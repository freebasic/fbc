'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
' Allegro 4.0 header for freeBASIC
'
' (C) 2004-2005 DrV <i_am_drv@yahoo.com>
'
' based on the Allegro 4.0.3 documentation and headers
'
' released under the same terms as the original Allegro distribution
'


'$include: 'crt.bi'

#define AL_LIB	"alleg"
#define AL_VER	4.0

' -- constants --

' todo ... lots of missing constants

'#define AL_ID(a,b,c,d)			(((a) shl 24) or ((b) shl 16) or ((c) shl 8) or (d))

Const FALSE%				= 0
Const TRUE%				= -1

Const JOY_TYPE_AUTODETECT%		= -1
Const JOY_TYPE_NONE%			= 0

Const MAX_JOYSTICKS%			= 8
Const MAX_JOYSTICK_AXIS%		= 3
Const MAX_JOYSTICK_STICKS%		= 5
Const MAX_JOYSTICK_BUTTONS%		= 32

Const PAL_SIZE%				= 256

Const MIDI_VOICES%			= 64
Const MIDI_TRACKS%			= 32

Const F_BUF_SIZE%			= 4096

Const TIMERS_PER_SECOND%		= 1193181

Const MASK_COLOR_8%			= 0
Const MASK_COLOR_15%			= &H7C1F	' (5.5.5 pink)
Const MASK_COLOR_16%			= &HF81F	' (5.6.5 pink)
Const MASK_COLOR_24%			= &HFF00FF	' (8.8.8 pink)
Const MASK_COLOR_32%			= &HFF00FF	' (8.8.8 pink)

Const fixtorad_r%			= 1608		' 2pi/256
Const radtofix_r%			= 2670177	' 256/2pi


Const SYSTEM_AUTODETECT% = 0

Const GFX_TEXT%				= -1
Const GFX_AUTODETECT%			= 0
Const GFX_AUTODETECT_FULLSCREEN%	= 1
Const GFX_AUTODETECT_WINDOWED%		= 2
Const GFX_SAFE%				= (83 shl 24) or (65 shl 16) or (70 shl 8) or 69 ' AL_ID('S','A','F','E')

Const GFX_CAN_SCROLL%			= &H00000001
Const GFX_CAN_TRIPLE_BUFFER%		= &H00000002
Const GFX_HW_CURSOR%			= &H00000004
Const GFX_HW_HLINE%			= &H00000008
Const GFX_HW_HLINE_XOR%			= &H00000010
Const GFX_HW_HLINE_SOLID_PATTERN%	= &H00000020
Const GFX_HW_HLINE_COPY_PATTERN%	= &H00000040
Const GFX_HW_FILL%			= &H00000080
Const GFX_HW_FILL_XOR%			= &H00000100
Const GFX_HW_FILL_SOLID_PATTERN%	= &H00000200
Const GFX_HW_FILL_COPY_PATTERN%		= &H00000400
Const GFX_HW_LINE%			= &H00000800
Const GFX_HW_LINE_XOR%			= &H00001000
Const GFX_HW_TRIANGLE%			= &H00002000
Const GFX_HW_TRIANGLE_XOR%		= &H00004000
Const GFX_HW_GLYPH%			= &H00008000
Const GFX_HW_VRAM_BLIT%			= &H00010000
Const GFX_HW_VRAM_BLIT_MASKED%		= &H00020000
Const GFX_HW_MEM_BLIT%			= &H00040000
Const GFX_HW_MEM_BLIT_MASKED%		= &H00080000
Const GFX_HW_SYS_TO_VRAM_BLIT%		= &H00100000
Const GFX_HW_SYS_TO_VRAM_BLIT_MASKED%	= &H00200000

' CPU Capabilities flags - set to 0 on non x86 capable chips
Const CPU_ID%				= &H0001
Const CPU_FPU%				= &H0002
Const CPU_MMX%				= &H0004
Const CPU_MMXPLUS%			= &H0008
Const CPU_SSE%				= &H0010
Const CPU_SSE2%				= &H0020
Const CPU_3DNOW%			= &H0040
Const CPU_ENH3DNOW%			= &H0080
Const CPU_CMOV%				= &H0100

Const POLYTYPE_FLAT%			= 0
Const POLYTYPE_GCOL%			= 1
Const POLYTYPE_GRGB%			= 2
Const POLYTYPE_ATEX%			= 3
Const POLYTYPE_PTEX%			= 4
Const POLYTYPE_ATEX_MASK%		= 5
Const POLYTYPE_PTEX_MASK%		= 6
Const POLYTYPE_ATEX_LIT%		= 7
Const POLYTYPE_PTEX_LIT%		= 8
Const POLYTYPE_ATEX_MASK_LIT%		= 9
Const POLYTYPE_PTEX_MASK_LIT%		= 10
Const POLYTYPE_ATEX_TRANS%		= 11
Const POLYTYPE_PTEX_TRANS%		= 12
Const POLYTYPE_ATEX_MASK_TRANS%		= 13
Const POLYTYPE_PTEX_MASK_TRANS%		= 14
Const POLYTYPE_MAX%			= 15
Const POLYTYPE_ZBUF%			= 16


Const KB_SHIFT_FLAG%			= &H0001
Const KB_CTRL_FLAG%			= &H0002
Const KB_ALT_FLAG%			= &H0004
Const KB_LWIN_FLAG%			= &H0008
Const KB_RWIN_FLAG%			= &H0010
Const KB_MENU_FLAG%			= &H0020
Const KB_COMMAND_FLAG%			= &H0040
Const KB_SCROLOCK_FLAG%			= &H0100
Const KB_NUMLOCK_FLAG%			= &H0200
Const KB_CAPSLOCK_FLAG%			= &H0400
Const KB_INALTSEQ_FLAG%			= &H0800
Const KB_ACCENT1_FLAG%			= &H1000
Const KB_ACCENT2_FLAG%			= &H2000
Const KB_ACCENT3_FLAG%			= &H4000
Const KB_ACCENT4_FLAG%			= &H8000

Const KEY_A%				= 1
Const KEY_B%				= 2
Const KEY_C%				= 3
Const KEY_D%				= 4
Const KEY_E%				= 5
Const KEY_F%				= 6
Const KEY_G%				= 7
Const KEY_H%				= 8
Const KEY_I%				= 9
Const KEY_J%				= 10
Const KEY_K%				= 11
Const KEY_L%				= 12
Const KEY_M%				= 13
Const KEY_N%				= 14
Const KEY_O%				= 15
Const KEY_P%				= 16
Const KEY_Q%				= 17
Const KEY_R%				= 18
Const KEY_S%				= 19
Const KEY_T%				= 20
Const KEY_U%				= 21
Const KEY_V%				= 22
Const KEY_W%				= 23
Const KEY_X%				= 24
Const KEY_Y%				= 25
Const KEY_Z%				= 26
Const KEY_0%				= 27
Const KEY_1%				= 28
Const KEY_2%				= 29
Const KEY_3%				= 30
Const KEY_4%				= 31
Const KEY_5%				= 32
Const KEY_6%				= 33
Const KEY_7%				= 34
Const KEY_8%				= 35
Const KEY_9%				= 36
Const KEY_0_PAD%			= 37
Const KEY_1_PAD%			= 38
Const KEY_2_PAD%			= 39
Const KEY_3_PAD%			= 40
Const KEY_4_PAD%			= 41
Const KEY_5_PAD%			= 42
Const KEY_6_PAD%			= 43
Const KEY_7_PAD%			= 44
Const KEY_8_PAD%			= 45
Const KEY_9_PAD%			= 46
Const KEY_F1%				= 47
Const KEY_F2%				= 48
Const KEY_F3%				= 49
Const KEY_F4%				= 50
Const KEY_F5%				= 51
Const KEY_F6%				= 52
Const KEY_F7%				= 53
Const KEY_F8%				= 54
Const KEY_F9%				= 55
Const KEY_F10%				= 56
Const KEY_F11%				= 57
Const KEY_F12%				= 58
Const KEY_ESC%				= 59
Const KEY_TILDE%			= 60
Const KEY_MINUS%			= 61
Const KEY_EQUALS%			= 62
Const KEY_BACKSPACE%			= 63
Const KEY_TAB%				= 64
Const KEY_OPENBRACE%			= 65
Const KEY_CLOSEBRACE%			= 66
Const KEY_ENTER%			= 67
Const KEY_COLON%			= 68
Const KEY_QUOTE%			= 69
Const KEY_BACKSLASH%			= 70
Const KEY_BACKSLASH2%			= 71
Const KEY_COMMA%			= 72
Const KEY_STOP%				= 73
Const KEY_SLASH%			= 74
Const KEY_SPACE%			= 75
Const KEY_INSERT%			= 76
Const KEY_DEL%				= 77
Const KEY_HOME%				= 78
Const KEY_END%				= 79
Const KEY_PGUP%				= 80
Const KEY_PGDN%				= 81
Const KEY_LEFT%				= 82
Const KEY_RIGHT%			= 83
Const KEY_UP%				= 84
Const KEY_DOWN%				= 85
Const KEY_SLASH_PAD%			= 86
Const KEY_ASTERISK%			= 87
Const KEY_MINUS_PAD%			= 88
Const KEY_PLUS_PAD%			= 89
Const KEY_DEL_PAD%			= 90
Const KEY_ENTER_PAD%			= 91
Const KEY_PRTSCR%			= 92
Const KEY_PAUSE%			= 93
Const KEY_ABNT_C1%			= 94
Const KEY_YEN%				= 95
Const KEY_KANA%				= 96
Const KEY_CONVERT%			= 97
Const KEY_NOCONVERT%			= 98
Const KEY_AT%				= 99
Const KEY_CIRCUMFLEX%			= 100
Const KEY_COLON2%			= 101
Const KEY_KANJI%			= 102
Const KEY_EQUALS_PAD%			= 103  ' MacOS X
Const KEY_BACKQUOTE%			= 104  ' MacOS X
Const KEY_SEMICOLON%			= 105  ' MacOS X
Const KEY_COMMAND%			= 106  ' MacOS X
Const KEY_MODIFIERS%			= 107

Const KEY_LSHIFT%			= 107
Const KEY_RSHIFT%			= 108
Const KEY_LCONTROL%			= 109
Const KEY_RCONTROL%			= 110
Const KEY_ALT%				= 111
Const KEY_ALTGR%			= 112
Const KEY_LWIN%				= 113
Const KEY_RWIN%				= 114
Const KEY_MENU%				= 115
Const KEY_SCRLOCK%			= 116
Const KEY_NUMLOCK%			= 117
Const KEY_CAPSLOCK%			= 118

