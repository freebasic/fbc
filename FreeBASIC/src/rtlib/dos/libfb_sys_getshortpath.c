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
 * sys_getshorpath.c -- get short path for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{

	if( strchr( src, 32 ) == NULL ) {
		strcpy( dst, src );
    } else {
        /* FIXME: SPC is only allowed when using LFNs provided by a Windows
         * environment. So I guess that we have to use the following INT
         * function:
         *
         * IN:
         *
         * AX = 0x7160
         * CL = 0x01
         * CH = SUBST expansion flag, 0x00 = true path for SUBSTed drive letter
         *                            0x80 = SUBSTed drive letter
         * DS:SI = ASCIZ FLN
         * ES:DI = buffer for SFN ( max size = 67 or 128 ??? )
         *
         * OUT:
         *
         * CF = 1 on error
         *      AX = error code
         *
         */
        strncpy( dst, src, maxlen-1 );
        dst[maxlen-1] = 0;
	}

	return dst;
}

