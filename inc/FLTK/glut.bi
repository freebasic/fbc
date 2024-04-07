#include once "gl.bi"
#include once "Fl.bi"
#include once "Fl_Gl_Window.bi"

extern "c++"
type Fl_Glut_Window extends Fl_Gl_Window
private:
	declare sub _init()
	mouse_down as long

protected:
	declare constructor (byref b as const Fl_Glut_Window)
	declare operator let (byref b as const Fl_Glut_Window)

	declare sub draw()
	declare sub draw_overlay()
	declare function handle(as long) as long
public:
	number as long
	menu(2) as long
	declare sub make_current()
	display as sub()
	overlaydisplay as sub()
	reshape as sub(w as long, h as long)
	keyboard as sub(as ubyte, x as long, y as long)
	mouse as sub(b as long, state as long, x as long, y as long)
	motion as sub(x as long, y as long)
	passivemotion as sub(x as long, y as long)
	entry as sub(as long)
	visibility as sub(as long)
	special as sub(as long, x as long, y as long)

	declare constructor(w as long, h as long, as const zstring ptr)
	declare constructor(x as long, y as long, w as long, h as long, as const zstring ptr)
	declare destructor()
end type

end extern

extern "c"
extern glut_window as Fl_Glut_Window ptr
extern glut_menu as long
end extern

extern "c++"
extern glut_idle_function as sub()
extern glut_menustate_function as sub(as long)
extern glut_menustatus_function as sub(as long, as long, as long)

declare sub glutInit(argcp as long ptr, argv as zstring ptr ptr)
declare sub glutInitDisplayMode(mode as unsigned long)

#define GLUT_RGB	FL_RGB
#define GLUT_RGBA	FL_RGB
#define GLUT_INDEX	FL_INDEX
#define GLUT_SINGLE	FL_SINGLE
#define GLUT_DOUBLE	FL_DOUBLE
#define GLUT_ACCUM	FL_ACCUM
#define GLUT_ALPHA	FL_ALPHA
#define GLUT_DEPTH	FL_DEPTH
#define GLUT_STENCIL	FL_STENCIL
#define GLUT_MULTISAMPLE FL_MULTISAMPLE
#define GLUT_STEREO	FL_STEREO

declare sub glutInitWindowPosition(x as long, y as long)
declare sub glutInitWindowSize(w as long, h as long)
declare sub glutMainLoop()
declare function glutCreateWindow(title as zstring ptr) as long
'declare function glutCreateWindow(title as const zstring ptr) as long
declare function glutCreateSubWindow(win as long, x as long, y as long, width_ as long, height as long) as long
declare sub glutDestroyWindow(win as long)

private sub glutPostRedisplay()
	glut_window->redraw()
end sub

declare sub glutPostWindowRedisplay(win as long)
declare sub glutSwapBuffers()

private function glutGetWindow() as long
	return glut_window->number
end function

declare sub glutSetWindow(win as long)

private sub glutSetWindowTitle(t as zstring ptr)
	glut_window->label(t)
end sub

private sub glutSetIconTitle(t as zstring ptr)
	glut_window->iconlabel(t)
end sub

private sub glutPositionWindow(x as long, y as long)
	glut_window->position(x,y)
end sub

private sub glutReshapeWindow(w as long, h as long)
	glut_window->size(w,h)
end sub

private sub glutPopWindow()
	glut_window->show()
end sub

private sub glutPushWindow()
end sub

private sub glutIconifyWindow()
	glut_window->iconize()
end sub

private sub glutShowWindow()
	glut_window->show()
end sub

private sub glutHideWindow()
	glut_window->hide()
end sub

private sub glutFullScreen()
	glut_window->fullscreen()
end sub

private sub glutSetCursor(cursor as Fl_Cursor)
	glut_window->cursor(cursor)
end sub

