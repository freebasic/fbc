'' FreeBASIC binding for freeglut-3.0.0
''
'' based on the C header files:
''   freeglut_std.h
''
''   The GLUT-compatible part of the freeglut library include file
''
''   Copyright (c) 1999-2000 Pawel W. Olszta. All Rights Reserved.
''   Written by Pawel W. Olszta, <olszta@sourceforge.net>
''   Creation date: Thu Dec 2 1999
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "GL/gl.bi"
#include once "GL/glu.bi"

#if defined(__FB_WIN32__) and (not defined(FREEGLUT_STATIC))
	extern "Windows"
#else
	extern "C"
#endif

#define __FREEGLUT_STD_H__

#ifdef __FB_WIN32__
	#ifdef FREEGLUT_STATIC
		#inclib "freeglut_static"
	#else
		#inclib "freeglut"
	#endif

	#inclib "glu32"
	#inclib "opengl32"
	#inclib "gdi32"
	#inclib "winmm"
	#inclib "user32"
	#ifdef FREEGLUT_STATIC
		#inclib "freeglut_static"
		#inclib "advapi32"
	#else
		#inclib "freeglut"
	#endif
#elseif defined(__FB_UNIX__)
	#inclib "glut"
#else
	#inclib "freeglut"
#endif

const FREEGLUT = 1
const GLUT_API_VERSION = 4
const GLUT_XLIB_IMPLEMENTATION = 13
const FREEGLUT_VERSION_2_0 = 1
const GLUT_KEY_F1 = &h0001
const GLUT_KEY_F2 = &h0002
const GLUT_KEY_F3 = &h0003
const GLUT_KEY_F4 = &h0004
const GLUT_KEY_F5 = &h0005
const GLUT_KEY_F6 = &h0006
const GLUT_KEY_F7 = &h0007
const GLUT_KEY_F8 = &h0008
const GLUT_KEY_F9 = &h0009
const GLUT_KEY_F10 = &h000A
const GLUT_KEY_F11 = &h000B
const GLUT_KEY_F12 = &h000C
const GLUT_KEY_LEFT = &h0064
const GLUT_KEY_UP = &h0065
const GLUT_KEY_RIGHT = &h0066
const GLUT_KEY_DOWN = &h0067
const GLUT_KEY_PAGE_UP = &h0068
const GLUT_KEY_PAGE_DOWN = &h0069
const GLUT_KEY_HOME = &h006A
const GLUT_KEY_END = &h006B
const GLUT_KEY_INSERT = &h006C
const GLUT_LEFT_BUTTON = &h0000
const GLUT_MIDDLE_BUTTON = &h0001
const GLUT_RIGHT_BUTTON = &h0002
const GLUT_DOWN = &h0000
const GLUT_UP = &h0001
const GLUT_LEFT = &h0000
const GLUT_ENTERED = &h0001
const GLUT_RGB = &h0000
const GLUT_RGBA = &h0000
const GLUT_INDEX = &h0001
const GLUT_SINGLE = &h0000
const GLUT_DOUBLE = &h0002
const GLUT_ACCUM = &h0004
const GLUT_ALPHA = &h0008
const GLUT_DEPTH = &h0010
const GLUT_STENCIL = &h0020
const GLUT_MULTISAMPLE = &h0080
const GLUT_STEREO = &h0100
const GLUT_LUMINANCE = &h0200
const GLUT_MENU_NOT_IN_USE = &h0000
const GLUT_MENU_IN_USE = &h0001
const GLUT_NOT_VISIBLE = &h0000
const GLUT_VISIBLE = &h0001
const GLUT_HIDDEN = &h0000
const GLUT_FULLY_RETAINED = &h0001
const GLUT_PARTIALLY_RETAINED = &h0002
const GLUT_FULLY_COVERED = &h0003

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	const GLUT_STROKE_ROMAN = cptr(any ptr, &h0000)
	const GLUT_STROKE_MONO_ROMAN = cptr(any ptr, &h0001)
	const GLUT_BITMAP_9_BY_15 = cptr(any ptr, &h0002)
	const GLUT_BITMAP_8_BY_13 = cptr(any ptr, &h0003)
	const GLUT_BITMAP_TIMES_ROMAN_10 = cptr(any ptr, &h0004)
	const GLUT_BITMAP_TIMES_ROMAN_24 = cptr(any ptr, &h0005)
	const GLUT_BITMAP_HELVETICA_10 = cptr(any ptr, &h0006)
	const GLUT_BITMAP_HELVETICA_12 = cptr(any ptr, &h0007)
	const GLUT_BITMAP_HELVETICA_18 = cptr(any ptr, &h0008)