Const KEY_MAX%				= 119


' -- "typedefs" --

#define ZBUFFER BITMAP				' 3D z-buffer type
#define fixed Integer				' 32-bit 16.16 fixed-point type


' -- structures and types --


Type GFX_VTABLE        ' functions for drawing onto bitmaps
	color_depth As Integer
	mask_color As Integer
	unwrite_bank As Integer  ' C function on some machines, asm on i386
	set_clip As Integer
	acquire As Integer
	release As Integer
	create_sub_bitmap As Integer
	created_sub_bitmap As Integer
	getpixel As Integer
	putpixel As Integer
	vline As Integer
	hline As Integer
	hfill As Integer
	draw_line As Integer
	rectfill As Integer
	triangle As Integer
	draw_sprite As Integer
	draw_256_sprite As Integer
	draw_sprite_v_flip As Integer
	draw_sprite_h_flip As Integer
	draw_sprite_vh_flip As Integer
	draw_trans_sprite As Integer
	draw_trans_rgba_sprite As Integer
	draw_lit_sprite As Integer
	draw_rle_sprite As Integer
	draw_trans_rle_sprite As Integer
	draw_trans_rgba_rle_sprite As Integer
	draw_lit_rle_sprite As Integer
	draw_character As Integer
	draw_glyph As Integer
	blit_from_memory As Integer
	blit_to_memory As Integer
	blit_from_system As Integer
	blit_to_system As Integer
	blit_to_self As Integer
	blit_to_self_forward As Integer
	blit_to_self_backward As Integer
	blit_between_formats As Integer
	masked_blit As Integer
	clear_to_color As Integer
	pivot_scaled_sprite_flip As Integer
	draw_sprite_end As Integer
	blit_end As Integer
End Type


Type BITMAP            				' a bitmap structure
	w As Integer				' width and height in pixels
	h as integer
	clip As Integer				' flag if clipping is turned on
	cl As Integer				' clip left, right, top and bottom values
	cr As Integer
	ct As Integer
	cb As Integer
	vtable As GFX_VTABLE Ptr		' drawing functions
	write_bank As Integer 'void *write_bank;' C func on some machines, asm on i386
	read_bank As Integer 'void *read_bank;	' C func on some machines, asm on i386
	dat As Integer Ptr			' the memory we allocated for the bitmap
	id As Unsigned Integer			' for identifying sub-bitmaps
	extra As UByte Ptr			' points to a structure with more info
	x_ofs As Integer			' horizontal offset (for sub-bitmaps)
	y_ofs As Integer			' vertical offset (for sub-bitmaps)
	seg As Integer				' bitmap segment
	line As UByte Ptr 			'ZERO_SIZE_ARRAY(unsigned char *, line);
End Type

Type RLE_SPRITE					' a RLE compressed sprite
	w As Integer				' width and height in pixels
	h As Integer
	color_depth As Integer			' color depth of the image
	size As Integer				' size of sprite data in bytes
	dat As UByte Ptr			' ZERO_SIZE_ARRAY(signed char, dat);
End Type


Type COMPILED_SPRITE_PROC
	draw As Integer Ptr			' routines to draw the image
	length As Integer			' length of the drawing functions - name changed from 'len' in fB
End Type

Type COMPILED_SPRITE				' compiled sprite structure
	planar As Short				' set if it's a planar (mode-X) sprite
	color_depth As Short			' color depth of the image
	w As Short				' size of the sprite
	h As Short
	proc(3) As COMPILED_SPRITE_PROC		' routines to draw the image
End Type

Type JOYSTICK_AXIS_INFO				' information about a single joystick axis
	pos As Integer
	d1 As Integer
	d2 As Integer
	name As UByte Ptr
End Type

Type JOYSTICK_STICK_INFO			' information about one or more axis (a slider or directional control)
	flags As Integer
	num_axis As Integer
	axis(MAX_JOYSTICK_AXIS - 1) As JOYSTICK_AXIS_INFO
	name As UByte Ptr
End Type

Type JOYSTICK_BUTTON_INFO			' information about a joystick button
	b As Integer
	name As UByte Ptr
End Type

Type JOYSTICK_INFO				' information about an entire joystick
	flags As Integer
	num_sticks As Integer
	num_buttons As Integer
	stick(MAX_JOYSTICK_STICKS - 1) As JOYSTICK_STICK_INFO
	button(MAX_JOYSTICK_BUTTONS - 1) As JOYSTICK_BUTTON_INFO
End Type

Type GFX_MODE
	width As Integer
	height As Integer
	bpp As Integer
End Type

Type GFX_MODE_LIST
	num_modes As Integer			' number of gfx modes
	mode As GFX_MODE Ptr			' pointer to the actual mode list array
End Type

Type AL_RGB					' note: this struct is called 'RGB' in Allegro docs
	r As UByte
	g As UByte
	b As UByte
	filler As UByte
End Type

Type AL_PALETTE					' note: AL_RGB is called 'PALETTE' in Allegro docs and is actually a #define for an array (won't work in FB)
	color(PAL_SIZE - 1) As AL_RGB		' fixme - this is broken
End Type

Type V3D					' a 3d point (fixed point version)
	x As fixed				' position
	y As fixed
	z As fixed
	u As fixed				' texture map coordinates
	v As fixed
	c As Integer				' color
End Type

Type V3D_f					' a 3d point (floating point version)
	x As Single				' position
	y As Single
	z As Single
	u As Single				' texture map coordinates
	v As Single
	c As Integer				' color
End Type

Type COLOR_MAP
	data(PAL_SIZE - 1, PAL_SIZE - 1) As UByte
End Type

Type RGB_MAP
	data(31, 31, 31) As UByte
End Type

Type al_ffblk					' file info block for the al_find*() routines
	attrib As Integer			' actual attributes of the file found
   	time As Integer				' modification time of file
	size As Long				' size of file
	name As String * 512			' name of file
	ff_data As UByte Ptr			' private hook
End Type

Type DATAFILE_PROPERTY
	dat As UByte Ptr			' pointer to the data
	p_type As Integer			' property type - note - changed from 'type' in allegro
End Type

Type DATAFILE
	dat As UByte Ptr			' pointer to the data
	type As Integer				' object type
	size As Long				' size of the object
	prop As DATAFILE_PROPERTY Ptr		' object properties
End Type

Type MATRIX					' transformation matrix (fixed point)
	v(2, 2) As fixed			' scaling and rotation
	t(2) As fixed				' translation
End Type

Type MATRIX_f					' transformation matrix (floating point)
	v(2, 2) As Single			' scaling and rotation
	t(2) As Single				' translation
End Type

Type QUAT
	w As Single
	x As Single
	y As Single
	z As Single
End Type

Type DIALOG
	proc As Function(msg As Integer, d As DIALOG Ptr, c As Integer)
	x As Integer				' position and size of the object
	y As Integer
	w As Integer
	h As Integer
	fg As Integer				' foreground and background colors
	bg As Integer
	key As Integer				' keyboard shortcut (ASCII code)
	flags As Integer			' flags about the object state
	d1 As Integer				' any data the object might require
	d2 As Integer
	dp As UByte Ptr				' pointers to more object data
	dp2 As UByte Ptr
	dp3 As UByte Ptr
End Type

Type MENU					' a popup menu
	text As UByte Ptr			' menu item text
	proc As Function()			' callback function
	child As MENU Ptr			' to allow nested menus
	flags As Integer			' flags about the menu state
	dp As UByte Ptr				' any data the menu might require
End Type

Type DIALOG_PLAYER				' stored information about the state of an active GUI dialog
	obj As Integer
	res As Integer
	mouse_obj As Integer
	focus_obj As Integer
	joy_on As Integer
	click_wait As Integer
	mouse_ox As Integer
	mouse_oy As Integer
	mouse_oz As Integer
	mouse_b As Integer
	dialog As DIALOG Ptr
End Type

Type MENU_PLAYER				' stored information about the state of an active GUI menu
	menu As MENU Ptr			' the menu itself
	bar As Integer				' set if it is a top level menu bar
	size As Integer				' number of items in the menu
	sel As Integer				' selected item
	x As Integer				' screen position of the menu
	y As Integer
	w As Integer
	h As Integer
	proc As Function()			' callback function
	saved As BITMAP Ptr			' saved what was underneath it

	mouse_button_was_pressed As Integer	' set if mouse button pressed on last iteration
	back_from_child As Integer		' set if a child was activated on last iteration
	timestamp As Integer			' timestamp for gui_timer events
	mouse_sel As Integer			' item the mouse is currently over
	redraw As Integer			' set if redrawing is required
	auto_open As Integer			' set if menu auto-opening is activated
	ret As Integer				' return value

	dialog As DIALOG Ptr			' d_menu_proc() parent dialog (if any)
	parent As MENU_PLAYER Ptr		' the parent menu, or NULL for root
	child As MENU_PLAYER Ptr		' the child menu, or NULL for none
End Type



Type SAMPLE					' a sample
	bits As Integer				' 8 or 16
	stereo As Integer			' sample type flag
	freq As Integer				' sample frequency
	priority As Integer			' 0-255
	length As Unsigned Long			' length (in samples) - name changed from 'len'
	loop_start As Unsigned Long		' loop start position
	loop_end As Unsigned Long		' loop finish position
	param As Unsigned Long			' for internal use by the driver
	data As UByte Ptr			' sample data
End Type

Type MIDI_TRACK
	data As UByte Ptr			' MIDI message stream
	length As Integer			' length of the track data - name changed from 'len'
End Type

Type MIDI					' a midi file
	divisions As Integer			' number of ticks per quarter note
	track(MIDI_TRACKS - 1) As MIDI_TRACK
End Type

Type AUDIOSTREAM
	voice As Integer			' the voice we are playing on
	samp As SAMPLE Ptr			' the sample we are using
	length As Integer			' buffer length - name changed from 'len'
	bufcount As Integer			' number of buffers per sample half
	bufnum As Integer			' current refill buffer
	active As Integer			' which half is currently playing
	locked As UByte Ptr			' the locked buffer
End Type

Type PACKFILE					' our very own FILE structure...
	hndl As Integer				' DOS file handle
	flags As Integer			' PACKFILE_FLAG_* constants
	buf_pos As UByte Ptr			' position in buffer
	buf_size As Integer			' number of bytes in the buffer
	todo As Long				' number of bytes still on the disk
	parent As PACKFILE Ptr			' nested, parent file
	pack_data As UByte Ptr			' for LZSS compression
	filename As UByte Ptr			' name of the file
	passdata As UByte Ptr			' encryption key data
	passpos As UByte Ptr			' current key position
	buf(F_BUF_SIZE - 1) As UByte		' the actual data buffer
