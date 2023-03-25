/* internal gfx definitions */

#ifndef __FB_GFX_H__
#define __FB_GFX_H__

#include "../rtlib/fb.h"
#include "../rtlib/fb_gfx_private.h"

#ifdef HOST_DOS
	/* No OpenGL support on DOS */
	#define DISABLE_OPENGL
#endif

#define PI			3.1415926535897932384626

#define BYTES_PER_PIXEL(d)		(((d) + 7) / 8)
#define BPP_MASK(b)				((int)((1LL << ((b) << 3)) - 1))

#define DRIVER_LOCK()		do { fb_GfxLock(); } while (0)
#define DRIVER_UNLOCK()		do { fb_GfxUnlock(1, 0); } while (0) /* start_line > end_line so dirty is not modified */
#define SET_DIRTY(c,y,h)	{ if (__fb_gfx->framebuffer == (c)->line[0]) fb_hMemSet(__fb_gfx->dirty + (y), TRUE, (h)); }

#define EVENT_LOCK()		{ fb_MutexLock(__fb_gfx->event_mutex); }
#define EVENT_UNLOCK()		{ fb_MutexUnlock(__fb_gfx->event_mutex); }

#define DRIVER_NULL				-1
#define DRIVER_FULLSCREEN		0x00000001
#define DRIVER_OPENGL			0x00000002
#define DRIVER_NO_SWITCH		0x00000004
#define DRIVER_NO_FRAME			0x00000008
#define DRIVER_SHAPED_WINDOW	0x00000010
#define DRIVER_ALWAYS_ON_TOP	0x00000020
#define DRIVER_ALPHA_PRIMITIVES	0x00000040
#define DRIVER_HIGH_PRIORITY	0x00000080
#define DRIVER_OPENGL_OPTIONS	0x000F0000
#define HAS_STENCIL_BUFFER		0x00010000
#define HAS_ACCUMULATION_BUFFER	0x00020000
#define HAS_MULTISAMPLE			0x00040000

#define HAS_MMX					0x01000000
#define SCREEN_EXIT				((int)0x80000000)
#define PRINT_SCROLL_WAS_OFF	0x00000004
#define ALPHA_PRIMITIVES		0x00000008
#define OPENGL_PRIMITIVES		0x00000010
#define HIGH_PRIORITY			0x00000020
#define QB_COMPATIBILITY		0x10000000
#define OPENGL_SUPPORT			0x20000000

#define CTX_BUFFER_INIT			0x00000001
#define CTX_BUFFER_SET			0x00000002
#define CTX_WINDOW_ACTIVE		0x00000004
#define CTX_WINDOW_SCREEN		0x00000008
#define CTX_VIEWPORT_SET		0x00000010
#define CTX_VIEW_SCREEN			0x00000020

#define COORD_TYPE_AA			0
#define COORD_TYPE_AR			1
#define COORD_TYPE_RA			2
#define COORD_TYPE_RR			3
#define COORD_TYPE_A			4
#define COORD_TYPE_R			5
#define COORD_TYPE_MASK			0x00000007
#define DEFAULT_COLOR_1			0x80000000
#define DEFAULT_COLOR_2			0x40000000
#define VIEW_SCREEN				0x00000001

#define DRIVER_OGL_2D_NONE          0
#define DRIVER_OGL_2D_MANUAL_SYNC   1
#define DRIVER_OGL_2D_AUTO_SYNC     2

#define LINE_TYPE_LINE		0
#define LINE_TYPE_B		1
#define LINE_TYPE_BF		2

#define PAINT_TYPE_FILL		0
#define PAINT_TYPE_PATTERN	1

#define MASK_COLOR_32		0xFF00FF
#define MASK_COLOR_16		0xF81F

#define MASK_RB_32			0x00FF00FF
#define MASK_G_32			0x0000FF00
#define MASK_GA_32			0xFF00FF00
#define MASK_A_32			0xFF000000

#define MASK_RB_16			0xF81F
#define MASK_R_16			0xF800
#define MASK_G_16			0x07E0
#define MASK_B_16			0x001F

#define PUT_HEADER_NEW		0x7

#define WINDOW_TITLE_SIZE	128