#else
	extern glutStrokeRoman as any ptr
	extern glutStrokeMonoRoman as any ptr
	extern glutBitmap9By15 as any ptr
	extern glutBitmap8By13 as any ptr
	extern glutBitmapTimesRoman10 as any ptr
	extern glutBitmapTimesRoman24 as any ptr
	extern glutBitmapHelvetica10 as any ptr
	extern glutBitmapHelvetica12 as any ptr
	extern glutBitmapHelvetica18 as any ptr

	#define GLUT_STROKE_ROMAN cptr(any ptr, @glutStrokeRoman)
	#define GLUT_STROKE_MONO_ROMAN cptr(any ptr, @glutStrokeMonoRoman)
	#define GLUT_BITMAP_9_BY_15 cptr(any ptr, @glutBitmap9By15)
	#define GLUT_BITMAP_8_BY_13 cptr(any ptr, @glutBitmap8By13)
	#define GLUT_BITMAP_TIMES_ROMAN_10 cptr(any ptr, @glutBitmapTimesRoman10)
	#define GLUT_BITMAP_TIMES_ROMAN_24 cptr(any ptr, @glutBitmapTimesRoman24)
	#define GLUT_BITMAP_HELVETICA_10 cptr(any ptr, @glutBitmapHelvetica10)
	#define GLUT_BITMAP_HELVETICA_12 cptr(any ptr, @glutBitmapHelvetica12)
	#define GLUT_BITMAP_HELVETICA_18 cptr(any ptr, @glutBitmapHelvetica18)
#endif

