/*
** profile.c -- profiling functions
**
** chng: apr/2005 written [lillo]
**       may/2005 rewritten to properly support recursive calls [lillo]
**       apr/2024 use thread local storage (wip) [jeffm]
**       apr/2024 add call counting [jeffm]
**       apr/2024 dynamic string table [jeffm]
**       apr/2024 remove NUL character padding requirement [jeffm]
**       apr/2024 add API to set output file name and report options [jeffm]
**       apr/2024 add profiler lock (replacing fb lock) [jeffm]
**       apr/2024 add calltree report and API to ignore procedures [jeffm]
**       may/2024 instance profiler on each thread [jeffm]
**/

/* TODO: disambiguate private procedures by module name */
/* TODO: function pointer testing and reporting */
/* TODO: test the start-up and exit code more */
/* TODO: demangle procedure names */
/* TODO: split calls profiler to separate module */
/* TODO: allow cycles profiler to use global settings */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif
#include <time.h>

/* ************************************
** CONFIG
*/

#define PROFILER_MAX_PATH      1024
#define MAIN_PROC_NAME         "(main)"
#define THREAD_PROC_NAME       "(thread)"
#define UNNAMED_PROC_NAME      "(unnamed)"
#define DEFAULT_PROFILE_FILE   "profile.txt"
#define DEFAULT_PROFILE_EXT    ".prf"
#define STRING_INFO_TB_SIZE    10240
#define STRING_HASH_TB_SIZE    997
#define PROC_MAX_CHILDREN      257
#define PROC_INFO_TB_SIZE      1024
#define PROC_HASH_TB_SIZE      257

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

/* String Storage */

typedef struct _STRING_INFO
{
	int size;
	int length;
	unsigned int hashkey;
} STRING_INFO;

typedef struct _STRING_INFO_TB
{
	unsigned char data[STRING_INFO_TB_SIZE];
	struct _STRING_INFO_TB *next;
	int bytes_used;
	int string_tb_id;
} STRING_INFO_TB;

typedef struct _STRING_TABLE
{
	STRING_INFO_TB *tb;
} STRING_TABLE;

typedef struct _STRING_HASH_TB
{
	STRING_INFO *items[STRING_HASH_TB_SIZE];
	struct _STRING_HASH_TB *next;
} STRING_HASH_TB;

typedef struct _STRING_HASH_TABLE
{
	STRING_TABLE *strings;
	STRING_HASH_TB *tb;
} STRING_HASH_TABLE;

typedef struct _STRING_HASH
{
	STRING_HASH_TABLE *strings_hash;
	STRING_HASH_TABLE hash;
} STRING_HASH;

/* procs */

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
} FB_PROCINFO;

typedef struct _FB_PROCINFO_TB
{
	FB_PROCINFO procinfo[PROC_INFO_TB_SIZE];
	struct _FB_PROCINFO_TB *next;
	int next_free;
	int proc_tb_id;
} FB_PROCINFO_TB;

typedef struct _PROC_HASH_TB
{
	FB_PROCINFO *proc[PROC_HASH_TB_SIZE];
	struct _PROC_HASH_TB *next;
} PROC_HASH_TB;

typedef struct _FB_PROCARRAY
{
	FB_PROCINFO **array;
	STRING_HASH hash;
	STRING_HASH_TABLE *ignores;
	int length;
	int size;
} FB_PROCARRAY;

/* profiler */

typedef struct _FB_PROFILER_METRICS
{
	int count_threads;

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

} FB_PROFILER_METRICS;

/* reporting options */

enum PROFILE_OPTIONS
{
	PROFILE_OPTION_REPORT_DEFAULT    = 0x00000000,
	PROFILE_OPTION_REPORT_CALLS      = 0x00000001,
	PROFILE_OPTION_REPORT_CALLTREE   = 0x00000002,
	PROFILE_OPTION_REPORT_RAWLIST    = 0x00000004,
	PROFILE_OPTION_REPORT_RAWDATA    = 0x00000008,
	PROFILE_OPTION_REPORT_RAWSTRINGS = 0x00000010,

	PROFILE_OPTION_REPORT_MASK       = 0x000000FF,

