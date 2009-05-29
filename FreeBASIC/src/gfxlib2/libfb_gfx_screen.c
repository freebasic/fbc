/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
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
 * screen.c -- screen function and drivers handling
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

#define NUM_MODES		21


typedef struct MODEINFO
{
	unsigned short w;
	unsigned short h;
	unsigned char depth;
	unsigned char scanline_size;
	const PALETTE *palette;
	const FONT *font;
	unsigned char text_w;
	unsigned char text_h;
	float aspect;
} MODEINFO;



static const MODEINFO mode_info[NUM_MODES] = {
 { 320, 200, 2, 1, &fb_palette_16,  &fb_font_8x8,   40, 25, 0.0 },		/* CGA mode 1 */
 { 640, 200, 1, 2, &fb_palette_16,  &fb_font_8x8,   80, 25, 0.0 },		/* CGA mode 2 */
 { 0 }, { 0 }, { 0 }, { 0 },						/* Unsupported modes (3, 4, 5, 6) */
 { 320, 200, 4, 1, &fb_palette_16,  &fb_font_8x8,   40, 25, 0.0 },		/* EGA mode 7 */
 { 640, 200, 4, 2, &fb_palette_16,  &fb_font_8x8,   80, 25, 0.0 },		/* EGA mode 8 */
 { 640, 350, 4, 1, &fb_palette_64,  &fb_font_8x14,  80, 25, 0.0 },		/* EGA mode 9 */
 { 640, 350, 1, 1, &fb_palette_2,   &fb_font_8x14,  80, 25, 0.0 },		/* EGA mode 10 */
 { 640, 480, 1, 1, &fb_palette_2,   &fb_font_8x16,  80, 30, 0.0 },		/* VGA mode 11 */
 { 640, 480, 4, 1, &fb_palette_256, &fb_font_8x16,  80, 30, 0.0 },		/* VGA mode 12 */
 { 320, 200, 8, 1, &fb_palette_256, &fb_font_8x8,   40, 25, 0.0 },		/* VGA mode 13 */

									/* New modes */
 { 320, 240, 8, 1, &fb_palette_256, &fb_font_8x8,   40, 30, 0.0 },		/* 14: 320x240 */
 { 400, 300, 8, 1, &fb_palette_256, &fb_font_8x8,   50, 37, 0.0 },		/* 15: 400x300 */
 { 512, 384, 8, 1, &fb_palette_256, &fb_font_8x16,  64, 24, 0.0 },		/* 16: 512x384 */
 { 640, 400, 8, 1, &fb_palette_256, &fb_font_8x16,  80, 25, 0.0 },		/* 17: 640x400 */
 { 640, 480, 8, 1, &fb_palette_256, &fb_font_8x16,  80, 30, 0.0 },		/* 18: 640x480 */
 { 800, 600, 8, 1, &fb_palette_256, &fb_font_8x16, 100, 37, 0.0 },		/* 19: 800x600 */
 {1024, 768, 8, 1, &fb_palette_256, &fb_font_8x16, 128, 48, 0.0 },		/* 20: 1024x768 */
 {1280,1024, 8, 1, &fb_palette_256, &fb_font_8x16, 160, 64, 0.0 },		/* 21: 1280x1024 */
};

static int  screen_id = 1;
static char window_title_buff[WINDOW_TITLE_SIZE] = { 0 };
static int  exit_proc_set = FALSE;

static int set_mode(const MODEINFO *info, int mode, int depth, int num_pages, int refresh_rate, int flags);


