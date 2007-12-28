''
''
'' OpenGL Utility Toolkit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
'' 
'' 

#ifndef __glut_bi__
#define __glut_bi__

#ifdef __FB_WIN32__
#	inclib "glut32"
#elseif defined(__FB_LINUX__)
#	inclib "glut" 
#elseif defined(__FB_DOS__)
#	inclib "GLUT" 
#	inclib "alleg"
#endif

#include once "GL/gl.bi"
#include once "GL/glu.bi"

#define GLUT_API_VERSION 3
#define GLUT_XLIB_IMPLEMENTATION 15
#define GLUT_RGB 0
#define GLUT_RGBA 0
#define GLUT_INDEX 1
#define GLUT_SINGLE 0
#define GLUT_DOUBLE 2
#define GLUT_ACCUM 4
#define GLUT_ALPHA 8
#define GLUT_DEPTH 16
#define GLUT_STENCIL 32
#define GLUT_MULTISAMPLE 128
#define GLUT_STEREO 256
#define GLUT_LUMINANCE 512
#define GLUT_LEFT_BUTTON 0
#define GLUT_MIDDLE_BUTTON 1
#define GLUT_RIGHT_BUTTON 2
#define GLUT_DOWN 0
#define GLUT_UP 1
#define GLUT_KEY_F1 1
#define GLUT_KEY_F2 2
#define GLUT_KEY_F3 3
#define GLUT_KEY_F4 4
#define GLUT_KEY_F5 5
#define GLUT_KEY_F6 6
#define GLUT_KEY_F7 7
#define GLUT_KEY_F8 8
#define GLUT_KEY_F9 9
#define GLUT_KEY_F10 10
#define GLUT_KEY_F11 11
#define GLUT_KEY_F12 12
#define GLUT_KEY_LEFT 100
#define GLUT_KEY_UP 101
#define GLUT_KEY_RIGHT 102
#define GLUT_KEY_DOWN 103
#define GLUT_KEY_PAGE_UP 104
#define GLUT_KEY_PAGE_DOWN 105
#define GLUT_KEY_HOME 106
#define GLUT_KEY_END 107
#define GLUT_KEY_INSERT 108
#define GLUT_LEFT 0
#define GLUT_ENTERED 1
#define GLUT_MENU_NOT_IN_USE 0
#define GLUT_MENU_IN_USE 1
#define GLUT_NOT_VISIBLE 0
#define GLUT_VISIBLE 1
#define GLUT_HIDDEN 0
#define GLUT_FULLY_RETAINED 1
#define GLUT_PARTIALLY_RETAINED 2
#define GLUT_FULLY_COVERED 3
#define GLUT_RED 0
#define GLUT_GREEN 1
#define GLUT_BLUE 2
#define GLUT_WINDOW_X 100
#define GLUT_WINDOW_Y 101
#define GLUT_WINDOW_WIDTH 102
#define GLUT_WINDOW_HEIGHT 103
#define GLUT_WINDOW_BUFFER_SIZE 104
#define GLUT_WINDOW_STENCIL_SIZE 105
#define GLUT_WINDOW_DEPTH_SIZE 106
#define GLUT_WINDOW_RED_SIZE 107
#define GLUT_WINDOW_GREEN_SIZE 108
#define GLUT_WINDOW_BLUE_SIZE 109
#define GLUT_WINDOW_ALPHA_SIZE 110
#define GLUT_WINDOW_ACCUM_RED_SIZE 111
#define GLUT_WINDOW_ACCUM_GREEN_SIZE 112
#define GLUT_WINDOW_ACCUM_BLUE_SIZE 113
#define GLUT_WINDOW_ACCUM_ALPHA_SIZE 114
#define GLUT_WINDOW_DOUBLEBUFFER 115
#define GLUT_WINDOW_RGBA 116
#define GLUT_WINDOW_PARENT 117
#define GLUT_WINDOW_NUM_CHILDREN 118
#define GLUT_WINDOW_COLORMAP_SIZE 119
#define GLUT_WINDOW_NUM_SAMPLES 120
#define GLUT_WINDOW_STEREO 121
#define GLUT_WINDOW_CURSOR 122
#define GLUT_SCREEN_WIDTH 200
#define GLUT_SCREEN_HEIGHT 201
#define GLUT_SCREEN_WIDTH_MM 202
#define GLUT_SCREEN_HEIGHT_MM 203
#define GLUT_MENU_NUM_ITEMS 300
#define GLUT_DISPLAY_MODE_POSSIBLE 400
#define GLUT_INIT_WINDOW_X 500
#define GLUT_INIT_WINDOW_Y 501
#define GLUT_INIT_WINDOW_WIDTH 502
#define GLUT_INIT_WINDOW_HEIGHT 503
#define GLUT_INIT_DISPLAY_MODE 504
#define GLUT_ELAPSED_TIME 700
#define GLUT_WINDOW_FORMAT_ID 123
#define GLUT_HAS_KEYBOARD 600
#define GLUT_HAS_MOUSE 601
#define GLUT_HAS_SPACEBALL 602
#define GLUT_HAS_DIAL_AND_BUTTON_BOX 603
#define GLUT_HAS_TABLET 604
#define GLUT_NUM_MOUSE_BUTTONS 605
#define GLUT_NUM_SPACEBALL_BUTTONS 606
#define GLUT_NUM_BUTTON_BOX_BUTTONS 607
#define GLUT_NUM_DIALS 608
#define GLUT_NUM_TABLET_BUTTONS 609
#define GLUT_DEVICE_IGNORE_KEY_REPEAT 610
#define GLUT_DEVICE_KEY_REPEAT 611
#define GLUT_HAS_JOYSTICK 612
#define GLUT_OWNS_JOYSTICK 613
#define GLUT_JOYSTICK_BUTTONS 614
#define GLUT_JOYSTICK_AXES 615
#define GLUT_JOYSTICK_POLL_RATE 616
#define GLUT_OVERLAY_POSSIBLE 800
#define GLUT_LAYER_IN_USE 801
#define GLUT_HAS_OVERLAY 802
#define GLUT_TRANSPARENT_INDEX 803
#define GLUT_NORMAL_DAMAGED 804
#define GLUT_OVERLAY_DAMAGED 805
#define GLUT_VIDEO_RESIZE_POSSIBLE 900
#define GLUT_VIDEO_RESIZE_IN_USE 901
#define GLUT_VIDEO_RESIZE_X_DELTA 902
#define GLUT_VIDEO_RESIZE_Y_DELTA 903
#define GLUT_VIDEO_RESIZE_WIDTH_DELTA 904
#define GLUT_VIDEO_RESIZE_HEIGHT_DELTA 905
#define GLUT_VIDEO_RESIZE_X 906
#define GLUT_VIDEO_RESIZE_Y 907
#define GLUT_VIDEO_RESIZE_WIDTH 908
#define GLUT_VIDEO_RESIZE_HEIGHT 909
#define GLUT_NORMAL 0
#define GLUT_OVERLAY 1
#define GLUT_ACTIVE_SHIFT 1
#define GLUT_ACTIVE_CTRL 2
#define GLUT_ACTIVE_ALT 4
#define GLUT_CURSOR_RIGHT_ARROW 0
#define GLUT_CURSOR_LEFT_ARROW 1
#define GLUT_CURSOR_INFO 2
#define GLUT_CURSOR_DESTROY 3
#define GLUT_CURSOR_HELP 4
#define GLUT_CURSOR_CYCLE 5
#define GLUT_CURSOR_SPRAY 6
#define GLUT_CURSOR_WAIT 7
#define GLUT_CURSOR_TEXT 8
#define GLUT_CURSOR_CROSSHAIR 9
#define GLUT_CURSOR_UP_DOWN 10
#define GLUT_CURSOR_LEFT_RIGHT 11
#define GLUT_CURSOR_TOP_SIDE 12
#define GLUT_CURSOR_BOTTOM_SIDE 13
#define GLUT_CURSOR_LEFT_SIDE 14
#define GLUT_CURSOR_RIGHT_SIDE 15
#define GLUT_CURSOR_TOP_LEFT_CORNER 16
#define GLUT_CURSOR_TOP_RIGHT_CORNER 17
#define GLUT_CURSOR_BOTTOM_RIGHT_CORNER 18
#define GLUT_CURSOR_BOTTOM_LEFT_CORNER 19
#define GLUT_CURSOR_INHERIT 100
#define GLUT_CURSOR_NONE 101
#define GLUT_CURSOR_FULL_CROSSHAIR 102

