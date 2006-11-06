''
'' FreeBASIC gfx library constants
''
#ifndef __fbgfx_bi__
#define __fbgfx_bi__

#inclib "fbgfx"
#ifdef __FB_WIN32__
	#inclib "gdi32"
	#inclib "winmm"
	#inclib "user32"
#elseif defined(__FB_LINUX__)
	#libpath "/usr/X11R6/lib"
	#inclib "X11"
	#inclib "Xext"
	#inclib "Xpm"
	#inclib "Xrandr"
	#inclib "Xrender"
	#inclib "pthread"
#endif


'' Flags accepted by SCREEN and SCREENRES
''
'' Usage examples:
''	SCREEN 14, 16,, GFX_FULLSCREEN
''	SCREEN 18, 32,, GFX_OPENGL OR GFX_STENCIL_BUFFER
''
#define GFX_NULL		-1
#define GFX_WINDOWED		&h00
#define GFX_FULLSCREEN		&h01
#define GFX_OPENGL		&h02
#define GFX_NO_SWITCH		&h04
#define GFX_NO_FRAME		&h08
#define GFX_SHAPED_WINDOW	&h10
#define GFX_ALWAYS_ON_TOP	&h20
#define GFX_ALPHA_PRIMITIVES	&h40
'' OpenGL options
#define GFX_STENCIL_BUFFER	&h10000
#define GFX_ACCUMULATION_BUFFER	&h20000
#define GFX_MULTISAMPLE		&h40000


'' Constants accepted by SCREENCONTROL
''
#define GET_WINDOW_POS				0
#define GET_WINDOW_TITLE			1
#define GET_WINDOW_HANDLE			2
#define GET_DESKTOP_SIZE			3
#define GET_SCREEN_SIZE				4
#define GET_SCREEN_DEPTH			5
#define GET_SCREEN_BPP				6
#define GET_SCREEN_PITCH			7
#define GET_SCREEN_REFRESH			8
#define GET_DRIVER_NAME				9
#define GET_TRANSPARENT_COLOR		10
#define GET_VIEWPORT				11
#define GET_PEN_POS					12
#define GET_COLOR					13
''
#define SET_WINDOW_POS				100
#define SET_WINDOW_TITLE			101
#define SET_PEN_POS					102


'' Color values for transparency
''
#define MASK_COLOR_INDEX	0
#define MASK_COLOR		&hFF00FF


'' Event type IDs
''
#define EVENT_KEY_PRESS				1
#define EVENT_KEY_RELEASE			2
#define EVENT_KEY_REPEAT			3
#define EVENT_MOUSE_MOVE			4
#define EVENT_MOUSE_BUTTON_PRESS	5
#define EVENT_MOUSE_BUTTON_RELEASE	6
#define EVENT_MOUSE_WHEEL			7
#define EVENT_MOUSE_ENTER			8
#define EVENT_MOUSE_EXIT			9
#define EVENT_WINDOW_GOT_FOCUS		10
#define EVENT_WINDOW_LOST_FOCUS		11
#define EVENT_WINDOW_CLOSE			12


type EVENT field = 1
	type as integer
	union
		type
			scancode as integer
			ascii as integer
		end type
		type
			x as integer
			y as integer
			dx as integer
			dy as integer
		end type
		button as integer
		z as integer
	end union
end type


'' Image buffer header, old style
''
type _OLD_HEADER field = 1
	bpp : 3 as ushort
	width : 13 as ushort
	height as ushort
end type


'' Image buffer header, new style (incorporates old header)
''
type PUT_HEADER field = 1
	union
		old as _OLD_HEADER
		type as uinteger
	end union
	bpp as integer
	width as uinteger
	height as uinteger
	pitch as uinteger
	_reserved(1 to 12) as ubyte
end type


'' Constant identifying new style headers
'' (header.type must be equal to this value in new style headers)
''
#define PUT_HEADER_NEW		&h7


'' Mouse button constants to be used with GETMOUSE
''
#define BUTTON_LEFT		&h1
#define BUTTON_RIGHT		&h2
#define BUTTON_MIDDLE		&h4


'' Keyboard scancodes returned by MULTIKEY
''
#define SC_ESCAPE		&h01
#define SC_1			&h02
#define SC_2			&h03
#define SC_3			&h04
#define SC_4			&h05
#define SC_5			&h06
#define SC_6			&h07
#define SC_7			&h08
#define SC_8			&h09
#define SC_9			&h0A
#define SC_0			&h0B
#define SC_MINUS		&h0C
#define SC_EQUALS		&h0D
#define SC_BACKSPACE		&h0E
#define SC_TAB			&h0F
#define SC_Q			&h10
#define SC_W			&h11
#define SC_E			&h12
#define SC_R			&h13
#define SC_T			&h14
#define SC_Y			&h15
#define SC_U			&h16
#define SC_I			&h17
#define SC_O			&h18
#define SC_P			&h19
#define SC_LEFTBRACKET		&h1A
#define SC_RIGHTBRACKET		&h1B
#define SC_ENTER		&h1C
#define SC_CONTROL		&h1D
#define SC_A			&h1E
#define SC_S			&h1F
#define SC_D			&h20
#define SC_F			&h21
#define SC_G			&h22
#define SC_H			&h23
#define SC_J			&h24
#define SC_K			&h25
#define SC_L			&h26
#define SC_SEMICOLON		&h27
#define SC_QUOTE		&h28
#define SC_TILDE		&h29
#define SC_LSHIFT		&h2A
#define SC_BACKSLASH		&h2B
#define SC_Z			&h2C
#define SC_X			&h2D
#define SC_C			&h2E
#define SC_V			&h2F
#define SC_B			&h30
#define SC_N			&h31
#define SC_M			&h32
#define SC_COMMA		&h33
#define SC_PERIOD		&h34
#define SC_SLASH		&h35
#define SC_RSHIFT		&h36
#define SC_MULTIPLY		&h37
#define SC_ALT			&h38
#define SC_SPACE		&h39
#define SC_CAPSLOCK		&h3A
#define SC_F1			&h3B
#define SC_F2			&h3C
#define SC_F3			&h3D
#define SC_F4			&h3E
#define SC_F5			&h3F
#define SC_F6			&h40
#define SC_F7			&h41
#define SC_F8			&h42
#define SC_F9			&h43
#define SC_F10			&h44
#define SC_NUMLOCK		&h45
#define SC_SCROLLLOCK		&h46
#define SC_HOME			&h47
#define SC_UP			&h48
#define SC_PAGEUP		&h49
#define SC_LEFT			&h4B
#define SC_RIGHT		&h4D
#define SC_PLUS			&h4E
#define SC_END			&h4F
#define SC_DOWN			&h50
#define SC_PAGEDOWN		&h51
#define SC_INSERT		&h52
#define SC_DELETE		&h53
#define SC_F11			&h57
#define SC_F12			&h58
#define SC_LWIN			&h7D
#define SC_RWIN			&h7E
#define SC_MENU			&h7F


#endif