#define GET_WINDOW_POS              0
#define GET_WINDOW_TITLE            1
#define GET_WINDOW_HANDLE           2
#define GET_DESKTOP_SIZE            3
#define GET_SCREEN_SIZE             4
#define GET_SCREEN_DEPTH            5
#define GET_SCREEN_BPP              6
#define GET_SCREEN_PITCH            7
#define GET_SCREEN_REFRESH          8
#define GET_DRIVER_NAME             9
#define GET_TRANSPARENT_COLOR       10
#define GET_VIEWPORT                11
#define GET_PEN_POS                 12
#define GET_COLOR                   13
#define GET_ALPHA_PRIMITIVES        14
#define GET_GL_EXTENSIONS           15
#define GET_HIGH_PRIORITY           16
#define GET_SCANLINE_SIZE           17

#define GET_GL_COLOR_BITS           37
#define GET_GL_COLOR_RED_BITS       38
#define GET_GL_COLOR_GREEN_BITS     39
#define GET_GL_COLOR_BLUE_BITS      40
#define GET_GL_COLOR_ALPHA_BITS     41
#define GET_GL_DEPTH_BITS           42
#define GET_GL_STENCIL_BITS         43
#define GET_GL_ACCUM_BITS           44
#define GET_GL_ACCUM_RED_BITS       45
#define GET_GL_ACCUM_GREEN_BITS     46
#define GET_GL_ACCUM_BLUE_BITS      47
#define GET_GL_ACCUM_ALPHA_BITS     48
#define GET_GL_NUM_SAMPLES          49

#define GET_GL_2D_MODE              82
#define GET_GL_SCALE                83

#define SET_FIRST_SETTER            100

#define SET_WINDOW_POS              100
#define SET_WINDOW_TITLE            101
#define SET_PEN_POS                 102
#define SET_DRIVER_NAME             103
#define SET_ALPHA_PRIMITIVES        104

#define SET_GL_COLOR_BITS           105
#define SET_GL_COLOR_RED_BITS       106
#define SET_GL_COLOR_GREEN_BITS     107
#define SET_GL_COLOR_BLUE_BITS      108
#define SET_GL_COLOR_ALPHA_BITS     109
#define SET_GL_DEPTH_BITS           110
#define SET_GL_STENCIL_BITS         111
#define SET_GL_ACCUM_BITS           112
#define SET_GL_ACCUM_RED_BITS       113
#define SET_GL_ACCUM_GREEN_BITS     114
#define SET_GL_ACCUM_BLUE_BITS      115
#define SET_GL_ACCUM_ALPHA_BITS     116
#define SET_GL_NUM_SAMPLES          117

#define SET_GL_2D_MODE              150
#define SET_GL_SCALE                151

#define POLL_EVENTS                 200

typedef void (BLITTER)(unsigned char *, int);

typedef struct _GFX_CHAR_CELL {
	FB_WCHAR ch;
	unsigned fg, bg;
} GFX_CHAR_CELL;

typedef struct FBGFX
{
	int id;                                 /**< Mode id number for contexts identification */
	int mode_num;                           /**< Current mode number */
	unsigned char **page;                   /**< Pages memory */
	int num_pages;                          /**< Number of requested pages */
	int visible_page;                       /**< Current visible page number */
	unsigned char *framebuffer;             /**< Our current visible framebuffer */
	int w, h;                               /**< Current mode width and height */
	int depth;                              /**< Current mode depth in bits per pixel */
	int bpp;                                /**< Bytes per pixel */
	int pitch;                              /**< Width of a framebuffer line in bytes */
	unsigned int *palette;                  /**< Current RGB color values for each palette index */
	unsigned int *device_palette;           /**< Current RGB color values of visible device palette */
	unsigned char *color_association;       /**< Palette color index associations for CGA/EGA emulation */
	char *dirty;                            /**< Dirty lines buffer */
	const struct GFXDRIVER *driver;         /**< Gfx driver in use */
	int color_mask;                         /**< Color bit mask for colordepth emulation */
	const struct PALETTE *default_palette;  /**< Default palette for current mode */
	int scanline_size;                      /**< Vertical size of a single scanline in pixels */
	int cursor_x, cursor_y;                 /**< Current graphical text cursor position (in chars, 0 based) */
	const struct FONT *font;                /**< Current font */
	int text_w, text_h;                     /**< Graphical text console size in characters */
	float aspect;                           /**< Aspect ratio (used in CIRCLE) */
	char *key;                              /**< Keyboard states */
	int refresh_rate;                       /**< Driver refresh rate */
	GFX_CHAR_CELL **con_pages;              /**< Character information for all pages */
	EVENT *event_queue;                     /**< The OS events queue array */
	int event_head, event_tail;             /**< Indices for the head and tail event in the array */
	FBMUTEX *event_mutex;                   /**< Mutex lock for accessing the events queue */
	volatile int flags;                     /**< Status flags */
	int lock_count;                         /**<Reference count for SCREENLOCK/UNLOCK */
} FBGFX;

