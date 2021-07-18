/* assembler definitions for MMX routines */

#ifndef __FB_GFX_MMX_H__
#define __FB_GFX_MMX_H__

#include "../../rtlib/fb_config.h"

#if defined(HOST_WIN32) || defined(HOST_DOS) || defined(HOST_XBOX) || defined(HOST_DARWIN)
#define GLOBL(name)		_##name
#else
#define GLOBL(name)		name
#endif
#define FUNC(name)		.globl GLOBL(name) ; .balign 8, 0x90 ; GLOBL(name) :
#define VAR(name)		.globl GLOBL(name) ; GLOBL(name) :
#define LABEL(name)		.balign 4, 0x90 ; name :

#define RESERVE_LOCALS(n)	subl $((n)*4), %esp
#define FREE_LOCALS(n)		addl $((n)*4), %esp

#define ARG1			8(%ebp)
#define ARG2			12(%ebp)
#define ARG3			16(%ebp)
#define ARG4			20(%ebp)
#define ARG5			24(%ebp)
#define ARG6			28(%ebp)
#define ARG7			32(%ebp)
#define ARG8			36(%ebp)

#define LOCAL1			-4(%ebp)
#define LOCAL2			-8(%ebp)
#define LOCAL3			-12(%ebp)
#define LOCAL4			-16(%ebp)

#define MASK_COLOR_32		0xFF00FF
#define MASK_COLOR_16		0xF81F

#define MASK_RGB_32			0x00FFFFFF
#define MASK_RB_32			0x00FF00FF
#define MASK_G_32			0x0000FF00
#define MASK_GA_32			0xFF00FF00
#define MASK_A_32			0xFF000000

#define MASK_RB_16			0xF81F
#define MASK_R_16			0xF800
#define MASK_G_16			0x07E0
#define MASK_B_16			0x001F

#define GFX_SCREEN_ID			0
#define GFX_MODE_NUM			4
#define GFX_PAGE				8
#define GFX_NUM_PAGES			12
#define GFX_VISIBLE_PAGE		16
#define GFX_FRAMEBUFFER			20
#define GFX_MODE_W				24
#define GFX_MODE_H				28
#define GFX_DEPTH				32
#define GFX_BPP					36
#define GFX_PITCH				40
#define GFX_PALETTE				44
#define GFX_DEVICE_PALETTE		48
#define GFX_COLOR_ASSOCIATION	52
#define GFX_DIRTY				56
#define GFX_DRIVER				60
#define GFX_COLOR_MASK			64
#define GFX_DEFAULT_PAL			68
#define GFX_SCANLINE_SIZE		72
#define GFX_CURSOR_X			76
#define GFX_CURSOR_Y			80
#define GFX_FONT				84
#define GFX_TEXT_W				88
#define GFX_TEXT_H				92
#define GFX_KEY					96
#define GFX_REFRESH_RATE		100
#define GFX_CON_PAGES			104
#define GFX_EVENTS_QUEUE		108
#define GFX_EVENT_HEAD			112
#define GFX_EVENT_TAIL			116
#define GFX_EVENT_MUTEX			120
#define GFX_FLAGS				124

#define CTX_SCREEN_ID			0
#define CTX_WORK_PAGE			4
#define CTX_LINE				8
#define CTX_MAX_H				12
#define CTX_TARGET_BPP			16
#define CTX_TARGET_PITCH		20
#define CTX_LAST_TARGET			24
#define CTX_LAST_X				28
#define CTX_LAST_Y				32
#define CTX_VIEW_X				36
#define CTX_VIEW_Y				40
#define CTX_VIEW_W				44
#define CTX_VIEW_H				48
#define CTX_OLD_VIEW_X			52
#define CTX_OLD_VIEW_Y			56
#define CTX_OLD_VIEW_W			60
#define CTX_OLD_VIEW_H			64
#define CTX_WIN_X				68
#define CTX_WIN_Y				72
#define CTX_WIN_W				76
#define CTX_WIN_H				80
#define CTX_FG_COLOR			84
#define CTX_BG_COLOR			88
#define CTX_PUT_PIXEL			92
#define CTX_GET_PIXEL			96
#define CTX_PIXEL_SET			100
#define CTX_PUTTER				104
#define CTX_PUT_BPP				108
#define CTX_FLAGS				112

#endif
