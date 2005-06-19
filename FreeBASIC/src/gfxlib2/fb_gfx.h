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
 * fb_gfx.h -- internal gfx definitions
 *
 * chng: jan/2005 written [lillo]
 *
 */

#ifndef __FB_GFX_H__
#define __FB_GFX_H__

#include <stdlib.h>
#include <string.h>
#include <math.h>

#include "fb_gfx_scancodes.h"
#include "../rtlib/fb.h"
#include "../rtlib/fb_rterr.h"

#ifdef TRUE
#undef TRUE
#endif
#define TRUE	-1
#ifdef FALSE
#undef FALSE
#endif
#define FALSE	0
#ifdef PI
#undef PI
#endif
#define PI			3.1415926535897932384626
#ifdef MIN
#undef MIN
#endif
#define MIN(a,b)		((a) < (b) ? (a) : (b))
#ifdef MAX
#undef MAX
#endif
#define MAX(a,b)		((a) > (b) ? (a) : (b))
#ifdef MID
#undef MID
#endif
#define MID(a,b,c)		MIN(MAX((a), (b)), (c))
#ifdef SWAP
#undef SWAP
#endif
#define SWAP(a,b)		((a) ^= (b), (b) ^= (a), (a) ^= (b))

#define BYTES_PER_PIXEL(d)	(((d) + 7) / 8)

#define DRIVER_LOCK()		{ if (!(fb_mode->flags & (SCREEN_LOCKED | SCREEN_AUTOLOCKED))) { fb_mode->driver->lock(); fb_mode->flags |= SCREEN_LOCKED | SCREEN_AUTOLOCKED; } }
#define DRIVER_UNLOCK()		{ if (fb_mode->flags & SCREEN_AUTOLOCKED) { fb_mode->driver->unlock(); fb_mode->flags &= ~(SCREEN_LOCKED | SCREEN_AUTOLOCKED); } }
#define SET_DIRTY(y,h)		{ if (fb_mode->framebuffer == fb_mode->line[0]) fb_hMemSet(fb_mode->dirty + (y), TRUE, (h)); }

#define DRIVER_FULLSCREEN	0x00000001
#define DRIVER_OPENGL		0x00000002
#define DRIVER_OPENGL_OPTIONS	0x000000F0
#define HAS_STENCIL_BUFFER	0x00000010
#define HAS_ACCUMULATION_BUFFER	0x00000020

#define HAS_MMX			0x01000000
#define SCREEN_EXIT		0x80000000
#define DEFAULT_COLOR		0xFEFF00FF
#define WINDOW_ACTIVE		0x00000001
#define WINDOW_SCREEN		0x00000002
#define VIEW_SCREEN		0x00000004
#define BUFFER_SET		0x00000008
#define SCREEN_LOCKED		0x00000010
#define SCREEN_AUTOLOCKED	0x00000020

#define COORD_TYPE_AA		0
#define COORD_TYPE_AR		1
#define COORD_TYPE_RA		2
#define COORD_TYPE_RR		3
#define COORD_TYPE_A		4
#define COORD_TYPE_R		5

#define LINE_TYPE_LINE		0
#define LINE_TYPE_B		1
#define LINE_TYPE_BF		2

#define PAINT_TYPE_FILL		0
#define PAINT_TYPE_PATTERN	1

#define MASK_COLOR_32		0xFF00FF
#define MASK_COLOR_16		0xF81F

#define PUT_MODE_TRANS		0
#define PUT_MODE_PSET		1
#define PUT_MODE_PRESET		2
#define PUT_MODE_AND		3
#define PUT_MODE_OR		4
#define PUT_MODE_XOR		5
#define PUT_MODE_ALPHA		6
#define PUT_MODE_CUSTOM		7

#define KEY_BUFFER_LEN		16

#define KEY_QUIT		0x100
#define KEY_UP			0x101
#define KEY_DOWN		0x102
#define KEY_LEFT		0x103
#define KEY_RIGHT		0x104
#define KEY_INS			0x105
#define KEY_DEL			0x106
#define KEY_HOME		0x107
#define KEY_END			0x108
#define KEY_PAGE_UP		0x109
#define KEY_PAGE_DOWN		0x10A
#define KEY_F(n)		(0x10A + (n))
#define KEY_MAX_SPECIALS	(KEY_F(10) - 0x100 + 1)

#define WINDOW_TITLE_SIZE	128