	PROFILE_OPTION_HIDE_HEADER       = 0x00000100,
	PROFILE_OPTION_HIDE_TITLES       = 0x00000200,
	PROFILE_OPTION_HIDE_COUNTS       = 0x00000400,
	PROFILE_OPTION_HIDE_TIMES        = 0x00000800,
	PROFILE_OPTION_HIDE_FUNCTIONS    = 0x00001000,
	PROFILE_OPTION_HIDE_GLOBALS      = 0x00002000,

	PROFILE_OPTION_SHOW_DEBUGGING    = 0x01000000,
	PROFILE_OPTION_GRAPHICS_CHARS    = 0x02000000
};

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

/* profiler global context */
/* use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing */
typedef struct _FB_PROFILER_GLOBAL
{
	char filename[PROFILER_MAX_PATH];
	char launch_time[32];
	STRING_TABLE strings;
	STRING_HASH_TABLE strings_hash;
	STRING_HASH_TABLE ignores_hash;
	FB_PROFILER_THREAD *main_thread;
	FB_PROFILER_THREAD *threads;
	FBSTRING calltree_leader;
	enum PROFILE_OPTIONS options;
} FB_PROFILER_GLOBAL;

/* ************************************
** Globals
*/

static FB_PROFILER_GLOBAL *fb_profiler = NULL;

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
** String Storage
*/

static STRING_INFO *STRING_TABLE_alloc( STRING_TABLE *strings, int length )
{
	STRING_INFO *info;
	int size;

	/* minumum size per string (assuming 4 bytes per int)
	** - space for STRING_INFO
	** - pad with additional NUL bytes to make size a multiple of 4
	*/
	size = sizeof(STRING_INFO) + ((length + (sizeof(int)-1))
	       & ~(sizeof(int)-1));

	if( size > STRING_INFO_TB_SIZE ) {
		return NULL;
	}

	if( size > (STRING_INFO_TB_SIZE - strings->tb->bytes_used) ) {
		STRING_INFO_TB *tb = (STRING_INFO_TB*)PROFILER_calloc( 1, sizeof(STRING_INFO_TB) );
		if( !tb ) {
			return NULL;
		}

		tb->bytes_used = 0;
		tb->string_tb_id = strings->tb->string_tb_id + 1;
		tb->next = strings->tb;
		strings->tb = tb;
	}

	info = (STRING_INFO*)&strings->tb->data[strings->tb->bytes_used];
	info->size = size;
	strings->tb->bytes_used += size;

	return info;
}

static void STRING_TABLE_constructor( STRING_TABLE *strings )
{
	if( strings ) {
		STRING_INFO_TB *tb = (STRING_INFO_TB*)PROFILER_calloc( 1, sizeof(STRING_INFO_TB) );
		if( tb ) {
			tb->bytes_used = 0;
			tb->string_tb_id = 1;
			tb->next = NULL;
		}
		strings->tb = tb;
	}
}

static void STRING_TABLE_destructor( STRING_TABLE *strings )
{
	if( strings ) {
		STRING_INFO_TB *tb = strings->tb;
		while( tb ) {
			STRING_INFO_TB *tb_next = tb->next;
			PROFILER_free( tb );
			tb = tb_next;
		}
		PROFILER_free( strings );
	}
}

static STRING_INFO *STRING_TABLE_add( STRING_TABLE *strings, const char *src, unsigned int hashkey )
{
	STRING_INFO *info;
	int length;

	length = strlen( src ) + 1;

	info = STRING_TABLE_alloc( strings, length );
	if( info ) {
		info->length = length;
		info->hashkey = hashkey;

		/* copy the string */
		strncpy( (char *)(info+1), src, length );
	}
	return info;
}

static int STRING_TABLE_max_len( STRING_TABLE *strings )
{
	STRING_INFO_TB *tb;
	STRING_INFO *info;
	int max_len = 0, index;
	if( strings ) {
		tb = strings->tb;
		while ( tb ) {
			index = 0;
			while( index < tb->bytes_used )
			{
				info = (STRING_INFO*)&tb->data[index];
				if( info->length > max_len ) {
					max_len = info->length;
				}
				index += info->size;
			}
			tb = tb->next;
		}
	}
	return max_len;
}

static STRING_INFO *STRING_HASH_TB_find( STRING_HASH_TB *tb, const char *src, unsigned int hashkey )
{
	STRING_INFO *info;
	int hash_index = hashkey % STRING_HASH_TB_SIZE;

	while( tb ) {
		info = tb->items[hash_index];
		if( info ) {
			if( (info->hashkey == hashkey) && (strcmp( (char *)(info + 1), src ) == 0) ) {
				return info;
			}
		} else {
			break;
		}
		tb = tb->next;
	}
	return NULL;
}

