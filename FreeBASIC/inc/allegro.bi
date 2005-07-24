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


	option nokeyword screen, circle, line, palette, rgb


#include once "crt.bi"

' -- platform-specific --

#ifndef __FB_LINUX__

	#ifdef __FB_DOS__

		'$inclib: "alleg"

		'$include: 'dos/go32.bi'
		'$include: 'dos/dpmi.bi'

		#define ALLEGRO_PLATFORM_STR  "djgpp"
		#define ALLEGRO_DOS
		#define ALLEGRO_I386
		#define ALLEGRO_LITTLE_ENDIAN
		#define ALLEGRO_CONSOLE_OK
		#define ALLEGRO_VRAM_SINGLE_SURFACE
		#define ALLEGRO_USE_CONSTRUCTOR

		' memory locking macros
		declare sub _unlock_dpmi_data cdecl alias "_unlock_dpmi_data" ( byval addr as any ptr, byval size as integer )

		#define END_OF_FUNCTION(x)		sub x##_end() : end sub
		#define END_OF_STATIC_FUNCTION(x)	private sub x##_end() : end sub
		#define LOCK_DATA(d, s)			_go32_dpmi_lock_data d, s
		#define LOCK_CODE(c, s)			_go32_dpmi_lock_code c, s
		#define UNLOCK_DATA(d,s)		_unlock_dpmi_data d, s
		#define LOCK_VARIABLE(x)		LOCK_DATA(@x, len(x))
		#define LOCK_FUNCTION(x)		LOCK_CODE(x, @x##_end - @x)

		' selector for video memory bitmaps
		#define _video_ds _dos_ds

		' helpers for talking to video memory
		#define bmp_select(bmp)	_farsetsel (bmp)->seg

		#define bmp_write8(addr, c)		_farnspokeb addr, c
		#define bmp_write15(addr, c)		_farnspokew addr, c
		#define bmp_write16(addr, c)		_farnspokew addr, c
		#define bmp_write32(addr, c)		_farnspokel addr, c

		#define bmp_read8(addr)			_farnspeekb(addr)
		#define bmp_read15(addr)		_farnspeekw(addr)
		#define bmp_read16(addr)		_farnspeekw(addr)
		#define bmp_read32(addr)		_farnspeekl(addr)
		#define bmp_read24(addr)		(_farnspeekl(addr) and &HFFFFFF)

		#define bmp_write24(addr, c)		_farnspokew addr, (c) and &HFFFF : _farnspokeb (addr)+2, (c) shr 16

	#elseif defined(__FB_WIN32__)
	
		#ifdef ALLEGRO_STATICLINK
			'$inclib: 'alleg_s'
			#define ALLEGRO_PLATFORM_STR  "MinGW32.s"
		#else
			'$inclib: 'alleg'
			#define ALLEGRO_PLATFORM_STR  "MinGW32"
		#endif

		#define ALLEGRO_WINDOWS
		#define ALLEGRO_I386
		#define ALLEGRO_LITTLE_ENDIAN
		#define ALLEGRO_USE_CONSTRUCTOR

		#ifdef USE_CONSOLE
			#define ALLEGRO_CONSOLE_OK
		#endif

		' describe how function prototypes look to MINGW32
		#if defined(ALLEGRO_STATICLINK)
			#define _AL_DLL
		#else
			#define _AL_DLL	Import ''__declspec(dllimport)
		#endif

		#define SYSTEM_DIRECTX		AL_ID(asc("D"),asc("X"),asc(" "),asc(" "))

		#define TIMER_WIN32_HIGH_PERF	AL_ID(asc("W"),asc("3"),asc("2"),asc("H"))
		#define TIMER_WIN32_LOW_PERF	AL_ID(asc("W"),asc("3"),asc("2"),asc("L"))
	
	#endif
	
#else
	' linux
	
	#define ALLEGRO_UNIX
	#define ALLEGRO_LINUX

	'$libpath: "/usr/local/lib"
	'$libpath: "/usr/X11R6/lib"
	'$inclib: "alleg-4.0.3"
	'$inclib: "alleg_unsharable"
	
	#define ALLEGRO_CONSOLE_OK
	#define ALLEGRO_VRAM_SINGLE_SURFACE
	
	#define TIMERDRV_UNIX_PTHREADS	AL_ID(asc("P"),asc("T"),asc("H"),asc("R"))

	declare sub split_modex_screen cdecl alias "split_modex_screen" ( byval _line as integer )

	' Port I/O functions -- maybe these should be internal

	private sub outportb ( byval port as ushort, byval value as ubyte)
		asm
			mov dx, [port]
			mov al, [value]
			out dx, al
		end asm
	end sub
	
	private sub outportw ( byval port as ushort, byval value as ushort )
		asm
			mov dx, [port]
			mov ax, [value]
			out dx, ax
		end asm
	end sub

	private sub outportl ( byval port as ushort, byval value as uinteger )
		asm
			mov dx, [port]
			mov eax, [value]
			out dx, eax
		end asm
	end sub

	private function inportb ( byval port as ushort ) as ubyte
		asm
			mov dx, [port]
			in al, dx
			mov [inportb], al
		end asm
	end function
	
	private function inportw ( byval port as ushort ) as ushort
		asm
			mov dx, [port]
			in ax, dx
			mov [inportw], ax
		end asm
	end function

	private function inportl ( byval port as ushort ) as ushort
		asm
			mov dx, [port]
			in eax, dx
			mov [inportl], eax
		end asm
	end function

#endif

#if not defined(__FB_DOS__)

	#define END_OF_FUNCTION(x)		if 0 then : end if
	#define END_OF_STATIC_FUNCTION(x)	if 0 then : end if
	#define LOCK_DATA(d, s)			if 0 then : end if
	#define LOCK_CODE(c, s)			if 0 then : end if
	#define UNLOCK_DATA(d,s)		if 0 then : end if
	#define LOCK_VARIABLE(x)		if 0 then : end if
	#define LOCK_FUNCTION(x)		if 0 then : end if

#endif


' -- constants --

' todo ... lots of missing constants

#define ALLEGRO_VERSION          4
#define ALLEGRO_SUB_VERSION      0
#define ALLEGRO_WIP_VERSION      3
#define ALLEGRO_VERSION_STR      "4.0.3 (RC3)"
#define ALLEGRO_DATE_STR         "2003"
#define ALLEGRO_DATE             20030330    ' yyyymmdd

#define AL_ID(a,b,c,d)			(((a) shl 24) or ((b) shl 16) or ((c) shl 8) or (d))

#define AL_PI				3.14159265358979323846

Const FALSE%				= 0
Const TRUE%				= -1

Const JOY_TYPE_AUTODETECT%		= -1
Const JOY_TYPE_NONE%			= 0

Const MAX_JOYSTICKS%			= 8
Const MAX_JOYSTICK_AXIS%		= 3
Const MAX_JOYSTICK_STICKS%		= 5
#if ALLEGRO_SUB_VERSION = 1
Const MAX_JOYSTICK_BUTTONS%		= 32
#else
Const MAX_JOYSTICK_BUTTONS%		= 16
#endif

Const PAL_SIZE%				= 256

Const MIDI_VOICES%			= 64
Const MIDI_TRACKS%			= 32

Const TIMERS_PER_SECOND%		= 1193181

Const MASK_COLOR_8%			= 0
Const MASK_COLOR_15%			= &H7C1F	' (5.5.5 pink)
Const MASK_COLOR_16%			= &HF81F	' (5.6.5 pink)
Const MASK_COLOR_24%			= &HFF00FF	' (8.8.8 pink)
Const MASK_COLOR_32%			= &HFF00FF	' (8.8.8 pink)

Const fixtorad_r%			= 1608		' 2pi/256
Const radtofix_r%			= 2670177	' 256/2pi

' joystick status flags
#define JOYFLAG_DIGITAL             1
#define JOYFLAG_ANALOGUE            2
#define JOYFLAG_CALIB_DIGITAL       4
#define JOYFLAG_CALIB_ANALOGUE      8
#define JOYFLAG_CALIBRATE           16
#define JOYFLAG_SIGNED              32
#define JOYFLAG_UNSIGNED            64

' alternative spellings
#define JOYFLAG_ANALOG              JOYFLAG_ANALOGUE
#define JOYFLAG_CALIB_ANALOG        JOYFLAG_CALIB_ANALOGUE

Const SYSTEM_AUTODETECT% = 0
#define SYSTEM_NONE        AL_ID(asc("N"),asc("O"),asc("N"),asc("E"))

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


#ifndef ALLEGRO_NO_KEY_DEFINES

#define KB_SHIFT_FLAG         &H0001
#define KB_CTRL_FLAG          &H0002
#define KB_ALT_FLAG           &H0004
#define KB_LWIN_FLAG          &H0008
#define KB_RWIN_FLAG          &H0010
#define KB_MENU_FLAG          &H0020
#define KB_SCROLOCK_FLAG      &H0100
#define KB_NUMLOCK_FLAG       &H0200
#define KB_CAPSLOCK_FLAG      &H0400
#define KB_INALTSEQ_FLAG      &H0800
#define KB_ACCENT1_FLAG       &H1000
#define KB_ACCENT2_FLAG       &H2000
#define KB_ACCENT3_FLAG       &H4000
#define KB_ACCENT4_FLAG       &H8000

#define KEY_A                 1
#define KEY_B                 2
#define KEY_C                 3
#define KEY_D                 4
#define KEY_E                 5
#define KEY_F                 6
#define KEY_G                 7
#define KEY_H                 8
#define KEY_I                 9
#define KEY_J                 10
#define KEY_K                 11
#define KEY_L                 12
#define KEY_M                 13
#define KEY_N                 14
#define KEY_O                 15
#define KEY_P                 16
#define KEY_Q                 17
#define KEY_R                 18
#define KEY_S                 19
#define KEY_T                 20
#define KEY_U                 21
#define KEY_V                 22
#define KEY_W                 23
#define KEY_X                 24
#define KEY_Y                 25
#define KEY_Z                 26
#define KEY_0                 27
#define KEY_1                 28
#define KEY_2                 29
#define KEY_3                 30
#define KEY_4                 31
#define KEY_5                 32
#define KEY_6                 33
#define KEY_7                 34
#define KEY_8                 35
#define KEY_9                 36
#define KEY_0_PAD             37
#define KEY_1_PAD             38
#define KEY_2_PAD             39
#define KEY_3_PAD             40
#define KEY_4_PAD             41
#define KEY_5_PAD             42
#define KEY_6_PAD             43
#define KEY_7_PAD             44
#define KEY_8_PAD             45
#define KEY_9_PAD             46
#define KEY_F1                47
#define KEY_F2                48
#define KEY_F3                49
#define KEY_F4                50
#define KEY_F5                51
#define KEY_F6                52
#define KEY_F7                53
#define KEY_F8                54
#define KEY_F9                55
#define KEY_F10               56
#define KEY_F11               57
#define KEY_F12               58
#define KEY_ESC               59
#define KEY_TILDE             60
#define KEY_MINUS             61
#define KEY_EQUALS            62
#define KEY_BACKSPACE         63
#define KEY_TAB               64
#define KEY_OPENBRACE         65
#define KEY_CLOSEBRACE        66
#define KEY_ENTER             67
#define KEY_COLON             68
#define KEY_QUOTE             69
#define KEY_BACKSLASH         70
#define KEY_BACKSLASH2        71
#define KEY_COMMA             72
#define KEY_STOP              73
#define KEY_SLASH             74
#define KEY_SPACE             75
#define KEY_INSERT            76
#define KEY_DEL               77
#define KEY_HOME              78
#define KEY_END               79
#define KEY_PGUP              80
#define KEY_PGDN              81
#define KEY_LEFT              82
#define KEY_RIGHT             83
#define KEY_UP                84
#define KEY_DOWN              85
#define KEY_SLASH_PAD         86
#define KEY_ASTERISK          87
#define KEY_MINUS_PAD         88
#define KEY_PLUS_PAD          89
#define KEY_DEL_PAD           90
#define KEY_ENTER_PAD         91
#define KEY_PRTSCR            92
#define KEY_PAUSE             93
#define KEY_ABNT_C1           94
#define KEY_YEN               95
#define KEY_KANA              96
#define KEY_CONVERT           97
#define KEY_NOCONVERT         98
#define KEY_AT                99
#define KEY_CIRCUMFLEX        100
#define KEY_COLON2            101
#define KEY_KANJI             102

