/* console input helpers */

#include "../fb.h"
#include "fb_private_console.h"
#include <math.h>

// QB key codes that are processed by keydown
static const unsigned short js_keycode_to_qb_key_tb[128] =
{
    [  8] = 8,              /* backspace */
    [  9] = 9,              /* tab */
    [ 13] = 13,             /* enter */
    [ 27] = 27,             /* esc */
    [ 33] = QB_EXTK(73),    /* pgup */
    [ 34] = QB_EXTK(81),    /* pgdown */
    [ 35] = QB_EXTK(79),    /* end */
    [ 36] = QB_EXTK(71),    /* home */
    [ 37] = QB_EXTK(75),    /* left */
    [ 38] = QB_EXTK(72),    /* up */
    [ 39] = QB_EXTK(77),    /* right */
    [ 40] = QB_EXTK(80),    /* down */
    [ 45] = QB_EXTK(82),    /* insert */
    [ 46] = QB_EXTK(83),    /* delete */
    [112] = QB_EXTK(59),    /* F1 */
    [113] = QB_EXTK(60),    /* F2 */
    [114] = QB_EXTK(61),    /* F3 */
    [115] = QB_EXTK(62),    /* F4 */
    [116] = QB_EXTK(63),    /* F5 */
    [117] = QB_EXTK(64),    /* F6 */
    [118] = QB_EXTK(65),    /* F7 */
    [119] = QB_EXTK(66),    /* F8 */
    [120] = QB_EXTK(67),    /* F9 */
    [121] = QB_EXTK(68),    /* F10 */
    [122] = QB_EXTK(133),   /* F11 */
    [123] = QB_EXTK(134),   /* F12 */
};

// QB key codes returned when CTRL is pressed
static const unsigned short js_keycode_to_qb_key_ctrl_tb[128] =
{
    [  8] = 127,            /* backspace */
    [ 13] = 10,             /* enter */
    [ 32] = 32,             /* espace */
    [ 33] = QB_EXTK(132),   /* pgup */
    [ 34] = QB_EXTK(118),   /* pgdown */
    [ 35] = QB_EXTK(117),   /* end */
    [ 36] = QB_EXTK(119),   /* home */
    [ 37] = QB_EXTK(115),   /* left */
    [ 38] = QB_EXTK(141),   /* up */
    [ 39] = QB_EXTK(116),   /* right */
    [ 40] = QB_EXTK(145),   /* down */
    [ 45] = QB_EXTK(146),   /* insert */
    [ 46] = QB_EXTK(147),   /* delete */
    [ 65] = 1,              /* A */
    [ 66] = 2,              /* B */
    [ 67] = 3,              /* C */
    [ 68] = 4,              /* D */
    [ 69] = 5,              /* E */
    [ 70] = 6,              /* F */
    [ 71] = 7,              /* G */
    [ 72] = 8,              /* H */
    [ 73] = 9,              /* I */
    [ 74] = 10,             /* J */
    [ 75] = 11,             /* K */
    [ 76] = 12,             /* L */
    [ 77] = 13,             /* M */
    [ 78] = 14,             /* N */
    [ 79] = 15,             /* O */
    [ 80] = 16,             /* P */
    [ 81] = 17,             /* Q */
    [ 82] = 18,             /* R */
    [ 83] = 19,             /* S */
    [ 84] = 20,             /* T */
    [ 85] = 21,             /* U */
    [ 86] = 22,             /* V */
    [ 87] = 23,             /* W */
    [ 88] = 24,             /* X */
    [ 89] = 25,             /* Y */
    [ 90] = 26,             /* Z */
    [ 91] = 27,             /* [ */
    [ 92] = 28,             /* \ */
    [ 93] = 29,             /* ] */
    [112] = QB_EXTK(94),    /* F1 */
    [113] = QB_EXTK(95),    /* F2 */
    [114] = QB_EXTK(96),    /*__fb_ctx.hooks.posteventproc(&fb_event); F3 */
    [115] = QB_EXTK(97),    /* F4 */
    [116] = QB_EXTK(98),    /* F5 */
    [117] = QB_EXTK(99),    /* F6 */
    [118] = QB_EXTK(100),   /* F7 */
    [119] = QB_EXTK(101),   /* F8 */
    [120] = QB_EXTK(102),   /* F9 */
    [121] = QB_EXTK(103),   /* F10 */
    [122] = QB_EXTK(137),   /* F11 */
    [123] = QB_EXTK(138),   /* F12 */
};

