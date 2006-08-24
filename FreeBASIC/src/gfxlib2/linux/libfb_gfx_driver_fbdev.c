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
 * fbdev.c -- Framebuffer device gfx driver
 *
 * chng: feb/2006 written [lillo]
 *
 */

#include "fb_gfx.h"

#include "fb_gfx_linux.h"
#include <linux/fb.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_lock(void);
static void driver_unlock(void);
static void driver_set_palette(int index, int r, int g, int b);
static void driver_wait_vsync(void);
static int driver_get_mouse(int *x, int *y, int *z, int *buttons);
static void driver_set_mouse(int x, int y, int cursor);
static int *driver_fetch_modes(int depth, int *size);

GFXDRIVER fb_gfxDriverFBDev =
{
	"FBDev",		/* char *name; */
	driver_init,		/* int (*init)(int w, int h, char *title, int fullscreen); */
	driver_exit,		/* void (*exit)(void); */
	driver_lock,		/* void (*lock)(void); */
	driver_unlock,		/* void (*unlock)(void); */
	driver_set_palette,	/* void (*set_palette)(int index, int r, int g, int b); */
	driver_wait_vsync,	/* void (*wait_vsync)(void); */
	driver_get_mouse,	/* int (*get_mouse)(int *x, int *y, int *z, int *buttons); */
	driver_set_mouse,	/* void (*set_mouse)(int x, int y, int cursor); */
	NULL,			/* void (*set_window_title)(char *title); */
	driver_fetch_modes,	/* int *(*fetch_modes)(void); */
	NULL			/* void (*flip)(void); */
};


typedef struct {
	int w, h;
} GFXMODE;


static const GFXMODE standard_mode[] = {
	{ 320, 200 }, { 320, 240 }, { 400, 300 }, { 512, 384 }, { 640, 400 }, { 640, 480 },
	{ 800, 600 }, { 1024, 768 }, { 1280, 1024 }, { 1600, 1200 }, { 0, 0 }
};

static int device_fd = -1;
static struct fb_fix_screeninfo device_info;
static struct fb_var_screeninfo mode, orig_mode;
static struct fb_cmap cmap, orig_cmap;
static unsigned char *framebuffer = NULL;
static unsigned short *palette = NULL;
static BLITTER *blitter;
static int framebuffer_offset, is_running = FALSE, is_active = TRUE;
static int vsync_flags = 0, is_palette_changed = FALSE;
static int mouse_fd = -1, mouse_packet_size, mouse_shown = TRUE;
static int mouse_x, mouse_y, mouse_z, mouse_buttons;
static pthread_t thread;
static pthread_mutex_t mutex;
static pthread_cond_t cond;


