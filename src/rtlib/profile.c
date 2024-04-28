/*
 * profile.c -- profiling functions
 *
 * chng: apr/2005 written [lillo]
 *       may/2005 rewritten to properly support recursive calls [lillo]
 *       apr/2024 use thread local storage (wip) [jeffm]
 *       apr/2024 add call counting [jeffm]
 *       apr/2024 dynamic string table [jeffm]
 *       apr/2024 remove NUL character padding requirement [jeffm]
 *       apr/2024 add API to set output file name and report options [jeffm]
 *       apr/2024 add profiler lock (replacing fb lock) [jeffm]
 *       apr/2024 add calltree report and API to ignore procedures [jeffm]
 */

/* TODO: optionally merge main and thread data */
/* TODO: test the start-up and exit code more */
/* TODO: demangle procedure names */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif
#include <time.h>

/* ************************************
** CONFIG
*/

#define MAIN_PROC_NAME         "(main)"
#define THREAD_PROC_NAME       "(thread)"
#define UNNAMED_PROC_NAME      "(unnamed)"
#define DEFAULT_PROFILE_FILE   "profile.txt"
#define STRING_BLOCK_TB_SIZE   10240
#define PROC_MAX_CHILDREN      257
#define PROC_BLOCK_SIZE        1024
#define PROC_HASH_TB_SIZE 257

#if defined HOST_UNIX
#define PATH_SEP               "/"
#else
#define PATH_SEP               "\\"
#endif

/* ************************************
** Memory Allocation
*/

#define PROFILER_malloc( size )       malloc( size )
#define PROFILER_calloc( n, size )    calloc( n, size )
#define PROFILER_realloc( ptr, size ) realloc( ptr, size )
#define PROFILER_free( ptr )          free( ptr )

/* ************************************
** Declarations
*/

/* Dynamic Strings */

typedef struct _STRING_INFO
{
	int size;
	int length;
	unsigned int full_hash;
} STRING_INFO;

#ifndef STRING_BLOCK_TB_SIZE
#define STRING_BLOCK_TB_SIZE 1024
#endif

typedef struct _STRING_BLOCK_TB
{
	unsigned char data[STRING_BLOCK_TB_SIZE];
	int bytes_used;
	int string_block_id;
	struct _STRING_BLOCK_TB *next;
} STRING_BLOCK_TB;

#ifndef STRING_HASH_TB_SIZE
#define STRING_HASH_TB_SIZE 997
#endif

typedef struct _STRING_HASH_TB
{
	STRING_INFO *items[STRING_HASH_TB_SIZE];
	struct _STRING_HASH_TB *next;
} STRING_HASH_TB;

/* procs */

#ifndef PROC_BLOCK_SIZE
#define PROC_BLOCK_SIZE 1024
#endif

#ifndef PROC_MAX_CHILDREN
#define PROC_MAX_CHILDREN 257
#endif

typedef struct _FBPROC
{
	const char *name;
	struct _FBPROC *parent;
	double time;
	double total_time;
	long long int call_count;
	struct _FBPROC *child[PROC_MAX_CHILDREN];
	struct _FBPROC *next;
	unsigned int children;
	unsigned int full_hash;
	unsigned int proc_id;
	unsigned int visited;
} FBPROC;

typedef struct _PROC_BLOCK_TB
{
	FBPROC fbproc[PROC_BLOCK_SIZE];
	int next_free;
	int proc_block_id;
	struct _PROC_BLOCK_TB *next;
} PROC_BLOCK_TB;

#ifndef PROC_HASH_TB_SIZE
#define PROC_HASH_TB_SIZE 257
#endif

typedef struct _PROC_HASH_TB
{
	FBPROC *proc[PROC_HASH_TB_SIZE];
	struct _PROC_HASH_TB *next;
} PROC_HASH_TB;

typedef struct _FBPROCARRAY
{
	FBPROC **array;
	STRING_HASH_TB *hash;
	int length;
	int size;
} FBPROCARRAY;

/* profiler */

typedef struct _PROFILER_METRICS
{
	int inited;

	int string_bytes_allocated;
	int string_bytes_used;
	int string_bytes_free;
	int string_count_blocks;
	int string_count_strings;
	int string_max_len;

	int hash_bytes_allocated;
	int hash_count_blocks;
	int hash_count_items;
	int hash_count_slots;

	int procs_bytes_allocated;
	int procs_count_blocks;
	int procs_count_items;
	int procs_count_slots;

} PROFILER_METRICS;

/* context for thread local storage */

typedef struct _FB_PROFILECTX
{
	FBPROC *main_proc;
	FBPROC *cur_proc;
} FB_PROFILECTX;

void fb_PROFILECTX_Destructor( void* );

/* reporting options */

enum PROFILE_OPTIONS
{
	PROFILE_OPTION_REPORT_DEFAULT    = 0x0000,
	PROFILE_OPTION_REPORT_CALLS      = 0x0001,
	PROFILE_OPTION_REPORT_CALLTREE   = 0x0002,
	PROFILE_OPTION_REPORT_RAWLIST    = 0x0004, 
	PROFILE_OPTION_REPORT_RAWDATA    = 0x0008,
	PROFILE_OPTION_REPORT_RAWSTRINGS = 0x0010,