declare sub glutInit alias "glutInit" (byref argcp as integer, byref argv as byte ptr)
declare sub glutInitDisplayMode alias "glutInitDisplayMode" (byval mode as uinteger)
declare sub glutInitDisplayString alias "glutInitDisplayString" (byval string as zstring ptr)
declare sub glutInitWindowPosition alias "glutInitWindowPosition" (byval x as integer, byval y as integer)
declare sub glutInitWindowSize alias "glutInitWindowSize" (byval width as integer, byval height as integer)
declare sub glutMainLoop alias "glutMainLoop" ()
declare function glutCreateWindow alias "glutCreateWindow" (byval title as zstring ptr) as integer
declare function glutCreateSubWindow alias "glutCreateSubWindow" (byval win as integer, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as integer
declare sub glutDestroyWindow alias "glutDestroyWindow" (byval win as integer)
declare sub glutPostRedisplay alias "glutPostRedisplay" ()
declare sub glutPostWindowRedisplay alias "glutPostWindowRedisplay" (byval win as integer)
declare sub glutSwapBuffers alias "glutSwapBuffers" ()
declare function glutGetWindow alias "glutGetWindow" () as integer
declare sub glutSetWindow alias "glutSetWindow" (byval win as integer)
declare sub glutSetWindowTitle alias "glutSetWindowTitle" (byval title as zstring ptr)
declare sub glutSetIconTitle alias "glutSetIconTitle" (byval title as zstring ptr)
declare sub glutPositionWindow alias "glutPositionWindow" (byval x as integer, byval y as integer)
declare sub glutReshapeWindow alias "glutReshapeWindow" (byval width as integer, byval height as integer)
declare sub glutPopWindow alias "glutPopWindow" ()
declare sub glutPushWindow alias "glutPushWindow" ()
declare sub glutIconifyWindow alias "glutIconifyWindow" ()
declare sub glutShowWindow alias "glutShowWindow" ()
declare sub glutHideWindow alias "glutHideWindow" ()
declare sub glutFullScreen alias "glutFullScreen" ()
declare sub glutSetCursor alias "glutSetCursor" (byval cursor as integer)
declare sub glutWarpPointer alias "glutWarpPointer" (byval x as integer, byval y as integer)
declare sub glutEstablishOverlay alias "glutEstablishOverlay" ()
declare sub glutRemoveOverlay alias "glutRemoveOverlay" ()
declare sub glutUseLayer alias "glutUseLayer" (byval layer as GLenum)
declare sub glutPostOverlayRedisplay alias "glutPostOverlayRedisplay" ()
declare sub glutPostWindowOverlayRedisplay alias "glutPostWindowOverlayRedisplay" (byval win as integer)
declare sub glutShowOverlay alias "glutShowOverlay" ()
declare sub glutHideOverlay alias "glutHideOverlay" ()
declare function glutCreateMenu alias "glutCreateMenu" (byval func as sub cdecl(byval as integer)) as integer
declare sub glutDestroyMenu alias "glutDestroyMenu" (byval menu as integer)
declare function glutGetMenu alias "glutGetMenu" () as integer
declare sub glutSetMenu alias "glutSetMenu" (byval menu as integer)
declare sub glutAddMenuEntry alias "glutAddMenuEntry" (byval label as zstring ptr, byval value as integer)
declare sub glutAddSubMenu alias "glutAddSubMenu" (byval label as zstring ptr, byval submenu as integer)
declare sub glutChangeToMenuEntry alias "glutChangeToMenuEntry" (byval item as integer, byval label as zstring ptr, byval value as integer)
declare sub glutChangeToSubMenu alias "glutChangeToSubMenu" (byval item as integer, byval label as zstring ptr, byval submenu as integer)
declare sub glutRemoveMenuItem alias "glutRemoveMenuItem" (byval item as integer)
declare sub glutAttachMenu alias "glutAttachMenu" (byval button as integer)
declare sub glutDetachMenu alias "glutDetachMenu" (byval button as integer)
declare sub glutDisplayFunc alias "glutDisplayFunc" (byval func as sub cdecl())
declare sub glutReshapeFunc alias "glutReshapeFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutKeyboardFunc alias "glutKeyboardFunc" (byval func as sub cdecl(byval as ubyte, byval as integer, byval as integer))
declare sub glutMouseFunc alias "glutMouseFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer))
declare sub glutMotionFunc alias "glutMotionFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutPassiveMotionFunc alias "glutPassiveMotionFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutEntryFunc alias "glutEntryFunc" (byval func as sub cdecl (byval as integer))
declare sub glutVisibilityFunc alias "glutVisibilityFunc" (byval func as sub cdecl(byval as integer))
declare sub glutIdleFunc alias "glutIdleFunc" (byval func as sub cdecl())
declare sub glutTimerFunc alias "glutTimerFunc" (byval millis as uinteger, byval func as sub cdecl(byval as integer), byval value as integer)
declare sub glutMenuStateFunc alias "glutMenuStateFunc" (byval func as sub cdecl(byval as integer))
declare sub glutSpecialFunc alias "glutSpecialFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballMotionFunc alias "glutSpaceballMotionFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballRotateFunc alias "glutSpaceballRotateFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballButtonFunc alias "glutSpaceballButtonFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutButtonBoxFunc alias "glutButtonBoxFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutDialsFunc alias "glutDialsFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutTabletMotionFunc alias "glutTabletMotionFunc" (byval func as sub cdecl(byval as integer, byval as integer))
declare sub glutTabletButtonFunc alias "glutTabletButtonFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer))
declare sub glutMenuStatusFunc alias "glutMenuStatusFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutOverlayDisplayFunc alias "glutOverlayDisplayFunc" (byval func as sub cdecl())
declare sub glutWindowStatusFunc alias "glutWindowStatusFunc" (byval func as sub cdecl(byval as integer))
declare sub glutKeyboardUpFunc alias "glutKeyboardUpFunc" (byval func as sub cdecl(byval as ubyte, byval as integer, byval as integer))
declare sub glutSpecialUpFunc alias "glutSpecialUpFunc" (byval func as sub cdecl(byval as integer, byval as integer, byval as integer))
declare sub glutJoystickFunc alias "glutJoystickFunc" (byval func as sub cdecl(byval as uinteger, byval as integer, byval as integer, byval as integer), byval pollInterval as integer)
declare sub glutSetColor alias "glutSetColor" (byval as integer, byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare function glutGetColor alias "glutGetColor" (byval ndx as integer, byval component as integer) as GLfloat
declare sub glutCopyColormap alias "glutCopyColormap" (byval win as integer)
declare function glutGet alias "glutGet" (byval type as GLenum) as integer
declare function glutDeviceGet alias "glutDeviceGet" (byval type as GLenum) as integer
declare function glutExtensionSupported alias "glutExtensionSupported" (byval name as zstring ptr) as integer
declare function glutGetModifiers alias "glutGetModifiers" () as integer
declare function glutLayerGet alias "glutLayerGet" (byval type as GLenum) as integer
declare sub glutBitmapCharacter alias "glutBitmapCharacter" (byval font as any ptr, byval character as integer)
declare function glutBitmapWidth alias "glutBitmapWidth" (byval font as any ptr, byval character as integer) as integer
declare sub glutStrokeCharacter alias "glutStrokeCharacter" (byval font as any ptr, byval character as integer)
declare function glutStrokeWidth alias "glutStrokeWidth" (byval font as any ptr, byval character as integer) as integer
declare function glutBitmapLength alias "glutBitmapLength" (byval font as any ptr, byval string as ubyte ptr) as integer
declare function glutStrokeLength alias "glutStrokeLength" (byval font as any ptr, byval string as ubyte ptr) as integer
declare sub glutWireSphere alias "glutWireSphere" (byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidSphere alias "glutSolidSphere" (byval radius as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutWireCone alias "glutWireCone" (byval base as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutSolidCone alias "glutSolidCone" (byval base as GLdouble, byval height as GLdouble, byval slices as GLint, byval stacks as GLint)
declare sub glutWireCube alias "glutWireCube" (byval size as GLdouble)
declare sub glutSolidCube alias "glutSolidCube" (byval size as GLdouble)
declare sub glutWireTorus alias "glutWireTorus" (byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval sides as GLint, byval rings as GLint)
declare sub glutSolidTorus alias "glutSolidTorus" (byval innerRadius as GLdouble, byval outerRadius as GLdouble, byval sides as GLint, byval rings as GLint)
declare sub glutWireDodecahedron alias "glutWireDodecahedron" ()
declare sub glutSolidDodecahedron alias "glutSolidDodecahedron" ()
declare sub glutWireTeapot alias "glutWireTeapot" (byval size as GLdouble)
declare sub glutSolidTeapot alias "glutSolidTeapot" (byval size as GLdouble)
declare sub glutWireOctahedron alias "glutWireOctahedron" ()
declare sub glutSolidOctahedron alias "glutSolidOctahedron" ()
declare sub glutWireTetrahedron alias "glutWireTetrahedron" ()
declare sub glutSolidTetrahedron alias "glutSolidTetrahedron" ()
declare sub glutWireIcosahedron alias "glutWireIcosahedron" ()
declare sub glutSolidIcosahedron alias "glutSolidIcosahedron" ()
declare function glutVideoResizeGet alias "glutVideoResizeGet" (byval param as GLenum) as integer
declare sub glutSetupVideoResizing alias "glutSetupVideoResizing" ()
declare sub glutStopVideoResizing alias "glutStopVideoResizing" ()
declare sub glutVideoResize alias "glutVideoResize" (byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub glutVideoPan alias "glutVideoPan" (byval x as integer, byval y as integer, byval width as integer, byval height as integer)
declare sub glutReportErrors alias "glutReportErrors" ()

#define GLUT_KEY_REPEAT_OFF 0
#define GLUT_KEY_REPEAT_ON 1
#define GLUT_KEY_REPEAT_DEFAULT 2
#define GLUT_JOYSTICK_BUTTON_A 1
#define GLUT_JOYSTICK_BUTTON_B 2
#define GLUT_JOYSTICK_BUTTON_C 4
#define GLUT_JOYSTICK_BUTTON_D 8

declare sub glutIgnoreKeyRepeat alias "glutIgnoreKeyRepeat" (byval ignore as integer)
declare sub glutSetKeyRepeat alias "glutSetKeyRepeat" (byval repeatMode as integer)
declare sub glutForceJoystickFunc alias "glutForceJoystickFunc" ()

#define GLUT_GAME_MODE_ACTIVE 0
#define GLUT_GAME_MODE_POSSIBLE 1
#define GLUT_GAME_MODE_WIDTH 2
#define GLUT_GAME_MODE_HEIGHT 3
#define GLUT_GAME_MODE_PIXEL_DEPTH 4
#define GLUT_GAME_MODE_REFRESH_RATE 5
#define GLUT_GAME_MODE_DISPLAY_CHANGED 6

declare sub glutGameModeString alias "glutGameModeString" (byval string as zstring ptr)
declare function glutEnterGameMode alias "glutEnterGameMode" () as integer
declare sub glutLeaveGameMode alias "glutLeaveGameMode" ()
declare function glutGameModeGet alias "glutGameModeGet" (byval mode as GLenum) as integer

#endif
