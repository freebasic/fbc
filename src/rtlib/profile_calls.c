/* profile_calls.c -- fb calls profiler
**
** chng: apr/2005 written [lillo]
**       may/2005 rewritten to properly support recursive calls [lillo]
**       apr/2024 use thread local storage (wip) [jeffm]
**       apr/2024 add call counting [jeffm]
**       apr/2024 remove NUL character padding requirement [jeffm]
**       apr/2024 add calltree report and API to ignore procedures [jeffm]
**       may/2024 instance profiler on each thread [jeffm]
**/

/* TODO: disambiguate private procedures by module name */
/* TODO: function pointer testing and reporting */
/* TODO: demangle procedure names */

#include "fb.h"
#include "fb_profile.h"

#ifdef HOST_WIN32
	#include <windows.h>
#endif
#include <time.h>

/* procs */

/* extra information about procinfo entry */
enum PROCINFO_FLAGS
{
	PROCINFO_FLAGS_NONE     = 0,
	PROCINFO_FLAGS_MAIN     = 1,
	PROCINFO_FLAGS_THREAD   = 2,
	PROCINFO_FLAGS_CALLPTR  = 4,
	PROCINFO_FLAGS_FOREIGN  = 8
};

/* procedure call information, and hash table for child procedures */
typedef struct _FB_PROCINFO
{
	const char *name;
	struct _FB_PROCINFO *parent;
	double start_time;
	double local_time;
	long long int local_count;
	unsigned int hashkey;
	int proc_id;
	struct _FB_PROCINFO *child[PROC_MAX_CHILDREN];
	struct _FB_PROCINFO *next;
	int flags;
} FB_PROCINFO;

/* block of memory to store procedure call information records */
typedef struct _FB_PROCINFO_TB
{
	FB_PROCINFO procinfo[PROC_INFO_TB_SIZE];
	struct _FB_PROCINFO_TB *next;
	int next_free;
	int proc_tb_id;
} FB_PROCINFO_TB;

/* hash table block for procedures */
typedef struct _PROC_HASH_TB
{
	FB_PROCINFO *proc[PROC_HASH_TB_SIZE];
	struct _PROC_HASH_TB *next;
} PROC_HASH_TB;

/* array of procinfo entries and associated hash tables */
typedef struct _FB_PROCARRAY
{
	FB_PROCINFO **array;
	STRING_HASH hash;
	STRING_HASH_TABLE *ignores;
	int length;
	int size;
} FB_PROCARRAY;

/* profiler */

/* context for thread local storage */

typedef struct _FB_PROFILER_THREAD
{
	FB_PROCINFO *thread_proc;
	STRING_TABLE strings;
	STRING_HASH_TABLE strings_hash;
	FB_PROCINFO_TB *proc_tb;
	struct _FB_PROFILER_THREAD *next;
	int last_proc_id;
} FB_PROFILER_THREAD;

typedef struct _FB_PROFILECTX
{
	FB_PROFILER_THREAD *ctx;
} FB_PROFILECTX;

void fb_PROFILECTX_Destructor( void* );

/* calls profiler global context */
/* use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing */
typedef struct _FB_PROFILER_CALLS
{
	FB_PROFILER_GLOBAL *global;
	FB_PROFILER_THREAD *main_thread;
	FB_PROFILER_THREAD *threads;
	FBSTRING calltree_leader;
} FB_PROFILER_CALLS;

/* ************************************
** Globals
*/

static FB_PROFILER_CALLS *fb_profiler = NULL;

/* ************************************
** strings
*/

static char *PROFILER_THREAD_add_string( FB_PROFILER_THREAD *ctx, const char *src, unsigned int hashkey )
{
	STRING_INFO *info = STRING_HASH_TABLE_add( &ctx->strings_hash, src, hashkey );
	return (char*)(info+1);
}

/* ************************************
** procs
*/

static void FB_PROCINFO_TB_destructor( FB_PROCINFO_TB *tb )
{
	while ( tb ) {
		FB_PROCINFO_TB *nxt = tb->next;
		PROFILER_free( tb );
		tb = nxt;
	}
}

static FB_PROCINFO *FB_PROCINFO_TB_alloc_proc( FB_PROCINFO_TB **proc_tb )
{
	FB_PROCINFO_TB *tb;
	FB_PROCINFO *proc;

	if ( ( !(*proc_tb) ) || ( (*proc_tb)->next_free >= PROC_INFO_TB_SIZE ) ) {
		tb = (FB_PROCINFO_TB *)PROFILER_calloc( 1, sizeof(FB_PROCINFO_TB) );
		tb->next = (*proc_tb);
		tb->proc_tb_id = ((*proc_tb) ? (*proc_tb)->proc_tb_id : 0 ) + 1;
		(*proc_tb) = tb;
	}

	proc = &(*proc_tb)->procinfo[(*proc_tb)->next_free];
	(*proc_tb)->next_free += 1;

	return proc;
}