	PROFILE_OPTION_REPORT_MASK       = 0x00FF,

	PROFILE_OPTION_HIDE_HEADER       = 0x0100,
	PROFILE_OPTION_HIDE_TITLES       = 0x0200,
	PROFILE_OPTION_HIDE_COUNTS       = 0x0400,
	PROFILE_OPTION_HIDE_TIMES        = 0x0800,
	PROFILE_OPTION_SHOW_DEBUGGING    = 0x1000,
	PROFILE_OPTION_GRAPHICS_CHARS    = 0x2000
};

/* profiler context */

typedef struct _FB_PROFILER_STATE
{
	char filename[MAX_PATH];
	char launch_time[32];
	unsigned int proc_id;
	enum PROFILE_OPTIONS options;
	STRING_BLOCK_TB *strings;
	STRING_HASH_TB *string_hash;
	STRING_HASH_TB *ignore_hash;
	PROC_BLOCK_TB *procs;
	PROFILER_METRICS *metrics;
	FBSTRING calltree_leader;
} FB_PROFILER_STATE;

/* ************************************
** Globals
*/

static FB_PROFILER_STATE *fb_profiler = NULL;

/* ************************************
** Helpers
*/

static unsigned int hash_compute( const char *p )
{
	unsigned int hash = 0;
	while( *p ) {
		hash += (unsigned int)*p;
		hash += hash << 10;
		hash ^= hash >> 6;
		++p;
	}
	hash += hash << 3;
	hash ^= hash >> 11;
	hash += hash << 15;
	return hash;
}

/* ************************************
** Dynamic Strings
*/

static STRING_INFO *PROFILER_new_string( const char *src, unsigned int full_hash )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	STRING_INFO *info;
	int size, length;

	length = strlen( src ) + 1;

	/* minumum size per string (assuming 4 bytes per int)
	** - space for STRING_INFO
	** - pad with additional NUL bytes to make size a multiple of 4
	*/

	size = sizeof(STRING_INFO) + ((length + (sizeof(int)-1))
	       & ~(sizeof(int)-1));

	if( size > STRING_BLOCK_TB_SIZE ) {
		return NULL;
	}

	if( size > (STRING_BLOCK_TB_SIZE - prof->strings->bytes_used) ) {
		STRING_BLOCK_TB *tb = (STRING_BLOCK_TB*)PROFILER_calloc( 1, sizeof(STRING_BLOCK_TB) );
		if( !tb ) {
			return NULL;
		}

		tb->bytes_used = 0;
		tb->string_block_id = prof->strings->string_block_id + 1;
		tb->next = prof->strings;
		prof->strings = tb;
	}

	info = (STRING_INFO*)&prof->strings->data[prof->strings->bytes_used];
	info->size = size;
	info->length = length;
	info->full_hash = full_hash;
	prof->strings->bytes_used += size;
	strncpy( (char *)(info+1), src, length );

	return info;
}

static STRING_HASH_TB* STRING_HASH_TB_new( void )
{
	STRING_HASH_TB *tb = (STRING_HASH_TB*)PROFILER_calloc( 1, sizeof( STRING_HASH_TB ) );
	if( tb ) {
		tb->next = NULL;
	}
	return tb;
}

static void STRING_HASH_TB_delete( STRING_HASH_TB *tb )
{
	while ( tb ) {
		STRING_HASH_TB *nxt = tb->next;
		PROFILER_free( tb );
		tb = nxt;
	}
}

static char *STRING_HASH_add( STRING_HASH_TB *tb, const char *src, unsigned int full_hash )
{
	STRING_INFO *info;
	int hash_index = full_hash % STRING_HASH_TB_SIZE;

	for (;;) {
		info = tb->items[hash_index];
		if( info ) {
			if( info->full_hash && !strcmp( (char *)(info + 1), src ) ) {
				goto return_string;
			}
		} else {
			info = PROFILER_new_string( src, full_hash );
			tb->items[hash_index] = info;
			goto return_string;
		}
		if( !tb->next ) {
			tb->next = STRING_HASH_TB_new( );
		}

		tb = tb->next;
	}

return_string:
	return (char *)(tb->items[hash_index] + 1);
}

static int STRING_HASH_find( STRING_HASH_TB *tb, const char *src, unsigned int full_hash )
{
	STRING_INFO *info;
	int hash_index = full_hash % STRING_HASH_TB_SIZE;

	for (;;) {
		info = tb->items[hash_index];
		if( info ) {
			if( info->full_hash && !strcmp( (char *)(info + 1), src ) ) {
				return TRUE;
			}
		} else {
			break;
		}
		if( !tb->next ) {
			break;
		}
		tb = tb->next;
	}
	return FALSE;
}

static char *PROFILER_add_string( const char *src, unsigned int full_hash )
{
	return STRING_HASH_add( fb_profiler->string_hash, src, full_hash );
}

static char *PROFILER_add_ignore( const char *src, unsigned int full_hash )
{
	return STRING_HASH_add( fb_profiler->ignore_hash, src, full_hash );
}

