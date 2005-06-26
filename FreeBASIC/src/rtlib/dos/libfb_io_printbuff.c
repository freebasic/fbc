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
 * io_printbuff.c -- low-level print to console function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>
#include <sys/farptr.h>
#include <go32.h>
#include <pc.h>


#define TEXT_ADDR	ScreenPrimary

void (*fb_ConsolePrintBufferProc) (const void *buffer, size_t len, int mask);

/*:::::*/
void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
	fb_ConsolePrintBufferProc(buffer, len, mask);
}

/*:::::*/
void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	fb_ConsolePrintBufferProc(buffer, strlen(buffer), mask);
}

/*:::::*/
void fb_ConsolePrintBufferConioEx(const void * buffer, size_t len, int mask)
{
	int col, row;
	int toprow, botrow;
	int cols, rows;
	int no_scroll = FALSE;
    unsigned short end_char = 0;
    const char *pachText = (const char *) buffer;

	fb_ConsoleGetSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
	fb_ConsoleGetXY( &col, &row );

	/* if no newline and row at bottom and col+string at right, disable scrolling */
	if( (mask & FB_PRINT_NEWLINE) == 0 )
		if( row == botrow )
			if( col + len - 1 == cols )
			{
                --len;
                end_char = (unsigned short) (pachText[len]);
				no_scroll = TRUE;
			}

    fwrite(buffer, len, 1, stdout);
    fflush(stdout);

	if (no_scroll) {
		_farpokew(	_dos_ds,
				TEXT_ADDR + (((wherey() + toprow - 2) * ScreenCols() + wherex() - 1) << 1),
				 (((unsigned short)ScreenAttrib)<< 8) + end_char );
	}

	if (mask & FB_PRINT_NEWLINE) {
		gotoxy(1, wherey()); /* carriage return */
	}

}

/*:::::*/
void fb_ConsolePrintBufferConio(const char * buffer, int mask)
{
    fb_ConsolePrintBufferConioEx(buffer, strlen(buffer), mask);
}

/*:::::*/
void fb_ConsolePrintBufferPrintfEx(const void *buffer, size_t len, int mask)
{
    fwrite(buffer, len, 1, stdout);
    fflush(stdout);
}

/*:::::*/
void fb_ConsolePrintBufferPrintf(const char *buffer, int mask)
{
    fb_ConsolePrintBufferPrintfEx(buffer, strlen(buffer), mask);
}

