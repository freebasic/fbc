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
 * io_print.c -- print [#] functions
 *
 * chng: oct/2004 written [v1ctor]
 *       nov/2004 fixed scrolling problem if printing at bottom/right w/o a newline [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#ifndef DISABLE_NCURSES
#include <curses.h>
#else
#ifndef FALSE
#define FALSE	0
#endif
#ifndef TRUE
#define TRUE	1
#endif
#endif
#endif


#define FB_PRINTNUM(fnum, val, mask, type) 				\
    char buffer[80];									\
    													\
    if( mask & FB_PRINT_NEWLINE )           			\
    	sprintf( buffer, "% " type "\n", val );       	\
    else if( mask & FB_PRINT_PAD )          			\
    	sprintf( buffer, "% -14" type, val );			\
    else												\
    	sprintf( buffer, "% " type, val );              \
    													\
    if( fnum == 0 )										\
    	fb_PrintBuffer( buffer, mask );					\
    else												\
    	fb_hFilePrintBuffer( fnum, buffer );


/*:::::*/
void fb_ConsolePrintBuffer( char *buffer, int mask )
{
    int col, row;
    int toprow, botrow;
	int cols, rows;
	int len, scrolloff = FALSE;
	int rowsleft, rowstoscroll;

	len = strlen( buffer );

	fb_ConsoleGetSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
	fb_ConsoleGetXY( &col, &row );

#ifdef WIN32
	/* scrolling */
	if( (row > botrow) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
		fb_ConsoleScroll( 1 );
		row = botrow;
	}

	/* if no newline and row at bottom and col+string at right, disable scrolling */
	if( (mask & FB_PRINT_NEWLINE) == 0 )
	{
		if( row == botrow )
			if( col + len - 1 == cols )
				scrolloff = TRUE;
	}

	HANDLE 	hnd;
	DWORD 	mode;

	if( scrolloff )
	{
		hnd = GetStdHandle( STD_OUTPUT_HANDLE );
		GetConsoleMode( hnd, &mode );
		SetConsoleMode( hnd, mode & ~ENABLE_WRAP_AT_EOL_OUTPUT );
	}

	/* scrolling if VIEW was set */
	if( (!scrolloff) && (col + len - 1 > cols) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
    	rowsleft = (botrow - row) /*+ 1*/;
    	rowstoscroll = 1 + (len - (cols - col + 1)) / cols;
    	if( (mask & FB_PRINT_NEWLINE) != 0 )
    		++rowstoscroll;

     	if( rowstoscroll - rowsleft > 0 )
     	{
     		fb_ConsoleScroll( rowstoscroll - rowsleft );
     		fb_ConsoleLocate( botrow - (rowstoscroll - rowsleft), -1, -1 );
     	}
	}
	
	printf( "%s", buffer );

	if( scrolloff )
		SetConsoleMode( hnd, mode );

#else

#ifdef DISABLE_NCURSES
	printf( "%s", buffer );
#else

	/* scrolling */
	if( (row > botrow) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
		row = botrow + 1;
		fb_ConsoleLocate(row, col, -1);
	}

	rowstoscroll = 0;
	if (mask & FB_PRINT_NEWLINE) {
		buffer[len - 1] = '\0';
		len--;
		rowstoscroll++;
	}
	if (col + len - 1 > cols)
		rowstoscroll += 1 + ((len - (cols - col + 1)) / cols);
	if (row + rowstoscroll > fb_ConsoleGetMaxRow()) {
		fb_ConsoleScroll((row + rowstoscroll) - fb_ConsoleGetMaxRow());
		fb_ConsoleLocate(fb_ConsoleGetMaxRow() - rowstoscroll, col, -1);
	}
	else {
		rowsleft = botrow - (row - 1);
		if (rowstoscroll > rowsleft) {
			fb_ConsoleScroll(rowstoscroll - rowsleft);
			fb_ConsoleLocate(botrow - rowstoscroll + 1, col, -1);
		}
	}
	printw("%s", buffer);
	if (mask & FB_PRINT_NEWLINE)
		move(getcury(stdscr) + 1, 0);
	refresh();
#endif

#endif

}

/*:::::*/
FBCALL void fb_PrintVoid ( int fnum, int mask )
{
    char *buffer;
#ifndef WIN32
	char nl[2] = { '\n', '\0' };
#endif

    if( mask & FB_PRINT_NEWLINE )
#ifndef WIN32
		buffer = nl;
#else
    	buffer = "\n";
#endif
    else if( mask & FB_PRINT_PAD )
    	buffer = "%-14";
    else
    	buffer = NULL;

    if( buffer != NULL )
    {
    	if( fnum == 0 )
    		fb_PrintBuffer( buffer, mask );
    	else
    		fb_hFilePrintBuffer( fnum, buffer );
    }
}

/*:::::*/
FBCALL void fb_PrintByte ( int fnum, char val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "d" )
}

/*:::::*/
FBCALL void fb_PrintUByte ( int fnum, unsigned char val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "u" )
}

/*:::::*/
FBCALL void fb_PrintShort ( int fnum, short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "hd" )
}

/*:::::*/
FBCALL void fb_PrintUShort ( int fnum, unsigned short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "hu" )
}

/*:::::*/
FBCALL void fb_PrintInt ( int fnum, int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "d" )
}

/*:::::*/
FBCALL void fb_PrintUInt ( int fnum, unsigned int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "u" )
}

/*:::::*/
FBCALL void fb_PrintSingle ( int fnum, float val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "g" )
}

/*:::::*/
FBCALL void fb_PrintDouble ( int fnum, double val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "lg" )
}


#define BUFFLEN 80*25

/*:::::*/
static void fb_hPrintStr( int fnum, char *s, int len, int mask )
{
    char buffer[BUFFLEN+14+1+1], *p;
    int chars;

    while( len > 0 )
    {
    	if( len > BUFFLEN )
    		chars = BUFFLEN;
    	else
    		chars = len;

    	p = &buffer[0];
    	if( len == chars )
    	{
    		if( mask & FB_PRINT_NEWLINE )
    			sprintf( buffer, "%s\n", s );
    		else if( mask & FB_PRINT_PAD )
    			sprintf( buffer, "%-14s", s );
    		else
    			p = s;
    	}
    	else
    	{
    		strncpy( buffer, s, chars );
    		buffer[chars] = '\0';
    	}


    	if( fnum == 0 )
    		fb_PrintBuffer( p, mask );
    	else
    		fb_hFilePrintBuffer( fnum, p );

    	s += chars;
    	len -= chars;
    }
}


/*:::::*/
FBCALL void fb_PrintString ( int fnum, FBSTRING *s, int mask )
{
    fb_hPrintStr( fnum, s->data, FB_STRSIZE(s), mask );

	/* del if temp */
	fb_hStrDelTemp( s );
}

/*:::::*/
FBCALL void fb_PrintFixString ( int fnum, char *s, int mask )
{
    fb_hPrintStr( fnum, s, strlen( s ), mask );
}