static STRING_INFO *STRING_HASH_TABLE_find( STRING_HASH_TABLE *hash, const char *src, unsigned int hashkey )
{
	return STRING_HASH_TB_find( hash->tb, src, hashkey );
}

static void STRING_HASH_TABLE_constructor( STRING_HASH_TABLE *hash, STRING_TABLE *strings )
{
	if( hash ) {
		hash->tb = NULL;
		hash->strings = strings;
	}
}

static void STRING_HASH_TABLE_destructor( STRING_HASH_TABLE *hash )
{
	if( hash ) {
		STRING_HASH_TB *tb = hash->tb;
		while ( tb ) {
			STRING_HASH_TB *tb_next = tb->next;
			PROFILER_free( tb );
			tb = tb_next;
		}
		hash->tb = NULL;
	}
}

static STRING_INFO *STRING_HASH_TABLE_add( STRING_HASH_TABLE *hash, const char *src, unsigned int hashkey )
{
	STRING_HASH_TB *tb = hash->tb;
	STRING_INFO *info;
	int hash_index = hashkey % STRING_HASH_TB_SIZE;

	if( !tb ) {
		tb = (STRING_HASH_TB*)PROFILER_calloc( 1, sizeof( STRING_HASH_TB ) );
		hash->tb = tb;
	}

	while( tb )
	{
		info = tb->items[hash_index];
		if( info ) {
			if( (info->hashkey == hashkey) && (strcmp( (char *)(info + 1), src ) == 0) ) {
				return info;
			}
		} else {
			info = STRING_TABLE_add( hash->strings, src, hashkey );
			tb->items[hash_index] = info;
			return info;
		}
		if( !tb->next ) {
			tb->next = (STRING_HASH_TB*)PROFILER_calloc( 1, sizeof( STRING_HASH_TB ) );
		}
		tb = tb->next;
	}
	return NULL;
}

static STRING_INFO *STRING_HASH_TABLE_add_info( STRING_HASH_TABLE *hash, STRING_INFO *new_info )
{
	STRING_HASH_TB *tb = hash->tb;
	STRING_INFO *info;
	int hash_index = new_info->hashkey % STRING_HASH_TB_SIZE;

	if( !tb ) {
		tb = (STRING_HASH_TB*)PROFILER_calloc( 1, sizeof( STRING_HASH_TB ) );
		hash->tb = tb;
	}

	while( tb )
	{
		info = tb->items[hash_index];
		if( info ) {
			if( info == new_info ) {
				return info;
			}
		} else {
			tb->items[hash_index] = new_info;
			return new_info;
		}
		if( !tb->next ) {
			tb->next = (STRING_HASH_TB*)PROFILER_calloc( 1, sizeof( STRING_HASH_TB ) );
		}
		tb = tb->next;
	}
	return NULL;
}

static void STRING_HASH_constructor( STRING_HASH *hash, STRING_HASH_TABLE *strings_hash )
{
	if( hash ) {
		STRING_HASH_TABLE_constructor( &hash->hash, strings_hash->strings );
		hash->strings_hash = strings_hash;
	}
}

static void STRING_HASH_destructor( STRING_HASH *hash )
{
	if( hash ) {
		STRING_HASH_TABLE_destructor( &hash->hash );
		hash->strings_hash = NULL;
	}
}

static void STRING_HASH_add( STRING_HASH *hash, const char *src, unsigned int hashkey )
{
	STRING_INFO *info = STRING_HASH_TABLE_add( hash->strings_hash, src, hashkey );
	if( info ) {
		STRING_HASH_TABLE_add_info( &hash->hash, info );
	}
}

static STRING_INFO *STRING_HASH_find( STRING_HASH *hash, const char *src, unsigned int hashkey )
{
	return STRING_HASH_TB_find( hash->hash.tb, src, hashkey );
}

static char *PROFILER_THREAD_add_string( FB_PROFILER_THREAD *ctx, const char *src, unsigned int hashkey )
{
	STRING_INFO *info = STRING_HASH_TABLE_add( &ctx->strings_hash, src, hashkey );
	return (char*)(info+1);
}