/*:::::*/
static void *driver_thread(void *arg)
{
	struct fb_vblank vblank;
	unsigned int count;
	fd_set set;
	struct timeval tv = { 0, 0 };
	unsigned char buffer[1024];
	int bytes_read, bytes_left = 0;
	
	(void)arg;
	
	is_running = TRUE;
	
	pthread_mutex_lock(&mutex);
	pthread_cond_signal(&cond);
	pthread_mutex_unlock(&mutex);
	
	while (is_running) {
		pthread_mutex_lock(&mutex);
		
		if (mouse_fd >= 0) {
			FD_ZERO(&set);
			FD_SET(mouse_fd, &set);
			if (select(FD_SETSIZE, &set, NULL, NULL, &tv) > 0) {
				bytes_read = read(mouse_fd, &buffer[bytes_left], sizeof(buffer) - bytes_left);
				if (bytes_read > 0) {
					bytes_left += bytes_read;
					while (bytes_left >= mouse_packet_size) {
						if (((mouse_packet_size == 3) && ((buffer[0] & 0xC0) != 0x00)) ||
						   ((mouse_packet_size == 4) && ((buffer[0] & 0xC8) != 0x08)))
							bytes_read = 1;
						else {
							mouse_x += buffer[1];
							if (buffer[0] & 0x10) mouse_x -= 256;
							mouse_y -= buffer[2];
							if (buffer[0] & 0x20) mouse_y += 256;
							mouse_x = MID(0, mouse_x, fb_mode->w - 1);
							mouse_y = MID(0, mouse_y, fb_mode->h - 1);
							mouse_buttons = buffer[0] & 0x7;
							if ((mouse_packet_size == 4) && (buffer[3] & 0xF))
								mouse_z += (((buffer[3] & 0xF) - 7) >> 3);
							bytes_read = mouse_packet_size;
						}
						bytes_left -= bytes_read;
						memcpy(buffer, &buffer[bytes_read], bytes_left);
					}
				}
			}
		}
		
		if (vsync_flags & (FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_VCOUNT)) {
			if (vsync_flags & FB_VBLANK_HAVE_VCOUNT) {
				ioctl(device_fd, FBIOGET_VBLANK, &vblank);
				do {
					count = vblank.vcount;
				} while ((ioctl(device_fd, FBIOGET_VBLANK, &vblank) == 0) && (vblank.vcount >= count));
			}
			else {
				while ((ioctl(device_fd, FBIOGET_VBLANK, &vblank) == 0) && (vblank.flags & FB_VBLANK_VBLANKING))
					;
				while ((ioctl(device_fd, FBIOGET_VBLANK, &vblank) == 0) && (!(vblank.flags & FB_VBLANK_VBLANKING)))
					;
			}
		}
		pthread_cond_signal(&cond);
		
		if (is_active) {
			if (is_palette_changed) {
				ioctl(device_fd, FBIOPUTCMAP, &cmap);
				if (mouse_fd >= 0)
					fb_hSoftCursorPaletteChanged();
				is_palette_changed = FALSE;
			}
			if ((mouse_fd >= 0) && (mouse_shown))
				fb_hSoftCursorPut(mouse_x, mouse_y);
			blitter(framebuffer + framebuffer_offset, device_info.line_length);
			fb_hMemSet(fb_mode->dirty, FALSE, fb_linux.h);
			if ((mouse_fd >= 0) && (mouse_shown))
				fb_hSoftCursorUnput(mouse_x, mouse_y);
		}
		
		pthread_mutex_unlock(&mutex);
		
		if (vsync_flags & (FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_VCOUNT))
			usleep(8000);
		else
			usleep(1000000 / ((fb_linux.refresh_rate > 0) ? fb_linux.refresh_rate : 60));
	}
	
	return NULL;
}


/*:::::*/
static void driver_save_screen(void)
{
	pthread_mutex_lock(&mutex);
	is_active = FALSE;
	pthread_mutex_unlock(&mutex);
	ioctl(device_fd, FBIOPUTCMAP, &orig_cmap);
}


