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
 * io_spc.c -- spc and tab functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
__stdcall void fb_PrintTab( int fnum, int newcol )
{
	int col, row, cols, rows;

	if( fnum == 0 )
	{
		fb_ConsoleGetXY( &col, &row );
		fb_ConsoleGetSize( &cols, &rows );

    	if( newcol > cols )
    		newcol %= cols;

		if( col > newcol )
			fb_Locate( row+1, newcol );

	    else if( newcol < 1 )
    		fb_Locate( -1, 1 );

    	else
    		fb_Locate( -1, newcol );
    }
}


/*:::::*/
__stdcall void fb_PrintSPC( int fnum, int n )
{
	int col, row, cols, rows, newcol;

	if( fnum == 0 )
	{
		if( n == 0 )
			return;

		fb_ConsoleGetXY( &col, &row );
		fb_ConsoleGetSize( &cols, &rows );

    	newcol = col + n;
    	if( newcol > cols )
    		newcol %= cols;

		fb_Locate( -1, newcol );
	}
}

