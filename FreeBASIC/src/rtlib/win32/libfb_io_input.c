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
 * io_mouse.c -- mouse functions for Windows console mode apps
 *
 * chng: jun/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

static FBSTRING fb_strInput = { 0 };
fb_FnProcessMouseEvent MouseEventHook = (fb_FnProcessMouseEvent) NULL;

/*:::::*/
int fb_ConsoleProcessEvents( void )
{
    int got_event = FALSE;
	INPUT_RECORD ir;
    DWORD dwRead;
    FBSTRING *CharBuffer = &fb_strInput;

	if( PeekConsoleInput( fb_in_handle, &ir, 1, &dwRead ) )
	{
		if( dwRead > 0 )
		{
            ReadConsoleInput( fb_in_handle, &ir, 1, &dwRead );

            FB_LOCK();

            switch ( ir.EventType )
            {
            case KEY_EVENT:
                if( ir.Event.KeyEvent.bKeyDown && ir.Event.KeyEvent.wRepeatCount!=0 )
                {
                    char chTemp[3];
                    size_t TempSize = 0;
                    if( ir.Event.KeyEvent.uChar.AsciiChar==0 )
                    {
                        WORD wVkCode = ir.Event.KeyEvent.wVirtualKeyCode;
                        WORD wVsCode = ir.Event.KeyEvent.wVirtualScanCode;
                        int allow_key = ( wVkCode >= VK_SPACE )
                            && ( wVkCode <= VK_NUMLOCK )
                            && ( wVsCode > 0 )
                            && ( wVsCode <= 254 );
                        switch ( wVkCode )
                        {
                        case VK_LWIN:
                        case VK_RWIN:
                        case VK_APPS:
                            allow_key = FALSE;
                            break;
                        }
                        if( allow_key )
                        {
                            chTemp[0] = 2;
                            chTemp[1] = FB_EXT_CHAR;
                            chTemp[2] = (char) (ir.Event.KeyEvent.wVirtualScanCode & 0xFF);
                            TempSize = 3;
                        }
                        else
                        {
                            chTemp[0] = 0;
                        }
                    }
                    else
                    {
                        chTemp[0] = 1;
                        chTemp[1] = ir.Event.KeyEvent.uChar.AsciiChar;
                        TempSize = 2;
                    }

                    if( chTemp[0]!=0 )
                    {
                        size_t ElemSize = FB_CHAR_TO_INT(chTemp[0]) + 1;
                        size_t OldSize, NewSize;

                        FB_STRLOCK();

                        OldSize = FB_STRSIZE( CharBuffer );
                        NewSize = OldSize +
                            ElemSize * ir.Event.KeyEvent.wRepeatCount;

                        CharBuffer = fb_hStrRealloc( CharBuffer,
                                                     NewSize,
                                                     FB_TRUE );

                        if( CharBuffer )
                        {
                            while( ir.Event.KeyEvent.wRepeatCount-- )
                            {
                                memcpy( CharBuffer->data + OldSize,
                                        chTemp,
                                        ElemSize );
                                OldSize += ElemSize;
                            }
                            got_event = TRUE;
                        }

                        FB_STRUNLOCK();
                    }
                }
                break;

            case MOUSE_EVENT:
                if( MouseEventHook != (fb_FnProcessMouseEvent) NULL )
                {
                    MouseEventHook( &ir.Event.MouseEvent );
                    got_event = TRUE;
                }
                break;
            }

            FB_UNLOCK();
		}
    }

	return got_event;
}

/*:::::*/
FBSTRING *fb_ConsoleGetKeyBuffer( void )
{
    fb_ConsoleProcessEvents( );
    return &fb_strInput;
}
