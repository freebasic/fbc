/* profile_cycles.c -- cycle counting profiler */

/* WIP */
/* TODO: update src/compiler/rtl-system.bas:rtlInitProfile */
/* TODO: test exit code, profiler clean-up should still run
**       even when compiled exe does not encounter fb_End() */
/* TODO: organize this code by only having start-up code here
**       and the test in src/rtlib/profile-cycles.c */
/* TODO: share reporting code with src/rtlib/profile.c */
/* TODO: add a report option for binary output */

#include "fb.h"
#include "fb_profile.h"

#ifdef HOST_WIN32
	#include <windows.h>
#endif

/* choose a suitable size_t printf specifier */
#if !defined(fmtsizet)
	#if defined(HOST_CYGWIN)
		#define fmtsizet "%18Iu"
	#elif defined(HOST_WIN32)
		#if defined(_UCRT) || __USE_MINGW_ANSI_STDIO
			#define fmtsizet "%18zu"
		#else
			#define fmtsizet "%18Iu"
		#endif
	#else
		#define fmtsizet "%18zu"
	#endif
#endif

/* profile section data */
extern char __start_fb_profilecycledata[];
extern char __stop_fb_profilecycledata;

/* profiler record ids - these indicate what the record is */
enum FB_PROFILE_REDORD_ID
{
	FB_PROFILE_RECORD_VERSION_ID = 1,
	FB_PROFILE_RECORD_DATA_ID    = 2
};

/* the current profiler version number */
#define FB_PROFILE_VERSION 100

typedef struct _FB_PROFILE_RECORD_HEADER
{
	ssize_t size;
	ssize_t id;
} FB_PROFILE_RECORD_HEADER;

typedef struct _FB_PROFILE_RECORD_VERSION
{
	ssize_t size;
	ssize_t id;
	ssize_t version;
	void * reserved1;
} FB_PROFILE_RECORD_VERSION;

typedef struct _FB_PROFILE_RECORD_DATA
{
	ssize_t size;
	ssize_t id;
	char * module_name;
	char * proc_name;
	ssize_t init0;
	ssize_t grand_total;
	ssize_t reinit;
	ssize_t internal_total;
	ssize_t call_count;
	ssize_t reserved;
} FB_PROFILE_RECORD_DATA;

typedef struct _FB_PROFILE_FILE_DATA
{
	ssize_t init0;
	ssize_t grand_total;
	ssize_t reinit;
	ssize_t internal_total;
	ssize_t call_count;
} FB_PROFILE_FILE_DATA;

/* cycles profiler global context */
/* use FB_PROFILE_LOCK()/FB_PROFILE_UNLOCK when accessing */
typedef struct _FB_PROFILER_CYCLES
{
	FB_PROFILER_GLOBAL *global;
	double start_time;
} FB_PROFILER_CYCLES;

/* ************************************
** Globals
*/

/* FIXME: creating a library with other sections causes dxe3gen to fail
**        when building the DXE dynamic link library support for DOS
*/
#if !defined(HOST_DOS)

/* make sure there is at least one record in the profile data section */
static FB_PROFILE_RECORD_VERSION
__attribute__ ((aligned (16))) prof_data_version
__attribute__((section("fb_profilecycledata"), used)) =
	{
		sizeof( FB_PROFILE_RECORD_VERSION ),
		FB_PROFILE_RECORD_VERSION_ID,
		FB_PROFILE_VERSION, 0
	};

#endif

static FB_PROFILER_CYCLES *fb_profiler = NULL;

/* ************************************
** Profiling
*/

static FB_PROFILER_CYCLES *PROFILER_CYCLES_create( void )
{
	if( fb_profiler == NULL ) {
		FB_PROFILER_CYCLES *prof;
		prof = PROFILER_calloc( 1, sizeof( FB_PROFILER_CYCLES ) );
		if( prof ) {
			prof->global = PROFILER_GLOBAL_create( );
			if( prof->global ) {
				prof->global->profiler_ctx = (void * )prof;
				fb_profiler = prof;
			} else {
				PROFILER_free( prof );
			}
		}
	}
	return fb_profiler;
}

static void PROFILER_CYCLES_destroy( void )
{
	if( fb_profiler ) {
		PROFILER_GLOBAL_destroy( );
		PROFILER_free( fb_profiler );
		fb_profiler = NULL;
	}
}

/* ************************************
** Report Generation
*/

#if 0
static hProfilerReportBinary( void )
{
	f1 = fopen( "profilename.prf", "w" );
	f2 = fopen( "profilecycles.prf", "w" );

	while( index < length )
	{
		FB_PROFILE_RECORD_HEADER *rec = (FB_PROFILE_RECORD_HEADER *)&data[index];
		switch ( rec->id )
		{
			case FB_PROFILE_RECORD_VERSION_ID:
			{
				// FB_PROFILE_RECORD_VERSION *ver = (FB_PROFILE_RECORD_VERSION *)rec;
				break;
			}
			case FB_PROFILE_RECORD_DATA_ID:
			{
				FB_PROFILE_RECORD_DATA *dat = (FB_PROFILE_RECORD_DATA *)rec;
				FB_PROFILE_FILE_DATA fil;

				fil.init0          = dat->init0;
				fil.grand_total    = dat->grand_total;
				fil.reinit         = dat->reinit;
				fil.internal_total = dat->internal_total;
				fil.call_count     = dat->call_count;

				fprintf( f1, "%s\n", dat->proc_name );
				fprintf( f1, "%s\n", dat->module_name );
				fwrite( &fil, sizeof(FB_PROFILE_FILE_DATA), 1, f2 );
				break;
			}
			default:
				break;
		}
		index += rec->size;
	}

	fclose( f2 );
	fclose( f1 );
}
#endif