#define KEY_MODIFIERS         103

#define KEY_LSHIFT            103
#define KEY_RSHIFT            104
#define KEY_LCONTROL          105
#define KEY_RCONTROL          106
#define KEY_ALT               107
#define KEY_ALTGR             108
#define KEY_LWIN              109
#define KEY_RWIN              110
#define KEY_MENU              111
#define KEY_SCRLOCK           112
#define KEY_NUMLOCK           113
#define KEY_CAPSLOCK          114

#define KEY_MAX               115

#endif ' ALLEGRO_NO_KEY_DEFINES

#define QUAT_SHORT   0
#define QUAT_LONG    1
#define QUAT_CW      2
#define QUAT_CCW     3
#define QUAT_USER    4

#define OSTYPE_UNKNOWN     0
#define OSTYPE_WIN3        AL_ID(asc("W"),asc("I"),asc("N"),asc("3"))
#define OSTYPE_WIN95       AL_ID(asc("W"),asc("9"),asc("5"),asc(" "))
#define OSTYPE_WIN98       AL_ID(asc("W"),asc("9"),asc("8"),asc(" "))
#define OSTYPE_WINME       AL_ID(asc("W"),asc("M"),asc("E"),asc(" "))
#define OSTYPE_WINNT       AL_ID(asc("W"),asc("N"),asc("T"),asc(" "))
#define OSTYPE_WIN2000     AL_ID(asc("W"),asc("2"),asc("K"),asc(" "))
#define OSTYPE_WINXP       AL_ID(asc("W"),asc("X"),asc("P"),asc(" "))
#define OSTYPE_OS2         AL_ID(asc("O"),asc("S"),asc("2"),asc(" "))
#define OSTYPE_WARP        AL_ID(asc("W"),asc("A"),asc("R"),asc("P"))
#define OSTYPE_DOSEMU      AL_ID(asc("D"),asc("E"),asc("M"),asc("U"))
#define OSTYPE_OPENDOS     AL_ID(asc("O"),asc("D"),asc("O"),asc("S"))
#define OSTYPE_LINUX       AL_ID(asc("T"),asc("U"),asc("X"),asc(" "))
#define OSTYPE_SUNOS       AL_ID(asc("S"),asc("U"),asc("N"),asc(" "))
#define OSTYPE_FREEBSD     AL_ID(asc("F"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_NETBSD      AL_ID(asc("N"),asc("B"),asc("S"),asc("D"))
#define OSTYPE_IRIX        AL_ID(asc("I"),asc("R"),asc("I"),asc("X"))
#define OSTYPE_QNX         AL_ID(asc("Q"),asc("N"),asc("X"),asc(" "))
#define OSTYPE_UNIX        AL_ID(asc("U"),asc("N"),asc("I"),asc("X"))
#define OSTYPE_BEOS        AL_ID(asc("B"),asc("E"),asc("O"),asc("S"))
#define OSTYPE_MACOS       AL_ID(asc("M"),asc("A"),asc("C"),asc(" "))

#define DAT_ID(a,b,c,d)    AL_ID(a,b,c,d)

#define DAT_MAGIC          DAT_ID(asc("A"),asc("L"),asc("L"),asc("."))
#define DAT_FILE           DAT_ID(asc("F"),asc("I"),asc("L"),asc("E"))
#define DAT_DATA           DAT_ID(asc("D"),asc("A"),asc("T"),asc("A"))
#define DAT_FONT           DAT_ID(asc("F"),asc("O"),asc("N"),asc("T"))
#define DAT_SAMPLE         DAT_ID(asc("S"),asc("A"),asc("M"),asc("P"))
#define DAT_MIDI           DAT_ID(asc("M"),asc("I"),asc("D"),asc("I"))
#define DAT_PATCH          DAT_ID(asc("P"),asc("A"),asc("T"),asc(" "))
#define DAT_FLI            DAT_ID(asc("F"),asc("L"),asc("I"),asc("C"))
#define DAT_BITMAP         DAT_ID(asc("B"),asc("M"),asc("P"),asc(" "))
#define DAT_RLE_SPRITE     DAT_ID(asc("R"),asc("L"),asc("E"),asc(" "))
#define DAT_C_SPRITE       DAT_ID(asc("C"),asc("M"),asc("P"),asc(" "))
#define DAT_XC_SPRITE      DAT_ID(asc("X"),asc("C"),asc("M"),asc("P"))
#define DAT_PALETTE        DAT_ID(asc("P"),asc("A"),asc("L"),asc(" "))
#define DAT_PROPERTY       DAT_ID(asc("p"),asc("r"),asc("o"),asc("p"))
#define DAT_NAME           DAT_ID(asc("N"),asc("A"),asc("M"),asc("E"))
#define DAT_END            -1

#define DIGI_AUTODETECT		-1	' for passing to install_sound()
#define DIGI_NONE		0

#define PLAYMODE_PLAY           0
#define PLAYMODE_LOOP           1
#define PLAYMODE_FORWARD        0
#define PLAYMODE_BACKWARD       2
#define PLAYMODE_BIDIR          4

#define SOUND_INPUT_MIC    1
#define SOUND_INPUT_LINE   2
#define SOUND_INPUT_CD     3

#define DRAW_MODE_SOLID             0        ' flags for drawing_mode()
#define DRAW_MODE_XOR               1
#define DRAW_MODE_COPY_PATTERN      2
#define DRAW_MODE_SOLID_PATTERN     3
#define DRAW_MODE_MASKED_PATTERN    4
#define DRAW_MODE_TRANS             5

#define F_READ          "r"
#define F_WRITE         "w"
#define F_READ_PACKED   "rp"
#define F_WRITE_PACKED  "wp"
#define F_WRITE_NOPACK  "w!"

#define F_BUF_SIZE      4096		' 4K buffer for caching data
#define F_PACK_MAGIC    &H736C6821	' magic number for packed files
#define F_NOPACK_MAGIC  &H736C682E	' magic number for autodetect
#define F_EXE_MAGIC     &H736C682B	' magic number for appended data

#define PACKFILE_FLAG_WRITE	1	' the file is being written
#define PACKFILE_FLAG_PACK	2	' data is compressed
#define PACKFILE_FLAG_CHUNK	4	' file is a sub-chunk
#define PACKFILE_FLAG_EOF	8	' reached the end-of-file
#define PACKFILE_FLAG_ERROR	16	' an error has occurred
#define PACKFILE_FLAG_OLD_CRYPT	32	' backward compatibility mode
#define PACKFILE_FLAG_EXEDAT	64	' reading from our executable

#define BMP_ID_VIDEO       &H80000000
#define BMP_ID_SYSTEM      &H40000000
#define BMP_ID_SUB         &H20000000
#define BMP_ID_PLANAR      &H10000000
#define BMP_ID_NOBLIT      &H08000000
#define BMP_ID_LOCKED      &H04000000
#define BMP_ID_AUTOLOCK    &H02000000
#define BMP_ID_MASK        &H01FFFFFF

#define VIRTUAL_W    iif(screen <> 0, screen->w, 0)
#define VIRTUAL_H    iif(screen <> 0, screen->h, 0)

#define COLORCONV_NONE              0

#define COLORCONV_8_TO_15           1
#define COLORCONV_8_TO_16           2
#define COLORCONV_8_TO_24           4
#define COLORCONV_8_TO_32           8

#define COLORCONV_15_TO_8           &H10
#define COLORCONV_15_TO_16          &H20
#define COLORCONV_15_TO_24          &H40
#define COLORCONV_15_TO_32          &H80

#define COLORCONV_16_TO_8           &H100
#define COLORCONV_16_TO_15          &H200
#define COLORCONV_16_TO_24          &H400
#define COLORCONV_16_TO_32          &H800

#define COLORCONV_24_TO_8           &H1000
#define COLORCONV_24_TO_15          &H2000
#define COLORCONV_24_TO_16          &H4000
#define COLORCONV_24_TO_32          &H8000

#define COLORCONV_32_TO_8           &H10000
#define COLORCONV_32_TO_15          &H20000
#define COLORCONV_32_TO_16          &H40000
#define COLORCONV_32_TO_24          &H80000

#define COLORCONV_32A_TO_8          &H100000
#define COLORCONV_32A_TO_15         &H200000
#define COLORCONV_32A_TO_16         &H400000
#define COLORCONV_32A_TO_24         &H800000

#define COLORCONV_DITHER_PAL        &H1000000
#define COLORCONV_DITHER_HI         &H2000000
#define COLORCONV_KEEP_TRANS        &H4000000

#define COLORCONV_DITHER            (COLORCONV_DITHER_PAL or COLORCONV_DITHER_HI)

#define COLORCONV_EXPAND_256        (COLORCONV_8_TO_15 or COLORCONV_8_TO_16 or COLORCONV_8_TO_24 or COLORCONV_8_TO_32)

#define COLORCONV_REDUCE_TO_256     (COLORCONV_15_TO_8 or COLORCONV_16_TO_8 or COLORCONV_24_TO_8 or COLORCONV_32_TO_8 or COLORCONV_32A_TO_8)

#define COLORCONV_EXPAND_15_TO_16    COLORCONV_15_TO_16

#define COLORCONV_REDUCE_16_TO_15    COLORCONV_16_TO_15

#define COLORCONV_EXPAND_HI_TO_TRUE (COLORCONV_15_TO_24 or COLORCONV_15_TO_32 or COLORCONV_16_TO_24 or COLORCONV_16_TO_32)

#define COLORCONV_REDUCE_TRUE_TO_HI (COLORCONV_24_TO_15 or COLORCONV_24_TO_16 or COLORCONV_32_TO_15 or COLORCONV_32_TO_16)

#define COLORCONV_24_EQUALS_32      (COLORCONV_24_TO_32 or COLORCONV_32_TO_24)

#define COLORCONV_TOTAL             (COLORCONV_EXPAND_256 or COLORCONV_REDUCE_TO_256 or COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_EXPAND_HI_TO_TRUE or COLORCONV_REDUCE_TRUE_TO_HI or COLORCONV_24_EQUALS_32 or COLORCONV_32A_TO_15 or COLORCONV_32A_TO_16 or COLORCONV_32A_TO_24)

#define COLORCONV_PARTIAL           (COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_24_EQUALS_32)

#define COLORCONV_MOST              (COLORCONV_EXPAND_15_TO_16 or COLORCONV_REDUCE_16_TO_15 or COLORCONV_EXPAND_HI_TO_TRUE or COLORCONV_REDUCE_TRUE_TO_HI or COLORCONV_24_EQUALS_32)

#define SWITCH_NONE           0
#define SWITCH_PAUSE          1
#define SWITCH_AMNESIA        2
#define SWITCH_BACKGROUND     3
#define SWITCH_BACKAMNESIA    4

#define SWITCH_IN             0
#define SWITCH_OUT            1

' bits for the flags field
#define D_EXIT          1        ' object makes the dialog exit
#define D_SELECTED      2        ' object is selected
#define D_GOTFOCUS      4        ' object has the input focus 
#define D_GOTMOUSE      8        ' mouse is on top of object
#define D_HIDDEN        16       ' object is not visible
#define D_DISABLED      32       ' object is visible but inactive
#define D_DIRTY         64       ' object needs to be redrawn
#define D_INTERNAL      128      ' reserved for internal use
#define D_USER          256      ' from here on is free for your own use


' return values for the dialog procedures
#define D_O_K           0        ' normal exit status
#define D_CLOSE         1        ' request to close the dialog
#define D_REDRAW        2        ' request to redraw the dialog
#define D_REDRAWME      4        ' request to redraw this object
#define D_WANTFOCUS     8        ' this object wants the input focus
#define D_USED_CHAR     16       ' object has used the keypress
#define D_REDRAW_ALL    32       ' request to redraw all active dialogs


