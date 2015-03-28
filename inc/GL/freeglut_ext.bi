#pragma once

#include once "crt/stdarg.bi"

#if defined(__FB_WIN32__) and (not defined(FREEGLUT_STATIC))
	extern "Windows"
#else
	extern "C"
#endif

#define __FREEGLUT_EXT_H__
const GLUT_KEY_NUM_LOCK = &h006D
const GLUT_KEY_BEGIN = &h006E
const GLUT_KEY_DELETE = &h006F
const GLUT_KEY_SHIFT_L = &h0070
const GLUT_KEY_SHIFT_R = &h0071
const GLUT_KEY_CTRL_L = &h0072
const GLUT_KEY_CTRL_R = &h0073
const GLUT_KEY_ALT_L = &h0074
const GLUT_KEY_ALT_R = &h0075
const GLUT_ACTION_EXIT = 0
const GLUT_ACTION_GLUTMAINLOOP_RETURNS = 1
const GLUT_ACTION_CONTINUE_EXECUTION = 2
const GLUT_CREATE_NEW_CONTEXT = 0
const GLUT_USE_CURRENT_CONTEXT = 1
const GLUT_FORCE_INDIRECT_CONTEXT = 0
const GLUT_ALLOW_DIRECT_CONTEXT = 1
const GLUT_TRY_DIRECT_CONTEXT = 2
const GLUT_FORCE_DIRECT_CONTEXT = 3
const GLUT_INIT_STATE = &h007C
const GLUT_ACTION_ON_WINDOW_CLOSE = &h01F9
const GLUT_WINDOW_BORDER_WIDTH = &h01FA
const GLUT_WINDOW_BORDER_HEIGHT = &h01FB
const GLUT_WINDOW_HEADER_HEIGHT = &h01FB
const GLUT_VERSION = &h01FC
const GLUT_RENDERING_CONTEXT = &h01FD
const GLUT_DIRECT_RENDERING = &h01FE
const GLUT_FULL_SCREEN = &h01FF
const GLUT_SKIP_STALE_MOTION_EVENTS = &h0204
const GLUT_GEOMETRY_VISUALIZE_NORMALS = &h0205
const GLUT_STROKE_FONT_DRAW_JOIN_DOTS = &h0206
const GLUT_AUX = &h1000
const GLUT_AUX1 = &h1000
const GLUT_AUX2 = &h2000
const GLUT_AUX3 = &h4000
const GLUT_AUX4 = &h8000
const GLUT_INIT_MAJOR_VERSION = &h0200
const GLUT_INIT_MINOR_VERSION = &h0201
const GLUT_INIT_FLAGS = &h0202
const GLUT_INIT_PROFILE = &h0203
const GLUT_DEBUG = &h0001
const GLUT_FORWARD_COMPATIBLE = &h0002
const GLUT_CORE_PROFILE = &h0001
const GLUT_COMPATIBILITY_PROFILE = &h0002

declare sub glutMainLoopEvent()
declare sub glutLeaveMainLoop()
declare sub glutExit()
declare sub glutFullScreenToggle()
declare sub glutLeaveFullScreen()
declare sub glutSetMenuFont(byval menuID as long, byval font as any ptr)
declare sub glutMouseWheelFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long, byval as long))
declare sub glutPositionFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutCloseFunc(byval callback as sub cdecl())
declare sub glutWMCloseFunc(byval callback as sub cdecl())
declare sub glutMenuDestroyFunc(byval callback as sub cdecl())
declare sub glutSetOption(byval option_flag as GLenum, byval value as long)
declare function glutGetModeValues(byval mode as GLenum, byval size as long ptr) as long ptr
declare function glutGetWindowData() as any ptr
declare sub glutSetWindowData(byval data as any ptr)
declare function glutGetMenuData() as any ptr
declare sub glutSetMenuData(byval data as any ptr)
declare function glutBitmapHeight(byval font as any ptr) as long
declare function glutStrokeHeight(byval font as any ptr) as GLfloat
declare sub glutBitmapString(byval font as any ptr, byval string as const ubyte ptr)
declare sub glutStrokeString(byval font as any ptr, byval string as const ubyte ptr)
declare sub glutWireRhombicDodecahedron()
declare sub glutSolidRhombicDodecahedron()
declare sub glutWireSierpinskiSponge(byval num_levels as long, byval offset as double ptr, byval scale as double)
declare sub glutSolidSierpinskiSponge(byval num_levels as long, byval offset as double ptr, byval scale as double)
declare sub glutWireCylinder(byval radius as double, byval height as double, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidCylinder(byval radius as double, byval height as double, byval slices as GLint, byval stacks as GLint)
declare sub glutWireTeacup(byval size as double)
declare sub glutSolidTeacup(byval size as double)
declare sub glutWireTeaspoon(byval size as double)
declare sub glutSolidTeaspoon(byval size as double)
type GLUTproc as sub cdecl()
declare function glutGetProcAddress(byval procName as const zstring ptr) as GLUTproc
const GLUT_HAS_MULTI = 1
declare sub glutMultiEntryFunc(byval callback as sub cdecl(byval as long, byval as long))
declare sub glutMultiButtonFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long, byval as long, byval as long))
declare sub glutMultiMotionFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare sub glutMultiPassiveFunc(byval callback as sub cdecl(byval as long, byval as long, byval as long))
declare function glutJoystickGetNumAxes cdecl(byval ident as long) as long
declare function glutJoystickGetNumButtons cdecl(byval ident as long) as long
declare function glutJoystickNotWorking cdecl(byval ident as long) as long
declare function glutJoystickGetDeadBand cdecl(byval ident as long, byval axis as long) as single
declare sub glutJoystickSetDeadBand cdecl(byval ident as long, byval axis as long, byval db as single)
declare function glutJoystickGetSaturation cdecl(byval ident as long, byval axis as long) as single
declare sub glutJoystickSetSaturation cdecl(byval ident as long, byval axis as long, byval st as single)
declare sub glutJoystickSetMinRange cdecl(byval ident as long, byval axes as single ptr)
declare sub glutJoystickSetMaxRange cdecl(byval ident as long, byval axes as single ptr)
declare sub glutJoystickSetCenter cdecl(byval ident as long, byval axes as single ptr)
declare sub glutJoystickGetMinRange cdecl(byval ident as long, byval axes as single ptr)
declare sub glutJoystickGetMaxRange cdecl(byval ident as long, byval axes as single ptr)
declare sub glutJoystickGetCenter cdecl(byval ident as long, byval axes as single ptr)
declare sub glutInitContextVersion(byval majorVersion as long, byval minorVersion as long)
declare sub glutInitContextFlags(byval flags as long)
declare sub glutInitContextProfile(byval profile as long)
declare sub glutInitErrorFunc(byval callback as sub cdecl(byval fmt as const zstring ptr, byval ap as va_list))
declare sub glutInitWarningFunc(byval callback as sub cdecl(byval fmt as const zstring ptr, byval ap as va_list))
declare sub glutSetVertexAttribCoord3(byval attrib as GLint)
declare sub glutSetVertexAttribNormal(byval attrib as GLint)
declare sub glutSetVertexAttribTexCoord2(byval attrib as GLint)
declare sub glutInitContextFunc(byval callback as sub cdecl())
declare sub glutAppStatusFunc(byval callback as sub cdecl(byval as long))

const GLUT_APPSTATUS_PAUSE = &h0001
const GLUT_APPSTATUS_RESUME = &h0002
const GLUT_CAPTIONLESS = &h0400
const GLUT_BORDERLESS = &h0800
const GLUT_SRGB = &h1000

end extern
