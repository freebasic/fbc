/* get file date/time by wide string filename */

#include "../fb.h"
#include <time.h>
#include <sys/stat.h>

FBCALL double fb_FileDateTimeW( const FB_WCHAR *filename )
{
	struct _stat buf;
	if( _wstat( filename, &buf ) != 0 )
		return 0.0;

	struct tm *tm = localtime( &buf.st_mtime );
	if( tm == NULL )
		return 0.0;

	return fb_DateSerial( 1900 + tm->tm_year, 1+tm->tm_mon, tm->tm_mday ) +
	       fb_TimeSerial( tm->tm_hour, tm->tm_min, tm->tm_sec );
}