typedef struct GFXDRIVER
{
	/** Name of the graphics driver.
	 *
	 * This string is compared case-insensitively with the FBGFX environment variable
	 * and/or the ScreenControl SET_DRIVER_NAME string, if those have been set,
	 * to override the automatic driver selection.
	 *
	 * This string must also be human-readable.
	 */
	char *name;

	/** Driver initialization function pointer.
	 *
	 * This function is called from fb_GfxScreen or fb_GfxScreenRes;
	 * the driver should first check to see if there are any flags that
	 * it does not support (for example, DRIVER_OPENGL).  If all flags
	 * specified are supported by this driver, the driver should attempt
	 * to set the requested mode.
	 *
	 * This function pointer must not be NULL.
	 *
	 * \param[in] title initial window title
	 * \param[in] w desired display mode width in pixels
	 * \param[in] h desired display mode height in pixels
	 * \param[in] refresh_rate desired refresh rate in Hz
	 * \param[in] flags DRIVER_ flags
	 *
	 * \return -1 on failure; 0 on success
	 */
	int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags);

	/** Driver exit function pointer.
	 *
	 * This function is called when a driver should clean up all allocated resources
	 * and restore the graphics device to its state before the driver was initialized.
	 *
	 * In some cases this function will be called even when a driver failed to initialize.
	 * It is the driver's responsibility to track which resources it has or has not allocated
	 * so that such resources are not released twice if the exit function is called when the
	 * init function failed.
	 *
	 * This function pointer must not be NULL.
	 */
	void (*exit)(void);

	/** Driver lock function pointer.
	 *
	 * The driver must not update the display from the internal framebuffer between calls to
	 * lock and unlock.
	 *
	 * This function pointer must not be NULL.
	 */
	void (*lock)(void);

	/** Driver unlock function pointer.
	 *
	 * This function pointer must not be NULL.
	 *
	 * \see lock
	 */
	void (*unlock)(void);

	/** Driver set palette function pointer.
	 *
	 * \param[in] index index of the palette entry to set in the range [0..255]
	 * \param[in] r red value in the range [0..63]
	 * \param[in] g green value in the range [0..63]
	 * \param[in] b blue value in the range [0..63]
	 */
	void (*set_palette)(int index, int r, int g, int b);

	/** Driver wait for vertical synchronization function pointer.
	 *
	 * This function should block until the next vertical retrace period.
	 * If it is not possible to use the actual hardware vertical retrace,
	 * this function should wait an amount of time equivalent to 1 / refresh_rate seconds.
	 *
	 * Can be NULL if the driver cannot wait for vsync.
	 */
	void (*wait_vsync)(void);

	/** Driver get mouse state function pointer.
	 *
	 * The driver should fill the parameters with the current mouse state.
	 * The driver can assume that all of the pointers are valid (non-null).
	 *
	 * Can be NULL if the driver cannot get the mouse state.
	 *
	 * \param[out] x x position in pixels relative to the graphics drawing area
	 * \param[out] y y position in pixels relative to the graphics drawing area
	 * \param[out] z scroll wheel position; initially 0
	 * \param[out] buttons bitfield with each bit representing the state of one button (1 if the button is pressed, 0 if not)
	 * \param[out] clip current mouse clipping status (1 if the mouse is currently clipped to the graphics drawing area; 0 if it is not)
	 * \return 0 on success; -1 on failure
	 */
	int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip);

	/** Driver set mouse state function pointer.
	 *
	 * Can be NULL if the driver cannot set the mouse state.
	 *
	 * \param[in] x x position in pixels relative to the graphics drawing area; if >= 0, the mouse cursor should be moved here; otherwise, this parameter should be ignored
	 * \param[in] y y position in pixels relative to the graphics drawing area; if >= 0, the mouse cursor should be moved here; otherwise, this parameter should be ignored
	 * \param[in] cursor cursor visibility state; if 0, the mouse cursor should be hidden; if > 0, the mouse cursor should be shown; otherwise, this parameter should be ignored
	 * \param[in] clip cursor clip state; if 0, the mouse cursor should be unclipped; if > 0, the mouse cursor should be clipped to the graphics drawing area; otherwise, this parameter should be ignored
	 */
	void (*set_mouse)(int x, int y, int cursor, int clip);

	/** Driver set window title function pointer.
	 *
	 * Can be NULL if the driver cannot set the window title.
	 *
	 * \param[in] title string to set the window title to
	 */
	void (*set_window_title)(char *title);

	/** Driver set/get window position function pointer.
	 *
	 * \param[in] x x position in pixels to move the window to, relative to the display device; if 0x80000000, ignore
	 * \param[in] y y position in pixels to move the window to, relative to the display device; if 0x80000000, ignore
	 * \return (current x position & 0xFFFF) | (current y position << 16)
	 */
	int (*set_window_pos)(int x, int y);

	/** Driver fetch mode list function pointer.
	 *
	 * This function returns a list of available modes for this driver.  The list need not be sorted or
	 * ordered in any way.
	 *
	 * Can be NULL if this driver cannot obtain a list of available modes.
	 *
	 * \param[in] depth bits per pixel for which to retrieve modes
	 * \param[in] size count of ints returned
	 * \return array of size ints allocated by malloc(), each containing (height | (width << 16)) for one of the available modes
	 */
	int *(*fetch_modes)(int depth, int *size);

	/** Driver page flip function pointer.
	 *
	 * This function flips the drawing page with the visible page.
	 * It is only needed for OpenGL drivers and can be NULL otherwise.
	 */
	void (*flip)(void);

	/** Driver poll events function pointer.
	 *
	 * This function should poll for event and post those that are available with fb_hPostEvent.
	 * It is only needed for OpenGL drivers and can be NULL otherwise.
	 */
	void (*poll_events)(void);

	/** Driver page update function pointer.
	 *
	 * Manually refresh the screen by copying from gfxlib2 memory to video memory
	 */
	void (*update)(void);
} GFXDRIVER;