' messages for the dialog procedures
#define MSG_START       1        ' start the dialog, initialise 
#define MSG_END         2        ' dialog is finished - cleanup
#define MSG_DRAW        3        ' draw the object
#define MSG_CLICK       4        ' mouse click on the object
#define MSG_DCLICK      5        ' double click on the object
#define MSG_KEY         6        ' keyboard shortcut
#define MSG_CHAR        7        ' other keyboard input
#define MSG_UCHAR       8        ' unicode keyboard input
#define MSG_XCHAR       9        ' broadcast character to all objects
#define MSG_WANTFOCUS   10       ' does object want the input focus?
#define MSG_GOTFOCUS    11       ' got the input focus
#define MSG_LOSTFOCUS   12       ' lost the input focus
#define MSG_GOTMOUSE    13       ' mouse on top of object
#define MSG_LOSTMOUSE   14       ' mouse moved away from object
#define MSG_IDLE        15       ' update any background stuff
#define MSG_RADIO       16       ' clear radio buttons
#define MSG_WHEEL       17       ' mouse wheel moved
#define MSG_LPRESS      18       ' mouse left button pressed
#define MSG_LRELEASE    19       ' mouse left button released
#define MSG_MPRESS      20       ' mouse middle button pressed
#define MSG_MRELEASE    21       ' mouse middle button released
#define MSG_RPRESS      22       ' mouse right button pressed
#define MSG_RRELEASE    23       ' mouse right button released
#define MSG_USER        24       ' from here on are free...

#define OLD_FILESEL_WIDTH   -1
#define OLD_FILESEL_HEIGHT  -1


' -- typedefs --

type ZBUFFER as BITMAP				' 3D z-buffer type
type fixed as Integer				' 32-bit 16.16 fixed-point type


' -- structures and types --

type _DRIVER_INFO		' info about a hardware driver
	id as integer		' integer ID
	driver as any ptr	' the driver structure
	autodetect as integer	' set to allow autodetection
end type

type GFX_DRIVER
   id as integer
   name as byte ptr
   desc as byte ptr
   ascii_name as byte ptr
   init as sub cdecl
   exit as sub cdecl
   scroll as sub cdecl
   vsync as sub cdecl
   set_palette as sub cdecl
   request_scroll as sub cdecl
   poll_scroll as sub cdecl
   enable_triple_buffer as sub cdecl
   create_video_bitmap as sub cdecl
   destroy_video_bitmap as sub cdecl
   show_video_bitmap as sub cdecl
   request_video_bitmap as sub cdecl
   create_system_bitmap as sub cdecl
   destroy_system_bitmap as sub cdecl
   set_mouse_sprite as sub cdecl
   show_mouse as sub cdecl
   hide_mouse as sub cdecl
   move_mouse as sub cdecl
   drawing_mode as sub cdecl
   save_video_state as sub cdecl
   restore_video_state as sub cdecl
   fetch_mode_list as sub cdecl
   w as integer
   h as integer
   linear as integer
   bank_size as integer
   bank_gran as integer
   vid_mem as integer
   vid_phys_base as integer
   windowed as integer
end type

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

Type RGB
	r As UByte
	g As UByte
	b As UByte
	filler As UByte
End Type

Type PALETTE					' note: this is actually a #define for an array (won't work in FB)
	color(PAL_SIZE - 1) As RGB		' fixme - this is broken
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
	proc as sub cdecl(msg As Integer, d As DIALOG Ptr, c As Integer)
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
	proc as sub cdecl()			' callback function
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
	proc as sub cdecl()			' callback function
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

type FONT_GLYPH					' a single monochrome font character
	w as short
	h as short
	dat as ubyte ptr
end type

Type FONT
	data As UByte Ptr
	height As Integer
	vtable As UByte Ptr
End Type

Type SYSTEM_DRIVER
	id as integer
	name as byte ptr
	desc as byte ptr
	ascii_name as byte ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	get_executable_name as sub cdecl(byval output as byte ptr, byval size as integer)
	find_resource as function cdecl(byval dest as byte ptr, byval resource as byte ptr, byval size as integer) as integer
	set_window_title as sub cdecl(byval name as byte ptr)
	set_window_close_button as function cdecl(byval enable as integer) as integer
	set_window_close_hook as sub cdecl(byval proc as sub cdecl())
	message as sub cdecl(byval msg as byte ptr)
	assert_ as sub cdecl(byval msg as byte ptr)
	save_console_state as sub cdecl()
	restore_console_state as sub cdecl()
	create_bitmap as function cdecl(byval color_depth as integer, byval width as integer, byval height as integer) as BITMAP ptr
	created_bitmap as sub cdecl(byval bmp as BITMAP ptr)
	create_sub_bitmap as function cdecl(byval parent as BITMAP ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer) as BITMAP ptr
	created_sub_bitmap as sub cdecl(byval bmp as BITMAP ptr, byval parent as BITMAP ptr)
	destroy_bitmap as function cdecl(byval bmp as BITMAP ptr) as integer
	read_hardware_palette as sub cdecl()
	set_palette_range as sub cdecl(byval p as RGB ptr, byval _from as integer, byval _to as integer, byval retracesync as integer)
	get_vtable as function cdecl(byval color_depth as integer) as GFX_VTABLE ptr
	set_display_switch_mode as function cdecl(byval mode as integer) as integer
	set_display_switch_callback as function cdecl(byval _dir as integer, byval cb as sub cdecl()) as integer
	remove_display_switch_callback as sub cdecl(byval cb as sub cdecl())
	display_switch_lock as sub cdecl(byval _lock as integer, byval foreground as integer)
	desktop_color_depth as function cdecl() as integer
	get_desktop_resolution as function cdecl(byval width as integer ptr, byval height as integer ptr) as integer
	yield_timeslice as sub cdecl()
	gfx_drivers as function cdecl() as _DRIVER_INFO ptr
	digi_drivers as function cdecl() as _DRIVER_INFO ptr
	midi_drivers as function cdecl() as _DRIVER_INFO ptr
	keyboard_drivers as function cdecl() as _DRIVER_INFO ptr
	mouse_drivers as function cdecl() as _DRIVER_INFO ptr
	joystick_drivers as function cdecl() as _DRIVER_INFO ptr
	timer_drivers as function cdecl() as _DRIVER_INFO ptr
end type

type TIMER_DRIVER
	id as integer
	name as byte ptr
	desc as byte ptr
	ascii_name as byte ptr
	init as function cdecl() as integer
	exit as sub cdecl()
	install_int as function cdecl(byval proc as sub cdecl(), byval speed as integer) as integer
	remove_int as sub cdecl(byval proc as sub cdecl())
	install_param_int as function cdecl(byval proc as sub cdecl(byval param as any ptr), byval _param as any ptr, byval speed as integer) as integer
	remove_param_int as sub cdecl(byval proc as sub cdecl(byval param as any ptr), byval _param as any ptr)
	can_simulate_retrace as function cdecl() as integer
	simulate_retrace as sub cdecl(byval enable as integer)
	rest as sub cdecl(byval time_ as integer, byval callback as sub cdecl())
end type

type _VTABLE_INFO
	color_depth as integer
	vtable as GFX_VTABLE ptr
end type

type DIALOG_PROC as function cdecl(byval msg as integer, byval d as DIALOG ptr, byval c as integer) as integer

' -- externs --

extern import gfx_driver alias "gfx_driver" as GFX_DRIVER ptr

extern import timer_driver as TIMER_DRIVER ptr
extern import _timer_driver_list as _DRIVER_INFO

extern import _system_none alias "system_none" as SYSTEM_DRIVER
extern import system_driver alias "system_driver" as SYSTEM_DRIVER ptr
extern import _system_driver_list alias "_system_driver_list" as _DRIVER_INFO

#define ALLEGRO_ERROR_SIZE 256

Extern Import allegro_id Alias "allegro_id" As zstring * ALLEGRO_ERROR_SIZE
Extern Import allegro_error Alias "allegro_error" As zstring * ALLEGRO_ERROR_SIZE

Extern Import os_type Alias "os_type" As Integer
Extern Import os_version Alias "os_version" As Integer
Extern Import os_revision Alias "os_revision" As Integer
Extern Import os_multitasking Alias "os_multitasking" As Integer

Extern Import cpu_vendor Alias "cpu_vendor" As Byte Ptr
Extern Import cpu_family Alias "cpu_family" As Integer
Extern Import cpu_model Alias "cpu_model" As Integer
Extern Import cpu_capabilities Alias "cpu_capabilities" as Integer

Extern Import mouse_x Alias "mouse_x" As Integer
Extern Import mouse_y Alias "mouse_y" As Integer
Extern Import mouse_z Alias "mouse_z" As Integer
Extern Import mouse_b Alias "mouse_b" As Integer
Extern Import mouse_pos Alias "mouse_pos" As Integer
Extern Import mouse_sprite  Alias "mouse_sprite" As BITMAP Ptr
Extern Import mouse_x_focus Alias "mouse_x_focus" As Integer
Extern Import mouse_y_focus Alias "mouse_y_focus" As Integer
Extern Import freeze_mouse_flag Alias "freeze_mouse_flag" As Integer
Extern Import mouse_callback Alias "mouse_callback" As Sub cdecl(ByVal flags As Integer)

Extern Import retrace_count Alias "retrace_count" As Integer
Extern Import retrace_proc Alias "retrace_proc" As Sub cdecl()

Extern Import keyboard_needs_poll Alias "keyboard_needs_poll" As Integer
Extern Import key(0 to KEY_MAX-1) Alias "key" As Byte
Extern Import key_shifts Alias "key_shifts" As Integer
Extern Import keyboard_callback Alias "keyboard_callback" As Function cdecl(ByVal key As Integer) As Integer
Extern Import keyboard_ucallback Alias "keyboard_ucallback" As Function cdecl(ByVal key As Integer, ByVal scancode As Integer Ptr) As Integer
Extern Import keyboard_lowlevel_callback Alias "keyboard_lowlevel_callback" As Function cdecl(ByVal key As Integer) As Integer
Extern Import three_finger_flag Alias "three_finger_flag" As Integer
Extern Import key_led_flag Alias "key_led_flag" As Integer

Extern Import num_joysticks Alias "num_joysticks" As Integer
Extern Import joy Alias "joy" As JOYSTICK_INFO Ptr

Extern Import gfx_capabilities Alias "gfx_capabilities" As Integer

Extern Import screen Alias "screen" As BITMAP Ptr

Extern Import default_palette(0 to PAL_SIZE-1) Alias "default_palette" As RGB
Extern Import black_palette(0 to PAL_SIZE-1) Alias "black_palette" As RGB
Extern Import desktop_palette(0 to PAL_SIZE-1) Alias "desktop_palette" As RGB

Extern Import rgb_map Alias "rgb_map" As RGB_MAP Ptr

Extern Import scene_gap Alias "scene_gap" As Single

Extern Import color_map Alias "color_map" As COLOR_MAP Ptr

Extern Import midi_pos Alias "midi_pos" As Integer
Extern Import midi_loop_start Alias "midi_loop_start" As Integer
Extern Import midi_loop_end Alias "midi_loop_end" As Integer
Extern Import midi_msg_callback Alias "midi_msg_callback" As Sub cdecl()
Extern Import midi_meta_callback Alias "midi_meta_callback" As Sub cdecl()
Extern Import midi_sysex_callback Alias "midi_sysex_callback" As Sub cdecl()

Extern Import digi_recorder Alias "digi_recorder" As Sub cdecl()
Extern Import midi_recorder Alias "midi_recorder" As Sub cdecl()

Extern Import fli_bitmap Alias "fli_bitmap" As BITMAP Ptr
Extern Import fli_palette Alias "fli_palette" As RGB Ptr
Extern Import fli_bmp_dirty_to Alias "fli_bmp_dirty_to" As Integer
Extern Import fli_bmp_dirty_from Alias "fli_bmp_dirty_from" As Integer
extern import fli_pal_dirty_from alias "fli_pal_dirty_from" as integer
extern import fli_pal_dirty_to alias "fli_pal_dirty_to" as integer
Extern Import fli_frame alias "fli_frame" as integer
Extern Import fli_timer Alias "fli_timer" As Integer

Extern Import font Alias "font" As FONT Ptr
Extern Import allegro_404_char Alias "allegro_404_char" As Integer

extern import identity_matrix alias "identity_matrix" as MATRIX
extern import identity_matrix_f alias "identity_matrix_f" as MATRIX_f

Extern import identity_quat alias "identity_quat" As QUAT

Extern Import linear_vtable16 Alias "linear_vtable16" As GFX_VTABLE Ptr

extern import _persp_xscale alias "_persp_xscale" as fixed
extern import _persp_yscale alias "_persp_yscale" as fixed
extern import _persp_xoffset as fixed
extern import _persp_yoffset as fixed

extern import _persp_xscale_f as single
extern import _persp_yscale_f as single
extern import _persp_xoffset_f as single
extern import _persp_yoffset_f as single

