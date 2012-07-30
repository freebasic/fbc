/'***********************************************************************
 * GLFW - An OpenGL framework
 * API version: 2.7
 * WWW:         http://www.glfw.org/
 *------------------------------------------------------------------------
 * Copyright (c) 2002-2006 Marcus Geelnard
 * Copyright (c) 2006-2010 Camilla Berglund
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would
 *    be appreciated but is not required.
 *
 * 2. Altered source versions must be plainly marked as such, and must not
 *    be misrepresented as being the original software.
 *
 * 3. This notice may not be removed or altered from any source
 *    distribution.
 *
 ************************************************************************'/

#Ifndef __glfw_bi__
#define __glfw_bi__

#If Defined(__FB_WIN32__) Or Defined(__FB_CYGWIN__)
#Ifndef GLFW_DLL
Extern "C"
#Else
Extern "Windows"
#EndIf
#ElseIf Defined(__FB_UNIX__)
Extern "C"
#Else
Extern "C"
#EndIf

/'************************************************************************
 * Global definitions
 ************************************************************************'/

/' We need a NULL pointer from time to time '/
#Ifndef NULL
#define NULL 0
#EndIf /' NULL '/

#Ifdef __FB_WIN32__
#	ifndef GLFW_DLL
#		Inclib "glfw"
#		inclib "user32"
#		inclib "gdi32"
#		define GLFWCALL Cdecl
#	Else
#		Inclib "glfwdll"
#		define GLFWCALL StdCall
#	EndIf
#Else
#	Inclib "glfw"
#	define GLFWCALL Cdecl
#EndIf

#Include Once "GL/gl.bi"
#Include Once "GL/glu.bi"

/'************************************************************************
 * GLFW version
 ************************************************************************'/

#define GLFW_VERSION_MAJOR    2
#define GLFW_VERSION_MINOR    7
#define GLFW_VERSION_REVISION 2


/'************************************************************************
 * Input handling definitions
 ************************************************************************'/

/' Key and button state/action definitions '/
#define GLFW_RELEASE            0
#define GLFW_PRESS              1

/' Keyboard key definitions: 8-bit ISO-8859-1 (Latin 1) encoding is used
 * for printable keys (such as A-Z, 0-9 etc), and values above 256
 * represent special (non-printable) keys (e.g. F1, Page Up etc).
 '/
