#ifndef  __FREEGLUT_EXT_BI__
#define  __FREEGLUT_EXT_BI__

/'
 * freeglut_ext.h
 *
 * The non-GLUT-compatible extensions to the freeglut library include file
 *
 * Copyright (c) 1999-2000 Pawel W. Olszta. All Rights Reserved.
 * Written by Pawel W. Olszta, <olszta@sourceforge.net>
 * Creation date: Thu Dec 2 1999
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * PAWEL W. OLSZTA BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 '/

#If Defined(__FB_WIN32__) Or Defined(__FB_CYGWIN__)
#Ifdef FREEGLUT_STATIC
Extern "C"
#Else
Extern "Windows"
#EndIf
#ElseIf Defined(__FB_UNIX__)
Extern "C"
#Else
Extern "C"
#EndIf

/'
 * Additional GLUT Key definitions for the Special key function
 '/
#define GLUT_KEY_NUM_LOCK           &h006D
#define GLUT_KEY_BEGIN              &h006E
#define GLUT_KEY_DELETE             &h006F

/'
 * GLUT API Extension macro definitions -- behaviour when the user clicks on an "x" to close a window
 '/
#define GLUT_ACTION_EXIT                         0
#define GLUT_ACTION_GLUTMAINLOOP_RETURNS         1
#define GLUT_ACTION_CONTINUE_EXECUTION           2

/'
 * Create a new rendering context when the user opens a new window?
 '/
#define GLUT_CREATE_NEW_CONTEXT                  0
#define GLUT_USE_CURRENT_CONTEXT                 1

/'
 * Direct/Indirect rendering context options (has meaning only in Unix/X11)
 '/
#define GLUT_FORCE_INDIRECT_CONTEXT              0
#define GLUT_ALLOW_DIRECT_CONTEXT                1
#define GLUT_TRY_DIRECT_CONTEXT                  2
#define GLUT_FORCE_DIRECT_CONTEXT                3

/'
 * GLUT API Extension macro definitions -- the glutGet parameters
 '/
#define  GLUT_INIT_STATE                    &h007C

#define  GLUT_ACTION_ON_WINDOW_CLOSE        &h01F9

#define  GLUT_WINDOW_BORDER_WIDTH           &h01FA
#define  GLUT_WINDOW_HEADER_HEIGHT          &h01FB

#define  GLUT_VERSION                       &h01FC

#define  GLUT_RENDERING_CONTEXT             &h01FD
#define  GLUT_DIRECT_RENDERING              &h01FE

#define  GLUT_FULL_SCREEN                   &h01FF

/'
 * New tokens for glutInitDisplayMode.
 * Only one GLUT_AUXn bit may be used at a time.
 * Value &h0400 is defined in OpenGLUT.
 '/
#define  GLUT_AUX                           &h1000

#define  GLUT_AUX1                          &h1000
#define  GLUT_AUX2                          &h2000
#define  GLUT_AUX3                          &h4000
#define  GLUT_AUX4                          &h8000

/'
 * Context-related flags, see freeglut_state.c
 '/
#define  GLUT_INIT_MAJOR_VERSION            &h0200
#define  GLUT_INIT_MINOR_VERSION            &h0201
#define  GLUT_INIT_FLAGS                    &h0202
#define  GLUT_INIT_PROFILE                  &h0203

/'
 * Flags for glutInitContextFlags, see freeglut_init.c
 '/
#define  GLUT_DEBUG                         &h0001
#define  GLUT_FORWARD_COMPATIBLE            &h0002


/'
 * Flags for glutInitContextProfile, see freeglut_init.c
 '/
#define GLUT_CORE_PROFILE                   &h0001
#define	GLUT_COMPATIBILITY_PROFILE          &h0002

/'
 * Process loop function, see freeglut_main.c
 '/
Declare Sub glutMainLoopEvent()
Declare Sub glutLeaveMainLoop()
Declare Sub glutExit()

/'
 * Window management functions, see freeglut_window.c
 '/
Declare Sub glutFullScreenToggle()

/'
 * Window-specific callback functions, see freeglut_callbacks.c
 '/
Declare Sub glutMouseWheelFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutCloseFunc(ByVal callback As Sub GLUTCALL ())
Declare Sub glutWMCloseFunc(ByVal callback As Sub GLUTCALL ())
/' A. Donev: Also a destruction callback for menus '/
Declare Sub glutMenuDestroyFunc(ByVal callback As Sub GLUTCALL ())