typedef struct PALETTE
{
	const int colors;
	const unsigned char *data;
} PALETTE;

typedef struct FONT
{
	const int w;
	const int h;
	const unsigned char *data;
} FONT;

struct _PUT_HEADER {
	union {
		struct {
			unsigned short bpp:3;
			unsigned short width:13;
			unsigned short height;
		} old;
		unsigned int type;
	};
	int bpp;
	unsigned int width;
	unsigned int height;
	unsigned int pitch;
	unsigned int tex;
	char _reserved[8];
	unsigned char data[0];
} FBPACKED;
typedef struct _PUT_HEADER PUT_HEADER;

/* Global variables */
extern FBGFX *__fb_gfx;
extern char *__fb_gfx_driver_name;
extern const GFXDRIVER *__fb_gfx_drivers_list[];
extern const GFXDRIVER __fb_gfxDriverNull;
extern void *(*fb_hMemCpy)(void *dest, const void *src, size_t size);
extern void *(*fb_hMemSet)(void *dest, int value, size_t size);
extern void *(*fb_hPixelCpy)(void *dest, const void *src, size_t size);
extern void *(*fb_hPixelSet)(void *dest, int color, size_t size);
extern unsigned int *__fb_color_conv_16to32;
extern char *__fb_window_title;

/* must match data.c */
enum {
	FB_FONT_8 = 0,
	FB_FONT_14,
	FB_FONT_16,
	FB_FONT_COUNT
};

