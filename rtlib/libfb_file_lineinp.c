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
#if !defined WIN32 && !defined DISABLE_NCURSES
#include <curses.h>
#endif

#define BUFFER_LEN 1024

/*:::::*/
static int fb_hFileLineInput( int fnum, FBSTRING *text, FBSTRING *dst,
					          int addquestion, int addnewline )
{
	FILE 		*f;
	int			c, len;
	FBSTRING	tmp = { 0 };
	char		buffer[BUFFER_LEN+1];
	int			lastcol, cols;

    /* - */
	if( fnum < 0 || fnum > FB_MAX_FILES )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if( fnum == 0 )
		f = stdin;
	else
		f = fb_fileTB[fnum-1].f;

	if( f == NULL )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

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
	fb_StrDelete( dst );

	/* - */
	do
	{
#if !defined WIN32 && !defined DISABLE_NCURSES
		if( fnum == 0 ) {
			echo();
			nodelay(stdscr, FALSE);
			if( getnstr( buffer, BUFFER_LEN ) == ERR )
				break;
			noecho();
			nodelay(stdscr, TRUE);
			strcat(buffer, "\n");
		}
		else
#endif
		if( fgets( buffer, BUFFER_LEN, f ) == NULL )
			break;

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

		fb_StrConcat( &tmp, (void *)dst, -1, (void *)buffer, len );
		fb_StrAssign( (void *)dst, -1, (void *)&tmp, -1 );

	} while( len == BUFFER_LEN );

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

	return FB_RTERROR_OK;
}

/*:::::*/
FBCALL int fb_FileLineInput( int fnum, FBSTRING *dst )
{

	return fb_hFileLineInput( fnum, NULL, dst, FB_FALSE, FB_FALSE );

}

/*:::::*/
FBCALL int fb_LineInput( FBSTRING *text, FBSTRING *dst, int addquestion, int addnewline )
{

	return fb_hFileLineInput( 0, text, dst, addquestion, addnewline );

}