static char *PROFILER_add_ignore( FB_PROFILER_GLOBAL *prof, const char *src, unsigned int hashkey )
{
	STRING_INFO *info = STRING_HASH_TABLE_add( &prof->ignores_hash, src, hashkey );
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

static void PROFILER_METRICS_clear( FB_PROFILER_METRICS *metrics )
{
	if( metrics ) {
		metrics->count_threads = 0;

		metrics->string_bytes_allocated = 0;
		metrics->string_bytes_used = 0;
		metrics->string_bytes_free = 0;
		metrics->string_count_blocks = 0;
		metrics->string_count_strings = 0;

		metrics->hash_bytes_allocated = 0;
		metrics->hash_count_blocks = 0;
		metrics->hash_count_items = 0;
		metrics->hash_count_slots = 0;

		metrics->procs_bytes_allocated = 0;
		metrics->procs_count_blocks = 0;
		metrics->procs_count_items = 0;
		metrics->procs_count_slots = 0;
	}
}

static void PROFILER_METRICS_hStrings( FB_PROFILER_METRICS *metrics, STRING_TABLE *strings )
{
	STRING_INFO_TB *tb;
	STRING_INFO *info;
	int index;

	if( metrics && strings ) {
		tb = strings->tb;
		while ( tb ) {
			metrics->string_bytes_allocated += sizeof( STRING_INFO_TB );
			metrics->string_bytes_used += tb->bytes_used;
			metrics->string_bytes_free += sizeof( STRING_INFO_TB ) - tb->bytes_used;
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
}

static void PROFILER_METRICS_hHashTable( FB_PROFILER_METRICS *metrics, STRING_HASH_TABLE *hash )
{
	STRING_HASH_TB *tb;
	if( metrics && hash ) {
		tb = hash->tb;
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
}

static void PROFILER_METRICS_hProcs( FB_PROFILER_METRICS *metrics, FB_PROCINFO_TB *proc_tb )
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

static void PROFILER_METRICS_hThreads( FB_PROFILER_METRICS *metrics, FB_PROFILER_THREAD *ctx )
{
	if( metrics && ctx ) {
		metrics->count_threads += 1;
		PROFILER_METRICS_hStrings( metrics, &ctx->strings );
		PROFILER_METRICS_hHashTable( metrics, &ctx->strings_hash );
		PROFILER_METRICS_hProcs( metrics, ctx->proc_tb );
	}
}

static void PROFILER_METRICS_hProfiler( FB_PROFILER_METRICS *metrics, FB_PROFILER_GLOBAL *prof )
{
	FB_PROFILER_THREAD *ctx;

	if( !prof || !metrics ) {
		return;
	}

	PROFILER_METRICS_clear( metrics );

	PROFILER_METRICS_hHashTable( metrics, &prof->strings_hash );
	PROFILER_METRICS_hHashTable( metrics, &prof->ignores_hash );
	PROFILER_METRICS_hStrings( metrics, &prof->strings );

	PROFILER_METRICS_hThreads( metrics, prof->main_thread );

	ctx = prof->threads;
	while( ctx ) {
		PROFILER_METRICS_hThreads( metrics, ctx );
		ctx = ctx->next;
	}
}

/* ************************************
** Profiling
*/

static FB_PROFILER_GLOBAL *PROFILER_new( void )
{
	FB_PROFILER_GLOBAL *prof = PROFILER_calloc( 1, sizeof( FB_PROFILER_GLOBAL ) );
	if( prof ) {
		prof->filename[0] = 0;
		prof->launch_time[0] = 0;
		prof->calltree_leader.data = NULL;
		prof->calltree_leader.size = 0;
		prof->calltree_leader.len = 0;
		STRING_TABLE_constructor( &prof->strings );
		STRING_HASH_TABLE_constructor( &prof->strings_hash, &prof->strings );
		STRING_HASH_TABLE_constructor( &prof->ignores_hash, &prof->strings );
	}
	return prof;
}

static void PROFILER_delete( FB_PROFILER_GLOBAL *prof )
{
	FB_PROFILER_THREAD *nxt_ctx;
	PROFILER_free( prof->calltree_leader.data );

	while( prof->threads ) {
		FB_PROCINFO_TB_destructor( prof->threads->proc_tb );
		STRING_HASH_TABLE_destructor( &prof->threads->strings_hash );
		STRING_TABLE_destructor( &prof->threads->strings );

		nxt_ctx = prof->threads->next;
		PROFILER_free( prof->threads );
		prof->threads = nxt_ctx;
	}

	STRING_HASH_TABLE_destructor( &prof->strings_hash );
	STRING_HASH_TABLE_destructor( &prof->ignores_hash );
	STRING_TABLE_destructor( &prof->strings );

	PROFILER_free( prof );
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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f,
	FB_PROCINFO *parent_proc, int col, int isthread )
{
	FB_PROCINFO *proc;
	FB_PROCARRAY proc_list;
	int j, len;

	PROCARRAY_constructor( &proc_list, &prof->strings_hash, &prof->ignores_hash );

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

		if( isthread ) {
			len = col - (fprintf( f, "(thread) %s", parent_proc->name ) );
		} else {
			len = col - (fprintf( f, "%s", parent_proc->name ) );
		}
		pad_spaces( f, len );

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", parent_proc->local_count );
			pad_spaces( f, len );
		}

		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
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

			if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->local_count );
				pad_spaces( f, len );
			}

			if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROCARRAY list;
	int i, len;
	int max_len = STRING_TABLE_max_len( &ctx->strings );
	int col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
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

	PROCARRAY_constructor( &list, &prof->strings_hash, &prof->ignores_hash );

	PROCARRAY_find_unique_procs( &list, ctx->proc_tb );
	PROCARRAY_sort_by_name( &list );
	for( i = 0; i < list.length; i++ ) {
		hProfilerReportCallsProc( prof, ctx, f, list.array[i], col, FALSE );
	}

	PROCARRAY_destructor( &list );
}

static void hProfilerReportCallsGlobals (
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROCINFO_TB *tb;
	FB_PROCARRAY list_all, list;
	FB_PROCINFO *last_p;
	int i, len;
	int max_len = STRING_TABLE_max_len( &ctx->strings );
	int col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Global results:\n\n" );
	}

	PROCARRAY_constructor( &list, &prof->strings_hash, &prof->ignores_hash );

	PROCARRAY_constructor( &list_all, &prof->strings_hash, &prof->ignores_hash );
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

		if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
			len = 14 - fprintf( f, "%12lld", proc->local_count );
			pad_spaces( f, len );
		}

		if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
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
static void hPushLeader( FB_PROFILER_GLOBAL *prof, int ch )
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