/'
 * State setting and retrieval functions, see freeglut_state.c
 '/
Declare Sub glutSetOption(ByVal option_flag As GLenum, ByVal value As Integer)
Declare Function glutGetModeValues(ByVal mode As GLenum, ByVal size As Integer Ptr) As Integer Ptr
/' A.Donev: User-data manipulation '/
Declare Function glutGetWindowData() As Any Ptr
Declare Sub glutSetWindowData(ByVal data As Any Ptr)
Declare Function glutGetMenuData() As Any Ptr
Declare Sub glutSetMenuData(ByVal data As Any Ptr)

/'
 * Font stuff, see freeglut_font.c
 '/
Declare Function glutBitmapHeight(ByVal font As Any Ptr) As Integer
Declare Function glutStrokeHeight(ByVal font As Any Ptr) As GLfloat
Declare Sub glutBitmapString(ByVal font As Any Ptr, ByVal string As ZString Ptr)
Declare Sub glutStrokeString(ByVal font As Any Ptr, ByVal string As ZString Ptr)

/'
 * Geometry functions, see freeglut_geometry.c
 '/
Declare Sub glutWireRhombicDodecahedron()
Declare Sub glutSolidRhombicDodecahedron()
Declare Sub glutWireSierpinskiSponge(ByVal num_levels As Integer, ByVal offset As GLdouble Ptr, ByVal scale As GLdouble)
Declare Sub glutSolidSierpinskiSponge(ByVal num_levels As Integer, ByVal offset As GLdouble Ptr, ByVal scale As GLdouble)
Declare Sub glutWireCylinder(ByVal radius As GLdouble, ByVal height As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub glutSolidCylinder(ByVal radius As GLdouble, ByVal height As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)

/'
 * Extension functions, see freeglut_ext.c
 '/
Type GLUTproc As Sub GLUTCALL ()
Declare Function glutGetProcAddress(ByVal procName As ZString Ptr) As GLUTproc

/'
 * Joystick functions, see freeglut_joystick.c
 '/
/' USE OF THESE FUNCTIONS IS DEPRECATED !!!!! '/
/' If you have a serious need for these functions in your application, please either
 * contact the "freeglut" developer community at freeglut-developer@lists.sourceforge.net,
 * switch to the OpenGLUT library, or else port your joystick functionality over to PLIB's
 * "js" library.
 '/
Declare Function glutJoystickGetNumAxes(ByVal ident As Integer) As Integer
Declare Function glutJoystickGetNumButtons(ByVal ident As Integer) As Integer
Declare Function glutJoystickNotWorking(ByVal ident As Integer) As Integer
Declare Function glutJoystickGetDeadBand(ByVal ident As Integer, ByVal axis As Integer) As Single
Declare Sub glutJoystickSetDeadBand(ByVal ident As Integer, ByVal axis As Integer, ByVal db As Single)
Declare Function glutJoystickGetSaturation(ByVal ident As Integer, ByVal axis As Integer)As Single
Declare Sub glutJoystickSetSaturation(ByVal ident As Integer, ByVal axis As Integer, ByVal st As Single)
Declare Sub glutJoystickSetMinRange(ByVal ident As Integer, ByVal axes As Single Ptr)
Declare Sub glutJoystickSetMaxRange(ByVal ident As Integer, ByVal axes As Single Ptr)
Declare Sub glutJoystickSetCenter(ByVal ident As Integer, ByVal axes As Single Ptr)
Declare Sub glutJoystickGetMinRange(ByVal ident As Integer, ByVal axes As Single Ptr)
Declare Sub glutJoystickGetMaxRange(ByVal ident As Integer, ByVal axes As Single Ptr)
Declare Sub glutJoystickGetCenter(ByVal ident As Integer, ByVal axes As Single Ptr)

/'
 * Initialization functions, see freeglut_init.c
 '/
Declare Sub glutInitContextVersion(ByVal majorVersion As Integer, ByVal minorVersion As Integer)
Declare Sub glutInitContextFlags(ByVal flags As Integer)
Declare Sub glutInitContextProfile(ByVal profile As Integer)

/'
 * GLUT API macro definitions -- the display mode definitions
 '/
#define  GLUT_CAPTIONLESS                   &h0400
#define  GLUT_BORDERLESS                    &h0800
#define  GLUT_SRGB                          &h1000


End Extern

/'** END OF FILE **'/

#endif /' __FREEGLUT_EXT_BI__ '/