static void release_gfx_mem(void)
{
	if (__fb_gfx) {
		if ((__fb_gfx->driver) && (__fb_gfx->driver->exit))
            __fb_gfx->driver->exit();
        fb_hResetCharCells(NULL, FALSE);
        if (__fb_gfx->page) {
            int i;
            for (i = 0; i < __fb_gfx->num_pages; i++) {
                free(((void **)(__fb_gfx->page[i]))[-1]);
            }
            free(__fb_gfx->page);
		}
		if (__fb_gfx->device_palette)
			free(__fb_gfx->device_palette);
		if (__fb_gfx->palette)
			free(__fb_gfx->palette);
		if (__fb_gfx->color_association)
			free(__fb_gfx->color_association);
		if (__fb_gfx->dirty)
			free(__fb_gfx->dirty);
		if (__fb_gfx->key)
			free(__fb_gfx->key);
		if (__fb_gfx->event_queue) {
			free(__fb_gfx->event_queue);
			fb_MutexDestroy(__fb_gfx->event_mutex);
		}
		free(__fb_gfx);
        __fb_gfx = NULL;
	}
    if (__fb_color_conv_16to32) {
        free(__fb_color_conv_16to32);
        __fb_color_conv_16to32 = NULL;
    }
}

/*:::::*/
static void exit_proc(void)
{
    if( __fb_gfx )
        set_mode(NULL, 0, 0, 0, 0, SCREEN_EXIT);
}

/* Dummy function to ensure that the CONSOLE "update" hook for a VIEW PRINT
 * doesn't get called */
void fb_GfxViewUpdate( void )
{
}

void fb_hResetCharCells(FB_GFXCTX *context, int do_alloc)
{
    int i;

    if( __fb_gfx!=NULL ) {
        /* Free the previously allocated character cells */
        if( __fb_gfx->con_pages!=NULL ) {
            for (i = 0; i < __fb_gfx->num_pages; i++) {
                free(__fb_gfx->con_pages[i]);
            }
            free(__fb_gfx->con_pages);
        }

        if( do_alloc ) {
            size_t text_size = __fb_gfx->text_w * __fb_gfx->text_h;

            /* Allocate memory for all character cells */
            __fb_gfx->con_pages = (GFX_CHAR_CELL **)malloc(sizeof(GFX_CHAR_CELL *) * __fb_gfx->num_pages);
            for (i = 0; i < __fb_gfx->num_pages; i++) {
                __fb_gfx->con_pages[i] =
                    (GFX_CHAR_CELL *)calloc(1, sizeof(GFX_CHAR_CELL) * text_size);
            }

            /* Reset all character cells with default values */
            fb_hClearCharCells( 0, 0,
                                __fb_gfx->text_w, __fb_gfx->text_h,
                                context->work_page,
                                32,
                                context->fg_color, context->bg_color );
        } else {
            __fb_gfx->con_pages = NULL;
        }
    }
}

void fb_hClearCharCells( int x1, int y1, int x2, int y2,
                         int page,
                         FB_WCHAR ch, unsigned fg, unsigned bg )
{
    GFX_CHAR_CELL fill_cell = { ch, fg, bg };
    int clear_w = x2 - x1;
    int text_w = __fb_gfx->text_w;
    int move_w = text_w - clear_w;
    GFX_CHAR_CELL *cell_line = __fb_gfx->con_pages[page]
        + y1 * text_w + x1;
    int y;
    for( y=y1; y!=y2; ++y ) {
        int x = clear_w;
        while( x-- ) {
            memcpy( cell_line++,
                    &fill_cell,
                    sizeof( GFX_CHAR_CELL ) );
        }
        cell_line += move_w;
    }
}

