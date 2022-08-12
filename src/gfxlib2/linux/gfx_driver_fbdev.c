/* Framebuffer device gfx driver */

#include "../fb_gfx.h"
#include "fb_gfx_linux.h"
#include "../../rtlib/unix/fb_private_console.h"

#ifndef DISABLE_FBDEV

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <linux/fb.h>
#include <pthread.h>

#ifndef FB_AUX_VGA_PLANES_VGA4
#define FB_AUX_VGA_PLANES_VGA4	0
#endif

#if defined HOST_X86 || defined HOST_X86_64
#define OUTB(port,value)	{ __asm__ __volatile__ ("outb %b0, %w1" : : "a"(value), "Nd"(port)); }
#else
#define OUTB(port,value)
#endif

typedef struct FBDEVDRIVER
{
	int w, h, depth, flags;
	ssize_t refresh_rate;
	int mouse_clip;
} FBDEVDRIVER;

static FBDEVDRIVER fb_fbdev;

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);
static void driver_exit(void);
static void driver_lock(void);
static void driver_unlock(void);
static void driver_set_palette(int index, int r, int g, int b);
static void driver_wait_vsync(void);
static int driver_get_mouse(int *x, int *y, int *z, int *buttons, int *clip);
static void driver_set_mouse(int x, int y, int cursor, int clip);
static int *driver_fetch_modes(int depth, int *size);

