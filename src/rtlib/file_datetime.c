/* get file date/time by filename */

#include "fb.h"
#include <time.h>
#include <sys/stat.h>

FBCALL double fb_FileDateTime( const char *filename )
{
#ifdef HOST_MINGW
	struct _stat buf;
	if( _stat( filename, &buf ) != 0 )
#else
	struct stat buf;
	if( stat( filename, &buf ) != 0 )
#endif
		return 0.0;

	struct tm *tm = localtime( &buf.st_mtime );
	if( tm == NULL )
		return 0.0;

	return fb_DateSerial( 1900 + tm->tm_year, 1+tm->tm_mon, tm->tm_mday ) +
	       fb_TimeSerial( tm->tm_hour, tm->tm_min, tm->tm_sec );
}