#define GLFW_KEY_UNKNOWN      -1
#define GLFW_KEY_SPACE        32
#define GLFW_KEY_SPECIAL      256
#define GLFW_KEY_ESC          (GLFW_KEY_SPECIAL+1)
#define GLFW_KEY_F1           (GLFW_KEY_SPECIAL+2)
#define GLFW_KEY_F2           (GLFW_KEY_SPECIAL+3)
#define GLFW_KEY_F3           (GLFW_KEY_SPECIAL+4)
#define GLFW_KEY_F4           (GLFW_KEY_SPECIAL+5)
#define GLFW_KEY_F5           (GLFW_KEY_SPECIAL+6)
#define GLFW_KEY_F6           (GLFW_KEY_SPECIAL+7)
#define GLFW_KEY_F7           (GLFW_KEY_SPECIAL+8)
#define GLFW_KEY_F8           (GLFW_KEY_SPECIAL+9)
#define GLFW_KEY_F9           (GLFW_KEY_SPECIAL+10)
#define GLFW_KEY_F10          (GLFW_KEY_SPECIAL+11)
#define GLFW_KEY_F11          (GLFW_KEY_SPECIAL+12)
#define GLFW_KEY_F12          (GLFW_KEY_SPECIAL+13)
#define GLFW_KEY_F13          (GLFW_KEY_SPECIAL+14)
#define GLFW_KEY_F14          (GLFW_KEY_SPECIAL+15)
#define GLFW_KEY_F15          (GLFW_KEY_SPECIAL+16)
#define GLFW_KEY_F16          (GLFW_KEY_SPECIAL+17)
#define GLFW_KEY_F17          (GLFW_KEY_SPECIAL+18)
#define GLFW_KEY_F18          (GLFW_KEY_SPECIAL+19)
#define GLFW_KEY_F19          (GLFW_KEY_SPECIAL+20)
#define GLFW_KEY_F20          (GLFW_KEY_SPECIAL+21)
#define GLFW_KEY_F21          (GLFW_KEY_SPECIAL+22)
#define GLFW_KEY_F22          (GLFW_KEY_SPECIAL+23)
#define GLFW_KEY_F23          (GLFW_KEY_SPECIAL+24)
#define GLFW_KEY_F24          (GLFW_KEY_SPECIAL+25)
#define GLFW_KEY_F25          (GLFW_KEY_SPECIAL+26)
#define GLFW_KEY_UP           (GLFW_KEY_SPECIAL+27)
#define GLFW_KEY_DOWN         (GLFW_KEY_SPECIAL+28)
#define GLFW_KEY_LEFT         (GLFW_KEY_SPECIAL+29)
#define GLFW_KEY_RIGHT        (GLFW_KEY_SPECIAL+30)
#define GLFW_KEY_LSHIFT       (GLFW_KEY_SPECIAL+31)
#define GLFW_KEY_RSHIFT       (GLFW_KEY_SPECIAL+32)
#define GLFW_KEY_LCTRL        (GLFW_KEY_SPECIAL+33)
#define GLFW_KEY_RCTRL        (GLFW_KEY_SPECIAL+34)
#define GLFW_KEY_LALT         (GLFW_KEY_SPECIAL+35)
#define GLFW_KEY_RALT         (GLFW_KEY_SPECIAL+36)
#define GLFW_KEY_TAB          (GLFW_KEY_SPECIAL+37)
#define GLFW_KEY_ENTER        (GLFW_KEY_SPECIAL+38)
#define GLFW_KEY_BACKSPACE    (GLFW_KEY_SPECIAL+39)
#define GLFW_KEY_INSERT       (GLFW_KEY_SPECIAL+40)
#define GLFW_KEY_DEL          (GLFW_KEY_SPECIAL+41)
#define GLFW_KEY_PAGEUP       (GLFW_KEY_SPECIAL+42)
#define GLFW_KEY_PAGEDOWN     (GLFW_KEY_SPECIAL+43)
#define GLFW_KEY_HOME         (GLFW_KEY_SPECIAL+44)
#define GLFW_KEY_END          (GLFW_KEY_SPECIAL+45)
#define GLFW_KEY_KP_0         (GLFW_KEY_SPECIAL+46)
#define GLFW_KEY_KP_1         (GLFW_KEY_SPECIAL+47)
#define GLFW_KEY_KP_2         (GLFW_KEY_SPECIAL+48)
#define GLFW_KEY_KP_3         (GLFW_KEY_SPECIAL+49)
#define GLFW_KEY_KP_4         (GLFW_KEY_SPECIAL+50)
#define GLFW_KEY_KP_5         (GLFW_KEY_SPECIAL+51)
#define GLFW_KEY_KP_6         (GLFW_KEY_SPECIAL+52)
#define GLFW_KEY_KP_7         (GLFW_KEY_SPECIAL+53)
#define GLFW_KEY_KP_8         (GLFW_KEY_SPECIAL+54)
#define GLFW_KEY_KP_9         (GLFW_KEY_SPECIAL+55)
#define GLFW_KEY_KP_DIVIDE    (GLFW_KEY_SPECIAL+56)
#define GLFW_KEY_KP_MULTIPLY  (GLFW_KEY_SPECIAL+57)
#define GLFW_KEY_KP_SUBTRACT  (GLFW_KEY_SPECIAL+58)
#define GLFW_KEY_KP_ADD       (GLFW_KEY_SPECIAL+59)
#define GLFW_KEY_KP_DECIMAL   (GLFW_KEY_SPECIAL+60)
#define GLFW_KEY_KP_EQUAL     (GLFW_KEY_SPECIAL+61)
#define GLFW_KEY_KP_ENTER     (GLFW_KEY_SPECIAL+62)
#define GLFW_KEY_KP_NUM_LOCK  (GLFW_KEY_SPECIAL+63)
#define GLFW_KEY_CAPS_LOCK    (GLFW_KEY_SPECIAL+64)
#define GLFW_KEY_SCROLL_LOCK  (GLFW_KEY_SPECIAL+65)
#define GLFW_KEY_PAUSE        (GLFW_KEY_SPECIAL+66)
#define GLFW_KEY_LSUPER       (GLFW_KEY_SPECIAL+67)
#define GLFW_KEY_RSUPER       (GLFW_KEY_SPECIAL+68)
#define GLFW_KEY_MENU         (GLFW_KEY_SPECIAL+69)
#define GLFW_KEY_LAST         GLFW_KEY_MENU

