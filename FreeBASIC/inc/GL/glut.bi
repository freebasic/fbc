''
'' OpenGL Utility Toolkit include file for FreeBASIC
'' ported by Blitz (blitz@bad-logic.com)
''

'' !!!WRITEME!!! some prototypes missing, any help is welcome

#ifdef FB__WIN32
'$inclib: "glut32"
#elseif defined(FB__LINUX)
'$inclib: "glut" 
#endif

'' Display mode bit masks. 
const GLUT_RGB			    = 0
const GLUT_RGBA			    = GLUT_RGB
const GLUT_INDEX			= 1
const GLUT_SINGLE			= 0
const GLUT_DOUBLE			= 2
const GLUT_ACCUM			= 4
const GLUT_ALPHA			= 8
const GLUT_DEPTH			= 16
const GLUT_STENCIL			= 32

const GLUT_MULTISAMPLE		= 128
const GLUT_STEREO			= 256
const GLUT_LUMINANCE		= 512


'' Mouse buttons. 
const GLUT_LEFT_BUTTON		= 0
const GLUT_MIDDLE_BUTTON	= 1
const GLUT_RIGHT_BUTTON		= 2

'' Mouse button  state. 
const GLUT_DOWN			    = 0
const GLUT_UP				= 1


'' function keys 
const GLUT_KEY_F1			= 1
const GLUT_KEY_F2			= 2
const GLUT_KEY_F3			= 3
const GLUT_KEY_F4			= 4
const GLUT_KEY_F5			= 5
const GLUT_KEY_F6			= 6
const GLUT_KEY_F7			= 7
const GLUT_KEY_F8			= 8
const GLUT_KEY_F9			= 9
const GLUT_KEY_F10			= 10
const GLUT_KEY_F11			= 11
const GLUT_KEY_F12			= 12
'' directional keys 
const GLUT_KEY_LEFT			= 100
const GLUT_KEY_UP			= 101
const GLUT_KEY_RIGHT		= 102
const GLUT_KEY_DOWN			= 103
const GLUT_KEY_PAGE_UP		= 104
const GLUT_KEY_PAGE_DOWN	= 105
const GLUT_KEY_HOME			= 106
const GLUT_KEY_END			= 107
const GLUT_KEY_INSERT		= 108


'' GLUT initialization sub-API
declare sub         glutInit _
                    alias "glutInit"               ( argc as integer, _
                                                                  argv as integer )
                                              
declare sub         glutInitDisplayMode _
                    alias "glutInitDisplayMode"    ( byval mode as uinteger )
                                              
declare sub         glutInitWindowPosition _
                    alias "glutInitWindowPosition" ( byval x as integer, _
                                                                  byval y as integer )

declare sub         glutInitWindowSize _
                    alias "glutInitWindowSize"     ( byval xres as integer, _
                                                                  byval yres as integer )

declare sub         glutMainLoop _
                    alias "glutMainLoop"           ( )

'' GLUT window sub-API.
declare sub         glutCreateWindow _
                    alias "glutCreateWindow"       ( byval title as string )
                    
declare sub         glutSwapBuffers	_
                    alias "glutSwapBuffers"        ( )           

declare sub         glutFullScreen _
                    alias "glutFullScreen"         ( )


'' GLUT window callback sub-API.

declare sub         glutDisplayFunc _
                    alias "glutDisplayFunc"        ( byval procaddr as uinteger )
                    
declare sub         glutIdleFunc _
                    alias "glutIdleFunc"        ( byval procaddr as uinteger )

declare sub         glutReshapeFunc _
                    alias "glutReshapeFunc"        ( byval procaddr as uinteger )

declare sub         glutKeyboardFunc _
                    alias "glutKeyboardFunc"       ( byval procaddr as uinteger )

declare sub         glutMouseFunc  _
                    alias "glutMouseFunc"          ( byval procaddr as uinteger )
                    
                    