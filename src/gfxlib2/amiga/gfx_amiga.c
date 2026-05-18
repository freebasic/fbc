/* FreeBASIC gfxlib2 driver for AmigaOS via intuition.library + graphics.library */

#include "../fb_gfx.h"

#if defined(HOST_AMIGAOS)
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/graphics.h>
#include <intuition/screens.h>

extern struct ExecBase *SysBase;
static struct IntuitionBase *IntuitionBase;
static struct GfxBase *GfxBase;
static struct Screen *amiga_screen;
static struct Window *amiga_window;
static int mouse_x, mouse_y, mouse_z, mouse_buttons;
static struct RastPort tmp_rp;
static struct BitMap *tmp_bm;
static int tmp_bm_width;


/* Amiga scancode to FreeBASIC (PC Set 1) scancode mapping */
static const unsigned char amiga_to_fb_scancode[128] = {
    /* 0x00-0x0F: ` 1 2 3 4 5 6 7 8 9 0 - = \ x Del */
    SC_TILDE, SC_1, SC_2, SC_3, SC_4, SC_5, SC_6, SC_7,
    SC_8, SC_9, SC_0, SC_MINUS, SC_EQUALS, SC_BACKSLASH, 0, SC_DELETE,
    /* 0x10-0x1F: Q W E R T Y U I O P [ ] x x x KP0 */
    SC_Q, SC_W, SC_E, SC_R, SC_T, SC_Y, SC_U, SC_I,
    SC_O, SC_P, SC_LEFTBRACKET, SC_RIGHTBRACKET, 0, 0, 0, SC_KEYPAD0,
    /* 0x20-0x2F: A S D F G H J K L ; ' x x x x KP. */
    SC_A, SC_S, SC_D, SC_F, SC_G, SC_H, SC_J, SC_K,
    SC_L, SC_SEMICOLON, SC_QUOTE, 0, 0, 0, 0, SC_KEYPADDOT,
    /* 0x30-0x3F: x Z X C V B N M , . / x x x x x */
    0, SC_Z, SC_X, SC_C, SC_V, SC_B, SC_N, SC_M,
    SC_COMMA, SC_PERIOD, SC_SLASH, 0, 0, 0, 0, 0,
    /* 0x40-0x4F: Space BS Tab Enter Ret Esc x x x x KP- x Up Down Right Left */
    SC_SPACE, SC_BACKSPACE, SC_TAB, SC_ENTER, SC_ENTER, SC_ESCAPE, 0, 0,
    0, 0, SC_KEYPADMINUS, 0, SC_UP, SC_DOWN, SC_RIGHT, SC_LEFT,
    /* 0x50-0x5F: F1-F10 x x */
    SC_F1, SC_F2, SC_F3, SC_F4, SC_F5, SC_F6, SC_F7, SC_F8,
    SC_F9, SC_F10, 0, 0, 0, 0, 0, 0,
    /* 0x60-0x6F: LShift RShift CapsLk Ctrl LAlt RAlt LAmiga RAmiga ... */
    SC_LSHIFT, SC_RSHIFT, SC_CAPSLOCK, SC_CONTROL, SC_LALT, SC_RALT, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    /* 0x70-0x7F: unused */
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0
};
static int driver_init(char *title, int w, int h, int depth, int refresh_rate, int flags) {
    if (flags & DRIVER_OPENGL) return -1;
    if (depth > 8) return -1; /* Amiga chipset only supports up to 8bpp */
    if (amiga_screen) return -1; /* Already initialized */

    IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 36);
    GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 40);
    if (!IntuitionBase || !GfxBase) goto fail;

    amiga_screen = OpenScreenTags(NULL,
        SA_Width, w, SA_Height, h, SA_Depth, depth,
        SA_Title, (ULONG)(title ? title : "FreeBASIC"),
        SA_ShowTitle, FALSE, SA_Quiet, TRUE, TAG_DONE);
    if (!amiga_screen) goto fail;

    amiga_window = OpenWindowTags(NULL,
        WA_CustomScreen, (ULONG)amiga_screen,
        WA_Left, 0, WA_Top, 0, WA_Width, w, WA_Height, h,
        WA_Borderless, TRUE, WA_Activate, TRUE, WA_RMBTrap, TRUE,
        WA_IDCMP, IDCMP_RAWKEY | IDCMP_MOUSEBUTTONS | IDCMP_MOUSEMOVE,
        WA_Flags, WFLG_BACKDROP | WFLG_BORDERLESS | WFLG_REPORTMOUSE,
        TAG_DONE);
    if (!amiga_window) goto fail;

    return 0;
fail:
    if (amiga_screen) { CloseScreen(amiga_screen); amiga_screen = NULL; }
    if (GfxBase) { CloseLibrary((struct Library *)GfxBase); GfxBase = NULL; }
    if (IntuitionBase) { CloseLibrary((struct Library *)IntuitionBase); IntuitionBase = NULL; }
    return -1;
}

extern void fb_GfxJoystickExit(void);

