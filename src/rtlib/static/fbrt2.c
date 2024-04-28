/* FB runtime initialization and cleanup for cycle counting profiler

   We use a global constructor and destructor for this. Where possible they
   should run first/last respectively, such that it's safe for FB programs to
   use the FB runtime from inside its own global ctors/dtors. */

/* WIP */
/* TODO: update src/compiler/rtl-system.bas:rtlInitProfile */
/* TODO: test exit code, profiler clean-up should still run
**       even when compiled exe does not encounter fb_End() */
/* TODO: organize this code by only having start-up code here
**       and the test in src/rtlib/profile-cycles.c */
/* TODO: share reporting code with src/rtlib/profile.c */
/* TODO: add a report option for binary output */

#include "../fb.h"

#ifdef HOST_WIN32
	#include <windows.h>
#endif

FBCALL void fb_InitProfileCycles( void );
FBCALL int fb_EndProfileCycles( int errorlevel );

/* note: they must be static, or shared libraries in Linux would reuse the 
		 same function */

#if defined(HOST_DARWIN) || defined(HOST_ANDROID)
	/* It seems like __attribute__((constructor(priority))) (or in general, ordering
	   ctors/dtors across modules) isn't supported on Darwin/MacOSX, so we just use
	   plain __attribute__((constructor)). */
	__attribute__((constructor)) static void fb_hDoInit( void )
	{
		fb_hRtInit( );
		fb_InitProfileGas64();
	}

	__attribute__((destructor)) static void fb_hDoExit( void )
	{
		fb_EndProfileGas64(0);
		fb_hRtExit( );
	}
#else
	static void fb_hDoInit( void )
	{
		fb_hRtInit( );
		fb_InitProfileCycles();
	}

	static void fb_hDoExit( void )
	{
		fb_EndProfileCycles(0);
		fb_hRtExit( );
	}

	/* This puts the init/exit global ctor/dtor for the rtlib in the sorted
	   ctors/dtors section. A named section of .?tors.65435 = Priority(100).
	   (65535 - 100 = 65435)

	   This is what __attribute__((constructor(100))) would do; but that would also
	   trigger a gcc warning, because priorities 0..100 are "reserved for the
	   implementation", so we can't use that.

	   GCC on GNU/Linux seems to use .init_array.<0-padded priority> to implement
	    __attribute__((constructor(priority))) now (instead of
	   .ctors.<65535 - priority>), but .ctors.* still works, so it's probably ok to
	   keep using it. */
	static void * priorityhDoInit __attribute__((section(".ctors.65435"), used)) = fb_hDoInit;
	static void * priorityhDoExit __attribute__((section(".dtors.65435"), used)) = fb_hDoExit;
#endif

extern int __start_fb_profilecycledata;
extern int __stop_fb_profilecycledata;

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

/* make sure there is at least one record in the profile data section */
static FB_PROFILE_RECORD_VERSION prof_data_version __attribute__((section("fb_profilecycledata"), used)) =
	{
		sizeof( FB_PROFILE_RECORD_VERSION ), 
		FB_PROFILE_RECORD_VERSION_ID,
		FB_PROFILE_VERSION, 0 
	};

#if 0
static hProfilerReportBinary( )
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
	FILE *f,
	FB_PROFILE_RECORD_DATA **array, ssize_t count
)
{
	FB_PROFILE_RECORD_DATA *rec;
	char * last_module = NULL; 
	ssize_t index;
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
		fprintf( f, "                %18zu %18zu %18zu %18zu %18zu\n",
			rec->init0, 
			rec->grand_total, 
			rec->reinit, 
			rec->internal_total, 
			rec->call_count 
		);
	}
}

/* ************************************
** Public API
*/

FBCALL void fb_InitProfileCycles( void )
{
}

FBCALL int fb_EndProfileCycles( int errorlevel )
{
	FILE *f;
	unsigned char *data;
	ssize_t length, count;
	FB_PROFILE_RECORD_DATA **array;

	data = (unsigned char *)&__start_fb_profilecycledata;
	length = (ssize_t)&__stop_fb_profilecycledata - (ssize_t)&__start_fb_profilecycledata;

	f = fopen( "profilecycles.txt", "w" );

	count = hProfilerCountProcs( data, length );
	if( count ) {
		array = malloc( sizeof(FB_PROFILE_RECORD_DATA*) * count );
		if( array ) {
			hProfilerBuildArray( array, count, data, length );
			hProfilerSortArray( array, count );
			hProfilerReport( f, array, count );
			free( array );
		}
	}

	fclose( f ); 

	return 0;
}
