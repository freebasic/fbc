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
 * io_printbuff.c -- low-level print to console function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"
#include <conio.h>
#include <string.h>
#include <malloc.h>
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
    const char *pFoundLF, *pLast = pachText;

	fb_ConsoleGetSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
	fb_ConsoleGetXY( &col, &row );

	/* if no newline and row at bottom and col+string at right, disable scrolling */
	if( (mask & FB_PRINT_NEWLINE) == 0 )
		if( row == botrow )
			if( col + len - 1 == cols )
			{
                end_char = ((unsigned char *)buffer)[len - 1];
                if (end_char >= 32 ) {
                    /* WARNING: This might destroy a constant string */
                    ((unsigned char *)buffer)[len - 1] = '\0';
                    no_scroll = TRUE;
                    --len;
                }
			}

    /* s/o means that we can only use cputs ... too bad ... so we've
     * to scan for LF and (optionally) insert a CR ourselves */
    pFoundLF = (const char *) memchr( pLast, '\n', len );
    while (pFoundLF!=NULL) {
        int tmp_len = pFoundLF - pLast;
        int has_cr = ((tmp_len > 0) ? (*(pFoundLF-1)=='\r') : FALSE);
        char *tmp_buffer = alloca(tmp_len + 3);
        memcpy(tmp_buffer, pLast, tmp_len);
        if( !has_cr ) {
            memcpy(tmp_buffer + tmp_len, "\r\n", 3);
        } else {
            memcpy(tmp_buffer + tmp_len, "\n", 2);
        }
        cputs( tmp_buffer );
        pLast = pFoundLF + 1;
        pFoundLF = (const char *) memchr( pLast, '\n', len );
    }
    cputs( pLast );

	if (no_scroll) {
		_farpokew(	_dos_ds,
                    TEXT_ADDR + (((wherey() + toprow - 2) * ScreenCols() + wherex() - 1) << 1),
                    (((unsigned short)ScreenAttrib)<< 8) + end_char );
        /* Restore the previously destroyed constant string */
        ((unsigned char *)buffer)[len] = end_char;
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