/' Mouse button definitions '/
#define GLFW_MOUSE_BUTTON_1      0
#define GLFW_MOUSE_BUTTON_2      1
#define GLFW_MOUSE_BUTTON_3      2
#define GLFW_MOUSE_BUTTON_4      3
#define GLFW_MOUSE_BUTTON_5      4
#define GLFW_MOUSE_BUTTON_6      5
#define GLFW_MOUSE_BUTTON_7      6
#define GLFW_MOUSE_BUTTON_8      7
#define GLFW_MOUSE_BUTTON_LAST   GLFW_MOUSE_BUTTON_8

/' Mouse button aliases '/
#define GLFW_MOUSE_BUTTON_LEFT   GLFW_MOUSE_BUTTON_1
#define GLFW_MOUSE_BUTTON_RIGHT  GLFW_MOUSE_BUTTON_2
#define GLFW_MOUSE_BUTTON_MIDDLE GLFW_MOUSE_BUTTON_3


/' Joystick identifiers '/
#define GLFW_JOYSTICK_1          0
#define GLFW_JOYSTICK_2          1
#define GLFW_JOYSTICK_3          2
#define GLFW_JOYSTICK_4          3
#define GLFW_JOYSTICK_5          4
#define GLFW_JOYSTICK_6          5
#define GLFW_JOYSTICK_7          6
#define GLFW_JOYSTICK_8          7
#define GLFW_JOYSTICK_9          8
#define GLFW_JOYSTICK_10         9
#define GLFW_JOYSTICK_11         10
#define GLFW_JOYSTICK_12         11
#define GLFW_JOYSTICK_13         12
#define GLFW_JOYSTICK_14         13
#define GLFW_JOYSTICK_15         14
#define GLFW_JOYSTICK_16         15
#define GLFW_JOYSTICK_LAST       GLFW_JOYSTICK_16


/'************************************************************************
 * Other definitions
 ************************************************************************'/

/' glfwOpenWindow modes '/
#define GLFW_WINDOW               &h00010001
#define GLFW_FULLSCREEN           &h00010002

/' glfwGetWindowParam tokens '/
#define GLFW_OPENED               &h00020001
#define GLFW_ACTIVE               &h00020002
#define GLFW_ICONIFIED            &h00020003
#define GLFW_ACCELERATED          &h00020004
#define GLFW_RED_BITS             &h00020005
#define GLFW_GREEN_BITS           &h00020006
#define GLFW_BLUE_BITS            &h00020007
#define GLFW_ALPHA_BITS           &h00020008
#define GLFW_DEPTH_BITS           &h00020009
#define GLFW_STENCIL_BITS         &h0002000A

/' The following constants are used for both glfwGetWindowParam
 * and glfwOpenWindowHint
 '/
#define GLFW_REFRESH_RATE         &h0002000B
#define GLFW_ACCUM_RED_BITS       &h0002000C
#define GLFW_ACCUM_GREEN_BITS     &h0002000D
#define GLFW_ACCUM_BLUE_BITS      &h0002000E
#define GLFW_ACCUM_ALPHA_BITS     &h0002000F
#define GLFW_AUX_BUFFERS          &h00020010
#define GLFW_STEREO               &h00020011
#define GLFW_WINDOW_NO_RESIZE     &h00020012
#define GLFW_FSAA_SAMPLES         &h00020013
#define GLFW_OPENGL_VERSION_MAJOR &h00020014
#define GLFW_OPENGL_VERSION_MINOR &h00020015
#define GLFW_OPENGL_FORWARD_COMPAT &h00020016
#define GLFW_OPENGL_DEBUG_CONTEXT &h00020017
#define GLFW_OPENGL_PROFILE       &h00020018

/' GLFW_OPENGL_PROFILE tokens '/
#define GLFW_OPENGL_CORE_PROFILE  &h00050001
#define GLFW_OPENGL_COMPAT_PROFILE &h00050002

/' glfwEnable/glfwDisable tokens '/
#define GLFW_MOUSE_CURSOR         &h00030001
#define GLFW_STICKY_KEYS          &h00030002
#define GLFW_STICKY_MOUSE_BUTTONS &h00030003
#define GLFW_SYSTEM_KEYS          &h00030004
#define GLFW_KEY_REPEAT           &h00030005
#define GLFW_AUTO_POLL_EVENTS     &h00030006

/' glfwWaitThread wait modes '/
#define GLFW_WAIT                 &h00040001
#define GLFW_NOWAIT               &h00040002

