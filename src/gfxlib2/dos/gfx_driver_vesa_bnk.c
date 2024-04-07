/* banked VESA gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_dos.h"

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_update(void);
static void end_of_driver_update(void);
static void fb_dos_vesa_set_bank_int(void);
static void fb_dos_vesa_set_bank_int_end(void);
extern void fb_dos_vesa_set_bank_pm(void);
extern void fb_dos_vesa_set_bank_pm_end(void);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverVESA =
{
	"VESA banked",           /* char *name; */
	driver_init,             /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,             /* void (*exit)(void); */
	fb_dos_lock,             /* void (*lock)(void); */
	fb_dos_unlock,           /* void (*unlock)(void); */
	fb_dos_set_palette,      /* void (*set_palette)(int index, int r, int g, int b); */
	fb_dos_vga_wait_vsync,   /* void (*wait_vsync)(void); */
	fb_dos_get_mouse,        /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	fb_dos_set_mouse,        /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	fb_dos_set_window_title, /* void (*set_window_title)(char *title); */
	NULL,                    /* int (*set_window_pos)(int x, int y); */
	fb_dos_vesa_fetch_modes, /* int *(*fetch_modes)(int depth, int *size); */
	NULL,                    /* void (*flip)(void); */
	NULL,                    /* void (*poll_events)(void); */
	NULL                     /* void (*update)(void); */
};

static int data_locked = FALSE;
static void (*fb_dos_vesa_set_bank)(void) = NULL;
static BLITTER *blitter = NULL;
static unsigned char *buffer = NULL;

int fb_dos_vesa_bank_number = 0;

static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	int depth = MAX(8, depth_arg);
	int is_rgb = FALSE;
	int bpp;
	
	fb_dos_detect();
	fb_dos_vesa_detect();
	
	if (flags & DRIVER_OPENGL)
		return -1;
	
	if (!fb_dos.vesa_ok)
		return -1;
	
	if (fb_dos_vesa_set_mode(w, h, depth, FALSE))
		return -1;
	
	vesa_get_pm_functions();
	
	if (fb_dos_vesa_pm_bank_switcher)
		fb_dos_vesa_set_bank = fb_dos_vesa_set_bank_pm;
	else
		fb_dos_vesa_set_bank = fb_dos_vesa_set_bank_int;
	
	refresh_rate = 60; /* FIXME */
	
	is_rgb = (depth > 8) && (fb_dos.vesa_mode_info.RedFieldPosition == 0);
	
	if (fb_dos.vesa_mode_info.BlueFieldPosition == 10 || fb_dos.vesa_mode_info.RedFieldPosition == 10)
		bpp = 15;
	else if (fb_dos.vesa_mode_info.BlueFieldPosition == 11 || fb_dos.vesa_mode_info.RedFieldPosition == 11)
		bpp = 16;
	else
		bpp = fb_dos.vesa_mode_info.BitsPerPixel;
	
	if( depth != bpp || is_rgb )
	{
		blitter = fb_hGetBlitter(bpp, is_rgb);
		if( !blitter )
			return -1;
		
		buffer = malloc( fb_dos.vesa_mode_info.YResolution * fb_dos.vesa_mode_info.BytesPerScanLine );
		if( !buffer )
			return -1;
	}
	else
	{
		blitter = NULL;
		buffer = NULL;
	}
	
	fb_dos_lock_data( &fb_dos_vesa_set_bank, sizeof(fb_dos_vesa_set_bank) );
	fb_dos_lock_data( &fb_dos_vesa_pm_info, sizeof(fb_dos_vesa_pm_info) );
	fb_dos_lock_data( &blitter, sizeof(blitter) );
	fb_dos_lock_code( (void *)fb_dos_vesa_set_bank_pm, (void *)fb_dos_vesa_set_bank_pm_end - (void *)fb_dos_vesa_set_bank_pm );
	fb_dos_lock_code( (void *)fb_dos_vesa_set_bank_int, (void *)fb_dos_vesa_set_bank_int_end - (void *)fb_dos_vesa_set_bank_int );
	if( buffer )
	{
		fb_dos_lock_data( &buffer, sizeof(buffer) );
		fb_dos_lock_data( buffer, h * __fb_gfx->pitch );
	}
	data_locked = TRUE;

	fb_dos.update = driver_update;
	fb_dos.update_len = (unsigned int)end_of_driver_update - (unsigned int)driver_update;
	fb_dos.set_palette = fb_dos_vesa_set_palette;

	return fb_dos_init(title, w, h, depth, refresh_rate, flags);
}