static ssize_t hProfilerCountProcs( unsigned char *data, ssize_t length )
{
	ssize_t index = 0, count = 0;
	while( index < length ) {
		FB_PROFILE_RECORD_HEADER *rec = (FB_PROFILE_RECORD_HEADER *)&data[index];
		if( rec->id == FB_PROFILE_RECORD_DATA_ID ) {
			count += 1;
		}
		index += rec->size;
	}
	return count;
}

static int name_sorter( const void *e1, const void *e2 )
{
	FB_PROFILE_RECORD_DATA *p1 = *(FB_PROFILE_RECORD_DATA **)e1;
	FB_PROFILE_RECORD_DATA *p2 = *(FB_PROFILE_RECORD_DATA **)e2;
	int ret;

	ret = strcmp( p1->module_name, p2->module_name );
	if( ret ) {
		return ret;
	}
	return strcmp( p1->proc_name, p2->proc_name );
}

static void hProfilerSortArray( FB_PROFILE_RECORD_DATA **array, ssize_t count )
{
	qsort( array, count, sizeof(FB_PROFILE_RECORD_DATA *), name_sorter );
}

static void hProfilerBuildArray (
	FB_PROFILE_RECORD_DATA **array, ssize_t count,
	unsigned char *data, ssize_t length
)
{
	ssize_t index = 0;
	int i = 0;

	if( !array ) {
		return;
	}

	while( (index < length) && (i < count) ) {
		FB_PROFILE_RECORD_HEADER *rec = (FB_PROFILE_RECORD_HEADER *)&data[index];
		if( rec->id == FB_PROFILE_RECORD_DATA_ID ) {
			array[i] = (FB_PROFILE_RECORD_DATA*)rec;
			i += 1;
		}
		index += rec->size;
	}
}

static void hProfilerReport (
	FB_PROFILER_CYCLES *prof, FILE *f,
	FB_PROFILE_RECORD_DATA **array, ssize_t count
)
{
	FB_PROFILE_RECORD_DATA *rec;
	char * last_module = NULL;
	ssize_t index;

	if( (prof->global->options & PROFILE_OPTION_HIDE_HEADER) == 0 )
	{
		fprintf( f, "module  function             total             inside         call count\n\n" );
	}

	for( index = 0; index < count; index ++ )
	{
		rec = array[index];
		if( last_module != rec->module_name ) {
			if( last_module != NULL ) {
				fprintf( f, "\n" );
			}
			last_module = rec->module_name;
			fprintf( f, "%s\n\n", rec->module_name );
		}

		fprintf( f, "        %s\n", rec->proc_name );
		fprintf( f, "                " fmtsizet " " fmtsizet " " fmtsizet "\n",
			rec->grand_total,
			rec->internal_total,
			rec->call_count
		);
	}
}

static void hProfilerWriteReport( FB_PROFILER_CYCLES *prof )
{
	char filename[PROFILER_MAX_PATH];
	FILE *f;
	unsigned char *data;
	ssize_t length, count;
	FB_PROFILE_RECORD_DATA **array;

	fb_ProfileGetFileName( filename, PROFILER_MAX_PATH );

	f = fopen( filename, "w" );

	if( (prof->global->options & PROFILE_OPTION_HIDE_HEADER) == 0 )
	{
		fprintf( f, "Cycle Count Profiling results:\n" );
		fprintf( f, "------------------------------\n\n" );

		fb_hGetExeName( filename, PROFILER_MAX_PATH-1 );
		fprintf( f, "Executable name: %s\n", filename );
		fprintf( f, "Launched on: %s\n", prof->global->launch_time );
		fprintf( f, "Total program execution time: %5.4g seconds\n", fb_Timer() - prof->start_time );
	}

	data = (unsigned char *)&__start_fb_profilecycledata[0];
	length = (ssize_t)&__stop_fb_profilecycledata - (ssize_t)&__start_fb_profilecycledata[0];

	count = hProfilerCountProcs( data, length );
	if( count ) {
		array = PROFILER_malloc( sizeof(FB_PROFILE_RECORD_DATA*) * count );
		if( array ) {
			hProfilerBuildArray( array, count, data, length );
			hProfilerSortArray( array, count );
			hProfilerReport( prof, f, array, count );
			PROFILER_free( array );
		}
	}

	fclose( f );
}

/* ************************************
** Cylcles Profing Public API
*/

/*:::::*/
FBCALL void fb_InitProfileCycles( void )
{
	if( fb_profiler ) {
		return;
	}
	fb_profiler = PROFILER_CYCLES_create( );
	if( fb_profiler ) {
		fb_profiler->start_time = fb_Timer();
	}
}

/*:::::*/
FBCALL int fb_EndProfileCycles( int errorlevel )
{
	hProfilerWriteReport( fb_profiler );
	PROFILER_CYCLES_destroy( );
	return errorlevel;
}

/*:::::*/
FBCALL FB_PROFILER_CYCLES *fb_ProfileGetCyclesProfiler()
{
	return fb_profiler;
}