End Type

Type FONT
	data As UByte Ptr
	height As Integer
	vtable As UByte Ptr
End Type

' -- prototypes --

' system
Declare Function install_allegro CDecl Lib AL_LIB Alias "install_allegro" (ByVal system_id As Integer, ByRef errno_ptr As Integer, ByVal atexit_ptr As Function()) As Integer
Declare Sub allegro_exit CDecl Lib AL_LIB Alias "allegro_exit" ()
Extern allegro_id Alias "allegro_id" As Byte Ptr
Extern allegro_error Alias "allegro_error" As Byte Ptr
Extern os_type Alias "os_type" As Integer
Extern os_version Alias "os_version" As Integer
Extern os_revision Alias "os_revision" As Integer
Extern os_multitasking Alias "os_multitasking" As Integer
Declare Sub allegro_message CDecl Lib AL_LIB Alias "allegro_message" (ByVal s As String)
Declare Sub set_window_title CDecl Lib AL_LIB Alias "set_window_title" (ByVal name As String)
Declare Function set_close_button CDecl Lib AL_LIB Alias "set_close_button" (ByVal enable As Integer) As Integer
Declare Sub set_window_close_hook CDecl Lib AL_LIB Alias "set_window_close_hook" (ByVal proc As Sub)
Declare Function desktop_color_depth CDecl Lib AL_LIB Alias "desktop_color_depth" () As Integer
Declare Function get_desktop_resolution CDecl Lib AL_LIB Alias "get_desktop_resolution" (ByRef width As Integer, ByRef height As Integer) As Integer
Declare Sub yield_timeslice CDecl Lib AL_LIB Alias "yield_timeslice" ()
Declare Sub check_cpu CDecl Lib AL_LIB Alias "check_cpu" ()
Extern cpu_vendor Alias "cpu_vendor" As Byte Ptr
Extern cpu_family Alias "cpu_family" As Integer
Extern cpu_model Alias "cpu_model" As Integer
Extern cpu_capabilities Alias "cpu_capabilities" as Integer

' unicode - todo

' configuration routines
Declare Sub set_config_file CDecl Lib AL_LIB Alias "set_config_file" (ByVal filename As String)
Declare Sub set_config_data CDecl Lib AL_LIB Alias "set_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub override_config_file CDecl Lib AL_LIB Alias "override_config_file" (ByVal filename As String)
Declare Sub override_config_data CDecl Lib AL_LIB Alias "override_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub push_config_state CDecl Lib AL_LIB Alias "push_config_state" ()
Declare Sub pop_config_state CDecl Lib AL_LIB Alias "pop_config_state" ()
Declare Sub flush_config_file CDecl Lib AL_LIB Alias "flush_config_file" ()
Declare Sub reload_config_texts CDecl Lib AL_LIB Alias "reload_config_texts" (ByVal new_language As String)
Declare Sub hook_config_section CDecl Lib AL_LIB Alias "hook_config_section" (ByVal section As String, ByVal intgetter As Function(ByVal name As String, ByVal idef As Integer) As Integer, ByVal stringgetter As Function(ByVal name As String, ByVal sdef As String) As Integer, ByVal stringsetter As Sub (ByVal name As String, ByVal value As String))
Declare Function config_is_hooked CDecl Lib AL_LIB Alias "config_is_hooked" (ByVal section As String) As Integer
Declare Function get_config_string CDecl Lib AL_LIB alias "get_config_string" (ByVal section As String, ByVal name As String, Byval sdef As String) As Byte Ptr
Declare Function get_config_int CDecl Lib AL_LIB Alias "get_config_int" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_hex CDecl Lib AL_LIB Alias "get_config_hex" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_float CDecl Lib AL_LIB Alias "get_config_float" (ByVal section As String, ByVal name As String, ByVal fdef As Single) As Single
Declare Function get_config_id CDecl Lib AL_LIB Alias "get_config_id" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_argv CDecl Lib AL_LIB Alias "get_config_argv" (ByVal section As String, ByVal s_name As String, ByVal argc As Integer Ptr) As Byte Ptr Ptr
Declare Function get_config_text CDecl Lib AL_LIB Alias "get_config_text" (ByVal msg As String) As Byte Ptr
Declare Sub set_config_string CDecl Lib AL_LIB Alias "set_config_string" (ByVal section As String, ByVal name As String, ByVal val As String)
Declare Sub set_config_int CDecl Lib AL_LIB Alias "set_config_int" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_hex CDecl Lib AL_LIB Alias "set_config_hex" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_float CDecl Lib AL_LIB Alias "set_config_float" (ByVal section As String, ByVal name As String, ByVal val As Single)
Declare Sub set_config_id CDecl Lib AL_LIB Alias "set_config_id" (ByVal section As String, ByVal name As String, ByVal val As Integer)