static void driver_exit(void)
{
	if( data_locked )
	{
			fb_dos_unlock_data( &fb_dos_vesa_set_bank, sizeof(fb_dos_vesa_set_bank) );
			fb_dos_unlock_data( &fb_dos_vesa_pm_info, sizeof(fb_dos_vesa_pm_info) );
			fb_dos_unlock_data( &blitter, sizeof(blitter) );
			fb_dos_unlock_code( (void *)fb_dos_vesa_set_bank_pm, (void *)fb_dos_vesa_set_bank_pm_end - (void *)fb_dos_vesa_set_bank_pm );
			fb_dos_unlock_code( (void *)fb_dos_vesa_set_bank_int, (void *)fb_dos_vesa_set_bank_int_end - (void *)fb_dos_vesa_set_bank_int );
			data_locked = FALSE;
	}
	
	if( buffer )
	{
		fb_dos_unlock_data( &buffer, sizeof(buffer) );
		fb_dos_unlock_data( buffer, fb_dos.vesa_mode_info.YResolution * fb_dos.vesa_mode_info.BytesPerScanLine );
		free( buffer );
		buffer = NULL;
	}
	
	fb_dos_exit();
}

static void fb_dos_vesa_set_bank_int(void)
{
	/* set write bank of window A based on fb_dos_vesa_bank_number */
	fb_dos.regs.x.ax = 0x4F05;
	fb_dos.regs.x.bx = 0;
	fb_dos.regs.x.dx = fb_dos_vesa_bank_number;
	__dpmi_int(0x10, &fb_dos.regs);
}
static void fb_dos_vesa_set_bank_int_end(void) { }

static void driver_update(void)
{
	int curr_bank = -1;
	unsigned char *memory_buffer;
	unsigned char *framebuffer;
	int framebuffer_start;
	int bank_size;
	int bank_granularity;
	int bank_add;
	int todo;
	int copy_size;
	int y1, y2;

	if( blitter )
	{
		blitter(buffer, fb_dos.vesa_mode_info.BytesPerScanLine);
		framebuffer = buffer;
	}
	else
	{
		framebuffer = __fb_gfx->framebuffer;
	}

	bank_size = fb_dos.vesa_mode_info.WinSize * 1024;
	bank_granularity = fb_dos.vesa_mode_info.WinGranularity * 1024;
	bank_add = bank_size / bank_granularity;
	
	for (y1 = 0; y1 < fb_dos.h; y1++) {
		if (__fb_gfx->dirty[y1]) {
			for (y2 = fb_dos.h - 1; !__fb_gfx->dirty[y2]; y2--)
				;
			
			fb_dos_vesa_bank_number = (y1 * __fb_gfx->pitch) / bank_granularity;
			
			framebuffer_start = fb_dos_vesa_bank_number * bank_granularity;
			
			todo = ((y2 + 1) * __fb_gfx->pitch) - framebuffer_start;
			
			memory_buffer = framebuffer + framebuffer_start;
			
			while (todo > 0) {
				/* select the appropriate bank */
				if (curr_bank != fb_dos_vesa_bank_number) {
					curr_bank = fb_dos_vesa_bank_number;
					
					fb_dos_vesa_set_bank();
				}
				
				/* how much can we copy in one go? */
				if (todo > bank_size)
					copy_size = bank_size;
				else
					copy_size = todo;
				
				/* copy a bank of data to the screen */
				dosmemput(memory_buffer, copy_size, 0xA0000);
				
				/* move on to the next bank of data */
				todo -= copy_size;
				memory_buffer += copy_size;
				fb_dos_vesa_bank_number += bank_add;
			}
			
			break;
		}
	}
}
static void end_of_driver_update(void) { /* do not remove */ }
