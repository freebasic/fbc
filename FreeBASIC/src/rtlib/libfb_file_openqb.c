/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2007 The FreeBASIC development team.
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
 * file_openqb - QB compatible OPEN
 *
 * chng: dec/2006 written [cha0s]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenQB
	(
		FBSTRING *str,
		unsigned int mode,
		unsigned int access,
		unsigned int lock,
		int fnum,
		int len
	)
{
	
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	int str_len = FB_STRSIZE( str );
	
	if( !str_len || !str->data )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );		
		
	// qb borks if first char is a space
	if( str->data[0] == ' ' )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	
	int device = 0;
	/* 0 = filename
	   1 = cons
	   2 = com
	   3 = lpt
	   4 = scrn */
	
	// handy, all devices are 4 chars + colon...	
	if( str_len > 4 ) {

		if( (str->data[0] == 'c') || (str->data[0] == 'C') )
			if( (str->data[1] == 'o') || (str->data[1] == 'O') )
				if( (str->data[2] == 'n') || (str->data[2] == 'N') )
					if( (str->data[3] == 's') || (str->data[3] == 'S') )
						if( (str->data[4] == ':') )
							device = 1;

		if( (str->data[0] == 'c') || (str->data[0] == 'C') )
			if( (str->data[1] == 'o') || (str->data[1] == 'O') )
				if( (str->data[2] == 'm') || (str->data[2] == 'M') )
					if( (str->data[4] == ':') )
						device = 2;

		if( (str->data[0] == 'l') || (str->data[0] == 'L') )
			if( (str->data[1] == 'p') || (str->data[1] == 'P') )
				if( (str->data[2] == 't') || (str->data[2] == 'T') )
					if( (str->data[4] == ':') )
						device = 3;

		if( (str->data[0] == 's') || (str->data[0] == 'S') )
			if( (str->data[1] == 'c') || (str->data[1] == 'C') )
				if( (str->data[2] == 'r') || (str->data[2] == 'R') )
					if( (str->data[3] == 'n') || (str->data[3] == 'N') )
						if( (str->data[4] == ':') )
							device = 4;

	}
	
	switch(device) {
	
		case 0:
			return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
		case 1:
		    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
		                             str,
		                             mode,
		                             access,
		                             lock,
		                             len,
		                             FB_FILE_ENCOD_ASCII,
		                             fb_DevConsOpen );
		case 2:
		    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
		                             str,
		                             mode,
		                             access,
		                             lock,
		                             len,
		                             FB_FILE_ENCOD_ASCII,
		                             fb_DevComOpen );
		case 3:
		    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
		                             str,
		                             mode,
		                             access,
		                             lock,
		                             len,
		                             FB_FILE_ENCOD_ASCII,
		                             fb_DevLptOpen );
		case 4:
		
		    fb_DevScrnInit( );
		
		    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
		                             str,
		                             mode,
		                             access,
		                             lock,
		                             len,
		                             FB_FILE_ENCOD_ASCII,
		                             fb_DevScrnOpen );
	}
			
}