extern import allegro_errno alias "allegro_error" as integer ptr

extern import _rgb_r_shift_15 as integer
extern import _rgb_g_shift_15 as integer
extern import _rgb_b_shift_15 as integer
extern import _rgb_r_shift_16 as integer
extern import _rgb_g_shift_16 as integer
extern import _rgb_b_shift_16 as integer
extern import _rgb_r_shift_24 as integer
extern import _rgb_g_shift_24 as integer
extern import _rgb_b_shift_24 as integer
extern import _rgb_r_shift_32 as integer
extern import _rgb_g_shift_32 as integer
extern import _rgb_b_shift_32 as integer
extern import _rgb_a_shift_32 as integer
extern import _rgb_scale_5 as integer
extern import _rgb_scale_6 as integer

Extern Import palette_color Alias "palette_color" As Integer Ptr

extern import _cos_tbl alias "_cos_tbl" as fixed ptr
extern import _tan_tbl alias "_tan_tbl" as fixed ptr
extern import _acos_tbl alias "_acos_tbl" as fixed ptr

extern import _vtable_list alias "_vtable_list" as _VTABLE_INFO ptr

extern import gui_shadow_box_proc as DIALOG_PROC
extern import gui_ctext_proc as DIALOG_PROC
extern import gui_button_proc as DIALOG_PROC
extern import gui_edit_proc as DIALOG_PROC
extern import gui_list_proc as DIALOG_PROC
extern import gui_text_list_proc as DIALOG_PROC
extern import active_dialog as DIALOG ptr
extern import active_menu as MENU ptr
extern import gui_mouse_focus as integer
extern import gui_fg_color as integer
extern import gui_mg_color as integer
extern import gui_bg_color as integer
extern import gui_font_baseline as integer
extern import gui_mouse_x as function cdecl() as integer
extern import gui_mouse_y as function cdecl() as integer
extern import gui_mouse_z as function cdecl() as integer
extern import gui_mouse_b as function cdecl() as integer
extern import gui_menu_draw_menu as sub cdecl(byval x as integer, byval y as integer, byval w as integer, byval h as integer)
extern import gui_menu_draw_menu_item as sub cdecl(byval m as MENU ptr, byval x as integer, byval y as integer, byval w as integer, byval h as integer, byval bar as integer, byval sel as integer)

' -- prototypes --

' system
Declare Function install_allegro CDecl Alias "install_allegro" (ByVal system_id As Integer, ByVal errno_ptr As Integer Ptr, ByVal atexit_ptr as function cdecl( byval as sub cdecl() ) as integer) As Integer
Declare Sub allegro_exit CDecl Alias "allegro_exit" ()
Declare Sub allegro_message CDecl Alias "allegro_message" (ByVal s As String)
Declare Sub set_window_title CDecl Alias "set_window_title" (ByVal name As String)
Declare Function set_close_button CDecl Alias "set_close_button" (ByVal enable As Integer) As Integer
Declare Sub set_window_close_hook CDecl Alias "set_window_close_hook" (ByVal proc As Sub cdecl())
Declare Function desktop_color_depth CDecl Alias "desktop_color_depth" () As Integer
Declare Function get_desktop_resolution CDecl Alias "get_desktop_resolution" (ByRef width As Integer, ByRef height As Integer) As Integer
Declare Sub yield_timeslice CDecl Alias "yield_timeslice" ()
Declare Sub check_cpu CDecl Alias "check_cpu" ()

' unicode - todo

' configuration routines
Declare Sub set_config_file CDecl Alias "set_config_file" (ByVal filename As String)
Declare Sub set_config_data CDecl Alias "set_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub override_config_file CDecl Alias "override_config_file" (ByVal filename As String)
Declare Sub override_config_data CDecl Alias "override_config_data" (ByVal sdata As String, ByVal length As Integer)
Declare Sub push_config_state CDecl Alias "push_config_state" ()
Declare Sub pop_config_state CDecl Alias "pop_config_state" ()
Declare Sub flush_config_file CDecl Alias "flush_config_file" ()
Declare Sub reload_config_texts CDecl Alias "reload_config_texts" (ByVal new_language As String)
Declare Sub hook_config_section CDecl Alias "hook_config_section" (ByVal section As String, ByVal intgetter As Function cdecl(ByVal name As String, ByVal idef As Integer) As Integer, ByVal stringgetter As Function cdecl(ByVal name As String, ByVal sdef As String) As Integer, ByVal stringsetter As Sub cdecl (ByVal name As String, ByVal value As String))
Declare Function config_is_hooked CDecl Alias "config_is_hooked" (ByVal section As String) As Integer
Declare Function get_config_string CDecl Alias "get_config_string" (ByVal section As String, ByVal name As String, Byval sdef As String) as zstring ptr
Declare Function get_config_int CDecl Alias "get_config_int" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_hex CDecl Alias "get_config_hex" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_float CDecl Alias "get_config_float" (ByVal section As String, ByVal name As String, ByVal fdef As Single) As Single
Declare Function get_config_id CDecl Alias "get_config_id" (ByVal section As String, ByVal name As String, ByVal idef As Integer) As Integer
Declare Function get_config_argv CDecl Alias "get_config_argv" (ByVal section As String, ByVal s_name As String, ByVal argc As Integer Ptr) as zstring ptr Ptr
Declare Function get_config_text CDecl Alias "get_config_text" (ByVal msg As String) as zstring ptr
Declare Sub set_config_string CDecl Alias "set_config_string" (ByVal section As String, ByVal name As String, ByVal val As String)
Declare Sub set_config_int CDecl Alias "set_config_int" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_hex CDecl Alias "set_config_hex" (ByVal section As String, ByVal name As String, ByVal val As Integer)
Declare Sub set_config_float CDecl Alias "set_config_float" (ByVal section As String, ByVal name As String, ByVal val As Single)
Declare Sub set_config_id CDecl Alias "set_config_id" (ByVal section As String, ByVal name As String, ByVal val As Integer)