static FB_PROCINFO *FB_PROFILER_THREAD_alloc_proc( FB_PROFILER_THREAD *ctx )
{
	return FB_PROCINFO_TB_alloc_proc( &ctx->proc_tb );
}

/* ************************************
** Proc Arrays
*/

static void PROCARRAY_constructor( FB_PROCARRAY *list, STRING_HASH_TABLE *strings_hash, STRING_HASH_TABLE *ignores )
{
	list->array = NULL;
	list->size = 0;
	list->length = 0;
	STRING_HASH_constructor( &list->hash, strings_hash );
	list->ignores = ignores;
}

static void PROCARRAY_destructor( FB_PROCARRAY *list )
{
	STRING_HASH_destructor( &list->hash );
	PROFILER_free( list->array );
	list->array = NULL;
	list->size = 0;
	list->length = 0;
	list->ignores = NULL;
}

static int PROCARRAY_name_sorter( const void *e1, const void *e2 )
{
	FB_PROCINFO *p1 = *(FB_PROCINFO **)e1;
	FB_PROCINFO *p2 = *(FB_PROCINFO **)e2;

	if( p1->parent && p2->parent ) {
		return strcmp( p1->name, p2->name );
	} else if( !p1->parent && p2->parent ) {
		return -1;
	} else if( p1->parent && !p2->parent ) {
		return 1;
	} else {
		return 0;
	}
}

static void PROCARRAY_sort_by_name( FB_PROCARRAY *list )
{
	qsort( list->array, list->length, sizeof(FB_PROCINFO *), PROCARRAY_name_sorter );
}

static int PROCARRAY_time_sorter( const void *e1, const void *e2 )
{
	FB_PROCINFO *p1 = *(FB_PROCINFO **)e1;
	FB_PROCINFO *p2 = *(FB_PROCINFO **)e2;

	if ( p1->local_time > p2->local_time ) {
		return -1;
	} else if ( p1->local_time < p2->local_time ) {
		return 1;
	} else {
		return 0;
	}
}

static void PROCARRAY_sort_by_time( FB_PROCARRAY *list )
{
	qsort( list->array, list->length, sizeof(FB_PROCINFO *), PROCARRAY_time_sorter );
}

static void PROCARRAY_add( FB_PROCARRAY *list, FB_PROCINFO *proc )
{
	FB_PROCINFO **new_array = NULL;
	int s = list->size;

	if( s == 0 ) {
		s = 16;
		new_array = (FB_PROCINFO **)PROFILER_malloc( s * sizeof(FB_PROCINFO *) );
	} else if ( list->length == s ) {
		s *= 2;
		new_array = (FB_PROCINFO **)PROFILER_realloc( list->array, s * sizeof(FB_PROCINFO *) );
	} else {
		new_array = list->array;
	}

	if( new_array ) {
		new_array[list->length] = proc;
		list->array = new_array;
		list->size = s;
		list->length += 1;
		STRING_HASH_add( &list->hash, proc->name, proc->hashkey );
	}
}

static void PROCARRAY_find_all_procs( FB_PROCARRAY *list, FB_PROCINFO_TB *proc_tb )
{
	FB_PROCINFO_TB *tb = proc_tb;
	FB_PROCINFO *proc;
	int i;

	while( tb ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->procinfo[i];
			if( !STRING_HASH_TABLE_find( list->ignores, proc->name, proc->hashkey ) ) {
				PROCARRAY_add( list, proc );
			}
		}
		tb = tb->next;
	}
}

static void PROCARRAY_find_unique_procs( FB_PROCARRAY *list, FB_PROCINFO_TB *proc_tb )
{
	FB_PROCINFO_TB *tb = proc_tb;
	FB_PROCINFO *proc;
	int i;

	while( tb ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->procinfo[i];
			if( !STRING_HASH_TABLE_find( list->ignores, proc->name, proc->hashkey ) ) {
				if( !STRING_HASH_find( &list->hash, proc->name, proc->hashkey ) ) {
					PROCARRAY_add( list, proc );
				}
			}
		}
		tb = tb->next;
	}
}

/* ************************************
** Profile Thread Context
*/

