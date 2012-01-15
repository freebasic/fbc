#ifndef  __FREEGLUT_STD_BI__
#define  __FREEGLUT_STD_BI__

/'
 * freeglut_std.h
 *
 * The GLUT-compatible part of the freeglut library include file
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
 * Under windows, we have to differentiate between static and dynamic libraries
 '/
#Ifdef __FB_WIN32__

#Inclib "glu32"
#Inclib "opengl32"
#Inclib "gdi32"
#Inclib "winmm"
#Inclib "user32"

/' Windows static library '/
#Ifdef FREEGLUT_STATIC
#Inclib "freeglut_static"
#Inclib "advapi32"
#Define GLUTCALL Cdecl

/' Windows shared library (DLL) '/
#Else
#Inclib "freeglut"
#Define GLUTCALL StdCall
#EndIf

' Unix
#ElseIf Defined(__FB_UNIX__)
#Inclib "glut"
#Define GLUTCALL Cdecl
#EndIf

' Other
#Else
#Inclib "freeglut"
#Define GLUTCALL Cdecl
#EndIf


/'
 * The freeglut and GLUT API versions
 '/
#define  FREEGLUT             1
#define  GLUT_API_VERSION     4
#define  FREEGLUT_VERSION_2_0 1
#define  GLUT_XLIB_IMPLEMENTATION 13

/'
 * Always include OpenGL and GLU headers
 '/
#include "GL/gl.bi"
#include "GL/glu.bi"

/'
 * GLUT API macro definitions -- the special key codes:
 '/
#define  GLUT_KEY_F1                        &h0001
#define  GLUT_KEY_F2                        &h0002
#define  GLUT_KEY_F3                        &h0003
#define  GLUT_KEY_F4                        &h0004
#define  GLUT_KEY_F5                        &h0005
#define  GLUT_KEY_F6                        &h0006
#define  GLUT_KEY_F7                        &h0007
#define  GLUT_KEY_F8                        &h0008
#define  GLUT_KEY_F9                        &h0009
#define  GLUT_KEY_F10                       &h000A
#define  GLUT_KEY_F11                       &h000B
#define  GLUT_KEY_F12                       &h000C
#define  GLUT_KEY_LEFT                      &h0064
#define  GLUT_KEY_UP                        &h0065
#define  GLUT_KEY_RIGHT                     &h0066
#define  GLUT_KEY_DOWN                      &h0067
#define  GLUT_KEY_PAGE_UP                   &h0068
#define  GLUT_KEY_PAGE_DOWN                 &h0069
#define  GLUT_KEY_HOME                      &h006A
#define  GLUT_KEY_END                       &h006B
#define  GLUT_KEY_INSERT                    &h006C

/'
 * GLUT API macro definitions -- mouse state definitions
 '/
#define  GLUT_LEFT_BUTTON                   &h0000
#define  GLUT_MIDDLE_BUTTON                 &h0001
#define  GLUT_RIGHT_BUTTON                  &h0002
#define  GLUT_DOWN                          &h0000
#define  GLUT_UP                            &h0001
#define  GLUT_LEFT                          &h0000
#define  GLUT_ENTERED                       &h0001

/'
 * GLUT API macro definitions -- the display mode definitions
 '/
#define  GLUT_RGB                           &h0000
#define  GLUT_RGBA                          &h0000
#define  GLUT_INDEX                         &h0001
#define  GLUT_SINGLE                        &h0000
#define  GLUT_DOUBLE                        &h0002
#define  GLUT_ACCUM                         &h0004
#define  GLUT_ALPHA                         &h0008
#define  GLUT_DEPTH                         &h0010
#define  GLUT_STENCIL                       &h0020
#define  GLUT_MULTISAMPLE                   &h0080
#define  GLUT_STEREO                        &h0100
#define  GLUT_LUMINANCE                     &h0200

/'
 * GLUT API macro definitions -- windows and menu related definitions
 '/
