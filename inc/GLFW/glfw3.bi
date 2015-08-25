'' FreeBASIC binding for glfw-3.1.1
''
'' based on the C header files:
''   **********************************************************************
''    GLFW 3.1 - www.glfw.org
''    A library for OpenGL, window and input
''   ------------------------------------------------------------------------
''    Copyright (c) 2002-2006 Marcus Geelnard
''    Copyright (c) 2006-2010 Camilla Berglund <elmindreda@elmindreda.org>
''
''    This software is provided 'as-is', without any express or implied
''    warranty. In no event will the authors be held liable for any damages
''    arising from the use of this software.
''
''    Permission is granted to anyone to use this software for any purpose,
''    including commercial applications, and to alter it and redistribute it
''    freely, subject to the following restrictions:
''
''    1. The origin of this software must not be misrepresented; you must not
''       claim that you wrote the original software. If you use this software
''       in a product, an acknowledgment in the product documentation would
''       be appreciated but is not required.
''
''    2. Altered source versions must be plainly marked as such, and must not
''       be misrepresented as being the original software.
''
''    3. This notice may not be removed or altered from any source
''       distribution.
''
''   ***********************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#inclib "glfw"
#elseif defined(__FB_WIN32__) and defined(GLFW_DLL)
	#inclib "glfw3dll"
#else
	#inclib "glfw3"
	#inclib "user32"
	#inclib "gdi32"
#endif

#include once "GL/gl.bi"

extern "C"