/* GFXDRIVER */
const GFXDRIVER fb_gfxDriverFBDev =
{
	"FBDev",            /* char *name; */
	driver_init,        /* int (*init)(char *title, int w, int h, int depth, int refresh_rate, int flags); */
	driver_exit,        /* void (*exit)(void); */
	driver_lock,        /* void (*lock)(void); */
	driver_unlock,      /* void (*unlock)(void); */
	driver_set_palette, /* void (*set_palette)(int index, int r, int g, int b); */
	driver_wait_vsync,  /* void (*wait_vsync)(void); */
	driver_get_mouse,   /* int (*get_mouse)(int *x, int *y, int *z, int *buttons, int *clip); */
	driver_set_mouse,   /* void (*set_mouse)(int x, int y, int cursor, int clip); */
	NULL,               /* void (*set_window_title)(char *title); */
	NULL,               /* int (*set_window_pos)(int x, int y); */
	driver_fetch_modes, /* int *(*fetch_modes)(void); */
	NULL,               /* void (*flip)(void); */
	NULL,               /* void (*poll_events)(void); */
	NULL                /* void (*update)(void); */
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
static unsigned char color_conv[4096];
static BLITTER *blitter;
static int framebuffer_offset, is_running = FALSE, is_active = TRUE;
static int vsync_flags = 0, is_palette_changed = FALSE;
static int mouse_fd = -1, mouse_packet_size, mouse_shown = TRUE;
static int mouse_x, mouse_y, mouse_z, mouse_buttons;
static int mouse_clip = 0;
static unsigned int last_click_time = 0;
static pthread_t thread;
static pthread_mutex_t mutex;
static pthread_cond_t cond;

#if defined HOST_X86 || defined HOST_X86_64

static void vga16_blitter(unsigned char *dest, int pitch)
{
	unsigned int color;
	unsigned char buffer[fb_fbdev.w], pattern;
	unsigned char *s, *source = __fb_gfx->framebuffer;
	int x, y, plane, i, offset;

	OUTB(0x3CE, 0x03);
	OUTB(0x3CF, 0x00);

	OUTB(0x3CE, 0x05);
	OUTB(0x3CF, 0x00);

	OUTB(0x3CE, 0x01);
	OUTB(0x3CF, 0x00);

	OUTB(0x3CE, 0x08);
	OUTB(0x3CF, 0xFF);

	for (y = 0; y < fb_fbdev.h; y++) {
		if (__fb_gfx->dirty[y]) {
			offset = 0;
			s = source;
			for (x = 0; x < fb_fbdev.w; x += 8) {
				for (plane = 0; plane < 4; plane++) {
					pattern = 0;
					for (i = 0; i < 8; i++) {
						if (__fb_gfx->depth == 8) {
							color = __fb_gfx->device_palette[s[i]];
							color = color_conv[((color & 0xF0) >> 4) | ((color & 0xF000) >> 8) | ((color & 0xF00000) >> 12)];
						}
						else {
							color = s[i];
						}

						if (color & (1 << plane))
							pattern |= 1 << (7 - i);
					}
					buffer[((fb_fbdev.w >> 3) * plane) + offset] = pattern;
				}
				offset++;
				s += 8;
			}
			for (plane = 0; plane < 4; plane++) {
				OUTB(0x3C4, 0x02);
				OUTB(0x3C5, (1 << plane));
				fb_hMemCpy(dest, buffer + ((fb_fbdev.w >> 3) * plane), (fb_fbdev.w >> 3));
			}
		}
		dest += pitch;
		source += __fb_gfx->pitch;
	}
}

#else /* !( defined HOST_X86 || defined HOST_X86_64 ) */

static void vga16_blitter(unsigned char *dest, int pitch)
{
	unsigned int c, color[2];
	unsigned char buffer[fb_fbdev.w];
	unsigned char *s, *source = __fb_gfx->framebuffer;
	int x, y, offset, i;

	for (y = 0; y < fb_fbdev.h; y++) {
		if (__fb_gfx->dirty[y]) {
			offset = 0;
			s = source;
			for (x = 0; x < fb_fbdev.w; x += 2) {
				if (__fb_gfx->depth == 8) {
					for( i = 0; i < 2; i++ )
					{
						c = __fb_gfx->device_palette[s[i]];
						color[i] = color_conv[((c & 0xF0) >> 4) | ((c & 0xF000) >> 8) | ((c & 0xF00000) >> 12)];
					}
					buffer[offset] = (color[0] << 4) | color[1];
				}
				else
				{
					buffer[offset] = ((s[0] << 4) & 0xF0) | (s[1] & 0xF);
				}

				offset++;
				s += 2;
			}

			fb_hMemCpy(dest, buffer, (fb_fbdev.w >> 1));
		}
		dest += pitch;
		source += __fb_gfx->pitch;
	}
}

#endif /* defined HOST_X86 || defined HOST_X86_64 */

static void *driver_thread(void *arg)
{
	struct fb_vblank vblank;
	unsigned int count, cur_time;
	fd_set set;
	struct timeval cur_tv, tv = { 0, 0 };
	unsigned char buffer[1024];
	int buttons, bytes_read, bytes_left = 0;
	EVENT e;

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
							e.dx = (unsigned int)buffer[1] - ((int)(buffer[0] & 0x10) << 4);
							e.dy = -(unsigned int)buffer[2] + ((int)(buffer[0] & 0x20) << 3);
							mouse_x += e.dx;
							mouse_y += e.dy;
							e.x = mouse_x = MID(0, mouse_x, __fb_gfx->w - 1);
							e.y = mouse_y = MID(0, mouse_y, __fb_gfx->h - 1);
							if( __fb_gfx->scanline_size != 1 ) {
								e.y /= __fb_gfx->scanline_size;
								e.dy /= __fb_gfx->scanline_size;
							}
							if (e.dx || e.dy) {
								e.type = EVENT_MOUSE_MOVE;
								fb_hPostEvent(&e);
							}
							buttons = mouse_buttons;
							mouse_buttons = buffer[0] & 0x7;
							if ((mouse_packet_size == 4) && (buffer[3] & 0xF)) {
								mouse_z += (((buffer[3] & 0xF) - 7) >> 3);
								e.type = EVENT_MOUSE_WHEEL;
								e.z = mouse_z;
								fb_hPostEvent(&e);
							}
							buttons = (mouse_buttons ^ buttons) & 0x7;
							for (e.button = 0x4; e.button; e.button >>= 1) {
								if (buttons & e.button) {
									if (mouse_buttons & e.button) {
										gettimeofday(&cur_tv, NULL);
										cur_time = (cur_tv.tv_sec * 1000) + (cur_tv.tv_usec / 1000);
										if (cur_time - last_click_time < DOUBLE_CLICK_TIME)
											e.type = EVENT_MOUSE_DOUBLE_CLICK;
										else
											e.type = EVENT_MOUSE_BUTTON_PRESS;
										last_click_time = cur_time;
									}
									else
										e.type = EVENT_MOUSE_BUTTON_RELEASE;
									fb_hPostEvent(&e);
								}
							}
							bytes_read = mouse_packet_size;
						}
						bytes_left -= bytes_read;
						memmove(buffer, &buffer[bytes_read], bytes_left);
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
				if (device_info.type != FB_TYPE_VGA_PLANES)
					ioctl(device_fd, FBIOPUTCMAP, &cmap);
				else
					fb_hMemSet(__fb_gfx->dirty, TRUE, fb_fbdev.h);
				if (mouse_fd >= 0)
					fb_hSoftCursorPaletteChanged();
				is_palette_changed = FALSE;
			}
			if ((mouse_fd >= 0) && (mouse_shown))
				fb_hSoftCursorPut(mouse_x, mouse_y);
			blitter(framebuffer + framebuffer_offset, device_info.line_length);
			fb_hMemSet(__fb_gfx->dirty, FALSE, fb_fbdev.h);
			if ((mouse_fd >= 0) && (mouse_shown))
				fb_hSoftCursorUnput(mouse_x, mouse_y);
		}

		pthread_mutex_unlock(&mutex);

		if (vsync_flags & (FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_VCOUNT))
			usleep(8000);
		else
			usleep(1000000 / ((fb_fbdev.refresh_rate > 0) ? fb_fbdev.refresh_rate : 60));
	}

	return NULL;
}

