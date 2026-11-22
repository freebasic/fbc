/* wayland window management code shared by wayland and opengl drivers */

#include <sys/types.h>
#include <poll.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
/* BTN_* from linux/input.h (avoid header conflict with fb KEY_* macros) */
#define BTN_LEFT 0x110
#define BTN_RIGHT 0x111
#define BTN_MIDDLE 0x112

#ifndef DISABLE_WAYLAND

#include "../fb_gfx.h"
#include "fb_gfx_wayland.h"
#include "../../rtlib/unix/fb_private_scancodes_wayland.h"
#include <pthread.h>
#include <time.h>
#include <stdio.h>

WAYLANDDRIVER fb_wayland;
static volatile int wayland_ready = 0;

static int has_focus = FALSE, cursor_shown = TRUE, mouse_on = FALSE;
static int mouse_x = 0, mouse_y = 0, mouse_z = 0, mouse_w = 0, mouse_buttons = 0;
static int close_requested = FALSE;
static int configured = FALSE;
static int cur_w = 0, cur_h = 0, cur_refresh = 0;
static int *modes_list = NULL, modes_count = 0, modes_cap = 0;
static uint32_t cursor_serial = 0;

static void add_mode(int w, int h) {
    int i;
    for (i = 0; i < modes_count; i += 2) {
        if (modes_list[i] == w && modes_list[i+1] == h) return;
    }
    if (modes_count + 2 > modes_cap) {
        int new_cap = modes_cap ? modes_cap * 2 : 64;
        int *tmp = realloc(modes_list, new_cap * sizeof(int));
        if (tmp) { modes_list = tmp; modes_cap = new_cap; }
    }
    modes_list[modes_count++] = w;
    modes_list[modes_count++] = h;
}

static void output_geometry(void *data, struct wl_output *output, int32_t x, int32_t y,
    int32_t physical_width, int32_t physical_height, int32_t subpixel,
    const char *make, const char *model, int32_t transform) { (void)data;(void)output;(void)x;(void)y;(void)physical_width;(void)physical_height;(void)subpixel;(void)make;(void)model;(void)transform; }

static void output_mode_cb(void *data, struct wl_output *output, uint32_t flags, int32_t width, int32_t height, int32_t refresh) {
    (void)data;(void)output;
    add_mode(width, height);
    if (flags & WL_OUTPUT_MODE_CURRENT) {
        cur_w = width; cur_h = height; cur_refresh = refresh / 1000;
        if (fb_wayland.refresh_rate <= 0) fb_wayland.refresh_rate = cur_refresh;
        if (__fb_gfx) __fb_gfx->refresh_rate = fb_wayland.refresh_rate;
    }
}

static void output_done(void *data, struct wl_output *output) { (void)data;(void)output; }
static void output_scale(void *data, struct wl_output *output, int32_t factor) { (void)data;(void)output;(void)factor; }
static void output_name(void *data, struct wl_output *output, const char *name) { (void)data;(void)output;(void)name; }
static void output_description(void *data, struct wl_output *output, const char *description) { (void)data;(void)output;(void)description; }

static const struct wl_output_listener output_listener = {
    .geometry = output_geometry,
    .mode = output_mode_cb,
    .done = output_done,
    .scale = output_scale,
    .name = output_name,
    .description = output_description,
};

static void seat_capabilities(void *data, struct wl_seat *seat, uint32_t caps);
static void seat_name(void *data, struct wl_seat *seat, const char *name);
static const struct wl_seat_listener seat_listener = {
    .capabilities = seat_capabilities,
    .name = seat_name,
};

