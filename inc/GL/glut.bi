'' FreeBASIC binding for glut-3.7
''
'' based on the C header files:
''   /* Copyright (c) Mark J. Kilgard, 1994, 1995, 1996, 1998. */
''
''   /* This program is freely distributable without licensing fees  and is
''      provided without guarantee or warrantee expressed or  implied. This
''      program is -not- in the public domain. */
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "glut"
#elseif defined(__FB_WIN32__)
	#inclib "glut32"
#else
	#inclib "GLUT"
	#inclib "alleg"
#endif

#include once "GL/gl.bi"
#include once "GL/glu.bi"

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define __glut_h__

#ifdef __FB_WIN32__
	#inclib "winmm"
	#inclib "opengl32"
	#inclib "glu32"
	#inclib "glut32"
#endif

const GLUT_API_VERSION = 3
const GLUT_XLIB_IMPLEMENTATION = 13
const GLUT_RGB = 0
const GLUT_RGBA = GLUT_RGB
const GLUT_INDEX = 1
const GLUT_SINGLE = 0
const GLUT_DOUBLE = 2
const GLUT_ACCUM = 4
const GLUT_ALPHA = 8
const GLUT_DEPTH = 16
const GLUT_STENCIL = 32
const GLUT_MULTISAMPLE = 128
const GLUT_STEREO = 256
const GLUT_LUMINANCE = 512
const GLUT_LEFT_BUTTON = 0
const GLUT_MIDDLE_BUTTON = 1
const GLUT_RIGHT_BUTTON = 2
const GLUT_DOWN = 0
const GLUT_UP = 1
const GLUT_KEY_F1 = 1
const GLUT_KEY_F2 = 2
const GLUT_KEY_F3 = 3
const GLUT_KEY_F4 = 4
const GLUT_KEY_F5 = 5
const GLUT_KEY_F6 = 6
const GLUT_KEY_F7 = 7
const GLUT_KEY_F8 = 8
const GLUT_KEY_F9 = 9
const GLUT_KEY_F10 = 10
const GLUT_KEY_F11 = 11
const GLUT_KEY_F12 = 12
const GLUT_KEY_LEFT = 100
const GLUT_KEY_UP = 101
const GLUT_KEY_RIGHT = 102
const GLUT_KEY_DOWN = 103
const GLUT_KEY_PAGE_UP = 104
const GLUT_KEY_PAGE_DOWN = 105
const GLUT_KEY_HOME = 106
const GLUT_KEY_END = 107
const GLUT_KEY_INSERT = 108
const GLUT_LEFT = 0
const GLUT_ENTERED = 1
const GLUT_MENU_NOT_IN_USE = 0
const GLUT_MENU_IN_USE = 1
const GLUT_NOT_VISIBLE = 0
const GLUT_VISIBLE = 1
const GLUT_HIDDEN = 0
const GLUT_FULLY_RETAINED = 1
const GLUT_PARTIALLY_RETAINED = 2
const GLUT_FULLY_COVERED = 3
const GLUT_RED = 0
const GLUT_GREEN = 1
const GLUT_BLUE = 2
const GLUT_NORMAL = 0
const GLUT_OVERLAY = 1

#ifdef __FB_WIN32__
	const GLUT_STROKE_ROMAN = cptr(any ptr, 0)
	const GLUT_STROKE_MONO_ROMAN = cptr(any ptr, 1)
	const GLUT_BITMAP_9_BY_15 = cptr(any ptr, 2)
	const GLUT_BITMAP_8_BY_13 = cptr(any ptr, 3)
	const GLUT_BITMAP_TIMES_ROMAN_10 = cptr(any ptr, 4)
	const GLUT_BITMAP_TIMES_ROMAN_24 = cptr(any ptr, 5)
	const GLUT_BITMAP_HELVETICA_10 = cptr(any ptr, 6)
	const GLUT_BITMAP_HELVETICA_12 = cptr(any ptr, 7)
	const GLUT_BITMAP_HELVETICA_18 = cptr(any ptr, 8)
