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
 * con_lineinp - console line input function
 *
 * chng: nov/2004 written [v1ctor]
 *       sep/2005 split into two files, file_lineinp.c and con_lineinp.c
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

static const char *pszDefaultQuestion = "? ";

#if defined(TARGET_WIN32) || defined(TARGET_CYGWIN) || defined(TARGET_DOS)

int fb_ConsoleLineInput( FBSTRING *text, void *dst, int dst_len, int fillrem, int addquestion, int addnewline )
{
    FBSTRING *tmp_result;

    FB_LOCK();

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );

    if( text != NULL )
    {
        if( text->data != NULL ) {
            fb_PrintString( 0, text, 0 );
        }

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine();

    if( addnewline ) {
        fb_PrintBufferEx( FB_NEWLINE, sizeof(FB_NEWLINE)-1, 0 );
    }

    if( tmp_result!=NULL ) {
        fb_StrAssign( dst, dst_len, tmp_result, -1, fillrem );
        return fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
}

#else

static char *fb_hDevScrnReadLineWrapper( char *buffer,
                                         size_t count,
                                         FILE *fp )
{
    return fb_ReadString( buffer, count, fp );
}

/*:::::*/
int fb_ConsoleLineInput( FBSTRING *text, void *dst, int dst_len, int fillrem, int addquestion, int addnewline )
{
	int res;
    size_t len;
    int old_x, old_y;

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
    fb_GetXY( &old_x, &old_y );

	FB_LOCK();

    if( text != NULL )
    {
        if( text->data != NULL ) {
            fb_PrintString( 0, text, 0 );
        }

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    {
        /* create temporary string */
        FBSTRING *str_result = fb_StrAllocTempDescZ( NULL );
        DBG_ASSERT(str_result != NULL);

        res = fb_DevFileReadLineDumb( stdin, str_result,
                                      fb_hDevScrnReadLineWrapper );

        len = FB_STRSIZE(str_result);

        /* We have to handle the NEWLINE stuff here because we *REQUIRE*
         * the *COMPLETE* temporary input string for the correct position
         * adjustment. */
        if( !addnewline ) {
            /* This is the easy and dumb method to do the position adjustment.
             * The problem is that it doesn't take TAB's into account. */
            int cols, rows;
            int old_y;

            fb_GetSize( &cols, &rows );
            fb_GetXY( NULL, &old_y );

            old_x += len - 1;
            old_x %= cols;
            old_x += 1;
            old_y -= 1;

            fb_Locate( old_y, old_x, -1 );
        }


        /* add contents of tempporary string to result buffer */
        fb_StrAssign( dst, dst_len, str_result, -1, fillrem );
        /* INFO: temporary string will be deleted during assignment */
    }

	FB_UNLOCK();

    return res;
}

#endif