/' glfwGetJoystickParam tokens '/
#define GLFW_PRESENT              &h00050001
#define GLFW_AXES                 &h00050002
#define GLFW_BUTTONS              &h00050003

/' glfwReadImage/glfwLoadTexture2D flags '/
#define GLFW_NO_RESCALE_BIT       &h00000001 /' Only for glfwReadImage '/
#define GLFW_ORIGIN_UL_BIT        &h00000002
#define GLFW_BUILD_MIPMAPS_BIT    &h00000004 /' Only for glfwLoadTexture2D '/
#define GLFW_ALPHA_MAP_BIT        &h00000008

/' Time spans longer than this (seconds) are considered to be infinity '/
#define GLFW_INFINITY 100000.0


/'************************************************************************
 * Typedefs
 ************************************************************************'/

/' The video mode structure used by glfwGetVideoModes() '/
Type GLFWvidmode
	As Integer Width, Height
	As Integer RedBits, BlueBits, GreenBits
End Type

/' Image/texture information '/
Type GLFWimage
	As Integer Width, Height
	As Integer Format
	As Integer BytesPerPixel
	As UByte Ptr Data
End Type

/' Thread ID '/
Type As Integer GLFWthread

/' Mutex object '/
Type As Any Ptr GLFWmutex

/' Condition variable object '/
Type As Any Ptr GLFWcond

/' Function pointer types '/
Type GLFWwindowsizefun As Sub GLFWCALL(ByVal As Integer, ByVal As Integer)
Type GLFWwindowclosefun As Function GLFWCALL() As Integer
Type GLFWwindowrefreshfun As Sub GLFWCALL()
Type GLFWmousebuttonfun As Sub GLFWCALL(ByVal As Integer, ByVal As Integer)
Type GLFWmouseposfun As Sub GLFWCALL(ByVal As Integer, ByVal As Integer)
Type GLFWmousewheelfun As Sub GLFWCALL(ByVal As Integer)
Type GLFWkeyfun As Sub GLFWCALL(ByVal As Integer, ByVal As Integer)
Type GLFWcharfun As Sub GLFWCALL(ByVal As Integer, ByVal As Integer)
Type GLFWthreadfun As Sub GLFWCALL(ByVal As Any Ptr)


/'************************************************************************
 * Prototypes
 ************************************************************************'/

/' GLFW initialization, termination and version querying '/
Declare Function glfwInit() As Integer
Declare Sub glfwTerminate()
Declare Sub glfwGetVersion(ByVal major As Integer Ptr, ByVal minor As Integer Ptr, ByVal rev As Integer Ptr)

/' Window handling '/
Declare Function glfwOpenWindow(ByVal Width As Integer, ByVal height As Integer, ByVal redbits As Integer, ByVal greenbits As Integer, ByVal bluebits As Integer, ByVal alphabits As Integer, ByVal depthbits As Integer, ByVal stencilbits As Integer, ByVal mode As Integer) As Integer
Declare Sub glfwOpenWindowHint(ByVal target As Integer, ByVal hint As Integer)
Declare Sub glfwCloseWindow()
Declare Sub glfwSetWindowTitle(ByVal title As ZString Ptr)
Declare Sub glfwGetWindowSize(ByVal Width As Integer Ptr, ByVal height As Integer Ptr)
Declare Sub glfwSetWindowSize(ByVal Width As Integer, ByVal height As Integer)
Declare Sub glfwSetWindowPos(ByVal x As Integer, ByVal y As Integer)
Declare Sub glfwIconifyWindow()
Declare Sub glfwRestoreWindow()
Declare Sub glfwSwapBuffers()
Declare Sub glfwSwapInterval(ByVal interval As Integer)
Declare Function glfwGetWindowParam(ByVal param As Integer) As Integer
Declare Sub glfwSetWindowSizeCallback(ByVal cbfun As GLFWwindowsizefun)
Declare Sub glfwSetWindowCloseCallback(ByVal cbfun As GLFWwindowclosefun)
Declare Sub glfwSetWindowRefreshCallback(ByVal cbfun As GLFWwindowrefreshfun)

/' Video mode functions '/
Declare Function glfwGetVideoModes(ByVal list As GLFWvidmode Ptr, ByVal maxcount As Integer) As Integer
Declare Sub glfwGetDesktopMode(ByVal mode As GLFWvidmode Ptr)

