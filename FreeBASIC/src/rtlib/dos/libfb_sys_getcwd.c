/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * sys_getcwd.c -- get current dir for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

#include <unistd.h>

/*:::::*/
int fb_hGetCurrentDir ( char *dst, int maxlen )
{

    int len, i;
    if ( getcwd( dst, maxlen ) != NULL ) {
        len = strlen( dst );
        /* Always return path with native path separator (backslash).
         * Returning a slash might break compatibility with older sources.
         */
        for (i=0; i!=len; ++i)
            if (dst[i]='/')
                dst[i]='\\';
        return len;
    }
    return 0;

}

