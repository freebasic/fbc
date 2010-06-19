/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_multikey.c -- Linux multikey function implementation
 *
 * chng: jul/2005 written [lillo]
 *
 */

#ifdef WITH_X

#include "fb.h"
#include "fb_scancodes.h"
#include <X11/Xlib.h>
#include <X11/keysym.h>

const KeysymToScancode fb_keysym_to_scancode[] = {
	{ XK_Escape,		0x01 },	{ XK_F1,			0x3B }, { XK_F2,			0x3C },
	{ XK_F3,			0x3D }, { XK_F4,			0x3E }, { XK_F5,			0x3F },
	{ XK_F6,			0x40 }, { XK_F7,			0x41 },	{ XK_F8,			0x42 },
	{ XK_F9,			0x43 }, { XK_F10,			0x44 }, { XK_F11,			0x57 },
	{ XK_F12,			0x58 }, { XK_Scroll_Lock,	0x46 }, { XK_grave,			0x29 },
	{ XK_quoteleft,		0x29 }, { XK_asciitilde,	0x29 }, { XK_1,				0x02 },
	{ XK_2,				0x03 }, { XK_3,				0x04 }, { XK_4,				0x05 },
	{ XK_5,				0x06 }, { XK_6,				0x07 }, { XK_7,				0x08 },
	{ XK_8,				0x09 }, { XK_9,				0x0A }, { XK_0,				0x0B },
	{ XK_minus,			0x0C }, { XK_equal,			0x0D }, { XK_backslash,		0x2B },
	{ XK_BackSpace,		0x0E }, { XK_Tab,			0x0F }, { XK_q,				0x10 },
	{ XK_w,				0x11 }, { XK_e,				0x12 }, { XK_r,				0x13 },
	{ XK_t,				0x14 }, { XK_y,				0x15 }, { XK_u,				0x16 },
	{ XK_i,				0x17 }, { XK_o,				0x18 }, { XK_p,				0x19 },
	{ XK_bracketleft,	0x1A }, { XK_bracketright,	0x1B }, { XK_Return,		0x1C },
	{ XK_Caps_Lock,		0x3A }, { XK_a,				0x1E }, { XK_s,				0x1F },
	{ XK_d,				0x20 }, { XK_f,				0x21 }, { XK_g,				0x22 },
	{ XK_h,				0x23 }, { XK_j,				0x24 }, { XK_k,				0x25 },
	{ XK_l,				0x26 }, { XK_semicolon,		0x27 }, { XK_apostrophe,	0x28 },
	{ XK_Shift_L,		0x2A }, { XK_z,				0x2C }, { XK_x,				0x2D },
	{ XK_c,				0x2E }, { XK_v,				0x2F }, { XK_b,				0x30 },
	{ XK_n,				0x31 }, { XK_m,				0x32 }, { XK_comma,			0x33 },
	{ XK_period,		0x34 }, { XK_slash,			0x35 }, { XK_Shift_R,		0x36 },
	{ XK_Control_L,		0x1D }, { XK_Meta_L,		0x5B }, { XK_Alt_L,			0x38 },
	{ XK_space,			0x39 }, { XK_Alt_R,			0x38 }, { XK_Meta_R,		0x5C },
	{ XK_Menu,			0x5D }, { XK_Control_R,		0x1D }, { XK_Insert,		0x52 },
	{ XK_Home,			0x47 }, { XK_Prior,			0x49 }, { XK_Delete,		0x53 },
	{ XK_End,			0x4F }, { XK_Next,			0x51 }, { XK_Up,			0x48 },
	{ XK_Left,			0x4B }, { XK_Down,			0x50 }, { XK_Right,			0x4D },
	{ XK_Num_Lock,		0x45 }, { XK_KP_Divide,		0x35 }, { XK_KP_Multiply,	0x37 },
	{ XK_KP_Subtract,	0x4A }, { XK_KP_Home,		0x47 }, { XK_KP_Up,			0x48 },
	{ XK_KP_Prior,		0x49 }, { XK_KP_Add,		0x4E }, { XK_KP_Left,		0x4B },
	{ XK_KP_Begin,		0x4C }, { XK_KP_Right,		0x4D }, { XK_KP_End,		0x4F },
	{ XK_KP_Down,		0x50 }, { XK_KP_Next,		0x51 }, { XK_KP_Enter,		0x1C },
	{ XK_KP_Insert,		0x52 }, { XK_KP_Delete,		0x53 }, { NoSymbol,			0x00 }
};

#endif