#else
	extern glutStrokeRoman as any ptr
	extern glutStrokeMonoRoman as any ptr
	#define GLUT_STROKE_ROMAN (@glutStrokeRoman)
	#define GLUT_STROKE_MONO_ROMAN (@glutStrokeMonoRoman)
	extern glutBitmap9By15 as any ptr
	extern glutBitmap8By13 as any ptr
	extern glutBitmapTimesRoman10 as any ptr
	extern glutBitmapTimesRoman24 as any ptr
	extern glutBitmapHelvetica10 as any ptr
	extern glutBitmapHelvetica12 as any ptr
	extern glutBitmapHelvetica18 as any ptr

	#define GLUT_BITMAP_9_BY_15 (@glutBitmap9By15)
	#define GLUT_BITMAP_8_BY_13 (@glutBitmap8By13)
	#define GLUT_BITMAP_TIMES_ROMAN_10 (@glutBitmapTimesRoman10)
	#define GLUT_BITMAP_TIMES_ROMAN_24 (@glutBitmapTimesRoman24)
	#define GLUT_BITMAP_HELVETICA_10 (@glutBitmapHelvetica10)
	#define GLUT_BITMAP_HELVETICA_12 (@glutBitmapHelvetica12)
	#define GLUT_BITMAP_HELVETICA_18 (@glutBitmapHelvetica18)
#endif

