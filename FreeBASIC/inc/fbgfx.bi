''
'' FreeBASIC gfx library constants
''
#ifndef __fbgfx_bi__
#define __fbgfx_bi__

#inclib "fbgfx"
#ifdef __FB_WIN32__
	#inclib "gdi32"
	#inclib "winmm"
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
'' OpenGL options
#define GFX_STENCIL_BUFFER	&h10000
#define GFX_ACCUMULATION_BUFFER	&h20000


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