static void PROFILER_THREAD_constructor( FB_PROFILER_THREAD *ctx )
{
	if( ctx ) {
		ctx->thread_proc = NULL;
		STRING_TABLE_constructor( &ctx->strings );
		STRING_HASH_TABLE_constructor( &ctx->strings_hash, &ctx->strings );
		ctx->proc_tb = NULL;
		ctx->next = NULL;
		ctx->last_proc_id = 0;
	}
}

static void fb_PROFILECTX_Constructor( FB_PROFILECTX *tls ) {
	if( !tls->ctx ) {
		tls->ctx = (FB_PROFILER_THREAD *)PROFILER_calloc(1, sizeof(FB_PROFILER_THREAD));
		PROFILER_THREAD_constructor( tls->ctx );
	}
}

void fb_PROFILECTX_Destructor( void* data )
{
	FB_PROFILECTX *tls = (FB_PROFILECTX *)data;
	if( tls ) {
		FB_PROFILER_THREAD *ctx = tls->ctx;
		if( ctx ) {
			if( ctx->thread_proc ) {
				ctx->thread_proc->local_time = fb_Timer() - ctx->thread_proc->start_time;
			}

			/* don't actually delete the data, just */
			/* add it to the main profiler state */
			if( fb_profiler ) {
				FB_PROFILE_LOCK();
				ctx->next = fb_profiler->threads;
				fb_profiler->threads = ctx;
				FB_PROFILE_UNLOCK();
			}
		}
	}
}

/* ************************************
** Profiler Metrics (internal stats)
*/

static void fb_hPROFILER_METRICS_Procs( FB_PROFILER_METRICS *metrics, FB_PROCINFO_TB *proc_tb )
{
	FB_PROCINFO_TB *tb;
	if( metrics && proc_tb ) {
		tb = proc_tb;
		while( tb ) {
			metrics->procs_bytes_allocated += sizeof( FB_PROCINFO_TB );
			metrics->procs_count_blocks += 1;

			for( int i = 0; i < PROC_INFO_TB_SIZE; i++ )
			{
				if( tb->procinfo[i].name ) {
					metrics->procs_count_items += 1;
				}
				metrics->procs_count_slots += 1;

			}
			tb = tb->next;
		}
	}
}

static void fb_hPROFILER_METRICS_Threads( FB_PROFILER_METRICS *metrics, FB_PROFILER_THREAD *ctx )
{
	if( metrics && ctx ) {
		metrics->count_threads += 1;
		fb_hPROFILER_METRICS_Strings( metrics, &ctx->strings );
		fb_hPROFILER_METRICS_HashTable( metrics, &ctx->strings_hash );
		fb_hPROFILER_METRICS_Procs( metrics, ctx->proc_tb );
	}
}

static void fb_hPROFILER_METRICS_CallsProfiler( FB_PROFILER_METRICS *metrics, FB_PROFILER_CALLS *prof )
{
	FB_PROFILER_THREAD *ctx;

	if( !prof || !metrics ) {
		return;
	}

	fb_hPROFILER_METRICS_Clear( metrics );
	fb_hPROFILER_METRICS_Global( metrics, prof->global );
	fb_hPROFILER_METRICS_Threads( metrics, prof->main_thread );

	ctx = prof->threads;
	while( ctx ) {
		fb_hPROFILER_METRICS_Threads( metrics, ctx );
		ctx = ctx->next;
	}
}

/* ************************************
** Profiling
*/

static FB_PROFILER_CALLS *PROFILER_CALLS_create( void )
{
	if( fb_profiler == NULL ) {
		FB_PROFILER_CALLS *prof;
		prof = PROFILER_calloc( 1, sizeof( FB_PROFILER_CALLS ) );
		if( prof ) {
			prof->global = PROFILER_GLOBAL_create( );
			if( prof->global ) {
				prof->global->profiler_ctx = (void * )prof;
				prof->calltree_leader.data = NULL;
				prof->calltree_leader.size = 0;
				prof->calltree_leader.len = 0;
				fb_profiler = prof;
			} else {
				PROFILER_free( prof );
			}
		}
	}
	return fb_profiler;
}

static void PROFILER_CALLS_destroy(  )
{
	if( fb_profiler ) {
		PROFILER_free( fb_profiler->calltree_leader.data );

		while( fb_profiler->threads )
		{
			FB_PROFILER_THREAD *nxt_ctx;

			FB_PROCINFO_TB_destructor( fb_profiler->threads->proc_tb );
			STRING_HASH_TABLE_destructor( &fb_profiler->threads->strings_hash );
			STRING_TABLE_destructor( &fb_profiler->threads->strings );

			nxt_ctx = fb_profiler->threads->next;
			PROFILER_free( fb_profiler->threads );
			fb_profiler->threads = nxt_ctx;
		}

		PROFILER_GLOBAL_destroy( );

		PROFILER_free( fb_profiler );
		fb_profiler = NULL;
	}
}

