''
''
'' OpenGL Utility Toolkit -- header translation done with help from the SWIG's FB wrapper.
''
'' To be distributed with the FreeBASIC compiler only!
'' 
'' 

#ifndef __glut_bi__
#define __glut_bi__

#ifdef FB__WIN32
#	inclib "glut32"
#elseif defined(FB__LINUX)
#	inclib "glut" 
#elseif defined(FB__DOS)
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
declare sub glutInitDisplayString alias "glutInitDisplayString" (byval string as string)
declare sub glutInitWindowPosition alias "glutInitWindowPosition" (byval x as integer, byval y as integer)
declare sub glutInitWindowSize alias "glutInitWindowSize" (byval width as integer, byval height as integer)
declare sub glutMainLoop alias "glutMainLoop" ()
declare function glutCreateWindow alias "glutCreateWindow" (byval title as string) as integer
declare function glutCreateSubWindow alias "glutCreateSubWindow" (byval win as integer, byval x as integer, byval y as integer, byval width as integer, byval height as integer) as integer
declare sub glutDestroyWindow alias "glutDestroyWindow" (byval win as integer)
declare sub glutPostRedisplay alias "glutPostRedisplay" ()
declare sub glutPostWindowRedisplay alias "glutPostWindowRedisplay" (byval win as integer)
declare sub glutSwapBuffers alias "glutSwapBuffers" ()
declare function glutGetWindow alias "glutGetWindow" () as integer
declare sub glutSetWindow alias "glutSetWindow" (byval win as integer)
declare sub glutSetWindowTitle alias "glutSetWindowTitle" (byval title as string)
declare sub glutSetIconTitle alias "glutSetIconTitle" (byval title as string)
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
declare function glutCreateMenu alias "glutCreateMenu" (byval func as sub(byval as integer)) as integer
declare sub glutDestroyMenu alias "glutDestroyMenu" (byval menu as integer)
declare function glutGetMenu alias "glutGetMenu" () as integer
declare sub glutSetMenu alias "glutSetMenu" (byval menu as integer)
declare sub glutAddMenuEntry alias "glutAddMenuEntry" (byval label as string, byval value as integer)
declare sub glutAddSubMenu alias "glutAddSubMenu" (byval label as string, byval submenu as integer)
declare sub glutChangeToMenuEntry alias "glutChangeToMenuEntry" (byval item as integer, byval label as string, byval value as integer)
declare sub glutChangeToSubMenu alias "glutChangeToSubMenu" (byval item as integer, byval label as string, byval submenu as integer)
declare sub glutRemoveMenuItem alias "glutRemoveMenuItem" (byval item as integer)
declare sub glutAttachMenu alias "glutAttachMenu" (byval button as integer)
declare sub glutDetachMenu alias "glutDetachMenu" (byval button as integer)
declare sub glutDisplayFunc alias "glutDisplayFunc" (byval func as sub())
declare sub glutReshapeFunc alias "glutReshapeFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutKeyboardFunc alias "glutKeyboardFunc" (byval func as sub(byval as ubyte, byval as integer, byval as integer))
declare sub glutMouseFunc alias "glutMouseFunc" (byval func as sub(byval as integer, byval as integer, byval as integer, byval as integer))
declare sub glutMotionFunc alias "glutMotionFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutPassiveMotionFunc alias "glutPassiveMotionFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutEntryFunc alias "glutEntryFunc" (byval func as sub(byval as integer))
declare sub glutVisibilityFunc alias "glutVisibilityFunc" (byval func as sub(byval as integer))
declare sub glutIdleFunc alias "glutIdleFunc" (byval func as sub())
declare sub glutTimerFunc alias "glutTimerFunc" (byval millis as uinteger, byval func as sub(byval as integer), byval value as integer)
declare sub glutMenuStateFunc alias "glutMenuStateFunc" (byval func as sub(byval as integer))
declare sub glutSpecialFunc alias "glutSpecialFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballMotionFunc alias "glutSpaceballMotionFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballRotateFunc alias "glutSpaceballRotateFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutSpaceballButtonFunc alias "glutSpaceballButtonFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutButtonBoxFunc alias "glutButtonBoxFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutDialsFunc alias "glutDialsFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutTabletMotionFunc alias "glutTabletMotionFunc" (byval func as sub(byval as integer, byval as integer))
declare sub glutTabletButtonFunc alias "glutTabletButtonFunc" (byval func as sub(byval as integer, byval as integer, byval as integer, byval as integer))
declare sub glutMenuStatusFunc alias "glutMenuStatusFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutOverlayDisplayFunc alias "glutOverlayDisplayFunc" (byval func as sub())
declare sub glutWindowStatusFunc alias "glutWindowStatusFunc" (byval func as sub(byval as integer))
declare sub glutKeyboardUpFunc alias "glutKeyboardUpFunc" (byval func as sub(byval as ubyte, byval as integer, byval as integer))
declare sub glutSpecialUpFunc alias "glutSpecialUpFunc" (byval func as sub(byval as integer, byval as integer, byval as integer))
declare sub glutJoystickFunc alias "glutJoystickFunc" (byval func as sub(byval as uinteger, byval as integer, byval as integer, byval as integer), byval pollInterval as integer)
declare sub glutSetColor alias "glutSetColor" (byval as integer, byval red as GLfloat, byval green as GLfloat, byval blue as GLfloat)
declare function glutGetColor alias "glutGetColor" (byval ndx as integer, byval component as integer) as GLfloat
declare sub glutCopyColormap alias "glutCopyColormap" (byval win as integer)
declare function glutGet alias "glutGet" (byval type as GLenum) as integer
declare function glutDeviceGet alias "glutDeviceGet" (byval type as GLenum) as integer
declare function glutExtensionSupported alias "glutExtensionSupported" (byval name as string) as integer
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
declare sub glutGameModeString alias "glutGameModeString" (byval string as string)
declare function glutEnterGameMode alias "glutEnterGameMode" () as integer
declare sub glutLeaveGameMode alias "glutLeaveGameMode" ()
declare function glutGameModeGet alias "glutGameModeGet" (byval mode as GLenum) as integer

#endif