static void driver_save_screen(void)
{
	EVENT e;

	pthread_mutex_lock(&mutex);
	is_active = FALSE;
	pthread_mutex_unlock(&mutex);
	ioctl(device_fd, FBIOPUTCMAP, &orig_cmap);
	e.type = EVENT_WINDOW_LOST_FOCUS;
	fb_hPostEvent(&e);
}

static void driver_restore_screen(void)
{
	EVENT e;

	pthread_mutex_lock(&mutex);
	is_active = TRUE;
	is_palette_changed = TRUE;
	fb_hMemSet(framebuffer, 0, device_info.smem_len);
	fb_hMemSet(__fb_gfx->dirty, TRUE, fb_fbdev.h);
	pthread_mutex_unlock(&mutex);
	e.type = EVENT_WINDOW_GOT_FOCUS;
	fb_hPostEvent(&e);
}

static void driver_key_handler( int pressed, int repeated, int scancode, int key )
{
	EVENT e;

	if( pressed ) {
		if( repeated ) {
			e.type = EVENT_KEY_REPEAT;
		} else {
			e.type = EVENT_KEY_PRESS;
		}
	} else {
		e.type = EVENT_KEY_RELEASE;
	}

	e.scancode = scancode;

	/* Don't return extended keycodes in the ascii field */
	e.ascii = ((key < 0) || (key > 0xFF)) ? 0 : key;

	fb_hPostEvent( &e );
}

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags)
{
	const char *device_name;
	int try, res_index, i, j, r, g, b, dist, best_dist, best_index = 0;
	ssize_t dummy;
	int palette_len;
	struct fb_vblank vblank;
	const char *mouse_device[] = { "/dev/input/mice", "/dev/usbmouse", "/dev/psaux", NULL };
	const unsigned char im_init[] = { 243, 200, 243, 100, 243, 80 };

	if (flags & DRIVER_OPENGL)
		return -1;

	fb_fbdev.w = w;
	fb_fbdev.h = h;
	fb_fbdev.flags = flags;
	depth = MAX(depth, 4);

	device_name = getenv("FBGFX_FRAMEBUFFER");
	if (!device_name)
		device_name = "/dev/fb0";
	device_fd = open(device_name, O_RDWR, 0);
	if (device_fd < 0)
		return -1;

	if ((ioctl(device_fd, FBIOGET_FSCREENINFO, &device_info) < 0) ||
	    (ioctl(device_fd, FBIOGET_VSCREENINFO, &orig_mode) < 0) ||
	    ((device_info.type != FB_TYPE_PACKED_PIXELS)
#if defined(i386) && defined(FB_TYPE_VGA_PLANES)
	     && (device_info.type != FB_TYPE_VGA_PLANES)
#endif
	     ) ||
	    ((device_info.visual != FB_VISUAL_PSEUDOCOLOR) &&
	     (device_info.visual != FB_VISUAL_DIRECTCOLOR) &&
	     (device_info.visual != FB_VISUAL_TRUECOLOR))) {
		close(device_fd);
		device_fd = -1;
		return -1;
	}

#if defined(i386) && defined(FB_TYPE_VGA_PLANES)
	if ((device_info.type == FB_TYPE_VGA_PLANES) && (device_info.type_aux == FB_AUX_VGA_PLANES_VGA4)) {
		mode = orig_mode;
		if ((orig_mode.xres >= (unsigned int)w) && (orig_mode.yres >= (unsigned int)h) && __fb_con.has_perm && (depth <= 8)) {
			/* we are in vga16 mode, got to live with it */
			goto got_mode;
		}

		close(device_fd);
		device_fd = -1;
		return -1;
	}
#endif

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
				default:
					mode.red.offset   = mode.red.length   = 0;
					mode.green.offset = mode.green.length = 0;
					mode.blue.offset  = mode.blue.length  = 0;
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
	if ((mode.xres >= (unsigned int)w) && (mode.yres >= (unsigned int)h))
		goto got_mode;

	close(device_fd);
	device_fd = -1;
	return -1;

got_mode:
	if (fb_hConsoleGfxMode(driver_exit, driver_save_screen, driver_restore_screen, driver_key_handler))
		return -1;

	fb_hFBDevInfo(&dummy, &dummy, &dummy, &fb_fbdev.refresh_rate);
	__fb_gfx->refresh_rate = fb_fbdev.refresh_rate;

	if (ioctl(device_fd, FBIOGET_FSCREENINFO, &device_info) < 0)
		return -1;

	framebuffer = mmap(NULL, device_info.smem_len, PROT_READ | PROT_WRITE, MAP_SHARED, device_fd, 0);
	if (framebuffer == (unsigned char *)-1)
		return -1;

	fb_hMemSet(framebuffer, 0, device_info.smem_len);

	if (mode.bits_per_pixel == 4) {
		palette_len = 16;
		framebuffer_offset = (((mode.yres - h) >> 1) * (mode.xres >> 3)) + ((mode.xres - w) >> 4);
		blitter = vga16_blitter;
	} else {
		palette_len = 256;
		framebuffer_offset = (((mode.yres - h) >> 1) * device_info.line_length) +
		                     (((mode.xres - w) >> 1) * BYTES_PER_PIXEL(mode.bits_per_pixel));
		blitter = fb_hGetBlitter(mode.bits_per_pixel, (mode.red.offset == 0) ? TRUE : FALSE);
		if (!blitter)
			return -1;
	}

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
	orig_cmap.len = palette_len;
	orig_cmap.transp = NULL;
	orig_cmap.red = palette;
	orig_cmap.green = palette + 256;
	orig_cmap.blue = palette + 512;
	ioctl(device_fd, FBIOGETCMAP, &orig_cmap);
	cmap.start = 0;
	cmap.len = palette_len;
	cmap.transp = NULL;
	cmap.red = palette + 768;
	cmap.green = palette + 1024;
	cmap.blue = palette + 1280;
	if ((mode.bits_per_pixel == 4) && (depth == 8)) {
		/* set safe palette */
		for (i = 0; i < 16; i++) {
			r = cmap.red[i]   = __fb_palette[FB_PALETTE_16].data[(i * 3) + 2] << 8;
			g = cmap.green[i] = __fb_palette[FB_PALETTE_16].data[(i * 3) + 1] << 8;
			b = cmap.blue[i]  = __fb_palette[FB_PALETTE_16].data[(i * 3)    ] << 8;
			__fb_gfx->device_palette[i] = (r >> 8) | g | (b << 8);
		}
		ioctl(device_fd, FBIOPUTCMAP, &cmap);
		for (i = 0; i < 4096; i++) {
			best_dist = 1000000;
			r = (i & 0xF) << 4;
			g = (i & 0xF0);
			b = (i & 0xF00) >> 4;
			for (j = 0; j < 16; j++) {
				dist = fb_hColorDistance(j, r, g, b);
				if (dist < best_dist) {
					best_dist = dist;
					best_index = j;
				}
			}
			color_conv[i] = best_index;
		}
	}

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
		fb_hConsoleGfxMode(NULL, NULL, NULL, NULL);
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

static void driver_lock(void)
{
	pthread_mutex_lock(&mutex);
}

static void driver_unlock(void)
{
	pthread_mutex_unlock(&mutex);
}

static void driver_set_palette(int index, int r, int g, int b)
{
	cmap.red[index] = r << 8;
	cmap.green[index] = g << 8;
	cmap.blue[index] = b << 8;
	is_palette_changed = TRUE;
}

static void driver_wait_vsync(void)
{
	pthread_mutex_lock(&mutex);
	pthread_cond_wait(&cond, &mutex);
	pthread_mutex_unlock(&mutex);
}

static int driver_get_mouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	if (mouse_fd < 0)
		return -1;
	if (x) *x = mouse_x;
	if (y) *y = mouse_y;
	if (z) *z = mouse_z;
	if (buttons) *buttons = mouse_buttons;
	if (clip) *clip = mouse_clip;
	return 0;
}