#define  GLUT_MENU_NOT_IN_USE               &h0000
#define  GLUT_MENU_IN_USE                   &h0001
#define  GLUT_NOT_VISIBLE                   &h0000
#define  GLUT_VISIBLE                       &h0001
#define  GLUT_HIDDEN                        &h0000
#define  GLUT_FULLY_RETAINED                &h0001
#define  GLUT_PARTIALLY_RETAINED            &h0002
#define  GLUT_FULLY_COVERED                 &h0003

/'
 * GLUT API macro definitions -- fonts definitions
 *
 * Steve Baker suggested to make it binary compatible with GLUT:
 '/
#Define GLUT_STROKE_ROMAN           Cast(Any Ptr, &h0000)
#Define GLUT_STROKE_MONO_ROMAN      Cast(Any Ptr, &h0001)
#Define GLUT_BITMAP_9_BY_15         Cast(Any Ptr, &h0002)
#Define GLUT_BITMAP_8_BY_13         Cast(Any Ptr, &h0003)
#Define GLUT_BITMAP_TIMES_ROMAN_10  Cast(Any Ptr, &h0004)
#Define GLUT_BITMAP_TIMES_ROMAN_24  Cast(Any Ptr, &h0005)
#Define GLUT_BITMAP_HELVETICA_10    Cast(Any Ptr, &h0006)
#Define GLUT_BITMAP_HELVETICA_12    Cast(Any Ptr, &h0007)
#Define GLUT_BITMAP_HELVETICA_18    Cast(Any Ptr, &h0008)

/'
 * GLUT API macro definitions -- the glutGet parameters
 '/
#define  GLUT_WINDOW_X                      &h0064
#define  GLUT_WINDOW_Y                      &h0065
#define  GLUT_WINDOW_WIDTH                  &h0066
#define  GLUT_WINDOW_HEIGHT                 &h0067
#define  GLUT_WINDOW_BUFFER_SIZE            &h0068
#define  GLUT_WINDOW_STENCIL_SIZE           &h0069
#define  GLUT_WINDOW_DEPTH_SIZE             &h006A
#define  GLUT_WINDOW_RED_SIZE               &h006B
#define  GLUT_WINDOW_GREEN_SIZE             &h006C
#define  GLUT_WINDOW_BLUE_SIZE              &h006D
#define  GLUT_WINDOW_ALPHA_SIZE             &h006E
#define  GLUT_WINDOW_ACCUM_RED_SIZE         &h006F
#define  GLUT_WINDOW_ACCUM_GREEN_SIZE       &h0070
#define  GLUT_WINDOW_ACCUM_BLUE_SIZE        &h0071
#define  GLUT_WINDOW_ACCUM_ALPHA_SIZE       &h0072
#define  GLUT_WINDOW_DOUBLEBUFFER           &h0073
#define  GLUT_WINDOW_RGBA                   &h0074
#define  GLUT_WINDOW_PARENT                 &h0075
#define  GLUT_WINDOW_NUM_CHILDREN           &h0076
#define  GLUT_WINDOW_COLORMAP_SIZE          &h0077
#define  GLUT_WINDOW_NUM_SAMPLES            &h0078
#define  GLUT_WINDOW_STEREO                 &h0079
#define  GLUT_WINDOW_CURSOR                 &h007A

#define  GLUT_SCREEN_WIDTH                  &h00C8
#define  GLUT_SCREEN_HEIGHT                 &h00C9
#define  GLUT_SCREEN_WIDTH_MM               &h00CA
#define  GLUT_SCREEN_HEIGHT_MM              &h00CB
#define  GLUT_MENU_NUM_ITEMS                &h012C
#define  GLUT_DISPLAY_MODE_POSSIBLE         &h0190
#define  GLUT_INIT_WINDOW_X                 &h01F4
#define  GLUT_INIT_WINDOW_Y                 &h01F5
#define  GLUT_INIT_WINDOW_WIDTH             &h01F6
#define  GLUT_INIT_WINDOW_HEIGHT            &h01F7
#define  GLUT_INIT_DISPLAY_MODE             &h01F8
#define  GLUT_ELAPSED_TIME                  &h02BC
#define  GLUT_WINDOW_FORMAT_ID              &h007B

