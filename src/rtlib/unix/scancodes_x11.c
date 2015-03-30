#include "../fb.h"
#include "fb_private_scancodes_x11.h"

#ifndef DISABLE_X11

typedef struct KeysymToScancode {
	KeySym keysym;
	int scancode;
} KeysymToScancode;

static const KeysymToScancode keysym_to_scancode[] =
{
	{ XK_Escape      , SC_ESCAPE       },
	{ XK_F1          , SC_F1           },
	{ XK_F2          , SC_F2           },
	{ XK_F3          , SC_F3           },
	{ XK_F4          , SC_F4           },
	{ XK_F5          , SC_F5           },
	{ XK_F6          , SC_F6           },
	{ XK_F7          , SC_F7           },
	{ XK_F8          , SC_F8           },
	{ XK_F9          , SC_F9           },
	{ XK_F10         , SC_F10          },
	{ XK_F11         , SC_F11          },
	{ XK_F12         , SC_F12          },
	{ XK_Scroll_Lock , SC_SCROLLLOCK   },
	{ XK_grave       , SC_TILDE        },
	{ XK_quoteleft   , SC_TILDE        },
	{ XK_asciitilde  , SC_TILDE        },
	{ XK_1           , SC_1            },
	{ XK_2           , SC_2            },
	{ XK_3           , SC_3            },
	{ XK_4           , SC_4            },
	{ XK_5           , SC_5            },
	{ XK_6           , SC_6            },
	{ XK_7           , SC_7            },
	{ XK_8           , SC_8            },
	{ XK_9           , SC_9            },
	{ XK_0           , SC_0            },
	{ XK_minus       , SC_MINUS        },
	{ XK_equal       , SC_EQUALS       },
	{ XK_backslash   , SC_BACKSLASH    },
	{ XK_BackSpace   , SC_BACKSPACE    },
	{ XK_Tab         , SC_TAB          },
	{ XK_q           , SC_Q            },
	{ XK_w           , SC_W            },
	{ XK_e           , SC_E            },
	{ XK_r           , SC_R            },
	{ XK_t           , SC_T            },
	{ XK_y           , SC_Y            },
	{ XK_u           , SC_U            },
	{ XK_i           , SC_I            },
	{ XK_o           , SC_O            },
	{ XK_p           , SC_P            },
	{ XK_bracketleft , SC_LEFTBRACKET  },
	{ XK_bracketright, SC_RIGHTBRACKET },
	{ XK_Return      , SC_ENTER        },
	{ XK_Caps_Lock   , SC_CAPSLOCK     },
	{ XK_a           , SC_A            },
	{ XK_s           , SC_S            },
	{ XK_d           , SC_D            },
	{ XK_f           , SC_F            },
	{ XK_g           , SC_G            },
	{ XK_h           , SC_H            },
	{ XK_j           , SC_J            },
	{ XK_k           , SC_K            },
	{ XK_l           , SC_L            },
	{ XK_semicolon   , SC_SEMICOLON    },
	{ XK_apostrophe  , SC_QUOTE        },
	{ XK_Shift_L     , SC_LSHIFT       },
	{ XK_z           , SC_Z            },
	{ XK_x           , SC_X            },
	{ XK_c           , SC_C            },
	{ XK_v           , SC_V            },
	{ XK_b           , SC_B            },
	{ XK_n           , SC_N            },
	{ XK_m           , SC_M            },
	{ XK_comma       , SC_COMMA        },
	{ XK_period      , SC_PERIOD       },
	{ XK_slash       , SC_SLASH        },
	{ XK_Shift_R     , SC_RSHIFT       },
	{ XK_Control_L   , SC_CONTROL      },
	{ XK_Meta_L      , SC_LWIN         },
	{ XK_Alt_L       , SC_ALT          },
	{ XK_space       , SC_SPACE        },
	{ XK_Alt_R       , SC_ALT          },
	{ XK_Meta_R      , SC_RWIN         },
	{ XK_Menu        , SC_MENU         },
	{ XK_Control_R   , SC_CONTROL      },
	{ XK_Insert      , SC_INSERT       },
	{ XK_Home        , SC_HOME         },
	{ XK_Prior       , SC_PAGEUP       },
	{ XK_Delete      , SC_DELETE       },
	{ XK_End         , SC_END          },
	{ XK_Next        , SC_PAGEDOWN     },
	{ XK_Up          , SC_UP           },
	{ XK_Left        , SC_LEFT         },
	{ XK_Down        , SC_DOWN         },
	{ XK_Right       , SC_RIGHT        },
	{ XK_Num_Lock    , SC_NUMLOCK      },
	{ XK_KP_Divide   , SC_SLASH        },
	{ XK_KP_Multiply , SC_MULTIPLY     },
	{ XK_KP_Subtract , SC_MINUS        },
	{ XK_KP_Home     , SC_HOME         },
	{ XK_KP_Up       , SC_UP           },
	{ XK_KP_Prior    , SC_PAGEUP       },
	{ XK_KP_Add      , SC_PLUS         },
	{ XK_KP_Left     , SC_LEFT         },
	{ XK_KP_Begin    , SC_CLEAR        },
	{ XK_KP_Right    , SC_RIGHT        },
	{ XK_KP_End      , SC_END          },
	{ XK_KP_Down     , SC_DOWN         },
	{ XK_KP_Next     , SC_PAGEDOWN     },
	{ XK_KP_Enter    , SC_ENTER        },
	{ XK_KP_Insert   , SC_INSERT       },
	{ XK_KP_Delete   , SC_DELETE       },
	{ NoSymbol       , 0               }
};

unsigned char fb_x11keycode_to_scancode[256];

void fb_hInitX11KeycodeToScancodeTb
	(
		Display *display,
		XDISPLAYKEYCODES DisplayKeycodes,
		XGETKEYBOARDMAPPING GetKeyboardMapping,
		XFREE Free
	)
{
	int keycode_min, keycode_max, i, j;
	int keysyms_per_keycode_return;

	DisplayKeycodes( display, &keycode_min, &keycode_max );
	if( keycode_min < 0   ) keycode_min = 0;
	if( keycode_max > 255 ) keycode_max = 255;

	for( i = keycode_min; i <= keycode_max; i++ ) {
		KeySym *keysyms = GetKeyboardMapping( display, i, 1, &keysyms_per_keycode_return );

		KeySym keysym = keysyms[0];
		if( keysym != NoSymbol ) {
			for( j = 0;
			     keysym_to_scancode[j].scancode &&
			         (keysym_to_scancode[j].keysym != keysym);
			     j++ )
				;
			fb_x11keycode_to_scancode[i] = keysym_to_scancode[j].scancode;
		}

		Free( keysyms );
	}
}

#endif
