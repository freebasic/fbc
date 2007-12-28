''
''
'' glfw -- An OpenGL framework (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __glfw_bi__
#define __glfw_bi__

'' Copyright (c) 2002-2005 Marcus Geelnard
''
'' This software is provided 'as-is', without any express or implied
'' warranty. In no event will the authors be held liable for any damages
'' arising from the use of this software.
''
'' Permission is granted to anyone to use this software for any purpose,
'' including commercial applications, and to alter it and redistribute it
'' freely, subject to the following restrictions:
''
'' 1. The origin of this software must not be misrepresented; you must not
''    claim that you wrote the original software. If you use this software
''    in a product, an acknowledgment in the product documentation would
''    be appreciated but is not required.
''
'' 2. Altered source versions must be plainly marked as such, and must not
''    be misrepresented as being the original software.
''
'' 3. This notice may not be removed or altered from any source
''    distribution.
''
'' Marcus Geelnard
'' marcus.geelnard at home.se

#inclib "glfw"

#ifdef __FB_WIN32__
#	ifndef GLFW_DLL
#		inclib "user32"
#		inclib "gdi32"
#		define GLFWAPIENTRY cdecl
#		define GLFWCALL     cdecl
#	else
#		define GLFWAPIENTRY stdcall
#		define GLFWCALL     stdcall
#	endif
#else
#	define GLFWAPIENTRY cdecl
#	define GLFWCALL     cdecl
#endif

#include once "GL/gl.bi"
#include once "GL/glu.bi"

#define GLFW_VERSION_MAJOR 2
#define GLFW_VERSION_MINOR 5
#define GLFW_VERSION_REVISION 0
#define GLFW_RELEASE 0
#define GLFW_PRESS 1
#define GLFW_KEY_UNKNOWN -1
#define GLFW_KEY_SPACE 32
#define GLFW_KEY_SPECIAL 256
#define GLFW_KEY_ESC (256+1)
#define GLFW_KEY_F1 (256+2)
#define GLFW_KEY_F2 (256+3)
#define GLFW_KEY_F3 (256+4)
#define GLFW_KEY_F4 (256+5)
#define GLFW_KEY_F5 (256+6)
#define GLFW_KEY_F6 (256+7)
#define GLFW_KEY_F7 (256+8)
#define GLFW_KEY_F8 (256+9)
#define GLFW_KEY_F9 (256+10)
#define GLFW_KEY_F10 (256+11)
#define GLFW_KEY_F11 (256+12)
#define GLFW_KEY_F12 (256+13)
#define GLFW_KEY_F13 (256+14)
#define GLFW_KEY_F14 (256+15)
#define GLFW_KEY_F15 (256+16)
#define GLFW_KEY_F16 (256+17)
#define GLFW_KEY_F17 (256+18)
#define GLFW_KEY_F18 (256+19)
#define GLFW_KEY_F19 (256+20)
#define GLFW_KEY_F20 (256+21)
#define GLFW_KEY_F21 (256+22)
#define GLFW_KEY_F22 (256+23)
#define GLFW_KEY_F23 (256+24)
#define GLFW_KEY_F24 (256+25)
#define GLFW_KEY_F25 (256+26)
#define GLFW_KEY_UP (256+27)
#define GLFW_KEY_DOWN (256+28)
#define GLFW_KEY_LEFT (256+29)
#define GLFW_KEY_RIGHT (256+30)
#define GLFW_KEY_LSHIFT (256+31)
#define GLFW_KEY_RSHIFT (256+32)
#define GLFW_KEY_LCTRL (256+33)
#define GLFW_KEY_RCTRL (256+34)
#define GLFW_KEY_LALT (256+35)
#define GLFW_KEY_RALT (256+36)
#define GLFW_KEY_TAB (256+37)
#define GLFW_KEY_ENTER (256+38)
#define GLFW_KEY_BACKSPACE (256+39)
#define GLFW_KEY_INSERT (256+40)
#define GLFW_KEY_DEL (256+41)
#define GLFW_KEY_PAGEUP (256+42)
#define GLFW_KEY_PAGEDOWN (256+43)
#define GLFW_KEY_HOME (256+44)
#define GLFW_KEY_END (256+45)
#define GLFW_KEY_KP_0 (256+46)
#define GLFW_KEY_KP_1 (256+47)
#define GLFW_KEY_KP_2 (256+48)
#define GLFW_KEY_KP_3 (256+49)
#define GLFW_KEY_KP_4 (256+50)
#define GLFW_KEY_KP_5 (256+51)
#define GLFW_KEY_KP_6 (256+52)
#define GLFW_KEY_KP_7 (256+53)
#define GLFW_KEY_KP_8 (256+54)
#define GLFW_KEY_KP_9 (256+55)
#define GLFW_KEY_KP_DIVIDE (256+56)
#define GLFW_KEY_KP_MULTIPLY (256+57)
#define GLFW_KEY_KP_SUBTRACT (256+58)
#define GLFW_KEY_KP_ADD (256+59)
#define GLFW_KEY_KP_DECIMAL (256+60)
#define GLFW_KEY_KP_EQUAL (256+61)
#define GLFW_KEY_KP_ENTER (256+62)
#define GLFW_KEY_LAST (256+62)
#define GLFW_MOUSE_BUTTON_1 0
#define GLFW_MOUSE_BUTTON_2 1
#define GLFW_MOUSE_BUTTON_3 2
#define GLFW_MOUSE_BUTTON_4 3
#define GLFW_MOUSE_BUTTON_5 4
#define GLFW_MOUSE_BUTTON_6 5
#define GLFW_MOUSE_BUTTON_7 6
#define GLFW_MOUSE_BUTTON_8 7
#define GLFW_MOUSE_BUTTON_LAST 7
#define GLFW_MOUSE_BUTTON_LEFT 0
#define GLFW_MOUSE_BUTTON_RIGHT 1
#define GLFW_MOUSE_BUTTON_MIDDLE 2
#define GLFW_JOYSTICK_1 0
#define GLFW_JOYSTICK_2 1
#define GLFW_JOYSTICK_3 2
#define GLFW_JOYSTICK_4 3
#define GLFW_JOYSTICK_5 4
#define GLFW_JOYSTICK_6 5
#define GLFW_JOYSTICK_7 6
#define GLFW_JOYSTICK_8 7
#define GLFW_JOYSTICK_9 8
#define GLFW_JOYSTICK_10 9
#define GLFW_JOYSTICK_11 10
#define GLFW_JOYSTICK_12 11
#define GLFW_JOYSTICK_13 12
#define GLFW_JOYSTICK_14 13
#define GLFW_JOYSTICK_15 14
#define GLFW_JOYSTICK_16 15
#define GLFW_JOYSTICK_LAST 15
#define GLFW_WINDOW &h00010001
#define GLFW_FULLSCREEN &h00010002
#define GLFW_OPENED &h00020001
#define GLFW_ACTIVE &h00020002
#define GLFW_ICONIFIED &h00020003
#define GLFW_ACCELERATED &h00020004
#define GLFW_RED_BITS &h00020005
#define GLFW_GREEN_BITS &h00020006
#define GLFW_BLUE_BITS &h00020007
#define GLFW_ALPHA_BITS &h00020008
#define GLFW_DEPTH_BITS &h00020009
#define GLFW_STENCIL_BITS &h0002000A
#define GLFW_REFRESH_RATE &h0002000B
#define GLFW_ACCUM_RED_BITS &h0002000C
#define GLFW_ACCUM_GREEN_BITS &h0002000D
#define GLFW_ACCUM_BLUE_BITS &h0002000E
#define GLFW_ACCUM_ALPHA_BITS &h0002000F
#define GLFW_AUX_BUFFERS &h00020010
#define GLFW_STEREO &h00020011
#define GLFW_MOUSE_CURSOR &h00030001
#define GLFW_STICKY_KEYS &h00030002
#define GLFW_STICKY_MOUSE_BUTTONS &h00030003
#define GLFW_SYSTEM_KEYS &h00030004
#define GLFW_KEY_REPEAT &h00030005
#define GLFW_AUTO_POLL_EVENTS &h00030006
#define GLFW_WAIT &h00040001
#define GLFW_NOWAIT &h00040002
#define GLFW_PRESENT &h00050001
#define GLFW_AXES &h00050002
#define GLFW_BUTTONS &h00050003
#define GLFW_NO_RESCALE_BIT &h00000001
#define GLFW_ORIGIN_UL_BIT &h00000002
#define GLFW_BUILD_MIPMAPS_BIT &h00000004
#define GLFW_ALPHA_MAP_BIT &h00000008
#define GLFW_INFINITY 100000.0

type GLFWvidmode
	Width as integer
	Height as integer
	RedBits as integer
	BlueBits as integer
	GreenBits as integer
end type

type GLFWimage
	Width as integer
	Height as integer
	Format as integer
	BytesPerPixel as integer
	Data as ubyte ptr
end type

type GLFWthread as integer
type GLFWmutex as any ptr
type GLFWcond as any ptr
type GLFWwindowsizefun as sub GLFWCALL(byval as integer, byval as integer)
type GLFWwindowclosefun as function GLFWCALL() as integer
type GLFWwindowrefreshfun as sub GLFWCALL()
type GLFWmousebuttonfun as sub GLFWCALL(byval as integer, byval as integer)
type GLFWmouseposfun as sub GLFWCALL(byval as integer, byval as integer)
type GLFWmousewheelfun as sub GLFWCALL(byval as integer)
type GLFWkeyfun as sub GLFWCALL(byval as integer, byval as integer)
type GLFWcharfun as sub GLFWCALL(byval as integer, byval as integer)
type GLFWthreadfun as sub GLFWCALL(byval as any ptr)

declare function glfwInit GLFWAPIENTRY alias "glfwInit" () as integer
declare sub glfwTerminate GLFWAPIENTRY alias "glfwTerminate" ()
declare sub glfwGetVersion GLFWAPIENTRY alias "glfwGetVersion" (byval major as integer ptr, byval minor as integer ptr, byval rev as integer ptr)
declare function glfwOpenWindow GLFWAPIENTRY alias "glfwOpenWindow" (byval width as integer, byval height as integer, byval redbits as integer, byval greenbits as integer, byval bluebits as integer, byval alphabits as integer, byval depthbits as integer, byval stencilbits as integer, byval mode as integer) as integer
declare sub glfwOpenWindowHint GLFWAPIENTRY alias "glfwOpenWindowHint" (byval target as integer, byval hint as integer)
declare sub glfwCloseWindow GLFWAPIENTRY alias "glfwCloseWindow" ()
declare sub glfwSetWindowTitle GLFWAPIENTRY alias "glfwSetWindowTitle" (byval title as zstring ptr)
declare sub glfwGetWindowSize GLFWAPIENTRY alias "glfwGetWindowSize" (byval width as integer ptr, byval height as integer ptr)
declare sub glfwSetWindowSize GLFWAPIENTRY alias "glfwSetWindowSize" (byval width as integer, byval height as integer)
declare sub glfwSetWindowPos GLFWAPIENTRY alias "glfwSetWindowPos" (byval x as integer, byval y as integer)
declare sub glfwIconifyWindow GLFWAPIENTRY alias "glfwIconifyWindow" ()
declare sub glfwRestoreWindow GLFWAPIENTRY alias "glfwRestoreWindow" ()
declare sub glfwSwapBuffers GLFWAPIENTRY alias "glfwSwapBuffers" ()
declare sub glfwSwapInterval GLFWAPIENTRY alias "glfwSwapInterval" (byval interval as integer)
declare function glfwGetWindowParam GLFWAPIENTRY alias "glfwGetWindowParam" (byval param as integer) as integer
declare sub glfwSetWindowSizeCallback GLFWAPIENTRY alias "glfwSetWindowSizeCallback" (byval cbfun as GLFWwindowsizefun)
declare sub glfwSetWindowCloseCallback GLFWAPIENTRY alias "glfwSetWindowCloseCallback" (byval cbfun as GLFWwindowclosefun)
declare sub glfwSetWindowRefreshCallback GLFWAPIENTRY alias "glfwSetWindowRefreshCallback" (byval cbfun as GLFWwindowrefreshfun)
declare function glfwGetVideoModes GLFWAPIENTRY alias "glfwGetVideoModes" (byval list as GLFWvidmode ptr, byval maxcount as integer) as integer
declare sub glfwGetDesktopMode GLFWAPIENTRY alias "glfwGetDesktopMode" (byval mode as GLFWvidmode ptr)
declare sub glfwPollEvents GLFWAPIENTRY alias "glfwPollEvents" ()
declare sub glfwWaitEvents GLFWAPIENTRY alias "glfwWaitEvents" ()
declare function glfwGetKey GLFWAPIENTRY alias "glfwGetKey" (byval key as integer) as integer
declare function glfwGetMouseButton GLFWAPIENTRY alias "glfwGetMouseButton" (byval button as integer) as integer
declare sub glfwGetMousePos GLFWAPIENTRY alias "glfwGetMousePos" (byval xpos as integer ptr, byval ypos as integer ptr)
declare sub glfwSetMousePos GLFWAPIENTRY alias "glfwSetMousePos" (byval xpos as integer, byval ypos as integer)
declare function glfwGetMouseWheel GLFWAPIENTRY alias "glfwGetMouseWheel" () as integer
declare sub glfwSetMouseWheel GLFWAPIENTRY alias "glfwSetMouseWheel" (byval pos as integer)
declare sub glfwSetKeyCallback GLFWAPIENTRY alias "glfwSetKeyCallback" (byval cbfun as GLFWkeyfun)
declare sub glfwSetCharCallback GLFWAPIENTRY alias "glfwSetCharCallback" (byval cbfun as GLFWcharfun)
declare sub glfwSetMouseButtonCallback GLFWAPIENTRY alias "glfwSetMouseButtonCallback" (byval cbfun as GLFWmousebuttonfun)
declare sub glfwSetMousePosCallback GLFWAPIENTRY alias "glfwSetMousePosCallback" (byval cbfun as GLFWmouseposfun)
declare sub glfwSetMouseWheelCallback GLFWAPIENTRY alias "glfwSetMouseWheelCallback" (byval cbfun as GLFWmousewheelfun)
declare function glfwGetJoystickParam GLFWAPIENTRY alias "glfwGetJoystickParam" (byval joy as integer, byval param as integer) as integer
declare function glfwGetJoystickPos GLFWAPIENTRY alias "glfwGetJoystickPos" (byval joy as integer, byval pos as single ptr, byval numaxes as integer) as integer
declare function glfwGetJoystickButtons GLFWAPIENTRY alias "glfwGetJoystickButtons" (byval joy as integer, byval buttons as ubyte ptr, byval numbuttons as integer) as integer
declare function glfwGetTime GLFWAPIENTRY alias "glfwGetTime" () as double
declare sub glfwSetTime GLFWAPIENTRY alias "glfwSetTime" (byval time as double)
declare sub glfwSleep GLFWAPIENTRY alias "glfwSleep" (byval time as double)
declare function glfwExtensionSupported GLFWAPIENTRY alias "glfwExtensionSupported" (byval extension as zstring ptr) as integer
declare function glfwGetProcAddress GLFWAPIENTRY alias "glfwGetProcAddress" (byval procname as zstring ptr) as any ptr
declare sub glfwGetGLVersion GLFWAPIENTRY alias "glfwGetGLVersion" (byval major as integer ptr, byval minor as integer ptr, byval rev as integer ptr)
declare function glfwCreateThread GLFWAPIENTRY alias "glfwCreateThread" (byval fun as GLFWthreadfun, byval arg as any ptr) as GLFWthread
declare sub glfwDestroyThread GLFWAPIENTRY alias "glfwDestroyThread" (byval ID as GLFWthread)
declare function glfwWaitThread GLFWAPIENTRY alias "glfwWaitThread" (byval ID as GLFWthread, byval waitmode as integer) as integer
declare function glfwGetThreadID GLFWAPIENTRY alias "glfwGetThreadID" () as GLFWthread
declare function glfwCreateMutex GLFWAPIENTRY alias "glfwCreateMutex" () as GLFWmutex
declare sub glfwDestroyMutex GLFWAPIENTRY alias "glfwDestroyMutex" (byval mutex as GLFWmutex)
declare sub glfwLockMutex GLFWAPIENTRY alias "glfwLockMutex" (byval mutex as GLFWmutex)
declare sub glfwUnlockMutex GLFWAPIENTRY alias "glfwUnlockMutex" (byval mutex as GLFWmutex)
declare function glfwCreateCond GLFWAPIENTRY alias "glfwCreateCond" () as GLFWcond
declare sub glfwDestroyCond GLFWAPIENTRY alias "glfwDestroyCond" (byval cond as GLFWcond)
declare sub glfwWaitCond GLFWAPIENTRY alias "glfwWaitCond" (byval cond as GLFWcond, byval mutex as GLFWmutex, byval timeout as double)
declare sub glfwSignalCond GLFWAPIENTRY alias "glfwSignalCond" (byval cond as GLFWcond)
declare sub glfwBroadcastCond GLFWAPIENTRY alias "glfwBroadcastCond" (byval cond as GLFWcond)
declare function glfwGetNumberOfProcessors GLFWAPIENTRY alias "glfwGetNumberOfProcessors" () as integer
declare sub glfwEnable GLFWAPIENTRY alias "glfwEnable" (byval token as integer)
declare sub glfwDisable GLFWAPIENTRY alias "glfwDisable" (byval token as integer)
declare function glfwReadImage GLFWAPIENTRY alias "glfwReadImage" (byval name as zstring ptr, byval img as GLFWimage ptr, byval flags as integer) as integer
declare sub glfwFreeImage GLFWAPIENTRY alias "glfwFreeImage" (byval img as GLFWimage ptr)
declare function glfwLoadTexture2D GLFWAPIENTRY alias "glfwLoadTexture2D" (byval name as zstring ptr, byval flags as integer) as integer

#endif