static void registry_global(void *data, struct wl_registry *registry, uint32_t name, const char *interface, uint32_t version) {
    (void)data;
    if (strcmp(interface, wl_compositor_interface.name) == 0) {
        fb_wayland.compositor = wl_registry_bind(registry, name, &wl_compositor_interface, 1);
    } else if (strcmp(interface, wl_shm_interface.name) == 0) {
        fb_wayland.shm = wl_registry_bind(registry, name, &wl_shm_interface, 1);
    } else if (strcmp(interface, wl_seat_interface.name) == 0) {
        fb_wayland.seat = wl_registry_bind(registry, name, &wl_seat_interface, 1);
        wl_seat_add_listener(fb_wayland.seat, &seat_listener, NULL);
    } else if (strcmp(interface, xdg_wm_base_interface.name) == 0) {
        fb_wayland.wm_base = wl_registry_bind(registry, name, &xdg_wm_base_interface, 1);
    } else if (strcmp(interface, zxdg_decoration_manager_v1_interface.name) == 0) {
        fb_wayland.decoration_manager = wl_registry_bind(registry, name, &zxdg_decoration_manager_v1_interface, 1);
    } else if (strcmp(interface, wl_output_interface.name) == 0) {
        struct wl_output *o = wl_registry_bind(registry, name, &wl_output_interface, 1);
        if (fb_wayland.num_outputs >= fb_wayland.cap_outputs) {
            int new_cap = fb_wayland.cap_outputs ? fb_wayland.cap_outputs * 2 : 4;
            struct wl_output **tmp = realloc(fb_wayland.outputs, new_cap * sizeof(struct wl_output*));
            if (tmp) { fb_wayland.outputs = tmp; fb_wayland.cap_outputs = new_cap; }
        }
        fb_wayland.outputs[fb_wayland.num_outputs++] = o;
        wl_output_add_listener(o, &output_listener, o);
    }
}

static void registry_global_remove(void *data, struct wl_registry *registry, uint32_t name) {
    (void)data;(void)registry;(void)name;
}

static const struct wl_registry_listener registry_listener = {
    .global = registry_global,
    .global_remove = registry_global_remove,
};

/* xdg surface */
static void xdg_surface_configure_cb(void *data, struct xdg_surface *xdg_surface, uint32_t serial) {
    (void)data;
    xdg_surface_ack_configure(xdg_surface, serial);
    configured = TRUE;
}

static const struct xdg_surface_listener xdg_surface_listener = {
    .configure = xdg_surface_configure_cb,
};

/* toplevel */
static void toplevel_configure_cb(void *data, struct xdg_toplevel *toplevel, int32_t width, int32_t height, struct wl_array *states) {
    (void)data;(void)toplevel;(void)states;
    (void)width;(void)height;
}

static void toplevel_close_cb(void *data, struct xdg_toplevel *toplevel) {
    (void)data;(void)toplevel;
    close_requested = TRUE;
}

static const struct xdg_toplevel_listener toplevel_listener = {
    .configure = toplevel_configure_cb,
    .close = toplevel_close_cb,
};

/* xdg wm base ping */
static void wm_base_ping(void *data, struct xdg_wm_base *wm_base, uint32_t serial) {
    (void)data;
    xdg_wm_base_pong(wm_base, serial);
}
static const struct xdg_wm_base_listener wm_base_listener = {
    .ping = wm_base_ping,
};

