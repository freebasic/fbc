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
 * file_lineinput - line input function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

#define BUFFER_LEN 1024

/*:::::*/
static int fb_hFileLineInput( int fnum, FBSTRING *text, void *dst, int dst_len, int fillrem, 
					          int addquestion, int addnewline )
{
	FILE 		*f;
	int			c, len, readlen;
	char		buffer[BUFFER_LEN];
	int			lastcol, cols;

    /* - */
	if( fnum < 0 || fnum > FB_MAX_FILES )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( fnum == 0 )
		f = stdin;
	else
		f = fb_fileTB[fnum-1].f;

	if( f == NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* - */
	if( fnum == 0 )
	{
		if( text != NULL )
		{
			if( text->data != NULL )
				fb_PrintString( 0, text, 0 );

			if( addquestion != FB_FALSE )
			{
				strcpy( buffer, "? " );
				fb_PrintFixString( 0, buffer, 0 );
			}
		}

		if( addnewline == FB_FALSE )
			fb_ConsoleGetXY( &lastcol, NULL );
	}


	/* - */
	readlen = 0;
	do
	{
		if( fb_ReadString( buffer, BUFFER_LEN, f ) == NULL )
		{
		    if( readlen == 0 )
		    {
    			/* del destine string */
				if( dst_len == -1 )
					fb_StrDelete( (FBSTRING *)dst );
				else
					*(char *)dst = '\0';
			}

			break;
		}

		len = strlen( buffer );

		c = buffer[len-1];
		if( (c == 13) || (c == 10) )
		{
			--len;
			if( (c == 10) && (len > 0) )
				if( buffer[len-1] == 13 )
					--len;
		}

		buffer[len] = '\0';

		if( readlen == 0 )
			fb_StrAssign( dst, dst_len, (void *)buffer, 0, fillrem );
		else
			fb_StrConcatAssign( dst, dst_len, (void *)buffer, 0, fillrem );

		readlen += len;

	} while( len == BUFFER_LEN-1 );

	/* - */
	if( fnum == 0 )
		if( addnewline == FB_FALSE )
		{
			fb_ConsoleGetSize( &cols, NULL );
			fb_ConsoleLocate( fb_ConsoleGetY( ) - 1, lastcol + (FB_STRSIZE( dst ) % cols), -1 );
		}


	/* del if temp */
	//if( text != NULL )
		//fb_hStrDelTemp( text );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_FileLineInput( int fnum, void *dst, int dst_len, int fillrem )
{
	int res;

	FB_LOCK();
	res = fb_hFileLineInput( fnum, NULL, dst, dst_len, fillrem, FB_FALSE, FB_FALSE );
	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_LineInput( FBSTRING *text, void *dst, int dst_len, int fillrem, int addquestion, int addnewline )
{
	int res;

	FB_LOCK();
	res = fb_hFileLineInput( 0, text, dst, dst_len, fillrem, addquestion, addnewline );
	FB_UNLOCK();

	return res;
}

