/*
 * profile.c -- profiling functions
 *
 * chng: apr/2005 written [lillo]
 *       may/2005 rewritten to properly support recursive calls [lillo]
 *       apr/2024 use thread local storage (wip) [jeffm]
 *       apr/2024 add call counting [jeffm]
 *       apr/2024 dynamic string table [jeffm]
 *       apr/2024 remove NUL character padding requirement [jeffm]
 */

/* TODO: allocate a high level hash array for a top level index */
/* TODO: allocate bins in TLS: FB_PROFILECTX (fewer locks)*/
/* TODO: merge thread data to the global data in fb_PROFILECTX_Destructor */
/* TODO: only LOCK/UNLOCK for global data, not individual thread data */
/* TODO: add API to set output file name */
/* TODO: add API to choose output options */
/* TODO: add API to set analysis options */
/* TODO: test the start-up and exit code more */
/* TODO: test and optimize the string comparisons */
/* TODO: demangle procedure names */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif
#include "fb.h"
#include <time.h>

#define MAIN_PROC_NAME         "(main)\0\0\0\0\0\0"
#define THREAD_PROC_NAME       "(thread)\0\0\0\0"
#define PROFILE_FILE           "profile.txt"
#define MAX_CHILDREN           257
#define BIN_SIZE               1024

#if defined HOST_UNIX
#define PATH_SEP               "/"
#else
#define PATH_SEP               "\\"
#endif

/* ************************************
** STRINGS
*/

#define STRING_BLOCK_SIZE 1024

typedef struct _STRING_BLOCK
{
	char data[STRING_BLOCK_SIZE];
	int used;
	int reserved;
	struct _STRING_BLOCK *next;
} STRING_BLOCK;

static STRING_BLOCK *string_head = NULL; 

static char * alloc_string( int length )
{
	char *ret;
	STRING_BLOCK *tmp;
	int size;

	/* 12 byte minumum per string (assuming 4 bytes per int)
	** - space for size (4 bytes) and length (4 bytes) plus
	** - round up length to mod 4 bytes 
	** - and pad with additional 4 NUL bytes
	** - example: ""  => 12, 0, !"\0\0\0\"
	** - example: "A" => 16, 1, !"A\0\0\0\0\0\0\0"
	*/
	size = sizeof(int) + sizeof(int) + ((length + (sizeof(int)-1)) 
	       & ~(sizeof(int)-1)) + sizeof(int);

	if( size > STRING_BLOCK_SIZE ) {
		return NULL;
	}

	if( ( !string_head ) ||
	    (size > (STRING_BLOCK_SIZE - string_head->used)) ) {

		tmp = (STRING_BLOCK*)calloc( 1, sizeof(STRING_BLOCK) );

		if( !tmp ) {
			return NULL;
		}

		tmp->used = 0;
		tmp->reserved = 0;
		tmp->next = string_head;
		string_head = tmp;
	}

	ret = &string_head->data[string_head->used];
	*(int *)ret = size;
	ret += sizeof(int);
	*(int *)ret = length;
	ret += sizeof(int);

	string_head->used += size;

	return ret;
}

static char * store_string( const char *src )
{
	int length = strlen(src) + 1;
	char *dst = (char *)alloc_string( length );
	if( dst ) {
		strncpy( dst, src, length ); 
	}
	return dst;
}

/* ************************************
** PROCS
*/

typedef struct _FBPROC
{
	const char *name;
	struct _FBPROC *parent;
	double time;
	double total_time;
	long long int call_count;
	struct _FBPROC *child[MAX_CHILDREN];
	struct _FBPROC *next;
} FBPROC;

typedef struct _FB_PROFILECTX
{
	FBPROC *main_proc;
	FBPROC *cur_proc;
} FB_PROFILECTX;

void fb_PROFILECTX_Destructor( void* );

typedef struct _BIN
{
	FBPROC fbproc[BIN_SIZE];
	int id;
	int next_free;
	struct _BIN *next;
} BIN;

