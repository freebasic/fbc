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

/* ************************************
** memory allocation
*/

#define PROFILER_malloc( size )       malloc( size )
#define PROFILER_calloc( n, size )    calloc( n, size )
#define PROFILER_realloc( ptr, size ) realloc( ptr, size )
#define PROFILER_free( ptr )          free( ptr )


/* ************************************
** CONFIG
*/

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
#define PROFILER_MAX_PATH      1024

#if defined HOST_UNIX
#define PROFILER_PATH_SEP      "/"
#else
#define PROFILER_PATH_SEP      "\\"
#endif

/* String Storage */

/* information about a single string */
typedef struct _STRING_INFO
{
	int size;
	int length;
	unsigned int hashkey;
} STRING_INFO;

/* block of memory to store strings */
typedef struct _STRING_INFO_TB
{
	unsigned char data[STRING_INFO_TB_SIZE];
	struct _STRING_INFO_TB *next;
	int bytes_used;
	int string_tb_id;
} STRING_INFO_TB;

/* first block in a list of string storage blocks */
typedef struct _STRING_TABLE
{
	STRING_INFO_TB *tb;
} STRING_TABLE;

/* block of memory for hashes */
typedef struct _STRING_HASH_TB
{
	STRING_INFO *items[STRING_HASH_TB_SIZE];
	struct _STRING_HASH_TB *next;
} STRING_HASH_TB;

/* first block of memory for hashes and associated string table */
typedef struct _STRING_HASH_TABLE
{
	STRING_TABLE *strings;
	STRING_HASH_TB *tb;
} STRING_HASH_TABLE;

/* hash table for strings */
typedef struct _STRING_HASH
{
	STRING_HASH_TABLE *strings_hash;
	STRING_HASH_TABLE hash;
} STRING_HASH;

unsigned int fb_ProfileHashName( const char *p );

STRING_INFO *STRING_TABLE_alloc( STRING_TABLE *strings, int length );
void         STRING_TABLE_constructor( STRING_TABLE *strings );
void         STRING_TABLE_destructor( STRING_TABLE *strings );
STRING_INFO *STRING_TABLE_add( STRING_TABLE *strings, const char *src, unsigned int hashkey );
int          STRING_TABLE_max_len( STRING_TABLE *strings );
STRING_INFO *STRING_HASH_TB_find( STRING_HASH_TB *tb, const char *src, unsigned int hashkey );
STRING_INFO *STRING_HASH_TABLE_find( STRING_HASH_TABLE *hash, const char *src, unsigned int hashkey );
void         STRING_HASH_TABLE_constructor( STRING_HASH_TABLE *hash, STRING_TABLE *strings );
void         STRING_HASH_TABLE_destructor( STRING_HASH_TABLE *hash );
STRING_INFO *STRING_HASH_TABLE_add( STRING_HASH_TABLE *hash, const char *src, unsigned int hashkey );
STRING_INFO *STRING_HASH_TABLE_add_info( STRING_HASH_TABLE *hash, STRING_INFO *new_info );
void         STRING_HASH_constructor( STRING_HASH *hash, STRING_HASH_TABLE *strings_hash );
void         STRING_HASH_destructor( STRING_HASH *hash );
void         STRING_HASH_add( STRING_HASH *hash, const char *src, unsigned int hashkey );
STRING_INFO *STRING_HASH_find( STRING_HASH *hash, const char *src, unsigned int hashkey );

/* ************************************
** Public API
*/

/* profiler global context */
/* use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing */
typedef struct _FB_PROFILER_GLOBAL
{
	void *profiler_ctx;
	STRING_TABLE strings;
	STRING_HASH_TABLE strings_hash;
	STRING_HASH_TABLE ignores_hash;
	char filename[PROFILER_MAX_PATH];
	char launch_time[32];
	int options; /* PROFILE_OPTIONS */
} FB_PROFILER_GLOBAL;

/* information about the profiler internals */
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

/* calls profiler */

FBCALL void fb_InitProfile( void );
FBCALL int fb_EndProfile( int errorlevel );

FBCALL void *fb_ProfileBeginProc( const char *procname );
FBCALL void  fb_ProfileEndProc( void *callid );
FBCALL void *fb_ProfileBeginCall( const char *procname );
FBCALL void  fb_ProfileEndCall( void *callid );

/* cycles profiles */

FBCALL void fb_InitProfileCycles( void );
FBCALL int fb_EndProfileCycles( int errorlevel );

/* global profiler */

FBCALL FB_PROFILER_GLOBAL *fb_ProfileGetGlobalProfiler();

FBCALL int                 fb_ProfileSetFileName( const char *filename );
FBCALL int                 fb_ProfileGetFileName( char *filename, int length );
FBCALL int                 fb_ProfileGetOptions();
FBCALL int                 fb_ProfileSetOptions( int options );
FBCALL void                fb_ProfileIgnore( const char * procname );
FBCALL void                fb_ProfileGetMetrics( FB_PROFILER_METRICS *metrics );

/* ************************************
** Internals
*/

FB_PROFILER_GLOBAL *PROFILER_GLOBAL_create( void );
void PROFILER_GLOBAL_destroy( void );

char *PROFILER_add_ignore( FB_PROFILER_GLOBAL *prof, const char *src, unsigned int hashkey );
void fb_hPROFILER_METRICS_Clear( FB_PROFILER_METRICS *metrics );
void fb_hPROFILER_METRICS_Strings( FB_PROFILER_METRICS *metrics, STRING_TABLE *strings );
void fb_hPROFILER_METRICS_HashTable( FB_PROFILER_METRICS *metrics, STRING_HASH_TABLE *hash );
void fb_hPROFILER_METRICS_Global( FB_PROFILER_METRICS *metrics, FB_PROFILER_GLOBAL *global );
