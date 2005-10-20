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
 * con_print_tty.c -- print wide text data - using TTY (teletype) interpretation
 *
 * chng: sep/2005 written [mjs]
 *
 */

#include <string.h>
#include "fb_con.h"

#define OUTPUT_BUFFER_SIZE 256

void fb_ConPrintTTYWstr( fb_ConHooks *handle,
                     	 const FB_WCHAR *pachText,
                     	 size_t TextLength,
                     	 int is_text_mode )
{
    static const FB_WCHAR achTabSpaces[8] = { 32, 32, 32, 32, 32, 32, 32, 32 };
    FB_WCHAR OutputBuffer[OUTPUT_BUFFER_SIZE];
    size_t OutputBufferLength = 0;
    fb_Rect *pBorder = &handle->Border;
    fb_Coord *pCoord = &handle->Coord;

    fb_Coord dwCurrentCoord;
    size_t IndexText;
    int fGotNewCoordinate = FALSE;
    int BorderWidth = pBorder->Right - pBorder->Left + 1;

    memcpy( &dwCurrentCoord, pCoord, sizeof( fb_Coord ) );

    for( IndexText=0; IndexText!=TextLength; ++IndexText )
    {
        const FB_WCHAR *pachOutputData = pachText + IndexText;
        size_t OutputDataLength = 0;
        int fDoFlush = FALSE;
        int fSetNewCoord = FALSE;
        fb_Coord dwMoveCoord;

        switch ( *pachOutputData )
        {
        case _LC('\a'):
            /* ALARM */
            fb_Beep();
            break;

        case _LC('\b'):
            /* BACKSPACE */
            fSetNewCoord = TRUE;
            if( dwCurrentCoord.X > pBorder->Left ) {
                dwMoveCoord.X = -1;
            } else {
                dwMoveCoord.X = 0;
            }
            dwMoveCoord.Y = 0;
            break;

        case _LC('\n'):
            /* LINE FEED / NEW LINE */
            fSetNewCoord = TRUE;
            if( is_text_mode ) {
                dwMoveCoord.X = pBorder->Left - dwCurrentCoord.X;
                dwMoveCoord.Y = 1;
            } else {
                dwMoveCoord.X = 0;
                dwMoveCoord.Y = 1;
            }
            break;

        case _LC('\r'):
            /* CARRIAGE RETURN */
            fSetNewCoord = TRUE;
            dwMoveCoord.X = pBorder->Left - dwCurrentCoord.X;
            dwMoveCoord.Y = 0;
            break;

        case _LC('\t'):
            /* TAB */
            pachOutputData = achTabSpaces;
            OutputDataLength = ((dwCurrentCoord.X - pBorder->Left + 8) & ~7) - (dwCurrentCoord.X - pBorder->Left);
            break;

        default:
            OutputDataLength = 1;
            break;
        }

        if( OutputDataLength + OutputBufferLength > OUTPUT_BUFFER_SIZE ) {
            fDoFlush = TRUE;
        } else if( fSetNewCoord ) {
            fDoFlush = TRUE;
        }

        if( fDoFlush ) {
            fDoFlush = FALSE;
            if( OutputBufferLength!=0 ) {
                fb_ConPrintRawWstr( handle,
                                	OutputBuffer,
                                	OutputBufferLength );
                OutputBufferLength = 0;
                fGotNewCoordinate = FALSE;
            }
        }

        if( fSetNewCoord ) {
            fSetNewCoord = FALSE;
            pCoord->X += dwMoveCoord.X;
            pCoord->Y += dwMoveCoord.Y;
            memcpy( &dwCurrentCoord, pCoord, sizeof( fb_Coord ) );
            fGotNewCoordinate = TRUE;
        }

        if( OutputDataLength!=0 ) {
            dwCurrentCoord.X += OutputDataLength;
            if( dwCurrentCoord.X > pBorder->Right ) {
                int NormalX = dwCurrentCoord.X - pBorder->Left;
                dwCurrentCoord.X = (NormalX % BorderWidth) + pBorder->Left;
                dwCurrentCoord.Y += NormalX / BorderWidth;
            }
            while( OutputDataLength-- ) {
                OutputBuffer[OutputBufferLength++] = *pachOutputData++;
            }
        }
    }

    if( OutputBufferLength!=0 ) {
        fb_ConPrintRawWstr( handle,
                        	OutputBuffer,
                        	OutputBufferLength );
    } else if( fGotNewCoordinate ) {
        fb_hConCheckScroll( handle );
    }
}