static void hPopLeader( FB_PROFILER_GLOBAL *prof )
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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f,
	FB_PROCINFO *proc, int isfirst, int islast )
{
	static char asc_chars[4] = { '|', '-', '|', '\\' };
	static char gfx_chars[4] = { 179, 196, 195, 192  };
	char * ch = asc_chars;

	FB_PROCINFO *p;
	int i, j, children;
	FB_PROCARRAY lst;

	if( (prof->options &PROFILE_OPTION_GRAPHICS_CHARS) != 0 ) {
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

	PROCARRAY_constructor( &lst, &prof->strings_hash, &prof->ignores_hash );

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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 )
	{
		pad_section( f );
		fprintf( f, "Call Tree:\n\n" );
	}

	hProfilerReportCallTreeProc( prof, ctx, f, ctx->thread_proc, TRUE, TRUE );
}

/* PROFILE_OPTION_REPORT_RAWLIST */
static void hProfilerReportRawList (
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	int len, col, i, max_len;
	FB_PROCINFO_TB *tb;
	FB_PROCINFO *proc;

	max_len = STRING_TABLE_max_len( &ctx->strings );

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

			if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
				len = 14 - fprintf( f, "%12lld", proc->local_count );
				pad_spaces( f, len );
			}

			if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
				len = 12 - fprintf( f, "%10.5f", proc->local_time );
				pad_spaces( f, len );
			}

			fprintf( f, "\n" );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWDATA */
