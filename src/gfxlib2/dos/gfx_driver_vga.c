/* VGA gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_dos.h"
#include <pc.h>
#include <go32.h>

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_update(void);
static void end_of_driver_update(void);
static int *driver_fetch_modes(int depth, int *size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverVGA =
{
	"VGA",                   /* char *name; */
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

static int modes[] = {
	SCREENLIST(320, 200),
	SCREENLIST(320, 100),
	SCREENLIST(256, 256),
	SCREENLIST(160, 120),
	SCREENLIST(80, 80)
};

static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags)
{
	int depth = depth_arg;
	int c;

	fb_dos_detect();
	
	if (flags & DRIVER_OPENGL)
		return -1;
	
	if (depth != 8) return -1;
	
	fb_dos.regs.x.ax = 0x13;
	
	if ((w == 320) && (h == 200)) {
		__dpmi_int(0x10, &fb_dos.regs);
		
		refresh_rate = 70;
	} else if ((w == 320) && (h == 100)) {
		__dpmi_int(0x10, &fb_dos.regs);
		
		outportb(0x3D4, 9);
		outportb(0x3D5, inportb(0x3D5) | 0x80);
		
		refresh_rate = 70;
	} else if ((w == 256) && (h == 256)) {
		__dpmi_int(0x10, &fb_dos.regs);
		
		outportb(0x3D4, 0x11);
		c = inportb(0x3D5) & 0x7F;
		outportb(0x3D4, (c << 8) | 0x11);
		outportb(0x3D5, c);
		
		outportb(0x3C2, 0xE3);
		outportw(0x3D4, 0x5F00);
		outportw(0x3D4, 0x3F01);
		outportw(0x3D4, 0x4002);
		outportw(0x3D4, 0x8203);
		outportw(0x3D4, 0x4A04);
		outportw(0x3D4, 0x9A05);
		outportw(0x3D4, 0x2306);
		outportw(0x3D4, 0xB207);
		outportw(0x3D4, 0x0008);
		outportw(0x3D4, 0x6109);
		outportw(0x3D4, 0x0A10);
		outportw(0x3D4, 0xAC11);
		outportw(0x3D4, 0xFF12);
		outportw(0x3D4, 0x2013);
		outportw(0x3D4, 0x4014);
		outportw(0x3D4, 0x0715);
		outportw(0x3D4, 0x1A16);
		outportw(0x3D4, 0xA317);
		outportw(0x3C4, 0x0101);
		outportw(0x3C4, 0x0E04);
		outportw(0x3CE, 0x4005);
		outportw(0x3CE, 0x0506);
		
		inportb(0x3DA);
		outportb(0x3C0, 0x30);
		outportb(0x3C0, 0x41);
		
		inportb(0x3DA);
		outportb(0x3C0, 0x33);
		outportb(0x3C0, 0x00);
		
		outportb(0x3C6, 0xFF);
		
		refresh_rate = 70;
	} else if ((w == 160) && (h == 120)) {
		fb_dos.regs.x.ax = 0x0D;
		__dpmi_int(0x10, &fb_dos.regs);

		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5)&0x7F);
		outportb(0x3D4, 0x04);
		outportb(0x3D5, inportb(0x3D5)+1);
		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5)|0x80);
		
		outportb(0x3C2, (inportb(0x3CC)&~0xC0)|0x80);
		
		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5)&0x7F);
		
		outportb(0x3D4, 0x06);
		outportb(0x3D5, 0x0B);
		
		outportb(0x3D4, 0x07);
		outportb(0x3D5, 0x3E);
		
		outportb(0x3D4, 0x10);
		outportb(0x3D5, 0xEA);
		
		outportb(0x3D4, 0x11);
		outportb(0x3D5, 0x8C);
		
		outportb(0x3D4, 0x12);
		outportb(0x3D5, 0xDF);
		
		outportb(0x3D4, 0x15);
		outportb(0x3D5, 0xE7);
		
		outportb(0x3D4, 0x16);
		outportb(0x3D5, 0x04);
		
		outportb(0x3D4, 0x11);
		outportb(0x3D5, inportb(0x3D5)|0x80);
		
		outportb(0x3CE, 0x05);
		outportb(0x3CF, (inportb(0x3CF)&0x60)|0x40);
		
		inportb(0x3DA);
		outportb(0x3C0, 0x30);
		outportb(0x3C0, inportb(0x3C1)|0x40);
		
		for (c=0; c<16; c++) {
			outportb(0x3C0, c);
			outportb(0x3C0, c);
		}
		outportb(0x3C0, 0x20);
		
		outportb(0x3C8, 0x00);
		
		outportb(0x3C4, 0x04);
		outportb(0x3C5, (inportb(0x3C5)&0xF7)|8);
		outportb(0x3D4, 0x14);
		outportb(0x3D5, (inportb(0x3D5)&~0x40)|64);
		outportb(0x3D4, 0x017);
		outportb(0x3D5, (inportb(0x3D5)&~0x40)|64);
		
		outportb(0x3D4, 0x09);
		outportb(0x3D5, (inportb(0x3D5)&0x60)|3);
		
		refresh_rate = 70;
	} else if ((w == 80) && (h == 80)) {
		__dpmi_int(0x10, &fb_dos.regs);
		
		outportw(0x3C4, 0x0604);
		outportw(0x3C4, 0x0F02);
		
		outportw(0x3D4, 0x0014);
		outportw(0x3D4, 0xE317);
		outportw(0x3D4, 0xE317);
		outportw(0x3D4, 0x0409);
		
		refresh_rate = 70;
	} else {
		return -1;
	}

	fb_dos.update = driver_update;
	fb_dos.update_len = (unsigned int)end_of_driver_update - (unsigned int)driver_update;
	fb_dos.set_palette = fb_dos_vga_set_palette;

	return fb_dos_init(title, w, h, depth, refresh_rate, flags);
}

static void driver_update(void)
{
	int y;
	unsigned int buffer = (unsigned int)__fb_gfx->framebuffer;
	unsigned int screen = 0xA0000;

	for (y = 0; y < fb_dos.h; y++, buffer += fb_dos.w, screen += fb_dos.w) {
		if (__fb_gfx->dirty[y]) {
			movedata(_my_ds(), buffer, _dos_ds, screen, fb_dos.w);
		}
	}
}
static void end_of_driver_update(void) { /* do not remove */ }

static int *driver_fetch_modes(int depth, int *size)
{
	if (depth != 8) return NULL;
	
	*size = sizeof(modes) / sizeof(int);
	return memcpy((void*)malloc(sizeof(modes)), modes, sizeof(modes));
}