static int PROFILER_new_proc_id( FB_PROFILER_THREAD *ctx )
{
	ctx->last_proc_id += 1;
	return ctx->last_proc_id;
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

/* PROFILE_OPTION_REPORT_CALLS */
static void hProfilerReportCallsProc (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f,
	FB_PROCINFO *parent_proc, int col )
{
	FB_PROCINFO *proc;
	FB_PROCARRAY proc_list;
	int j, len;

	PROCARRAY_constructor( &proc_list, &prof->global->strings_hash, &prof->global->ignores_hash );

	for ( proc = parent_proc; proc; proc = proc->next ) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( proc->child[j] ) {
				if( !STRING_HASH_TABLE_find( proc_list.ignores, proc->child[j]->name, proc->child[j]->hashkey ) ) {
					PROCARRAY_add( &proc_list, proc->child[j] );
				}
			}
		}
	}

	if( proc_list.length > 0 ) {

		if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 ) {
			if( (parent_proc->flags & PROCINFO_FLAGS_THREAD) != 0 ) {
				fprintf( f, "(thread)\n" );
			}
		}

		len = col - (fprintf( f, "%s", parent_proc->name ) );
		pad_spaces( f, len );

		if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", parent_proc->local_count );
			pad_spaces( f, len );
		}

		if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			len = 14 - fprintf( f, "%10.5f", parent_proc->local_time );
			pad_spaces( f, len );

			fprintf( f, "%6.2f%%", (parent_proc->local_time * 100.0) / ctx->thread_proc->local_time );
		}

		fprintf( f, "\n\n" );

		PROCARRAY_sort_by_time( &proc_list );

		for( j = 0; j < proc_list.length; j++ ) {
			proc = proc_list.array[j];

			len = col - fprintf( f, "        %s", proc->name );
			pad_spaces( f, len );

			if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->local_count );
				pad_spaces( f, len );
			}

			if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
				len = 14 - fprintf( f, "%10.5f", proc->local_time );
				pad_spaces( f, len );

				len = 10 - fprintf( f, "%6.2f%%", ( proc->local_time * 100.0 ) / ctx->thread_proc->local_time );
				pad_spaces( f, len );

				fprintf( f, "%6.2f%%", ( parent_proc->local_time > 0.0 ) ?
					( proc->local_time * 100.0 ) / parent_proc->local_time : 0.0 );
			}

			fprintf( f, "\n" );
		}

		fprintf( f, "\n" );
	}

	PROCARRAY_destructor( &proc_list );
}

static int hProcIsRecursive( FB_PROCINFO *proc )
{
	FB_PROCINFO *p = proc;
	if( p ) {
		p = p->parent;
		while( p ) {
			if( (p->hashkey == proc->hashkey) && (strcmp( p->name, proc->name ) == 0) ) {
				return TRUE;
			}
			p = p->parent;
		}
	}
	return FALSE;
}

static void hProfilerReportCallsFunctions (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROCARRAY list;
	int i, len;
	int max_len = STRING_TABLE_max_len( &ctx->strings );
	int col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Per function results:\n\n" );
		len = col - fprintf( f, "        Function:" );
		pad_spaces( f, len );

		if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      Count:  " );
		}

		if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     Time:    " );
			fprintf( f, "Total%%:    " );
			fprintf( f, "Proc%%:" );
		}

		fprintf( f, "\n\n" );
	}

	PROCARRAY_constructor( &list, &prof->global->strings_hash, &prof->global->ignores_hash );

	PROCARRAY_find_unique_procs( &list, ctx->proc_tb );
	PROCARRAY_sort_by_name( &list );
	for( i = 0; i < list.length; i++ ) {
		hProfilerReportCallsProc( prof, ctx, f, list.array[i], col );
	}

	PROCARRAY_destructor( &list );
}