' notice that the numeric values are different than glut:
#define GLUT_CURSOR_RIGHT_ARROW		(cast(Fl_Cursor,2))
#define GLUT_CURSOR_LEFT_ARROW		(cast(Fl_Cursor,67))
#define GLUT_CURSOR_INFO		FL_CURSOR_HAND
#define GLUT_CURSOR_DESTROY		(cast(Fl_Cursor,45))
#define GLUT_CURSOR_HELP		FL_CURSOR_HELP
#define GLUT_CURSOR_CYCLE		(cast(Fl_Cursor,26))
#define GLUT_CURSOR_SPRAY		(cast(Fl_Cursor,63))
#define GLUT_CURSOR_WAIT		FL_CURSOR_WAIT
#define GLUT_CURSOR_TEXT		FL_CURSOR_INSERT
#define GLUT_CURSOR_CROSSHAIR		FL_CURSOR_CROSS
#define GLUT_CURSOR_UP_DOWN		FL_CURSOR_NS
#define GLUT_CURSOR_LEFT_RIGHT		FL_CURSOR_WE
#define GLUT_CURSOR_TOP_SIDE		FL_CURSOR_N
#define GLUT_CURSOR_BOTTOM_SIDE		FL_CURSOR_S
#define GLUT_CURSOR_LEFT_SIDE		FL_CURSOR_W
#define GLUT_CURSOR_RIGHT_SIDE		FL_CURSOR_E
#define GLUT_CURSOR_TOP_LEFT_CORNER	FL_CURSOR_NW
#define GLUT_CURSOR_TOP_RIGHT_CORNER	FL_CURSOR_NE
#define GLUT_CURSOR_BOTTOM_RIGHT_CORNER	FL_CURSOR_SE
#define GLUT_CURSOR_BOTTOM_LEFT_CORNER	FL_CURSOR_SW
#define GLUT_CURSOR_INHERIT		FL_CURSOR_DEFAULT
#define GLUT_CURSOR_NONE		FL_CURSOR_NONE
#define GLUT_CURSOR_FULL_CROSSHAIR	FL_CURSOR_CROSS

private sub glutWarpPointer(a as long, b as long)
end sub

private sub glutEstablishOverlay()
	glut_window->make_overlay_current()
end sub

private sub glutRemoveOverlay()
	glut_window->hide_overlay()
end sub

private sub glutUseLayer(layer as GLenum)
	if layer then glut_window->make_overlay_current() else glut_window->make_current()
end sub

enum
	GLUT_NORMAL
	GLUT_OVERLAY
end enum

private sub glutPostOverlayRedisplay()
	glut_window->redraw_overlay()
end sub

private sub glutShowOverlay()
	glut_window->redraw_overlay()
end sub

private sub glutHideOverlay()
	glut_window->hide_overlay()
end sub

declare function glutCreateMenu(as sub (as long)) as long

declare sub glutDestroyMenu(menu as long)

private function glutGetMenu() as long
	return glut_menu
end function

private sub glutSetMenu(m as long)
	glut_menu = m
end sub

declare sub glutAddMenuEntry(label as zstring ptr, value as long)

declare sub glutAddSubMenu(label as zstring ptr, submenu as long)

declare sub glutChangeToMenuEntry(item as long, labela as zstring ptr, value as long)

declare sub glutChangeToSubMenu(item as long, label as zstring ptr, submenu as long)

declare sub glutRemoveMenuItem(item as long)

private sub glutAttachMenu(b as long)
	glut_window->menu(b) = glut_menu
end sub

private sub glutDetachMenu(b as long)
	glut_window->menu(b) = 0
end sub

private sub glutDisplayFunc(f as sub())
	glut_window->display = f
end sub

private sub glutReshapeFunc(f as sub(w as long, h as long))
	glut_window->reshape=f
end sub

private sub glutKeyboardFunc(f as sub(key as ubyte, x as long, y as long))
	glut_window->keyboard = f
end sub

private sub glutMouseFunc(f as sub(b as long, state as long, x as long, y as long))
	glut_window->mouse = f
end sub

#define GLUT_LEFT_BUTTON		0
#define GLUT_MIDDLE_BUTTON		1
#define GLUT_RIGHT_BUTTON		2
#define GLUT_DOWN			0
#define GLUT_UP				1

private sub glutMotionFunc(f as sub(x as long, y as long))
	glut_window->motion= f
end sub

private sub glutPassiveMotionFunc(f as sub(x as long, y as long))
	glut_window->passivemotion= f
end sub

private sub glutEntryFunc(f as sub(s as long))
	glut_window->entry = f
end sub

enum
	GLUT_LEFT
	GLUT_ENTERED
end enum

private sub glutVisibilityFunc(f as sub(s as long))
	glut_window->visibility=f
end sub

enum
	GLUT_NOT_VISIBLE
	GLUT_VISIBLE
end enum

declare sub glutIdleFunc(f as sub())

private sub glutTimerFunc(msec as unsigned long, f as sub( as long), value as long)
	Fl.add_timeout(msec*.001, cast(sub(as any ptr),f), cast(any ptr,cast(integer,value))  )
end sub

private sub glutMenuStateFunc(f as sub(state as long))
	glut_menustate_function = f
end sub

private sub glutMenuStatusFunc(f as sub(status as long, x as long, y as long))
	glut_menustatus_function = f
end sub

enum
	GLUT_MENU_NOT_IN_USE
	GLUT_MENU_IN_USE
end enum