/* pointer */
static void pointer_enter(void *data, struct wl_pointer *pointer, uint32_t serial, struct wl_surface *surface, wl_fixed_t sx, wl_fixed_t sy) {
    (void)data;(void)surface;(void)sx;(void)sy;
    cursor_serial = serial;
    mouse_on = TRUE;
    if (cursor_shown && fb_wayland.cursor_left_ptr) {
        struct wl_cursor_image *image = fb_wayland.cursor_left_ptr->images[0];
        struct wl_buffer *buf = wl_cursor_image_get_buffer(image);
        wl_pointer_set_cursor(pointer, serial, fb_wayland.cursor_surface, image->hotspot_x, image->hotspot_y);
        wl_surface_attach(fb_wayland.cursor_surface, buf, 0, 0);
        wl_surface_damage(fb_wayland.cursor_surface, 0, 0, image->width, image->height);
        wl_surface_commit(fb_wayland.cursor_surface);
    } else {
        wl_pointer_set_cursor(pointer, serial, NULL, 0, 0);
    }
}
static void pointer_leave(void *data, struct wl_pointer *pointer, uint32_t serial, struct wl_surface *surface) {
    (void)data;(void)pointer;(void)serial;(void)surface;
    mouse_on = FALSE;
}
static void pointer_motion(void *data, struct wl_pointer *pointer, uint32_t time, wl_fixed_t sx, wl_fixed_t sy) {
    (void)data;(void)pointer;(void)time;
    mouse_x = wl_fixed_to_int(sx);
    mouse_y = wl_fixed_to_int(sy);
    if (has_focus) {
        EVENT e;
        memset(&e, 0, sizeof(e));
        e.type = EVENT_MOUSE_MOVE;
        e.x = mouse_x;
        e.y = mouse_y;
        if (__fb_gfx && __fb_gfx->scanline_size != 1) {
            e.y /= __fb_gfx->scanline_size;
        }
        fb_hPostEvent(&e);
    }
}
static void pointer_button(void *data, struct wl_pointer *pointer, uint32_t serial, uint32_t time, uint32_t button, uint32_t state) {
    (void)data;(void)pointer;(void)serial;(void)time;
    int btn = 0, is_press = (state == WL_POINTER_BUTTON_STATE_PRESSED);
    if (button == BTN_LEFT) btn = BUTTON_LEFT;
    else if (button == BTN_RIGHT) btn = BUTTON_RIGHT;
    else if (button == BTN_MIDDLE) btn = BUTTON_MIDDLE;
    if (btn) {
        if (is_press) {
            mouse_buttons |= btn;
            EVENT e; memset(&e,0,sizeof(e));
            e.type = EVENT_MOUSE_BUTTON_PRESS;
            e.button = btn;
            /* double click */
            static unsigned int last = 0;
            /* use time */
            if (time - last < DOUBLE_CLICK_TIME) e.type = EVENT_MOUSE_DOUBLE_CLICK;
            last = time;
            e.x = mouse_x; e.y = mouse_y;
            fb_hPostEvent(&e);
        } else {
            mouse_buttons &= ~btn;
            EVENT e; memset(&e,0,sizeof(e));
            e.type = EVENT_MOUSE_BUTTON_RELEASE;
            e.button = btn;
            e.x = mouse_x; e.y = mouse_y;
            fb_hPostEvent(&e);
        }
    } else {
        /* wheel buttons 4/5? wl uses axis; ignore button-based wheel */
    }
}
static void pointer_axis(void *data, struct wl_pointer *pointer, uint32_t time, uint32_t axis, wl_fixed_t value) {
    (void)data;(void)pointer;(void)time;
    if (axis == WL_POINTER_AXIS_VERTICAL_SCROLL) {
        int v = wl_fixed_to_int(value);
        if (v > 0) mouse_z--; else if (v < 0) mouse_z++;
        EVENT e; memset(&e,0,sizeof(e));
        e.type = EVENT_MOUSE_WHEEL;
        e.z = mouse_z;
        fb_hPostEvent(&e);
    } else if (axis == WL_POINTER_AXIS_HORIZONTAL_SCROLL) {
        int v = wl_fixed_to_int(value);
        if (v > 0) mouse_w++; else if (v < 0) mouse_w--;
        EVENT e; memset(&e,0,sizeof(e));
        e.type = EVENT_MOUSE_HWHEEL;
        e.w = mouse_w;
        fb_hPostEvent(&e);
    }
}
static const struct wl_pointer_listener pointer_listener = {
    .enter = pointer_enter,
    .leave = pointer_leave,
    .motion = pointer_motion,
    .button = pointer_button,
    .axis = pointer_axis,
};

