/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * file_datetime.c -- get file date/time by filename
 *
 * chng: jul/2006 written [v1ctor]
 *
 */

#include "fb.h"

#include <time.h>
#include <sys/stat.h>

#ifdef TARGET_WIN32
#define stat _stat
#endif

/*:::::*/
FBCALL double fb_FileDateTime 
	( 
		const char *filename 
	)
{
	struct stat buf;
	struct tm *tm;
	
	if( stat( filename, &buf ) != 0 )
		return 0.0;
		
	tm = localtime( &buf.st_mtime );
	
	return fb_DateSerial( 1900 + tm->tm_year, 1+tm->tm_mon, tm->tm_mday ) +
		   fb_TimeSerial( tm->tm_hour, tm->tm_min, tm->tm_sec );
}