private sub glutSpecialFunc(f as sub(key as long, x as long, y as long))
	glut_window->special = f
end sub

#define GLUT_KEY_F1			1
#define GLUT_KEY_F2			2
#define GLUT_KEY_F3			3
#define GLUT_KEY_F4			4
#define GLUT_KEY_F5			5
#define GLUT_KEY_F6			6
#define GLUT_KEY_F7			7
#define GLUT_KEY_F8			8
#define GLUT_KEY_F9			9
#define GLUT_KEY_F10			10
#define GLUT_KEY_F11			11
#define GLUT_KEY_F12			12
' WARNING: Different values than GLUT uses:
#define GLUT_KEY_LEFT			FL_Left
#define GLUT_KEY_UP			FL_Up
#define GLUT_KEY_RIGHT			FL_Right
#define GLUT_KEY_DOWN			FL_Down
#define GLUT_KEY_PAGE_UP		FL_Page_Up
#define GLUT_KEY_PAGE_DOWN		FL_Page_Down
#define GLUT_KEY_HOME			FL_Home
#define GLUT_KEY_END			FL_End
#define GLUT_KEY_INSERT			FL_Insert

private sub glutOverlayDisplayFunc(f as sub())
	glut_window->overlaydisplay = f
end sub

declare function glutGet(type_ as GLenum) as long

enum 
	GLUT_RETURN_ZERO = 0
	GLUT_WINDOW_X
	GLUT_WINDOW_Y
	GLUT_WINDOW_WIDTH
	GLUT_WINDOW_HEIGHT
	GLUT_WINDOW_PARENT
	GLUT_SCREEN_WIDTH
	GLUT_SCREEN_HEIGHT
	GLUT_MENU_NUM_ITEMS
	GLUT_DISPLAY_MODE_POSSIBLE
	GLUT_INIT_WINDOW_X
	GLUT_INIT_WINDOW_Y
	GLUT_INIT_WINDOW_WIDTH
	GLUT_INIT_WINDOW_HEIGHT
	GLUT_INIT_DISPLAY_MODE
	GLUT_WINDOW_BUFFER_SIZE
	GLUT_VERSION
end enum

#define GLUT_WINDOW_STENCIL_SIZE	GL_STENCIL_BITS
#define GLUT_WINDOW_DEPTH_SIZE		GL_DEPTH_BITS
#define GLUT_WINDOW_RED_SIZE		GL_RED_BITS
#define GLUT_WINDOW_GREEN_SIZE		GL_GREEN_BITS
#define GLUT_WINDOW_BLUE_SIZE		GL_BLUE_BITS
#define GLUT_WINDOW_ALPHA_SIZE		GL_ALPHA_BITS
#define GLUT_WINDOW_ACCUM_RED_SIZE	GL_ACCUM_RED_BITS
#define GLUT_WINDOW_ACCUM_GREEN_SIZE	GL_ACCUM_GREEN_BITS
#define GLUT_WINDOW_ACCUM_BLUE_SIZE	GL_ACCUM_BLUE_BITS
#define GLUT_WINDOW_ACCUM_ALPHA_SIZE	GL_ACCUM_ALPHA_BITS
#define GLUT_WINDOW_DOUBLEBUFFER	GL_DOUBLEBUFFER
#define GLUT_WINDOW_RGBA		GL_RGBA
#define GLUT_WINDOW_COLORMAP_SIZE	GL_INDEX_BITS
#ifdef GL_SAMPLES_SGIS
#define GLUT_WINDOW_NUM_SAMPLES	GL_SAMPLES_SGIS
#else
#define GLUT_WINDOW_NUM_SAMPLES	GLUT_RETURN_ZERO
#endif
#define GLUT_WINDOW_STEREO		GL_STEREO

#define GLUT_HAS_KEYBOARD		600
#define GLUT_HAS_MOUSE			601
#define GLUT_HAS_SPACEBALL		602
#define GLUT_HAS_DIAL_AND_BUTTON_BOX	603
#define GLUT_HAS_TABLET			604
#define GLUT_NUM_MOUSE_BUTTONS		605
#define GLUT_NUM_SPACEBALL_BUTTONS	606
#define GLUT_NUM_BUTTON_BOX_BUTTONS	607
#define GLUT_NUM_DIALS			608
#define GLUT_NUM_TABLET_BUTTONS		609
declare function glutDeviceGet(type_ as GLenum) as long

' WARNING: these values are different than GLUT uses:
#define GLUT_ACTIVE_SHIFT               __FL_SHIFT
#define GLUT_ACTIVE_CTRL                __FL_CTRL
#define GLUT_ACTIVE_ALT                 __FL_ALT
private function glutGetModifiers() as long
	return Fl.event_state() and (GLUT_ACTIVE_SHIFT or GLUT_ACTIVE_CTRL or GLUT_ACTIVE_ALT)
