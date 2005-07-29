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
 * math_rnd.c -- rnd# function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL double fb_Rnd ( int n )
{
	static double last_num;

	if( n == 0 )
		return last_num;

    /* return between 0 and 1 (but never 1) */
	last_num = (double)rand( ) * (1.0 / ((double)RAND_MAX+1.0));

	return last_num;
}


/*:::::*/
FBCALL void fb_Randomize ( double seed )
{

	if( seed == -1.0 )
		seed = fb_Timer( );

	srand( (int)seed );

	rand( );

}