' mouse routines
Declare Function install_mouse CDecl Lib AL_LIB Alias "install_mouse" () As Integer
Declare Sub remove_mouse CDecl Lib AL_LIB Alias "remove_mouse" ()
Declare Function poll_mouse CDecl Lib AL_LIB Alias "poll_mouse" () As Integer
Declare Function mouse_needs_poll CDecl Lib AL_LIB Alias "mouse_needs_poll" () As Integer
Extern mouse_x Alias "mouse_x" As Integer
Extern mouse_y Alias "mouse_y" As Integer
Extern mouse_z Alias "mouse_z" As Integer
Extern mouse_b Alias "mouse_b" As Integer
Extern mouse_pos Alias "mouse_pos" As Integer
Extern mouse_sprite  Alias "mouse_sprite" As BITMAP Ptr
Extern mouse_x_focus Alias "mouse_x_focus" As Integer
Extern mouse_y_focus Alias "mouse_y_focus" As Integer
Declare Sub show_mouse CDecl Lib AL_LIB Alias "show_mouse" (ByVal bmp As BITMAP Ptr)
Declare Sub scare_mouse CDecl Lib AL_LIB Alias "scare_mouse" ()
Declare Sub scare_mouse_area CDecl Lib AL_LIB Alias "scare_mouse_area" (ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub unscare_mouse CDecl Lib AL_LIB Alias "unscare_mouse" ()
Extern freeze_mouse_flag Alias "freeze_mouse_flag" As Integer
Declare Sub position_mouse CDecl Lib AL_LIB Alias "position_mouse" (ByVal x As Integer, ByVal y As Integer)
Declare Sub position_mouse_z CDecl Lib AL_LIB Alias "position_mouse_z" (ByVal z As Integer)
Declare Sub set_mouse_range CDecl Lib AL_LIB Alias "set_mouse_range" (ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
Declare Sub set_mouse_speed CDecl Lib AL_LIB Alias "set_mouse_speed" (ByVal xspeed As Integer, ByVal yspeed As Integer)
Declare Sub set_mouse_sprite CDecl Lib AL_LIB Alias "set_mouse_sprite" (ByVal sprite As BITMAP Ptr)
Declare Sub set_mouse_sprite_focus CDecl Lib AL_LIB Alias "set_mouse_sprite_focus" (ByVal x As Integer, ByVal y As Integer)
Declare Sub get_mouse_mickeys CDecl Lib AL_LIB Alias "get_mouse_mickeys) (ByRef mickeyx As Integer, ByRef mickeyy As Integer)
Extern mouse_callback Alias "mouse_callback" As Sub(ByVal flags As Integer)

' timer routines
Declare Function install_timer CDecl Lib AL_LIB Alias "install_timer" () As Integer
Declare Sub remove_timer CDecl Lib AL_LIB Alias "remove_timer" ()
Declare Function install_int CDecl Lib AL_LIB Alias "install_int" (ByVal proc As Sub(), ByVal speed As Integer) As Integer
Declare Function install_int_ex CDecl Lib AL_LIB Alias "install_int_ex" (ByVal proc As Sub(), ByVal speed As Integer) As Integer
Declare Sub remove_int CDecl Lib AL_LIB Alias "remove_int" (ByVal proc As Sub())
Declare Function install_param_int CDecl Lib AL_LIB Alias "install_param_int" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Function install_param_int_ex CDecl Lib AL_LIB Alias "install_param_int_ex" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Sub remove_param_int CDecl Lib AL_LIB Alias "remove_param_int" (ByVal proc As Sub(ByVal p As Integer), ByVal param As Integer)
Declare Function timer_can_simulate_retrace CDecl Lib AL_LIB Alias "timer_can_simulate_retrace" () As Integer
Declare Sub timer_simulate_retrace CDecl Lib AL_LIB Alias "timer_simulate_retrace" (ByVal enable As Integer)
Declare Function timer_is_using_retrace CDecl Lib AL_LIB Alias "timer_is_using_retrace" () As Integer
Extern retrace_count Alias "retrace_count" As Integer
Extern retrace_proc Alias "retrace_proc" As Sub()
Declare Sub rest CDecl Lib AL_LIB Alias "rest" (ByVal time As Long)
Declare Sub rest_callback CDecl Lib AL_LIB Alias "rest_callback" (ByVal time As Long, ByVal callback As Sub())

' keyboard routines
Declare Function install_keyboard CDecl Lib AL_LIB Alias "install_keyboard" () As Integer
Declare Sub remove_keyboard CDecl Lib AL_LIB Alias "remove_keyboard" ()
Declare Sub install_keyboard_hooks CDecl Lib AL_LIB Alias "install_keyboard_hooks" (ByVal keypressed As Function() As Integer, ByVal readkey As Function() As Integer)
Declare Function poll_keyboard CDecl Lib AL_LIB Alias "poll_keyboard" () As Integer
Extern keyboard_needs_poll Alias "keyboard_needs_poll" As Integer
Extern fb_al_key Alias "key" As Byte Ptr
Extern key_shifts Alias "key_shifts" As Integer
Declare Function keypressed CDecl Lib AL_LIB Alias "keypressed" () As Integer
Declare Function readkey CDecl Lib AL_LIB Alias "readkey" () As Integer
Declare Function ureadkey CDecl Lib AL_LIB Alias "ureadkey" (ByRef scancode As Integer) As Integer
Declare Function scancode_to_ascii CDecl Lib AL_LIB Alias "scancode_to_ascii" (ByVal scancode As Integer) As Integer
Declare Sub simulate_keypress CDecl Lib AL_LIB Alias "simulate_keypress" (ByVal key As Integer)
Declare Sub simulate_ukeypress CDecl Lib AL_LIB Alias "simulate_ukeypress" (ByVal key As Integer, ByVal scancode As Integer)
Extern keyboard_callback Alias "keyboard_callback" As Function(ByVal key As Integer) As Integer
Extern keyboard_ucallback Alias "keyboard_ucallback" As Function(ByVal key As Integer, ByVal scancode As Integer Ptr) As Integer
Extern keyboard_lowlevel_callback Alias "keyboard_lowlevel_callback" As Function(ByVal key As Integer) As Integer
Declare Sub set_leds CDecl Lib AL_LIB Alias "set_leds" (ByVal leds As Integer)
Declare Sub set_keyboard_rate CDecl Lib AL_LIB Alias "set_keyboard_rate" (ByVal delay As Integer, ByVal repeat As Integer)
Declare Sub clear_keybuf CDecl Lib AL_LIB Alias "clear_keybuf" ()
Extern three_finger_flag Alias "three_finger_flag" As Integer
Extern key_led_flag Alias "key_led_flag" As Integer

' joystick routines
Declare Function install_joystick CDecl Lib AL_LIB Alias "install_joystick" (ByVal jtype As Integer) As Integer
Declare Sub remove_joystick CDecl Lib AL_LIB Alias "remove_joystick" ()
Declare Function poll_joystick CDecl Lib AL_LIB Alias "poll_joystick" () As Integer
Extern num_joysticks Alias "num_joysticks" As Integer
Extern fb_joy Alias "joy" As JOYSTICK_INFO Ptr
Declare Function calibrate_joystick_name CDecl Lib AL_LIB Alias "calibrate_joystick_name" (ByVal n As Integer) As Byte Ptr
Declare Function calibrate_joystick CDecl Lib AL_LIB Alias "calibrate_joystick" (ByVal n As Integer) As Integer
Declare Function save_joystick_data CDecl Lib AL_LIB Alias "save_joystick_data" (ByVal filename As String) As Integer
Declare Function load_joystick_data CDecl Lib AL_LIB Alias "load_joystick_data" (ByVal filename As String) As Integer
Declare Function initialise_joystick CDecl Lib AL_LIB Alias "initialise_joystick" () As Integer

' graphics modes
Declare Sub set_color_depth CDecl Lib AL_LIB Alias "set_color_depth" (ByVal depth As Integer)
Declare Sub request_refresh_rate CDecl Lib AL_LIB Alias "request_refresh_rate" (ByVal rate As Integer)
Declare Function get_refresh_rate CDecl Lib AL_LIB Alias "get_refresh_rate" () As Integer
Declare Function get_gfx_mode_list CDecl Lib AL_LIB Alias "get_gfx_mode_list" (ByVal card As Integer) As GFX_MODE_LIST Ptr
Declare Sub destroy_gfx_mode_list CDecl Lib AL_LIB Alias "destroy_gfx_mode_list" (ByVal mode_list As GFX_MODE_LIST Ptr)
Declare Function set_gfx_mode CDecl Lib AL_LIB Alias "set_gfx_mode" (ByVal card As Integer, ByVal w As Integer, ByVal h As Integer, ByVal v_w As Integer, ByVal v_h As Integer)
Declare Function set_display_switch_mode CDecl Lib AL_LIB Alias "set_display_switch_mode" (ByVal mode As Integer) As Integer
Declare Function set_display_switch_callback CDecl Lib AL_LIB Alias "set_display_switch_callback" (ByVal dir As Integer, ByVal cb As Sub()) As Integer
Declare Sub remove_display_switch_callback CDecl Lib AL_LIB Alias "remove_display_switch_callback" (ByVal cb As Sub())
Declare Function get_display_switch_mode CDecl Lib AL_LIB Alias "get_display_switch_mode" () As Integer
Extern gfx_capabilities Alias "gfx_capabilities" As Integer
Declare Function enable_triple_buffer CDecl Lib AL_LIB Alias "enable_triple_buffer" () As Integer
Declare Function scroll_screen CDecl Lib AL_LIB Alias "scroll_screen" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function request_scroll CDecl Lib AL_LIB Alias "request_scroll" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function poll_scroll CDecl Lib AL_LIB Alias "poll_scroll" () As Integer
Declare Function show_video_bitmap CDecl Lib AL_LIB Alias "show_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function request_video_bitmap CDecl Lib AL_LIB Alias "request_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Sub vsync CDecl Lib AL_LIB Alias "vsync" ()

' bitmap objects
Extern al_screen Alias "screen" As BITMAP Ptr ' note: this is called 'screen' in Allegro docs
Declare Function create_bitmap CDecl Lib AL_LIB Alias "create_bitmap" (ByVal w As Integer, ByVal h As Integer) as BITMAP Ptr
Declare Function create_bitmap_ex CDecl Lib AL_LIB Alias "create_bitmap_ex" (ByVal color_depth As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_sub_bitmap CDecl Lib AL_LIB Alias "create_sub_bitmap" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_video_bitmap CDecl Lib AL_LIB Alias "create_video_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_system_bitmap CDecl Lib AL_LIB Alias "create_system_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Sub destroy_bitmap CDecl Lib AL_LIB Alias "destroy_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub lock_bitmap CDecl Lib AL_LIB Alias "lock_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Function bitmap_color_depth CDecl Lib AL_LIB Alias "bitmap_color_depth" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function bitmap_mask_color CDecl Lib AL_LIB Alias "bitmap_mask_color" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_same_bitmap CDecl Lib AL_LIB Alias "is_same_bitmap" (ByVal bmp1 As BITMAP Ptr, ByVal bmp2 As BITMAP Ptr) As Integer
Declare Function is_planar_bitmap CDecl Lib AL_LIB Alias "is_planar_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_linear_bitmap CDecl Lib AL_LIB Alias "is_linear_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_memory_bitmap CDecl Lib AL_LIB Alias "is_memory_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_screen_bitmap CDecl Lib AL_LIB Alias "is_screen_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_video_bitmap CDecl Lib AL_LIB Alias "is_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_sub_bitmap CDecl Lib AL_LIB Alias "is_sub_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Sub acquire_bitmap CDecl Lib AL_LIB Alias "acquire_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub release_bitmap CDecl Lib AL_LIB Alias "release_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub acquire_screen CDecl Lib AL_LIB Alias "acquire_screen" ()
Declare Sub release_screen CDecl Lib AL_LIB Alias "release_screen" ()
Declare Sub set_clip CDecl Lib AL_LIB Alias "set_clip" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub set_clip_rect CDecl Lib AL_LIB Alias "set_clip_rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub get_clip_rect CDecl Lib AL_LIB Alias "get_clip_rect" (ByVal bmp As BITMAP Ptr, ByRef x1 As Integer, ByRef y1 As Integer, ByRef x2 As Integer, ByRef y2 As Integer)
'Declare Sub add_clip_rect CDecl Lib AL_LIB Alias "add_clip_rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub set_clip_state CDecl Lib AL_LIB Alias "set_clip_state" (ByVal bmp As BITMAP Ptr, ByVal state As Integer)
'Declare Function get_clip_state CDecl Lib AL_LIB Alias "get_clip_state" (ByVal bmp As BITMAP Ptr) As Integer
'Declare Function is_inside_bitmap CDecl Lib AL_LIB Alias "is_inside_bitmap" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal clip As Integer) As Integer

' loading image files
Declare Function load_bitmap CDecl Lib AL_LIB Alias "load_bitmap" (ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr
Declare Function load_bmp CDecl Lib AL_LIB Alias "load_bmp" (ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr
Declare Function load_lbm CDecl Lib AL_LIB Alias "load_lbm" (ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr
Declare Function load_pcx CDecl Lib AL_LIB Alias "load_pcx" (ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr
Declare Function load_tga CDecl Lib AL_LIB Alias "load_tga" (ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr
Declare Function save_bitmap CDecl Lib AL_LIB Alias "save_bitmap" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB Ptr) As Integer
Declare Function save_bmp CDecl Lib AL_LIB Alias "save_bmp" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB Ptr) As Integer
Declare Function save_pcx CDecl Lib AL_LIB Alias "save_pcx" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB Ptr) As Integer
Declare Function save_tga CDecl Lib AL_LIB Alias "save_tga" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB Ptr) As Integer
Declare Sub register_bitmap_file_type CDecl Lib AL_LIB Alias "register_bitmap_file_type" (ByVal ext As String, ByVal load As Function(ByVal filename As String, ByVal pal As AL_RGB Ptr) As BITMAP Ptr, ByVal save As Function(ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB Ptr))
Declare Sub set_color_conversion CDecl Lib AL_LIB Alias "set_color_conversion" (ByVal mode As Integer)
Declare Function get_color_conversion CDecl Lib AL_LIB Alias "get_color_conversion" () As Integer

' palette routines
Declare Sub set_color CDecl Lib AL_LIB Alias "set_color" (ByVal index As Integer, ByVal p As AL_RGB Ptr)
Declare Sub set_palette CDecl Lib AL_LIB Alias "set_palette" (ByVal p As AL_RGB Ptr)
Declare Sub set_palette_range CDecl Lib AL_LIB Alias "set_palette_range" (ByVal p As AL_RGB Ptr, ByVal from As Integer, ByVal iTo As Integer, ByVal vsync As Integer)
Declare Sub get_color CDecl Lib AL_LIB Alias "get_color" (ByVal index As Integer, ByVal p As AL_RGB Ptr)
Declare Sub get_palette CDecl Lib AL_LIB Alias "get_palette" (ByVal p As AL_RGB Ptr)
Declare Sub get_palette_range CDecl Lib AL_LIB Alias "get_palette_range" (ByVal p As AL_RGB Ptr, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_interpolate CDecl Lib AL_LIB Alias "fade_interpolate" (ByVal source As AL_RGB Ptr, ByVal dest As AL_RGB Ptr, ByVal poutput As AL_RGB Ptr, ByVal pos As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from_range CDecl Lib AL_LIB Alias "fade_from_range" (ByVal source As AL_RGB Ptr, ByVal dest As AL_RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_in_range CDecl Lib AL_LIB Alias "fade_in_range" (ByVal p As AL_RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_out_range CDecl Lib AL_LIB Alias "fade_out_range" (ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from CDecl Lib AL_LIB Alias "fade_from" (ByVal source As AL_RGB Ptr, ByVal dest As AL_RGB Ptr, ByVal speed As Integer)
Declare Sub fade_in CDecl Lib AL_LIB Alias "fade_in" (ByVal p As AL_RGB Ptr, ByVal speed As Integer)
Declare Sub fade_out CDecl Lib AL_LIB Alias "fade_out" (ByVal speed As Integer)
Declare Sub select_palette CDecl Lib AL_LIB Alias "select_palette" (ByVal p As AL_RGB Ptr)
Declare Sub unselect_palette CDecl Lib AL_LIB Alias "unselect_palette" ()
Declare Sub generate_332_palette CDecl Lib AL_LIB Alias "generate_332_palette" (ByVal pal As AL_RGB ptr)
Declare Function generate_optimized_palette CDecl Lib AL_LIB Alias "generate_optimized_palette" (ByVal bmp As BITMAP Ptr, ByVal pal As AL_RGB ptr, ByVal rsvd As String) As Integer
Extern default_palette Alias "default_palette" As AL_RGB Ptr
Extern black_palette Alias "black_palette" As AL_RGB Ptr
Extern desktop_palette Alias "desktop_palette" As AL_RGB Ptr

' truecolor pixel formats
Declare Function makecol8 CDecl Lib AL_LIB Alias "makecol8" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol15 CDecl Lib AL_LIB Alias "makecol15" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol16 CDecl Lib AL_LIB Alias "makecol16" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol24 CDecl Lib AL_LIB Alias "makecol24" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol32 CDecl Lib AL_LIB Alias "makecol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makeacol32 CDecl Lib AL_LIB Alias "makeacol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makecol CDecl Lib AL_LIB Alias "makecol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol_depth CDecl Lib AL_LIB Alias "makecol_depth" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makeacol CDecl Lib AL_LIB Alias "makeacol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makeacol_depth CDecl Lib AL_LIB Alias "makeacol" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makecol15_dither CDecl Lib AL_LIB Alias "makecol15_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function makecol16_dither CDecl Lib AL_LIB Alias "makecol16_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getr8 CDecl Lib AL_LIB Alias "getr8" (ByVal c As Integer) As Integer
Declare Function getg8 CDecl Lib AL_LIB Alias "getg8" (ByVal c As Integer) As Integer
Declare Function getb8 CDecl Lib AL_LIB Alias "getb8" (ByVal c As Integer) As Integer
Declare Function getr15 CDecl Lib AL_LIB Alias "getr15" (ByVal c As Integer) As Integer
Declare Function getg15 CDecl Lib AL_LIB Alias "getg15" (ByVal c As Integer) As Integer
Declare Function getb15 CDecl Lib AL_LIB Alias "getb15" (ByVal c As Integer) As Integer
Declare Function getr16 CDecl Lib AL_LIB Alias "getr16" (ByVal c As Integer) As Integer
Declare Function getg16 CDecl Lib AL_LIB Alias "getg16" (ByVal c As Integer) As Integer
Declare Function getb16 CDecl Lib AL_LIB Alias "getb16" (ByVal c As Integer) As Integer
Declare Function getr24 CDecl Lib AL_LIB Alias "getr24" (ByVal c As Integer) As Integer
Declare Function getg24 CDecl Lib AL_LIB Alias "getg24" (ByVal c As Integer) As Integer
Declare Function getb24 CDecl Lib AL_LIB Alias "getb24" (ByVal c As Integer) As Integer
Declare Function getr32 CDecl Lib AL_LIB Alias "getr32" (ByVal c As Integer) As Integer
Declare Function getg32 CDecl Lib AL_LIB Alias "getg32" (ByVal c As Integer) As Integer
Declare Function getb32 CDecl Lib AL_LIB Alias "getb32" (ByVal c As Integer) As Integer
Declare Function geta32 CDecl Lib AL_LIB Alias "geta32" (ByVal c As Integer) As Integer
Declare Function getr CDecl Lib AL_LIB Alias "getr" (ByVal c As Integer) As Integer
Declare Function getg CDecl Lib AL_LIB Alias "getg" (ByVal c As Integer) As Integer
Declare Function getb CDecl Lib AL_LIB Alias "getb" (ByVal c As Integer) As Integer
Declare Function geta CDecl Lib AL_LIB Alias "geta" (ByVal c As Integer) As Integer
Declare Function getr_depth CDecl Lib AL_LIB Alias "getr_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getg_depth CDecl Lib AL_LIB Alias "getg_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getb_depth CDecl Lib AL_LIB Alias "getb_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function geta_depth CDecl Lib AL_LIB Alias "geta_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Extern palette_color Alias "palette_color" As Integer Ptr

' drawing primitives
Declare Sub putpixel CDecl Lib AL_LIB Alias "putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel8 CDecl Lib AL_LIB Alias "_putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel15 CDecl Lib AL_LIB Alias "_putpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel16 CDecl Lib AL_LIB Alias "_putpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel24 CDecl Lib AL_LIB Alias "_putpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel32 CDecl Lib AL_LIB Alias "_putpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Function getpixel CDecl Lib AL_LIB Alias "getpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel8 CDecl Lib AL_LIB Alias "_getpixel8" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel15 CDecl Lib AL_LIB Alias "_getpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel16 CDecl Lib AL_LIB Alias "_getpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel24 CDecl Lib AL_LIB Alias "_getpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel32 CDecl Lib AL_LIB Alias "_getpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Sub vline CDecl Lib AL_LIB Alias "vline" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y1 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub hline CDecl Lib AL_LIB Alias "hline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y As Integer, ByVal x2 As Integer, ByVal c As Integer)
Declare Sub do_line CDecl Lib AL_LIB Alias "do_line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
' note: draw_line is the fb name for Allegro's line
Declare Sub draw_line CDecl Lib AL_LIB Alias "line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub fastline CDecl Lib AL_LIB Alias "fastline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub triangle CDecl Lib AL_LIB Alias "triangle" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal x3 As Integer, ByVal y3 As Integer, ByVal c As Integer)
Declare Sub polygon CDecl Lib AL_LIB Alias "polygon" (ByVal bmp As BITMAP Ptr, ByVal vertices As Integer, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub rect CDecl Lib AL_LIB Alias "rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub rectfill CDecl Lib AL_LIB Alias "rectfill" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub do_circle CDecl Lib AL_LIB Alias "do_circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub draw_circle CDecl Lib AL_LIB Alias "circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer) ' note: this is called 'circle' in Allegro docs
Declare Sub circlefill CDecl Lib AL_LIB Alias "circlefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer)
Declare Sub do_ellipse CDecl Lib AL_LIB Alias "do_ellipse" (ByVal bmp As BITMAP Ptr, BYVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub ellipse CDecl Lib AL_LIB Alias "ellipse" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub ellipsefill CDecl Lib AL_LIB Alias "ellipsefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub do_arc CDecl Lib AL_LIB Alias "do_arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal a1 As fixed, ByVal a2 As fixed, ByVal r As Integer, ByVal d As Integer, ByVal proc As Sub(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub arc CDecl Lib AL_LIB Alias "arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal ang1 As fixed, ByVal ang2 As fixed, ByVal r As Integer, ByVal c As Integer)
Declare Sub calc_spline CDecl Lib AL_LIB Alias "calc_spline" (ByVal points As Integer Ptr, ByVal npts As Integer, ByRef x As Integer, ByRef y As Integer)
Declare Sub spline CDecl Lib AL_LIB Alias "spline" (ByVal bmp As BITMAP Ptr, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub floodfill CDecl Lib AL_LIB Alias "floodfill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)

' blitting and sprites
Declare Sub clear_bitmap CDecl Lib AL_LIB Alias "clear_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub clear_to_color CDecl Lib AL_LIB Alias "clear_to_color" (ByVal bmp As BITMAP Ptr, ByVal c As Integer)
Declare Sub blit CDecl Lib AL_LIB Alias "blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub stretch_blit CDecl Lib AL_LIB Alias "stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub masked_blit CDecl Lib AL_LIB Alias "masked_blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub masked_stretch_blit CDecl Lib AL_LIB Alias "masked_stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub draw_sprite CDecl Lib AL_LIB Alias "draw_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub stretch_sprite CDecl Lib AL_LIB Alias "stretch_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub draw_sprite_v_flip CDecl Lib AL_LIB Alias "draw_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_h_flip CDecl Lib AL_LIB Alias "draw_sprite_h_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_vh_flip CDecl Lib AL_LIB Alias "draw_sprite_vh_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_trans_sprite CDecl Lib AL_LIB Alias "draw_trans_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_lit_sprite CDecl Lib AL_LIB Alias "draw_lit_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub draw_gouraud_sprite CDecl Lib AL_LIB Alias "draw_gouraud_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c1 As Integer, ByVal c2 As Integer, ByVal c3 As Integer, ByVal c4 As Integer)
Declare Sub draw_character_ex CDecl Lib AL_LIB Alias "draw_character_ex" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
Declare Sub rotate_sprite CDecl Lib AL_LIB Alias "rotate_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_sprite_v_flip CDecl Lib AL_LIB Alias "rotate_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_scaled_sprite CDecl Lib AL_LIB Alias "rotate_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_sprite CDecl Lib AL_LIB Alias "pivot_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_sprite_v_flip CDecl Lib AL_LIB Alias "pivot_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_scaled_sprite CDecl Lib AL_LIB Alias "pivot_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_scaled_sprite_v_flip CDecl Lib AL_LIB Alias "pivot_scaled_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)

' RLE sprites
' todo ...

' compiled sprites
' todo ...

' text output
Extern font Alias "font" As FONT Ptr
Extern allegro_404_char Alias "allegro_404_char" As Integer
Declare Function text_mode CDecl Lib AL_LIB Alias "text_mode" (ByVal mode As Integer) As Integer
Declare Sub textout CDecl Lib AL_LIB Alias "textout" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_centre CDecl Lib AL_LIB Alias "textout_centre" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_right CDecl Lib AL_LIB Alias "textout_right" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_justify CDecl Lib AL_LIB Alias "textout_justify" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x1 As Integer, ByVal x2 As Integer, ByVal y As Integer, ByVal diff As Integer, ByVal c As Integer)
Declare Sub textprintf CDecl Lib AL_LIB Alias "textprintf" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal s As String)
Declare Function text_length CDecl Lib AL_LIB Alias "text_length" (ByVal f As FONT Ptr, ByVal s As String) As Integer
Declare Function text_height CDecl Lib AL_LIB Alias "text_height" (ByVal f As FONT Ptr) As Integer
Declare Sub destroy_font CDecl Lib AL_LIB Alias "destroy_font" (ByVal f As FONT Ptr)
'Declare Sub textout_ex CDecl Lib AL_LIB Alias "textout_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_centre_ex CDecl Lib AL_LIB Alias "textout_centre_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_right_ex CDecl Lib AL_LIB Alias "textout_right_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_justify_ex CDecl Lib AL_LIB Alias "textout_justify_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textprintf_ex CDecl Lib AL_LIB Alias "textprintf_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)
'Declare Sub textprintf_right_ex CDecl Lib AL_LIB Alias "textprintf_right_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)
'Declare Sub textprintf_justify_ex CDecl Lib AL_LIB Alias "textprintf_justify_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)

' polygon rendering
Declare Sub polygon3d CDecl Lib AL_LIB Alias "polygon3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, ByRef vtx() As V3D Ptr)
Declare Sub polygon3d_f CDecl Lib AL_LIB Alias "polygon3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, ByRef vtx() As V3D_f Ptr)
Declare Sub triangle3d CDecl Lib AL_LIB Alias "triangle3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D)
Declare Sub triangle3d_f CDecl Lib AL_LIB Alias "triangle3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f)
Declare Sub quad3d CDecl Lib AL_LIB Alias "quad3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D, ByRef v4 As V3D)
Declare Sub quad3d_f CDecl Lib AL_LIB Alias "quad3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f, ByRef v4 As V3D_f)
Declare Function clip3d_f CDecl Lib AL_LIB Alias "clip3d_f" (ByVal typ As Integer, ByVal min_z As Single, ByVal max_z As Single, ByVal vc As Integer, ByRef vtx() As V3D_f Ptr, ByRef vout() As V3D_f Ptr, ByRef vtmp() As V3D_f Ptr, ByVal iOut As Integer Ptr) As Integer
Declare Function clip3d CDecl Lib AL_LIB Alias "clip3d" (ByVal typ As Integer, ByVal min_z As fixed, ByVal max_z As fixed, ByVal vc As Integer, ByRef vtx() As V3D Ptr, ByRef vout() As V3D Ptr, ByRef vtmp() As V3D Ptr, ByVal iOut As Integer Ptr) As Integer
Declare Function create_zbuffer CDecl Lib AL_LIB Alias "create_zbuffer" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Sub set_zbuffer CDecl Lib AL_LIB Alias "set_zbuffer" (ByVal buf As BITMAP Ptr)
Declare Sub clear_zbuffer CDecl Lib AL_LIB Alias "clear_zbuffer" (ByVal zbuf As BITMAP Ptr, ByVal z As Single)
Declare Sub destroy_zbuffer CDecl Lib AL_LIB Alias "destroy_zbuffer" (ByVal zbuf As BITMAP Ptr)
Declare Function create_scene CDecl Lib AL_LIB Alias "create_scene" (ByVal nedge As Integer, ByVal npoly As Integer)
Declare Sub clear_scene CDecl Lib AL_LIB Alias "clear_scene" (ByVal bmp As BITMAP Ptr)
Declare Sub destroy_scene CDecl Lib AL_LIB Alias "destroy_scene" ()
Declare Function scene_polygon3d CDecl Lib AL_LIB Alias "scene_polygon3d" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, ByRef vtx() As V3D Ptr)
Declare Function scene_polygon3d_f CDecl Lib AL_LIB Alias "scene_polygon3d_f" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, ByRef vtx() As V3D_f Ptr)
Declare Sub render_scene CDecl Lib AL_LIB Alias "render_scene" ()
Extern scene_gap Alias "scene_gap" As Single

' transparency and patterned drawing
Declare Sub xor_mode CDecl Lib AL_LIB Alias "xor_mode" (ByVal iOn As Integer)
Declare Sub solid_mode CDecl Lib AL_LIB Alias "solid_mode" ()
Extern color_map Alias "color_map" As COLOR_MAP Ptr
Declare Sub create_trans_table CDecl Lib AL_LIB Alias "create_trans_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As AL_RGB Ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub create_light_table CDecl Lib AL_LIB Alias "create_light_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As AL_RGB Ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub create_color_table CDecl Lib AL_LIB Alias "create_color_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As AL_RGB Ptr, ByVal blend As Sub(ByVal pal As AL_RGB Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As AL_RGB Ptr), ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub create_blender_table CDecl Lib AL_LIB Alias "create_blender_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As AL_RGB Ptr, ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub set_trans_blender CDecl Lib AL_LIB Alias "set_trans_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_alpha_blender CDecl Lib AL_LIB Alias "set_alpha_blender" ()
Declare Sub set_write_alpha_blender CDecl Lib AL_LIB Alias "set_write_alpha_blender" ()
Declare Sub set_add_blender CDecl Lib AL_LIB Alias "set_add_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_burn_blender CDecl Lib AL_LIB Alias "set_burn_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_color_blender CDecl Lib AL_LIB Alias "set_color_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_difference_blender CDecl Lib AL_LIB Alias "set_difference_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dissolve_blender CDecl Lib AL_LIB Alias "set_dissolve_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dodge_blender CDecl Lib AL_LIB Alias "set_dodge_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_hue_blender CDecl Lib AL_LIB Alias "set_hue_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_invert_blender CDecl Lib AL_LIB Alias "set_invert_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_luminance_blender CDecl Lib AL_LIB Alias "set_luminance_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_multiply_blender CDecl Lib AL_LIB Alias "set_multiply_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_saturation_blender CDecl Lib AL_LIB Alias "set_saturation_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_screen_blender CDecl Lib AL_LIB Alias "set_screen_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_blender_mode CDecl Lib AL_LIB Alias "set_blender_mode" (ByVal b15 As Function(), ByVal b16 As Function(), ByVal b24 As Function(), ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_blender_mode_ex CDecl Lib AL_LIB Alias "set_blender_mode_ex" (ByVal b15 As Function(), ByVal b16 As Function(), ByVal b24 As Function(), ByVal b32 As Function(), ByVal b15x As Function(), ByVal b16x As Function(), ByVal b24x As Function(), ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)

' converting between color formats
Declare Function bestfit_color CDecl Lib AL_LIB Alias "bestfit_color" (ByVal pal As AL_RGB ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Extern rgb_map Alias "rgb_map" As RGB_MAP Ptr
Declare Sub create_rgb_table CDecl Lib AL_LIB Alias "create_rgb_table" (ByVal table As RGB_MAP Ptr, ByVal pal As AL_RGB Ptr, ByVal callback As Sub(ByVal ipos As Integer))
Declare Sub hsv_to_rgb CDecl Lib AL_LIB Alias "hsv_to_rgb" (ByVal h As Single, ByVal s As Single, ByVal v As Single, ByRef r As Integer, ByRef g As Integer, ByRef b As Integer)
Declare Sub rgb_to_hsv CDecl Lib AL_LIB Alias "rgb_to_hsv" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByRef h As Single, ByRef s As Single, ByRef v As Single)

' direct access to video memory
Declare Function bmp_write_line CDecl Lib AL_LIB Alias "bmp_write_line" (ByVal bmp As BITMAP Ptr, ByVal iLine As Integer) As Unsigned Integer
Declare Function bmp_read_line CDecl Lib AL_LIB Alias "bmp_read_line" (ByVal bmp As BITMAP Ptr, ByVal iLine As Integer) As Unsigned Integer
Declare Function bmp_unwrite_line CDecl Lib AL_LIB Alias "bmp_unwrite_line" (ByVal bmp As BITMAP Ptr) As unsigned Integer

' FLIC routines
Declare Function play_fli CDecl Lib AL_LIB Alias "play_fli" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function() As Integer) As Integer
Declare Function play_memory_fli CDecl Lib AL_LIB Alias "play_memory_fli" (ByVal fli_data As Integer, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function() As Integer) As Integer
Declare Function open_fli CDecl Lib AL_LIB Alias "open_fli" (ByVal filename As String) As Integer
Declare Function open_memory_fli CDecl Lib AL_LIB Alias "open_memory_fli" (ByVal fli_data As Integer) As Integer
Declare Sub close_fli CDecl Lib AL_LIB Alias "close_fli" ()
Declare Function next_fli_frame CDecl Lib AL_LIB Alias "next_fli_frame" (ByVal iloop As Integer) As Integer
Extern fli_bitmap Alias "fli_bitmap" As BITMAP Ptr
Extern fli_palette Alias "fli_palette" As AL_RGB Ptr
Declare Function fli_bmp_dirty_from CDecl Lib AL_LIB Alias "fb_fli_bmp_dirty_from" () As Integer
Extern fli_bmp_dirty_to Alias "fli_bmp_dirty_to" As Integer
Extern fli_bmp_dirty_from Alias "fli_bmp_dirty_from" As Integer
Declare Sub reset_fli_variables CDecl Lib AL_LIB Alias "reset_fli_variables" ()
Extern fli_frame alias "fli_frame" as integer
Extern fli_timer Alias "fli_timer" As Integer

' sound init routines
Declare Function detect_digi_driver CDecl Lib AL_LIB Alias "detect_digi_driver" (ByVal driver_id As Integer) As Integer
Declare Function detect_midi_driver CDecl Lib AL_LIB Alias "detect_midi_driver" (ByVal driver_id As Integer) As Integer
Declare Sub reserve_voices CDecl Lib AL_LIB Alias "reserve_voices" (ByVal digi_voices As Integer, ByVal midi_voices As Integer)
Declare Sub set_volume_per_voice CDecl Lib AL_LIB Alias "set_volume_per_voice" (ByVal scale As Integer)
Declare Function install_sound CDecl Lib AL_LIB Alias "install_sound" (ByVal digi As Integer, ByVal midi As Integer, ByVal cfg_path As String) As Integer
Declare Sub remove_sound CDecl Lib AL_LIB Alias "remove_sound"
Declare Sub set_volume CDecl Lib AL_LIB Alias "set_volume" (ByVal digi_volume As Integer, ByVal midi_volume As Integer)

' digital sample routines
Declare Function load_sample CDecl Lib AL_LIB Alias "load_sample" (ByVal filename As String) As SAMPLE Ptr
Declare Function load_wav CDecl Lib AL_LIB Alias "load_wav" (ByVal filename As String) As SAMPLE Ptr
Declare Function load_voc CDecl Lib AL_LIB Alias "load_voc" (BYVal filename As String) As SAMPLE Ptr
Declare Function create_sample CDecl Lib AL_LIB Alias "create_sample" (ByVal bits As Integer, ByVal stereo As Integer, ByVal freq As Integer, ByVal iLen As Integer) As SAMPLE Ptr
Declare Sub destroy_sample CDecl Lib AL_LIB Alias "destroy_sample" (ByVal spl As SAMPLE Ptr)
Declare Sub lock_sample CDecl Lib AL_LIB Alias "lock_sample" (ByVal spl As SAMPLE Ptr)
Declare Function play_sample CDecl Lib AL_LIB Alias "play_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)
Declare Sub adjust_sample CDecl Lib AL_LIB Alias "adjust_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)
Declare Sub stop_sample CDecl Lib AL_LIB Alias "stop_sample" (ByVal spl As SAMPLE Ptr)
Declare Function allocate_voice CDecl Lib AL_LIB Alias "allocate_voice" (ByVal spl As SAMPLE Ptr) As Integer
Declare Sub deallocate_voice CDecl Lib AL_LIB Alias "deallocate_voice" (ByVal voice As Integer)
Declare Sub reallocate_voice CDecl Lib AL_LIB Alias "reallocate_voice" (ByVal voice As Integer, ByVal spl As SAMPLE Ptr)
Declare Sub release_voice CDecl Lib AL_LIB Alias "release_Voice" (ByVal voice As Integer)
Declare Sub voice_start CDecl Lib AL_LIB Alias "voice_start" (ByVal voice As Integer)
Declare Sub voice_stop CDecl Lib AL_LIB Alias "voice_stop" (ByVal voice As Integer)
Declare Sub voice_set_priority CDecl Lib AL_LIB Alias "voice_set_priority" (ByVal voice As Integer, ByVal priority As Integer)
Declare Function voice_check CDecl Lib AL_LIB Alias "voice_check" (ByVal voice As Integer) As SAMPLE Ptr
Declare Function voice_get_position CDecl Lib AL_LIB Alias "voice_get_position" (ByVal voice As Integer) As Integer
Declare Sub voice_set_position CDecl Lib AL_LIB Alias "voice_set_position" (ByVal voice As Integer, ByVal position As Integer)
Declare Sub voice_set_playmode CDecl Lib AL_LIB Alias "voice_set_playmode" (ByVal voice As Integer, ByVal playmode As Integer)
Declare Function voice_get_volume CDecl Lib AL_LIB Alias "voice_get_volume" (ByVal voice As Integer) As Integer
Declare Sub voice_set_volume CDecl Lib AL_LIB Alias "voice_set_volume" (ByVal voice As Integer, ByVal volume As Integer)
Declare Sub voice_ramp_volume CDecl Lib AL_LIB Alias "voice_ramp_volume" (ByVal voice As Integer, ByVal itime As Integer, ByVal endvol As Integer)
Declare Sub voice_stop_volumeramp CDecl Lib AL_LIB Alias "voice_stop_volumeramp" (ByVal voice As Integer)
Declare Function voice_get_frequency CDecl Lib AL_LIB Alias "voice_get_frequency" (ByVal voice As Integer) As Integer
Declare Sub voice_set_frequency CDecl Lib AL_LIB Alias "voice_set_frequency" (ByVal voice As Integer, BYVal frequency As Integer)
Declare Sub voice_sweep_frequency CDecl Lib AL_LIB Alias "voice_sweep_frequency" (ByVal voice As Integer, bYvAl iTime As Integer, ByVal endfreq As Integer)
Declare Sub voice_stop_frequency_sweep CDecl Lib AL_LIB Alias "voice_stop_frequency_sweep" (ByVal voice As Integer)
Declare Function voice_get_pan CDecl Lib AL_LIB Alias "voice_get_pan" (ByVal voice As Integer) As Integer
Declare Sub voice_set_pan CDecl Lib AL_LIB Alias "voice_set_pan" (ByVal voice As Integer, ByVal pan As Integer)
Declare Sub voice_sweep_pan CDecl Lib AL_LIB Alias "voice_sweep_pan" (ByVal voice As Integer, ByVal iTime As Integer, ByVal endpan As Integer)
Declare Sub voice_stop_pan_sweep CDecl Lib AL_LIB Alias "voice_stop_pan_sweep" (ByVal voice As Integer)
Declare Sub voice_set_echo CDecl Lib AL_LIB Alias "voice_set_echo" (ByVal voice As Integer, BYVal strength As Integer, ByVal delay As Integer)
Declare Sub voice_set_tremolo CDecl Lib AL_LIB Alias "voice_set_tremolo" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)
Declare Sub voice_set_vibrato CDecl Lib AL_LIB Alias "voice_set_vibrato" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)

' music routines (MIDI)
Declare Function load_midi CDecl Lib AL_LIB Alias "load_midi" (ByVal filename As String) As MIDI Ptr
Declare Sub destroy_midi CDecl Lib AL_LIB Alias "destroy_midi" (ByVal midi As MIDI Ptr)
Declare Sub lock_midi CDecl Lib AL_LIB Alias "lock_midi" (ByVal midi As MIDI Ptr)
Declare Function play_midi CDecl Lib AL_LIB Alias "play_midi" (BYVal midi As MIDI Ptr, ByVal iloop As Integer) As Integer
Declare Function play_looped_midi CDecl Lib AL_LIB Alias "play_looped_midi" (ByVal midi As MIDI Ptr, ByVal loop_start As Integer, ByVal loop_end As Integer) As Integer
Declare Sub stop_midi CDecl Lib AL_LIB Alias "stop_midi" ()
Declare Sub midi_pause CDecl Lib AL_LIB Alias "midi_pause" ()
Declare Sub midi_resume CDecl Lib AL_LIB Alias "midi_resume" ()
Declare Function midi_seek CDecl Lib AL_LIB Alias "midi_seek" (ByVal target As Integer) As Integer
Declare Sub midi_out CDecl Lib AL_LIB Alias "midi_out" (ByVal dat As UByte Ptr, ByVal length As Integer)
Declare Function load_midi_patches CDecl Lib AL_LIB Alias "load_midi_patches" () As Integer
Extern midi_pos Alias "midi_pos" As Integer
Extern midi_loop_start Alias "midi_loop_start" As Integer
Extern midi_loop_end Alias "midi_loop_end" As Integer
Extern midi_msg_callback Alias "midi_msg_callback" As Sub()
Extern midi_meta_callback Alias "midi_meta_callback" As Sub()
Extern midi_sysex_callback Alias "midi_sysex_callback" As Sub()
Declare Function load_ibk CDecl Lib AL_LIB Alias "load_ibk" (ByVal filename As String, ByVal drums As Integer) As Integer

' audio stream routines
' todo ...

' recording routines
Declare Function install_sound_input CDecl Lib AL_LIB Alias "install_sound_input" (ByVal digi As Integer, ByVal midi As Integer) As Integer
Declare Sub remove_sound_input CDecl Lib AL_LIB Alias "remove_sound_input" ()
Declare Function get_sound_input_cap_bits CDecl Lib AL_LIB Alias "get_sound_input_cap_bits" () As Integer
Declare Function get_sound_input_cap_stereo CDecl Lib AL_LIB Alias "get_sound_input_cap_stereo" () As Integer
Declare Function get_sound_input_cap_rate CDecl Lib AL_LIB Alias "get_sound_input_cap_rate" (ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function get_sound_input_cap_parm CDecl Lib AL_LIB Alias "get_sound_input_cap_parm" (BYVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function set_sound_input_source CDecl Lib AL_LIB Alias "set_sound_input_source" (ByVal source As Integer) As Integer
Declare Function start_sound_input CDecl Lib AL_LIB Alias "start_sound_input" (ByVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Sub stop_sound_input CDecl Lib AL_LIB Alias "stop_sound_input" ()
Declare Function read_sound_input CDecl Lib AL_LIB Alias "read_sound_input" (ByVal buffer As UByte Ptr)
Extern digi_recorder Alias "digi_recorder" As Sub()
Extern midi_recorder Alias "midi_recorder" As Sub()

' file and compression routines
' todo ...

' datafile routines
Declare Function load_datafile CDecl Lib AL_LIB Alias "load_datafile" (ByVal filename As String) As DATAFILE Ptr
Declare Function load_datafile_callback CDecl Lib AL_LIB Alias "load_datafile_callback" (ByVal filename As String, ByVal callback As Sub(ByVal d As DATAFILE Ptr)) As DATAFILE Ptr
Declare Sub unload_datafile CDecl Lib AL_LIB Alias "unload_datafile" (ByVal dat As DATAFILE Ptr)
Declare Function load_datafile_object CDecl Lib AL_LIB Alias "load_datafile_object" (ByVal filename As String, ByVal objectname As String) As DATAFILE Ptr
Declare Sub unload_datafile_object CDecl Lib AL_LIB Alias "unload_datafile_object" (ByVal dat As DATAFILE Ptr)
Declare Function find_datafile_object CDecl Lib AL_LIB Alias "find_datafile_object" (ByVal dat As DATAFILE Ptr, ByVal objectname As String) As DATAFILE Ptr
Declare Function get_datafile_property CDecl Lib AL_LIB Alias "get_datafile_property" (ByVal dat As DATAFILE Ptr, ByVal typ As Integer) As Byte Ptr
Declare Sub register_datafile_object CDecl Lib AL_LIB Alias "register_datafile_object" (ByVal id As Integer, ByVal load As Sub(ByVal f As PACKFILE Ptr, ByVal size As Long), ByVal destroy As Sub(ByVal dat As Integer))
Declare Sub fixup_datafile CDecl Lib AL_LIB Alias "fixup_datafile" (ByVal dat As DATAFILE Ptr)

' fixed point math routines
Declare Function itofix CDecl Lib AL_LIB Alias "itofix" (ByVal x As Integer) As fixed
Declare Function fixtoi CDecl Lib AL_LIB Alias "fixtoi" (ByVal x As fixed) As Integer
Declare Function fixfloor CDecl Lib AL_LIB Alias "fixfloor" (ByVal x As fixed) As Integer
Declare Function fixceil CDecl Lib AL_LIB Alias "fixceil" (ByVal x As fixed) As Integer
Declare Function ftofix CDecl Lib AL_LIB Alias "ftofix" (ByVal x As Double) As fixed
Declare Function fixtof CDecl Lib AL_LIB Alias "fixtof" (ByVal x As fixed) As Double
Declare Function fixmul CDecl Lib AL_LIB Alias "fixmul" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixdiv CDecl Lib AL_LIB Alias "fixdiv" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixadd CDecl Lib AL_LIB Alias "fixadd" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixsub CDecl Lib AL_LIB Alias "fixsub" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixsin CDecl Lib AL_LIB Alias "fixsin" (ByVal x As fixed) As fixed
Declare Function fixcos CDecl Lib AL_LIB Alias "fixcos" (ByVal x As fixed) As fixed
Declare Function fixtan CDecl Lib AL_LIB Alias "fixtan" (ByVal x As fixed) As fixed
Declare Function fixasin CDecl Lib AL_LIB Alias "fixasin" (ByVal x As fixed) As fixed
Declare Function fixacos CDecl Lib AL_LIB Alias "fixacos" (ByVal x As fixed) As fixed
Declare Function fixatan CDecl Lib AL_LIB Alias "fixatan" (ByVal x As fixed) As fixed
Declare Function fixatan2 CDecl Lib AL_LIB Alias "fixatan2" (ByVal y As fixed, byVal x As fixed) As fixed
Declare Function fixsqrt CDecl Lib AL_LIB Alias "fixsqrt" (ByVal x As fixed) As fixed
Declare Function fixhypot CDecl Lib AL_LIB Alias "fixhypot" (ByVal x As fixed, ByVal y As fixed) As fixed

' 3D math routines
Declare Sub get_identity_matrix CDecl Lib AL_LIB Alias "fb_get_identity_matrix" (ByVal m As MATRIX Ptr)
Declare Sub get_identity_matrix_f CDecl Lib AL_LIB Alias "fb_get_identity_matrix_f" (ByVal m As MATRIX_f Ptr)
Declare Sub get_translation_matrix CDecl Lib AL_LIB Alias "get_translation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_translation_matrix_f CDecl Lib AL_LIB Alias "get_translation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_scaling_matrix CDecl Lib AL_LIB Alias "get_scaling_matrix" (ByVal m As MATRIX Ptr, Byval x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_scaling_matrix_f CDecl Lib AL_LIB Alias "get_scaling_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_x_rotate_matrix CDecl Lib AL_LIB Alias "get_x_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_x_rotate_matrix_f CDecl Lib AL_LIB Alias "get_x_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_y_rotate_matrix CDecl Lib AL_LIB Alias "get_y_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_y_rotate_matrix_f CDecl Lib AL_LIB Alias "get_y_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_z_rotate_matrix CDecl Lib AL_LIB Alias "get_z_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_z_rotate_matrix_f CDecl Lib AL_LIB Alias "get_z_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_rotation_matrix CDecl Lib AL_LIB Alias "get_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub get_rotation_matrix_f CDecl Lib AL_LIB Alias "get_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_align_matrix CDecl Lib AL_LIB Alias "get_align_matrix" (ByVal m As MATRIX Ptr, ByVal xfront As fixed, ByVal yfront As fixed, ByVal zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed)
Declare Sub get_align_matrix_f CDecl Lib AL_LIB Alias "get_align_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, ByVal yup As Single, ByVal zup As Single)
Declare Sub get_vector_rotation_matrix CDecl Lib AL_LIB Alias "get_vector_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, BYVal z AS fixed, ByVal a As fixed)
Declare Sub get_vector_rotation_matrix_f CDecl Lib AL_LIB Alias "get_vector_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal a As Single)
Declare Sub get_transformation_matrix CDecl Lib AL_LIB Alias "get_transformation_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed, ByVal xrot As fixed, ByVal yrot As fixed, ByVal zrot As fixed, ByVal x As fixed, ByVal y As fixed, byVal z As fixed)
Declare Sub get_transformation_matrix_f CDecl Lib AL_LIB Alias "get_transformation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single, ByVal xrot As Single, BYVal yrot As Single, ByVal zrot As Single, ByVal x As Single, BYVal y As Single, ByVal z As Single)
Declare Sub get_camera_matrix CDecl Lib AL_LIB Alias "get_camera_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed, ByVal xfront As fixed, ByVal yfront As fixed, BYval zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed, ByVal fov As fixed, ByVal aspect As fixed)
Declare Sub get_camera_matrix_f CDecl Lib AL_LIB Alias "get_camera_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, BYVal yup As Single, ByVal zup As Single, ByVal fov As Single, Byval aspect As Single)
Declare Sub qtranslate_matrix CDecl Lib AL_LIB Alias "qtranslate_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub qtrnslate_matrix_f CDecl Lib AL_LIB Alias "qtranslate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub qscale_matrix CDecl Lib AL_LIB Alias "qscale_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed)
Declare Sub qscale_matrix_f CDecl Lib AL_LIB Alias "qscale_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single)
Declare Sub matrix_mul CDecl Lib AL_LIB Alias "matrix_mul" (ByVal m1 As MATRIX Ptr, ByVal m2 As MATRIX Ptr, ByVal mout As MATRIX Ptr)
Declare Sub matrix_mul_f CDecl Lib AL_LIB Alias "matrix_mul_f' (ByVal m1 As MATRIX_f Ptr, ByVal m2 As MATRIX_f Ptr, ByVal mout As MATRIX_f Ptr)
Declare Function vector_length CDecl Lib AL_LIB Alias "vector_length" (ByVal x As fixed, BYVal y As fixed, ByVal z As fixed) As fixed
Declare Function vector_lengtH_f CDecl Lib AL_LIB Alias "vector_length_f" (ByVal x As Single, BYVal y As Single, ByVal z As Single) As SIngle
Declare Sub normalize_vector CDecl Lib AL_LIB Alias "normalize_vector" (ByRef x As fixed, ByRef y As fixed, ByRef z As fixed)
Declare Sub normalize_vector_f CDecl Lib AL_LIB Alias "normalize_vector_f" (ByRef x As Single, ByRef y As Single, ByRef z As Single)
Declare Function dot_product CDecl Lib AL_LIB Alias "dot_product" (Byval x1 As fixed, ByVal y1 As fixed, ByVal z1 As fixed, ByVal x2 As fixed, ByVAl y2 As fixed, BYVal z2 As fixed) As fixed
Declare Function dot_product_f CDecl Lib AL_LIB Alias "dot_product_f" (ByVal x1 As Single, ByVal y1 As Single, ByVal z1 As Single, ByVal x2 As Single, ByVal y2 AS Single, ByVal z2 As Single) As Single
Declare Sub cross_product CDecl Lib AL_LIB Alias "cross_product" (ByVal x1 As fixed, BYVal y1 As fixed, ByVal z1 As fixed, BYVal x2 As fixed, BYVal y2 As fixed, ByVal z2 As fixed, ByRef xout As fixed, ByRef yout As fixed, ByRef zout As fixed)
Declare Sub cross_product_f CDecl Lib AL_LIB Alias "cross_product_f" (ByVal x1 As Single, BYVal y1 As Single, ByVal z1 As Single, BYVal x2 As Single, BYVal y2 As Single, ByVal z2 As Single, ByRef xout As Single, ByRef yout As Single, ByRef zout As Single)
Declare Function polygon_z_normal CDecl Lib AL_LIB Alias "polygon_z_normal" (ByVal v1 As V3D Ptr, Byval v2 As V3D Ptr, ByVal v3 As V3D Ptr) As fixed
Declare Function polygon_z_normal_f CDecl Lib AL_LIB Alias "polygon_z_normal_f" (ByVal v1 As V3D_f Ptr, ByVal v2 As V3D_f ptr, ByVal v3 As V3D_f PTr) As Single
Declare Sub apply_matrix CDecl Lib AL_LIB Alias "apply_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, BYVal z As fixed, ByRef xout As fixed, BYRef yout As fixed, ByRef zout As fixed)
Declare Sub apply_matrix_f CDecl Lib AL_LIB Alias "apply_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As SIngle, byVal z As Single, ByRef xout As Single, ByRef yout As Single, Byref zout As Single)
Declare Sub set_projection_viewport CDecl Lib AL_LIB Alias "set_projection_viewport" (ByVal x As Integer, BYVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub persp_project CDecl Lib AL_LIB Alias "persp_project" (ByVal x As fixed, ByVal y As fixed, BYVal z As fixed, ByRef xout As fixed, BYRef yout As fixed)
Declare Sub persp_project_f CDecl Lib AL_LIB Alias "persp_project_f" (ByVal x As Single, ByVal y As Single, ByVal z As Single, ByRef xout As Single, ByRef yout As Single)

' quaternion math routines
' todo ...
Declare Sub get_identity_quat CDecl Lib AL_LIB Alias "fb_get_identity_quat" (ByVal q As QUAT Ptr)

' GUI routines
' todo ...
Declare Function alert CDecl Lib AL_LIB Alias "alert" (ByVal s1 as String, ByVal s2 As String, ByVal s3 As String, ByVal b1 As String, ByVal b2 As String, ByVal c1 As String, ByVal c2 As String) As Integer
Declare Function gfx_mode_select CDecl Lib AL_LIB Alias "gfx_mode_select" (ByRef card As Integer, ByRef w As Integer, ByRef h As Integer) As Integer
Declare Function gfx_mode_select_ex CDecl Lib AL_LIB Alias "gfx_mode_select_ex" (ByVal card As Integer Ptr, ByVal w As Integer Ptr, ByVal h As Integer Ptr, ByVal color_depth As Integer Ptr)

' ---


' -- misc --
Dim Shared errno As Integer

' -- macros converted to functions --

'Function allegro_init() As Integer
'	allegro_init = install_allegro(SYSTEM_AUTODETECT, errno, ProcPtr(atexit))
'End Function

#define allegro_init	install_allegro(SYSTEM_AUTODETECT, errno, ProcPtr(atexit))

Function SCREEN_W() As Integer
	SCREEN_W = al_screen->w
End Function

Function SCREEN_H() As Integer
	SCREEN_H = al_screen->h
End Function

Function SECS_TO_TIMER(ByVal secs As fixed) As fixed
	SECS_TO_TIMER = secs * TIMERS_PER_SECOND
End Function

Function MSEC_TO_TIMER(ByVal msec As fixed) As fixed
	MSEC_TO_TIMER = msec * (TIMERS_PER_SECOND / 1000)
End Function

Function BPS_TO_TIMER(ByVal bps As fixed) As fixed
	BPS_TO_TIMER = TIMERS_PER_SECOND / bps
End Function

Function BPM_TO_TIMER(ByVal bpm As fixed) As fixed
	BPM_TO_TIMER = (60 * TIMERS_PER_SECOND) / bpm
End Function

'Function rand() As Integer	' included in crtdll.bi as of fB 0.08b
'	rand = rnd * RAND_MAX
'End Function

#define AL_RAND	rand()

' MIN, MAX, and AL_MID will only work for integers, unlike Allegro's #defines...
Function MIN(ByVal x As Integer, ByVal y As Integer) As Integer
	If x < y Then
		MIN = x
	Else
		MIN = y
	End If
End Function

Function MAX(ByVal x As Integer, ByVal y As Integer) As Integer
	If x > y Then
		MAX = x
	Else
		MAX = y
	End If
End Function

' AL_MID is the fb equivalent of Allegro's MID
Function AL_MID(ByVal x As Integer, ByVal y As Integer, ByVal z As Integer) As Integer
	AL_MID = MAX(x, MIN(y, z))
End Function

' -- random hacks --

'Declare Function linear_vtable16 CDecl Lib AL_LIB Alias "fb_linear_vtable16" () As GFX_VTABLE Ptr
Extern linear_vtable16 Alias "linear_vtable16" As GFX_VTABLE Ptr
