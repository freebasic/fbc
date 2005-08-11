/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
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
 */

/*
 *	dev_lpt - LPTx device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_DevLptTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{
    size_t i;

    if( strcasecmp(filename, "PRN:")==0 )
        return TRUE;

    if( filename_len < 5 )
        return FALSE;
    if( strncasecmp(filename, "LPT", 3)!=0 )
        return FALSE;
    if( filename[filename_len-1]!=':' )
        return FALSE;

    for( i = 3;
         i != (filename_len-1);
         ++i )
    {
        char ch = filename[i];
        if( ch<'0' || ch>'9')
            return FALSE;
    }

    return TRUE;
}