static void hProfilerReportRawDataProc (
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f,
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

	if( (prof->options & PROFILE_OPTION_HIDE_COUNTS) == 0 ) {
		len = 14 - fprintf( f, "%12lld", proc->local_count );
		pad_spaces( f, len );
	}

	if( (prof->options & PROFILE_OPTION_HIDE_TIMES) == 0 ) {
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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	int i, max_len, len, col;
	FB_PROCINFO_TB *tb;
	FB_PROCINFO *proc;

	max_len = STRING_TABLE_max_len( &ctx->strings );

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

	for( tb = ctx->proc_tb; tb; tb = tb->next ) {
		for( i = 0; i < tb->next_free; i++ ) {
			proc = &tb->procinfo[i];
			hProfilerReportRawDataProc( prof, ctx, f, proc, 1, max_len, 1 );
		}
	}
}

/* PROFILE_OPTION_REPORT_RAWSTRINGS */
static void hProfilerReportRawStrings (
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	STRING_INFO_TB *tb = ctx->strings.tb;

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
			fprintf( f, "  %8x", info->hashkey );
			fprintf( f, "  %s\n", (char *)(info + 1) );
			index += info->size;
		}
		tb = tb->next;
	}

	if( (prof->options & PROFILE_OPTION_HIDE_TITLES) == 0 ) {
		fprintf( f, "\n\n" );
	}
}

/* PROFILE_OPTION_SHOW_DEBUGGING */
static void hProfilerReportDebug (
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	FB_PROFILER_METRICS metrics_data;
	FB_PROFILER_METRICS *metrics = &metrics_data;
	PROFILER_METRICS_clear( metrics );
	PROFILER_METRICS_hProfiler( metrics, prof );

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
	FB_PROFILER_GLOBAL *prof, FB_PROFILER_THREAD *ctx, FILE *f )
{
	/* default report? */
	if( (prof->options & PROFILE_OPTION_REPORT_MASK) == 0 ) {
		prof->options |= PROFILE_OPTION_REPORT_CALLS;
	}

	if( (prof->options & PROFILE_OPTION_REPORT_CALLS) != 0 ) {
		if( (prof->options & PROFILE_OPTION_HIDE_FUNCTIONS) == 0 ) {
			hProfilerReportCallsFunctions( prof, ctx, f );
		}

		if( (prof->options & PROFILE_OPTION_HIDE_GLOBALS) == 0 ) {
			hProfilerReportCallsGlobals( prof, ctx, f );
		}
	}

	if( (prof->options & PROFILE_OPTION_REPORT_CALLTREE) != 0 ) {
		hProfilerReportCallTree( prof, ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWLIST) != 0 ) {
		hProfilerReportRawList( prof, ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWDATA) != 0 ) {
		hProfilerReportRawData( prof, ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_REPORT_RAWSTRINGS) != 0 ) {
		hProfilerReportRawStrings( prof, ctx, f );
	}

	if( (prof->options & PROFILE_OPTION_SHOW_DEBUGGING) != 0 ) {
		hProfilerReportDebug( prof, ctx, f );
	}
}

/* ************************************
** Public API
*/

/*:::::*/
FBCALL void *fb_ProfileBeginCall( const char *procname )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx;
	FB_PROCINFO *orig_parent_proc, *parent_proc, *proc;
	unsigned int j, hashkey = 0, hash_index, offset;

	if( !procname || !(*procname) ) {
		procname = UNNAMED_PROC_NAME;
	}

	hashkey = hash_compute( procname );

	if( !tls->ctx ) {
		fb_PROFILECTX_Constructor( tls );
	}

	ctx = tls->ctx;
	parent_proc = ctx->thread_proc;

	/* First function call of a newly spawned thread has no parent proc set */
	if( !parent_proc ) {
		parent_proc = FB_PROFILER_THREAD_alloc_proc( ctx );
		parent_proc->name = THREAD_PROC_NAME;
		parent_proc->hashkey = hash_compute( parent_proc->name );
		parent_proc->local_count = 1;
		parent_proc->proc_id = PROFILER_new_proc_id( ctx );
		parent_proc->start_time = fb_Timer();
	}

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
	proc->proc_id = PROFILER_new_proc_id( ctx );
	proc->name = PROFILER_THREAD_add_string( ctx, procname, hashkey );
	proc->hashkey = hashkey;
	proc->local_time = 0.0;
	proc->local_count = 0;
	proc->parent = orig_parent_proc;
	parent_proc->child[hash_index] = proc;

update_proc:
	/* set the current procedure pointer to the procedure about to be called */
	ctx->thread_proc = proc;

	proc->start_time = fb_Timer();

	return (void *)proc;
}

/*:::::*/
FBCALL void fb_ProfileEndCall( void *p )
{
	FB_PROFILECTX *tls;
	FB_PROFILER_THREAD *ctx;
	FB_PROCINFO *proc;

	double end_time;

	if( !p ) {
		return;
	}

	end_time = fb_Timer();

	tls = FB_TLSGETCTX(PROFILE);
	ctx = tls->ctx;

	proc = (FB_PROCINFO *)p;

	/* accumulated time and call count is for all calls */
	/* with the current parent */
	proc->local_time += ( end_time - proc->start_time );
	proc->local_count += 1;

	/* return to the callee's parent */
	ctx->thread_proc = proc->parent;
}