/* must match data.c */
enum {
	FB_PALETTE_2 = 0,
	FB_PALETTE_16,
	FB_PALETTE_64,
	FB_PALETTE_256,
	FB_PALETTE_COUNT
};

extern const FONT __fb_font[FB_FONT_COUNT];
extern const PALETTE __fb_palette[FB_PALETTE_COUNT];

/* Internal functions */
extern FB_GFXCTX *fb_hGetContext(void);
extern void fb_hSetupFuncs(int bpp);
extern void fb_hSetupData(void);
extern FBCALL int fb_hEncode(const unsigned char *in_buffer, ssize_t in_size, unsigned char *out_buffer, ssize_t *out_size);
extern FBCALL int fb_hDecode(const unsigned char *in_buffer, ssize_t in_size, unsigned char *out_buffer, ssize_t *out_size);
extern void fb_hPostEvent(EVENT *e);
extern void fb_hPostKey(int key);
extern BLITTER *fb_hGetBlitter(int device_depth, int is_rgb);
extern unsigned int fb_hMakeColor(int bpp, unsigned int index, int r, int g, int b);
extern unsigned int fb_hFixColor(int bpp, unsigned int color);
extern void fb_hRestorePalette(void);
extern void fb_hSetPaletteColorRgb(int index, int r, int g, int b);
extern void fb_hSetPaletteColor(int index, unsigned int color);
extern void fb_hPrepareTarget(FB_GFXCTX *ctx, void *target);
extern void fb_hSetPixelTransfer(FB_GFXCTX *ctx, unsigned int color);
extern void fb_hTranslateCoord(FB_GFXCTX *ctx, float fx, float fy, int *x, int *y);
extern void fb_hFixRelative(FB_GFXCTX *ctx, int coord_type, float *x1, float *y1, float *x2, float *y2);
extern void fb_hFixCoordsOrder(int *x1, int *y1, int *x2, int *y2);
extern void fb_GfxDrawLine(FB_GFXCTX *context, int x1, int y1, int x2, int y2, unsigned int color, unsigned int style);
extern void fb_hGfxBox(int x1, int y1, int x2, int y2, unsigned int color, int full, unsigned int style);
extern void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);
extern void *fb_hMemCpyMMX(void *dest, const void *src, size_t size);
extern void *fb_hMemSetMMX(void *dest, int value, size_t size);
extern void fb_hResetCharCells(FB_GFXCTX *context, int do_alloc);
extern void fb_hClearCharCells(int x1, int y1, int x2, int y2, int page, FB_WCHAR ch, unsigned fg, unsigned bg);
extern void fb_hSoftCursorInit(void);
extern void fb_hSoftCursorExit(void);
extern void fb_hSoftCursorPut(int x, int y);
extern void fb_hSoftCursorUnput(int x, int y);
extern void fb_hSoftCursorPaletteChanged(void);
extern int fb_hColorDistance(int index, int r, int g, int b);
extern void *fb_hPixelSetAlpha4(void *dest, int color, size_t size);
extern ssize_t fb_hGetWindowHandle(void);
extern ssize_t fb_hGetDisplayHandle(void);