static int PROFILER_should_ignore( const char *src, unsigned int full_hash )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	return STRING_HASH_find( prof->ignore_hash, src, full_hash );
}

/* ************************************
** procs
*/

static FBPROC *PROC_BLOCK_TB_alloc_proc( void )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROC_BLOCK_TB *tb;
	FBPROC *proc;

	if ( ( !prof->procs ) || ( prof->procs->next_free >= PROC_BLOCK_SIZE ) ) {
		tb = (PROC_BLOCK_TB *)PROFILER_calloc( 1, sizeof(PROC_BLOCK_TB) );
		tb->next = prof->procs;
		tb->proc_block_id = (prof->procs ? prof->procs->proc_block_id : 0 ) + 1;
		prof->procs = tb;
	}

	proc = &prof->procs->fbproc[prof->procs->next_free];
	prof->procs->next_free += 1;

	return proc;
}

/* ************************************
** Proc Arrays
*/

static void PROCARRAY_constructor( FBPROCARRAY *list )
{
	list->array = NULL;
	list->size = 0;
	list->length = 0;
	list->hash = NULL;
}

static void PROCARRAY_destructor( FBPROCARRAY *list )
{
	STRING_HASH_TB_delete( list->hash );
	list->hash = NULL;
	PROFILER_free( list->array );
	list->array = NULL;
	list->size = 0;
	list->length = 0;
}

static int PROCARRAY_name_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;

	return strcmp( p1->name, p2->name );
}

static void PROCARRAY_sort_by_name( FBPROCARRAY *list )
{
	qsort( list->array, list->length, sizeof(FBPROC *), PROCARRAY_name_sorter );
}

static int PROCARRAY_time_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;

	if ( p1->total_time > p2->total_time ) {
		return -1;
	} else if ( p1->total_time < p2->total_time ) {
		return 1;
	} else {
		return 0;
	}
}

static void PROCARRAY_sort_by_time( FBPROCARRAY *list )
{
	qsort( list->array, list->length, sizeof(FBPROC *), PROCARRAY_time_sorter );
}

static void PROCARRAY_add_proc( FBPROCARRAY *list, FBPROC *proc )
{
	FBPROC **new_array = NULL;
    int s = list->size;

	if( s == 0 ) {
		s = 16;
		new_array = (FBPROC **)PROFILER_malloc( s * sizeof(FBPROC *) );
		list->hash = STRING_HASH_TB_new( );
	} else if ( list->length == s ) {
		s *= 2;
		new_array = (FBPROC **)PROFILER_realloc( list->array, s * sizeof(FBPROC *) );
	} else {
		new_array = list->array;
	}

	if( new_array ) {
		new_array[list->length] = proc;
		list->array = new_array;
		list->size = s;
		list->length += 1;
		STRING_HASH_add( list->hash, proc->name, proc->full_hash );
	}
}

static void PROCARRAY_find_all_procs( FBPROCARRAY *list, FBPROC *proc )
{
	FBPROC *p;
	int j;

	if( !STRING_HASH_find( list->hash, proc->name, proc->full_hash ) ) {
		PROCARRAY_add_proc( list, proc );
	}

	for ( p = proc; p; p = p->next ) {
		p->visited += 1;
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( p->child[j] && p->child[j]->visited == 0 ) {
				PROCARRAY_find_all_procs( list, p->child[j] );
			}
		}
	}
}

/* ************************************
** Profiling
*/

static PROFILER_METRICS *PROFILER_METRICS_new( FB_PROFILER_STATE *prof )
{
	if( prof->metrics ) {
		return prof->metrics;
	}

	prof->metrics = PROFILER_calloc( 1, sizeof( PROFILER_METRICS ) );
	prof->metrics->inited = FALSE;
	return prof->metrics;
}

static FB_PROFILER_STATE *PROFILER_new( void )
{
	FB_PROFILER_STATE *prof = PROFILER_calloc( 1, sizeof( FB_PROFILER_STATE ) );
	if( prof ) {
		prof->strings = (STRING_BLOCK_TB*)PROFILER_calloc( 1, sizeof(STRING_BLOCK_TB) );
		if( prof->strings ) {
			prof->strings->bytes_used = 0;
			prof->strings->string_block_id = 1;
			prof->strings->next = NULL;
		}
		prof->string_hash = STRING_HASH_TB_new( );
		prof->ignore_hash = STRING_HASH_TB_new( );
/*
		prof->string_hash = STRING_HASH_TB_new( prof->strings );
		prof->ignore_hash = STRING_HASH_TB_new( prof->strings );
*/
		/* initialized to zero by PROFILER_calloc 
		prof->filename[0] = 0;
		prof->launch_time[0] = 0;
		prof->procs = NULL;
		prof->metrics = NULL;
		prof->calltree_leader.data = NULL;
		prof->calltree_leader.size = NULL;
		prof->calltree_leader_len = 0;
		*/
	}
	return prof;
}

