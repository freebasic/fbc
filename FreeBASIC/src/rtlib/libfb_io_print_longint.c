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
 * io_print_longint.c -- print [#] function (longint)
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_PrintLongint ( int fnum, long long val, int mask )
{
#ifdef WIN32
    FB_PRINTNUM( fnum, val, mask, "% ", "I64d" );
#else
	FB_PRINTNUM( fnum, val, mask, "% ", "lld" );
#endif
}

/*:::::*/
FBCALL void fb_PrintULongint ( int fnum, unsigned long long val, int mask )
{
#ifdef WIN32
	FB_PRINTNUM( fnum, val, mask, "%", "I64u" );
#else
    FB_PRINTNUM( fnum, val, mask, "%", "llu" );
#endif
}
