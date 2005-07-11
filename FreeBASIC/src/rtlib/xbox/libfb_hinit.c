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
 * init.c -- libfb initialization for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */


#include <hal/xbox.h>
#include <hal/fileio.h>
#include <openxdk/debug.h>
#include <SDL.h>


#include <stdlib.h>
#include <stdlib.h>
#include "../fb.h"
#include "../fb_rterr.h"
#include "fb_xbox.h"
/*#include <float.h>	This isn't seen for some reason.*/

#ifdef MULTITHREADED
CRITICAL_SECTION fb_global_mutex;
CRITICAL_SECTION fb_string_mutex;
#endif

HANDLE fb_in_handle, fb_out_handle;
#define fbhandlesdefined

/*:::::*/
void fb_hInit ( int argc, char **argv )
{

    /* set FPU precision to 64-bit and round to nearest (as in QB) 
	Actually, we won't. It's just not a good idea at this point.
*/
	/*_controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );*/
	//FIXME: THESE SEEM IMPORTANT!
	//fb_in_handle = GetStdHandle( STD_INPUT_HANDLE );
	//fb_out_handle = GetStdHandle( STD_OUTPUT_HANDLE );

#ifdef MULTITHREADED
	InitializeCriticalSection(&fb_global_mutex);
	InitializeCriticalSection(&fb_string_mutex);
	
	/* allocate thread local storage vars for runtime error handling */
	fb_errctx.handler   = TlsAlloc();
	fb_errctx.num       = TlsAlloc();
	fb_errctx.reslbl    = TlsAlloc();
	fb_errctx.resnxtlbl = TlsAlloc();
	
	/* allocate thread local storage vars for input context */
	fb_inpctx.f         = TlsAlloc();
	fb_inpctx.i         = TlsAlloc();
	fb_inpctx.s.data    = TlsAlloc();
	fb_inpctx.s.len     = TlsAlloc();
	fb_inpctx.s.size    = TlsAlloc();
	
	/* allocate thread local storage vars for print using context */
	fb_printusgctx.chars       = TlsAlloc();
	fb_printusgctx.ptr         = TlsAlloc();
	fb_printusgctx.fmtstr.data = TlsAlloc();
	fb_printusgctx.fmtstr.len  = TlsAlloc();
	fb_printusgctx.fmtstr.size = TlsAlloc();

#endif

}


#if 0
  // Basic text output

void DrawPixel(SDL_Surface *screen, int x, int y, unsigned char R, unsigned char G, unsigned char B)
{
  unsigned int color = SDL_MapRGB(screen->format, R, G, B);
  switch (screen->format->BytesPerPixel)
  {
    case 1: // Assuming 8-bpp
      {
        unsigned char *bufp;
        bufp = (unsigned char *)screen->pixels + y*screen->pitch + x;
        *bufp = color;
      }
      break;
    case 2: // Probably 15-bpp or 16-bpp
      {
        unsigned short *bufp;
        bufp = (unsigned short *)screen->pixels + y*screen->pitch/2 + x;
        *bufp = color;
      }
      break;
    case 3: // Slow 24-bpp mode, usually not used
      {
        unsigned char *bufp;
        bufp = (unsigned char *)screen->pixels + y*screen->pitch + x * 3;
        if(SDL_BYTEORDER == SDL_LIL_ENDIAN)
        {
          bufp[0] = color;
          bufp[1] = color >> 8;
          bufp[2] = color >> 16;
        } else {
          bufp[2] = color;
          bufp[1] = color >> 8;
          bufp[0] = color >> 16;
        }
      }
      break;
    case 4: // Probably 32-bpp
      {
        unsigned int *bufp;
        bufp = (unsigned int *)screen->pixels + y*screen->pitch/4 + x;
        *bufp = color;
      }
      break;
  }
}

void drawScreen(int width, int height, int bpp)
{
	SDL_Surface *screen = SDL_SetVideoMode(width, height, bpp, SDL_HWSURFACE | SDL_DOUBLEBUF);
	for(int x=0; x<width; x++)
	{
		for(int y=0; y<height; y++)
		{
			DrawPixel(screen, x, y, y/2, y/2, x/3);
		}
	}
	SDL_Flip(screen);
	XSleep(1000);
}

//extern FBCALL void XBOXSTART ();

#endif

#if 0
	int width = 640;
	int height = 480;
	int bpp = 32;
	
	SDL_Init(SDL_INIT_VIDEO);
	drawScreen(width, height, 8);
	//This is kept here so I don't have to worry about whether stuff is actually happening
	//XBOXSTART ();		

	
	//end stuff
	drawScreen(width, height, 16);
	
	XSleep(5000);
	
#endif


extern void XBoxStartup2(void);

void XBoxStartup()
{
	SDL_Init(SDL_INIT_VIDEO);
	SDL_SetVideoMode(640, 480, 32, SDL_HWSURFACE | SDL_DOUBLEBUF);
	
	XBoxStartup2();
	
	while (1) { }
	//XReboot();
}