static void PROFILER_delete( FB_PROFILER_STATE *prof )
{
	PROFILER_free( prof->calltree_leader.data );

	while ( prof->procs ) {
		PROC_BLOCK_TB *nxt = prof->procs->next;
		PROFILER_free( prof->procs );
		prof->procs = nxt;
	}
	prof->procs = NULL;

	STRING_HASH_TB_delete( prof->ignore_hash );
	prof->ignore_hash = NULL;

	STRING_HASH_TB_delete( prof->string_hash );
	prof->string_hash = NULL;

	while ( prof->strings ) {
		STRING_BLOCK_TB *nxt = prof->strings->next;
		PROFILER_free( prof->strings );
		prof->strings = nxt;
	}
	prof->strings = NULL;

	PROFILER_free( prof->metrics );
	prof->metrics = NULL;

	PROFILER_free( prof );
}

static int PROFILER_new_proc_id( void )
{
	fb_profiler->proc_id += 1;
	return fb_profiler->proc_id;
}

static void PROFILER_hCountHashMemory( PROFILER_METRICS *metrics, STRING_HASH_TB *tb )
{
	while( tb ) {
		metrics->hash_bytes_allocated += sizeof( STRING_HASH_TB );
		metrics->hash_count_blocks += 1;

		for( int i=0; i < STRING_HASH_TB_SIZE; i++ )
		{
			if( tb->items[i] ) {
				metrics->hash_count_items += 1;
			}
			metrics->hash_count_slots += 1;

		}
		tb = tb->next;
	}
}

static PROFILER_METRICS *PROFILER_GetMetrics( FB_PROFILER_STATE *prof )
{
	STRING_INFO *info;
	int index;
	PROFILER_METRICS *metrics = PROFILER_METRICS_new( prof );

	if( !metrics ) {
		return NULL;
	}

	if( metrics->inited ) {
		return metrics;
	}

	metrics->string_bytes_allocated = 0;
	metrics->string_bytes_used = 0;
	metrics->string_bytes_free = 0;
	metrics->string_count_blocks = 0;
	metrics->string_count_strings = 0;
	metrics->string_max_len = 0;
	{
		STRING_BLOCK_TB *tb = prof->strings;
		while ( tb ) {
			metrics->string_bytes_allocated += sizeof( STRING_BLOCK_TB );
			metrics->string_bytes_used += tb->bytes_used;
			metrics->string_bytes_free += sizeof( STRING_BLOCK_TB ) - tb->bytes_used;
			metrics->string_count_blocks += 1;

			index = 0;
			while( index < tb->bytes_used )
			{
				info = (STRING_INFO*)&tb->data[index];
				if( info->length > metrics->string_max_len ) {
					metrics->string_max_len = info->length;
				}
				metrics->string_count_strings += 1;
				index += info->size;
			}
			tb = tb->next;
		}
	}

	metrics->hash_bytes_allocated = 0;
	metrics->hash_count_blocks = 0;
	metrics->hash_count_items = 0;
	metrics->hash_count_slots = 0;
	{
		 PROFILER_hCountHashMemory( metrics, prof->string_hash );
		 PROFILER_hCountHashMemory( metrics, prof->ignore_hash );
	}

	metrics->procs_bytes_allocated = 0;
	metrics->procs_count_blocks = 0;
	metrics->procs_count_items = 0;
	metrics->procs_count_slots = 0;
	{
		PROC_BLOCK_TB *tb = prof->procs;
		while( tb ) {
			metrics->procs_bytes_allocated += sizeof( PROC_BLOCK_TB );
			metrics->procs_count_blocks += 1;

			for( int i = 0; i < PROC_BLOCK_SIZE; i++ )
			{
				if( tb->fbproc[i].name ) {
					metrics->procs_count_items += 1;
				}
				metrics->procs_count_slots += 1;

			}
			tb = tb->next;
		}
	}

	metrics->inited = TRUE;
	return metrics;
}

/* ************************************
** REPORT GENERATION
*/

static void pad_spaces( FILE *f, int len )
{
	for( ; len > 0; len-- ) {
		fprintf( f, " " );
	}
}

static void pad_section( FILE *f )
{
	static int started = 0;
	if( started != 0 ) { 
		fprintf( f, "\n\n" );
	} else {
		started = 1;
	}
}

static void hResetProcVisted( FB_PROFILER_STATE *prof )
{
	PROC_BLOCK_TB *tb;
	FBPROC *proc;
	int i;

	for( tb = prof->procs; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->fbproc[i];
			proc->visited = 0;
		}
	}
}