typedef struct MODE
{
	int mode_num;					/* Current mode number */
	unsigned char **page;				/* Pages memory */
	int num_pages;					/* Number of requested pages */
	int work_page;					/* Current work page number */
	unsigned char *framebuffer;			/* Our current visible framebuffer */
	unsigned char **line;				/* Line pointers into current active framebuffer */
	int pitch;					/* Width of a framebuffer line in bytes */
	int target_pitch;				/* Width of current target buffer line in bytes */
	void *last_target;				/* Last target buffer set */
	int max_h;					/* Max registered height of target buffer */
	int bpp;					/* Bytes per pixel */
	unsigned int *palette;				/* Current RGB color values for each palette index */
	unsigned int *device_palette;			/* Current RGB color values of visible device palette */
	unsigned char *color_association;		/* Palette color index associations for CGA/EGA emulation */
	char *dirty;					/* Dirty lines buffer */
	const struct GFXDRIVER *driver;			/* Gfx driver in use */
	int w, h;					/* Current mode width and height */
	int depth;					/* Current mode depth */
	int color_mask;					/* Color bit mask for colordepth emulation */
	const struct PALETTE *default_palette;		/* Default palette for current mode */
	int scanline_size;				/* Vertical size of a single scanline in pixels */
	unsigned int fg_color, bg_color;		/* Current foreground and background colors */
	float last_x, last_y;				/* Last pen position */
	int cursor_x, cursor_y;				/* Current graphical text cursor position (in chars, 0 based) */
	const struct FONT *font;			/* Current font */
	int view_x, view_y, view_w, view_h;		/* VIEW coordinates */
	float win_x, win_y, win_w, win_h;		/* WINDOW coordinates */
	int text_w, text_h;				/* Graphical text console size in characters */
	char *key;					/* Keyboard states */
	int driver_flags;				/* Driver initialization flags */
	int refresh_rate;				/* Driver refresh rate */
	int flags;					/* Status flags */
} MODE;


typedef struct GFXDRIVER
{
	char *name;
	int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags);
	void (*exit)(void);
	void (*lock)(void);
	void (*unlock)(void);
	void (*set_palette)(int index, int r, int g, int b);
	void (*wait_vsync)(void);
	int (*get_mouse)(int *x, int *y, int *z, int *buttons);
	void (*set_mouse)(int x, int y, int cursor);
	void (*set_window_title)(char *title);
	int *(*fetch_modes)(int depth, int *size);
	void (*flip)(void);
} GFXDRIVER;


typedef struct PALETTE
{
	const int colors;
	const unsigned char *data;
} PALETTE;


typedef struct FONT
{
	const int h;
	const unsigned char *data;
} FONT;


typedef void (BLITTER)(unsigned char *, int);
typedef FBCALL unsigned int (BLENDER)(unsigned int, unsigned int);

/* Global variables */
extern MODE *fb_mode;
extern const GFXDRIVER *fb_gfx_driver_list[];
extern void *(*fb_hMemCpy)(void *dest, const void *src, size_t size);
extern void *(*fb_hMemSet)(void *dest, int value, size_t size);
extern void (*fb_hPutPixel)(int x, int y, unsigned int color);
extern unsigned int (*fb_hGetPixel)(int x, int y);
extern void *(*fb_hPixelCpy)(void *dest, const void *src, size_t size);
extern void *(*fb_hPixelSet)(void *dest, int color, size_t size);
extern unsigned int *fb_color_conv_16to32;
extern const PALETTE fb_palette_16;
extern const PALETTE fb_palette_64;
extern const PALETTE fb_palette_256;
extern const FONT fb_font_8x8;
extern const FONT fb_font_8x14;
extern const FONT fb_font_8x16;


/* Internal functions */
extern void fb_hSetupFuncs(void);
extern void fb_hSetupData(void);
extern FBCALL int fb_hEncode(const unsigned char *in_buffer, int in_size, unsigned char *out_buffer, int *out_size);
extern FBCALL int fb_hDecode(const unsigned char *in_buffer, int in_size, unsigned char *out_buffer, int *out_size);
extern void fb_hPostKey(int key);
extern BLITTER *fb_hGetBlitter(int device_depth, int is_rgb);
extern unsigned int fb_hMakeColor(unsigned int index, int r, int g, int b);
extern unsigned int fb_hFixColor(unsigned int color);
extern void fb_hRestorePalette(void);
extern void fb_hPrepareTarget(void *target);
extern void fb_hTranslateCoord(float fx, float fy, int *x, int *y);
extern void fb_hFixRelative(int coord_type, float *x1, float *y1, float *x2, float *y2);
extern void fb_hFixCoordsOrder(int *x1, int *y1, int *x2, int *y2);
extern void fb_hGfxBox(int x1, int y1, int x2, int y2, unsigned int color, int full);
extern void fb_hScreenInfo(int *width, int *height, int *depth, int *refresh);
extern int fb_hHasMMX(void);
extern void *fb_hMemCpyMMX(void *dest, const void *src, size_t size);
extern void *fb_hMemSetMMX(void *dest, int value, size_t size);