/'
 * GLUT API macro definitions -- the glutDeviceGet parameters
 '/
#define  GLUT_HAS_KEYBOARD                  &h0258
#define  GLUT_HAS_MOUSE                     &h0259
#define  GLUT_HAS_SPACEBALL                 &h025A
#define  GLUT_HAS_DIAL_AND_BUTTON_BOX       &h025B
#define  GLUT_HAS_TABLET                    &h025C
#define  GLUT_NUM_MOUSE_BUTTONS             &h025D
#define  GLUT_NUM_SPACEBALL_BUTTONS         &h025E
#define  GLUT_NUM_BUTTON_BOX_BUTTONS        &h025F
#define  GLUT_NUM_DIALS                     &h0260
#define  GLUT_NUM_TABLET_BUTTONS            &h0261
#define  GLUT_DEVICE_IGNORE_KEY_REPEAT      &h0262
#define  GLUT_DEVICE_KEY_REPEAT             &h0263
#define  GLUT_HAS_JOYSTICK                  &h0264
#define  GLUT_OWNS_JOYSTICK                 &h0265
#define  GLUT_JOYSTICK_BUTTONS              &h0266
#define  GLUT_JOYSTICK_AXES                 &h0267
#define  GLUT_JOYSTICK_POLL_RATE            &h0268

/'
 * GLUT API macro definitions -- the glutLayerGet parameters
 '/
#define  GLUT_OVERLAY_POSSIBLE              &h0320
#define  GLUT_LAYER_IN_USE                  &h0321
#define  GLUT_HAS_OVERLAY                   &h0322
#define  GLUT_TRANSPARENT_INDEX             &h0323
#define  GLUT_NORMAL_DAMAGED                &h0324
#define  GLUT_OVERLAY_DAMAGED               &h0325

/'
 * GLUT API macro definitions -- the glutVideoResizeGet parameters
 '/
#define  GLUT_VIDEO_RESIZE_POSSIBLE         &h0384
#define  GLUT_VIDEO_RESIZE_IN_USE           &h0385
#define  GLUT_VIDEO_RESIZE_X_DELTA          &h0386
#define  GLUT_VIDEO_RESIZE_Y_DELTA          &h0387
#define  GLUT_VIDEO_RESIZE_WIDTH_DELTA      &h0388
#define  GLUT_VIDEO_RESIZE_HEIGHT_DELTA     &h0389
#define  GLUT_VIDEO_RESIZE_X                &h038A
#define  GLUT_VIDEO_RESIZE_Y                &h038B
#define  GLUT_VIDEO_RESIZE_WIDTH            &h038C
#define  GLUT_VIDEO_RESIZE_HEIGHT           &h038D

/'
 * GLUT API macro definitions -- the glutUseLayer parameters
 '/
#define  GLUT_NORMAL                        &h0000
#define  GLUT_OVERLAY                       &h0001

/'
 * GLUT API macro definitions -- the glutGetModifiers parameters
 '/
#define  GLUT_ACTIVE_SHIFT                  &h0001
#define  GLUT_ACTIVE_CTRL                   &h0002
#define  GLUT_ACTIVE_ALT                    &h0004

/'
 * GLUT API macro definitions -- the glutSetCursor parameters
 '/