static BIN *bin_head = NULL;
static char launch_time[32];
static unsigned int max_len = 0;

/*:::::*/
static int strcmp4(const char *s1, const char *s2)
{
	while ((*s1) && (*s2)) {
		if (*(int *)s1 != *(int *)s2) {
			return -1;
		}
		s1 += 4;
		s2 += 4;
	}
	if ((*s1) || (*s2)) {
		return -1;
	}
	return 0;
}

/*:::::*/
static FBPROC *alloc_proc( void )
{
	BIN *bin;
	FBPROC *proc;

	if ( ( !bin_head ) || ( bin_head->next_free >= BIN_SIZE ) ) {
		bin = (BIN *)calloc( 1, sizeof(BIN) );
		bin->next = bin_head;
		bin->id = 0;
		if( bin_head ) {
			bin->id = bin_head->id + 1;
		}
		bin_head = bin;
	}

	proc = &bin_head->fbproc[bin_head->next_free];
	bin_head->next_free++;

	return proc;
}

/*:::::*/
static int name_sorter( const void *e1, const void *e2 )
{
	FBPROC *p1 = *(FBPROC **)e1;
	FBPROC *p2 = *(FBPROC **)e2;

	return strcmp( p1->name, p2->name );
}

/*:::::*/
static int time_sorter( const void *e1, const void *e2 )
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

/*:::::*/
static void add_proc( FBPROC ***array, int *size, FBPROC *proc )
{
	FBPROC **new_array = NULL;
	int s = *size;
	if( *array ) {
		new_array = (FBPROC **)realloc( *array, (s + 1) * sizeof(FBPROC *) );
	} else {
		new_array = (FBPROC **)calloc( (s + 1), sizeof(FBPROC *) );
	}
	
	if( new_array ) {
		new_array[s] = proc;
		(*size)++;
		*array = new_array;
	}
}

/*:::::*/
static void find_all_procs( FBPROC *proc, FBPROC ***array, int *size )
{
	FBPROC *p, **a;
	int add_self = TRUE;
	int i;

	a = *array;
	for ( i = 0; i < *size; i++ ) {
		if ( !strcmp4( a[i]->name, proc->name ) ) {
			add_self = FALSE;
		}
	}
	if ( add_self ) {
		add_proc( array, size, proc );
	}

	for ( p = proc; p; p = p->next ) {
		for ( i = 0; i < MAX_CHILDREN; i++ ) {
			if ( p->child[i] ) {
				find_all_procs( p->child[i], array, size );
			}
		}
	}
}

/*:::::*/
static unsigned int hash4_compute( const char *p, unsigned int *out_hash )
{
	unsigned int hash = 0, len, out_len;

	union {
		int d;
		char b[4];
	} tmp = {0};

	len = out_len = strlen( p );

	while ( len > 3 ) {
		hash = ( (hash << 3) | (hash >> 29) ) ^ ( *(unsigned int *)p );
		len -= 4;
	}

	while ( len > 0 ) {
		tmp.b[len] = p[len];
		--len;
	}

	hash = ( (hash << 3) | (hash >> 29) ) ^ ( tmp.d );

	*out_hash = hash;
	return out_len; 
}

/* ************************************
** PROFILING
*/