static void driver_set_mouse(int x, int y, int cursor, int clip)
{
	if (x != (int)0x80000000 || y != (int)0x80000000) {
		if (x == (int)0x80000000) {
			x = mouse_x;
		}
		else if (y == (int)0x80000000) {
			y = mouse_y;
		}

		x = MID(0, x, __fb_gfx->w - 1);
		y = MID(0, y, __fb_gfx->h - 1);

		mouse_x = x;
		mouse_y = y;
	}
	mouse_shown = (cursor != 0);
	if (clip == 0)
		mouse_clip = FALSE;
	else if (clip > 0)
		mouse_clip = TRUE;
}

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

int fb_hFBDevInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh)
{
	struct fb_var_screeninfo temp, *info;
	int fd = -1, htotal, vtotal, flags, res;

	if (device_fd < 0) {
		if ((fd = open("/dev/fb0", O_RDWR, 0)) < 0)
			return -1;
		res = ioctl(fd, FBIOGET_VSCREENINFO, &temp);
		close(fd);
		if (res < 0)
			return -1;
		info = &temp;
	}
	else
		info = &mode;

	htotal = info->left_margin + info->xres + info->right_margin + info->hsync_len;
	vtotal = info->upper_margin + info->yres + info->lower_margin + info->vsync_len;
	flags = info->vmode & FB_VMODE_MASK;

	if (!(flags == FB_VMODE_INTERLACED))
		vtotal <<= 1;
	if (flags == FB_VMODE_DOUBLE)
		vtotal <<= 1;

	*width = info->xres;
	*height = info->yres;
	*depth = info->bits_per_pixel;
	if ((info->pixclock) && (htotal) && (vtotal))
		*refresh = (((1e12 / info->pixclock) / htotal) / vtotal) * 2;

	return 0;
}

#endif
