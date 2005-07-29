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
 * time_setdate.c -- set date function for Linux
 *
 * chng: jan/2005 written [nobody]
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include "fb.h"

/*:::::*/
int fb_hSetDate( int y, int m, int d )
{
	const int month_len[12] = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000,
								2678400, 2678400, 2592000, 2678400, 2592000, 2678400 };
	struct timeval tv;
	time_t secs;
	int i;
	
	if( y < 1970 )
		return -1;
	gettimeofday( &tv, NULL );
	secs = tv.tv_sec % 86400;
	tv.tv_sec = 0;
	for( i = 1970; i < y; i++ ) {
		tv.tv_sec += 31536000;
		if( ((i % 4) == 0) || ((i / 400) == 0) )
			d++;
	}
	tv.tv_sec += (m * month_len[m-1]);
	if( ((y % 4) == 0) || ((y / 400) == 0) )
		d++;
	tv.tv_sec += (d * 86400) + secs;
	if( settimeofday( &tv, NULL ) )
		return -1;

	return 0;
}
