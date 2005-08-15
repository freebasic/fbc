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
 * io_input.c -- console input functions for Windows console mode apps
 *
 * chng: jun/2005 written [lillo]
 *       aug/2005 modified to read keyboard events [mjs]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

#define KEY_BUFFER_LEN 512
static int key_buffer[KEY_BUFFER_LEN], key_head = 0, key_tail = 0;

/*:::::*/
void fb_hConsolePostKey(int key)
{
    FB_LOCK();

	key_buffer[key_tail] = key;
	if (((key_tail + 1) & (KEY_BUFFER_LEN - 1)) == key_head)
		key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
    key_tail = (key_tail + 1) & (KEY_BUFFER_LEN - 1);

    FB_UNLOCK();
}

/*:::::*/
int fb_hConsoleGetKeyEx(int full, int allow_remove)
{
    int key = -1;

    fb_ConsoleProcessEvents( );

	FB_LOCK();

    if (key_head != key_tail) {
        int do_remove = allow_remove;
        key = key_buffer[key_head];
        if( key > 255 ) {
            if( !full ) {
                key_buffer[key_head] = (key >> 8);
                key = (unsigned) (unsigned char) FB_EXT_CHAR;
                do_remove = FALSE;
            }
        }
        if( do_remove )
            key_head = (key_head + 1) & (KEY_BUFFER_LEN - 1);
	}

	FB_UNLOCK();

	return key;
}

/*:::::*/
int fb_hConsoleGetKey(int full)
{
    return fb_hConsoleGetKeyEx( full, TRUE );
}

/*:::::*/
int fb_hConsolePeekKey(int full)
{
    return fb_hConsoleGetKeyEx( full, FALSE );
}


fb_FnProcessMouseEvent MouseEventHook = (fb_FnProcessMouseEvent) NULL;

/*:::::*/
int fb_ConsoleProcessEvents( void )
{
    int got_event = FALSE;
	INPUT_RECORD ir;
    DWORD dwRead;

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
                    int KeyCode = 0, AddKeyCode = FALSE;
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
                            KeyCode = FB_MAKE_EXT_KEY((char) (wVsCode & 0xFF));
                            AddKeyCode = TRUE;
                        }
                    }
                    else
                    {
                        KeyCode = FB_MAKE_KEY((char) (ir.Event.KeyEvent.uChar.AsciiChar));
                        AddKeyCode = TRUE;
                    }

                    if( AddKeyCode )
                    {
                        fb_hConsolePostKey(KeyCode);
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
