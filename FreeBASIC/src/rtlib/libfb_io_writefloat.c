/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * io_write.c -- write [#] functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WriteSingle ( int fnum, float val, int mask )
{
	char buffer[8+1+8+1+2];

	fb_hFloat2Str( (double)val, buffer, 7, 0 );

	if( mask & FB_PRINT_BIN_NEWLINE )
    	strcat( buffer, FB_BINARY_NEWLINE );
	else if( mask & FB_PRINT_NEWLINE )
    	strcat( buffer, FB_NEWLINE );
	else
    	strcat( buffer, "," );

	fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE( fnum ), buffer, strlen( buffer ) );

}

/*:::::*/
FBCALL void fb_WriteDouble ( int fnum, double val, int mask )
{
	char buffer[16+1+8+1];

	fb_hFloat2Str( val, buffer, 16, 0 );

	if( mask & FB_PRINT_BIN_NEWLINE )
    	strcat( buffer, FB_BINARY_NEWLINE );
	else if( mask & FB_PRINT_NEWLINE )
    	strcat( buffer, FB_NEWLINE );
	else
    	strcat( buffer, "," );

	fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE( fnum ), buffer, strlen( buffer ) );
}