/*:::::*/
FBCALL void fb_InitProfile( void )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx;
	double start_time;

	if( fb_profiler ) {
		return;
	}
	start_time = fb_Timer();

	fb_profiler = PROFILER_new( );

	time_t rawtime = { 0 };
	struct tm *ptm = { 0 };

	time( &rawtime );
	ptm = localtime( &rawtime );
	sprintf( fb_profiler->launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );

	fb_PROFILECTX_Constructor( tls );
	ctx = tls->ctx;

	/* assume we are starting from MAIN procedure */
	ctx->thread_proc = FB_PROFILER_THREAD_alloc_proc( ctx );
	ctx->thread_proc->name = MAIN_PROC_NAME;
	ctx->thread_proc->hashkey = hash_compute( ctx->thread_proc->name );
	ctx->thread_proc->local_count = 1;
	ctx->thread_proc->proc_id = PROFILER_new_proc_id( ctx );
	ctx->thread_proc->start_time = start_time;

	/* assume that this must have been called from the main thread */
	fb_profiler->main_thread = ctx;
}

static void hProfilerWriteReport( FB_PROFILER_GLOBAL *prof )
{
	FB_PROFILER_THREAD *thread;
	FILE *f;

	char buffer[PROFILER_MAX_PATH], *filename;

	if( !prof ) {
		return;
	}

	/* fb_PROFILECTX_Destructor() won't be called for the main thread, */
	/* until at least after the report is written, so update time now */
	prof->main_thread->thread_proc->local_time = fb_Timer() - prof->main_thread->thread_proc->start_time;

	filename = fb_hGetExeName( buffer, PROFILER_MAX_PATH-1 );
	if( prof->filename[0] ) {
		filename = prof->filename;
	} else if( !filename ) {
		filename = DEFAULT_PROFILE_FILE;
	} else {
		strcat( buffer, DEFAULT_PROFILE_EXT );
		filename = buffer;
	}

	f = fopen( filename, "w" );

	if( (prof->options & PROFILE_OPTION_HIDE_HEADER) == 0 )
	{
		pad_section( f );
		fprintf( f, "Profiling results:\n" );
		fprintf( f, "------------------\n\n" );

		fb_hGetExeName( buffer, PROFILER_MAX_PATH-1 );
		fprintf( f, "Executable name: %s\n", buffer );
		fprintf( f, "Launched on: %s\n", prof->launch_time );
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

/*:::::*/
FBCALL int fb_EndProfile( int errorlevel )
{
	FB_PROFILECTX *tls = FB_TLSGETCTX(PROFILE);
	FB_PROFILER_THREAD *ctx = tls->ctx;
	FB_PROFILER_GLOBAL *prof = fb_profiler;

	if( ctx != prof->main_thread ) {
		/* TODO: Ending the profile from some other thread? */
	}

	hProfilerWriteReport( prof );

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

	if( len < 1 || len >= PROFILER_MAX_PATH-1 ) {
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
	int previous_options = 0;

	FB_PROFILE_LOCK();

	if( fb_profiler ) {
		previous_options = fb_profiler->options;
		fb_profiler->options = options;
	}

	FB_PROFILE_UNLOCK();

	return previous_options;
}

/*:::::*/
FBCALL void fb_ProfileIgnore( const char * procname )
{
	FB_PROFILE_LOCK();

	if( fb_profiler && procname ) {
		unsigned int hashkey;
		hashkey = hash_compute( procname );
		PROFILER_add_ignore( fb_profiler, procname, hashkey );
	}

	FB_PROFILE_UNLOCK();
}

/*:::::*/
FBCALL FB_PROFILER_GLOBAL *fb_ProfileGetProfiler()
{
	return fb_profiler;
}

/*:::::*/
FBCALL void fb_ProfileGetMetrics( FB_PROFILER_METRICS *metrics )
{
	FB_PROFILE_LOCK();

	if( fb_profiler && metrics ) {
		PROFILER_METRICS_hProfiler( metrics, fb_profiler );
	}

	FB_PROFILE_UNLOCK();
}