/* PROFILE_OPTION_REPORT_CALLS */
static void hProfilerReportCalls ( 
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROFILER_METRICS *metrics = PROFILER_GetMetrics( prof );
	int i, j, len, skip_proc, col, max_len;
	PROC_BLOCK_TB *tb;
	FBPROCARRAY parent_proc_list, proc_list;
	FBPROC *proc, *parent_proc;

	PROCARRAY_constructor( &parent_proc_list );
	PROCARRAY_constructor( &proc_list );

	max_len = metrics->string_max_len;

	col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 ) {
		pad_section( f );
		fprintf( f, "Per function results:\n\n" );
		len = col - fprintf( f, "        Function:" );
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      Count:  " );
		}
	
		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     Time:    " );
			fprintf( f, "Total%%:    " );
			fprintf( f, "Proc%%:" );
		}

		fprintf( f, "\n\n" );
	}

	hResetProcVisted( prof );

	for( tb = prof->procs; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->fbproc[i];
			if( !proc->parent ) {
				/* no parent; either main proc or a thread proc */

				if( !proc->total_time ) {
					/* thread execution time unknown, assume total program execution time */
					proc->total_time = ctx->main_proc->total_time;
				}

				PROCARRAY_add_proc( &parent_proc_list, proc );
				PROCARRAY_find_all_procs( &parent_proc_list, proc );
			}
		}
	}

	PROCARRAY_sort_by_name( &parent_proc_list );

	for( i = 0; i < parent_proc_list.length; i++ ) {
		parent_proc = parent_proc_list.array[i];
		skip_proc = TRUE;

		for ( proc = parent_proc; proc; proc = proc->next ) {
			for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
				if ( proc->child[j] ) {
					PROCARRAY_add_proc( &proc_list, proc->child[j] );
					skip_proc = FALSE;
				}
			}
		}

		if ( skip_proc ) {
			continue;
		}

		len = col - (fprintf( f, "%s", parent_proc->name ) );
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", parent_proc->call_count );
			pad_spaces( f, len );
		}

		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			len = 14 - fprintf( f, "%10.5f", parent_proc->total_time );
			pad_spaces( f, len );

			fprintf( f, "%6.2f%%", (parent_proc->total_time * 100.0) / ctx->main_proc->total_time );
		}

		fprintf( f, "\n\n" );

		PROCARRAY_sort_by_time( &proc_list );

		for( j = 0; j < proc_list.length; j++ ) {
			proc = proc_list.array[j];

			len = col - fprintf( f, "        %s", proc->name );
			pad_spaces( f, len );

			if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->call_count );
				pad_spaces( f, len );
			}

			if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
				len = 14 - fprintf( f, "%10.5f", proc->total_time );
				pad_spaces( f, len );

				len = 10 - fprintf( f, "%6.2f%%", ( proc->total_time * 100.0 ) / ctx->main_proc->total_time );
				pad_spaces( f, len );

				fprintf( f, "%6.2f%%", ( parent_proc_list.array[i]->total_time > 0.0 ) ?
					( proc->total_time * 100.0 ) / parent_proc_list.array[i]->total_time : 0.0 );
			}

			fprintf( f, "\n" );
		}

		fprintf( f, "\n" );

		PROCARRAY_destructor( &proc_list );
	}

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 ) {
		pad_section( f );
		fprintf( f, "Global results:\n\n" );
	}

	PROCARRAY_sort_by_time( &parent_proc_list );

	for( i = 0; i < parent_proc_list.length; i++ ) {
		proc = parent_proc_list.array[i];
		len = col - fprintf( f, "%s", proc->name );
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", proc->call_count );
			pad_spaces( f, len );
		}

		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			len = 14 - fprintf( f, "%10.5f", proc->total_time );
			pad_spaces( f, len );

			len = 10 - fprintf( f, "%6.2f%%", ( proc->total_time * 100.0 ) / ctx->main_proc->total_time );
		}

		fprintf( f, "\n" );
	}

	PROCARRAY_destructor( &parent_proc_list );
}

/* PROFILE_OPTION_REPORT_CALLTREE */
static void hPushLeader( FB_PROFILER_STATE *prof, int ch )
{
	if( (prof->calltree_leader.data == NULL) ||
	    (prof->calltree_leader.len + 4 > prof->calltree_leader.size) ) {

		ssize_t newsize = prof->calltree_leader.size ? prof->calltree_leader.size * 2 : 64;
		char * newbuffer = (char *)realloc( prof->calltree_leader.data, newsize );
		if( !newbuffer ) {
			return;
		}
		prof->calltree_leader.data = newbuffer;
		prof->calltree_leader.size = newsize;
	}

	if( prof->calltree_leader.len + 4 > prof->calltree_leader.size ) {
		return;
	}

	if( ch ) {
		prof->calltree_leader.data[prof->calltree_leader.len] = ch;
		++prof->calltree_leader.len;
	}
	prof->calltree_leader.data[prof->calltree_leader.len] = 0;
}

static void hPopLeader( FB_PROFILER_STATE *prof )
{
	if( prof->calltree_leader.data ) {
		if( prof->calltree_leader.len >= 3 ) {
			prof->calltree_leader.len -= 3;
		}
		prof->calltree_leader.data[prof->calltree_leader.len] = 0; 		
	} else {
		prof->calltree_leader.len = 0;
	}
} 

