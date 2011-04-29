/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
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

static const char *pszDefaultQuestion = "? ";

#if defined(TARGET_WIN32) || defined(TARGET_CYGWIN) || defined(TARGET_DOS) || defined(TARGET_LINUX)

int fb_ConsoleLineInput( FBSTRING *text, void *dst, int dst_len, int fillrem,
						 int addquestion, int addnewline )
{
    FBSTRING *tmp_result;

    FB_LOCK();

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );

    if( text != NULL )
    {
        if( text->data != NULL )
        {
            fb_PrintString( 0, text, 0 );
        }
    	/* del if temp */
    	else
    	{
    		fb_hStrDelTemp( text );
    	}

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    FB_UNLOCK();

    tmp_result = fb_ConReadLine( FALSE );

    if( addnewline ) {
				fb_PrintVoid( 0, FB_PRINT_NEWLINE );
    }

    if( tmp_result!=NULL ) {
        fb_StrAssign( dst, dst_len, tmp_result, -1, fillrem );
        return fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
}

#else

static char *hWrapper( char *buffer,
                                         size_t count,
                                         FILE *fp )
{
    return fb_ReadString( buffer, count, fp );
}

/*:::::*/
int fb_ConsoleLineInput( FBSTRING *text, void *dst, int dst_len, int fillrem,
						 int addquestion, int addnewline )
{
	int res;
    size_t len;
    int old_x, old_y;

    fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
    fb_GetXY( &old_x, &old_y );

	FB_LOCK();

    if( text != NULL )
    {
        if( text->data != NULL )
        {
            fb_PrintString( 0, text, 0 );
        }
    	/* del if temp */
    	else
    	{
    		fb_hStrDelTemp( text );
    	}

        if( addquestion != FB_FALSE )
        {
            fb_PrintFixString( 0, pszDefaultQuestion, 0 );
        }
    }

    {
        /* create temporary string */
        FBSTRING str_result = { 0 };

        res = fb_DevFileReadLineDumb( stdin, &str_result, hWrapper );

        len = FB_STRSIZE(&str_result);

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

            fb_Locate( old_y, old_x, -1, 0, 0 );
        }


        /* add contents of tempporary string to result buffer */
        fb_StrAssign( dst, dst_len, (void *)&str_result, -1, fillrem );

        fb_StrDelete( &str_result );

    }

	FB_UNLOCK();

    return res;
}

#endif
