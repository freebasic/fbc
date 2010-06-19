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
 * file_attr.c -- file open mode and attribs
 *
 * chng: jun/2006 written [DrV]
 *
 */

#include "fb.h"

static int file_mode_map[] = { FB_FILE_ATTR_MODE_BINARY,   /* FB_FILE_MODE_BINARY = 0 */
	                           FB_FILE_ATTR_MODE_RANDOM,   /* FB_FILE_MODE_RANDOM = 1 */
    	                       FB_FILE_ATTR_MODE_INPUT,    /* FB_FILE_MODE_INPUT  = 2 */
    	                       FB_FILE_ATTR_MODE_OUTPUT,   /* FB_FILE_MODE_OUTPUT = 3 */
    	                       FB_FILE_ATTR_MODE_APPEND }; /* FB_FILE_MODE_APPEND = 4 */

FBCALL int fb_FileAttr 
	( 
		int handle, 
		int returntype 
	)
{
	int ret = 0;
	int err = 0;
	FB_FILE *file;
	
	file = FB_FILE_TO_HANDLE( handle );
	
	if ( !file ) 
	{
		ret = 0;
		err = FB_RTERROR_ILLEGALFUNCTIONCALL;
	} 
	else 
	{
		switch ( returntype )
		{
		case FB_FILE_ATTR_MODE:
			ret = file_mode_map[file->mode];
			err = FB_RTERROR_OK;
			break;
			
/* FB_FILE_ATTR_HANDLE only enabled on x86 for now due to return value size issues */
#ifdef TARGET_X86


		case FB_FILE_ATTR_HANDLE:

      /* TODO: standardize the DEV_* structs, or provide a device hook function to get OS handle */

			if( file->type == FB_FILE_TYPE_PRINTER )
			{
				if( file->opaque )
				{
#if (defined(TARGET_WIN32) || defined(TARGET_CYGWIN))
					if( *((int*)file->opaque) ) /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					{
					  ret = **((int**)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					  err = FB_RTERROR_OK;
					}
#else
					ret = *((int*)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					err = FB_RTERROR_OK;
#endif
				}
			}
			else if( file->type == FB_FILE_TYPE_SERIAL )
			{
				if( file->opaque )
				{
					if( *((int*)file->opaque) ) /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					{
					  ret = **((int**)file->opaque); /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
					  err = FB_RTERROR_OK;
					}
				}
			}
			else
			{
				ret = (int)file->opaque; /* WARNING: unsafe when sizeof(void *) > sizeof(int) */
				err = FB_RTERROR_OK;
			}
			break;
#endif
				
		case FB_FILE_ATTR_ENCODING:
			ret = file->encod;
			err = FB_RTERROR_OK;
			break;
				
		default:
			ret = 0;
			err = FB_RTERROR_ILLEGALFUNCTIONCALL; 
			break;
		}
	}
	
	fb_ErrorSetNum( err );
	
	return ret;
	
}
