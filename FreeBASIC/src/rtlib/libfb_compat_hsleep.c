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
 * compat_hsleep.c -- Redirects calls to fb_hSleep to fb_Delay
 *
 * chng: oct/2005 written [mjs]
 *
 */

#include "fb.h"

/* This is a very bad quirk to keep compatibility with older sources that
 * rely on this function. However, this function was meant to be a HELPER
 * function and should never be used outside this library ...
 */
void fb_hSleep ( int msecs )
{
    fb_Delay( msecs );
}