/*:::::*/
static void driver_restore_screen(void)
{
	pthread_mutex_lock(&mutex);
	is_active = TRUE;
	is_palette_changed = TRUE;
	fb_hMemSet(framebuffer, 0, device_info.smem_len);
	fb_hMemSet(fb_mode->dirty, TRUE, fb_linux.h);
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	const char *device_name;
	int try, res_index;
	struct fb_vblank vblank;
	const char *mouse_device[] = { "/dev/input/mice", "/dev/usbmouse", "/dev/psaux", NULL };
	const unsigned char im_init[] = { 243, 200, 243, 100, 243, 80 };
	
	if (flags & DRIVER_OPENGL)
		return -1;
	
	fb_linux.w = w;
	fb_linux.h = h;
	fb_linux.flags = flags;
	fb_linux.refresh_rate = refresh_rate;
	depth = MAX(depth, 8);
	
	device_name = getenv("FBGFX_FRAMEBUFFER");
	if (!device_name)
		device_name = "/dev/fb0";
	device_fd = open(device_name, O_RDWR, 0);
	if (device_fd < 0)
		return -1;
	
	if ((ioctl(device_fd, FBIOGET_FSCREENINFO, &device_info) < 0) ||
	    (ioctl(device_fd, FBIOGET_VSCREENINFO, &orig_mode) < 0) ||
	    (device_info.type != FB_TYPE_PACKED_PIXELS) ||
	    ((device_info.visual != FB_VISUAL_PSEUDOCOLOR) &&
	     (device_info.visual != FB_VISUAL_DIRECTCOLOR) &&
	     (device_info.visual != FB_VISUAL_TRUECOLOR))) {
		close(device_fd);
		device_fd = -1;
		return -1;
	}
    
	/* tries in order:
	 *  1) wanted resolution and color depth;
	 *  2) any higher resolution and wanted color depth;
	 *  3) wanted resolution and original color depth;
	 *  4) any higher resolution and original color depth;
	 */
	for (try = 0; try < 4; try++) {
		mode = orig_mode;
		
		mode.xoffset = 0;
		mode.yoffset = 0;
		
		if (try < 2) {
			mode.bits_per_pixel = depth;
			mode.grayscale = 0;
			switch (depth) {
				case 8:
					mode.red.offset   = mode.red.length   = 0;
					mode.green.offset = mode.green.length = 0;
					mode.blue.offset  = mode.blue.length  = 0;
					break;
				case 15:
					mode.red.offset   = 10; mode.red.length   = 5;
					mode.green.offset = 5;  mode.green.length = 5;
					mode.blue.offset  = 0;  mode.blue.length  = 5;
					break;
				case 16:
					mode.red.offset   = 11; mode.red.length   = 5;
					mode.green.offset = 5;  mode.green.length = 6;
					mode.blue.offset  = 0;  mode.blue.length  = 5;
					break;
				case 24:
				case 32:
					mode.red.offset   = 16; mode.red.length   = 8;
					mode.green.offset = 8;  mode.green.length = 8;
					mode.blue.offset  = 0;  mode.blue.length  = 8;
					break;
			}
			mode.red.msb_right = mode.green.msb_right = mode.blue.msb_right = 0;
		}
		
		if (try & 1) {
			for (res_index = 0; standard_mode[res_index].w; res_index++) {
				if ((standard_mode[res_index].w >= w) && (standard_mode[res_index].h > h)) {
					mode.xres = mode.xres_virtual = standard_mode[res_index].w;
					mode.yres = mode.yres_virtual = standard_mode[res_index].h;
					if (ioctl(device_fd, FBIOPUT_VSCREENINFO, &mode) == 0)
						goto got_mode;
				}
			}
		}
		else {
			mode.xres = mode.xres_virtual = w;
			mode.yres = mode.yres_virtual = h;
			if (ioctl(device_fd, FBIOPUT_VSCREENINFO, &mode) == 0)
				goto got_mode;
		}
	}
	
	mode = orig_mode;
	if ((mode.xres >= w) && (mode.yres >= h))
		goto got_mode;
	
	close(device_fd);
	device_fd = -1;
	return -1;

got_mode:
	if (ioctl(device_fd, FBIOGET_FSCREENINFO, &device_info) < 0)
		return -1;
	
	framebuffer = mmap(NULL, device_info.smem_len, PROT_READ | PROT_WRITE, MAP_SHARED, device_fd, 0);
	if (framebuffer == (unsigned char *)-1)
		return -1;
	
	fb_hMemSet(framebuffer, 0, device_info.smem_len);
	
	framebuffer_offset = (((mode.yres - h) >> 1) * device_info.line_length) +
	                     (((mode.xres - w) >> 1) * BYTES_PER_PIXEL(mode.bits_per_pixel));
	
	blitter = fb_hGetBlitter(mode.bits_per_pixel, (mode.red.offset == 0) ? TRUE : FALSE);
	if (!blitter)
		return -1;
	
	if (fb_hConsoleGfxMode(driver_exit, driver_save_screen, driver_restore_screen))
		return -1;
	
	mouse_packet_size = 3;
	for (try = 0; mouse_device[try]; try++) {
		mouse_fd = open(mouse_device[try], O_RDWR, 0);
		if ((mouse_fd >= 0) && (write(mouse_fd, im_init, sizeof(im_init)) == sizeof(im_init))) {
			mouse_packet_size++;
			break;
		}
		if (mouse_fd < 0)
			mouse_fd = open(mouse_device[try], O_RDONLY, 0);
		if (mouse_fd >= 0)
			break;
	}
	if (mouse_fd >= 0) {
		mouse_x = w >> 1;
		mouse_y = h >> 1;
		mouse_buttons = mouse_z = 0;
		mouse_shown = TRUE;
		fb_hSoftCursorInit();
	}
	
	palette = (unsigned short *)malloc(sizeof(unsigned short) * 1536);
	orig_cmap.start = 0;
	orig_cmap.len = 256;
	orig_cmap.transp = NULL;
	orig_cmap.red = palette;
	orig_cmap.green = palette + 256;
	orig_cmap.blue = palette + 512;
	ioctl(device_fd, FBIOGETCMAP, &orig_cmap);
	cmap.start = 0;
	cmap.len = 256;
	cmap.transp = NULL;
	cmap.red = palette + 768;
	cmap.green = palette + 1024;
	cmap.blue = palette + 1280;
	
	if (ioctl(device_fd, FBIOGET_VBLANK, &vblank) == 0)
		vsync_flags = vblank.flags;
	
	pthread_mutex_init(&mutex, NULL);
	pthread_cond_init(&cond, NULL);
	pthread_mutex_lock(&mutex);
	if (pthread_create(&thread, NULL, driver_thread, NULL)) {
		pthread_mutex_unlock(&mutex);
		return -1;
	}
	pthread_cond_wait(&cond, &mutex);
	pthread_mutex_unlock(&mutex);

	return 0;
}