const GLUT_WINDOW_X = 100
const GLUT_WINDOW_Y = 101
const GLUT_WINDOW_WIDTH = 102
const GLUT_WINDOW_HEIGHT = 103
const GLUT_WINDOW_BUFFER_SIZE = 104
const GLUT_WINDOW_STENCIL_SIZE = 105
const GLUT_WINDOW_DEPTH_SIZE = 106
const GLUT_WINDOW_RED_SIZE = 107
const GLUT_WINDOW_GREEN_SIZE = 108
const GLUT_WINDOW_BLUE_SIZE = 109
const GLUT_WINDOW_ALPHA_SIZE = 110
const GLUT_WINDOW_ACCUM_RED_SIZE = 111
const GLUT_WINDOW_ACCUM_GREEN_SIZE = 112
const GLUT_WINDOW_ACCUM_BLUE_SIZE = 113
const GLUT_WINDOW_ACCUM_ALPHA_SIZE = 114
const GLUT_WINDOW_DOUBLEBUFFER = 115
const GLUT_WINDOW_RGBA = 116
const GLUT_WINDOW_PARENT = 117
const GLUT_WINDOW_NUM_CHILDREN = 118
const GLUT_WINDOW_COLORMAP_SIZE = 119
const GLUT_WINDOW_NUM_SAMPLES = 120
const GLUT_WINDOW_STEREO = 121
const GLUT_WINDOW_CURSOR = 122
const GLUT_SCREEN_WIDTH = 200
const GLUT_SCREEN_HEIGHT = 201
const GLUT_SCREEN_WIDTH_MM = 202
const GLUT_SCREEN_HEIGHT_MM = 203
const GLUT_MENU_NUM_ITEMS = 300
const GLUT_DISPLAY_MODE_POSSIBLE = 400
const GLUT_INIT_WINDOW_X = 500
const GLUT_INIT_WINDOW_Y = 501
const GLUT_INIT_WINDOW_WIDTH = 502
const GLUT_INIT_WINDOW_HEIGHT = 503
const GLUT_INIT_DISPLAY_MODE = 504
const GLUT_ELAPSED_TIME = 700
const GLUT_WINDOW_FORMAT_ID = 123
const GLUT_HAS_KEYBOARD = 600
const GLUT_HAS_MOUSE = 601
const GLUT_HAS_SPACEBALL = 602
const GLUT_HAS_DIAL_AND_BUTTON_BOX = 603
const GLUT_HAS_TABLET = 604
const GLUT_NUM_MOUSE_BUTTONS = 605
const GLUT_NUM_SPACEBALL_BUTTONS = 606
const GLUT_NUM_BUTTON_BOX_BUTTONS = 607
const GLUT_NUM_DIALS = 608
const GLUT_NUM_TABLET_BUTTONS = 609
const GLUT_DEVICE_IGNORE_KEY_REPEAT = 610
const GLUT_DEVICE_KEY_REPEAT = 611
const GLUT_HAS_JOYSTICK = 612
const GLUT_OWNS_JOYSTICK = 613
const GLUT_JOYSTICK_BUTTONS = 614
const GLUT_JOYSTICK_AXES = 615
const GLUT_JOYSTICK_POLL_RATE = 616
const GLUT_OVERLAY_POSSIBLE = 800
const GLUT_LAYER_IN_USE = 801
const GLUT_HAS_OVERLAY = 802
const GLUT_TRANSPARENT_INDEX = 803
const GLUT_NORMAL_DAMAGED = 804
const GLUT_OVERLAY_DAMAGED = 805
const GLUT_VIDEO_RESIZE_POSSIBLE = 900
const GLUT_VIDEO_RESIZE_IN_USE = 901
const GLUT_VIDEO_RESIZE_X_DELTA = 902
const GLUT_VIDEO_RESIZE_Y_DELTA = 903
const GLUT_VIDEO_RESIZE_WIDTH_DELTA = 904
const GLUT_VIDEO_RESIZE_HEIGHT_DELTA = 905
const GLUT_VIDEO_RESIZE_X = 906
const GLUT_VIDEO_RESIZE_Y = 907
const GLUT_VIDEO_RESIZE_WIDTH = 908
const GLUT_VIDEO_RESIZE_HEIGHT = 909
const GLUT_NORMAL = 0
const GLUT_OVERLAY = 1
const GLUT_ACTIVE_SHIFT = 1
const GLUT_ACTIVE_CTRL = 2
const GLUT_ACTIVE_ALT = 4
const GLUT_CURSOR_RIGHT_ARROW = 0
const GLUT_CURSOR_LEFT_ARROW = 1
const GLUT_CURSOR_INFO = 2
const GLUT_CURSOR_DESTROY = 3
const GLUT_CURSOR_HELP = 4
const GLUT_CURSOR_CYCLE = 5
const GLUT_CURSOR_SPRAY = 6
const GLUT_CURSOR_WAIT = 7
const GLUT_CURSOR_TEXT = 8
const GLUT_CURSOR_CROSSHAIR = 9
const GLUT_CURSOR_UP_DOWN = 10
const GLUT_CURSOR_LEFT_RIGHT = 11
const GLUT_CURSOR_TOP_SIDE = 12
const GLUT_CURSOR_BOTTOM_SIDE = 13
const GLUT_CURSOR_LEFT_SIDE = 14
const GLUT_CURSOR_RIGHT_SIDE = 15
const GLUT_CURSOR_TOP_LEFT_CORNER = 16
const GLUT_CURSOR_TOP_RIGHT_CORNER = 17
const GLUT_CURSOR_BOTTOM_RIGHT_CORNER = 18
const GLUT_CURSOR_BOTTOM_LEFT_CORNER = 19
const GLUT_CURSOR_INHERIT = 100
const GLUT_CURSOR_NONE = 101
const GLUT_CURSOR_FULL_CROSSHAIR = 102