#define _glfw3_h_
const GLFW_VERSION_MAJOR = 3
const GLFW_VERSION_MINOR = 1
const GLFW_VERSION_REVISION = 1
const GLFW_RELEASE = 0
const GLFW_PRESS = 1
const GLFW_REPEAT = 2
const GLFW_KEY_UNKNOWN = -1
const GLFW_KEY_SPACE = 32
const GLFW_KEY_APOSTROPHE = 39
const GLFW_KEY_COMMA = 44
const GLFW_KEY_MINUS = 45
const GLFW_KEY_PERIOD = 46
const GLFW_KEY_SLASH = 47
const GLFW_KEY_0 = 48
const GLFW_KEY_1 = 49
const GLFW_KEY_2 = 50
const GLFW_KEY_3 = 51
const GLFW_KEY_4 = 52
const GLFW_KEY_5 = 53
const GLFW_KEY_6 = 54
const GLFW_KEY_7 = 55
const GLFW_KEY_8 = 56
const GLFW_KEY_9 = 57
const GLFW_KEY_SEMICOLON = 59
const GLFW_KEY_EQUAL = 61
const GLFW_KEY_A = 65
const GLFW_KEY_B = 66
const GLFW_KEY_C = 67
const GLFW_KEY_D = 68
const GLFW_KEY_E = 69
const GLFW_KEY_F = 70
const GLFW_KEY_G = 71
const GLFW_KEY_H = 72
const GLFW_KEY_I = 73
const GLFW_KEY_J = 74
const GLFW_KEY_K = 75
const GLFW_KEY_L = 76
const GLFW_KEY_M = 77
const GLFW_KEY_N = 78
const GLFW_KEY_O = 79
const GLFW_KEY_P = 80
const GLFW_KEY_Q = 81
const GLFW_KEY_R = 82
const GLFW_KEY_S = 83
const GLFW_KEY_T = 84
const GLFW_KEY_U = 85
const GLFW_KEY_V = 86
const GLFW_KEY_W = 87
const GLFW_KEY_X = 88
const GLFW_KEY_Y = 89
const GLFW_KEY_Z = 90
const GLFW_KEY_LEFT_BRACKET = 91
const GLFW_KEY_BACKSLASH = 92
const GLFW_KEY_RIGHT_BRACKET = 93
const GLFW_KEY_GRAVE_ACCENT = 96
const GLFW_KEY_WORLD_1 = 161
const GLFW_KEY_WORLD_2 = 162
const GLFW_KEY_ESCAPE = 256
const GLFW_KEY_ENTER = 257
const GLFW_KEY_TAB = 258
const GLFW_KEY_BACKSPACE = 259
const GLFW_KEY_INSERT = 260
const GLFW_KEY_DELETE = 261
const GLFW_KEY_RIGHT = 262
const GLFW_KEY_LEFT = 263
const GLFW_KEY_DOWN = 264
const GLFW_KEY_UP = 265
const GLFW_KEY_PAGE_UP = 266
const GLFW_KEY_PAGE_DOWN = 267
const GLFW_KEY_HOME = 268
const GLFW_KEY_END = 269
const GLFW_KEY_CAPS_LOCK = 280
const GLFW_KEY_SCROLL_LOCK = 281
const GLFW_KEY_NUM_LOCK = 282
const GLFW_KEY_PRINT_SCREEN = 283
const GLFW_KEY_PAUSE = 284
const GLFW_KEY_F1 = 290
const GLFW_KEY_F2 = 291
const GLFW_KEY_F3 = 292
const GLFW_KEY_F4 = 293
const GLFW_KEY_F5 = 294
const GLFW_KEY_F6 = 295
const GLFW_KEY_F7 = 296
const GLFW_KEY_F8 = 297
const GLFW_KEY_F9 = 298
const GLFW_KEY_F10 = 299
const GLFW_KEY_F11 = 300
const GLFW_KEY_F12 = 301
const GLFW_KEY_F13 = 302
const GLFW_KEY_F14 = 303
const GLFW_KEY_F15 = 304
const GLFW_KEY_F16 = 305
const GLFW_KEY_F17 = 306
const GLFW_KEY_F18 = 307
const GLFW_KEY_F19 = 308
const GLFW_KEY_F20 = 309
const GLFW_KEY_F21 = 310
const GLFW_KEY_F22 = 311
const GLFW_KEY_F23 = 312
const GLFW_KEY_F24 = 313
const GLFW_KEY_F25 = 314
const GLFW_KEY_KP_0 = 320
const GLFW_KEY_KP_1 = 321
const GLFW_KEY_KP_2 = 322
const GLFW_KEY_KP_3 = 323
const GLFW_KEY_KP_4 = 324
const GLFW_KEY_KP_5 = 325
const GLFW_KEY_KP_6 = 326
const GLFW_KEY_KP_7 = 327
const GLFW_KEY_KP_8 = 328
const GLFW_KEY_KP_9 = 329
const GLFW_KEY_KP_DECIMAL = 330
const GLFW_KEY_KP_DIVIDE = 331
const GLFW_KEY_KP_MULTIPLY = 332
const GLFW_KEY_KP_SUBTRACT = 333
const GLFW_KEY_KP_ADD = 334
const GLFW_KEY_KP_ENTER = 335
const GLFW_KEY_KP_EQUAL = 336
const GLFW_KEY_LEFT_SHIFT = 340
const GLFW_KEY_LEFT_CONTROL = 341
const GLFW_KEY_LEFT_ALT = 342
const GLFW_KEY_LEFT_SUPER = 343
const GLFW_KEY_RIGHT_SHIFT = 344
const GLFW_KEY_RIGHT_CONTROL = 345
const GLFW_KEY_RIGHT_ALT = 346
const GLFW_KEY_RIGHT_SUPER = 347
const GLFW_KEY_MENU = 348
const GLFW_KEY_LAST = GLFW_KEY_MENU
const GLFW_MOD_SHIFT = &h0001
const GLFW_MOD_CONTROL = &h0002
const GLFW_MOD_ALT = &h0004
const GLFW_MOD_SUPER = &h0008
const GLFW_MOUSE_BUTTON_1 = 0
const GLFW_MOUSE_BUTTON_2 = 1
const GLFW_MOUSE_BUTTON_3 = 2
const GLFW_MOUSE_BUTTON_4 = 3
const GLFW_MOUSE_BUTTON_5 = 4
const GLFW_MOUSE_BUTTON_6 = 5
const GLFW_MOUSE_BUTTON_7 = 6
const GLFW_MOUSE_BUTTON_8 = 7
const GLFW_MOUSE_BUTTON_LAST = GLFW_MOUSE_BUTTON_8
const GLFW_MOUSE_BUTTON_LEFT = GLFW_MOUSE_BUTTON_1
const GLFW_MOUSE_BUTTON_RIGHT = GLFW_MOUSE_BUTTON_2
const GLFW_MOUSE_BUTTON_MIDDLE = GLFW_MOUSE_BUTTON_3
const GLFW_JOYSTICK_1 = 0
const GLFW_JOYSTICK_2 = 1
const GLFW_JOYSTICK_3 = 2
const GLFW_JOYSTICK_4 = 3
const GLFW_JOYSTICK_5 = 4
const GLFW_JOYSTICK_6 = 5
const GLFW_JOYSTICK_7 = 6
const GLFW_JOYSTICK_8 = 7
const GLFW_JOYSTICK_9 = 8
const GLFW_JOYSTICK_10 = 9
const GLFW_JOYSTICK_11 = 10
const GLFW_JOYSTICK_12 = 11
const GLFW_JOYSTICK_13 = 12
const GLFW_JOYSTICK_14 = 13
const GLFW_JOYSTICK_15 = 14
const GLFW_JOYSTICK_16 = 15
const GLFW_JOYSTICK_LAST = GLFW_JOYSTICK_16
const GLFW_NOT_INITIALIZED = &h00010001
const GLFW_NO_CURRENT_CONTEXT = &h00010002
const GLFW_INVALID_ENUM = &h00010003
const GLFW_INVALID_VALUE = &h00010004
const GLFW_OUT_OF_MEMORY = &h00010005
const GLFW_API_UNAVAILABLE = &h00010006
const GLFW_VERSION_UNAVAILABLE = &h00010007
const GLFW_PLATFORM_ERROR = &h00010008
const GLFW_FORMAT_UNAVAILABLE = &h00010009
const GLFW_FOCUSED = &h00020001
const GLFW_ICONIFIED = &h00020002
const GLFW_RESIZABLE = &h00020003
const GLFW_VISIBLE = &h00020004
const GLFW_DECORATED = &h00020005
const GLFW_AUTO_ICONIFY = &h00020006
const GLFW_FLOATING = &h00020007
const GLFW_RED_BITS = &h00021001
const GLFW_GREEN_BITS = &h00021002
const GLFW_BLUE_BITS = &h00021003
const GLFW_ALPHA_BITS = &h00021004
const GLFW_DEPTH_BITS = &h00021005
const GLFW_STENCIL_BITS = &h00021006
const GLFW_ACCUM_RED_BITS = &h00021007
const GLFW_ACCUM_GREEN_BITS = &h00021008
const GLFW_ACCUM_BLUE_BITS = &h00021009
const GLFW_ACCUM_ALPHA_BITS = &h0002100A
const GLFW_AUX_BUFFERS = &h0002100B
const GLFW_STEREO = &h0002100C
const GLFW_SAMPLES = &h0002100D
const GLFW_SRGB_CAPABLE = &h0002100E
const GLFW_REFRESH_RATE = &h0002100F
const GLFW_DOUBLEBUFFER = &h00021010
const GLFW_CLIENT_API = &h00022001
const GLFW_CONTEXT_VERSION_MAJOR = &h00022002
const GLFW_CONTEXT_VERSION_MINOR = &h00022003
const GLFW_CONTEXT_REVISION = &h00022004
const GLFW_CONTEXT_ROBUSTNESS = &h00022005
const GLFW_OPENGL_FORWARD_COMPAT = &h00022006
const GLFW_OPENGL_DEBUG_CONTEXT = &h00022007
const GLFW_OPENGL_PROFILE = &h00022008
const GLFW_CONTEXT_RELEASE_BEHAVIOR = &h00022009
const GLFW_OPENGL_API = &h00030001
const GLFW_OPENGL_ES_API = &h00030002
const GLFW_NO_ROBUSTNESS = 0
const GLFW_NO_RESET_NOTIFICATION = &h00031001
const GLFW_LOSE_CONTEXT_ON_RESET = &h00031002
const GLFW_OPENGL_ANY_PROFILE = 0
const GLFW_OPENGL_CORE_PROFILE = &h00032001
const GLFW_OPENGL_COMPAT_PROFILE = &h00032002
const GLFW_CURSOR = &h00033001
const GLFW_STICKY_KEYS = &h00033002
const GLFW_STICKY_MOUSE_BUTTONS = &h00033003
const GLFW_CURSOR_NORMAL = &h00034001
const GLFW_CURSOR_HIDDEN = &h00034002
const GLFW_CURSOR_DISABLED = &h00034003
const GLFW_ANY_RELEASE_BEHAVIOR = 0
const GLFW_RELEASE_BEHAVIOR_FLUSH = &h00035001
const GLFW_RELEASE_BEHAVIOR_NONE = &h00035002
const GLFW_ARROW_CURSOR = &h00036001
const GLFW_IBEAM_CURSOR = &h00036002
const GLFW_CROSSHAIR_CURSOR = &h00036003
const GLFW_HAND_CURSOR = &h00036004
const GLFW_HRESIZE_CURSOR = &h00036005
const GLFW_VRESIZE_CURSOR = &h00036006
const GLFW_CONNECTED = &h00040001
const GLFW_DISCONNECTED = &h00040002
const GLFW_DONT_CARE = -1