/*:::::*/
FBCALL void *fb_ProfileBeginCall( const char *procname )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);
	FBPROC *orig_parent_proc, *parent_proc, *proc;
	unsigned int i, hash = 0, offset = 1, len;

	parent_proc = ctx->cur_proc;
	if( !parent_proc ) {
		/* First function call of a newly spawned thread has no parent proc set */
		parent_proc = alloc_proc();
		parent_proc->name = THREAD_PROC_NAME;
		parent_proc->call_count = 1;
		len = strlen( THREAD_PROC_NAME );
	} else {
		len = ( parent_proc->name != NULL? strlen( parent_proc->name ) : 0 );
	}

	if( len > max_len ) {
		max_len = len;
	}

	orig_parent_proc = parent_proc;

	FB_LOCK();

	len = hash4_compute( procname, &hash );

	if( len > max_len ) {
		max_len = len;
	}

	hash %= MAX_CHILDREN;
	if ( hash ) {
		offset = MAX_CHILDREN - hash;
	}

	for (;;) {
		for ( i = 0; i < MAX_CHILDREN; i++ ) {
			proc = parent_proc->child[hash];
			if ( proc ) {
				if ( !strcmp4( proc->name, procname ) ) {
					goto update_proc;
				}
				hash = ( hash + offset ) % MAX_CHILDREN;
			} else {
				proc = alloc_proc();
				goto fill_proc;
			}
		}

		if ( !parent_proc->next ) {
			parent_proc->next = alloc_proc();
			proc = parent_proc->next;
			if( proc ) {
				goto fill_proc;
			}
		}

		parent_proc = parent_proc->next;
	}

fill_proc:
	proc->name = store_string( procname );
	proc->total_time = 0.0;
	proc->call_count = 0;
	proc->parent = orig_parent_proc;
	parent_proc->child[hash] = proc;

update_proc:
	ctx->cur_proc = proc;

	proc->time = fb_Timer();

	FB_UNLOCK();

	return (void *)proc;
}

/*:::::*/
FBCALL void fb_ProfileEndCall( void *p )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);
	FBPROC *proc;
	double end_time;

	end_time = fb_Timer();

	FB_LOCK();

	proc = (FBPROC *)p;
	proc->total_time += ( end_time - proc->time );
	proc->call_count += 1;
	ctx->cur_proc = proc->parent;

	FB_UNLOCK();
}

/*:::::*/
static void pad_spaces( FILE *f, int len )
{
	for( ; len > 0; len-- ) {
		fprintf( f, " " );
	}
}

/*:::::*/
FBCALL void fb_InitProfile( void )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);

	time_t rawtime = { 0 };
	struct tm *ptm = { 0 };

	ctx->main_proc = alloc_proc();
	ctx->main_proc->name = MAIN_PROC_NAME;
	ctx->main_proc->call_count = 1;

	ctx->cur_proc = ctx->main_proc;

	time( &rawtime );
	ptm = localtime( &rawtime );
	sprintf( launch_time, "%02d-%02d-%04d, %02d:%02d:%02d", 1+ptm->tm_mon, ptm->tm_mday, 1900+ptm->tm_year, ptm->tm_hour, ptm->tm_min, ptm->tm_sec );

	ctx->main_proc->time = fb_Timer();

	max_len = 0;
}