declare sub glutInit(byref argcp as long, byref argv as zstring ptr)
declare sub glutInitDisplayMode(byval mode as ulong)
declare sub glutInitDisplayString(byval string as const zstring ptr)
declare sub glutInitWindowPosition(byval x as long, byval y as long)
declare sub glutInitWindowSize(byval width as long, byval height as long)
declare sub glutMainLoop()
declare function glutCreateWindow(byval title as const zstring ptr) as long
declare function glutCreateSubWindow(byval win as long, byval x as long, byval y as long, byval width as long, byval height as long) as long
declare sub glutDestroyWindow(byval win as long)
declare sub glutPostRedisplay()
declare sub glutPostWindowRedisplay(byval win as long)
declare sub glutSwapBuffers()
declare function glutGetWindow() as long
declare sub glutSetWindow(byval win as long)
declare sub glutSetWindowTitle(byval title as const zstring ptr)
declare sub glutSetIconTitle(byval title as const zstring ptr)
declare sub glutPositionWindow(byval x as long, byval y as long)
declare sub glutReshapeWindow(byval width as long, byval height as long)
declare sub glutPopWindow()
declare sub glutPushWindow()
declare sub glutIconifyWindow()
declare sub glutShowWindow()
declare sub glutHideWindow()
declare sub glutFullScreen()
declare sub glutSetCursor(byval cursor as long)
declare sub glutWarpPointer(byval x as long, byval y as long)
declare sub glutEstablishOverlay()
declare sub glutRemoveOverlay()
declare sub glutUseLayer(byval layer as GLenum)
declare sub glutPostOverlayRedisplay()
declare sub glutPostWindowOverlayRedisplay(byval win as long)
declare sub glutShowOverlay()
declare sub glutHideOverlay()
declare function glutCreateMenu(byval as sub cdecl(byval as long)) as long
declare sub glutDestroyMenu(byval menu as long)
declare function glutGetMenu() as long
declare sub glutSetMenu(byval menu as long)
declare sub glutAddMenuEntry(byval label as const zstring ptr, byval value as long)
declare sub glutAddSubMenu(byval label as const zstring ptr, byval submenu as long)
declare sub glutChangeToMenuEntry(byval item as long, byval label as const zstring ptr, byval value as long)
declare sub glutChangeToSubMenu(byval item as long, byval label as const zstring ptr, byval submenu as long)
declare sub glutRemoveMenuItem(byval item as long)
declare sub glutAttachMenu(byval button as long)
declare sub glutDetachMenu(byval button as long)
declare sub glutDisplayFunc(byval func as sub cdecl())
declare sub glutReshapeFunc(byval func as sub cdecl(byval width as long, byval height as long))
declare sub glutKeyboardFunc(byval func as sub cdecl(byval key as ubyte, byval x as long, byval y as long))
declare sub glutMouseFunc(byval func as sub cdecl(byval button as long, byval state as long, byval x as long, byval y as long))
declare sub glutMotionFunc(byval func as sub cdecl(byval x as long, byval y as long))
declare sub glutPassiveMotionFunc(byval func as sub cdecl(byval x as long, byval y as long))
declare sub glutEntryFunc(byval func as sub cdecl(byval state as long))
declare sub glutVisibilityFunc(byval func as sub cdecl(byval state as long))
declare sub glutIdleFunc(byval func as sub cdecl())
declare sub glutTimerFunc(byval millis as ulong, byval func as sub cdecl(byval value as long), byval value as long)
declare sub glutMenuStateFunc(byval func as sub cdecl(byval state as long))
declare sub glutSpecialFunc(byval func as sub cdecl(byval key as long, byval x as long, byval y as long))
declare sub glutSpaceballMotionFunc(byval func as sub cdecl(byval x as long, byval y as long, byval z as long))
declare sub glutSpaceballRotateFunc(byval func as sub cdecl(byval x as long, byval y as long, byval z as long))
declare sub glutSpaceballButtonFunc(byval func as sub cdecl(byval button as long, byval state as long))
declare sub glutButtonBoxFunc(byval func as sub cdecl(byval button as long, byval state as long))
declare sub glutDialsFunc(byval func as sub cdecl(byval dial as long, byval value as long))
declare sub glutTabletMotionFunc(byval func as sub cdecl(byval x as long, byval y as long))
declare sub glutTabletButtonFunc(byval func as sub cdecl(byval button as long, byval state as long, byval x as long, byval y as long))
declare sub glutMenuStatusFunc(byval func as sub cdecl(byval status as long, byval x as long, byval y as long))
declare sub glutOverlayDisplayFunc(byval func as sub cdecl())
declare sub glutWindowStatusFunc(byval func as sub cdecl(byval state as long))
declare sub glutKeyboardUpFunc(byval func as sub cdecl(byval key as ubyte, byval x as long, byval y as long))
declare sub glutSpecialUpFunc(byval func as sub cdecl(byval key as long, byval x as long, byval y as long))
declare sub glutJoystickFunc(byval func as sub cdecl(byval buttonMask as ulong, byval x as long, byval y as long, byval z as long), byval pollInterval as long)
declare sub glutSetColor(byval as long, byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare function glutGetColor(byval ndx as long, byval component as long) as GLfloat
declare sub glutCopyColormap(byval win as long)
declare function glutGet(byval type as GLenum) as long
declare function glutDeviceGet(byval type as GLenum) as long
declare function glutExtensionSupported(byval name as const zstring ptr) as long
declare function glutGetModifiers() as long
declare function glutLayerGet(byval type as GLenum) as long
declare sub glutBitmapCharacter(byval font as any ptr, byval character as long)
declare function glutBitmapWidth(byval font as any ptr, byval character as long) as long
declare sub glutStrokeCharacter(byval font as any ptr, byval character as long)
declare function glutStrokeWidth(byval font as any ptr, byval character as long) as long
declare function glutBitmapLength(byval font as any ptr, byval string as const ubyte ptr) as long
declare function glutStrokeLength(byval font as any ptr, byval string as const ubyte ptr) as long
declare sub glutWireSphere(byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidSphere(byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutWireCone(byval base as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidCone(byval base as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutWireCube(byval size as GLdouble)
declare sub glutSolidCube(byval size as GLdouble)
declare sub glutWireTorus(byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval sides as GLint, byval rings as GLint)
declare sub glutSolidTorus(byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval sides as GLint, byval rings as GLint)
declare sub glutWireDodecahedron()
declare sub glutSolidDodecahedron()
declare sub glutWireTeapot(byval size as GLdouble)
declare sub glutSolidTeapot(byval size as GLdouble)
declare sub glutWireOctahedron()
declare sub glutSolidOctahedron()
declare sub glutWireTetrahedron()
declare sub glutSolidTetrahedron()
declare sub glutWireIcosahedron()
declare sub glutSolidIcosahedron()
declare function glutVideoResizeGet(byval param as GLenum) as long
declare sub glutSetupVideoResizing()
declare sub glutStopVideoResizing()
declare sub glutVideoResize(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub glutVideoPan(byval x as long, byval y as long, byval width as long, byval height as long)
declare sub glutReportErrors()

const GLUT_KEY_REPEAT_OFF = 0
const GLUT_KEY_REPEAT_ON = 1
const GLUT_KEY_REPEAT_DEFAULT = 2
const GLUT_JOYSTICK_BUTTON_A = 1
const GLUT_JOYSTICK_BUTTON_B = 2
const GLUT_JOYSTICK_BUTTON_C = 4
const GLUT_JOYSTICK_BUTTON_D = 8

declare sub glutIgnoreKeyRepeat(byval ignore as long)
declare sub glutSetKeyRepeat(byval repeatMode as long)
declare sub glutForceJoystickFunc()

const GLUT_GAME_MODE_ACTIVE = 0
const GLUT_GAME_MODE_POSSIBLE = 1
const GLUT_GAME_MODE_WIDTH = 2
const GLUT_GAME_MODE_HEIGHT = 3
const GLUT_GAME_MODE_PIXEL_DEPTH = 4
const GLUT_GAME_MODE_REFRESH_RATE = 5
const GLUT_GAME_MODE_DISPLAY_CHANGED = 6

declare sub glutGameModeString(byval string as const zstring ptr)
declare function glutEnterGameMode() as long
declare sub glutLeaveGameMode()
declare function glutGameModeGet(byval mode as GLenum) as long

end extern
