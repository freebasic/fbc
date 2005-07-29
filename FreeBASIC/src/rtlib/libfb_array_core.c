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
 * array_core.c -- dynamic arrays core
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"

/*:::::*/
int fb_hArrayCalcElements( int dimensions, const int *lboundTB, const int *uboundTB )
{
	int i;
	int elements;

    elements = (uboundTB[0] - lboundTB[0]) + 1;
    for( i = 1; i < dimensions; i++ )
    	elements *= (uboundTB[i] - lboundTB[i]) + 1;

    return elements;
}

/*:::::*/
int fb_hArrayCalcDiff( int dimensions, const int *lboundTB, const int *uboundTB )
{
	int i;
	int elements;
	int diff = 0;

	if( dimensions <= 0 )
		return 0;

    for( i = 0; i < dimensions-1; i++ )
    {
    	elements = (uboundTB[i+1] - lboundTB[i+1]) + 1;
    	diff = (diff + lboundTB[i]) * elements;
    }

	diff += lboundTB[dimensions-1];

	return -diff;
}


