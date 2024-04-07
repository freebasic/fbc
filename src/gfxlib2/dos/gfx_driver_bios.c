/* BIOS gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_dos.h"
#include <go32.h>
#include <pc.h>

typedef void (*fnUpdate)(void);

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_update_bpp1(void);
static void driver_update_bpp2(void);
static void driver_update_bpp4(void);
static void end_of_driver_update(void);
static int *driver_fetch_modes(int depth, int *size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverBIOS =
{
	"BIOS",                  /* char *name; */
	driver_init,             /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	fb_dos_exit,             /* void (*exit)(void); */
	fb_dos_lock,             /* void (*lock)(void); */
	fb_dos_unlock,           /* void (*unlock)(void); */
	fb_dos_set_palette,      /* void (*set_palette)(int index, int r, int g, int b); */
	fb_dos_vga_wait_vsync,   /* void (*wait_vsync)(void); */
	fb_dos_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_dos_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_dos_set_window_title, /* void (*set_window_title)(char *title); */
	NULL,                    /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes,      /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                    /* void (*flip)(void); */
	NULL,                    /* void (*poll_events)(void); */
	NULL                     /* void (*update)(void); */
};

static const int res_bpp1[] = {
	SCREENLIST(640, 200),     /* 0x06 */
    SCREENLIST(640, 350),     /* 0x0F */
    SCREENLIST(640, 480),     /* 0x11 */
    0
};
static const unsigned char mode_bpp1[] = {
	0x06, 0x0F, 0x11, 0
};
static const int res_bpp2[] = {
	SCREENLIST(320, 200),     /* 0x04 */
    0
};
static const unsigned char mode_bpp2[] = {
	0x04, 0
};
static const int res_bpp4[] = {
#if 0
	SCREENLIST(320, 200),     /* 0x0D */
	SCREENLIST(640, 200),     /* 0x0E */
#endif
	SCREENLIST(640, 350),     /* 0x10 */
    SCREENLIST(640, 480),     /* 0x12 */
    0
};
static const unsigned char mode_bpp4[] = {
#if 0
    0x0D, 0x0E,
#endif
    0x10, 0x12,
    0
};

typedef struct _driver_depth_modes {
    int bit_depth;
    const int * resolutions;
    const unsigned char * modes;
    fnUpdate pfnUpdate;
} driver_depth_modes;

static const driver_depth_modes scr_modes[] = {
    { 1, res_bpp1, mode_bpp1, driver_update_bpp1 },
    { 2, res_bpp2, mode_bpp2, driver_update_bpp2 },
    { 4, res_bpp4, mode_bpp4, driver_update_bpp4 }
};

#define DRV_DEPTH_COUNT (sizeof(scr_modes)/sizeof(scr_modes[0]))

static unsigned char uchScanLineBuffer[ 640 ];

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
    int i;
    unsigned char uchNewMode;
    const driver_depth_modes *depth_modes = NULL;
    int iResCount, iFoundRes;

    fb_dos_detect();

    /* Remove this dumb "fake" scan line size */
    h /= __fb_gfx->scanline_size;

	if (flags & DRIVER_OPENGL)
		return -1;

    for( i=0; i!=DRV_DEPTH_COUNT; ++i ) {
        if( scr_modes[i].bit_depth == depth ) {
            depth_modes = scr_modes + i;
            break;
        }
    }

    if (depth_modes == NULL)
        return -1;

    iResCount = 0;
    while( depth_modes->resolutions[ iResCount ]!=0 )
        ++iResCount;

    iFoundRes = iResCount;
    for( i=0; i!=iResCount; ++i ) {
        if( depth_modes->resolutions[ i ]==SCREENLIST( w, h ) ) {
            iFoundRes = i;
            break;
        }
    }

    if( iFoundRes==iResCount )
        return -1;

    fb_dos.regs.h.ah = 0x00;
    fb_dos.regs.h.al = depth_modes->modes[ iFoundRes ];
    __dpmi_int(0x10, &fb_dos.regs);

    _movedatab( _dos_ds, 0x449, _my_ds(), (int) &uchNewMode, 1 );
    if( uchNewMode!=depth_modes->modes[ iFoundRes ] )
        return -1;

    /* We only need a scanline_size of 1 because the doubling will be done
     * by the graphics card itself. */
    __fb_gfx->scanline_size = 1;
    refresh_rate = 70;

    fb_dos.bios_mode = depth_modes->modes[ iFoundRes ];
	fb_dos.update = depth_modes->pfnUpdate;
    fb_dos.update_len = (unsigned char*)end_of_driver_update - (unsigned char*)fb_dos.update;
    if( fb_dos.bios_mode >= 0x11 ) {
        /* 16 or 256 colors out of 64*64*64 (262144) */
        fb_dos.set_palette = fb_dos_vga_set_palette;
    } else if( fb_dos.bios_mode >= 0x0D ) {
        /* FIXME: Implement setting the palette for EGA cards.
         *        (2 or 16 out of 64) */
        fb_dos.set_palette = NULL;
    } else {
        /* FIXME: Implement setting the palette for CGA cards.
         *        Two sets of four colors. */
        fb_dos.set_palette = NULL;
    }

	return fb_dos_init(title, w, h, depth, refresh_rate, flags);

}