static void hProfilerReportCallTreeProc (
	FB_PROFILECTX *ctx, FILE *f, 
	FB_PROFILER_STATE *prof, FBPROC *proc, int isfirst, int islast )
{
	static char asc_chars[4] = { '|', '-', '|', '\\' };
	static char gfx_chars[4] = { 179, 196, 195, 192  };
	char * ch = asc_chars;

	FBPROC *p;
	int j;
	unsigned int c = 0;

	if( (prof->options &PROFILE_OPTION_GRAPHICS_CHARS) != 0 ) {
		ch = gfx_chars;
	}

	hPushLeader( prof, 0 );

	if( islast ) {
		fprintf( f, "%s%c%c %s\n", prof->calltree_leader.data, ch[3], ch[1], proc->name );
	} else {
		fprintf( f, "%s%c%c %s\n", prof->calltree_leader.data, ch[2], ch[1], proc->name );
	}

	if( proc->children > 0 ) {
		if( islast ) {
			hPushLeader( prof, ' ' ); 
		} else {
			hPushLeader( prof, ch[0] ); 
		}
		hPushLeader( prof, ' ' ); 
		hPushLeader( prof, ' ' ); 
	}

	for ( p = proc; p; p = p->next ) {
		p->visited += 1;
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( proc->child[j] ) {
				c += 1;
				hProfilerReportCallTreeProc( ctx, f, prof, p->child[j], (c == 1), (c == proc->children) );
			}
		}
	}

	if( proc->children > 0 ) {
		hPopLeader( prof );
	}
}
 
static void hProfilerReportCallTree (
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROC_BLOCK_TB *tb;
	FBPROC *proc;
	int i;

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Call Tree:\n\n" );
	}

	hResetProcVisted( prof );

	for( tb = prof->procs; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->fbproc[i];
			if( proc->visited == 0 ) {
				hProfilerReportCallTreeProc( ctx, f, prof, proc, TRUE, TRUE );
			}
			fprintf( f, "\n\n" );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWLIST */
static void hProfilerReportRawList (
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROFILER_METRICS *metrics = PROFILER_GetMetrics( prof );
	int len, col, i, max_len;
	PROC_BLOCK_TB *tb;
	FBPROC *proc;

	max_len = metrics->string_max_len;

	col = (max_len >= 20 ? max_len : 20);

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "List of call data captured:\n\n" );

		fprintf( f, "    id  " );
		len = col - fprintf( f, "caller (parent)" );
		pad_spaces( f, len );

		fprintf( f, "    id  " );
		len = col - fprintf( f, "callee" );
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      count:  " );
		}
		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     time:  " );
		}
		fprintf( f, "\n\n" );
	}

	for( tb = prof->procs; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->fbproc[i];

			if( !proc->parent ) {
				fprintf( f, "%6d  ", 0 );
				len = col - fprintf( f, "(root)" );
			} else {
				fprintf( f, "%6d  ", proc->parent->proc_id );
				len = col - fprintf( f, "%s", proc->parent->name );
			}
			pad_spaces( f, len );

			fprintf( f, "%6d  ", proc->proc_id );
			len = col - fprintf( f, "%s", proc->name );
			pad_spaces( f, len );

			if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->call_count );
				pad_spaces( f, len );
			}

			if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
				len = 12 - fprintf( f, "%10.5f", proc->total_time );
				pad_spaces( f, len );
			}

			fprintf( f, "\n" );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWDATA */
static void hProfilerReportRawDataProc (
	FB_PROFILECTX *ctx, FILE *f, 
	FBPROC *proc, int level, int max_len, int recursion )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	int len, col, j;

	col = (max_len >= 20 ? max_len : 20);

	if( recursion > 0 ) {
		fprintf( f, "%5d   ", level );
	} else {
		fprintf( f, "%5d * ", level );
	}

	if( !proc->parent ) {
		fprintf( f, "%6d  ", 0 );
		len = col - fprintf( f, "(root)" );
	} else {
		fprintf( f, "%6d  ", proc->parent->proc_id );
		len = col - fprintf( f, "%s", proc->parent->name );
	}
	pad_spaces( f, len );

	fprintf( f, "%6d  ", proc->proc_id );
	len = col - fprintf( f, "%s", proc->name );
	pad_spaces( f, len );

	if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
		len = 14 - fprintf( f, "%12lld", proc->call_count );
		pad_spaces( f, len );
	}

	if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
		len = 14 - fprintf( f, "%10.5f", proc->total_time );
		pad_spaces( f, len );
	}

	fprintf( f, "\n" );

	if( recursion > 0 ) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( proc->child[j] ) {
				hProfilerReportRawDataProc( ctx, f, proc->child[j], level + 1, max_len, recursion - 1 );
			}
		}
	}
}

static void hProfilerReportRawData (
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROFILER_METRICS *metrics = PROFILER_GetMetrics( prof );
	int i, max_len, len, col;
	PROC_BLOCK_TB *tb;
	FBPROC *proc;

	max_len = metrics->string_max_len;

	col = (max_len >= 20 ? max_len : 20);

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "List of call data captured (recursive):\n\n" );

		fprintf( f, " depth: " );
		fprintf( f, "    id  " );
		len = col - fprintf( f, "caller (parent)" );
		pad_spaces( f, len );

		fprintf( f, "    id  " );
		len = col - fprintf( f, "callee" );
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      count:  " );
		}
		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     time:  " );
		}
		fprintf( f, "\n\n" );
	}

	for( tb = prof->procs; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->fbproc[i];
			hProfilerReportRawDataProc( ctx, f, proc, 1, max_len, 1 );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWSTRINGS */
static void hProfilerReportRawStrings (
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	STRING_BLOCK_TB *tb = prof->strings;

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Profiler string table (procedure names):\n\n" );
		fprintf( f, " size length  hash      string\n\n" );
	}

	while( tb )
	{
		int index = 0;
		while( index < tb->bytes_used )
		{
			STRING_INFO *info = (STRING_INFO*)&tb->data[index];
			fprintf( f, "%5d", info->size );
			fprintf( f, "  %5d", info->length );
			fprintf( f, "  %8x", info->full_hash );
			fprintf( f, "  %s\n", (char *)(info + 1) );
			index += info->size;
		}
		tb = tb->next;
	}
}