' mouse routines
Declare Function install_mouse CDecl Alias "install_mouse" () As Integer
Declare Sub remove_mouse CDecl Alias "remove_mouse" ()
Declare Function poll_mouse CDecl Alias "poll_mouse" () As Integer
Declare Function mouse_needs_poll CDecl Alias "mouse_needs_poll" () As Integer
Declare Sub show_mouse CDecl Alias "show_mouse" (ByVal bmp As BITMAP Ptr)
Declare Sub scare_mouse CDecl Alias "scare_mouse" ()
Declare Sub scare_mouse_area CDecl Alias "scare_mouse_area" (ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub unscare_mouse CDecl Alias "unscare_mouse" ()
Declare Sub position_mouse CDecl Alias "position_mouse" (ByVal x As Integer, ByVal y As Integer)
Declare Sub position_mouse_z CDecl Alias "position_mouse_z" (ByVal z As Integer)
Declare Sub set_mouse_range CDecl Alias "set_mouse_range" (ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
Declare Sub set_mouse_speed CDecl Alias "set_mouse_speed" (ByVal xspeed As Integer, ByVal yspeed As Integer)
Declare Sub set_mouse_sprite CDecl Alias "set_mouse_sprite" (ByVal sprite As BITMAP Ptr)
Declare Sub set_mouse_sprite_focus CDecl Alias "set_mouse_sprite_focus" (ByVal x As Integer, ByVal y As Integer)
Declare Sub get_mouse_mickeys CDecl Alias "get_mouse_mickeys" (Byval mickeyx As Integer ptr, Byval mickeyy As Integer ptr)

' timer routines
Declare Function install_timer CDecl Alias "install_timer" () As Integer
Declare Sub remove_timer CDecl Alias "remove_timer" ()
Declare Function install_int CDecl Alias "install_int" (ByVal proc As Sub cdecl(), ByVal speed As Integer) As Integer
Declare Function install_int_ex CDecl Alias "install_int_ex" (ByVal proc As Sub cdecl(), ByVal speed As Integer) As Integer
Declare Sub remove_int CDecl Alias "remove_int" (ByVal proc As Sub cdecl())
Declare Function install_param_int CDecl Alias "install_param_int" (ByVal proc As Sub cdecl(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Function install_param_int_ex CDecl Alias "install_param_int_ex" (ByVal proc As Sub cdecl(ByVal p As Integer), ByVal param As Integer, ByVal speed As Integer) As Integer
Declare Sub remove_param_int CDecl Alias "remove_param_int" (ByVal proc As Sub cdecl(ByVal p As Integer), ByVal param As Integer)
Declare Function timer_can_simulate_retrace CDecl Alias "timer_can_simulate_retrace" () As Integer
Declare Sub timer_simulate_retrace CDecl Alias "timer_simulate_retrace" (ByVal enable As Integer)
Declare Function timer_is_using_retrace CDecl Alias "timer_is_using_retrace" () As Integer
Declare Sub rest CDecl Alias "rest" (ByVal time As Long)
Declare Sub rest_callback CDecl Alias "rest_callback" (ByVal time As Long, ByVal callback As Sub cdecl())

' keyboard routines
Declare Function install_keyboard CDecl Alias "install_keyboard" () As Integer
Declare Sub remove_keyboard CDecl Alias "remove_keyboard" ()
Declare Sub install_keyboard_hooks CDecl Alias "install_keyboard_hooks" (ByVal keypressed As Function cdecl() As Integer, ByVal readkey As Function cdecl() As Integer)
Declare Function poll_keyboard CDecl Alias "poll_keyboard" () As Integer
Declare Function keypressed CDecl Alias "keypressed" () As Integer
Declare Function readkey CDecl Alias "readkey" () As Integer
Declare Function ureadkey CDecl Alias "ureadkey" (ByRef scancode As Integer) As Integer
Declare Function scancode_to_ascii CDecl Alias "scancode_to_ascii" (ByVal scancode As Integer) As Integer
Declare Sub simulate_keypress CDecl Alias "simulate_keypress" (ByVal key As Integer)
Declare Sub simulate_ukeypress CDecl Alias "simulate_ukeypress" (ByVal key As Integer, ByVal scancode As Integer)
Declare Sub set_leds CDecl Alias "set_leds" (ByVal leds As Integer)
Declare Sub set_keyboard_rate CDecl Alias "set_keyboard_rate" (ByVal delay As Integer, ByVal repeat As Integer)
Declare Sub clear_keybuf CDecl Alias "clear_keybuf" ()

' joystick routines
Declare Function install_joystick CDecl Alias "install_joystick" (ByVal jtype As Integer) As Integer
Declare Sub remove_joystick CDecl Alias "remove_joystick" ()
Declare Function poll_joystick CDecl Alias "poll_joystick" () As Integer
Declare Function calibrate_joystick_name CDecl Alias "calibrate_joystick_name" (ByVal n As Integer) as zstring ptr
Declare Function calibrate_joystick CDecl Alias "calibrate_joystick" (ByVal n As Integer) As Integer
Declare Function save_joystick_data CDecl Alias "save_joystick_data" (ByVal filename As String) As Integer
Declare Function load_joystick_data CDecl Alias "load_joystick_data" (ByVal filename As String) As Integer
Declare Function initialise_joystick CDecl Alias "initialise_joystick" () As Integer

' graphics modes
Declare Sub set_color_depth CDecl Alias "set_color_depth" (ByVal depth As Integer)
Declare Sub request_refresh_rate CDecl Alias "request_refresh_rate" (ByVal rate As Integer)
Declare Function get_refresh_rate CDecl Alias "get_refresh_rate" () As Integer
Declare Function get_gfx_mode_list CDecl Alias "get_gfx_mode_list" (ByVal card As Integer) As GFX_MODE_LIST Ptr
Declare Sub destroy_gfx_mode_list CDecl Alias "destroy_gfx_mode_list" (ByVal mode_list As GFX_MODE_LIST Ptr)
Declare Function set_gfx_mode CDecl Alias "set_gfx_mode" (ByVal card As Integer, ByVal w As Integer, ByVal h As Integer, ByVal v_w As Integer, ByVal v_h As Integer)
Declare Function set_display_switch_mode CDecl Alias "set_display_switch_mode" (ByVal mode As Integer) As Integer
Declare Function set_display_switch_callback CDecl Alias "set_display_switch_callback" (ByVal dir As Integer, ByVal cb As Sub cdecl()) As Integer
Declare Sub remove_display_switch_callback CDecl Alias "remove_display_switch_callback" (ByVal cb As Sub cdecl())
Declare Function get_display_switch_mode CDecl Alias "get_display_switch_mode" () As Integer
Declare Function enable_triple_buffer CDecl Alias "enable_triple_buffer" () As Integer
Declare Function scroll_screen CDecl Alias "scroll_screen" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function request_scroll CDecl Alias "request_scroll" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function poll_scroll CDecl Alias "poll_scroll" () As Integer
Declare Function show_video_bitmap CDecl Alias "show_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function request_video_bitmap CDecl Alias "request_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Sub vsync CDecl Alias "vsync" ()

' bitmap objects
Declare Function create_bitmap CDecl Alias "create_bitmap" (ByVal w As Integer, ByVal h As Integer) as BITMAP Ptr
Declare Function create_bitmap_ex CDecl Alias "create_bitmap_ex" (ByVal color_depth As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_sub_bitmap CDecl Alias "create_sub_bitmap" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_video_bitmap CDecl Alias "create_video_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Function create_system_bitmap CDecl Alias "create_system_bitmap" (ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Sub destroy_bitmap CDecl Alias "destroy_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub lock_bitmap CDecl Alias "lock_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Function bitmap_color_depth CDecl Alias "bitmap_color_depth" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function bitmap_mask_color CDecl Alias "bitmap_mask_color" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_same_bitmap CDecl Alias "is_same_bitmap" (ByVal bmp1 As BITMAP Ptr, ByVal bmp2 As BITMAP Ptr) As Integer
Declare Function is_planar_bitmap CDecl Alias "is_planar_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_linear_bitmap CDecl Alias "is_linear_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_memory_bitmap CDecl Alias "is_memory_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_screen_bitmap CDecl Alias "is_screen_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_video_bitmap CDecl Alias "is_video_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Function is_sub_bitmap CDecl Alias "is_sub_bitmap" (ByVal bmp As BITMAP Ptr) As Integer
Declare Sub acquire_bitmap CDecl Alias "acquire_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub release_bitmap CDecl Alias "release_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub acquire_screen CDecl Alias "acquire_screen" ()
Declare Sub release_screen CDecl Alias "release_screen" ()
Declare Sub set_clip CDecl Alias "set_clip" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub set_clip_rect CDecl Alias "set_clip_rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub get_clip_rect CDecl Alias "get_clip_rect" (ByVal bmp As BITMAP Ptr, ByRef x1 As Integer, ByRef y1 As Integer, ByRef x2 As Integer, ByRef y2 As Integer)
'Declare Sub add_clip_rect CDecl Alias "add_clip_rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer)
'Declare Sub set_clip_state CDecl Alias "set_clip_state" (ByVal bmp As BITMAP Ptr, ByVal state As Integer)
'Declare Function get_clip_state CDecl Alias "get_clip_state" (ByVal bmp As BITMAP Ptr) As Integer
'Declare Function is_inside_bitmap CDecl Alias "is_inside_bitmap" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal clip As Integer) As Integer

' loading image files
Declare Function load_bitmap CDecl Alias "load_bitmap" (ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_bmp CDecl Alias "load_bmp" (ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_lbm CDecl Alias "load_lbm" (ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_pcx CDecl Alias "load_pcx" (ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function load_tga CDecl Alias "load_tga" (ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr
Declare Function save_bitmap CDecl Alias "save_bitmap" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_bmp CDecl Alias "save_bmp" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_pcx CDecl Alias "save_pcx" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Function save_tga CDecl Alias "save_tga" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr) As Integer
Declare Sub register_bitmap_file_type CDecl Alias "register_bitmap_file_type" (ByVal ext As String, ByVal load As Function cdecl(ByVal filename As String, ByVal pal As RGB Ptr) As BITMAP Ptr, ByVal save As sub cdecl(ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal pal As RGB Ptr))
Declare Sub set_color_conversion CDecl Alias "set_color_conversion" (ByVal mode As Integer)
Declare Function get_color_conversion CDecl Alias "get_color_conversion" () As Integer

' palette routines
Declare Sub set_color CDecl Alias "set_color" (ByVal index As Integer, ByVal p As RGB Ptr)
Declare Sub set_palette CDecl Alias "set_palette" (ByVal p As RGB Ptr)
Declare Sub set_palette_range CDecl Alias "set_palette_range" (ByVal p As RGB Ptr, ByVal from As Integer, ByVal iTo As Integer, ByVal vsync As Integer)
Declare Sub get_color CDecl Alias "get_color" (ByVal index As Integer, ByVal p As RGB Ptr)
Declare Sub get_palette CDecl Alias "get_palette" (ByVal p As RGB Ptr)
Declare Sub get_palette_range CDecl Alias "get_palette_range" (ByVal p As RGB Ptr, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_interpolate CDecl Alias "fade_interpolate" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal poutput As RGB Ptr, ByVal pos As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from_range CDecl Alias "fade_from_range" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_in_range CDecl Alias "fade_in_range" (ByVal p As RGB Ptr, ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_out_range CDecl Alias "fade_out_range" (ByVal speed As Integer, ByVal from As Integer, ByVal iTo As Integer)
Declare Sub fade_from CDecl Alias "fade_from" (ByVal source As RGB Ptr, ByVal dest As RGB Ptr, ByVal speed As Integer)
Declare Sub fade_in CDecl Alias "fade_in" (ByVal p As RGB Ptr, ByVal speed As Integer)
Declare Sub fade_out CDecl Alias "fade_out" (ByVal speed As Integer)
Declare Sub select_palette CDecl Alias "select_palette" (ByVal p As RGB Ptr)
Declare Sub unselect_palette CDecl Alias "unselect_palette" ()
Declare Sub generate_332_palette CDecl Alias "generate_332_palette" (ByVal pal As RGB ptr)
Declare Function generate_optimized_palette CDecl Alias "generate_optimized_palette" (ByVal bmp As BITMAP Ptr, ByVal pal As RGB ptr, ByVal rsvd As String) As Integer

' truecolor pixel formats
Declare Function makecol8 CDecl Alias "makecol8" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol15 CDecl Alias "makecol15" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol16 CDecl Alias "makecol16" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol24 CDecl Alias "makecol24" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol32 CDecl Alias "makecol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makeacol32 CDecl Alias "makeacol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makecol CDecl Alias "makecol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol_depth CDecl Alias "makecol_depth" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makeacol CDecl Alias "makeacol" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makeacol_depth CDecl Alias "makeacol" (ByVal color_depth As Integer, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
Declare Function makecol15_dither CDecl Alias "makecol15_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function makecol16_dither CDecl Alias "makecol16_dither" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getr8 CDecl Alias "getr8" (ByVal c As Integer) As Integer
Declare Function getg8 CDecl Alias "getg8" (ByVal c As Integer) As Integer
Declare Function getb8 CDecl Alias "getb8" (ByVal c As Integer) As Integer
Declare Function getr15 CDecl Alias "getr15" (ByVal c As Integer) As Integer
Declare Function getg15 CDecl Alias "getg15" (ByVal c As Integer) As Integer
Declare Function getb15 CDecl Alias "getb15" (ByVal c As Integer) As Integer
Declare Function getr16 CDecl Alias "getr16" (ByVal c As Integer) As Integer
Declare Function getg16 CDecl Alias "getg16" (ByVal c As Integer) As Integer
Declare Function getb16 CDecl Alias "getb16" (ByVal c As Integer) As Integer
Declare Function getr24 CDecl Alias "getr24" (ByVal c As Integer) As Integer
Declare Function getg24 CDecl Alias "getg24" (ByVal c As Integer) As Integer
Declare Function getb24 CDecl Alias "getb24" (ByVal c As Integer) As Integer
Declare Function getr32 CDecl Alias "getr32" (ByVal c As Integer) As Integer
Declare Function getg32 CDecl Alias "getg32" (ByVal c As Integer) As Integer
Declare Function getb32 CDecl Alias "getb32" (ByVal c As Integer) As Integer
Declare Function geta32 CDecl Alias "geta32" (ByVal c As Integer) As Integer
Declare Function getr CDecl Alias "getr" (ByVal c As Integer) As Integer
Declare Function getg CDecl Alias "getg" (ByVal c As Integer) As Integer
Declare Function getb CDecl Alias "getb" (ByVal c As Integer) As Integer
Declare Function geta CDecl Alias "geta" (ByVal c As Integer) As Integer
Declare Function getr_depth CDecl Alias "getr_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getg_depth CDecl Alias "getg_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function getb_depth CDecl Alias "getb_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer
Declare Function geta_depth CDecl Alias "geta_depth" (ByVal color_depth As Integer, ByVal c As Integer) As Integer

' drawing primitives
Declare Sub putpixel CDecl Alias "putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel8 CDecl Alias "_putpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel15 CDecl Alias "_putpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel16 CDecl Alias "_putpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel24 CDecl Alias "_putpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub putpixel32 CDecl Alias "_putpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Function getpixel CDecl Alias "getpixel" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel8 CDecl Alias "_getpixel8" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel15 CDecl Alias "_getpixel15" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel16 CDecl Alias "_getpixel16" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel24 CDecl Alias "_getpixel24" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function getpixel32 CDecl Alias "_getpixel32" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Sub vline CDecl Alias "vline" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y1 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub hline CDecl Alias "hline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y As Integer, ByVal x2 As Integer, ByVal c As Integer)
Declare Sub do_line CDecl Alias "do_line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal d As Integer, ByVal proc As Sub cdecl(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub line CDecl Alias "line" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub fastline CDecl Alias "fastline" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub triangle CDecl Alias "triangle" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal x3 As Integer, ByVal y3 As Integer, ByVal c As Integer)
Declare Sub polygon CDecl Alias "polygon" (ByVal bmp As BITMAP Ptr, ByVal vertices As Integer, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub rect CDecl Alias "rect" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub rectfill CDecl Alias "rectfill" (ByVal bmp As BITMAP Ptr, ByVal x1 As Integer, ByVal y1 As Integer, ByVal x2 As Integer, ByVal y2 As Integer, ByVal c As Integer)
Declare Sub do_circle CDecl Alias "do_circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal d As Integer, ByVal proc As Sub cdecl(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub circle CDecl Alias "circle" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer) ' note: this is called 'circle' in Allegro docs
Declare Sub circlefill CDecl Alias "circlefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal radius As Integer, ByVal c As Integer)
Declare Sub do_ellipse CDecl Alias "do_ellipse" (ByVal bmp As BITMAP Ptr, BYVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal d As Integer, ByVal proc As Sub cdecl(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub ellipse CDecl Alias "ellipse" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub ellipsefill CDecl Alias "ellipsefill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal rx As Integer, ByVal ry As Integer, ByVal c As Integer)
Declare Sub do_arc CDecl Alias "do_arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal a1 As fixed, ByVal a2 As fixed, ByVal r As Integer, ByVal d As Integer, ByVal proc As Sub cdecl(ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal d As Integer))
Declare Sub arc CDecl Alias "arc" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal ang1 As fixed, ByVal ang2 As fixed, ByVal r As Integer, ByVal c As Integer)
Declare Sub calc_spline CDecl Alias "calc_spline" (ByVal points As Integer Ptr, ByVal npts As Integer, ByRef x As Integer, ByRef y As Integer)
Declare Sub spline CDecl Alias "spline" (ByVal bmp As BITMAP Ptr, ByVal points As Integer Ptr, ByVal c As Integer)
Declare Sub floodfill CDecl Alias "floodfill" (ByVal bmp As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)

' blitting and sprites
Declare Sub clear_bitmap CDecl Alias "clear_bitmap" (ByVal bmp As BITMAP Ptr)
Declare Sub clear_to_color CDecl Alias "clear_to_color" (ByVal bmp As BITMAP Ptr, ByVal c As Integer)
Declare Sub blit CDecl Alias "blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub stretch_blit CDecl Alias "stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub masked_blit CDecl Alias "masked_blit" (ByVal source AS BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, BYVal source_y As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal width As Integer, ByVal height As Integer)
Declare Sub masked_stretch_blit CDecl Alias "masked_stretch_blit" (ByVal source As BITMAP Ptr, ByVal dest As BITMAP Ptr, ByVal source_x As Integer, ByVal source_y As Integer, ByVal source_width As Integer, ByVal source_height As Integer, ByVal dest_x As Integer, ByVal dest_y As Integer, ByVal dest_width As Integer, ByVal dest_height As Integer)
Declare Sub draw_sprite CDecl Alias "draw_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub stretch_sprite CDecl Alias "stretch_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub draw_sprite_v_flip CDecl Alias "draw_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_h_flip CDecl Alias "draw_sprite_h_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_sprite_vh_flip CDecl Alias "draw_sprite_vh_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_trans_sprite CDecl Alias "draw_trans_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer)
Declare Sub draw_lit_sprite CDecl Alias "draw_lit_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub draw_gouraud_sprite CDecl Alias "draw_gouraud_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c1 As Integer, ByVal c2 As Integer, ByVal c3 As Integer, ByVal c4 As Integer)
Declare Sub draw_character_ex CDecl Alias "draw_character_ex" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
Declare Sub rotate_sprite CDecl Alias "rotate_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_sprite_v_flip CDecl Alias "rotate_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed)
Declare Sub rotate_scaled_sprite CDecl Alias "rotate_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_sprite CDecl Alias "pivot_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_sprite_v_flip CDecl Alias "pivot_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed)
Declare Sub pivot_scaled_sprite CDecl Alias "pivot_scaled_sprite" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)
Declare Sub pivot_scaled_sprite_v_flip CDecl Alias "pivot_scaled_sprite_v_flip" (ByVal bmp As BITMAP Ptr, ByVal sprite As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal angle As fixed, ByVal scale As fixed)

' RLE sprites
declare function get_rle_sprite cdecl alias "get_rle_sprite" ( byval bmp as BITMAP ptr ) as RLE_SPRITE ptr
declare sub destroy_rle_sprite cdecl alias "destroy_rle_sprite" ( byval sprite as RLE_SPRITE ptr )

' compiled sprites
declare function get_compiled_sprite cdecl alias "get_compiled_sprite" ( byval bmp as BITMAP ptr , byval planar as integer ) as COMPILED_SPRITE ptr
declare sub destroy_compiled_sprite cdecl alias "destroy_compiled_sprite" ( byval sprite as COMPILED_SPRITE ptr )
declare sub draw_compiled_sprite cdecl alias "draw_compiled_sprite" ( byval bmp as BITMAP ptr, byval sprite as COMPILED_SPRITE ptr, byval x as integer, byval y as integer )

' text output
Declare Function text_mode CDecl Alias "text_mode" (ByVal mode As Integer) As Integer
Declare Sub textout CDecl Alias "textout" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_centre CDecl Alias "textout_centre" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_right CDecl Alias "textout_right" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer)
Declare Sub textout_justify CDecl Alias "textout_justify" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x1 As Integer, ByVal x2 As Integer, ByVal y As Integer, ByVal diff As Integer, ByVal c As Integer)
Declare Sub textprintf CDecl Alias "textprintf" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal s As String)
Declare Function text_length CDecl Alias "text_length" (ByVal f As FONT Ptr, ByVal s As String) As Integer
Declare Function text_height CDecl Alias "text_height" (ByVal f As FONT Ptr) As Integer
Declare Sub destroy_font CDecl Alias "destroy_font" (ByVal f As FONT Ptr)
'Declare Sub textout_ex CDecl Alias "textout_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_centre_ex CDecl Alias "textout_centre_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_right_ex CDecl Alias "textout_right_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textout_justify_ex CDecl Alias "textout_justify_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer, ByVal c As Integer, ByVal bg As Integer)
'Declare Sub textprintf_ex CDecl Alias "textprintf_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)
'Declare Sub textprintf_right_ex CDecl Alias "textprintf_right_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)
'Declare Sub textprintf_justify_ex CDecl Alias "textprintf_justify_ex" (ByVal bmp As BITMAP Ptr, ByVal f As FONT Ptr, ByVal s As String, ByVal x As Integer, ByVal y As Integer)

' polygon rendering
Declare Sub polygon3d CDecl Alias "polygon3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D Ptr)
Declare Sub polygon3d_f CDecl Alias "polygon3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D_f Ptr)
Declare Sub triangle3d CDecl Alias "triangle3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D)
Declare Sub triangle3d_f CDecl Alias "triangle3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f)
Declare Sub quad3d CDecl Alias "quad3d" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D, ByRef v2 As V3D, ByRef v3 As V3D, ByRef v4 As V3D)
Declare Sub quad3d_f CDecl Alias "quad3d_f" (ByVal bmp As BITMAP Ptr, ByVal typ As Integer, ByVal tex As BITMAP Ptr, ByRef v1 As V3D_f, ByRef v2 As V3D_f, ByRef v3 As V3D_f, ByRef v4 As V3D_f)
Declare Function clip3d_f CDecl Alias "clip3d_f" (ByVal typ As Integer, ByVal min_z As Single, ByVal max_z As Single, ByVal vc As Integer, vtx() As V3D_f Ptr, vout() As V3D_f Ptr, vtmp() As V3D_f Ptr, ByVal iOut As Integer Ptr) As Integer
Declare Function clip3d CDecl Alias "clip3d" (ByVal typ As Integer, ByVal min_z As fixed, ByVal max_z As fixed, ByVal vc As Integer, vtx() As V3D Ptr, vout() As V3D Ptr, vtmp() As V3D Ptr, ByVal iOut As Integer Ptr) As Integer
Declare Function create_zbuffer CDecl Alias "create_zbuffer" (ByVal parent As BITMAP Ptr, ByVal x As Integer, ByVal y As Integer, ByVal width As Integer, ByVal height As Integer) As BITMAP Ptr
Declare Sub set_zbuffer CDecl Alias "set_zbuffer" (ByVal buf As BITMAP Ptr)
Declare Sub clear_zbuffer CDecl Alias "clear_zbuffer" (ByVal zbuf As BITMAP Ptr, ByVal z As Single)
Declare Sub destroy_zbuffer CDecl Alias "destroy_zbuffer" (ByVal zbuf As BITMAP Ptr)
Declare Function create_scene CDecl Alias "create_scene" (ByVal nedge As Integer, ByVal npoly As Integer)
Declare Sub clear_scene CDecl Alias "clear_scene" (ByVal bmp As BITMAP Ptr)
Declare Sub destroy_scene CDecl Alias "destroy_scene" ()
Declare Function scene_polygon3d CDecl Alias "scene_polygon3d" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D Ptr)
Declare Function scene_polygon3d_f CDecl Alias "scene_polygon3d_f" (ByVal typ As Integer, ByVal texture As BITMAP Ptr, ByVal vc As Integer, vtx() As V3D_f Ptr)
Declare Sub render_scene CDecl Alias "render_scene" ()

' transparency and patterned drawing
Declare Sub drawing_mode CDecl Alias "drawing_mode" ( byval mode as integer, byval pattern as BITMAP ptr, byval x_anchor as integer, byval y_anchor as integer )
Declare Sub xor_mode CDecl Alias "xor_mode" (ByVal iOn As Integer)
Declare Sub solid_mode CDecl Alias "solid_mode" ()
Declare Sub create_trans_table CDecl Alias "create_trans_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As RGB Ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub cdecl(ByVal ipos As Integer))
Declare Sub create_light_table CDecl Alias "create_light_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As RGB Ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal callback As Sub cdecl(ByVal ipos As Integer))
Declare Sub create_color_table CDecl Alias "create_color_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As RGB Ptr, ByVal blend As Sub cdecl(ByVal pal As RGB Ptr, ByVal x As Integer, ByVal y As Integer, ByVal c As RGB Ptr), ByVal callback As Sub cdecl(ByVal ipos As Integer))
Declare Sub create_blender_table CDecl Alias "create_blender_table" (ByVal table As COLOR_MAP Ptr, ByVal pal As RGB Ptr, ByVal callback As Sub cdecl(ByVal ipos As Integer))
Declare Sub set_trans_blender CDecl Alias "set_trans_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_alpha_blender CDecl Alias "set_alpha_blender" ()
Declare Sub set_write_alpha_blender CDecl Alias "set_write_alpha_blender" ()
Declare Sub set_add_blender CDecl Alias "set_add_blender" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_burn_blender CDecl Alias "set_burn_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_color_blender CDecl Alias "set_color_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_difference_blender CDecl Alias "set_difference_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dissolve_blender CDecl Alias "set_dissolve_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_dodge_blender CDecl Alias "set_dodge_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_hue_blender CDecl Alias "set_hue_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_invert_blender CDecl Alias "set_invert_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_luminance_blender CDecl Alias "set_luminance_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_multiply_blender CDecl Alias "set_multiply_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_saturation_blender CDecl Alias "set_saturation_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_screen_blender CDecl Alias "set_screen_blender" (byVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_blender_mode CDecl Alias "set_blender_mode" (ByVal b15 As sub cdecl(), ByVal b16 as sub cdecl(), ByVal b24 as sub cdecl(), ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)
Declare Sub set_blender_mode_ex CDecl Alias "set_blender_mode_ex" (ByVal b15 as sub cdecl(), ByVal b16 as sub cdecl(), ByVal b24 as sub cdecl(), ByVal b32 as sub cdecl(), ByVal b15x as sub cdecl(), ByVal b16x as sub cdecl(), ByVal b24x as sub cdecl(), ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer)

' converting between color formats
Declare Function bestfit_color CDecl Alias "bestfit_color" (ByVal pal As RGB ptr, ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Sub create_rgb_table CDecl Alias "create_rgb_table" (ByVal table As RGB_MAP Ptr, ByVal pal As RGB Ptr, ByVal callback As Sub cdecl(ByVal ipos As Integer))
Declare Sub hsv_to_rgb CDecl Alias "hsv_to_rgb" (ByVal h As Single, ByVal s As Single, ByVal v As Single, ByRef r As Integer, ByRef g As Integer, ByRef b As Integer)
Declare Sub rgb_to_hsv CDecl Alias "rgb_to_hsv" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByRef h As Single, ByRef s As Single, ByRef v As Single)

' direct access to video memory
Declare Function bmp_write_line CDecl Alias "bmp_write_line" (ByVal bmp As BITMAP Ptr, ByVal iLine As Integer) As Unsigned Integer
Declare Function bmp_read_line CDecl Alias "bmp_read_line" (ByVal bmp As BITMAP Ptr, ByVal iLine As Integer) As Unsigned Integer
Declare Function bmp_unwrite_line CDecl Alias "bmp_unwrite_line" (ByVal bmp As BITMAP Ptr) As unsigned Integer

' FLIC routines
Declare Function play_fli CDecl Alias "play_fli" (ByVal filename As String, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function cdecl() As Integer) As Integer
Declare Function play_memory_fli CDecl Alias "play_memory_fli" (ByVal fli_data As Integer, ByVal bmp As BITMAP Ptr, ByVal iloop As Integer, ByVal callback As Function cdecl() As Integer) As Integer
Declare Function open_fli CDecl Alias "open_fli" (ByVal filename As String) As Integer
Declare Function open_memory_fli CDecl Alias "open_memory_fli" (ByVal fli_data As Integer) As Integer
Declare Sub close_fli CDecl Alias "close_fli" ()
Declare Function next_fli_frame CDecl Alias "next_fli_frame" (ByVal iloop As Integer) As Integer
Declare Sub reset_fli_variables CDecl Alias "reset_fli_variables" ()

' sound init routines
Declare Function detect_digi_driver CDecl Alias "detect_digi_driver" (ByVal driver_id As Integer) As Integer
Declare Function detect_midi_driver CDecl Alias "detect_midi_driver" (ByVal driver_id As Integer) As Integer
Declare Sub reserve_voices CDecl Alias "reserve_voices" (ByVal digi_voices As Integer, ByVal midi_voices As Integer)
Declare Sub set_volume_per_voice CDecl Alias "set_volume_per_voice" (ByVal scale As Integer)
Declare Function install_sound CDecl Alias "install_sound" (ByVal digi As Integer, ByVal midi As Integer, ByVal cfg_path As String) As Integer
Declare Sub remove_sound CDecl Alias "remove_sound"
Declare Sub set_volume CDecl Alias "set_volume" (ByVal digi_volume As Integer, ByVal midi_volume As Integer)

' digital sample routines
Declare Function load_sample CDecl Alias "load_sample" (ByVal filename As String) As SAMPLE Ptr
Declare Function load_wav CDecl Alias "load_wav" (ByVal filename As String) As SAMPLE Ptr
Declare Function load_voc CDecl Alias "load_voc" (BYVal filename As String) As SAMPLE Ptr
Declare Function create_sample CDecl Alias "create_sample" (ByVal bits As Integer, ByVal stereo As Integer, ByVal freq As Integer, ByVal iLen As Integer) As SAMPLE Ptr
Declare Sub destroy_sample CDecl Alias "destroy_sample" (ByVal spl As SAMPLE Ptr)
Declare Sub lock_sample CDecl Alias "lock_sample" (ByVal spl As SAMPLE Ptr)
Declare Function play_sample CDecl Alias "play_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)
Declare Sub adjust_sample CDecl Alias "adjust_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)
Declare Sub stop_sample CDecl Alias "stop_sample" (ByVal spl As SAMPLE Ptr)
Declare Function allocate_voice CDecl Alias "allocate_voice" (ByVal spl As SAMPLE Ptr) As Integer
Declare Sub deallocate_voice CDecl Alias "deallocate_voice" (ByVal voice As Integer)
Declare Sub reallocate_voice CDecl Alias "reallocate_voice" (ByVal voice As Integer, ByVal spl As SAMPLE Ptr)
Declare Sub release_voice CDecl Alias "release_Voice" (ByVal voice As Integer)
Declare Sub voice_start CDecl Alias "voice_start" (ByVal voice As Integer)
Declare Sub voice_stop CDecl Alias "voice_stop" (ByVal voice As Integer)
Declare Sub voice_set_priority CDecl Alias "voice_set_priority" (ByVal voice As Integer, ByVal priority As Integer)
Declare Function voice_check CDecl Alias "voice_check" (ByVal voice As Integer) As SAMPLE Ptr
Declare Function voice_get_position CDecl Alias "voice_get_position" (ByVal voice As Integer) As Integer
Declare Sub voice_set_position CDecl Alias "voice_set_position" (ByVal voice As Integer, ByVal position As Integer)
Declare Sub voice_set_playmode CDecl Alias "voice_set_playmode" (ByVal voice As Integer, ByVal playmode As Integer)
Declare Function voice_get_volume CDecl Alias "voice_get_volume" (ByVal voice As Integer) As Integer
Declare Sub voice_set_volume CDecl Alias "voice_set_volume" (ByVal voice As Integer, ByVal volume As Integer)
Declare Sub voice_ramp_volume CDecl Alias "voice_ramp_volume" (ByVal voice As Integer, ByVal itime As Integer, ByVal endvol As Integer)
Declare Sub voice_stop_volumeramp CDecl Alias "voice_stop_volumeramp" (ByVal voice As Integer)
Declare Function voice_get_frequency CDecl Alias "voice_get_frequency" (ByVal voice As Integer) As Integer
Declare Sub voice_set_frequency CDecl Alias "voice_set_frequency" (ByVal voice As Integer, BYVal frequency As Integer)
Declare Sub voice_sweep_frequency CDecl Alias "voice_sweep_frequency" (ByVal voice As Integer, bYvAl iTime As Integer, ByVal endfreq As Integer)
Declare Sub voice_stop_frequency_sweep CDecl Alias "voice_stop_frequency_sweep" (ByVal voice As Integer)
Declare Function voice_get_pan CDecl Alias "voice_get_pan" (ByVal voice As Integer) As Integer
Declare Sub voice_set_pan CDecl Alias "voice_set_pan" (ByVal voice As Integer, ByVal pan As Integer)
Declare Sub voice_sweep_pan CDecl Alias "voice_sweep_pan" (ByVal voice As Integer, ByVal iTime As Integer, ByVal endpan As Integer)
Declare Sub voice_stop_pan_sweep CDecl Alias "voice_stop_pan_sweep" (ByVal voice As Integer)
Declare Sub voice_set_echo CDecl Alias "voice_set_echo" (ByVal voice As Integer, BYVal strength As Integer, ByVal delay As Integer)
Declare Sub voice_set_tremolo CDecl Alias "voice_set_tremolo" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)
Declare Sub voice_set_vibrato CDecl Alias "voice_set_vibrato" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)

' music routines (MIDI)
Declare Function load_midi CDecl Alias "load_midi" (ByVal filename As String) As MIDI Ptr
Declare Sub destroy_midi CDecl Alias "destroy_midi" (ByVal midi As MIDI Ptr)
Declare Sub lock_midi CDecl Alias "lock_midi" (ByVal midi As MIDI Ptr)
Declare Function play_midi CDecl Alias "play_midi" (BYVal midi As MIDI Ptr, ByVal iloop As Integer) As Integer
Declare Function play_looped_midi CDecl Alias "play_looped_midi" (ByVal midi As MIDI Ptr, ByVal loop_start As Integer, ByVal loop_end As Integer) As Integer
Declare Sub stop_midi CDecl Alias "stop_midi" ()
Declare Sub midi_pause CDecl Alias "midi_pause" ()
Declare Sub midi_resume CDecl Alias "midi_resume" ()
Declare Function midi_seek CDecl Alias "midi_seek" (ByVal target As Integer) As Integer
Declare Sub midi_out CDecl Alias "midi_out" (ByVal dat As UByte Ptr, ByVal length As Integer)
Declare Function load_midi_patches CDecl Alias "load_midi_patches" () As Integer
Declare Function load_ibk CDecl Alias "load_ibk" (ByVal filename As String, ByVal drums As Integer) As Integer

' audio stream routines
declare function play_audio_stream cdecl alias "play_audio_stream" ( byval length as integer, byval bits as integer, byval stereo as integer, byval freq as integer, byval vol as integer, byval pan as integer ) as AUDIOSTREAM ptr
declare sub stop_audio_stream cdecl alias "stop_audio_stream" ( byval stream as AUDIOSTREAM ptr )
declare function get_audio_stream_buffer cdecl alias "get_audio_stream_buffer" ( byval stream as AUDIOSTREAM ptr ) as any ptr
declare sub free_audio_stream_buffer cdecl alias "get_audio_stream_buffer" ( byval stream as AUDIOSTREAM ptr )

' recording routines
Declare Function install_sound_input CDecl Alias "install_sound_input" (ByVal digi As Integer, ByVal midi As Integer) As Integer
Declare Sub remove_sound_input CDecl Alias "remove_sound_input" ()
Declare Function get_sound_input_cap_bits CDecl Alias "get_sound_input_cap_bits" () As Integer
Declare Function get_sound_input_cap_stereo CDecl Alias "get_sound_input_cap_stereo" () As Integer
Declare Function get_sound_input_cap_rate CDecl Alias "get_sound_input_cap_rate" (ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function get_sound_input_cap_parm CDecl Alias "get_sound_input_cap_parm" (BYVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function set_sound_input_source CDecl Alias "set_sound_input_source" (ByVal source As Integer) As Integer
Declare Function start_sound_input CDecl Alias "start_sound_input" (ByVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Sub stop_sound_input CDecl Alias "stop_sound_input" ()
Declare Function read_sound_input CDecl Alias "read_sound_input" (ByVal buffer As UByte Ptr)

' file and compression routines
' todo ...

' datafile routines
Declare Function load_datafile CDecl Alias "load_datafile" (ByVal filename As String) As DATAFILE Ptr
Declare Function load_datafile_callback CDecl Alias "load_datafile_callback" (ByVal filename As String, ByVal callback As Sub cdecl(ByVal d As DATAFILE Ptr)) As DATAFILE Ptr
Declare Sub unload_datafile CDecl Alias "unload_datafile" (ByVal dat As DATAFILE Ptr)
Declare Function load_datafile_object CDecl Alias "load_datafile_object" (ByVal filename As String, ByVal objectname As String) As DATAFILE Ptr
Declare Sub unload_datafile_object CDecl Alias "unload_datafile_object" (ByVal dat As DATAFILE Ptr)
Declare Function find_datafile_object CDecl Alias "find_datafile_object" (ByVal dat As DATAFILE Ptr, ByVal objectname As String) As DATAFILE Ptr
Declare Function get_datafile_property CDecl Alias "get_datafile_property" (ByVal dat As DATAFILE Ptr, ByVal typ As Integer) as zstring ptr
Declare Sub register_datafile_object CDecl Alias "register_datafile_object" (ByVal id As Integer, ByVal load As Sub cdecl(ByVal f As PACKFILE Ptr, ByVal size As Long), ByVal destroy As Sub cdecl(ByVal dat As Integer))
Declare Sub fixup_datafile CDecl Alias "fixup_datafile" (ByVal dat As DATAFILE Ptr)

' fixed point math routines
Declare Function itofix CDecl Alias "itofix" (ByVal x As Integer) As fixed
Declare Function fixtoi CDecl Alias "fixtoi" (ByVal x As fixed) As Integer
Declare Function fixfloor CDecl Alias "fixfloor" (ByVal x As fixed) As Integer
Declare Function fixceil CDecl Alias "fixceil" (ByVal x As fixed) As Integer
Declare Function ftofix CDecl Alias "ftofix" (ByVal x As Double) As fixed
Declare Function fixtof CDecl Alias "fixtof" (ByVal x As fixed) As Double
Declare Function fixmul CDecl Alias "fixmul" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixdiv CDecl Alias "fixdiv" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixadd CDecl Alias "fixadd" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixsub CDecl Alias "fixsub" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixsin CDecl Alias "fixsin" (ByVal x As fixed) As fixed
Declare Function fixcos CDecl Alias "fixcos" (ByVal x As fixed) As fixed
Declare Function fixtan CDecl Alias "fixtan" (ByVal x As fixed) As fixed
Declare Function fixasin CDecl Alias "fixasin" (ByVal x As fixed) As fixed
Declare Function fixacos CDecl Alias "fixacos" (ByVal x As fixed) As fixed
Declare Function fixatan CDecl Alias "fixatan" (ByVal x As fixed) As fixed
Declare Function fixatan2 CDecl Alias "fixatan2" (ByVal y As fixed, byVal x As fixed) As fixed
Declare Function fixsqrt CDecl Alias "fixsqrt" (ByVal x As fixed) As fixed
Declare Function fixhypot CDecl Alias "fixhypot" (ByVal x As fixed, ByVal y As fixed) As fixed

' 3D math routines
Declare Sub get_translation_matrix CDecl Alias "get_translation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_translation_matrix_f CDecl Alias "get_translation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_scaling_matrix CDecl Alias "get_scaling_matrix" (ByVal m As MATRIX Ptr, Byval x As fixed, ByVal y As fixed, ByVal z As fixed)
Declare Sub get_scaling_matrix_f CDecl Alias "get_scaling_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_x_rotate_matrix CDecl Alias "get_x_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_x_rotate_matrix_f CDecl Alias "get_x_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_y_rotate_matrix CDecl Alias "get_y_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_y_rotate_matrix_f CDecl Alias "get_y_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_z_rotate_matrix CDecl Alias "get_z_rotate_matrix" (ByVal m As MATRIX Ptr, ByVal r As fixed)
Declare Sub get_z_rotate_matrix_f CDecl Alias "get_z_rotate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal r As Single)
Declare Sub get_rotation_matrix CDecl Alias "get_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub get_rotation_matrix_f CDecl Alias "get_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub get_align_matrix CDecl Alias "get_align_matrix" (ByVal m As MATRIX Ptr, ByVal xfront As fixed, ByVal yfront As fixed, ByVal zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed)
Declare Sub get_align_matrix_f CDecl Alias "get_align_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, ByVal yup As Single, ByVal zup As Single)
Declare Sub get_vector_rotation_matrix CDecl Alias "get_vector_rotation_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, BYVal z AS fixed, ByVal a As fixed)
Declare Sub get_vector_rotation_matrix_f CDecl Alias "get_vector_rotation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal a As Single)
Declare Sub get_transformation_matrix CDecl Alias "get_transformation_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed, ByVal xrot As fixed, ByVal yrot As fixed, ByVal zrot As fixed, ByVal x As fixed, ByVal y As fixed, byVal z As fixed)
Declare Sub get_transformation_matrix_f CDecl Alias "get_transformation_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single, ByVal xrot As Single, BYVal yrot As Single, ByVal zrot As Single, ByVal x As Single, BYVal y As Single, ByVal z As Single)
Declare Sub get_camera_matrix CDecl Alias "get_camera_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, ByVal y As fixed, ByVal z As fixed, ByVal xfront As fixed, ByVal yfront As fixed, BYval zfront As fixed, ByVal xup As fixed, ByVal yup As fixed, ByVal zup As fixed, ByVal fov As fixed, ByVal aspect As fixed)
Declare Sub get_camera_matrix_f CDecl Alias "get_camera_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single, ByVal xfront As Single, ByVal yfront As Single, ByVal zfront As Single, ByVal xup As Single, BYVal yup As Single, ByVal zup As Single, ByVal fov As Single, Byval aspect As Single)
Declare Sub qtranslate_matrix CDecl Alias "qtranslate_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, ByVal z As fixed)
Declare Sub qtrnslate_matrix_f CDecl Alias "qtranslate_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As Single, ByVal z As Single)
Declare Sub qscale_matrix CDecl Alias "qscale_matrix" (ByVal m As MATRIX Ptr, ByVal scale As fixed)
Declare Sub qscale_matrix_f CDecl Alias "qscale_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal scale As Single)
Declare Sub matrix_mul CDecl Alias "matrix_mul" (ByVal m1 As MATRIX Ptr, ByVal m2 As MATRIX Ptr, ByVal mout As MATRIX Ptr)
Declare Sub matrix_mul_f CDecl Alias "matrix_mul_f" (ByVal m1 As MATRIX_f Ptr, ByVal m2 As MATRIX_f Ptr, ByVal mout As MATRIX_f Ptr)
Declare Function vector_length CDecl Alias "vector_length" (ByVal x As fixed, BYVal y As fixed, ByVal z As fixed) As fixed
Declare Function vector_lengtH_f CDecl Alias "vector_length_f" (ByVal x As Single, BYVal y As Single, ByVal z As Single) As SIngle
Declare Sub normalize_vector CDecl Alias "normalize_vector" (ByRef x As fixed, ByRef y As fixed, ByRef z As fixed)
Declare Sub normalize_vector_f CDecl Alias "normalize_vector_f" (ByRef x As Single, ByRef y As Single, ByRef z As Single)
Declare Function dot_product CDecl Alias "dot_product" (Byval x1 As fixed, ByVal y1 As fixed, ByVal z1 As fixed, ByVal x2 As fixed, ByVAl y2 As fixed, BYVal z2 As fixed) As fixed
Declare Function dot_product_f CDecl Alias "dot_product_f" (ByVal x1 As Single, ByVal y1 As Single, ByVal z1 As Single, ByVal x2 As Single, ByVal y2 AS Single, ByVal z2 As Single) As Single
Declare Sub cross_product CDecl Alias "cross_product" (ByVal x1 As fixed, BYVal y1 As fixed, ByVal z1 As fixed, BYVal x2 As fixed, BYVal y2 As fixed, ByVal z2 As fixed, ByRef xout As fixed, ByRef yout As fixed, ByRef zout As fixed)
Declare Sub cross_product_f CDecl Alias "cross_product_f" (ByVal x1 As Single, BYVal y1 As Single, ByVal z1 As Single, BYVal x2 As Single, BYVal y2 As Single, ByVal z2 As Single, ByRef xout As Single, ByRef yout As Single, ByRef zout As Single)
Declare Function polygon_z_normal CDecl Alias "polygon_z_normal" (ByVal v1 As V3D Ptr, Byval v2 As V3D Ptr, ByVal v3 As V3D Ptr) As fixed
Declare Function polygon_z_normal_f CDecl Alias "polygon_z_normal_f" (ByVal v1 As V3D_f Ptr, ByVal v2 As V3D_f ptr, ByVal v3 As V3D_f PTr) As Single
Declare Sub apply_matrix CDecl Alias "apply_matrix" (ByVal m As MATRIX Ptr, ByVal x As fixed, BYVal y As fixed, BYVal z As fixed, ByRef xout As fixed, BYRef yout As fixed, ByRef zout As fixed)
Declare Sub apply_matrix_f CDecl Alias "apply_matrix_f" (ByVal m As MATRIX_f Ptr, ByVal x As Single, ByVal y As SIngle, byVal z As Single, ByRef xout As Single, ByRef yout As Single, Byref zout As Single)
Declare Sub set_projection_viewport CDecl Alias "set_projection_viewport" (ByVal x As Integer, BYVal y As Integer, ByVal w As Integer, ByVal h As Integer)
Declare Sub persp_project CDecl Alias "persp_project" (ByVal x As fixed, ByVal y As fixed, BYVal z As fixed, ByRef xout As fixed, BYRef yout As fixed)
Declare Sub persp_project_f CDecl Alias "persp_project_f" (ByVal x As Single, ByVal y As Single, ByVal z As Single, ByRef xout As Single, ByRef yout As Single)

' quaternion math routines
Declare Sub quat_mul CDecl Alias "quat_mul" (byval p as QUAT ptr, byval q as QUAT ptr, byval outp as QUAT ptr)
Declare sub get_x_rotate_quat cdecl alias "get_x_rotate_quat" ( byval q as QUAT ptr, byval r as single)
Declare sub get_y_rotate_quat cdecl alias "get_y_rotate_quat" ( byval q as QUAT ptr, byval r as single)
Declare sub get_z_rotate_quat cdecl alias "get_z_rotate_quat" ( byval q as QUAT ptr, byval r as single)
declare sub get_rotation_quat cdecl alias "get_rotation_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single )
declare sub get_vector_rotation_quat cdecl alias "get_vector_rotation_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval a as single )
declare sub apply_quat cdecl alias "apply_quat" ( byval q as QUAT ptr, byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr )
declare sub quat_slerp cdecl alias "quat_slerp" ( byval pfrom as QUAT ptr, byval pto as QUAT ptr, byval t as single, byval outp as QUAT ptr, byval how as integer )
#define quat_interpolate(pfrom, pto, t, pout)   quat_slerp (pfrom), (pto), (t), (pout), QUAT_SHORT
declare sub quat_to_matrix cdecl alias "quat_to_matrix" ( byval q as QUAT ptr, byval m as MATRIX_f ptr )
declare sub matrix_to_quat cdecl alias "matrix_to_quat" ( byval m as MATRIX_f ptr, byval q as QUAT ptr )

' GUI routines
declare function d_yield_proc cdecl alias "d_yield_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_clear_proc cdecl alias "d_clear_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_box_proc cdecl alias "d_box_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_shadow_proc cdecl alias "d_shadow_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_bitmap_proc cdecl alias "d_bitmap_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_text_proc cdecl alias "d_text_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_ctext_proc cdecl alias "d_ctext_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_rtext_proc cdecl alias "d_rtext_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_button_proc cdecl alias "d_button_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_check_proc cdecl alias "d_check_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_radio_proc cdecl alias "d_radio_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_icon_proc cdecl alias "d_icon_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_keyboard_proc cdecl alias "d_keyboard_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_edit_proc cdecl alias "d_edit_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_list_proc cdecl alias "d_list_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_text_list_proc cdecl alias "d_text_list_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_textbox_proc cdecl alias "d_textbox_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_slider_proc cdecl alias "d_slider_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function d_menu_proc cdecl alias "d_menu_proc" ( byval msg as integer, byval d as DIALOG ptr, byval c as integer ) as integer
declare function gui_textout cdecl alias "gui_textout" ( byval bmp as BITMAP ptr, byval s as string, byval x as integer, byval y as integer, byval _color as integer, byval centre as integer) as integer
declare function gui_strlen cdecl alias "gui_strlen" ( byval s as string ) as integer
declare sub position_dialog cdecl alias "position_dialog" ( byval dlg as DIALOG ptr, byval x as integer, byval y as integer )
declare sub centre_dialog cdecl alias "centre_dialog" ( byval dlg as DiALOG ptr )
declare sub set_dialog_color cdecl alias "set_dialog_color" ( byval dlg as DIALOG ptr, byval fg as integer, byval bg as integer )
declare function find_dialog_focus cdecl alias "find_dialog_focus" ( byval dlg as DIALOG ptr ) as integer
declare function offer_focus cdecl alias "offer_focus" ( byval d as DIALOG ptr, byval obj as integer, byval focus_obj as integer ptr, byval force as integer ) as integer
declare function dialog_message cdecl alias "dialog_message" ( byval d as DIALOG ptr, byval msg as integer, byval c as integer, byval obj as integer ptr ) as integer
declare function broadcast_dialog_message cdecl alias "broadcast_dialog_message" ( byval msg as integer, byval c as integer ) as integer
declare function do_dialog cdecl alias "do_dialog" ( byval d as DIALOG ptr, byval focus_obj as integer ) as integer
declare function popup_dialog cdecl alias "popup_dialog" ( byval dlg as DIALOG ptr, byval focus_obj as integer ) as integer
declare function init_dialog cdecl alias "init_dialog" ( byval d as DIALOG ptr, byval focus_obj as integer ) as DIALOG_PLAYER ptr
declare function update_dialog cdecl alias "update_dialog" ( byval player as DIALOG_PLAYER) as integer
declare function shutdown_dialog cdecl alias "shutdown_dialog" ( byval player as DIALOG_PLAYER Ptr ) as integer
declare function do_menu cdecl alias "do_menu" ( byval menu as MENU ptr, byval x as integer, byval y as integer ) as integer
Declare Function alert CDecl Alias "alert" (ByVal s1 as String, ByVal s2 As String, ByVal s3 As String, ByVal b1 As String, ByVal b2 As String, ByVal c1 As String, ByVal c2 As String) As Integer
declare function alert3 cdecl alias "alert3" ( byval s1 as string, byval s2 as string, byval s3 as string, byval b1 as string, byval b2 as string, byval b3 as string, byval c1 as integer, byval c2 as integer, byval c3 as integer ) as integer
declare function file_select cdecl alias "file_select" ( byval message as string, byval path as byte ptr, byval ext as string ) as integer
declare function file_select_ex cdecl alias "file_select_ex" ( byval message as string, byval path as byte ptr, byval ext as string, byval size as integer, byval w as integer, byval h as integer ) as integer
Declare Function gfx_mode_select CDecl Alias "gfx_mode_select" (ByRef card As Integer, ByRef w As Integer, ByRef h As Integer) As Integer
Declare Function gfx_mode_select_ex CDecl Alias "gfx_mode_select_ex" (ByVal card As Integer Ptr, ByVal w As Integer Ptr, ByVal h As Integer Ptr, ByVal color_depth As Integer Ptr)

' debug facilities
declare sub al_assert cdecl alias "al_assert" ( byval file as string, byval _line as integer )
declare sub al_trace cdecl alias "al_trace" ( byval msg as string, ... )
declare sub register_assert_handler cdecl alias "register_assert_handler" ( byval handler as function cdecl(byval msg as byte ptr) as integer)
declare sub register_trace_handler cdecl alias "register_trace_handler" ( byval handler as function cdecl(byval msg as byte ptr) as integer)


' -- misc --

#define allegro_init() install_allegro(SYSTEM_AUTODETECT, @errno, @atexit)

#define SCREEN_W gfx_driver->w

#define SCREEN_H gfx_driver->h

#define SECS_TO_TIMER(secs) ((secs) * TIMERS_PER_SECOND)

#define MSEC_TO_TIMER(msec) ((msec) * (TIMERS_PER_SECOND / 1000))

#define BPS_TO_TIMER(bps) (TIMERS_PER_SECOND / (bps))

#define BPM_TO_TIMER(bpm) ((60 * TIMERS_PER_SECOND) / (bpm))

#define AL_RAND() rand()

#define AL_MIN(x,y) iif( (x) <= (y), (x), (y) )

#define AL_MAX(x,y) iif( (x) >= (y), (x), (y) )

' AL_MID is the fb equivalent of Allegro's MID
#define AL_MID(x,y,z) AL_MAX(x, AL_MIN(y, z))

' -- random hacks --

#ifdef __FB_LINUX__

extern __crt0_argc alias "__crt0_argc" as integer
extern __crt0_argv alias "__crt0_argv" as ubyte ptr ptr

redim shared __crt0_argp(0) as zstring ptr
redim shared __crt0_args(0) as string

'':::::	
private sub build_args constructor
	dim i as integer
	
	__crt0_argc = 0
	while (len(command(__crt0_argc)) > 0)
		redim preserve __crt0_argp(__crt0_argc + 1)
		redim preserve __crt0_args(__crt0_argc + 1)
		__crt0_args(__crt0_argc) = command(__crt0_argc)
		__crt0_argc += 1
	wend
	for i = 1 to __crt0_argc
		__crt0_argp(i) = cptr(zstring ptr, @__crt0_args(i))
	next i
	__crt0_argv = @__crt0_argp(0)
end sub

'':::::
public sub _mangled_main_address alias "_mangled_main_address"

end sub


#endif
