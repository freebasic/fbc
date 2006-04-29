''
''
'' allegro\keyboard -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_keyboard_bi__
#define __allegro_keyboard_bi__

#include once "allegro/base.bi"

type KEYBOARD_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	autorepeat as integer
	init as function cdecl() as integer
	exit as sub cdecl()
	poll as sub cdecl()
	set_leds as sub cdecl(byval as integer)
	set_rate as sub cdecl(byval as integer, byval as integer)
	wait_for_input as sub cdecl()
	stop_waiting_for_input as sub cdecl()
	scancode_to_ascii as function cdecl(byval as integer) as integer
end type

extern _AL_DLL keyboard_driver alias "keyboard_driver" as KEYBOARD_DRIVER ptr
extern _AL_DLL ___keyboard_driver_list alias "_keyboard_driver_list" as _DRIVER_INFO
#define _keyboard_driver_list(x) *(@___keyboard_driver_list + (x))

declare function install_keyboard cdecl alias "install_keyboard" () as integer
declare sub remove_keyboard cdecl alias "remove_keyboard" ()
declare function poll_keyboard cdecl alias "poll_keyboard" () as integer
declare function keyboard_needs_poll cdecl alias "keyboard_needs_poll" () as integer

extern _AL_DLL keyboard_callback alias "keyboard_callback" as function cdecl(byval as integer) as integer
extern _AL_DLL keyboard_ucallback alias "keyboard_ucallback" as function cdecl(byval as integer, byval as integer ptr) as integer
extern _AL_DLL keyboard_lowlevel_callback alias "keyboard_lowlevel_callback" as sub cdecl(byval as integer)

declare sub install_keyboard_hooks cdecl alias "install_keyboard_hooks" (byval keypressed as function cdecl() as integer, byval readkey as function cdecl() as integer)

extern _AL_DLL __key alias "key" as byte
#define key(x) *(@__key + (x))
extern _AL_DLL key_shifts alias "key_shifts" as integer
extern _AL_DLL three_finger_flag alias "three_finger_flag" as integer
extern _AL_DLL key_led_flag alias "key_led_flag" as integer

declare function keypressed cdecl alias "keypressed" () as integer
declare function readkey cdecl alias "readkey" () as integer
declare function ureadkey cdecl alias "ureadkey" (byval scancode as integer ptr) as integer
declare sub simulate_keypress cdecl alias "simulate_keypress" (byval keycode as integer)
declare sub simulate_ukeypress cdecl alias "simulate_ukeypress" (byval keycode as integer, byval scancode as integer)
declare sub clear_keybuf cdecl alias "clear_keybuf" ()
declare sub set_leds cdecl alias "set_leds" (byval leds as integer)
declare sub set_keyboard_rate cdecl alias "set_keyboard_rate" (byval delay as integer, byval repeat as integer)
declare function scancode_to_ascii cdecl alias "scancode_to_ascii" (byval scancode as integer) as integer

#define KB_SHIFT_FLAG &h0001
#define KB_CTRL_FLAG &h0002
#define KB_ALT_FLAG &h0004
#define KB_LWIN_FLAG &h0008
#define KB_RWIN_FLAG &h0010
#define KB_MENU_FLAG &h0020
#define KB_SCROLOCK_FLAG &h0100
#define KB_NUMLOCK_FLAG &h0200
#define KB_CAPSLOCK_FLAG &h0400
#define KB_INALTSEQ_FLAG &h0800
#define KB_ACCENT1_FLAG &h1000
#define KB_ACCENT2_FLAG &h2000
#define KB_ACCENT3_FLAG &h4000
#define KB_ACCENT4_FLAG &h8000
#define KEY_A 1
#define KEY_B 2
#define KEY_C 3
#define KEY_D 4
#define KEY_E 5
#define KEY_F 6
#define KEY_G 7
#define KEY_H 8
#define KEY_I 9
#define KEY_J 10
#define KEY_K 11
#define KEY_L 12
#define KEY_M 13
#define KEY_N 14
#define KEY_O 15
#define KEY_P 16
#define KEY_Q 17
#define KEY_R 18
#define KEY_S 19
#define KEY_T 20
#define KEY_U 21
#define KEY_V 22
#define KEY_W 23
#define KEY_X 24
#define KEY_Y 25
#define KEY_Z 26
#define KEY_0 27
#define KEY_1 28
#define KEY_2 29
#define KEY_3 30
#define KEY_4 31
#define KEY_5 32
#define KEY_6 33
#define KEY_7 34
#define KEY_8 35
#define KEY_9 36
#define KEY_0_PAD 37
#define KEY_1_PAD 38
#define KEY_2_PAD 39
#define KEY_3_PAD 40
#define KEY_4_PAD 41
#define KEY_5_PAD 42
#define KEY_6_PAD 43
#define KEY_7_PAD 44
#define KEY_8_PAD 45
#define KEY_9_PAD 46
#define KEY_F1 47
#define KEY_F2 48
#define KEY_F3 49
#define KEY_F4 50
#define KEY_F5 51
#define KEY_F6 52
#define KEY_F7 53
#define KEY_F8 54
#define KEY_F9 55
#define KEY_F10 56
#define KEY_F11 57
#define KEY_F12 58
#define KEY_ESC 59
#define KEY_TILDE 60
#define KEY_MINUS 61
#define KEY_EQUALS 62
#define KEY_BACKSPACE 63
#define KEY_TAB 64
#define KEY_OPENBRACE 65
#define KEY_CLOSEBRACE 66
#define KEY_ENTER 67
#define KEY_COLON 68
#define KEY_QUOTE 69
#define KEY_BACKSLASH 70
#define KEY_BACKSLASH2 71
#define KEY_COMMA 72
#define KEY_STOP 73
#define KEY_SLASH 74
#define KEY_SPACE 75
#define KEY_INSERT 76
#define KEY_DEL 77
#define KEY_HOME 78
#define KEY_END 79
#define KEY_PGUP 80
#define KEY_PGDN 81
#define KEY_LEFT 82
#define KEY_RIGHT 83
#define KEY_UP 84
#define KEY_DOWN 85
#define KEY_SLASH_PAD 86
#define KEY_ASTERISK 87
#define KEY_MINUS_PAD 88
#define KEY_PLUS_PAD 89
#define KEY_DEL_PAD 90
#define KEY_ENTER_PAD 91
#define KEY_PRTSCR 92
#define KEY_PAUSE 93
#define KEY_ABNT_C1 94
#define KEY_YEN 95
#define KEY_KANA 96
#define KEY_CONVERT 97
#define KEY_NOCONVERT 98
#define KEY_AT 99
#define KEY_CIRCUMFLEX 100
#define KEY_COLON2 101
#define KEY_KANJI 102
#define KEY_MODIFIERS 103
#define KEY_LSHIFT 103
#define KEY_RSHIFT 104
#define KEY_LCONTROL 105
#define KEY_RCONTROL 106
#define KEY_ALT 107
#define KEY_ALTGR 108
#define KEY_LWIN 109
#define KEY_RWIN 110
#define KEY_MENU 111
#define KEY_SCRLOCK 112
#define KEY_NUMLOCK 113
#define KEY_CAPSLOCK 114
#define KEY_MAX 115

#endif