#define  GLUT_CURSOR_RIGHT_ARROW            &h0000
#define  GLUT_CURSOR_LEFT_ARROW             &h0001
#define  GLUT_CURSOR_INFO                   &h0002
#define  GLUT_CURSOR_DESTROY                &h0003
#define  GLUT_CURSOR_HELP                   &h0004
#define  GLUT_CURSOR_CYCLE                  &h0005
#define  GLUT_CURSOR_SPRAY                  &h0006
#define  GLUT_CURSOR_WAIT                   &h0007
#define  GLUT_CURSOR_TEXT                   &h0008
#define  GLUT_CURSOR_CROSSHAIR              &h0009
#define  GLUT_CURSOR_UP_DOWN                &h000A
#define  GLUT_CURSOR_LEFT_RIGHT             &h000B
#define  GLUT_CURSOR_TOP_SIDE               &h000C
#define  GLUT_CURSOR_BOTTOM_SIDE            &h000D
#define  GLUT_CURSOR_LEFT_SIDE              &h000E
#define  GLUT_CURSOR_RIGHT_SIDE             &h000F
#define  GLUT_CURSOR_TOP_LEFT_CORNER        &h0010
#define  GLUT_CURSOR_TOP_RIGHT_CORNER       &h0011
#define  GLUT_CURSOR_BOTTOM_RIGHT_CORNER    &h0012
#define  GLUT_CURSOR_BOTTOM_LEFT_CORNER     &h0013
#define  GLUT_CURSOR_INHERIT                &h0064
#define  GLUT_CURSOR_NONE                   &h0065
#define  GLUT_CURSOR_FULL_CROSSHAIR         &h0066

/'
 * GLUT API macro definitions -- RGB color component specification definitions
 '/
#define  GLUT_RED                           &h0000
#define  GLUT_GREEN                         &h0001
#define  GLUT_BLUE                          &h0002

/'
 * GLUT API macro definitions -- additional keyboard and joystick definitions
 '/
#define  GLUT_KEY_REPEAT_OFF                &h0000
#define  GLUT_KEY_REPEAT_ON                 &h0001
#define  GLUT_KEY_REPEAT_DEFAULT            &h0002

#define  GLUT_JOYSTICK_BUTTON_A             &h0001
#define  GLUT_JOYSTICK_BUTTON_B             &h0002
#define  GLUT_JOYSTICK_BUTTON_C             &h0004
#define  GLUT_JOYSTICK_BUTTON_D             &h0008

/'
 * GLUT API macro definitions -- game mode definitions
 '/
#define  GLUT_GAME_MODE_ACTIVE              &h0000
#define  GLUT_GAME_MODE_POSSIBLE            &h0001
#define  GLUT_GAME_MODE_WIDTH               &h0002
#define  GLUT_GAME_MODE_HEIGHT              &h0003
#define  GLUT_GAME_MODE_PIXEL_DEPTH         &h0004
#define  GLUT_GAME_MODE_REFRESH_RATE        &h0005
#define  GLUT_GAME_MODE_DISPLAY_CHANGED     &h0006

/'
 * Initialization functions, see fglut_init.c
 '/
Declare Sub glutInit(ByVal pargc As Integer Ptr, ByVal argv As ZString Ptr Ptr)
Declare Sub glutInitWindowPosition(ByVal x As Integer, ByVal y As Integer)
Declare Sub glutInitWindowSize(ByVal width As Integer, ByVal height As Integer)
Declare Sub glutInitDisplayMode(ByVal displayMode As UInteger)
Declare Sub glutInitDisplayString(ByVal displayMode As ZString Ptr)

/'
 * Process loop function, see freeglut_main.c
 '/
Declare Sub glutMainLoop()

/'
 * Window management functions, see freeglut_window.c
 '/