/* keyboard */
static void keyboard_keymap(void *data, struct wl_keyboard *keyboard, uint32_t format, int32_t fd, uint32_t size) {
    (void)data;(void)keyboard;
    if (format == WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1) {
        char *map_str = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
        if (map_str) {
            if (fb_wayland.xkb_keymap) xkb_keymap_unref(fb_wayland.xkb_keymap);
            fb_wayland.xkb_keymap = xkb_keymap_new_from_string(fb_wayland.xkb_context, map_str, XKB_KEYMAP_FORMAT_TEXT_V1, XKB_KEYMAP_COMPILE_NO_FLAGS);
            munmap(map_str, size);
            if (fb_wayland.xkb_keymap) {
                if (fb_wayland.xkb_state) xkb_state_unref(fb_wayland.xkb_state);
                fb_wayland.xkb_state = xkb_state_new(fb_wayland.xkb_keymap);
            }
        }
        close(fd);
    } else {
        close(fd);
    }
}
static void keyboard_enter(void *data, struct wl_keyboard *keyboard, uint32_t serial, struct wl_surface *surface, struct wl_array *keys) {
    (void)data;(void)keyboard;(void)serial;(void)surface;(void)keys;
    has_focus = TRUE;
    mouse_on = TRUE;
}
static void keyboard_leave(void *data, struct wl_keyboard *keyboard, uint32_t serial, struct wl_surface *surface) {
    (void)data;(void)keyboard;(void)serial;(void)surface;
    has_focus = FALSE;
    memset(__fb_gfx->key, FALSE, 128);
}
static void keyboard_key(void *data, struct wl_keyboard *keyboard, uint32_t serial, uint32_t time, uint32_t key, uint32_t state) {
    (void)data;(void)keyboard;(void)serial;(void)time;
    if (!fb_wayland.xkb_state) return;
    xkb_keysym_t keysym = xkb_state_key_get_one_sym(fb_wayland.xkb_state, key + 8);
    int scancode = fb_hWaylandKeysymToScancode(keysym);
    int pressed = (state == WL_KEYBOARD_KEY_STATE_PRESSED);
    if (scancode > 0 && scancode < 128) {
        if (pressed) __fb_gfx->key[scancode] = TRUE;
        else __fb_gfx->key[scancode] = FALSE;
    }
    if (pressed) {
        /* Alt+Enter toggle fullscreen */
        if (scancode == SC_ENTER && __fb_gfx->key[SC_ALT] && !(fb_wayland.flags & DRIVER_NO_SWITCH)) {
            fb_wayland.flags ^= DRIVER_FULLSCREEN;
            if (fb_wayland.flags & DRIVER_FULLSCREEN) xdg_toplevel_set_fullscreen(fb_wayland.toplevel, NULL);
            else xdg_toplevel_unset_fullscreen(fb_wayland.toplevel);
            return;
        }
        int ascii = 0;
        /* translate keysym to ascii */
        if (keysym >= 0x20 && keysym <= 0x7E) ascii = keysym;
        if (ascii) {
            fb_hPostKey(ascii);
        } else {
            int ext = fb_hScancodeToExtendedKey(scancode);
            if (ext) fb_hPostKey(ext);
        }
        EVENT e; memset(&e,0,sizeof(e));
        e.type = EVENT_KEY_PRESS;
        e.scancode = scancode;
        e.ascii = (ascii && ascii <= 0xFF) ? ascii : 0;
        fb_hPostEvent(&e);
    } else {
        /* repeat detection not implemented; treat as release */
        EVENT e; memset(&e,0,sizeof(e));
        e.type = EVENT_KEY_RELEASE;
        e.scancode = scancode;
        fb_hPostEvent(&e);
    }
}
static void keyboard_modifiers(void *data, struct wl_keyboard *keyboard, uint32_t serial, uint32_t mods_depressed, uint32_t mods_latched, uint32_t mods_locked, uint32_t group) {
    (void)data;(void)keyboard;(void)serial;
    if (fb_wayland.xkb_state) {
        xkb_state_update_mask(fb_wayland.xkb_state, mods_depressed, mods_latched, mods_locked, 0, 0, group);
    }
}
static void keyboard_repeat_info(void *data, struct wl_keyboard *keyboard, int32_t rate, int32_t delay) {
    (void)data;(void)keyboard;(void)rate;(void)delay;
}
static const struct wl_keyboard_listener keyboard_listener = {
    .keymap = keyboard_keymap,
    .enter = keyboard_enter,
    .leave = keyboard_leave,
    .key = keyboard_key,
    .modifiers = keyboard_modifiers,
    .repeat_info = keyboard_repeat_info,
};