// keycodes that should not be remapped by keydown
static const unsigned char js_keycode_to_not_process_tb[256] =
{
    [ 16] = 1,             /* shift */
    [ 17] = 1,             /* ctrl */
    [ 18] = 1,             /* alt */
    [ 20] = 1,             /* capslock */
    [ 32] = 1,             /* espace */
    [ 59] = 1,             /* ; */
    [ 61] = 1,             /* = */
    [ 91] = 1,             /* lwin */
    [ 93] = 1,             /* menu */
    [144] = 1,             /* numlock */
    [145] = 1,             /* scrolllock */
    [173] = 1,             /* - */
    [176] = 1,             /* ~ */
    [188] = 1,             /* , */
    [190] = 1,             /* . */
    [191] = 1,             /* / */
    [219] = 1,             /* [ */
    [220] = 1,             /* \ */
    [221] = 1,             /* ] */
    [222] = 1,             /* ' */
};

// keyboard scan codes returned my MultiKey()
static const unsigned char js_keycode_to_qb_scancode_tb[256] =
{
    [  8] = SC_BACKSPACE,
    [  9] = SC_TAB,
    [ 13] = SC_ENTER,
    [ 20] = SC_CAPSLOCK,
    [ 27] = SC_ESCAPE,
    [ 32] = SC_SPACE,
    [ 33] = SC_PAGEUP,
    [ 34] = SC_PAGEDOWN,
    [ 35] = SC_END,
    [ 36] = SC_HOME,
    [ 37] = SC_LEFT,
    [ 38] = SC_UP,
    [ 39] = SC_RIGHT,
    [ 40] = SC_DOWN,
    [ 45] = SC_INSERT,
    [ 46] = SC_DELETE,
    [ 48] = SC_0,
    [ 49] = SC_1,
    [ 50] = SC_2,
    [ 51] = SC_3,
    [ 52] = SC_4,
    [ 53] = SC_5,
    [ 54] = SC_6,
    [ 55] = SC_7,
    [ 56] = SC_8,
    [ 57] = SC_9,
    [ 59] = SC_SEMICOLON,
    [ 61] = SC_EQUALS,
    [ 65] = SC_A,
    [ 66] = SC_B,
    [ 67] = SC_C,
    [ 68] = SC_D,
    [ 69] = SC_E,
    [ 70] = SC_F,
    [ 71] = SC_G,
    [ 72] = SC_H,
    [ 73] = SC_I,
    [ 74] = SC_J,
    [ 75] = SC_K,
    [ 76] = SC_L,
    [ 77] = SC_M,
    [ 78] = SC_N,
    [ 79] = SC_O,
    [ 80] = SC_P,
    [ 81] = SC_Q,
    [ 82] = SC_R,
    [ 83] = SC_S,
    [ 84] = SC_T,
    [ 85] = SC_U,
    [ 86] = SC_V,
    [ 87] = SC_W,
    [ 88] = SC_X,
    [ 89] = SC_Y,
    [ 90] = SC_Z,
    [ 93] = SC_MENU,
    [106] = SC_MULTIPLY,          /* * (numpad) */
    [107] = SC_PLUS,              /* + (numpad) */
    [108] = SC_PERIOD,            /* . (numpad) */
    [109] = SC_MINUS,             /* - (numpad) */
    [110] = SC_COMMA,             /* , (numpad) */
    [111] = SC_SLASH,             /* / (numpad) */
    [112] = SC_F1,
    [113] = SC_F2,
    [114] = SC_F3,
    [115] = SC_F4,
    [116] = SC_F5,
    [117] = SC_F6,
    [118] = SC_F7,
    [119] = SC_F8,
    [120] = SC_F9,
    [121] = SC_F10,
    [122] = SC_F11,
    [123] = SC_F12,
    [144] = SC_NUMLOCK,
    [145] = SC_SCROLLLOCK,
    [173] = SC_MINUS,
    [176] = SC_TILDE,
    [188] = SC_COMMA,
    [190] = SC_PERIOD,
    [191] = SC_SLASH,
    [219] = SC_LEFTBRACKET,
    [220] = SC_BACKSLASH,
    [221] = SC_RIGHTBRACKET,
    [222] = SC_QUOTE,
};

static unsigned int js_keycode_to_qb_key(const EmscriptenKeyboardEvent *keyEvent)
{
    unsigned int key = keyEvent->keyCode;

    // numpad?
    if( keyEvent->location == 3 )
    {
        // numlock on? let keypress process it
        if( key > 46 )
            return 0;
    }

    // ctrl? remap to the special qb keys
    if( keyEvent->ctrlKey )
    {
        if( key < 128 )
            key = js_keycode_to_qb_key_ctrl_tb[key];
    }
    else
    {
        // printable character or other key that should not be returned to inkey()? let keypress do the rest
        if( (key >= 'A' && key <= 'Z') ||
            (key >= '0' && key <= '9') ||
            (key < 256 && js_keycode_to_not_process_tb[key] != 0) )
        {
            return 0;
        }
        else
        {
            // remap to QB key code
            if( key < 128 )
            {
                unsigned short qbkey = js_keycode_to_qb_key_tb[key];
                if( qbkey != 0 )
                    key = qbkey;
            }
        }
    }

    return key;
}

