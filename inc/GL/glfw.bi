'' FreeBASIC binding for glfw-2.7.9
''
'' based on the C header files:
''   *********************************************************************
''    GLFW - An OpenGL framework
''    API version: 2.7
''    WWW:         http://www.glfw.org/
''   ------------------------------------------------------------------------
''    Copyright (c) 2002-2006 Marcus Geelnard
''    Copyright (c) 2006-2010 Camilla Berglund
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

#if defined(__FB_WIN32__) and defined(GLFW_DLL)
	#inclib "glfwdll"
#else
	#inclib "glfw"
#endif

#if defined(__FB_WIN32__) and (not defined(GLFW_DLL))
	#inclib "user32"
	#inclib "gdi32"
#endif

#include once "crt/long.bi"
#include once "GL/gl.bi"
#include once "GL/glu.bi"

#if defined(GLFW_DLL) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	extern "Windows"
#else
	extern "C"
#endif

#define __glfw_h_
#ifndef NULL
	const NULL = 0
#endif

#if defined(GLFW_DLL) and (defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	#define GLFWCALL stdcall
#else
	#define GLFWCALL cdecl
#endif

const GLFW_VERSION_MAJOR = 2
const GLFW_VERSION_MINOR = 7
const GLFW_VERSION_REVISION = 9
const GLFW_RELEASE = 0
const GLFW_PRESS = 1
const GLFW_KEY_UNKNOWN = -1
const GLFW_KEY_SPACE = 32
const GLFW_KEY_SPECIAL = 256
const GLFW_KEY_ESC = GLFW_KEY_SPECIAL + 1
const GLFW_KEY_F1 = GLFW_KEY_SPECIAL + 2
const GLFW_KEY_F2 = GLFW_KEY_SPECIAL + 3
const GLFW_KEY_F3 = GLFW_KEY_SPECIAL + 4
const GLFW_KEY_F4 = GLFW_KEY_SPECIAL + 5
const GLFW_KEY_F5 = GLFW_KEY_SPECIAL + 6
const GLFW_KEY_F6 = GLFW_KEY_SPECIAL + 7
const GLFW_KEY_F7 = GLFW_KEY_SPECIAL + 8
const GLFW_KEY_F8 = GLFW_KEY_SPECIAL + 9
const GLFW_KEY_F9 = GLFW_KEY_SPECIAL + 10
const GLFW_KEY_F10 = GLFW_KEY_SPECIAL + 11
const GLFW_KEY_F11 = GLFW_KEY_SPECIAL + 12
const GLFW_KEY_F12 = GLFW_KEY_SPECIAL + 13
const GLFW_KEY_F13 = GLFW_KEY_SPECIAL + 14
const GLFW_KEY_F14 = GLFW_KEY_SPECIAL + 15
const GLFW_KEY_F15 = GLFW_KEY_SPECIAL + 16
const GLFW_KEY_F16 = GLFW_KEY_SPECIAL + 17
const GLFW_KEY_F17 = GLFW_KEY_SPECIAL + 18
const GLFW_KEY_F18 = GLFW_KEY_SPECIAL + 19
const GLFW_KEY_F19 = GLFW_KEY_SPECIAL + 20
const GLFW_KEY_F20 = GLFW_KEY_SPECIAL + 21
const GLFW_KEY_F21 = GLFW_KEY_SPECIAL + 22
const GLFW_KEY_F22 = GLFW_KEY_SPECIAL + 23
const GLFW_KEY_F23 = GLFW_KEY_SPECIAL + 24
const GLFW_KEY_F24 = GLFW_KEY_SPECIAL + 25
const GLFW_KEY_F25 = GLFW_KEY_SPECIAL + 26
const GLFW_KEY_UP = GLFW_KEY_SPECIAL + 27
const GLFW_KEY_DOWN = GLFW_KEY_SPECIAL + 28
const GLFW_KEY_LEFT = GLFW_KEY_SPECIAL + 29
const GLFW_KEY_RIGHT = GLFW_KEY_SPECIAL + 30
const GLFW_KEY_LSHIFT = GLFW_KEY_SPECIAL + 31
const GLFW_KEY_RSHIFT = GLFW_KEY_SPECIAL + 32
const GLFW_KEY_LCTRL = GLFW_KEY_SPECIAL + 33
const GLFW_KEY_RCTRL = GLFW_KEY_SPECIAL + 34
const GLFW_KEY_LALT = GLFW_KEY_SPECIAL + 35
const GLFW_KEY_RALT = GLFW_KEY_SPECIAL + 36
const GLFW_KEY_TAB = GLFW_KEY_SPECIAL + 37
const GLFW_KEY_ENTER = GLFW_KEY_SPECIAL + 38
const GLFW_KEY_BACKSPACE = GLFW_KEY_SPECIAL + 39
const GLFW_KEY_INSERT = GLFW_KEY_SPECIAL + 40
const GLFW_KEY_DEL = GLFW_KEY_SPECIAL + 41
const GLFW_KEY_PAGEUP = GLFW_KEY_SPECIAL + 42
const GLFW_KEY_PAGEDOWN = GLFW_KEY_SPECIAL + 43
const GLFW_KEY_HOME = GLFW_KEY_SPECIAL + 44
const GLFW_KEY_END = GLFW_KEY_SPECIAL + 45
const GLFW_KEY_KP_0 = GLFW_KEY_SPECIAL + 46
const GLFW_KEY_KP_1 = GLFW_KEY_SPECIAL + 47
const GLFW_KEY_KP_2 = GLFW_KEY_SPECIAL + 48
const GLFW_KEY_KP_3 = GLFW_KEY_SPECIAL + 49
const GLFW_KEY_KP_4 = GLFW_KEY_SPECIAL + 50
const GLFW_KEY_KP_5 = GLFW_KEY_SPECIAL + 51
const GLFW_KEY_KP_6 = GLFW_KEY_SPECIAL + 52
const GLFW_KEY_KP_7 = GLFW_KEY_SPECIAL + 53
const GLFW_KEY_KP_8 = GLFW_KEY_SPECIAL + 54
const GLFW_KEY_KP_9 = GLFW_KEY_SPECIAL + 55
const GLFW_KEY_KP_DIVIDE = GLFW_KEY_SPECIAL + 56
const GLFW_KEY_KP_MULTIPLY = GLFW_KEY_SPECIAL + 57
const GLFW_KEY_KP_SUBTRACT = GLFW_KEY_SPECIAL + 58
const GLFW_KEY_KP_ADD = GLFW_KEY_SPECIAL + 59
const GLFW_KEY_KP_DECIMAL = GLFW_KEY_SPECIAL + 60
const GLFW_KEY_KP_EQUAL = GLFW_KEY_SPECIAL + 61
const GLFW_KEY_KP_ENTER = GLFW_KEY_SPECIAL + 62
const GLFW_KEY_KP_NUM_LOCK = GLFW_KEY_SPECIAL + 63
const GLFW_KEY_CAPS_LOCK = GLFW_KEY_SPECIAL + 64
const GLFW_KEY_SCROLL_LOCK = GLFW_KEY_SPECIAL + 65
const GLFW_KEY_PAUSE = GLFW_KEY_SPECIAL + 66
const GLFW_KEY_LSUPER = GLFW_KEY_SPECIAL + 67
const GLFW_KEY_RSUPER = GLFW_KEY_SPECIAL + 68
const GLFW_KEY_MENU = GLFW_KEY_SPECIAL + 69
const GLFW_KEY_LAST = GLFW_KEY_MENU
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
const GLFW_WINDOW = &h00010001
const GLFW_FULLSCREEN = &h00010002
const GLFW_OPENED = &h00020001
const GLFW_ACTIVE = &h00020002
const GLFW_ICONIFIED = &h00020003
const GLFW_ACCELERATED = &h00020004
const GLFW_RED_BITS = &h00020005
const GLFW_GREEN_BITS = &h00020006
const GLFW_BLUE_BITS = &h00020007
const GLFW_ALPHA_BITS = &h00020008
const GLFW_DEPTH_BITS = &h00020009
const GLFW_STENCIL_BITS = &h0002000A
const GLFW_REFRESH_RATE = &h0002000B
const GLFW_ACCUM_RED_BITS = &h0002000C
const GLFW_ACCUM_GREEN_BITS = &h0002000D
const GLFW_ACCUM_BLUE_BITS = &h0002000E
const GLFW_ACCUM_ALPHA_BITS = &h0002000F
const GLFW_AUX_BUFFERS = &h00020010
const GLFW_STEREO = &h00020011
const GLFW_WINDOW_NO_RESIZE = &h00020012
const GLFW_FSAA_SAMPLES = &h00020013
const GLFW_OPENGL_VERSION_MAJOR = &h00020014
const GLFW_OPENGL_VERSION_MINOR = &h00020015
const GLFW_OPENGL_FORWARD_COMPAT = &h00020016
const GLFW_OPENGL_DEBUG_CONTEXT = &h00020017
const GLFW_OPENGL_PROFILE = &h00020018
const GLFW_OPENGL_CORE_PROFILE = &h00050001
const GLFW_OPENGL_COMPAT_PROFILE = &h00050002
const GLFW_MOUSE_CURSOR = &h00030001
const GLFW_STICKY_KEYS = &h00030002
const GLFW_STICKY_MOUSE_BUTTONS = &h00030003
const GLFW_SYSTEM_KEYS = &h00030004
const GLFW_KEY_REPEAT = &h00030005
const GLFW_AUTO_POLL_EVENTS = &h00030006
const GLFW_WAIT = &h00040001
const GLFW_NOWAIT = &h00040002
const GLFW_PRESENT = &h00050001
const GLFW_AXES = &h00050002
const GLFW_BUTTONS = &h00050003
const GLFW_NO_RESCALE_BIT = &h00000001
const GLFW_ORIGIN_UL_BIT = &h00000002
const GLFW_BUILD_MIPMAPS_BIT = &h00000004
const GLFW_ALPHA_MAP_BIT = &h00000008
const GLFW_INFINITY = 100000.0