static void hProfilerReportCallsGlobals (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROCINFO_TB *tb;
	FB_PROCARRAY list_all, list;
	FB_PROCINFO *last_p;
	int i, len;
	int max_len = STRING_TABLE_max_len( &ctx->strings );
	int col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Global results:\n\n" );
	}

	PROCARRAY_constructor( &list, &prof->global->strings_hash, &prof->global->ignores_hash );

	PROCARRAY_constructor( &list_all, &prof->global->strings_hash, &prof->global->ignores_hash );
	PROCARRAY_find_all_procs( &list_all, ctx->proc_tb );
	PROCARRAY_sort_by_name( &list_all );

	tb = NULL;
	last_p = NULL;
	for( i = 0; i < list_all.length; i++ )
	{
		FB_PROCINFO *p, *q;
		q = list_all.array[i];

		if( !last_p || (last_p->hashkey != q->hashkey) || (strcmp(last_p->name, q->name) != 0) ) {
			p = FB_PROCINFO_TB_alloc_proc( &tb );
			if( p ) {
				p->name = q->name;
				p->hashkey = q->hashkey;
				if( !hProcIsRecursive( q ) ) {
					p->local_time = q->local_time;
				} else {
					p->local_time = 0;
				}
				p->local_count = q->local_count;
				PROCARRAY_add( &list, p );
			}
			last_p = p;
		} else {
			if( !hProcIsRecursive( q ) ) {
				last_p->local_time += q->local_time;
			}
			last_p->local_count += q->local_count;
		}
	}

	for( i = 0; i < list.length; i++ ) {
		FB_PROCINFO *proc = list.array[i];
		len = col - fprintf( f, "%s", proc->name );
		pad_spaces( f, len );

		if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", proc->local_count );
			pad_spaces( f, len );
		}

		if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			len = 14 - fprintf( f, "%10.5f", proc->local_time );
			pad_spaces( f, len );

			len = 10 - fprintf( f, "%6.2f%%", ( proc->local_time * 100.0 ) / ctx->thread_proc->local_time );
		}

		fprintf( f, "\n" );
	}

	FB_PROCINFO_TB_destructor( tb );
	PROCARRAY_destructor( &list );
	PROCARRAY_destructor( &list_all );
}

/* PROFILE_OPTION_REPORT_CALLTREE */
static void hPushLeader( FB_PROFILER_CALLS *prof, int ch )
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

static void hPopLeader( FB_PROFILER_CALLS *prof )
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
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f,
	FB_PROCINFO *proc, int isfirst, int islast )
{
	static char asc_chars[4] = { '|', '-', '|', '\\' };
	static char gfx_chars[4] = { 179, 196, 195, 192  };
	char * ch = asc_chars;

	FB_PROCINFO *p;
	int i, j, children;
	FB_PROCARRAY lst;

	if( (prof->global->options &PROFILE_OPTION_GRAPHICS_CHARS) != 0 ) {
		ch = gfx_chars;
	}

	hPushLeader( prof, 0 );

	if( islast ) {
		fprintf( f, "%s%c%c %s\n", prof->calltree_leader.data, ch[3], ch[1], proc->name );
	} else {
		fprintf( f, "%s%c%c %s\n", prof->calltree_leader.data, ch[2], ch[1], proc->name );
	}

	children = 0;
	for ( p = proc; p; p = p->next ) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( p->child[j] ) {
				children += 1;
			}
		}
	}

	if( children > 0 ) {
		if( islast ) {
			hPushLeader( prof, ' ' );
		} else {
			hPushLeader( prof, ch[0] );
		}
		hPushLeader( prof, ' ' );
		hPushLeader( prof, ' ' );
	}

	PROCARRAY_constructor( &lst, &prof->global->strings_hash, &prof->global->ignores_hash );

	for ( p = proc; p; p = p->next ) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( p->child[j] ) {
				if( !STRING_HASH_TB_find( lst.ignores->tb, p->child[j]->name, p->child[j]->hashkey ) ) {
					PROCARRAY_add( &lst, p->child[j] );
				}
			}
		}
	}

	PROCARRAY_sort_by_name( &lst );

	for( i = 0; i < lst.length; i++ ) {
		hProfilerReportCallTreeProc( prof, ctx, f, lst.array[i], (i == 0), (i == lst.length - 1) );
	}

	PROCARRAY_destructor( &lst );

	if( children > 0 ) {
		hPopLeader( prof );
	}
}

static void hProfilerReportCallTree (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Call Tree:\n\n" );
	}

	hProfilerReportCallTreeProc( prof, ctx, f, ctx->thread_proc, TRUE, TRUE );
}