type GLFWglproc as sub()
type GLFWerrorfun as sub(byval as long, byval as const zstring ptr)
type GLFWwindow as GLFWwindow_
type GLFWwindowposfun as sub(byval as GLFWwindow ptr, byval as long, byval as long)
type GLFWwindowsizefun as sub(byval as GLFWwindow ptr, byval as long, byval as long)
type GLFWwindowclosefun as sub(byval as GLFWwindow ptr)
type GLFWwindowrefreshfun as sub(byval as GLFWwindow ptr)
type GLFWwindowfocusfun as sub(byval as GLFWwindow ptr, byval as long)
type GLFWwindowiconifyfun as sub(byval as GLFWwindow ptr, byval as long)
type GLFWframebuffersizefun as sub(byval as GLFWwindow ptr, byval as long, byval as long)
type GLFWmousebuttonfun as sub(byval as GLFWwindow ptr, byval as long, byval as long, byval as long)
type GLFWcursorposfun as sub(byval as GLFWwindow ptr, byval as double, byval as double)
type GLFWcursorenterfun as sub(byval as GLFWwindow ptr, byval as long)
type GLFWscrollfun as sub(byval as GLFWwindow ptr, byval as double, byval as double)
type GLFWkeyfun as sub(byval as GLFWwindow ptr, byval as long, byval as long, byval as long, byval as long)
type GLFWcharfun as sub(byval as GLFWwindow ptr, byval as ulong)
type GLFWcharmodsfun as sub(byval as GLFWwindow ptr, byval as ulong, byval as long)
type GLFWdropfun as sub(byval as GLFWwindow ptr, byval as long, byval as const zstring ptr ptr)
type GLFWmonitor as GLFWmonitor_
type GLFWmonitorfun as sub(byval as GLFWmonitor ptr, byval as long)