Declare Function glutCreateWindow(ByVal title As ZString Ptr) As Integer
Declare Function glutCreateSubWindow(ByVal window As Integer, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As Integer
Declare Sub glutDestroyWindow(ByVal window As Integer)
Declare Sub glutSetWindow(ByVal window As Integer)
Declare Function glutGetWindow() As Integer
Declare Sub glutSetWindowTitle(ByVal title As ZString Ptr)
Declare Sub glutSetIconTitle(ByVal title As ZString Ptr)
Declare Sub glutReshapeWindow(ByVal width As Integer, ByVal height As Integer)
Declare Sub glutPositionWindow(ByVal x As Integer, ByVal y As Integer)
Declare Sub glutShowWindow()
Declare Sub glutHideWindow()
Declare Sub glutIconifyWindow()
Declare Sub glutPushWindow()
Declare Sub glutPopWindow()
Declare Sub glutFullScreen()

/'
 * Display-connected functions, see freeglut_display.c
 '/
Declare Sub glutPostWindowRedisplay(ByVal window As Integer)
Declare Sub glutPostRedisplay()
Declare Sub glutSwapBuffers()

/'
 * Mouse cursor functions, see freeglut_cursor.c
 '/
Declare Sub glutWarpPointer(ByVal x As Integer, ByVal y As Integer)
Declare Sub glutSetCursor(ByVal cursor As Integer)

/'
 * Overlay stuff, see freeglut_overlay.c
 '/
Declare Sub glutEstablishOverlay()
Declare Sub glutRemoveOverlay()
Declare Sub glutUseLayer(ByVal layer As GLenum)
Declare Sub glutPostOverlayRedisplay()
Declare Sub glutPostWindowOverlayRedisplay(ByVal window As Integer)
Declare Sub glutShowOverlay()
Declare Sub glutHideOverlay()

/'
 * Menu stuff, see freeglut_menu.c
 '/
Declare Function glutCreateMenu(ByVal callback As Sub GLUTCALL (ByVal menu As Integer)) As Integer
Declare Sub glutDestroyMenu(ByVal menu As Integer)
Declare Function glutGetMenu() As Integer
Declare Sub glutSetMenu(ByVal menu As Integer)
Declare Sub glutAddMenuEntry(ByVal label As ZString Ptr, ByVal value As Integer)
Declare Sub glutAddSubMenu(ByVal label As ZString Ptr, ByVal subMenu As Integer)
Declare Sub glutChangeToMenuEntry(ByVal item As Integer, ByVal label As ZString Ptr, ByVal value As Integer)
Declare Sub glutChangeToSubMenu(ByVal item As Integer, ByVal label As ZString Ptr, ByVal value As Integer)
Declare Sub glutRemoveMenuItem(ByVal item As Integer)
Declare Sub glutAttachMenu(ByVal button As Integer)
Declare Sub glutDetachMenu(ByVal button As Integer)

/'
 * Global callback functions, see freeglut_callbacks.c
 '/
Declare Sub glutTimerFunc(ByVal time As UInteger, ByVal callback As Sub GLUTCALL (ByVal As Integer), ByVal value As Integer)
Declare Sub glutIdleFunc(ByVal callback As Sub GLUTCALL ())

/'
 * Window-specific callback functions, see freeglut_callbacks.c
 '/
Declare Sub glutKeyboardFunc(ByVal callback As Sub GLUTCALL (ByVal As UByte, ByVal As Integer, ByVal As Integer))
Declare Sub glutSpecialFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutReshapeFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutVisibilityFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer))
Declare Sub glutDisplayFunc(ByVal callback As Sub GLUTCALL ())
Declare Sub glutMouseFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutMotionFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutPassiveMotionFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutEntryFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer))

Declare Sub glutKeyboardUpFunc(ByVal callback As Sub GLUTCALL (ByVal As UByte, ByVal As Integer, ByVal As Integer))
Declare Sub glutSpecialUpFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutJoystickFunc(ByVal callback As Sub GLUTCALL (ByVal As UInteger, ByVal As Integer, ByVal As Integer, ByVal As Integer), ByVal pollInterval As Integer)
Declare Sub glutMenuStateFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer))
Declare Sub glutMenuStatusFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutOverlayDisplayFunc(ByVal callback As Sub GLUTCALL ())
Declare Sub glutWindowStatusFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer))

Declare Sub glutSpaceballMotionFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutSpaceballRotateFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer))
Declare Sub glutSpaceballButtonFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutButtonBoxFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutDialsFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutTabletMotionFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer))
Declare Sub glutTabletButtonFunc(ByVal callback As Sub GLUTCALL (ByVal As Integer, ByVal As Integer, ByVal As Integer, ByVal As Integer))

/'
 * State setting and retrieval functions, see freeglut_state.c
 '/