static void driver_exit(void) {
    fb_GfxJoystickExit();
    if (tmp_bm) { FreeBitMap(tmp_bm); tmp_bm = NULL; }
    if (amiga_window) { CloseWindow(amiga_window); amiga_window = NULL; }
    if (amiga_screen) { CloseScreen(amiga_screen); amiga_screen = NULL; }
    if (GfxBase) { CloseLibrary((struct Library *)GfxBase); GfxBase = NULL; }
    if (IntuitionBase) { CloseLibrary((struct Library *)IntuitionBase); IntuitionBase = NULL; }
}

static void driver_lock(void) { }
static void driver_unlock(void) { }

static void driver_set_palette(int index, int r, int g, int b) {
    if (amiga_screen && GfxBase) {

        /* Scale 8-bit (0-255) to 32-bit by replicating across all bytes */
        ULONG r32 = ((ULONG)r << 24) | ((ULONG)r << 16) | ((ULONG)r << 8) | (ULONG)r;
        ULONG g32 = ((ULONG)g << 24) | ((ULONG)g << 16) | ((ULONG)g << 8) | (ULONG)g;
        ULONG b32 = ((ULONG)b << 24) | ((ULONG)b << 16) | ((ULONG)b << 8) | (ULONG)b;
        SetRGB32(&amiga_screen->ViewPort, index, r32, g32, b32);
    }
}

static void driver_wait_vsync(void) {
    if (GfxBase) WaitTOF();
}

static int driver_get_mouse(int *x, int *y, int *z, int *buttons, int *clip) {
    *x = mouse_x; *y = mouse_y; *z = mouse_z;
    *buttons = mouse_buttons; *clip = 0;
    return 0;
}

static void driver_set_mouse(int x, int y, int cursor, int clip) {
    /* Not easily supported without pointer sprite manipulation */
}

static void driver_set_window_title(char *title) {
    if (amiga_window) SetWindowTitles(amiga_window, (UBYTE *)title, (UBYTE *)-1);
}

static void driver_update(void) {
    if (!amiga_window || !__fb_gfx) return;

    struct RastPort *rp = amiga_window->RPort;
    unsigned char *src = __fb_gfx->framebuffer;
    int w = __fb_gfx->w, h = __fb_gfx->h;

    /* Allocate/reallocate temp bitmap for WritePixelArray8 */
    if (!tmp_bm || tmp_bm_width != w) {
        if (tmp_bm) FreeBitMap(tmp_bm);
        tmp_bm = AllocBitMap(w, h, amiga_screen->RastPort.BitMap->Depth, 0,
                             amiga_screen->RastPort.BitMap);
        if (!tmp_bm) { tmp_bm_width = 0; return; }
        InitRastPort(&tmp_rp);
        tmp_rp.BitMap = tmp_bm;
        tmp_bm_width = w;
    }

    WritePixelArray8(rp, 0, 0, w - 1, h - 1, src, &tmp_rp);
}

static void driver_poll_events(void) {
    if (!amiga_window || !__fb_gfx) return;
    struct IntuiMessage *msg;
    while ((msg = (struct IntuiMessage *)GetMsg(amiga_window->UserPort))) {
        switch (msg->Class) {
            case IDCMP_MOUSEMOVE:
                mouse_x = msg->MouseX;
                mouse_y = msg->MouseY;
                break;
            case IDCMP_MOUSEBUTTONS:
                if (msg->Code == SELECTDOWN) mouse_buttons |= 1;
                else if (msg->Code == SELECTUP) mouse_buttons &= ~1;
                else if (msg->Code == MENUDOWN) mouse_buttons |= 2;
                else if (msg->Code == MENUUP) mouse_buttons &= ~2;
                break;
            case IDCMP_RAWKEY: {
                int amiga_sc = msg->Code & 0x7F;
                int pressed = !(msg->Code & 0x80);
                int fb_sc = amiga_to_fb_scancode[amiga_sc];
                if (fb_sc) {
                    __fb_gfx->key[fb_sc] = pressed ? TRUE : FALSE;
                    if (pressed) fb_hPostKey(fb_sc);
                }
                break;
            }
        }
        ReplyMsg((struct Message *)msg);
    }
}

const GFXDRIVER fb_gfxDriverAmiga = {
    "Amiga",
    driver_init,
    driver_exit,
    driver_lock,
    driver_unlock,
    driver_set_palette,
    driver_wait_vsync,
    driver_get_mouse,
    driver_set_mouse,
    driver_set_window_title,
    NULL,               /* set_window_pos */
    NULL,               /* fetch_modes */
    NULL,               /* flip */
    driver_poll_events,
    driver_update
};

/* Driver list for Amiga */
const GFXDRIVER *__fb_gfx_drivers_list[] = {
    &fb_gfxDriverAmiga,
    NULL
};

void fb_hScreenInfo(ssize_t *width, ssize_t *height, ssize_t *depth, ssize_t *refresh) {
    *width = 640; *height = 480; *depth = 8; *refresh = 50;
}

#endif /* HOST_AMIGAOS */
