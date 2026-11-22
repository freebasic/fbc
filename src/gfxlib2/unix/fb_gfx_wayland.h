/* common wayland internal definitions */

#ifndef DISABLE_WAYLAND

#ifndef __FB_GFX_WAYLAND_H__
#define __FB_GFX_WAYLAND_H__

#include <wayland-client.h>
#include <wayland-cursor.h>
#include <wayland-egl.h>
#include <xkbcommon/xkbcommon.h>
#include "wayland_xdg_shell.h"
#include "wayland_xdg_decoration.h"
#include <pthread.h>

#define DOUBLE_CLICK_TIME		250

typedef struct WAYLANDDRIVER
{
	struct wl_display   *display;
	struct wl_registry  *registry;
	struct wl_compositor *compositor;
	struct wl_shm       *shm;
	struct wl_seat      *seat;
	struct xdg_wm_base  *wm_base;
	struct zxdg_decoration_manager_v1 *decoration_manager;

	struct wl_surface   *surface;
	struct xdg_surface  *xdg_surface;
	struct xdg_toplevel *toplevel;
	struct zxdg_toplevel_decoration_v1 *toplevel_decoration;

	/* software rendering */
	struct wl_shm_pool  *pool;
	struct wl_buffer    *buffer;
	void                *shm_data;
	size_t               shm_size;
	struct wl_callback  *frame_callback;
	int                  frame_pending;

	/* GL */
	struct wl_egl_window *egl_window;

	int w, h, depth, visual_depth, flags;
	int refresh_rate, display_offset;
	int mouse_clip;

	int (*init)(void);
	void (*exit)(void);
	void (*update)(void);

	pthread_t thread;
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	int is_running;

	struct wl_pointer   *pointer;
	struct wl_keyboard  *keyboard;
	struct wl_cursor_theme *cursor_theme;
	struct wl_cursor    *cursor_left_ptr;
	struct wl_surface   *cursor_surface;

	struct xkb_context  *xkb_context;
	struct xkb_keymap   *xkb_keymap;
	struct xkb_state    *xkb_state;

	int mouse_x, mouse_y, mouse_z, mouse_w;
	int mouse_buttons, mouse_on;
	int has_focus, cursor_shown;

	struct wl_output **outputs;
	int num_outputs, cap_outputs;
} WAYLANDDRIVER;

extern WAYLANDDRIVER fb_wayland;
extern const GFXDRIVER fb_gfxDriverWayland;
extern const GFXDRIVER fb_gfxDriverOpenGLWayland;

extern void fb_hWaylandWaitVSync(void);

extern int fb_hWaylandInit(char *title, int w, int h, int depth, int refresh_rate, int flags);
extern void fb_hWaylandExit(void);
extern void fb_hWaylandLock(void);
extern void fb_hWaylandUnlock(void);
extern void fb_hWaylandSetPalette(int index, int r, int g, int b);
extern int fb_hWaylandGetMouse(int *x, int *y, int *z, int *buttons, int *clip);
extern void fb_hWaylandSetMouse(int x, int y, int cursor, int clip);
extern void fb_hWaylandSetWindowTitle(char *title);
extern int fb_hWaylandSetWindowPos(int x, int y);
extern int *fb_hWaylandFetchModes(int depth, int *size);
extern int fb_hWaylandScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh);

#endif
#endif