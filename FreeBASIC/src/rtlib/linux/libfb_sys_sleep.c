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
 * sys_sleep.c -- sleep function for Linux
 *
 * chng: nov/2004 written [lillo]
 *
 */

#include "fb.h"

#include <sys/time.h>

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{
	struct timeval tv;

	tv.tv_sec = msecs / 1000;
	tv.tv_usec = (msecs % 1000) * 1000;

	select(0, NULL, NULL, NULL, &tv);
}