/*:::::*/
static int set_mode(const MODEINFO *info, int mode, int depth, int num_pages, int refresh_rate, int flags)
{
    const GFXDRIVER *driver = NULL;
    FB_GFXCTX *context;
    int i, j, try_count;
    char *c, *driver_name;
    unsigned char *dest;

    if (num_pages <= 0)
        num_pages = 1;

	/* normalize flags */
	if ((flags >= 0) && (flags & DRIVER_SHAPED_WINDOW))
		flags |= DRIVER_SHAPED_WINDOW | DRIVER_NO_FRAME | DRIVER_NO_SWITCH;

    release_gfx_mem();

	if ((mode == 0) || (info->w == 0)) {
        memset(&__fb_ctx.hooks, 0, sizeof(__fb_ctx.hooks));

        if (flags != SCREEN_EXIT) {
            /* set and clear text screen mode or the width and line_len will be wrong */
            fb_Width( 80, 25 );
            fb_Cls( 0 );
        }
        /* reset viewport to console dimensions */
        fb_ConsoleSetTopBotRows(-1, -1);
	}
	else {
        __fb_ctx.hooks.inkeyproc = fb_GfxInkey;
        __fb_ctx.hooks.getkeyproc = fb_GfxGetkey;
        __fb_ctx.hooks.keyhitproc = fb_GfxKeyHit;
        __fb_ctx.hooks.clsproc = fb_GfxClear;
        __fb_ctx.hooks.colorproc = fb_GfxColor;
        __fb_ctx.hooks.locateproc = fb_GfxLocate;
        __fb_ctx.hooks.widthproc = fb_GfxWidth;
        __fb_ctx.hooks.getxproc = fb_GfxGetX;
        __fb_ctx.hooks.getyproc = fb_GfxGetY;
        __fb_ctx.hooks.getxyproc = fb_GfxGetXY;
        __fb_ctx.hooks.getsizeproc = fb_GfxGetSize;
        __fb_ctx.hooks.printbuffproc = fb_GfxPrintBufferEx;
        __fb_ctx.hooks.printbuffwproc = fb_GfxPrintBufferWstrEx;
        __fb_ctx.hooks.readstrproc = fb_GfxReadStr;
        __fb_ctx.hooks.multikeyproc = fb_GfxMultikey;
        __fb_ctx.hooks.getmouseproc = fb_GfxGetMouse;
        __fb_ctx.hooks.setmouseproc = fb_GfxSetMouse;
        __fb_ctx.hooks.inproc = fb_GfxIn;
        __fb_ctx.hooks.outproc = fb_GfxOut;
        __fb_ctx.hooks.viewupdateproc = fb_GfxViewUpdate;
        __fb_ctx.hooks.lineinputproc = fb_GfxLineInput;
        __fb_ctx.hooks.lineinputwproc = fb_GfxLineInputWstr;
        __fb_ctx.hooks.readxyproc = fb_GfxReadXY;
        __fb_ctx.hooks.sleepproc = fb_GfxSleep;
        __fb_ctx.hooks.isredirproc = fb_GfxIsRedir;
        __fb_ctx.hooks.pagecopyproc = fb_GfxPageCopy;
        __fb_ctx.hooks.pagesetproc = fb_GfxPageSet;
        __fb_gfx = (FBGFX *)calloc(1, sizeof(FBGFX));
    }

    if (__fb_gfx) {
    	__fb_gfx->id = screen_id++;
        __fb_gfx->mode_num = mode;
        __fb_gfx->w = info->w;
        __fb_gfx->h = info->h;
        __fb_gfx->depth = info->depth;
        if ((mode > 13) && ((depth == 8) || (depth == 15) || (depth == 16) || (depth == 24) || (depth == 32)))
            __fb_gfx->depth = depth;
        if ((flags >= 0) && (flags & DRIVER_OPENGL))
            __fb_gfx->depth = MAX(16, __fb_gfx->depth);
        __fb_gfx->default_palette = info->palette;
        __fb_gfx->scanline_size = info->scanline_size;
        __fb_gfx->font = (FONT *)info->font;

		if(info->aspect)
			__fb_gfx->aspect = info->aspect;
		else
			__fb_gfx->aspect = (4.0 / 3.0) * ((float)__fb_gfx->h / (float)__fb_gfx->w);

        switch (__fb_gfx->depth) {
        case 15:
        case 16:	__fb_gfx->color_mask = 0xFFFF; __fb_gfx->depth = 16; break;
        case 24:
        case 32:	__fb_gfx->color_mask = 0xFFFFFFFF; __fb_gfx->depth = 32; break;
        default:	__fb_gfx->color_mask = (1 << __fb_gfx->depth) - 1;
        }

        __fb_gfx->bpp = BYTES_PER_PIXEL(__fb_gfx->depth);
        __fb_gfx->pitch = __fb_gfx->w * __fb_gfx->bpp;
        __fb_gfx->page = (unsigned char **)malloc(sizeof(unsigned char *) * num_pages);
        for (i = 0; i < num_pages; i++) {
		/* 0xF for the para alignment, p_size is sizeof(void *) rounded up to % 16 for the storage for the original pointer */
		int p_size = (sizeof(void *) + 0xF) & 0xF;
		void *tmp = malloc((__fb_gfx->pitch * __fb_gfx->h) + p_size + 0xF);
		__fb_gfx->page[i] = (unsigned char *)(((intptr_t)tmp + p_size + 0xF) & ~0xF);
		((void **)(__fb_gfx->page[i]))[-1] = tmp;
	}
        __fb_gfx->num_pages = num_pages;
        __fb_gfx->framebuffer = __fb_gfx->page[0];

        /* dirty lines array may be bigger than needed; this is to please the
         gfx driver which is not aware of the scanline size */
        __fb_gfx->dirty = (char *)calloc(1, __fb_gfx->h * __fb_gfx->scanline_size);
        __fb_gfx->device_palette = (unsigned int *)calloc(1, sizeof(int) * 256);
        __fb_gfx->palette = (unsigned int *)calloc(1, sizeof(int) * 256);
        __fb_gfx->color_association = (unsigned char *)malloc(16);
        __fb_gfx->key = (char *)calloc(1, 128);
        __fb_gfx->event_queue = (EVENT *)malloc(sizeof(EVENT) * MAX_EVENTS);
        __fb_gfx->event_mutex = fb_MutexCreate();
        __fb_color_conv_16to32 = (unsigned int *)malloc(sizeof(int) * 512);
        if (flags != DRIVER_NULL) {
			if (flags & DRIVER_ALPHA_PRIMITIVES)
	        	__fb_gfx->flags |= ALPHA_PRIMITIVES;
	        if (flags & DRIVER_OPENGL)
	        	__fb_gfx->flags |= OPENGL_SUPPORT;
	        if (flags & DRIVER_HIGH_PRIORITY)
	        	__fb_gfx->flags |= HIGH_PRIORITY;
	    }

        fb_hSetupFuncs(__fb_gfx->bpp);
        fb_hSetupData();

        if (!__fb_window_title)
        {
            __fb_window_title = fb_hGetExeName( window_title_buff, WINDOW_TITLE_SIZE - 1 );
            if ((c = strrchr(__fb_window_title, '.')))
                *c = '\0';
        }

		driver_name = __fb_gfx_driver_name;
		if (!driver_name)
	        driver_name = getenv("FBGFX");
        if ((flags == DRIVER_NULL) || ((driver_name) && (!strcasecmp(driver_name, "null"))))
            driver = &__fb_gfxDriverNull;
        else {
            for (try_count = (driver_name ? 4 : 2); try_count; try_count--) {
                for (i = 0; __fb_gfx_drivers_list[i >> 1]; i++) {
                    driver = __fb_gfx_drivers_list[i >> 1];
                    if ((driver_name) && !(try_count & 0x1) && (strcasecmp(driver_name, driver->name))) {
                        driver = NULL;
                        continue;
					}
                    if (!driver->init(__fb_window_title, __fb_gfx->w, __fb_gfx->h * __fb_gfx->scanline_size, __fb_gfx->depth, (i & 0x1) ? 0 : refresh_rate, flags))
                        break;
                    driver->exit();
                    driver = NULL;
                }
                if (driver)
                    break;
                if (driver_name) {
                    if (try_count == 3)
                        flags ^= DRIVER_FULLSCREEN;
                }
                else
                    flags ^= DRIVER_FULLSCREEN;
            }
        }

        if (!driver) {
            exit_proc();
            return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        }
        __fb_gfx->driver = driver;

        fb_GfxPalette(-1, 0, 0, 0);

        __fb_gfx->text_w = info->text_w;
        __fb_gfx->text_h = info->text_h;

        context = fb_hGetContext();

        fb_hResetCharCells(context, TRUE);
        for (i = 0; i < num_pages; i++) {
        	dest = __fb_gfx->page[i];
        	for (j = 0; j < __fb_gfx->h; j++) {
	        	context->pixel_set(dest, context->bg_color, context->view_w);
	        	dest += __fb_gfx->pitch;
	        }
		}

        if( !exit_proc_set ) {
            exit_proc_set = TRUE;
            atexit(exit_proc);
        }
    }

    if( flags!=SCREEN_EXIT ) {
        /* Reset VIEW PRINT
         *
         * Normally, resetting VIEW PRINT should also result in setting the cursor
         * position to Y,X = 1,1 but this doesn't seem to be suitable (at least
         * on Win32 platforms). I don't believe that this is a problem because
         * on DOS, the cursor position will automatically be reset when the screen
         * mode changes and not changing the console cursor position on Win32
         * and Linux seem to be more "natural". */
        fb_ConsoleViewEx( 0, 0, __fb_gfx!=NULL );
    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_GfxScreen(int mode, int depth, int num_pages, int flags, int refresh_rate)
{
    const MODEINFO *info = NULL;
    int res;

	if ((mode < 0) || (mode > NUM_MODES))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	if (mode > 0) {
		info = &mode_info[mode - 1];
		if (info->w == 0)
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
    res = set_mode(info, mode, depth, num_pages, refresh_rate, flags);
    if (res == FB_RTERROR_OK)
        FB_HANDLE_SCREEN->line_length = 0;

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
FBCALL int fb_GfxScreenQB(int mode, int visible, int active)
{

	int res = fb_GfxScreen( mode, 0, 0, 0, 0 );
	if( res != FB_RTERROR_OK )
		return res;

	if( visible >= 0 || active >= 0 )
		return fb_ErrorSetNum( fb_PageSet( visible, active ) );
	else
		return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
FBCALL int fb_GfxScreenRes(int w, int h, int depth, int num_pages, int flags, int refresh_rate)
{
    MODEINFO info;
    int res;

	if ((w <= 0) || (h <= 0))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	switch (depth) {
		case 1:
		case 2:
		case 4:
		case 8:
		case 15:
		case 16:
		case 24:
		case 32:
			break;
		default:
			return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	info.w = w;
	info.h = h;
	info.depth = depth;
	info.scanline_size = 1;
	info.palette = &fb_palette_256;
	info.font = &fb_font_8x8;
	info.text_w = w / info.font->w;
	info.text_h = h / info.font->h;
	info.aspect = 1.0;

    res = set_mode((const MODEINFO *)&info, -1, depth, num_pages, refresh_rate, flags);
    if (res==FB_RTERROR_OK)
        FB_HANDLE_SCREEN->line_length = 0;

    return res;
}


/*:::::*/
FBCALL void fb_GfxSetWindowTitle(FBSTRING *title)
{
	fb_hMemSet(window_title_buff, 0, WINDOW_TITLE_SIZE);
	fb_hMemCpy(window_title_buff, title->data, MIN(WINDOW_TITLE_SIZE - 1, FB_STRSIZE(title)));
	__fb_window_title = window_title_buff;

	if ((__fb_gfx) && (__fb_gfx->driver->set_window_title))
		__fb_gfx->driver->set_window_title(__fb_window_title);

	/* del if temp */
	fb_hStrDelTemp( title );
}


/*:::::*/
#if !defined(HAVE_GL_GL_H)
FBCALL void *fb_GfxGetGLProcAddress(const char *proc)
{
	/* if gl.h header was not found at configure time
	 * then no OpenGL support will be compiled in, and
	 * this function won't be defined anywhere else, so
	 * just provide a stub in such a case (jeffm).
	 */
	return NULL;
}
#endif