static void init_planar_access( void )
{
    /* Write mask: Allow all bits */
    outportb(0x3CE, 0x08);
    outportb(0x3CF, 0xFF);

    /* Write mode: 0 */
    outportb(0x3CE, 0x05);
    outportb(0x3CF, 0x00);

    /* Overwrite mode, no rotation */
    outportb(0x3CE, 0x03);
    outportb(0x3CF, 0x00);

    /* Enable write access for plane "plane" */
    outportb(0x3C4, 0x02);
}

static void driver_update_planar_ega_vga( unsigned int planes )
{
    /* EGA/VGA planar mode */
    int y;
    unsigned w = fb_dos.w, w8 = w >> 3, w32 = w >> 5;
    unsigned char *buffer = (unsigned char *)__fb_gfx->framebuffer;
    unsigned screen_offset = 0xA0000;
    static const unsigned char vga_bitmap[8] = {
        128, 64, 32, 16, 8, 4, 2, 1
    };
    static const unsigned char bitmask[4] = {
        1, 2, 4, 8
    };
    unsigned uiDestOffset[4] = { 0, w8, w8*2, w8*3 };

    init_planar_access();

    for (y = 0;
         y != fb_dos.h;
         ++y)
    {
        if (__fb_gfx->dirty[y]) {
            unsigned x, uiDestIndex = 0;
            unsigned char *pFrameBuffer = buffer;
            unsigned plane;

            /* Split "per pixel" color values into a plane oriented
             * representation */
            for( x=0; x!=w; x+=8 ) {
                unsigned i;
                for( plane=0; plane!=planes; ++plane ) {
                    unsigned char color_mask = bitmask[plane];
                    unsigned char pattern = 0;
                    for( i=0; i!=8; ++i ) {
                        if (pFrameBuffer[i] & color_mask)
                            pattern |= vga_bitmap[i];
                    }
                    uchScanLineBuffer[ uiDestOffset[plane] + uiDestIndex ] = pattern;
                }
                pFrameBuffer += 8;
                ++uiDestIndex;
            }
            for( plane=0; plane!=planes; ++plane ) {
                outportb(0x3C5, bitmask[plane] ); /* Select plane */
                _movedatal(_my_ds(),
                           (int) uchScanLineBuffer + uiDestOffset[ plane ],
                           _dos_ds,
                           screen_offset,
                           w32);
            }
        }
        buffer += w;
        screen_offset += w8;
    }
}