end function

declare function glutLayerGet(as GLenum) as long
#define GLUT_OVERLAY_POSSIBLE		800
'#define GLUT_LAYER_IN_USE		801
'#define GLUT_HAS_OVERLAY		802
#define GLUT_TRANSPARENT_INDEX		803
#define GLUT_NORMAL_DAMAGED		804
#define GLUT_OVERLAY_DAMAGED		805

extern "C" 
type GLUTproc as sub()
end extern

declare function glutGetProcAddress(procName as const zstring ptr) as GLUTproc

type Fl_Glut_Bitmap_Font
	font as Fl_Font
	size as Fl_Fontsize
end type

extern as Fl_Glut_Bitmap_Font glutBitmap9By15, glutBitmap8By13, glutBitmapTimesRoman10, glutBitmapTimesRoman24, glutBitmapHelvetica10, glutBitmapHelvetica12, glutBitmapHelvetica18
#define GLUT_BITMAP_9_BY_15             (@glutBitmap9By15)
#define GLUT_BITMAP_8_BY_13             (@glutBitmap8By13)
#define GLUT_BITMAP_TIMES_ROMAN_10      (@glutBitmapTimesRoman10)
#define GLUT_BITMAP_TIMES_ROMAN_24      (@glutBitmapTimesRoman24)
#define GLUT_BITMAP_HELVETICA_10        (@glutBitmapHelvetica10)
#define GLUT_BITMAP_HELVETICA_12        (@glutBitmapHelvetica12)
#define GLUT_BITMAP_HELVETICA_18        (@glutBitmapHelvetica18)

declare sub glutBitmapCharacter(font as any ptr, character as long)
declare function glutBitmapHeight(font as any ptr) as long
declare function glutBitmapLength(font as any ptr, string_ as const ubyte ptr) as long
declare sub glutBitmapString(font as any ptr,  string_ as const ubyte ptr)
declare function glutBitmapWidth(font as any ptr, character as long) as long

declare function glutExtensionSupported(name as zstring ptr) as long

type Fl_Glut_StrokeVertex
	as GLfloat X, Y
end type

type Fl_Glut_StrokeStrip 
	Number as long
	as const Fl_Glut_StrokeVertex ptr Vertices
end type

type Fl_Glut_StrokeChar
	Right_ as GLfloat
	Number as long
	as const Fl_Glut_StrokeStrip ptr Strips
end type

type Fl_Glut_StrokeFont
	Name as zstring ptr
	Quantity as long
	Height as GLfloat 
	as const Fl_Glut_StrokeChar ptr ptr Characters
end type

extern glutStrokeRoman as Fl_Glut_StrokeFont
extern glutStrokeMonoRoman as Fl_Glut_StrokeFont
#define GLUT_STROKE_ROMAN		(@glutStrokeRoman)
#define GLUT_STROKE_MONO_ROMAN		(@glutStrokeMonoRoman)

declare sub glutStrokeCharacter(font as any ptr, character as long)
declare function glutStrokeHeight(font as any ptr) as GLfloat
declare function glutStrokeLength(font as any ptr, string_ as const unsigned byte ptr) as long
declare sub glutStrokeString(font as any ptr, string_ as const unsigned byte ptr)
declare function glutStrokeWidth(font as any ptr, character as long) as long

declare sub glutWireSphere(radius as GLdouble, slices as GLint, stacks as GLint)
declare sub glutSolidSphere(radius as GLdouble , slices as GLint, stacks as GLint)
declare sub glutWireCone(base_ as GLdouble , height as GLdouble , slices as  GLint, stacks as GLint)
declare sub glutSolidCone(base_ as GLdouble, height as GLdouble, slices as  GLint, stacks as  GLint)
declare sub glutWireCube(size as GLdouble)
declare sub glutSolidCube(size as GLdouble)
declare sub glutWireTorus(innerRadius as GLdouble, outerRadius as GLdouble, sides as GLint, rings as  GLint)
declare sub glutSolidTorus(innerRadius as GLdouble, outerRadius as GLdouble, sides as GLint, rings as GLint)
declare sub glutWireDodecahedron()
declare sub glutSolidDodecahedron()
declare sub glutWireTeapot(size as GLdouble)
declare sub glutSolidTeapot(size as GLdouble)
declare sub glutWireOctahedron()
declare sub glutSolidOctahedron()
declare sub glutWireTetrahedron()
declare sub glutSolidTetrahedron()
declare sub glutWireIcosahedron()
declare sub glutSolidIcosahedron()
end extern