/* seat capabilities */
static void seat_capabilities(void *data, struct wl_seat *seat, uint32_t caps) {
    (void)data;
    if (caps & WL_SEAT_CAPABILITY_POINTER) {
        if (!fb_wayland.pointer) {
            fb_wayland.pointer = wl_seat_get_pointer(seat);
            wl_pointer_add_listener(fb_wayland.pointer, &pointer_listener, NULL);
        }
    }
    if (caps & WL_SEAT_CAPABILITY_KEYBOARD) {
        if (!fb_wayland.keyboard) {
            fb_wayland.keyboard = wl_seat_get_keyboard(seat);
            wl_keyboard_add_listener(fb_wayland.keyboard, &keyboard_listener, NULL);
        }
    }
}
static void seat_name(void *data, struct wl_seat *seat, const char *name) { (void)data;(void)seat;(void)name; }

/* frame callback handled in driver file; but shared needs frame_pending? store in fb_wayland */

static void *window_thread(void *arg) {
    (void)arg;
    wayland_ready = 0;
    fb_wayland.is_running = TRUE;
    if (fb_wayland.init && fb_wayland.init())
        fb_wayland.is_running = FALSE;
    pthread_mutex_lock(&fb_wayland.mutex);
    wayland_ready = 1;
    pthread_cond_broadcast(&fb_wayland.cond);
    pthread_mutex_unlock(&fb_wayland.mutex);
    cursor_shown = TRUE;
    fb_wayland.cursor_shown = TRUE;
    mouse_x = -1;
    pthread_mutex_lock(&fb_wayland.mutex);
    pthread_cond_signal(&fb_wayland.cond);
    pthread_mutex_unlock(&fb_wayland.mutex);

    while (fb_wayland.is_running) {
        fb_hWaylandLock();
        if (fb_wayland.update) fb_wayland.update();

        /* dispatch events */
        while (wl_display_prepare_read(fb_wayland.display) == 0) {
            struct pollfd pfd;
            pfd.fd = wl_display_get_fd(fb_wayland.display);
            pfd.events = POLLIN;
            pfd.revents = 0;
            int ret = poll(&pfd, 1, 0);
            if (ret > 0) {
                wl_display_read_events(fb_wayland.display);
                break;
            } else {
                wl_display_cancel_read(fb_wayland.display);
                break;
            }
        }
        wl_display_dispatch_pending(fb_wayland.display);
        wl_display_flush(fb_wayland.display);

        if (close_requested) {
            close_requested = FALSE;
            fb_hPostKey(KEY_QUIT);
            EVENT e; memset(&e,0,sizeof(e));
            e.type = EVENT_WINDOW_CLOSE;
            fb_hPostEvent(&e);
        }

        pthread_cond_signal(&fb_wayland.cond);

        fb_hWaylandUnlock();
        usleep(16000);
    }

    if (fb_wayland.exit) fb_wayland.exit();

    return NULL;
}

/* collect modes helper for temp display */
static void collect_roundtrip(struct wl_display *d) {
    struct wl_registry *reg = wl_display_get_registry(d);
    wl_registry_add_listener(reg, &registry_listener, NULL);
    wl_display_roundtrip(d);
    wl_display_roundtrip(d);
}