/*:::::*/
static void driver_exit(void)
{
	if (is_running) {
		is_running = FALSE;
		pthread_join(thread, NULL);
		pthread_mutex_destroy(&mutex);
		pthread_cond_destroy(&cond);
	}
	
	if (mouse_fd >= 0) {
		fb_hSoftCursorExit();
		close(mouse_fd);
		mouse_fd = -1;
	}
	
	if (device_fd >= 0) {
		fb_hConsoleGfxMode(NULL, NULL, NULL);
		if (framebuffer) {
			munmap(framebuffer, device_info.smem_len);
			framebuffer = NULL;
		}
		if (palette) {
			ioctl(device_fd, FBIOPUTCMAP, &orig_cmap);
			free(palette);
			palette = NULL;
		}
		ioctl(device_fd, FBIOPUT_VSCREENINFO, &orig_mode);
		close(device_fd);
		device_fd = -1;
	}
}


/*:::::*/
static void driver_lock(void)
{
	pthread_mutex_lock(&mutex);
}


/*:::::*/
static void driver_unlock(void)
{
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
static void driver_set_palette(int index, int r, int g, int b)
{
	cmap.red[index] = r << 8;
	cmap.green[index] = g << 8;
	cmap.blue[index] = b << 8;
	is_palette_changed = TRUE;
}


/*:::::*/
static void driver_wait_vsync(void)
{
	pthread_mutex_lock(&mutex);
	pthread_cond_wait(&cond, &mutex);
	pthread_mutex_unlock(&mutex);
}


/*:::::*/
static int driver_get_mouse(int *x, int *y, int *z, int *buttons)
{
	if (mouse_fd < 0)
		return -1;
	*x = mouse_x;
	*y = mouse_y;
	*z = mouse_z;
	*buttons = mouse_buttons;
	return 0;
}


/*:::::*/
static void driver_set_mouse(int x, int y, int cursor)
{
	if ((x >= 0) && (x < fb_mode->w))
		mouse_x = x;
	if ((y >= 0) && (y < fb_mode->h))
		mouse_y = y;
	mouse_shown = (cursor != 0);
}


/*:::::*/
static int *driver_fetch_modes(int depth, int *size)
{
	const char *device_name;
	int i, fd, num_sizes = 0, *sizes = NULL;
	
	if ((depth != 8) && (depth != 15) && (depth != 16) && (depth != 24) && (depth != 32))
		return NULL;

	if (device_fd < 0) {
		device_name = getenv("FBGFX_FRAMEBUFFER");
		if (!device_name)
			device_name = "/dev/fb0";
		fd = open(device_name, O_RDWR, 0);
		if (fd < 0)
			return NULL;
	}
	else
		fd = device_fd;
	
	ioctl(fd, FBIOGET_VSCREENINFO, &mode);
	for (i = 0; standard_mode[i].w; i++) {
		mode.bits_per_pixel = depth;
		mode.activate = FB_ACTIVATE_TEST;
		mode.xres = mode.xres_virtual = standard_mode[i].w;
		mode.yres = mode.yres_virtual = standard_mode[i].h;
		if (ioctl(fd, FBIOPUT_VSCREENINFO, &mode) == 0) {
			num_sizes++;
			sizes = realloc(sizes, num_sizes * sizeof(int));
			sizes[num_sizes - 1] = (mode.xres << 16) | mode.yres;
		}
	}
	
	if (device_fd < 0)
		close(fd);
	
	*size = num_sizes;
	return sizes;
}