/* PROFILE_OPTION_REPORT_RAWLIST */
static void hProfilerReportRawList (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	int len, col, i, max_len;
	FB_PROCINFO_TB *tb;
	FB_PROCINFO *proc;

	max_len = STRING_TABLE_max_len( &ctx->strings );

	col = (max_len >= 20 ? max_len : 20);

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "List of call data captured:\n\n" );

		fprintf( f, "    id  " );
		len = col - fprintf( f, "caller (parent)" );
		pad_spaces( f, len );

		fprintf( f, "    id  " );
		len = col - fprintf( f, "callee" );
		pad_spaces( f, len );

		if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      count:  " );
		}
		if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     time:  " );
		}
		fprintf( f, "\n\n" );
	}

	for( tb = ctx->proc_tb; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->procinfo[i];

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

			if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->local_count );
				pad_spaces( f, len );
			}

			if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
				len = 12 - fprintf( f, "%10.5f", proc->local_time );
				pad_spaces( f, len );
			}

			fprintf( f, "\n" );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWDATA */
static void hProfilerReportRawDataProc (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f,
	FB_PROCINFO *proc, int level, int max_len, int recursion )
{
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

	if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
		len = 14 - fprintf( f, "%12lld", proc->local_count );
		pad_spaces( f, len );
	}

	if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
		len = 14 - fprintf( f, "%10.5f", proc->local_time );
		pad_spaces( f, len );
	}

	fprintf( f, "\n" );

	if( recursion > 0 ) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			if ( proc->child[j] ) {
				hProfilerReportRawDataProc( prof, ctx, f, proc->child[j], level + 1, max_len, recursion - 1 );
			}
		}
	}
}

