#define _GNU_SOURCE
#include <time.h>
#include <stdio.h>
/* Wayland gfx driver (software rendering) */

#ifndef DISABLE_WAYLAND

#include "../fb_gfx.h"
#include "fb_gfx_wayland.h"
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags);

const GFXDRIVER fb_gfxDriverWayland =
{
	"Wayland",              /* char *name; */
	driver_init,            /* int (*init)(...); */
	fb_hWaylandExit,        /* void (*exit)(void); */
	fb_hWaylandLock,        /* void (*lock)(void); */
	fb_hWaylandUnlock,      /* void (*unlock)(void); */
	fb_hWaylandSetPalette,  /* void (*set_palette)(...); */
	fb_hWaylandWaitVSync,   /* void (*wait_vsync)(void); */
	fb_hWaylandGetMouse,    /* int (*get_mouse)(...); */
	fb_hWaylandSetMouse,    /* void (*set_mouse)(...); */
	fb_hWaylandSetWindowTitle, /* void (*set_window_title)(...); */
	fb_hWaylandSetWindowPos,/* int (*set_window_pos)(...); */
	fb_hWaylandFetchModes,  /* int *(*fetch_modes)(...); */
	NULL,                   /* void (*flip)(void); */
	NULL,                   /* void (*poll_events)(void); */
	NULL                    /* void (*update)(void); */
};

static int shm_fd = -1;
static void *shm_data_ptr = NULL;
static size_t shm_size_val = 0;
static BLITTER *blitter = NULL;
static struct wl_callback *frame_callback = NULL;
static int frame_pending = 0;

static void frame_done(void *data, struct wl_callback *cb, uint32_t time) {
    (void)data;(void)time;
    if (cb) wl_callback_destroy(cb);
    frame_callback = NULL;
    frame_pending = 0;
}
static const struct wl_callback_listener frame_listener = { .done = frame_done };

static int wayland_init(void) {
    int is_rgb = FALSE;
    blitter = fb_hGetBlitter(fb_wayland.visual_depth ? fb_wayland.visual_depth : 32, is_rgb);
    /* visual_depth not set; use 32 */
    blitter = fb_hGetBlitter(32, is_rgb);
    if (!blitter) return -1;

    size_t size = (size_t)fb_wayland.w * (size_t)fb_wayland.h * 4;
    shm_fd = memfd_create("fbgfx", MFD_CLOEXEC);
    if (shm_fd < 0) {
        shm_fd = shm_open("/fbgfx", O_RDWR | O_CREAT | O_EXCL, 0600);
        if (shm_fd < 0) return -1;
        shm_unlink("/fbgfx");
    }
    if (ftruncate(shm_fd, size) < 0) { close(shm_fd); shm_fd = -1; return -1; }
    shm_data_ptr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    if (shm_data_ptr == MAP_FAILED) { close(shm_fd); shm_fd = -1; return -1; }
    fb_wayland.shm_data = shm_data_ptr;
    fb_wayland.shm_size = size;
    shm_size_val = size;
    fb_wayland.pool = wl_shm_create_pool(fb_wayland.shm, shm_fd, size);
    if (!fb_wayland.pool) return -1;
    fb_wayland.buffer = wl_shm_pool_create_buffer(fb_wayland.pool, 0, fb_wayland.w, fb_wayland.h, fb_wayland.w * 4, WL_SHM_FORMAT_XRGB8888);
    if (!fb_wayland.buffer) return -1;
    frame_pending = 0;
    return 0;
}

static void wayland_exit(void) {
    if (frame_callback) { wl_callback_destroy(frame_callback); frame_callback = NULL; }
    if (fb_wayland.buffer) { wl_buffer_destroy(fb_wayland.buffer); fb_wayland.buffer = NULL; }
    if (fb_wayland.pool) { wl_shm_pool_destroy(fb_wayland.pool); fb_wayland.pool = NULL; }
    if (shm_data_ptr && shm_data_ptr != MAP_FAILED) { munmap(shm_data_ptr, shm_size_val ? shm_size_val : fb_wayland.shm_size); shm_data_ptr = NULL; }
    if (shm_fd >= 0) { close(shm_fd); shm_fd = -1; }
}

static void wayland_update(void) {
    if (!fb_wayland.buffer || !fb_wayland.shm_data) return;
    {
        int _any = 0, _i;
        for (_i = 0; _i < fb_wayland.h; _i++) if (__fb_gfx->dirty[_i]) { _any = 1; break; }
        if (!_any) return;
    }
    blitter((unsigned char *)fb_wayland.shm_data, fb_wayland.w * 4);
    /* damage dirty runs */
    int i;
    for (i = 0; i < fb_wayland.h; i++) {
        if (__fb_gfx->dirty[i]) {
            int y = i, h = 0;
            for (; (i < fb_wayland.h) && __fb_gfx->dirty[i]; h++, i++) ;
            wl_surface_damage(fb_wayland.surface, 0, y, fb_wayland.w, h);
        }
    }
    if (!frame_pending) {
        wl_surface_attach(fb_wayland.surface, fb_wayland.buffer, 0, 0);
        frame_callback = wl_surface_frame(fb_wayland.surface);
        wl_callback_add_listener(frame_callback, &frame_listener, NULL);
        frame_pending = 1;
        wl_surface_commit(fb_wayland.surface);
    }
    fb_hMemSet(__fb_gfx->dirty, FALSE, fb_wayland.h);
    /* keep frame_pending in fb_wayland */
    fb_wayland.frame_pending = frame_pending;
    fb_wayland.frame_callback = frame_callback;
}

static int driver_init(char *title, int w, int h, int depth_arg, int refresh_rate, int flags) {
    int depth = MAX(8, depth_arg);
    if (flags & DRIVER_OPENGL) return -1;
    fb_hMemSet(&fb_wayland, 0, sizeof(fb_wayland));
    fb_wayland.init = wayland_init;
    fb_wayland.exit = wayland_exit;
    fb_wayland.update = wayland_update;
    fb_wayland.frame_pending = 0;
    return fb_hWaylandInit(title, w, h, depth, refresh_rate, flags);
}

#endif