static void driver_update_bpp1(void)
{
    if( fb_dos.bios_mode==0x06 ) {
        /* CGA interlaced mode */
        int y, w = fb_dos.w, w4 = w >> 2, w8 = w >> 3, w32 = w >> 5;
        unsigned int *buffer = (unsigned int *)__fb_gfx->framebuffer;
        unsigned int screen_even = 0xB8000;
        unsigned int screen_odd  = 0xBA000;

        for (y = 0;
             y != fb_dos.h;
             ++y)
        {
            unsigned int *pScreenOffset = ( ((y & 1)==0) ? &screen_even : &screen_odd );
            if (__fb_gfx->dirty[y]) {
                unsigned dx = w8;
                unsigned x = w4;
                unsigned char uchDst = 0;
                while( x-- ) {
                    unsigned value = buffer[x];
                    if( x & 1 ) {
                        uchDst = (unsigned char)
                            (
                             ((value & 0x01000000) >> 24) +
                             ((value & 0x00010000) >> 15) +
                             ((value & 0x00000100) >>  6) +
                             ((value & 0x00000001) <<  3)
                            );
                    } else {
                        uchScanLineBuffer[dx--] = (unsigned char)
                            (
                             uchDst +
                             (
                              ((value & 0x01000000) >> 20) +
                              ((value & 0x00010000) >> 11) +
                              ((value & 0x00000100) >>  2) +
                              ((value & 0x00000001) <<  7)
                             )
                            );
                    }
                }
                _movedatal(_my_ds(), (int) uchScanLineBuffer,
                           _dos_ds, *pScreenOffset,
                           w32);
            }
            buffer += w4;
            *pScreenOffset += w8;
        }
    } else {
        /* EGA/VGA linear mode */
        int y, w = fb_dos.w, w4 = w >> 2, w8 = w >> 3, w32 = w >> 5;
        unsigned int *buffer = (unsigned int *)__fb_gfx->framebuffer;
        unsigned int screen_offset = 0xA0000;

        init_planar_access();
        outportb(0x3C5, 0x0F); /* All planes */

        for (y = 0;
             y != fb_dos.h;
             ++y)
        {
            if (__fb_gfx->dirty[y]) {
                unsigned dx = w8;
                unsigned x = w4;
                unsigned char uchDst = 0;
                while( x-- ) {
                    unsigned value = buffer[x];
                    if( x & 1 ) {
                        uchDst = (unsigned char)
                            (
                             ((value & 0x01000000) >> 24) +
                             ((value & 0x00010000) >> 15) +
                             ((value & 0x00000100) >>  6) +
                             ((value & 0x00000001) <<  3)
                            );
                    } else {
                        uchScanLineBuffer[dx--] = (unsigned char)
                            (
                             uchDst +
                             (
                              ((value & 0x01000000) >> 20) +
                              ((value & 0x00010000) >> 11) +
                              ((value & 0x00000100) >>  2) +
                              ((value & 0x00000001) <<  7)
                             )
                            );
                    }
                }
                _movedatal(_my_ds(), (int) uchScanLineBuffer,
                           _dos_ds, screen_offset,
                           w32);
            }
            buffer += w4;
            screen_offset += w8;
        }
    }
}

static void driver_update_bpp2(void)
{
	int y, w = fb_dos.w, w4 = w >> 2, w16 = w >> 4;
	unsigned int *buffer = (unsigned int *)__fb_gfx->framebuffer;
    unsigned int screen_even = 0xB8000;
    unsigned int screen_odd  = 0xBA000;

    for (y = 0;
         y != fb_dos.h;
         ++y)
    {
        unsigned int *pScreenOffset = ( ((y & 1)==0) ? &screen_even : &screen_odd );
        if (__fb_gfx->dirty[y]) {
            unsigned x = w4;
            while( x-- ) {
                unsigned value = buffer[x];
                uchScanLineBuffer[x] = (unsigned char)
                    (
                     ((value & 0x03000000) >> 24) +
                     ((value & 0x00030000) >> 14) +
                     ((value & 0x00000300) >>  4) +
                     ((value & 0x00000003) <<  6)
                    );
            }
            _movedatal(_my_ds(), (int) uchScanLineBuffer,
                       _dos_ds, *pScreenOffset,
                       w16);
        }
        buffer += w4;
        *pScreenOffset += w4;
    }
}

static void driver_update_bpp4(void)
{
    /* FIXME: This has to be implemented soon (to support SCREEN 12
     * and others) */
    if( fb_dos.bios_mode >= 0x10 ) {
        driver_update_planar_ega_vga( 4 );
    }
}
static void end_of_driver_update(void) { /* do not remove */ }

static int *driver_fetch_modes(int depth, int *size)
{
    int i;
    const driver_depth_modes *depth_modes = NULL;
    int iResCount;
#ifdef DEBUG
    int iModeCount;
#endif
    for( i=0; i!=DRV_DEPTH_COUNT; ++i ) {
        if( scr_modes[i].bit_depth == depth ) {
            depth_modes = scr_modes + i;
            break;
        }
    }

    if (depth_modes == NULL)
        return NULL;

    iResCount = 0;
    while( depth_modes->resolutions[ iResCount ]!=0 )
        ++iResCount;

#ifdef DEBUG
    iModeCount = 0;
    while( depth_modes->modes[ iModeCount ]!=0 )
        ++iModeCount;
    DBG_ASSERT( iModeCount==iResCount );
#endif

	*size = iResCount;
    return memcpy((void*)malloc(iResCount * sizeof( int )),
                  depth_modes->resolutions, iResCount * sizeof( int ));
}