/' Input handling '/
Declare Sub glfwPollEvents()
Declare Sub glfwWaitEvents()
Declare Function glfwGetKey(ByVal key As Integer) As Integer
Declare Function glfwGetMouseButton(ByVal button As Integer) As Integer
Declare Sub glfwGetMousePos(ByVal xpos As Integer Ptr, ByVal ypos As Integer Ptr)
Declare Sub glfwSetMousePos(ByVal xpos As Integer, ByVal ypos As Integer)
Declare Function glfwGetMouseWheel() As Integer
Declare Sub glfwSetMouseWheel(ByVal Pos As Integer)
Declare Sub glfwSetKeyCallback(ByVal cbfun As GLFWkeyfun)
Declare Sub glfwSetCharCallback(ByVal cbfun As GLFWcharfun)
Declare Sub glfwSetMouseButtonCallback(ByVal cbfun As GLFWmousebuttonfun)
Declare Sub glfwSetMousePosCallback(ByVal cbfun As GLFWmouseposfun)
Declare Sub glfwSetMouseWheelCallback(ByVal cbfun As GLFWmousewheelfun)

/' Joystick input '/
Declare Function glfwGetJoystickParam(ByVal joy As Integer, ByVal param As Integer) As Integer
Declare Function glfwGetJoystickPos(ByVal joy As Integer, ByVal Pos As Single Ptr, ByVal numaxes As Integer) As Integer
Declare Function glfwGetJoystickButtons(ByVal joy As Integer, ByVal buttons As UByte Ptr, ByVal numbuttons As Integer) As Integer

/' Time '/
Declare Function glfwGetTime() As Double
Declare Sub glfwSetTime(ByVal Time As Double)
Declare Sub glfwSleep(ByVal Time As Double)

/' Extension support '/
Declare Function glfwExtensionSupported(ByVal extension As ZString Ptr) As Integer
Declare Function glfwGetProcAddress(ByVal procname As ZString Ptr) As Any Ptr
Declare Sub glfwGetGLVersion(ByVal major As Integer Ptr, ByVal minor As Integer Ptr, ByVal rev As Integer Ptr)

/' Threading support '/
Declare Function glfwCreateThread(ByVal fun As GLFWthreadfun, ByVal arg As Any Ptr) As GLFWthread
Declare Sub glfwDestroyThread(ByVal ID As GLFWthread)
Declare Function glfwWaitThread(ByVal ID As GLFWthread, ByVal waitmode As Integer) As Integer
Declare Function glfwGetThreadID() As GLFWthread
Declare Function glfwCreateMutex() As GLFWmutex
Declare Sub glfwDestroyMutex(ByVal mutex As GLFWmutex)
Declare Sub glfwLockMutex(ByVal mutex As GLFWmutex)
Declare Sub glfwUnlockMutex(ByVal mutex As GLFWmutex)
Declare Function glfwCreateCond() As GLFWcond
Declare Sub glfwDestroyCond(ByVal cond As GLFWcond)
Declare Sub glfwWaitCond(ByVal cond As GLFWcond, ByVal mutex As GLFWmutex, ByVal timeout As Double)
Declare Sub glfwSignalCond(ByVal cond As GLFWcond)
Declare Sub glfwBroadcastCond(ByVal cond As GLFWcond)
Declare Function glfwGetNumberOfProcessors() As Integer

/' Enable/disable functions '/
Declare Sub glfwEnable(ByVal token As Integer)
Declare Sub glfwDisable(ByVal token As Integer)

/' Image/texture I/O support '/
Declare Function glfwReadImage(ByVal Name As ZString Ptr, ByVal img As GLFWimage Ptr, ByVal flags As Integer) As Integer
Declare Function glfwReadMemoryImage(ByVal Data As Any Ptr, ByVal size As Long, ByVal img As GLFWimage Ptr, ByVal flags As Integer) As Integer
Declare Sub glfwFreeImage(ByVal img As GLFWimage Ptr)
Declare Function glfwLoadTexture2D(ByVal Name As ZString Ptr, ByVal flags As Integer) As Integer
Declare Function glfwLoadMemoryTexture2D(ByVal Data As Any Ptr, ByVal size As Long, ByVal flags As Integer) As Integer
Declare Function glfwLoadTextureImage2D(ByVal img As GLFWimage Ptr, ByVal flags As Integer) As Integer

End Extern

#EndIf /' __glfw_bi__ '/