/* PROFILE_OPTION_SHOW_DEBUGGING */
static void hProfilerReportDebug (
	FB_PROFILECTX *ctx, FILE *f )
{
	FB_PROFILER_STATE *prof = fb_profiler;
	PROFILER_METRICS *metrics = PROFILER_GetMetrics( prof );

	fprintf( f, "Profiler Debugging Information:\n" );

	fprintf( f, "    Call Tree:\n" );
	fprintf( f, "        number of proc blks: %d\n", prof->procs->proc_block_id );
	fprintf( f, "        number of proc ids : %d\n", prof->proc_id );
	fprintf( f, "        bytes allocated    : %d\n", metrics->procs_bytes_allocated );
	fprintf( f, "        number of blocks   : %d\n", metrics->procs_count_blocks );
	fprintf( f, "        number of items    : %d\n", metrics->procs_count_items );
	fprintf( f, "        number of slots    : %d\n", metrics->procs_count_slots );
	fprintf( f, "    String Block:\n" );
	fprintf( f, "        last block id      : %d\n", prof->strings->string_block_id );
	fprintf( f, "        bytes allocated    : %d\n", metrics->string_bytes_allocated );
	fprintf( f, "        bytes used         : %d\n", metrics->string_bytes_used );
	fprintf( f, "        bytes free         : %d\n", metrics->string_bytes_free );
	fprintf( f, "        number of blocks   : %d\n", metrics->string_count_blocks );
	fprintf( f, "        number of strings  : %d\n", metrics->string_count_strings );
	fprintf( f, "        max string length  : %d\n", metrics->string_max_len );
	fprintf( f, "    Hash String Table:\n" );
	fprintf( f, "        bytes allocated    : %d\n", metrics->hash_bytes_allocated );
	fprintf( f, "        number of blocks   : %d\n", metrics->hash_count_blocks );
	fprintf( f, "        number of items    : %d\n", metrics->hash_count_items );
	fprintf( f, "        number of slots    : %d\n", metrics->hash_count_slots );
	fprintf( f, "        density            : %-4.2f%%\n", (float)metrics->hash_count_items * 100 / (float)metrics->hash_count_slots );
	fprintf( f, "\n" );
}

/* ************************************
** Public API
*/

/*:::::*/
FBCALL void *fb_ProfileBeginCall( const char *procname )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);
	FBPROC *orig_parent_proc, *parent_proc, *proc;
	unsigned int j, full_hash = 0, hash_index, offset;

	FB_PROFILE_LOCK();

	if( !procname || !(*procname) ) {
		procname = UNNAMED_PROC_NAME;
	}

	full_hash = hash_compute( procname );

	if( !fb_profiler ) {
		return NULL;
	}

	if( PROFILER_should_ignore( procname, full_hash ) ) {
		FB_PROFILE_UNLOCK();
		return NULL;
	}

	parent_proc = ctx->cur_proc;
	if( !parent_proc ) {
		/* First function call of a newly spawned thread has no parent proc set */
		parent_proc = PROC_BLOCK_TB_alloc_proc();
		parent_proc->name = THREAD_PROC_NAME;
		parent_proc->full_hash = hash_compute( parent_proc->name );
		parent_proc->call_count = 1;
		parent_proc->proc_id = PROFILER_new_proc_id();
		parent_proc->children = 0;
	}

	orig_parent_proc = parent_proc;

	hash_index = full_hash % PROC_MAX_CHILDREN;
	offset = hash_index ? (PROC_MAX_CHILDREN - hash_index) : 1;

	for (;;) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			proc = parent_proc->child[hash_index];
			if ( proc ) {
				if ( proc->full_hash == full_hash && !strcmp( proc->name, procname ) ) {
					goto update_proc;
				}
				hash_index = ( hash_index + offset ) % PROC_MAX_CHILDREN;
			} else {
				proc = PROC_BLOCK_TB_alloc_proc();
				goto fill_proc;
			}
		}

		if ( !parent_proc->next ) {
			parent_proc->next = PROC_BLOCK_TB_alloc_proc();
			proc = parent_proc->next;
			goto fill_proc;
		}

		parent_proc = parent_proc->next;
	}

fill_proc:
	proc->proc_id = PROFILER_new_proc_id();
	proc->name = PROFILER_add_string( procname, full_hash );
	proc->full_hash = full_hash;
	proc->total_time = 0.0;
	proc->call_count = 0;
	proc->parent = orig_parent_proc;
	proc->children = 0;
	parent_proc->child[hash_index] = proc;
	parent_proc->children += 1;

