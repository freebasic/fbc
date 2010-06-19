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
 * file_copy.c -- generic C stdio file copy
 *
 * chng: jun/2006 written [DrV]
 *
 */
 
#define FILE_COPY_BUF_SIZE 512

#include <stdio.h>
#include "fb.h"

/*:::::*/
int fb_DrvFileCopy( const char *source, const char *destination )
{
	FILE *src, *dst = NULL;
	long len;
	size_t bytes_to_copy;
	char buf[FILE_COPY_BUF_SIZE];
	
	src = fopen(source, "rb");
	
	if (!src)
		goto err;
	
	fseek(src, 0, SEEK_END);
	len = ftell(src);
	fseek(src, 0, SEEK_SET);
	
	dst = fopen(destination, "wb");
	
	if (!dst)
		goto err;
	
	while (len > 0) {
		if (len >= FILE_COPY_BUF_SIZE)
			bytes_to_copy = FILE_COPY_BUF_SIZE;
		else
			bytes_to_copy = len;
		
		if (fread( buf, 1, bytes_to_copy, src ) != bytes_to_copy)
			goto err;
		
		if (fwrite( buf, 1, bytes_to_copy, dst ) != bytes_to_copy)
			goto err;
		
		len -= bytes_to_copy;
	}
	
	fclose( src );
	fclose( dst );
	
	return fb_ErrorSetNum( FB_RTERROR_OK );
	
err:
	
	if (src) fclose( src );
	if (dst) fclose( dst );
	
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	
}