type GLFWvidmode
	Width as long
	Height as long
	RedBits as long
	BlueBits as long
	GreenBits as long
end type

type GLFWimage
	Width as long
	Height as long
	Format as long
	BytesPerPixel as long
	Data as ubyte ptr
end type

type GLFWthread as long
type GLFWmutex as any ptr
type GLFWcond as any ptr
type GLFWwindowsizefun as sub(byval as long, byval as long)
type GLFWwindowclosefun as function() as long
type GLFWwindowrefreshfun as sub()
type GLFWmousebuttonfun as sub(byval as long, byval as long)
type GLFWmouseposfun as sub(byval as long, byval as long)
type GLFWmousewheelfun as sub(byval as long)
type GLFWkeyfun as sub(byval as long, byval as long)
type GLFWcharfun as sub(byval as long, byval as long)
type GLFWthreadfun as sub(byval as any ptr)

declare function glfwInit() as long
declare sub glfwTerminate()
declare sub glfwGetVersion(byval major as long ptr, byval minor as long ptr, byval rev as long ptr)
declare function glfwOpenWindow(byval width as long, byval height as long, byval redbits as long, byval greenbits as long, byval bluebits as long, byval alphabits as long, byval depthbits as long, byval stencilbits as long, byval mode as long) as long
declare sub glfwOpenWindowHint(byval target as long, byval hint as long)
declare sub glfwCloseWindow()
declare sub glfwSetWindowTitle(byval title as const zstring ptr)
declare sub glfwGetWindowSize(byval width as long ptr, byval height as long ptr)
declare sub glfwSetWindowSize(byval width as long, byval height as long)
declare sub glfwSetWindowPos(byval x as long, byval y as long)
declare sub glfwIconifyWindow()
declare sub glfwRestoreWindow()
declare sub glfwSwapBuffers()
declare sub glfwSwapInterval(byval interval as long)
declare function glfwGetWindowParam(byval param as long) as long
declare sub glfwSetWindowSizeCallback(byval cbfun as GLFWwindowsizefun)
declare sub glfwSetWindowCloseCallback(byval cbfun as GLFWwindowclosefun)
declare sub glfwSetWindowRefreshCallback(byval cbfun as GLFWwindowrefreshfun)
declare function glfwGetVideoModes(byval list as GLFWvidmode ptr, byval maxcount as long) as long
declare sub glfwGetDesktopMode(byval mode as GLFWvidmode ptr)
declare sub glfwPollEvents()
declare sub glfwWaitEvents()
declare function glfwGetKey(byval key as long) as long
declare function glfwGetMouseButton(byval button as long) as long
declare sub glfwGetMousePos(byval xpos as long ptr, byval ypos as long ptr)
declare sub glfwSetMousePos(byval xpos as long, byval ypos as long)
declare function glfwGetMouseWheel() as long
declare sub glfwSetMouseWheel(byval pos as long)
declare sub glfwSetKeyCallback(byval cbfun as GLFWkeyfun)
declare sub glfwSetCharCallback(byval cbfun as GLFWcharfun)
declare sub glfwSetMouseButtonCallback(byval cbfun as GLFWmousebuttonfun)
declare sub glfwSetMousePosCallback(byval cbfun as GLFWmouseposfun)
declare sub glfwSetMouseWheelCallback(byval cbfun as GLFWmousewheelfun)
declare function glfwGetJoystickParam(byval joy as long, byval param as long) as long
declare function glfwGetJoystickPos(byval joy as long, byval pos as single ptr, byval numaxes as long) as long
declare function glfwGetJoystickButtons(byval joy as long, byval buttons as ubyte ptr, byval numbuttons as long) as long
declare function glfwGetTime() as double
declare sub glfwSetTime(byval time as double)
declare sub glfwSleep(byval time as double)
declare function glfwExtensionSupported(byval extension as const zstring ptr) as long
declare function glfwGetProcAddress(byval procname as const zstring ptr) as any ptr
declare sub glfwGetGLVersion(byval major as long ptr, byval minor as long ptr, byval rev as long ptr)
declare function glfwCreateThread(byval fun as GLFWthreadfun, byval arg as any ptr) as GLFWthread
declare sub glfwDestroyThread(byval ID as GLFWthread)
declare function glfwWaitThread(byval ID as GLFWthread, byval waitmode as long) as long
declare function glfwGetThreadID() as GLFWthread
declare function glfwCreateMutex() as GLFWmutex
declare sub glfwDestroyMutex(byval mutex as GLFWmutex)
declare sub glfwLockMutex(byval mutex as GLFWmutex)
declare sub glfwUnlockMutex(byval mutex as GLFWmutex)
declare function glfwCreateCond() as GLFWcond
declare sub glfwDestroyCond(byval cond as GLFWcond)
declare sub glfwWaitCond(byval cond as GLFWcond, byval mutex as GLFWmutex, byval timeout as double)
declare sub glfwSignalCond(byval cond as GLFWcond)
declare sub glfwBroadcastCond(byval cond as GLFWcond)
declare function glfwGetNumberOfProcessors() as long
declare sub glfwEnable(byval token as long)
declare sub glfwDisable(byval token as long)
declare function glfwReadImage(byval name as const zstring ptr, byval img as GLFWimage ptr, byval flags as long) as long
declare function glfwReadMemoryImage(byval data as const any ptr, byval size as clong, byval img as GLFWimage ptr, byval flags as long) as long
declare sub glfwFreeImage(byval img as GLFWimage ptr)
declare function glfwLoadTexture2D(byval name as const zstring ptr, byval flags as long) as long
declare function glfwLoadMemoryTexture2D(byval data as const any ptr, byval size as clong, byval flags as long) as long
declare function glfwLoadTextureImage2D(byval img as GLFWimage ptr, byval flags as long) as long

end extern