type GLFWvidmode
	width as long
	height as long
	redBits as long
	greenBits as long
	blueBits as long
	refreshRate as long
end type

type GLFWgammaramp
	red as ushort ptr
	green as ushort ptr
	blue as ushort ptr
	size as ulong
end type

type GLFWimage
	width as long
	height as long
	pixels as ubyte ptr
end type

declare function glfwInit() as long
declare sub glfwTerminate()
declare sub glfwGetVersion(byval major as long ptr, byval minor as long ptr, byval rev as long ptr)
declare function glfwGetVersionString() as const zstring ptr
declare function glfwSetErrorCallback(byval cbfun as GLFWerrorfun) as GLFWerrorfun
declare function glfwGetMonitors(byval count as long ptr) as GLFWmonitor ptr ptr
declare function glfwGetPrimaryMonitor() as GLFWmonitor ptr
declare sub glfwGetMonitorPos(byval monitor as GLFWmonitor ptr, byval xpos as long ptr, byval ypos as long ptr)
declare sub glfwGetMonitorPhysicalSize(byval monitor as GLFWmonitor ptr, byval widthMM as long ptr, byval heightMM as long ptr)
declare function glfwGetMonitorName(byval monitor as GLFWmonitor ptr) as const zstring ptr
declare function glfwSetMonitorCallback(byval cbfun as GLFWmonitorfun) as GLFWmonitorfun
declare function glfwGetVideoModes(byval monitor as GLFWmonitor ptr, byval count as long ptr) as const GLFWvidmode ptr
declare function glfwGetVideoMode(byval monitor as GLFWmonitor ptr) as const GLFWvidmode ptr
declare sub glfwSetGamma(byval monitor as GLFWmonitor ptr, byval gamma as single)
declare function glfwGetGammaRamp(byval monitor as GLFWmonitor ptr) as const GLFWgammaramp ptr
declare sub glfwSetGammaRamp(byval monitor as GLFWmonitor ptr, byval ramp as const GLFWgammaramp ptr)
declare sub glfwDefaultWindowHints()
declare sub glfwWindowHint(byval target as long, byval hint as long)
declare function glfwCreateWindow(byval width as long, byval height as long, byval title as const zstring ptr, byval monitor as GLFWmonitor ptr, byval share as GLFWwindow ptr) as GLFWwindow ptr
declare sub glfwDestroyWindow(byval window as GLFWwindow ptr)
declare function glfwWindowShouldClose(byval window as GLFWwindow ptr) as long
declare sub glfwSetWindowShouldClose(byval window as GLFWwindow ptr, byval value as long)
declare sub glfwSetWindowTitle(byval window as GLFWwindow ptr, byval title as const zstring ptr)
declare sub glfwGetWindowPos(byval window as GLFWwindow ptr, byval xpos as long ptr, byval ypos as long ptr)
declare sub glfwSetWindowPos(byval window as GLFWwindow ptr, byval xpos as long, byval ypos as long)
declare sub glfwGetWindowSize(byval window as GLFWwindow ptr, byval width as long ptr, byval height as long ptr)
declare sub glfwSetWindowSize(byval window as GLFWwindow ptr, byval width as long, byval height as long)
declare sub glfwGetFramebufferSize(byval window as GLFWwindow ptr, byval width as long ptr, byval height as long ptr)
declare sub glfwGetWindowFrameSize(byval window as GLFWwindow ptr, byval left as long ptr, byval top as long ptr, byval right as long ptr, byval bottom as long ptr)
declare sub glfwIconifyWindow(byval window as GLFWwindow ptr)
declare sub glfwRestoreWindow(byval window as GLFWwindow ptr)
declare sub glfwShowWindow(byval window as GLFWwindow ptr)
declare sub glfwHideWindow(byval window as GLFWwindow ptr)
declare function glfwGetWindowMonitor(byval window as GLFWwindow ptr) as GLFWmonitor ptr
declare function glfwGetWindowAttrib(byval window as GLFWwindow ptr, byval attrib as long) as long
declare sub glfwSetWindowUserPointer(byval window as GLFWwindow ptr, byval pointer as any ptr)
declare function glfwGetWindowUserPointer(byval window as GLFWwindow ptr) as any ptr
declare function glfwSetWindowPosCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowposfun) as GLFWwindowposfun
declare function glfwSetWindowSizeCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowsizefun) as GLFWwindowsizefun
declare function glfwSetWindowCloseCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowclosefun) as GLFWwindowclosefun
declare function glfwSetWindowRefreshCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowrefreshfun) as GLFWwindowrefreshfun
declare function glfwSetWindowFocusCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowfocusfun) as GLFWwindowfocusfun
declare function glfwSetWindowIconifyCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWwindowiconifyfun) as GLFWwindowiconifyfun
declare function glfwSetFramebufferSizeCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWframebuffersizefun) as GLFWframebuffersizefun
declare sub glfwPollEvents()
declare sub glfwWaitEvents()
declare sub glfwPostEmptyEvent()
declare function glfwGetInputMode(byval window as GLFWwindow ptr, byval mode as long) as long
declare sub glfwSetInputMode(byval window as GLFWwindow ptr, byval mode as long, byval value as long)
declare function glfwGetKey(byval window as GLFWwindow ptr, byval key as long) as long
declare function glfwGetMouseButton(byval window as GLFWwindow ptr, byval button as long) as long
declare sub glfwGetCursorPos(byval window as GLFWwindow ptr, byval xpos as double ptr, byval ypos as double ptr)
declare sub glfwSetCursorPos(byval window as GLFWwindow ptr, byval xpos as double, byval ypos as double)
type GLFWcursor as GLFWcursor_
declare function glfwCreateCursor(byval image as const GLFWimage ptr, byval xhot as long, byval yhot as long) as GLFWcursor ptr
declare function glfwCreateStandardCursor(byval shape as long) as GLFWcursor ptr
declare sub glfwDestroyCursor(byval cursor as GLFWcursor ptr)
declare sub glfwSetCursor(byval window as GLFWwindow ptr, byval cursor as GLFWcursor ptr)
declare function glfwSetKeyCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWkeyfun) as GLFWkeyfun
declare function glfwSetCharCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWcharfun) as GLFWcharfun
declare function glfwSetCharModsCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWcharmodsfun) as GLFWcharmodsfun
declare function glfwSetMouseButtonCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWmousebuttonfun) as GLFWmousebuttonfun
declare function glfwSetCursorPosCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWcursorposfun) as GLFWcursorposfun
declare function glfwSetCursorEnterCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWcursorenterfun) as GLFWcursorenterfun
declare function glfwSetScrollCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWscrollfun) as GLFWscrollfun
declare function glfwSetDropCallback(byval window as GLFWwindow ptr, byval cbfun as GLFWdropfun) as GLFWdropfun
declare function glfwJoystickPresent(byval joy as long) as long
declare function glfwGetJoystickAxes(byval joy as long, byval count as long ptr) as const single ptr
declare function glfwGetJoystickButtons(byval joy as long, byval count as long ptr) as const ubyte ptr
declare function glfwGetJoystickName(byval joy as long) as const zstring ptr
declare sub glfwSetClipboardString(byval window as GLFWwindow ptr, byval string as const zstring ptr)
declare function glfwGetClipboardString(byval window as GLFWwindow ptr) as const zstring ptr
declare function glfwGetTime() as double
declare sub glfwSetTime(byval time as double)
declare sub glfwMakeContextCurrent(byval window as GLFWwindow ptr)
declare function glfwGetCurrentContext() as GLFWwindow ptr
declare sub glfwSwapBuffers(byval window as GLFWwindow ptr)
declare sub glfwSwapInterval(byval interval as long)
declare function glfwExtensionSupported(byval extension as const zstring ptr) as long
declare function glfwGetProcAddress(byval procname as const zstring ptr) as GLFWglproc

end extern