const GLUT_WINDOW_X = &h0064
const GLUT_WINDOW_Y = &h0065
const GLUT_WINDOW_WIDTH = &h0066
const GLUT_WINDOW_HEIGHT = &h0067
const GLUT_WINDOW_BUFFER_SIZE = &h0068
const GLUT_WINDOW_STENCIL_SIZE = &h0069
const GLUT_WINDOW_DEPTH_SIZE = &h006A
const GLUT_WINDOW_RED_SIZE = &h006B
const GLUT_WINDOW_GREEN_SIZE = &h006C
const GLUT_WINDOW_BLUE_SIZE = &h006D
const GLUT_WINDOW_ALPHA_SIZE = &h006E
const GLUT_WINDOW_ACCUM_RED_SIZE = &h006F
const GLUT_WINDOW_ACCUM_GREEN_SIZE = &h0070
const GLUT_WINDOW_ACCUM_BLUE_SIZE = &h0071
const GLUT_WINDOW_ACCUM_ALPHA_SIZE = &h0072
const GLUT_WINDOW_DOUBLEBUFFER = &h0073
const GLUT_WINDOW_RGBA = &h0074
const GLUT_WINDOW_PARENT = &h0075
const GLUT_WINDOW_NUM_CHILDREN = &h0076
const GLUT_WINDOW_COLORMAP_SIZE = &h0077
const GLUT_WINDOW_NUM_SAMPLES = &h0078
const GLUT_WINDOW_STEREO = &h0079
const GLUT_WINDOW_CURSOR = &h007A
const GLUT_SCREEN_WIDTH = &h00C8
const GLUT_SCREEN_HEIGHT = &h00C9
const GLUT_SCREEN_WIDTH_MM = &h00CA
const GLUT_SCREEN_HEIGHT_MM = &h00CB
const GLUT_MENU_NUM_ITEMS = &h012C
const GLUT_DISPLAY_MODE_POSSIBLE = &h0190
const GLUT_INIT_WINDOW_X = &h01F4
const GLUT_INIT_WINDOW_Y = &h01F5
const GLUT_INIT_WINDOW_WIDTH = &h01F6
const GLUT_INIT_WINDOW_HEIGHT = &h01F7
const GLUT_INIT_DISPLAY_MODE = &h01F8
const GLUT_ELAPSED_TIME = &h02BC
const GLUT_WINDOW_FORMAT_ID = &h007B
const GLUT_HAS_KEYBOARD = &h0258
const GLUT_HAS_MOUSE = &h0259
const GLUT_HAS_SPACEBALL = &h025A
const GLUT_HAS_DIAL_AND_BUTTON_BOX = &h025B
const GLUT_HAS_TABLET = &h025C
const GLUT_NUM_MOUSE_BUTTONS = &h025D
const GLUT_NUM_SPACEBALL_BUTTONS = &h025E
const GLUT_NUM_BUTTON_BOX_BUTTONS = &h025F
const GLUT_NUM_DIALS = &h0260
const GLUT_NUM_TABLET_BUTTONS = &h0261
const GLUT_DEVICE_IGNORE_KEY_REPEAT = &h0262
const GLUT_DEVICE_KEY_REPEAT = &h0263
const GLUT_HAS_JOYSTICK = &h0264
const GLUT_OWNS_JOYSTICK = &h0265
const GLUT_JOYSTICK_BUTTONS = &h0266
const GLUT_JOYSTICK_AXES = &h0267
const GLUT_JOYSTICK_POLL_RATE = &h0268
const GLUT_OVERLAY_POSSIBLE = &h0320
const GLUT_LAYER_IN_USE = &h0321
const GLUT_HAS_OVERLAY = &h0322
const GLUT_TRANSPARENT_INDEX = &h0323
const GLUT_NORMAL_DAMAGED = &h0324
const GLUT_OVERLAY_DAMAGED = &h0325
const GLUT_VIDEO_RESIZE_POSSIBLE = &h0384
const GLUT_VIDEO_RESIZE_IN_USE = &h0385
const GLUT_VIDEO_RESIZE_X_DELTA = &h0386
const GLUT_VIDEO_RESIZE_Y_DELTA = &h0387
const GLUT_VIDEO_RESIZE_WIDTH_DELTA = &h0388
const GLUT_VIDEO_RESIZE_HEIGHT_DELTA = &h0389
const GLUT_VIDEO_RESIZE_X = &h038A
const GLUT_VIDEO_RESIZE_Y = &h038B
const GLUT_VIDEO_RESIZE_WIDTH = &h038C
const GLUT_VIDEO_RESIZE_HEIGHT = &h038D
const GLUT_NORMAL = &h0000
const GLUT_OVERLAY = &h0001
const GLUT_ACTIVE_SHIFT = &h0001
const GLUT_ACTIVE_CTRL = &h0002
const GLUT_ACTIVE_ALT = &h0004
const GLUT_CURSOR_RIGHT_ARROW = &h0000
const GLUT_CURSOR_LEFT_ARROW = &h0001
const GLUT_CURSOR_INFO = &h0002
const GLUT_CURSOR_DESTROY = &h0003
const GLUT_CURSOR_HELP = &h0004
const GLUT_CURSOR_CYCLE = &h0005
const GLUT_CURSOR_SPRAY = &h0006
const GLUT_CURSOR_WAIT = &h0007
const GLUT_CURSOR_TEXT = &h0008
const GLUT_CURSOR_CROSSHAIR = &h0009
const GLUT_CURSOR_UP_DOWN = &h000A
const GLUT_CURSOR_LEFT_RIGHT = &h000B
const GLUT_CURSOR_TOP_SIDE = &h000C
const GLUT_CURSOR_BOTTOM_SIDE = &h000D
const GLUT_CURSOR_LEFT_SIDE = &h000E
const GLUT_CURSOR_RIGHT_SIDE = &h000F
const GLUT_CURSOR_TOP_LEFT_CORNER = &h0010
const GLUT_CURSOR_TOP_RIGHT_CORNER = &h0011
const GLUT_CURSOR_BOTTOM_RIGHT_CORNER = &h0012
const GLUT_CURSOR_BOTTOM_LEFT_CORNER = &h0013
const GLUT_CURSOR_INHERIT = &h0064
const GLUT_CURSOR_NONE = &h0065
const GLUT_CURSOR_FULL_CROSSHAIR = &h0066
const GLUT_RED = &h0000
const GLUT_GREEN = &h0001
const GLUT_BLUE = &h0002
const GLUT_KEY_REPEAT_OFF = &h0000
const GLUT_KEY_REPEAT_ON = &h0001
const GLUT_KEY_REPEAT_DEFAULT = &h0002
const GLUT_JOYSTICK_BUTTON_A = &h0001
const GLUT_JOYSTICK_BUTTON_B = &h0002
const GLUT_JOYSTICK_BUTTON_C = &h0004
const GLUT_JOYSTICK_BUTTON_D = &h0008
const GLUT_GAME_MODE_ACTIVE = &h0000
const GLUT_GAME_MODE_POSSIBLE = &h0001
const GLUT_GAME_MODE_WIDTH = &h0002
const GLUT_GAME_MODE_HEIGHT = &h0003
const GLUT_GAME_MODE_PIXEL_DEPTH = &h0004
const GLUT_GAME_MODE_REFRESH_RATE = &h0005
const GLUT_GAME_MODE_DISPLAY_CHANGED = &h0006