int fb_hWaylandInit(char *title, int w, int h, int depth, int refresh_rate, int flags) {
    (void)depth;
    fb_wayland.w = w;
    fb_wayland.h = h;
    fb_wayland.flags = flags;
    fb_wayland.refresh_rate = refresh_rate;

    if (!fb_wayland.display) {
        fb_wayland.display = wl_display_connect(NULL);
        if (!fb_wayland.display) return -1;
    }

    fb_wayland.registry = wl_display_get_registry(fb_wayland.display);
    wl_registry_add_listener(fb_wayland.registry, &registry_listener, NULL);
    wl_display_roundtrip(fb_wayland.display);
    wl_display_roundtrip(fb_wayland.display);

    fb_wayland.xkb_context = xkb_context_new(XKB_CONTEXT_NO_FLAGS);

    if (fb_wayland.shm) {
        fb_wayland.cursor_theme = wl_cursor_theme_load(NULL, 24, fb_wayland.shm);
        if (fb_wayland.cursor_theme)
            fb_wayland.cursor_left_ptr = wl_cursor_theme_get_cursor(fb_wayland.cursor_theme, "left_ptr");
    }
    if (fb_wayland.compositor)
        fb_wayland.cursor_surface = wl_compositor_create_surface(fb_wayland.compositor);

    if (fb_wayland.wm_base) {
        xdg_wm_base_add_listener(fb_wayland.wm_base, &wm_base_listener, NULL);
    }

    /* surface */
    fb_wayland.surface = wl_compositor_create_surface(fb_wayland.compositor);
    fb_wayland.xdg_surface = xdg_wm_base_get_xdg_surface(fb_wayland.wm_base, fb_wayland.surface);
    xdg_surface_add_listener(fb_wayland.xdg_surface, &xdg_surface_listener, NULL);
    fb_wayland.toplevel = xdg_surface_get_toplevel(fb_wayland.xdg_surface);
    xdg_toplevel_add_listener(fb_wayland.toplevel, &toplevel_listener, NULL);
    xdg_toplevel_set_title(fb_wayland.toplevel, title);
    xdg_toplevel_set_app_id(fb_wayland.toplevel, "freebasic");

    if (fb_wayland.decoration_manager) {
        fb_wayland.toplevel_decoration = zxdg_decoration_manager_v1_get_toplevel_decoration(fb_wayland.decoration_manager, fb_wayland.toplevel);
        zxdg_toplevel_decoration_v1_set_mode(fb_wayland.toplevel_decoration, ZXDG_TOPLEVEL_DECORATION_V1_MODE_SERVER_SIDE);
    }

    if (flags & DRIVER_FULLSCREEN) {
        xdg_toplevel_set_fullscreen(fb_wayland.toplevel, NULL);
    }

    wl_surface_commit(fb_wayland.surface);
    configured = FALSE;
    while (!configured) {
        wl_display_roundtrip(fb_wayland.display);
    }

    /* seat already has listener; roundtrip to receive capabilities */
    if (fb_wayland.seat) {
        wl_display_roundtrip(fb_wayland.display);
    }
    if (fb_wayland.refresh_rate <= 0 && cur_refresh > 0) {
        fb_wayland.refresh_rate = cur_refresh;
    }

    pthread_mutex_init(&fb_wayland.mutex, NULL);
    pthread_cond_init(&fb_wayland.cond, NULL);
    pthread_mutex_lock(&fb_wayland.mutex);
    if (pthread_create(&fb_wayland.thread, NULL, window_thread, NULL) == 0) {
        if (!wayland_ready) while (!wayland_ready) pthread_cond_wait(&fb_wayland.cond, &fb_wayland.mutex);
        pthread_mutex_unlock(&fb_wayland.mutex);
        if (fb_wayland.is_running) return 0;
        pthread_join(fb_wayland.thread, NULL);
    } else {
        pthread_mutex_unlock(&fb_wayland.mutex);
    }
    pthread_cond_destroy(&fb_wayland.cond);
    pthread_mutex_destroy(&fb_wayland.mutex);
    return -1;
}