/*:::::*/
FBCALL int fb_EndProfile( int errorlevel )
{
	FB_PROFILECTX *ctx = FB_TLSGETCTX(PROFILE);

	char buffer[MAX_PATH], *p;
	int i, j, len, skip_proc, col;
	BIN *bin;
	FILE *f;
	FBPROC **parent_proc_list = NULL, **proc_list = NULL, *proc, *parent_proc;
	FBPROC *main_proc = ctx->main_proc;
	int parent_proc_size = 0, proc_size = 0;

	col = (max_len + 8 + 1 >= 20? max_len + 8 + 1: 20);

	main_proc->total_time = fb_Timer() - ctx->main_proc->time;

	/* explicitly call destructor? */

	p = fb_hGetExePath( buffer, MAX_PATH-1 );
	if( !p )
		p = PROFILE_FILE;
	else {
		strcat( buffer, PATH_SEP PROFILE_FILE );
		p = buffer;
	}
	f = fopen( p, "w" );
	fprintf( f, "Profiling results:\n"
			    "------------------\n\n" );
	fb_hGetExeName( buffer, MAX_PATH-1 );
	fprintf( f, "Executable name: %s\n", buffer );
	fprintf( f, "Launched on: %s\n", launch_time );
	fprintf( f, "Total program execution time: %5.4g seconds\n\n", main_proc->total_time );

	fprintf( f, "Per function timings:\n\n" );
	len = col - fprintf( f, "        Function:" );
	pad_spaces( f, len );

	fprintf( f, "       Count:      Time:    Total%%:    Proc%%:" );

	for( bin = bin_head; bin; bin = bin->next ) {
		for( i = 0; i < bin->next_free; i++ ) {
			proc = &bin->fbproc[i];
			if( !proc->parent ) {
				/* no parent; either main proc or a thread proc */

				if( !proc->total_time ) {
					/* thread execution time unknown, assume total program execution time */
					proc->total_time = main_proc->total_time;
				}

				add_proc( &parent_proc_list, &parent_proc_size, proc );
				find_all_procs( proc, &parent_proc_list, &parent_proc_size );
			}
		}
	}

	qsort( parent_proc_list, parent_proc_size, sizeof(FBPROC *), name_sorter );

	for( i = 0; i < parent_proc_size; i++ ) {
		parent_proc = parent_proc_list[i];
		skip_proc = TRUE;

		for ( proc = parent_proc; proc; proc = proc->next ) {
			for ( j = 0; j < MAX_CHILDREN; j++ ) {
				if ( proc->child[j] ) {
					add_proc( &proc_list, &proc_size, proc->child[j] );
					skip_proc = FALSE;
				}
			}
		}

		if ( skip_proc ) {
			continue;
		}

		len = col - (fprintf( f, "\n\n%s", parent_proc->name ) - 2);
		pad_spaces( f, len );

		fprintf( f, "%12lld", parent_proc->call_count );
		pad_spaces( f, 2 );

		len = 14 - fprintf( f, "%10.5f", parent_proc->total_time );
		pad_spaces( f, len );

		fprintf( f, "%6.2f%%\n\n", (parent_proc->total_time * 100.0) / main_proc->total_time );

		qsort( proc_list, proc_size, sizeof(FBPROC *), time_sorter );

		for( j = 0; j < proc_size; j++ ) {
			proc = proc_list[j];

			len = col - fprintf( f, "        %s", proc->name );
			pad_spaces( f, len );

			fprintf( f, "%12lld", proc->call_count );
			pad_spaces( f, 2 );

			len = 14 - fprintf( f, "%10.5f", proc->total_time );
			pad_spaces( f, len );

			len = 10 - fprintf( f, "%6.2f%%", ( proc->total_time * 100.0 ) / main_proc->total_time );
			pad_spaces( f, len );
	
			fprintf( f, "%6.2f%%\n", ( parent_proc_list[i]->total_time > 0.0 ) ?
				( proc->total_time * 100.0 ) / parent_proc_list[i]->total_time : 0.0 );
		}

		free( proc_list );
		proc_list = NULL;
		proc_size = 0;
	}

	fprintf( f, "\n\n\nGlobal timings:\n\n" );
	qsort( parent_proc_list, parent_proc_size, sizeof(FBPROC *), time_sorter );
	for( i = 0; i < parent_proc_size; i++ ) {
		proc = parent_proc_list[i];
		len = col - fprintf( f, "%s", proc->name );
		pad_spaces( f, len );

		fprintf( f, "%12lld", proc->call_count );
		pad_spaces( f, 2 );

		len = 14 - fprintf( f, "%10.5f", proc->total_time );
		pad_spaces( f, len );

		len = 10 - fprintf( f, "%6.2f%%\n", ( proc->total_time * 100.0 ) / main_proc->total_time );
	}

	free( parent_proc_list );
	fclose( f );

	while ( bin_head ) {
		bin = bin_head->next;
		free( bin_head );
		bin_head = bin;
	}

	while ( string_head ) {
		STRING_BLOCK *nxt = string_head->next;
		free( string_head );
		string_head = nxt;
	}

	return errorlevel;
}

/*:::::*/
void fb_PROFILECTX_Destructor( void* data )
{
	/* FB_PROFILECTX *ctx = (FB_PROFILECTX *)data; */
	/* TODO: merge the thread results with the (main)/(thread) results */
	data = data;
}