declare sub glutInit(byval pargc as long ptr, byval argv as zstring ptr ptr)
declare sub glutInitWindowPosition(byval x as long, byval y as long)
declare sub glutInitWindowSize(byval width as long, byval height as long)
declare sub glutInitDisplayMode(byval displayMode as ulong)
declare sub glutInitDisplayString(byval displayMode as const zstring ptr)
declare sub glutMainLoop()
declare function glutCreateWindow(byval title as const zstring ptr) as long
declare function glutCreateSubWindow(byval window as long, byval x as long, byval y as long, byval width as long, byval height as long) as long
declare sub glutDestroyWindow(byval window as long)
declare sub glutSetWindow(byval window as long)
declare function glutGetWindow() as long
declare sub glutSetWindowTitle(byval title as const zstring ptr)
declare sub glutSetIconTitle(byval title as const zstring ptr)
declare sub glutReshapeWindow(byval width as long, byval height as long)
declare sub glutPositionWindow(byval x as long, byval y as long)
declare sub glutShowWindow()
declare sub glutHideWindow()
declare sub glutIconifyWindow()
declare sub glutPushWindow()
declare sub glutPopWindow()
declare sub glutFullScreen()
declare sub glutPostWindowRedisplay(byval window as long)
declare sub glutPostRedisplay()
declare sub glutSwapBuffers()
declare sub glutWarpPointer(byval x as long, byval y as long)
declare sub glutSetCursor(byval cursor as long)
declare sub glutEstablishOverlay()
declare sub glutRemoveOverlay()
declare sub glutUseLayer(byval layer as GLenum)
declare sub glutPostOverlayRedisplay()
declare sub glutPostWindowOverlayRedisplay(byval window as long)
declare sub glutShowOverlay()
declare sub glutHideOverlay()
declare function glutCreateMenu(byval callback as sub cdecl(byval menu as long)) as long
declare sub glutDestroyMenu(byval menu as long)
declare function glutGetMenu() as long
declare sub glutSetMenu(byval menu as long)
declare sub glutAddMenuEntry(byval label as const zstring ptr, byval value as long)
declare sub glutAddSubMenu(byval label as const zstring ptr, byval subMenu as long)
declare sub glutChangeToMenuEntry(byval item as long, byval label as const zstring ptr, byval value as long)
declare sub glutChangeToSubMenu(byval item as long, byval label as const zstring ptr, byval value as long)
declare sub glutRemoveMenuItem(byval item as long)
declare sub glutAttachMenu(byval button as long)
declare sub glutDetachMenu(byval button as long)
declare sub glutTimerFunc(byval time as ulong, byval callback as sub cdecl(byval as long), byval value as long)
declare sub glutIdleFunc(byval callback as sub cdecl())
declare sub glutKeyboardFunc(byval callback as sub cdecl(byval as ubyte, byval as long, byval as long))
declare sub glutSpecialFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutReshapeFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutVisibilityFunc(byval callback as sub cdecl(byval as long))
declare sub glutDisplayFunc(byval callback as sub cdecl())
declare sub glutMouseFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long, byval as long))
declare sub glutMotionFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutPassiveMotionFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutEntryFunc(byval callback as sub cdecl(byval as long))
declare sub glutKeyboardUpFunc(byval callback as sub cdecl(byval as ubyte, byval as long, byval as long))
declare sub glutSpecialUpFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutJoystickFunc(byval callback as sub cdecl(byval as ulong, byval as long, byval as long, byval as long), byval pollInterval as long)
declare sub glutMenuStateFunc(byval callback as sub cdecl(byval as long))
declare sub glutMenuStatusFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutOverlayDisplayFunc(byval callback as sub cdecl())
declare sub glutWindowStatusFunc(byval callback as sub cdecl(byval as long))
declare sub glutSpaceballMotionFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutSpaceballRotateFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutSpaceballButtonFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutButtonBoxFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutDialsFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutTabletMotionFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutTabletButtonFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long, byval as long))
declare function glutGet(byval query as GLenum) as long
declare function glutDeviceGet(byval query as GLenum) as long
declare function glutGetModifiers() as long
declare function glutLayerGet(byval query as GLenum) as long
declare sub glutBitmapCharacter(byval font as any ptr, byval character as long)
declare function glutBitmapWidth(byval font as any ptr, byval character as long) as long
declare sub glutStrokeCharacter(byval font as any ptr, byval character as long)
declare function glutStrokeWidth(byval font as any ptr, byval character as long) as long
declare function glutStrokeWidthf(byval font as any ptr, byval character as long) as GLfloat
declare function glutBitmapLength(byval font as any ptr, byval string as const ubyte ptr) as long
declare function glutStrokeLength(byval font as any ptr, byval string as const ubyte ptr) as long
declare function glutStrokeLengthf(byval font as any ptr, byval string as const ubyte ptr) as GLfloat
declare sub glutWireCube(byval size as double)
declare sub glutSolidCube(byval size as double)
declare sub glutWireSphere(byval radius as double, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidSphere(byval radius as double, byval slices as GLint, byval stacks as GLint)
declare sub glutWireCone(byval base as double, byval height as double, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidCone(byval base as double, byval height as double, byval slices as GLint, byval stacks as GLint)
declare sub glutWireTorus(byval innerRadius as double, byval outerRadius as double, byval sides as GLint, byval rings as GLint)
declare sub glutSolidTorus(byval innerRadius as double, byval outerRadius as double, byval sides as GLint, byval rings as GLint)
declare sub glutWireDodecahedron()
declare sub glutSolidDodecahedron()
declare sub glutWireOctahedron()
declare sub glutSolidOctahedron()
declare sub glutWireTetrahedron()
declare sub glutSolidTetrahedron()
declare sub glutWireIcosahedron()
declare sub glutSolidIcosahedron()
declare sub glutWireTeapot(byval size as double)
declare sub glutSolidTeapot(byval size as double)
declare sub glutGameModeString(byval string as const zstring ptr)
declare function glutEnterGameMode() as long
declare sub glutLeaveGameMode()
declare function glutGameModeGet(byval query as GLenum) as long
declare function glutVideoResizeGet(byval query as GLenum) as long
declare sub glutSetupVideoResizing()
declare sub glutStopVideoResizing()
declare sub glutVideoResize(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub glutVideoPan(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub glutSetColor(byval color as long, byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare function glutGetColor(byval color as long, byval component as long) as GLfloat
declare sub glutCopyColormap(byval window as long)
declare sub glutIgnoreKeyRepeat(byval ignore as long)
declare sub glutSetKeyRepeat(byval repeatMode as long)
declare sub glutForceJoystickFunc()
declare function glutExtensionSupported(byval extension as const zstring ptr) as long
declare sub glutReportErrors()

end extern