/* Public API */
extern FBCALL int fb_GfxScreen(int mode, int depth, int num_pages, int flags, int refresh_rate);
extern FBCALL int fb_GfxScreenRes(int width, int height, int depth, int num_pages, int flags, int refresh_rate);
extern FBCALL void fb_GfxScreenInfo(int *width, int *height, int *depth, int *bpp, int *pitch, int *refresh_rate, FBSTRING *driver);
extern FBCALL void *fb_GfxImageCreate(int width, int height, unsigned int color);
extern FBCALL void fb_GfxImageDestroy(void *image);
extern FBCALL void fb_GfxPalette(int index, int r, int g, int b);
extern FBCALL void fb_GfxPaletteUsing(int *data);
extern FBCALL void fb_GfxPaletteGet(int index, int *r, int *g, int *b);
extern FBCALL void fb_GfxPaletteGetUsing(int *data);
extern FBCALL void fb_GfxPaletteOut(int port, int value);
extern FBCALL int fb_GfxPaletteInp(int port);
extern FBCALL void fb_GfxPset(void *target, float x, float y, unsigned int color, int coord_type);
extern FBCALL int fb_GfxPoint(void *target, float x, float y);
extern FBCALL float fb_GfxPMap(float coord, int func);
extern FBCALL float fb_GfxCursor(int func);
extern FBCALL void fb_GfxView(int x1, int y1, int x2, int y2, unsigned int fill_color, unsigned int border_color, int screen);
extern FBCALL void fb_GfxWindow(float x1, float y1, float x2, float y2, int screen);
extern FBCALL void fb_GfxLine(void *target, float x1, float y1, float x2, float y2, unsigned int color, int type, unsigned int style, int coord_type);
extern FBCALL void fb_GfxEllipse(void *target, float x, float y, float radius, unsigned int color, float aspect, float start, float end, int fill, int coord_type);
extern FBCALL int fb_GfxGet(void *target, float x1, float y1, float x2, float y2, unsigned char *dest, int coord_type, FBARRAY *array);
extern FBCALL void fb_GfxPut(void *target, float x, float y, unsigned char *src, int coord_type, int mode, int alpha, BLENDER *func);
extern FBCALL void fb_GfxWaitVSync(int port, int and_mask, int xor_mask);
extern FBCALL void fb_GfxPaint(void *target, float fx, float fy, unsigned int color, unsigned int border_color, FBSTRING *pattern, int mode, int coord_type);
extern FBCALL void fb_GfxDraw(void *target, FBSTRING *command);
extern FBCALL void fb_GfxFlip(int from_page, int to_page);
extern FBCALL void fb_GfxSetPage(int work_page, int visible_page);
extern FBCALL void fb_GfxLock(void);
extern FBCALL void fb_GfxUnlock(int start_line, int end_line);
extern FBCALL void *fb_GfxScreenPtr(void);
extern FBCALL void fb_GfxSetWindowTitle(FBSTRING *title);
extern FBCALL int fb_GfxMultikey(int scancode);
extern FBCALL int fb_GfxGetMouse(int *x, int *y, int *z, int *buttons);
extern FBCALL int fb_GfxSetMouse(int x, int y, int cursor);
extern FBCALL int fb_GfxGetJoystick(int id, int *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6);

/* Runtime library hooks */
int fb_GfxGetkey(void);
FBSTRING *fb_GfxInkey(void);
int fb_GfxKeyHit(void);
int fb_GfxColor(int fg_color, int bg_color);
void fb_GfxClear(int mode);
int fb_GfxWidth(int w, int h);
int fb_GfxLocate(int y, int x, int cursor);
int fb_GfxGetX(void);
int fb_GfxGetY(void);
void fb_GfxPrintBuffer(char *buffer, int mask);
char *fb_GfxReadStr(char *buffer, int maxlen);

#endif