Declare Function glutGet(ByVal query As GLenum) As Integer
Declare Function glutDeviceGet(ByVal query As GLenum) As Integer
Declare Function glutGetModifiers() As Integer
Declare Function glutLayerGet(ByVal query As GLenum) As Integer

/'
 * Font stuff, see freeglut_font.c
 '/
Declare Sub glutBitmapCharacter(ByVal font As Any Ptr, ByVal character As Integer)
Declare Function glutBitmapWidth(ByVal font As Any Ptr, ByVal character As Integer) As Integer
Declare Sub glutStrokeCharacter(ByVal font As Any Ptr, ByVal character As Integer)
Declare Function glutStrokeWidth(ByVal font As Any Ptr, ByVal character As Integer) As Integer
Declare Function glutBitmapLength(ByVal font As Any Ptr, ByVal string As ZString Ptr) As Integer
Declare Function glutStrokeLength(ByVal font As Any Ptr, ByVal string As ZString Ptr) As Integer

/'
 * Geometry functions, see freeglut_geometry.c
 '/
Declare Sub glutWireCube(ByVal size As GLdouble)
Declare Sub glutSolidCube(ByVal size As GLdouble)
Declare Sub glutWireSphere(ByVal radius As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub glutSolidSphere(ByVal radius As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub glutWireCone(ByVal base As GLdouble, ByVal height As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)
Declare Sub glutSolidCone(ByVal base As GLdouble, ByVal height As GLdouble, ByVal slices As GLint, ByVal stacks As GLint)

Declare Sub glutWireTorus(ByVal innerRadius As GLdouble, ByVal outerRadius As GLdouble, ByVal sides As GLint, ByVal rings As GLint)
Declare Sub glutSolidTorus(ByVal innerRadius As GLdouble, ByVal outerRadius As GLdouble, ByVal sides As GLint, ByVal rings As GLint)
Declare Sub glutWireDodecahedron()
Declare Sub glutSolidDodecahedron()
Declare Sub glutWireOctahedron()
Declare Sub glutSolidOctahedron()
Declare Sub glutWireTetrahedron()
Declare Sub glutSolidTetrahedron()
Declare Sub glutWireIcosahedron()
Declare Sub glutSolidIcosahedron()

/'
 * Teapot rendering functions, found in freeglut_teapot.c
 '/
Declare Sub glutWireTeapot(ByVal size As GLdouble)
Declare Sub glutSolidTeapot(ByVal size As GLdouble)

/'
 * Game mode functions, see freeglut_gamemode.c
 '/
Declare Sub glutGameModeString(ByVal string As ZString Ptr)
Declare Function glutEnterGameMode() As Integer
Declare Sub glutLeaveGameMode()
Declare Function glutGameModeGet(ByVal query As GLenum) As Integer

/'
 * Video resize functions, see freeglut_videoresize.c
 '/
Declare Function glutVideoResizeGet(ByVal query As GLenum) As Integer
Declare Sub glutSetupVideoResizing()
Declare Sub glutStopVideoResizing()
Declare Sub glutVideoResize(ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub glutVideoPan(ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer)

/'
 * Colormap functions, see freeglut_misc.c
 '/
Declare Sub glutSetColor(ByVal color As Integer, ByVal red As GLfloat, ByVal green As GLfloat, ByVal blue As GLfloat)
Declare Function glutGetColor(ByVal color As Integer, ByVal component As Integer) As GLfloat
Declare Sub glutCopyColormap(ByVal window As Integer)

/'
 * Misc keyboard and joystick functions, see freeglut_misc.c
 '/
Declare Sub glutIgnoreKeyRepeat(ByVal ignore As Integer)
Declare Sub glutSetKeyRepeat(ByVal repeatMode As Integer)
Declare Sub glutForceJoystickFunc()

/'
 * Misc functions, see freeglut_misc.c
 '/
Declare Function glutExtensionSupported(ByVal extension As ZString Ptr) As Integer
Declare Sub glutReportErrors()


End Extern

/'** END OF FILE **'/

#endif /' __FREEGLUT_STD_BI__ '/

