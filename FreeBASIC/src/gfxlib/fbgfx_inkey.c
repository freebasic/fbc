/*
 *  By Sterling Christensen (sterling@engineer.com)
 *  Based on code Copyright (C) 2004 by Marzec
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

#include "QB_gfx_main.h"

#define QBK_F1      0xFF3B
#define QBK_F2      QBK_F1 + 1
#define QBK_F3      QBK_F1 + 2
#define QBK_F4      QBK_F1 + 3
#define QBK_F5      QBK_F1 + 4
#define QBK_F6      QBK_F1 + 5
#define QBK_F7      QBK_F1 + 6
#define QBK_F8      QBK_F1 + 7
#define QBK_F9      QBK_F1 + 8
#define QBK_F10     QBK_F1 + 9
#define QBK_F11     0xFF85
#define QBK_F12     QBK_F11 + 1
#define QBK_DELETE  0xFF53
#define QBK_INSERT  0xFF52
#define QBK_HOME    0xFF47
#define QBK_END     0xFF4F
#define QBK_PUP     0xFF49
#define QBK_PDOWN   0xFF51
#define QBK_UP      0xFF48
#define QBK_DOWN    0xFF50
#define QBK_LEFT    0xFF4B
#define QBK_RIGHT   0xFF4D

static const Uint16 SdlKToQbK[SDLK_F12 - SDLK_KP0 + 1] = 
{
    /* SDLK_KP0-9 */
    QBK_INSERT,
    QBK_END,   QBK_DOWN,  QBK_PDOWN,
    QBK_LEFT,  0,         QBK_RIGHT,
    QBK_HOME,  QBK_UP,    QBK_PUP,
    
    QBK_DELETE, '/', '*', '-', '+', 13, '=',
    
    QBK_UP, QBK_DOWN, QBK_RIGHT, QBK_LEFT,
    QBK_INSERT, QBK_HOME, QBK_END, QBK_PUP, QBK_PDOWN,
    
    QBK_F1, QBK_F2, QBK_F3, QBK_F4, QBK_F5,
    QBK_F6, QBK_F7, QBK_F8, QBK_F9, QBK_F10,
    QBK_F11, QBK_F12
};

/* Sets what type of events Inkey/InkeyEx removes from the queue
   Default is SDL_ALLEVENTS
   Takes an int in the same format as SDL_PeepEvents */
FBCALL void fb_GfxSetEventMask (int mask)
{
    fb_GfxInfo.eventMask = mask;
}

/*------------------------------------------------------------------------------
    fb_GfxInkey()
    desc: returns the first key within the keyqueue or "" if no key is in there
------------------------------------------------------------------------------*/
FBSTRING* fb_GfxInkey (void)
{
	FBSTRING *ret;
    int ikey;

    ikey = fb_GfxInkeyEx();

    if (ikey == 0) return &fb_strNullDesc;

    if ((ikey & 0xFF00) != 0xFF00) return fb_CHR(ikey);

    if (ikey == -1)
    {
        ret = (FBSTRING *)fb_hStrAllocTmpDesc();
        fb_hStrAllocTemp(ret, 4);
        ret->data[0] = 'Q';
        ret->data[1] = 'U';
        ret->data[2] = 'I';
        ret->data[3] = 'T';
        ret->data[4] = '\0';
        return ret;
    }

//    if ((ikey & 0xFF00) == 0xFF00)
//    {
//        return fb_MKI(0xFF + ((unsigned char)ikey << 8));
        ret = (FBSTRING *)fb_hStrAllocTmpDesc();
        fb_hStrAllocTemp(ret, 2);
        ret->data[0] = 0xFF;
        ret->data[1] = (char)ikey;
        ret->data[2] = '\0';
        return ret;
//    }

}

int fb_GfxGetKey (void)
{
    int k;
    
    do
    {
        SDL_WaitEvent(NULL);
        k = fb_GfxInkeyEx();
    }
    while (k == 0);
    
    return k;
}

int fb_GfxInkeyEx(void)
{
    int n;
    SDL_Event event;

    SDL_PumpEvents();

    do
    {
        n = SDL_PeepEvents(&event, 1, SDL_GETEVENT, fb_GfxInfo.eventMask);
        if (n < 1) return 0;

        if (event.key.type == SDL_QUIT) return -1;
    }
    while (event.key.type != SDL_KEYDOWN);

    n = event.key.keysym.unicode;
    if (n > 0 && n <= 255) return n;

    n = event.key.keysym.sym;
    if (n >= SDLK_NUMLOCK) return 0;

    /* Numpad keys are handled here when numlock is on: */
    if (event.key.keysym.mod & KMOD_NUM)
    {
        if (n == SDLK_KP_PERIOD)
        {
            return '.';
        }
        else if (n >= SDLK_KP0 && n <= SDLK_KP9)
        {
            return n - SDLK_KP0 + '0';
        }
    }
    
    if (n == SDLK_DELETE) return QBK_DELETE;
    
    if (n >= SDLK_KP0 && n <= SDLK_F12)
    {
        if (n == SDLK_KP5) return 0;
        return SdlKToQbK[n - SDLK_KP0];
    }
    
    return 0xFF00 + event.key.keysym.scancode;
}