/* Public API */
extern FBCALL int fb_GfxScreen(int mode, int depth, int num_pages, int flags, int refresh_rate);
extern FBCALL int fb_GfxScreenQB(int mode, int visible, int active);
extern FBCALL int fb_GfxScreenRes(int width, int height, int depth, int num_pages, int flags, int refresh_rate);
extern FBCALL void fb_GfxScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *bpp, ssize_t *pitch, ssize_t *refresh_rate, FBSTRING *driver);
extern FBCALL void fb_GfxScreenInfo32(int *width, int *height, int *depth, int *bpp, int *pitch, int *refresh_rate, FBSTRING *driver);
extern FBCALL void fb_GfxScreenInfo64(long long *width, long long  *height, long long  *depth, long long  *bpp, long long  *pitch, long long  *refresh_rate, FBSTRING *driver);
extern FBCALL int fb_GfxScreenList(int depth);
extern FBCALL void *fb_GfxImageCreate(int width, int height, unsigned int color, int depth, int flags);
extern FBCALL void *fb_GfxImageCreateQB(int width, int height, unsigned int color, int depth, int flags);
extern FBCALL void fb_GfxImageDestroy(void *image);
extern FBCALL int fb_GfxImageInfo(void *img, ssize_t *width, ssize_t *height, ssize_t *bpp, ssize_t *pitch, void **imgdata, ssize_t *size);
extern FBCALL int fb_GfxImageInfo32(void *img, int *width, int *height, int *bpp, int *pitch, void **imgdata, int *size);
extern FBCALL int fb_GfxImageInfo64(void *img, long long *width, long long *height, long long *bpp, long long *pitch, void **imgdata, long long *size);
extern FBCALL void fb_GfxPalette(int index, int r, int g, int b);
extern FBCALL void fb_GfxPaletteUsing(int *data);
extern FBCALL void fb_GfxPaletteUsing64(long long *data);
extern FBCALL void fb_GfxPaletteGet(int index, int *r, int *g, int *b);
extern FBCALL void fb_GfxPaletteGet64(int index, long long *r, long long *g, long long *b);
extern FBCALL void fb_GfxPaletteGetUsing(int *data);
extern FBCALL void fb_GfxPaletteGetUsing64(long long *data);
extern FBCALL void fb_GfxPset(void *target, float x, float y, unsigned int color, int coord_type, int ispreset);
extern FBCALL unsigned int fb_GfxPoint(void *target, float x, float y);
extern FBCALL float fb_GfxPMap(float coord, int func);
extern FBCALL float fb_GfxCursor(int func);
extern FBCALL void fb_GfxView(int x1, int y1, int x2, int y2, unsigned int fill_color, unsigned int border_color, int screen);
extern FBCALL void fb_GfxWindow(float x1, float y1, float x2, float y2, int screen);
extern FBCALL void fb_GfxLine(void *target, float x1, float y1, float x2, float y2, unsigned int color, int type, unsigned int style, int coord_type);
extern FBCALL void fb_GfxEllipse(void *target, float x, float y, float radius, unsigned int color, float aspect, float start, float end, int fill, int coord_type);
extern FBCALL int fb_GfxGet(void *target, float x1, float y1, float x2, float y2, unsigned char *dest, int coord_type, FBARRAY *array);
extern FBCALL int fb_GfxGetQB(void *target, float x1, float y1, float x2, float y2, unsigned char *dest, int coord_type, FBARRAY *array);
extern FBCALL int fb_GfxPut(void *target, float x, float y, unsigned char *src, int x1, int y1, int x2, int y2, int coord_type, int mode, PUTTER *putter, int alpha, BLENDER *blender, void *param);
extern FBCALL int fb_GfxWaitVSync(void);
extern FBCALL void fb_GfxPaint(void *target, float fx, float fy, unsigned int color, unsigned int border_color, FBSTRING *pattern, int mode, int coord_type);
extern FBCALL void fb_GfxDraw(void *target, FBSTRING *command);
extern FBCALL int fb_GfxDrawString(void *target, float fx, float fy, int coord_type, FBSTRING *string, unsigned int color, void *font, int mode, PUTTER *putter, BLENDER *blender, void *param);
extern FBCALL int fb_GfxFlip(int from_page, int to_page);
extern FBCALL void fb_GfxLock(void);
extern FBCALL void fb_GfxUnlock(int start_line, int end_line);
extern FBCALL void *fb_GfxScreenPtr(void);
extern FBCALL void fb_GfxSetWindowTitle(FBSTRING *title);
extern FBCALL int fb_GfxGetJoystick(int id, ssize_t *buttons, float *a1, float *a2, float *a3, float *a4, float *a5, float *a6, float *a7, float *a8);
extern FBCALL int fb_GfxEvent(EVENT *event);
extern FBCALL void fb_GfxControl_s(int what, FBSTRING *param);
extern FBCALL void fb_GfxControl_i(int what, ssize_t *param1, ssize_t *param2, ssize_t *param3, ssize_t *param4);
extern FBCALL void fb_GfxControl_i32(int what, int *param1, int *param2, int *param3, int *param4);
extern FBCALL void fb_GfxControl_i64(int what, long long *param1, long long *param2, long long *param3, long long *param4);
extern FBCALL int fb_GfxBload(FBSTRING *filename, void *dest, void *pal);
extern FBCALL int fb_GfxBloadQB(FBSTRING *filename, void *dest, void *pal);
extern FBCALL int fb_GfxBsave(FBSTRING *filename, void *src, unsigned int size, void *pal);
extern FBCALL int fb_GfxBsaveEx(FBSTRING *filename, void *src, unsigned int size, void *pal, int bitsperpixel);
extern FBCALL void *fb_GfxGetGLProcAddress(const char *proc);

