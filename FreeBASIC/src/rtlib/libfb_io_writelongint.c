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
 * io_write.c -- write [#] functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_WriteLongint ( int fnum, long long val, int mask )
{
#ifdef TARGET_WIN32
    FB_WRITENUM( fnum, val, mask, "%I64d" );
#else
    FB_WRITENUM( fnum, val, mask, "%lld" );
#endif
}

/*:::::*/
FBCALL void fb_WriteULongint ( int fnum, unsigned long long val, int mask )
{
#ifdef TARGET_WIN32
    FB_WRITENUM( fnum, val, mask, "%I64u" );
#else
    FB_WRITENUM( fnum, val, mask, "%llu" );
#endif
}