static unsigned int js_multikey_handler(unsigned long key, unsigned long location, int isKeyDown)
{
    unsigned int scancode = 0;

    if( key < 256 )
    {
        switch( key )
        {
            // shift?
            case 16:
                /* location == 1? left-shift: right-shift */
                scancode = location == 1? SC_LSHIFT: SC_RSHIFT;
                break;

            // ctrl?
            case 17:
                /* location == 1? left-ctrl: right-ctrl */
                scancode = location == 1? SC_CONTROL: SC_CONTROL;
                break;

            // alt?
            case 18:
                /* location == 1? left-alt: alt-gr */
                scancode = location == 1? SC_ALT: SC_ALTGR;
                break;

            // win?
            case 91:
                /* location == 1? lwin: rwin */
                scancode = location == 1? SC_LWIN: SC_RWIN;
                break;

            default:
                scancode = js_keycode_to_qb_scancode_tb[key];
                break;
        }

        __fb_con.multikey[scancode] = isKeyDown? 1: 0;
    }

    return scancode;
}

static void js_key_buffer_add(unsigned int key)
{
    __fb_con.key_buffer[__fb_con.key_tail] = key;
    __fb_con.key_tail = (__fb_con.key_tail + 1) % KEY_BUFFER_LEN;

    if( __fb_con.key_tail == __fb_con.key_head )
        __fb_con.key_head = (__fb_con.key_head + 1) % KEY_BUFFER_LEN;

}

EM_BOOL fb_hKeyEventHandler(int eventType, const EmscriptenKeyboardEvent *keyEvent, void *userData)
{
	static unsigned int scancode;
	static unsigned int keycode;

	switch( eventType )
	{
        case EMSCRIPTEN_EVENT_KEYDOWN:
        {
            EM_BOOL supress_keypress = 0;
            if( keyEvent->keyCode != 0)
            {
                keycode = js_keycode_to_qb_key( keyEvent );
                if( keycode != 0 )
                {
                    js_key_buffer_add(keycode);
                    // as the key code was added to Inkey's buffer, supress the keypress handler
                    supress_keypress = 1;
                }

                scancode = js_multikey_handler(keyEvent->keyCode, keyEvent->location, TRUE);

                if( supress_keypress )
                {
                    if(__fb_ctx.hooks.posteventproc != NULL)
                    {
                        EVENT fb_event = { .type = EVENT_KEY_PRESS, .scancode = scancode, .ascii = scancode };
                        __fb_ctx.hooks.posteventproc(&fb_event);
                    }

                }
            }

            return supress_keypress;
        }

        case EMSCRIPTEN_EVENT_KEYPRESS:
        {
            // printable char and CTRL not pressed? add it to Inkey's buffer..
            keycode = keyEvent->charCode;
            if( keycode != 0)
            {
                if( keyEvent->ctrlKey == 0)
                {
                    js_key_buffer_add(keycode);

                    if(__fb_ctx.hooks.posteventproc != NULL)
                    {
                        EVENT fb_event = { .type = EVENT_KEY_PRESS, .scancode = scancode, .ascii = keycode };
                        __fb_ctx.hooks.posteventproc(&fb_event);
                    }
                }
            }

            return 0;
        }

        case EMSCRIPTEN_EVENT_KEYUP:
        {
            scancode = js_multikey_handler(keyEvent->keyCode, keyEvent->location, FALSE);

            if(__fb_ctx.hooks.posteventproc != NULL)
            {
                EVENT fb_event = { .type = EVENT_KEY_RELEASE, .scancode = scancode, .ascii = keycode };
                __fb_ctx.hooks.posteventproc(&fb_event);
            }

            return 1;
        }

        default:
        {
            return 0;
        }
	}
}

EM_BOOL fb_hMouseEventHandler(int eventType, const EmscriptenMouseEvent *mouseEvent, void *userData)
{
    switch( eventType )
    {
        case EMSCRIPTEN_EVENT_MOUSEMOVE:
        case EMSCRIPTEN_EVENT_MOUSEDOWN:
        case EMSCRIPTEN_EVENT_MOUSEUP:
        case EMSCRIPTEN_EVENT_DBLCLICK:
        {
            __fb_con.mouse.x = mouseEvent->clientX;
            __fb_con.mouse.y = mouseEvent->clientY;
            __fb_con.mouse.dx = mouseEvent->movementX;
            __fb_con.mouse.dy = mouseEvent->movementY;
            __fb_con.mouse.button = mouseEvent->button == 0? BUTTON_LEFT: (mouseEvent->button == 1? BUTTON_MIDDLE: BUTTON_RIGHT);
			break;
        }
    }

    return 0;
}

int fb_hConsoleInputBufferChanged( void )
{
    return fb_ConsoleKeyHit();
}