/* Public API - QB compatibility */
extern FBCALL int fb_GfxStickQB( int n );
extern FBCALL int fb_GfxStrigQB( int n );


/* Runtime library hooks */
int fb_GfxGetkey(void);
FBSTRING *fb_GfxInkey(void);
int fb_GfxKeyHit(void);
unsigned int fb_GfxColor(unsigned int fg_color, unsigned int bg_color, int flags);
void fb_GfxClear(int mode);
int fb_GfxWidth(int w, int h);
int fb_GfxLocateRaw(int y, int x, int cursor);
int fb_GfxLocate(int y, int x, int cursor);
int fb_GfxGetX(void);
int fb_GfxGetY(void);
void fb_GfxGetXY(int *col, int *row);
void fb_GfxGetSize(int *cols, int *rows);
void fb_GfxPrintBuffer(const char *buffer, int mask);
void fb_GfxPrintBufferWstr(const FB_WCHAR *buffer, int mask);
void fb_GfxPrintBufferEx(const void *buffer, size_t len, int mask);
void fb_GfxPrintBufferWstrEx(const FB_WCHAR *buffer, size_t len, int mask);
char *fb_GfxReadStr(char *buffer, ssize_t maxlen);
int fb_GfxMultikey(int scancode);
int fb_GfxGetMouse(int *x, int *y, int *z, int *buttons, int *clip);
int fb_GfxSetMouse(int x, int y, int cursor, int clip);
int fb_GfxOut(unsigned short port, unsigned char value);
int fb_GfxIn(unsigned short port);
int fb_GfxLineInput( FBSTRING *text, void *dst, ssize_t dst_len, int fillrem, int addquestion, int addnewline );
int fb_GfxLineInputWstr( const FB_WCHAR *text, FB_WCHAR *dst, ssize_t max_chars, int addquestion, int addnewline );
unsigned int fb_GfxReadXY( int col, int row, int colorflag );
void fb_GfxSleep( int msecs );
int fb_GfxIsRedir( int is_input );
int fb_GfxPageCopy(int from_page, int to_page);
int fb_GfxPageSet(int work_page, int visible_page);

typedef void (*FBGFX_IMAGE_CONVERT)(const unsigned char *, unsigned char *, int);

void fb_image_convert_8to8(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_8to16(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_8to32(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_24to16(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_24to32(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_32to16(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_32to32(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_24bgrto16(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_24bgrto32(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_32bgrto16(const unsigned char *src, unsigned char *dest, int w);
void fb_image_convert_32bgrto32(const unsigned char *src, unsigned char *dest, int w);

FBCALL void fb_GfxImageConvertRow( const unsigned char *src, int src_bpp, unsigned char *dest, int dst_bpp, int width, int isrgb );

void fb_hPutTrans (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutPSet  (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutPReset(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutAnd   (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutOr    (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutXor   (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutAlpha (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutBlend (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutAdd   (unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);
void fb_hPutCustom(unsigned char *src, unsigned char *dest, int w, int h, int src_pitch, int dest_pitch, int alpha, BLENDER *blender, void *param);

/** Returns TRUE if application is in graphics mode.
 */
#define FB_GFX_ACTIVE() \
    (__fb_gfx!=NULL)

/** Returns the code page as integral value.
 *
 * This function returns the code page as integral value. When the code page
 * cannot be expressed as an integral value (like UTF-8 or UCS-4), it returns
 * -1 and the character set ID should be used instead.
 */
#define FB_GFX_GET_CODEPAGE() \
    437

/** Returns the character set as a string.
 */
#define FB_GFX_GET_CHARSET() \
    "CP437"

#endif