static void hProfilerReportRawData (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	int i, max_len, len, col;
	FB_PROCINFO_TB *tb;
	FB_PROCINFO *proc;

	max_len = STRING_TABLE_max_len( &ctx->strings );

	col = (max_len >= 20 ? max_len : 20);

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
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

		if( (prof->global->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			fprintf( f, "      count:  " );
		}
		if( (prof->global->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
			fprintf( f, "     time:  " );
		}
		fprintf( f, "\n\n" );
	}

	for( tb = ctx->proc_tb; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->procinfo[i];
			hProfilerReportRawDataProc( prof, ctx, f, proc, 1, max_len, 1 );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWSTRINGS */
static void hProfilerReportRawStrings (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	STRING_INFO_TB *tb = ctx->strings.tb;

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
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
			fprintf( f, "  %8x", info->hashkey );
			fprintf( f, "  %s\n", (char *)(info + 1) );
			index += info->size;
		}
		tb = tb->next;
	}

	if( (prof->global->options & PROFILE_OPTION_HIDE_TITLES) == 0 ) {
		fprintf( f, "\n\n" );
	}
}

/* PROFILE_OPTION_SHOW_DEBUGGING */
static void hProfilerReportDebug (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROFILER_METRICS metrics_data;
	FB_PROFILER_METRICS *metrics = &metrics_data;
	fb_hPROFILER_METRICS_Clear( metrics );
	fb_hPROFILER_METRICS_CallsProfiler( metrics, prof );

	fprintf( f, "Profiler Debugging Information:\n" );

	fprintf( f, "    Call Tree:\n" );
	fprintf( f, "        number of threads  : %d\n", metrics->count_threads );
	fprintf( f, "        bytes allocated    : %d\n", metrics->procs_bytes_allocated );
	fprintf( f, "        number of blocks   : %d\n", metrics->procs_count_blocks );
	fprintf( f, "        number of items    : %d\n", metrics->procs_count_items );
	fprintf( f, "        number of slots    : %d\n", metrics->procs_count_slots );
	fprintf( f, "    String Block:\n" );
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

static void hProfilerReportThread (
	FB_PROFILER_CALLS *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	/* default report? */
	if( (prof->global->options & PROFILE_OPTION_REPORT_MASK) == 0 ) {
		prof->global->options |= PROFILE_OPTION_REPORT_CALLS;
	}

	if( (prof->global->options & PROFILE_OPTION_REPORT_CALLS) != 0 ) {
		if( (prof->global->options & PROFILE_OPTION_HIDE_FUNCTIONS) == 0 ) {
			hProfilerReportCallsFunctions( prof, ctx, f );
		}

		if( (prof->global->options & PROFILE_OPTION_HIDE_GLOBALS) == 0 ) {
			hProfilerReportCallsGlobals( prof, ctx, f );
		}
	}

	if( (prof->global->options & PROFILE_OPTION_REPORT_CALLTREE) != 0 ) {
		hProfilerReportCallTree( prof, ctx, f );
	}

	if( (prof->global->options & PROFILE_OPTION_REPORT_RAWLIST) != 0 ) {
		hProfilerReportRawList( prof, ctx, f );
	}

	if( (prof->global->options & PROFILE_OPTION_REPORT_RAWDATA) != 0 ) {
		hProfilerReportRawData( prof, ctx, f );
	}

	if( (prof->global->options & PROFILE_OPTION_REPORT_RAWSTRINGS) != 0 ) {
		hProfilerReportRawStrings( prof, ctx, f );
	}

	if( (prof->global->options & PROFILE_OPTION_SHOW_DEBUGGING) != 0 ) {
		hProfilerReportDebug( prof, ctx, f );
	}
}

static void hProfilerWriteReport( FB_PROFILER_CALLS *prof )
{
	char filename[PROFILER_MAX_PATH];
	FB_PROFILER_THREAD *thread;
	FILE *f;

	if( !prof ) {
		return;
	}

	/* fb_PROFILECTX_Destructor() won't be called for the main thread, */
	/* until at least after the report is written, so update time now */
	prof->main_thread->thread_proc->local_time = fb_Timer() - prof->main_thread->thread_proc->start_time;

	fb_ProfileGetFileName( filename, PROFILER_MAX_PATH );

	f = fopen( filename, "w" );

	if( (prof->global->options & PROFILE_OPTION_HIDE_HEADER) == 0 )
	{
		pad_section( f );
		fprintf( f, "Profiling results:\n" );
		fprintf( f, "------------------\n\n" );

		fb_hGetExeName( filename, PROFILER_MAX_PATH-1 );
		fprintf( f, "Executable name: %s\n", filename );
		fprintf( f, "Launched on: %s\n", prof->global->launch_time );
		fprintf( f, "Total program execution time: %5.4g seconds\n", prof->main_thread->thread_proc->local_time );
	}

	hProfilerReportThread( prof, prof->main_thread, f );

	thread = prof->threads;
	while( thread )
	{
		hProfilerReportThread( prof, thread, f );
		thread = thread->next;
	}

	fclose( f );
}

/* ************************************
** Call Stack
*/

static void hInitCall( FB_PROFILER_THREAD *ctx, FB_PROCINFO *proc, const char *procname )
{
	unsigned int hashkey = fb_ProfileHashName( procname );

	proc->name = PROFILER_THREAD_add_string( ctx, procname, hashkey );
	proc->hashkey = hashkey;
	proc->proc_id = PROFILER_new_proc_id( ctx );
	proc->start_time = fb_Timer();
	proc->local_time = 0.0;
	proc->local_count = 0;
	proc->parent = NULL;
	if( strncmp( proc->name, "{fbfp}", 6 ) == 0 ) {
		proc->flags = PROCINFO_FLAGS_CALLPTR;
	} else {
		proc->flags = PROCINFO_FLAGS_NONE;
	}
}

static FB_PROCINFO *hPushCall( FB_PROFILER_THREAD *ctx, FB_PROCINFO *parent_proc, const char *procname )
{
	FB_PROCINFO *orig_parent_proc, *proc;
	int j, hash_index, offset;
	unsigned int hashkey;

	hashkey = fb_ProfileHashName( procname );

	orig_parent_proc = parent_proc;

	hash_index = hashkey % PROC_MAX_CHILDREN;
	offset = hash_index ? (PROC_MAX_CHILDREN - hash_index) : 1;

	for (;;) {
		for ( j = 0; j < PROC_MAX_CHILDREN; j++ ) {
			proc = parent_proc->child[hash_index];
			if ( proc ) {
				if ( proc->hashkey == hashkey && !strcmp( proc->name, procname ) ) {
					goto update_proc;
				}
				hash_index = ( hash_index + offset ) % PROC_MAX_CHILDREN;
			} else {
				proc = FB_PROFILER_THREAD_alloc_proc( ctx );
				goto fill_proc;
			}
		}

		if ( !parent_proc->next ) {
			parent_proc->next = FB_PROFILER_THREAD_alloc_proc( ctx );
			proc = parent_proc->next;
			goto fill_proc;
		}

		parent_proc = parent_proc->next;
	}

fill_proc:
	hInitCall( ctx, proc, procname );
	proc->parent = orig_parent_proc;
	parent_proc->child[hash_index] = proc;

update_proc:
	proc->start_time = fb_Timer();

	/* set the current procedure pointer to the procedure about to be called */
	ctx->thread_proc = proc;

	return proc;
}

static void hPopCall( FB_PROFILER_THREAD *ctx, FB_PROCINFO *proc )
{
	double end_time;

	end_time = fb_Timer();

	/* accumulated time and call count is for all calls */
	/* with the current parent */
	proc->local_time += ( end_time - proc->start_time );
	proc->local_count += 1;

	/* return to the callee's parent */
	ctx->thread_proc = proc->parent;
}

/* ************************************
** Public API
*/

/*:::::*/
FBCALL void *fb_ProfileBeginProc( const char *procname )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx;
	FB_PROCINFO *proc;

	if( !tls->ctx ) {
		fb_PROFILECTX_Constructor( tls );
	}

	ctx = tls->ctx;
	proc = ctx->thread_proc;

	/* First function call of a newly spawned thread has no proc set */
	if( !proc ) {
		if( !procname || !(*procname) ) {
			procname = THREAD_PROC_NAME;
		}
		proc = FB_PROFILER_THREAD_alloc_proc( ctx );
		hInitCall( ctx, proc, procname );
		proc->flags |= PROCINFO_FLAGS_THREAD;
	}

	if( !procname || !(*procname) ) {
		procname = UNNAMED_PROC_NAME;
	}

	/* set the current proc pointer to current procedure called */
	ctx->thread_proc = proc;

	if( (proc->flags & PROCINFO_FLAGS_CALLPTR) != 0 ) {
		proc = hPushCall( ctx, proc, procname );
		ctx->thread_proc = proc;
	}

	return (FB_PROCINFO *)proc;
}

/*:::::*/
FBCALL void fb_ProfileEndProc( void *p )
{
	if( p ) {
		FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
		FB_PROFILER_THREAD *ctx = tls->ctx;
		FB_PROCINFO *proc = ctx->thread_proc;
		if( (proc->flags & PROCINFO_FLAGS_THREAD) != 0 ) {
			proc->local_count += 1;
		}
		if( proc->parent ) {
			if( (proc->parent->flags & PROCINFO_FLAGS_CALLPTR) != 0 ) {
				hPopCall( ctx, proc );
			}
		}
	}
}

/*:::::*/
FBCALL void *fb_ProfileBeginCall( const char *procname )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx;
	FB_PROCINFO *parent_proc;

	if( !tls->ctx ) {
		fb_PROFILECTX_Constructor( tls );
	}

	ctx = tls->ctx;
	parent_proc = ctx->thread_proc;

	/* First function call of a newly spawned thread has no parent proc set */
	if( !parent_proc ) {
		if( !procname || !(*procname) ) {
			procname = THREAD_PROC_NAME;
		}
		parent_proc = FB_PROFILER_THREAD_alloc_proc( ctx );
		hInitCall( ctx, parent_proc, THREAD_PROC_NAME );
		parent_proc->flags |= PROCINFO_FLAGS_THREAD;
	}

	if( !procname || !(*procname) ) {
		procname = UNNAMED_PROC_NAME;
	}

	return (void *)hPushCall( ctx, parent_proc, procname );
}