update_proc:
	ctx->cur_proc = proc;

	proc->time = fb_Timer();

	FB_PROFILE_UNLOCK();

	return (void *)proc;
}

/*:::::*/
FBCALL void fb_ProfileEndCall( void *p )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);
	FBPROC *proc;
	double end_time;

	if( !p ) {
		return;
	}

	end_time = fb_Timer();

	FB_PROFILE_LOCK();

	proc = (FBPROC *)p;
	proc->total_time += ( end_time - proc->time );
	proc->call_count += 1;
	ctx->cur_proc = proc->parent;

	FB_PROFILE_UNLOCK();
}

/*:::::*/
FBCALL void fb_InitProfile( void )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);

	if( fb_profiler ) {
		return;
	}
	fb_profiler = PROFILER_new( );

	time_t rawtime = { 0 };
	struct tm *ptm = { 0 };

	ctx->main_proc = PROC_BLOCK_TB_alloc_proc();
	ctx->main_proc->name = MAIN_PROC_NAME;
	ctx->main_proc->full_hash = hash_compute( ctx->main_proc->name );
	ctx->main_proc->children = 0;
	ctx->main_proc->call_count = 1;
	ctx->main_proc->proc_id = PROFILER_new_proc_id();

	ctx->cur_proc = ctx->main_proc;

	time( &rawtime );
	ptm = localtime( &rawtime );
	sprintf( fb_profiler->launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );

	ctx->main_proc->time = fb_Timer();
}

/*:::::*/
void fb_PROFILECTX_Destructor( void* data )
{
	/* FB_PROFILECTX *ctx = (FB_PROFILECTX *)data; */
	/* TODO: merge the thread results with the (main)/(thread) results */
	data = data;
}

/*:::::*/
FBCALL int fb_EndProfile( int errorlevel )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_STATE *prof = fb_profiler;
	FILE *f;

	char buffer[MAX_PATH], *filename;

	if( !prof ) {
		return -1;
	}

	ctx->main_proc->total_time = fb_Timer() - ctx->main_proc->time;

	filename = fb_hGetExeName( buffer, MAX_PATH-1 );
	if( prof->filename[0] ) {
		filename = prof->filename;
	} else if( !filename ) {
		filename = DEFAULT_PROFILE_FILE;
	} else {
		strcat( buffer, ".prf" );
		filename = buffer;
	}

	f = fopen( filename, "w" );

	if( (prof->options & PROFILE_OPTION_HIDE_HEADER) == 0 )
	{
		pad_section( f );
		fprintf( f, "Profiling results:\n" );
		fprintf( f, "------------------\n\n" );

		fb_hGetExeName( buffer, MAX_PATH-1 );
		fprintf( f, "Executable name: %s\n", buffer );
		fprintf( f, "Launched on: %s\n", prof->launch_time );
		fprintf( f, "Total program execution time: %5.4g seconds\n", ctx->main_proc->total_time );
	}

	/* default report? */
	if( (prof->options & PROFILE_OPTION_REPORT_MASK) == 0 ) {
		prof->options |= PROFILE_OPTION_REPORT_CALLS; 
	}

	if( (prof->options & PROFILE_OPTION_REPORT_CALLS) != 0 ) {
		hProfilerReportCalls( ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_CALLTREE) != 0 ) {
		hProfilerReportCallTree( ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWLIST) != 0 ) {
		hProfilerReportRawList( ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWDATA) != 0 ) {
		hProfilerReportRawData( ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWSTRINGS) != 0 ) {
		hProfilerReportRawStrings( ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_SHOW_DEBUGGING) != 0 ) {
		hProfilerReportDebug( ctx, f );
	}

	fclose( f );

	PROFILER_delete( fb_profiler );
	fb_profiler = NULL;

	return errorlevel;
}

/* ************************************
** Profiling Options
*/

/*:::::*/
FBCALL int fb_ProfileSetFileName( const char *filename )
{
	int len;

	if( !fb_profiler || !filename ) {
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	len = strlen(filename);

	if( len < 1 || len >= MAX_PATH-1 ) {
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	FB_PROFILE_LOCK();

	strcpy( fb_profiler->filename, filename );

	FB_PROFILE_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL unsigned int fb_ProfileGetOptions()
{
	unsigned int options;
	if( !fb_profiler ) {
		return 0;
	}
	FB_PROFILE_LOCK();
	options = fb_profiler->options;
	FB_PROFILE_UNLOCK();
	return options;
}

/*:::::*/
FBCALL int fb_ProfileSetOptions( unsigned int options )
{
	unsigned int previous_options;
	if( !fb_profiler ) {
		return 0;
	}
	FB_PROFILE_LOCK();
	previous_options = fb_profiler->options;
	fb_profiler->options = options;
	FB_PROFILE_UNLOCK();
	return previous_options;
}

/*:::::*/
FBCALL void fb_ProfileIgnore( const char * procname )
{
	unsigned int full_hash;
	if( !fb_profiler || !procname ) {
		return;
	}
	full_hash = hash_compute( procname );  
	FB_PROFILE_LOCK();
	PROFILER_add_ignore( procname, full_hash );
	FB_PROFILE_UNLOCK();
} 