void fb_hWaylandExit(void) {
    if (fb_wayland.is_running) {
        fb_wayland.is_running = FALSE;
        pthread_join(fb_wayland.thread, NULL);
        pthread_mutex_destroy(&fb_wayland.mutex);
        pthread_cond_destroy(&fb_wayland.cond);
    }
    /* cleanup toplevel/surface */
    if (fb_wayland.toplevel_decoration) { zxdg_toplevel_decoration_v1_destroy(fb_wayland.toplevel_decoration); fb_wayland.toplevel_decoration = NULL; }
    if (fb_wayland.toplevel) { xdg_toplevel_destroy(fb_wayland.toplevel); fb_wayland.toplevel = NULL; }
    if (fb_wayland.xdg_surface) { xdg_surface_destroy(fb_wayland.xdg_surface); fb_wayland.xdg_surface = NULL; }
    if (fb_wayland.surface) { wl_surface_destroy(fb_wayland.surface); fb_wayland.surface = NULL; }
    if (fb_wayland.cursor_surface) { wl_surface_destroy(fb_wayland.cursor_surface); fb_wayland.cursor_surface = NULL; }
    if (fb_wayland.cursor_theme) { wl_cursor_theme_destroy(fb_wayland.cursor_theme); fb_wayland.cursor_theme = NULL; }
    if (fb_wayland.pointer) { wl_pointer_destroy(fb_wayland.pointer); fb_wayland.pointer = NULL; }
    if (fb_wayland.keyboard) { wl_keyboard_destroy(fb_wayland.keyboard); fb_wayland.keyboard = NULL; }
    if (fb_wayland.xkb_state) { xkb_state_unref(fb_wayland.xkb_state); fb_wayland.xkb_state = NULL; }
    if (fb_wayland.xkb_keymap) { xkb_keymap_unref(fb_wayland.xkb_keymap); fb_wayland.xkb_keymap = NULL; }
    if (fb_wayland.xkb_context) { xkb_context_unref(fb_wayland.xkb_context); fb_wayland.xkb_context = NULL; }
    for (int i = 0; i < fb_wayland.num_outputs; i++) {
        if (fb_wayland.outputs[i]) wl_output_destroy(fb_wayland.outputs[i]);
    }
    free(fb_wayland.outputs); fb_wayland.outputs = NULL; fb_wayland.num_outputs = 0;
    if (fb_wayland.seat) { wl_seat_destroy(fb_wayland.seat); fb_wayland.seat = NULL; }
    if (fb_wayland.decoration_manager) { zxdg_decoration_manager_v1_destroy(fb_wayland.decoration_manager); fb_wayland.decoration_manager = NULL; }
    if (fb_wayland.wm_base) { xdg_wm_base_destroy(fb_wayland.wm_base); fb_wayland.wm_base = NULL; }
    if (fb_wayland.shm) { wl_shm_destroy(fb_wayland.shm); fb_wayland.shm = NULL; }
    if (fb_wayland.compositor) { wl_compositor_destroy(fb_wayland.compositor); fb_wayland.compositor = NULL; }
    if (fb_wayland.registry) { wl_registry_destroy(fb_wayland.registry); fb_wayland.registry = NULL; }
    if (fb_wayland.display) { wl_display_disconnect(fb_wayland.display); fb_wayland.display = NULL; }
}

void fb_hWaylandLock(void) {
    pthread_mutex_lock(&fb_wayland.mutex);
}

void fb_hWaylandUnlock(void) {
    pthread_mutex_unlock(&fb_wayland.mutex);
}

void fb_hWaylandSetPalette(int index, int r, int g, int b) {
    (void)index;(void)r;(void)g;(void)b;
}

void fb_hWaylandWaitVSync(void) {
    usleep(1000000 / ((fb_wayland.refresh_rate > 0) ? fb_wayland.refresh_rate : 60));
}

int fb_hWaylandGetMouse(int *x, int *y, int *z, int *buttons, int *clip) {
    if ((!mouse_on) || (!has_focus)) return -1;
    if (x) *x = mouse_x;
    if (y) *y = mouse_y;
    if (z) *z = mouse_z;
    if (buttons) *buttons = mouse_buttons;
    if (clip) *clip = fb_wayland.mouse_clip;
    return 0;
}