/*:::::*/
FBCALL void fb_ProfileEndCall( void *p )
{
	if( p ) {
		FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
		hPopCall( tls->ctx, (FB_PROCINFO *)p );
	}
}

/*:::::*/
FBCALL void fb_InitProfile( void )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx;

	if( fb_profiler ) {
		return;
	}
	fb_profiler = PROFILER_CALLS_create( );
	fb_PROFILECTX_Constructor( tls );
	ctx = tls->ctx;

	/* assume we are starting from MAIN procedure */
	ctx->thread_proc = FB_PROFILER_THREAD_alloc_proc( ctx );
	hInitCall( ctx, ctx->thread_proc, MAIN_PROC_NAME );
	ctx->thread_proc->flags |= PROCINFO_FLAGS_MAIN;
	ctx->thread_proc->local_count = 1;

	/* assume that this must have been called from the main thread */
	fb_profiler->main_thread = ctx;
}

/*:::::*/
FBCALL int fb_EndProfile( int errorlevel )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx = tls->ctx;
	FB_PROFILER_CALLS *prof = fb_profiler;

	if( ctx != prof->main_thread ) {
		/* TODO: Ending the profile from some other thread? */
	}

	hProfilerWriteReport( prof );

	PROFILER_CALLS_destroy( fb_profiler );
	fb_profiler = NULL;

	return errorlevel;
}

/*:::::*/
FBCALL void fb_ProfileGetCallsMetrics( FB_PROFILER_METRICS *metrics )
{
	FB_PROFILE_LOCK();

	if( fb_profiler && metrics ) {
		fb_hPROFILER_METRICS_CallsProfiler( metrics, fb_profiler );
	}

	FB_PROFILE_UNLOCK();
}

/*:::::*/
FBCALL FB_PROFILER_CALLS *fb_ProfileGetCallsProfiler()
{
	return fb_profiler;
}