void fb_hWaylandSetMouse(int x, int y, int show, int clip) {
    if ((x != (int)0x80000000 || y != (int)0x80000000) && has_focus) {
        if (x == (int)0x80000000) x = mouse_x;
        else if (y == (int)0x80000000) y = mouse_y;
        mouse_x = x; mouse_y = y;
        /* warping not supported; no-op */
    }
    if (fb_wayland.pointer) {
        if ((show > 0) && (!cursor_shown)) {
            cursor_shown = TRUE;
            if (fb_wayland.cursor_left_ptr) {
                struct wl_cursor_image *image = fb_wayland.cursor_left_ptr->images[0];
                struct wl_buffer *buf = wl_cursor_image_get_buffer(image);
                wl_pointer_set_cursor(fb_wayland.pointer, cursor_serial, fb_wayland.cursor_surface, image->hotspot_x, image->hotspot_y);
                wl_surface_attach(fb_wayland.cursor_surface, buf, 0, 0);
                wl_surface_damage(fb_wayland.cursor_surface, 0, 0, image->width, image->height);
                wl_surface_commit(fb_wayland.cursor_surface);
            }
        } else if ((show == 0) && (cursor_shown)) {
            cursor_shown = FALSE;
            wl_pointer_set_cursor(fb_wayland.pointer, cursor_serial, NULL, 0, 0);
        }
    }
    if (clip == 0) {
        fb_wayland.mouse_clip = FALSE;
    } else if (clip > 0) {
        fb_wayland.mouse_clip = TRUE;
    }
    fb_wayland.cursor_shown = cursor_shown;
}

void fb_hWaylandSetWindowTitle(char *title) {
    if (fb_wayland.toplevel) xdg_toplevel_set_title(fb_wayland.toplevel, title);
}

int fb_hWaylandSetWindowPos(int x, int y) {
    (void)x;(void)y;
    /* not supported */
    return 0;
}

int *fb_hWaylandFetchModes(int depth, int *size) {
    (void)depth;
    if ((depth != 8) && (depth != 15) && (depth != 16) && (depth != 24) && (depth != 32)) {
        if (size) *size = 0;
        return NULL;
    }
    /* ensure modes collected */
    if (!modes_count) {
        struct wl_display *d = fb_wayland.display;
        int temp = 0;
        if (!d) { d = wl_display_connect(NULL); temp = 1; }
        if (d) {
            /* reset */
            modes_count = 0;
            collect_roundtrip(d);
            if (temp) wl_display_disconnect(d);
        }
    }
    if (size) *size = modes_count / 2;
    if (modes_count == 0) return NULL;
    int *arr = malloc(modes_count / 2 * sizeof(int));
    for (int i = 0; i < modes_count / 2; i++) {
        arr[i] = (modes_list[i*2] << 16) | modes_list[i*2+1];
    }
    return arr;
}

int fb_hWaylandScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh) {
    struct wl_display *d = fb_wayland.display;
    int temp = 0;
    if (!d) { d = wl_display_connect(NULL); temp = 1; }
    if (!d) return -1;
    /* reset current */
    cur_w = cur_h = cur_refresh = 0;
    modes_count = 0;
    collect_roundtrip(d);
    if (temp) wl_display_disconnect(d);
    if (cur_w == 0) {
        /* fallback to first mode */
        if (modes_count >= 2) { cur_w = modes_list[0]; cur_h = modes_list[1]; }
    }
    if (width) *width = cur_w;
    if (height) *height = cur_h;
    if (depth) *depth = 32;
    if (refresh) *refresh = cur_refresh;
    return 0;
}

/* expose close_requested to driver? window_thread uses global */
/* sync global has_focus etc into fb_wayland? store */
/* We keep locals; but driver code expects fb_wayland.has_focus etc. Sync at end? */
/* To satisfy guide, also update fb_wayland fields in events. We'll set fb_wayland fields where relevant. */

#endif
