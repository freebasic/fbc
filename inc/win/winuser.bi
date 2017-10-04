'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "user32"

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "_mingw.bi"
#include once "crt/stdarg.bi"
#include once "guiddef.bi"

'' The following symbols have been renamed:
''     typedef INPUT => INPUT_

extern "Windows"

#define _WINUSER_
type HDWP as HANDLE
type MENUTEMPLATEA as any
type MENUTEMPLATEW as any
type LPMENUTEMPLATEA as PVOID
type LPMENUTEMPLATEW as PVOID

#ifdef UNICODE
	type MENUTEMPLATE as MENUTEMPLATEW
	type LPMENUTEMPLATE as LPMENUTEMPLATEW
#else
	type MENUTEMPLATE as MENUTEMPLATEA
	type LPMENUTEMPLATE as LPMENUTEMPLATEA
#endif

type WNDPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as LRESULT
type DLGPROC as function(byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as INT_PTR
type TIMERPROC as sub(byval as HWND, byval as UINT, byval as UINT_PTR, byval as DWORD)
type GRAYSTRINGPROC as function(byval as HDC, byval as LPARAM, byval as long) as WINBOOL
type WNDENUMPROC as function(byval as HWND, byval as LPARAM) as WINBOOL
type ENUMWINDOWSPROC as WNDENUMPROC  '' custom name for backwards-compatibility (it existed in old headers despite being undocumented)
type HOOKPROC as function(byval code as long, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
type SENDASYNCPROC as sub(byval as HWND, byval as UINT, byval as ULONG_PTR, byval as LRESULT)
type PROPENUMPROCA as function(byval as HWND, byval as LPCSTR, byval as HANDLE) as WINBOOL
type PROPENUMPROCW as function(byval as HWND, byval as LPCWSTR, byval as HANDLE) as WINBOOL
type PROPENUMPROCEXA as function(byval as HWND, byval as LPSTR, byval as HANDLE, byval as ULONG_PTR) as WINBOOL
type PROPENUMPROCEXW as function(byval as HWND, byval as LPWSTR, byval as HANDLE, byval as ULONG_PTR) as WINBOOL
type EDITWORDBREAKPROCA as function(byval lpch as LPSTR, byval ichCurrent as long, byval cch as long, byval code as long) as long
type EDITWORDBREAKPROCW as function(byval lpch as LPWSTR, byval ichCurrent as long, byval cch as long, byval code as long) as long
type DRAWSTATEPROC as function(byval hdc as HDC, byval lData as LPARAM, byval wData as WPARAM, byval cx as long, byval cy as long) as WINBOOL

#ifdef UNICODE
	type PROPENUMPROC as PROPENUMPROCW
	type PROPENUMPROCEX as PROPENUMPROCEXW
	type EDITWORDBREAKPROC as EDITWORDBREAKPROCW
#else
	type PROPENUMPROC as PROPENUMPROCA
	type PROPENUMPROCEX as PROPENUMPROCEXA
	type EDITWORDBREAKPROC as EDITWORDBREAKPROCA
#endif

type NAMEENUMPROCA as function(byval as LPSTR, byval as LPARAM) as WINBOOL
type NAMEENUMPROCW as function(byval as LPWSTR, byval as LPARAM) as WINBOOL
type WINSTAENUMPROCA as NAMEENUMPROCA
type WINSTAENUMPROCW as NAMEENUMPROCW
type DESKTOPENUMPROCA as NAMEENUMPROCA
type DESKTOPENUMPROCW as NAMEENUMPROCW

#ifdef UNICODE
	type WINSTAENUMPROC as WINSTAENUMPROCW
	type DESKTOPENUMPROC as DESKTOPENUMPROCW
#else
	type WINSTAENUMPROC as WINSTAENUMPROCA
	type DESKTOPENUMPROC as DESKTOPENUMPROCA
#endif

#define IS_INTRESOURCE(_r) ((cast(ULONG_PTR, (_r)) shr 16) = 0)
#define MAKEINTRESOURCEA(i) cast(LPSTR, cast(ULONG_PTR, cast(WORD, (i))))
#define MAKEINTRESOURCEW(i) cast(LPWSTR, cast(ULONG_PTR, cast(WORD, (i))))

#ifdef UNICODE
	#define MAKEINTRESOURCE MAKEINTRESOURCEW
#else
	#define MAKEINTRESOURCE MAKEINTRESOURCEA
#endif

#define RT_CURSOR MAKEINTRESOURCE(1)
#define RT_BITMAP MAKEINTRESOURCE(2)
#define RT_ICON MAKEINTRESOURCE(3)
#define RT_MENU MAKEINTRESOURCE(4)
#define RT_DIALOG MAKEINTRESOURCE(5)
#define RT_STRING MAKEINTRESOURCE(6)
#define RT_FONTDIR MAKEINTRESOURCE(7)
#define RT_FONT MAKEINTRESOURCE(8)
#define RT_ACCELERATOR MAKEINTRESOURCE(9)
#define RT_RCDATA MAKEINTRESOURCE(10)
#define RT_MESSAGETABLE MAKEINTRESOURCE(11)
const DIFFERENCE = 11
#define RT_GROUP_CURSOR MAKEINTRESOURCE(cast(ULONG_PTR, RT_CURSOR) + DIFFERENCE)
#define RT_GROUP_ICON MAKEINTRESOURCE(cast(ULONG_PTR, RT_ICON) + DIFFERENCE)
#define RT_VERSION MAKEINTRESOURCE(16)
#define RT_DLGINCLUDE MAKEINTRESOURCE(17)
#define RT_PLUGPLAY MAKEINTRESOURCE(19)
#define RT_VXD MAKEINTRESOURCE(20)
#define RT_ANICURSOR MAKEINTRESOURCE(21)
#define RT_ANIICON MAKEINTRESOURCE(22)
#define RT_HTML MAKEINTRESOURCE(23)
#define RT_MANIFEST MAKEINTRESOURCE(24)
#define CREATEPROCESS_MANIFEST_RESOURCE_ID MAKEINTRESOURCE(1)
#define ISOLATIONAWARE_MANIFEST_RESOURCE_ID MAKEINTRESOURCE(2)
#define ISOLATIONAWARE_NOSTATICIMPORT_MANIFEST_RESOURCE_ID MAKEINTRESOURCE(3)
#define MINIMUM_RESERVED_MANIFEST_RESOURCE_ID MAKEINTRESOURCE(1)
#define MAXIMUM_RESERVED_MANIFEST_RESOURCE_ID MAKEINTRESOURCE(16)

#ifdef UNICODE
	#define wvsprintf wvsprintfW
	#define wsprintf wsprintfW
#else
	#define wvsprintf wvsprintfA
	#define wsprintf wsprintfA
#endif

declare function wvsprintfA(byval as LPSTR, byval as LPCSTR, byval arglist as va_list) as long
declare function wvsprintfW(byval as LPWSTR, byval as LPCWSTR, byval arglist as va_list) as long
declare function wsprintfA cdecl(byval as LPSTR, byval as LPCSTR, ...) as long
declare function wsprintfW cdecl(byval as LPWSTR, byval as LPCWSTR, ...) as long

const SETWALLPAPER_DEFAULT = cast(LPWSTR, -1)
const SB_HORZ = 0
const SB_VERT = 1
const SB_CTL = 2
const SB_BOTH = 3
const SB_LINEUP = 0
const SB_LINELEFT = 0
const SB_LINEDOWN = 1
const SB_LINERIGHT = 1
const SB_PAGEUP = 2
const SB_PAGELEFT = 2
const SB_PAGEDOWN = 3
const SB_PAGERIGHT = 3
const SB_THUMBPOSITION = 4
const SB_THUMBTRACK = 5
const SB_TOP = 6
const SB_LEFT = 6
const SB_BOTTOM = 7
const SB_RIGHT = 7
const SB_ENDSCROLL = 8
const SW_HIDE = 0
const SW_SHOWNORMAL = 1
const SW_NORMAL = 1
const SW_SHOWMINIMIZED = 2
const SW_SHOWMAXIMIZED = 3
const SW_MAXIMIZE = 3
const SW_SHOWNOACTIVATE = 4
const SW_SHOW = 5
const SW_MINIMIZE = 6
const SW_SHOWMINNOACTIVE = 7
const SW_SHOWNA = 8
const SW_RESTORE = 9
const SW_SHOWDEFAULT = 10
const SW_FORCEMINIMIZE = 11
const SW_MAX = 11
const HIDE_WINDOW = 0
const SHOW_OPENWINDOW = 1
const SHOW_ICONWINDOW = 2
const SHOW_FULLSCREEN = 3
const SHOW_OPENNOACTIVATE = 4
const SW_PARENTCLOSING = 1
const SW_OTHERZOOM = 2
const SW_PARENTOPENING = 3
const SW_OTHERUNZOOM = 4
const AW_HOR_POSITIVE = &h00000001
const AW_HOR_NEGATIVE = &h00000002
const AW_VER_POSITIVE = &h00000004
const AW_VER_NEGATIVE = &h00000008
const AW_CENTER = &h00000010
const AW_HIDE = &h00010000
const AW_ACTIVATE = &h00020000
const AW_SLIDE = &h00040000
const AW_BLEND = &h00080000
const KF_EXTENDED = &h0100
const KF_DLGMODE = &h0800
const KF_MENUMODE = &h1000
const KF_ALTDOWN = &h2000
const KF_REPEAT = &h4000
const KF_UP = &h8000
const VK_LBUTTON = &h01
const VK_RBUTTON = &h02
const VK_CANCEL = &h03
const VK_MBUTTON = &h04
const VK_XBUTTON1 = &h05
const VK_XBUTTON2 = &h06
const VK_BACK = &h08
const VK_TAB = &h09
const VK_CLEAR = &h0C
const VK_RETURN = &h0D
const VK_SHIFT = &h10
const VK_CONTROL = &h11
const VK_MENU = &h12
const VK_PAUSE = &h13
const VK_CAPITAL = &h14
const VK_KANA = &h15
const VK_HANGEUL = &h15
const VK_HANGUL = &h15
const VK_JUNJA = &h17
const VK_FINAL = &h18
const VK_HANJA = &h19
const VK_KANJI = &h19
const VK_ESCAPE = &h1B
const VK_CONVERT = &h1C
const VK_NONCONVERT = &h1D
const VK_ACCEPT = &h1E
const VK_MODECHANGE = &h1F
const VK_SPACE = &h20
const VK_PRIOR = &h21
const VK_NEXT = &h22
const VK_END = &h23
const VK_HOME = &h24
const VK_LEFT = &h25
const VK_UP = &h26
const VK_RIGHT = &h27
const VK_DOWN = &h28
const VK_SELECT = &h29
const VK_PRINT = &h2A
const VK_EXECUTE = &h2B
const VK_SNAPSHOT = &h2C
const VK_INSERT = &h2D
const VK_DELETE = &h2E
const VK_HELP = &h2F
const VK_0 = &h30
const VK_1 = &h31
const VK_2 = &h32
const VK_3 = &h33
const VK_4 = &h34
const VK_5 = &h35
const VK_6 = &h36
const VK_7 = &h37
const VK_8 = &h38
const VK_9 = &h39
const VK_A = &h41
const VK_B = &h42
const VK_C = &h43
const VK_D = &h44
const VK_E = &h45
const VK_F = &h46
const VK_G = &h47
const VK_H = &h48
const VK_I = &h49
const VK_J = &h4A
const VK_K = &h4B
const VK_L = &h4C
const VK_M = &h4D
const VK_N = &h4E
const VK_O = &h4F
const VK_P = &h50
const VK_Q = &h51
const VK_R = &h52
const VK_S = &h53
const VK_T = &h54
const VK_U = &h55
const VK_V = &h56
const VK_W = &h57
const VK_X = &h58
const VK_Y = &h59
const VK_Z = &h5A
const VK_LWIN = &h5B
const VK_RWIN = &h5C
const VK_APPS = &h5D
const VK_SLEEP = &h5F
const VK_NUMPAD0 = &h60
const VK_NUMPAD1 = &h61
const VK_NUMPAD2 = &h62
const VK_NUMPAD3 = &h63
const VK_NUMPAD4 = &h64
const VK_NUMPAD5 = &h65
const VK_NUMPAD6 = &h66
const VK_NUMPAD7 = &h67
const VK_NUMPAD8 = &h68
const VK_NUMPAD9 = &h69
const VK_MULTIPLY = &h6A
const VK_ADD = &h6B
const VK_SEPARATOR = &h6C
const VK_SUBTRACT = &h6D
const VK_DECIMAL = &h6E
const VK_DIVIDE = &h6F
const VK_F1 = &h70
const VK_F2 = &h71
const VK_F3 = &h72
const VK_F4 = &h73
const VK_F5 = &h74
const VK_F6 = &h75
const VK_F7 = &h76
const VK_F8 = &h77
const VK_F9 = &h78
const VK_F10 = &h79
const VK_F11 = &h7A
const VK_F12 = &h7B
const VK_F13 = &h7C
const VK_F14 = &h7D
const VK_F15 = &h7E
const VK_F16 = &h7F
const VK_F17 = &h80
const VK_F18 = &h81
const VK_F19 = &h82
const VK_F20 = &h83
const VK_F21 = &h84
const VK_F22 = &h85
const VK_F23 = &h86
const VK_F24 = &h87
const VK_NUMLOCK = &h90
const VK_SCROLL = &h91
const VK_OEM_NEC_EQUAL = &h92
const VK_OEM_FJ_JISHO = &h92
const VK_OEM_FJ_MASSHOU = &h93
const VK_OEM_FJ_TOUROKU = &h94
const VK_OEM_FJ_LOYA = &h95
const VK_OEM_FJ_ROYA = &h96
const VK_LSHIFT = &hA0
const VK_RSHIFT = &hA1
const VK_LCONTROL = &hA2
const VK_RCONTROL = &hA3
const VK_LMENU = &hA4
const VK_RMENU = &hA5
const VK_BROWSER_BACK = &hA6
const VK_BROWSER_FORWARD = &hA7
const VK_BROWSER_REFRESH = &hA8
const VK_BROWSER_STOP = &hA9
const VK_BROWSER_SEARCH = &hAA
const VK_BROWSER_FAVORITES = &hAB
const VK_BROWSER_HOME = &hAC
const VK_VOLUME_MUTE = &hAD
const VK_VOLUME_DOWN = &hAE
const VK_VOLUME_UP = &hAF
const VK_MEDIA_NEXT_TRACK = &hB0
const VK_MEDIA_PREV_TRACK = &hB1
const VK_MEDIA_STOP = &hB2
const VK_MEDIA_PLAY_PAUSE = &hB3
const VK_LAUNCH_MAIL = &hB4
const VK_LAUNCH_MEDIA_SELECT = &hB5
const VK_LAUNCH_APP1 = &hB6
const VK_LAUNCH_APP2 = &hB7
const VK_OEM_1 = &hBA
const VK_OEM_PLUS = &hBB
const VK_OEM_COMMA = &hBC
const VK_OEM_MINUS = &hBD
const VK_OEM_PERIOD = &hBE
const VK_OEM_2 = &hBF
const VK_OEM_3 = &hC0
const VK_OEM_4 = &hDB
const VK_OEM_5 = &hDC
const VK_OEM_6 = &hDD
const VK_OEM_7 = &hDE
const VK_OEM_8 = &hDF
const VK_OEM_AX = &hE1
const VK_OEM_102 = &hE2
const VK_ICO_HELP = &hE3
const VK_ICO_00 = &hE4
const VK_PROCESSKEY = &hE5
const VK_ICO_CLEAR = &hE6
const VK_PACKET = &hE7
const VK_OEM_RESET = &hE9
const VK_OEM_JUMP = &hEA
const VK_OEM_PA1 = &hEB
const VK_OEM_PA2 = &hEC
const VK_OEM_PA3 = &hED
const VK_OEM_WSCTRL = &hEE
const VK_OEM_CUSEL = &hEF
const VK_OEM_ATTN = &hF0
const VK_OEM_FINISH = &hF1
const VK_OEM_COPY = &hF2
const VK_OEM_AUTO = &hF3
const VK_OEM_ENLW = &hF4
const VK_OEM_BACKTAB = &hF5
const VK_ATTN = &hF6
const VK_CRSEL = &hF7
const VK_EXSEL = &hF8
const VK_EREOF = &hF9
const VK_PLAY = &hFA
const VK_ZOOM = &hFB
const VK_NONAME = &hFC
const VK_PA1 = &hFD
const VK_OEM_CLEAR = &hFE
const WH_MIN = -1
const WH_MSGFILTER = -1
const WH_JOURNALRECORD = 0
const WH_JOURNALPLAYBACK = 1
const WH_KEYBOARD = 2
const WH_GETMESSAGE = 3
const WH_CALLWNDPROC = 4
const WH_CBT = 5
const WH_SYSMSGFILTER = 6
const WH_MOUSE = 7
const WH_HARDWARE = 8
const WH_DEBUG = 9
const WH_SHELL = 10
const WH_FOREGROUNDIDLE = 11
const WH_CALLWNDPROCRET = 12
const WH_KEYBOARD_LL = 13
const WH_MOUSE_LL = 14
const WH_MAX = 14
const WH_MINHOOK = WH_MIN
const WH_MAXHOOK = WH_MAX
const HC_ACTION = 0
const HC_GETNEXT = 1
const HC_SKIP = 2
const HC_NOREMOVE = 3
const HC_NOREM = HC_NOREMOVE
const HC_SYSMODALON = 4
const HC_SYSMODALOFF = 5
const HCBT_MOVESIZE = 0
const HCBT_MINMAX = 1
const HCBT_QS = 2
const HCBT_CREATEWND = 3
const HCBT_DESTROYWND = 4
const HCBT_ACTIVATE = 5
const HCBT_CLICKSKIPPED = 6
const HCBT_KEYSKIPPED = 7
const HCBT_SYSCOMMAND = 8
const HCBT_SETFOCUS = 9
type tagCREATESTRUCTA as tagCREATESTRUCTA_

type tagCBT_CREATEWNDA
	lpcs as tagCREATESTRUCTA ptr
	hwndInsertAfter as HWND
end type

type CBT_CREATEWNDA as tagCBT_CREATEWNDA
type LPCBT_CREATEWNDA as tagCBT_CREATEWNDA ptr
type tagCREATESTRUCTW as tagCREATESTRUCTW_

type tagCBT_CREATEWNDW
	lpcs as tagCREATESTRUCTW ptr
	hwndInsertAfter as HWND
end type

type CBT_CREATEWNDW as tagCBT_CREATEWNDW
type LPCBT_CREATEWNDW as tagCBT_CREATEWNDW ptr

#ifdef UNICODE
	type CBT_CREATEWND as CBT_CREATEWNDW
	type LPCBT_CREATEWND as LPCBT_CREATEWNDW
#else
	type CBT_CREATEWND as CBT_CREATEWNDA
	type LPCBT_CREATEWND as LPCBT_CREATEWNDA
#endif

type tagCBTACTIVATESTRUCT
	fMouse as WINBOOL
	hWndActive as HWND
end type

type CBTACTIVATESTRUCT as tagCBTACTIVATESTRUCT
type LPCBTACTIVATESTRUCT as tagCBTACTIVATESTRUCT ptr

type tagWTSSESSION_NOTIFICATION
	cbSize as DWORD
	dwSessionId as DWORD
end type

type WTSSESSION_NOTIFICATION as tagWTSSESSION_NOTIFICATION
type PWTSSESSION_NOTIFICATION as tagWTSSESSION_NOTIFICATION ptr
const WTS_CONSOLE_CONNECT = &h1
const WTS_CONSOLE_DISCONNECT = &h2
const WTS_REMOTE_CONNECT = &h3
const WTS_REMOTE_DISCONNECT = &h4
const WTS_SESSION_LOGON = &h5
const WTS_SESSION_LOGOFF = &h6
const WTS_SESSION_LOCK = &h7
const WTS_SESSION_UNLOCK = &h8
const WTS_SESSION_REMOTE_CONTROL = &h9
const WTS_SESSION_CREATE = &ha
const WTS_SESSION_TERMINATE = &hb
const MSGF_DIALOGBOX = 0
const MSGF_MESSAGEBOX = 1
const MSGF_MENU = 2
const MSGF_SCROLLBAR = 5
const MSGF_NEXTWINDOW = 6
const MSGF_MAX = 8
const MSGF_USER = 4096
const HSHELL_WINDOWCREATED = 1
const HSHELL_WINDOWDESTROYED = 2
const HSHELL_ACTIVATESHELLWINDOW = 3
const HSHELL_WINDOWACTIVATED = 4
const HSHELL_GETMINRECT = 5
const HSHELL_REDRAW = 6
const HSHELL_TASKMAN = 7
const HSHELL_LANGUAGE = 8
const HSHELL_SYSMENU = 9
const HSHELL_ENDTASK = 10
const HSHELL_ACCESSIBILITYSTATE = 11
const HSHELL_APPCOMMAND = 12
const HSHELL_WINDOWREPLACED = 13
const HSHELL_WINDOWREPLACING = 14

#if _WIN32_WINNT = &h0602
	const HSHELL_MONITORCHANGED = 16
#endif

const HSHELL_HIGHBIT = &h8000
const HSHELL_FLASH = HSHELL_REDRAW or HSHELL_HIGHBIT
const HSHELL_RUDEAPPACTIVATED = HSHELL_WINDOWACTIVATED or HSHELL_HIGHBIT
const ACCESS_STICKYKEYS = &h0001
const ACCESS_FILTERKEYS = &h0002
const ACCESS_MOUSEKEYS = &h0003
const APPCOMMAND_BROWSER_BACKWARD = 1
const APPCOMMAND_BROWSER_FORWARD = 2
const APPCOMMAND_BROWSER_REFRESH = 3
const APPCOMMAND_BROWSER_STOP = 4
const APPCOMMAND_BROWSER_SEARCH = 5
const APPCOMMAND_BROWSER_FAVORITES = 6
const APPCOMMAND_BROWSER_HOME = 7
const APPCOMMAND_VOLUME_MUTE = 8
const APPCOMMAND_VOLUME_DOWN = 9
const APPCOMMAND_VOLUME_UP = 10
const APPCOMMAND_MEDIA_NEXTTRACK = 11
const APPCOMMAND_MEDIA_PREVIOUSTRACK = 12
const APPCOMMAND_MEDIA_STOP = 13
const APPCOMMAND_MEDIA_PLAY_PAUSE = 14
const APPCOMMAND_LAUNCH_MAIL = 15
const APPCOMMAND_LAUNCH_MEDIA_SELECT = 16
const APPCOMMAND_LAUNCH_APP1 = 17
const APPCOMMAND_LAUNCH_APP2 = 18
const APPCOMMAND_BASS_DOWN = 19
const APPCOMMAND_BASS_BOOST = 20
const APPCOMMAND_BASS_UP = 21
const APPCOMMAND_TREBLE_DOWN = 22
const APPCOMMAND_TREBLE_UP = 23
const APPCOMMAND_MICROPHONE_VOLUME_MUTE = 24
const APPCOMMAND_MICROPHONE_VOLUME_DOWN = 25
const APPCOMMAND_MICROPHONE_VOLUME_UP = 26
const APPCOMMAND_HELP = 27
const APPCOMMAND_FIND = 28
const APPCOMMAND_NEW = 29
const APPCOMMAND_OPEN = 30
const APPCOMMAND_CLOSE = 31
const APPCOMMAND_SAVE = 32
const APPCOMMAND_PRINT = 33
const APPCOMMAND_UNDO = 34
const APPCOMMAND_REDO = 35
const APPCOMMAND_COPY = 36
const APPCOMMAND_CUT = 37
const APPCOMMAND_PASTE = 38
const APPCOMMAND_REPLY_TO_MAIL = 39
const APPCOMMAND_FORWARD_MAIL = 40
const APPCOMMAND_SEND_MAIL = 41
const APPCOMMAND_SPELL_CHECK = 42
const APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE = 43
const APPCOMMAND_MIC_ON_OFF_TOGGLE = 44
const APPCOMMAND_CORRECTION_LIST = 45
const APPCOMMAND_MEDIA_PLAY = 46
const APPCOMMAND_MEDIA_PAUSE = 47
const APPCOMMAND_MEDIA_RECORD = 48
const APPCOMMAND_MEDIA_FAST_FORWARD = 49
const APPCOMMAND_MEDIA_REWIND = 50
const APPCOMMAND_MEDIA_CHANNEL_UP = 51
const APPCOMMAND_MEDIA_CHANNEL_DOWN = 52

#if _WIN32_WINNT >= &h0600
	const APPCOMMAND_DELETE = 53
	const APPCOMMAND_DWM_FLIP3D = 54
#endif

const FAPPCOMMAND_MOUSE = &h8000
const FAPPCOMMAND_KEY = 0
const FAPPCOMMAND_OEM = &h1000
const FAPPCOMMAND_MASK = &hF000
#define GET_APPCOMMAND_LPARAM(lParam) cshort(HIWORD(lParam) and (not FAPPCOMMAND_MASK))
#define GET_DEVICE_LPARAM(lParam) cast(WORD, HIWORD(lParam) and FAPPCOMMAND_MASK)
#define GET_MOUSEORKEY_LPARAM GET_DEVICE_LPARAM
#define GET_FLAGS_LPARAM(lParam) LOWORD(lParam)
#define GET_KEYSTATE_LPARAM(lParam) GET_FLAGS_LPARAM(lParam)

type SHELLHOOKINFO
	hwnd as HWND
	rc as RECT
end type

type LPSHELLHOOKINFO as SHELLHOOKINFO ptr

type tagEVENTMSG
	message as UINT
	paramL as UINT
	paramH as UINT
	time as DWORD
	hwnd as HWND
end type

type EVENTMSG as tagEVENTMSG
type PEVENTMSGMSG as tagEVENTMSG ptr
type NPEVENTMSGMSG as tagEVENTMSG ptr
type LPEVENTMSGMSG as tagEVENTMSG ptr
type PEVENTMSG as tagEVENTMSG ptr
type NPEVENTMSG as tagEVENTMSG ptr
type LPEVENTMSG as tagEVENTMSG ptr

type tagCWPSTRUCT
	lParam as LPARAM
	wParam as WPARAM
	message as UINT
	hwnd as HWND
end type

type CWPSTRUCT as tagCWPSTRUCT
type PCWPSTRUCT as tagCWPSTRUCT ptr
type NPCWPSTRUCT as tagCWPSTRUCT ptr
type LPCWPSTRUCT as tagCWPSTRUCT ptr

type tagCWPRETSTRUCT
	lResult as LRESULT
	lParam as LPARAM
	wParam as WPARAM
	message as UINT
	hwnd as HWND
end type

type CWPRETSTRUCT as tagCWPRETSTRUCT
type PCWPRETSTRUCT as tagCWPRETSTRUCT ptr
type NPCWPRETSTRUCT as tagCWPRETSTRUCT ptr
type LPCWPRETSTRUCT as tagCWPRETSTRUCT ptr

const LLKHF_EXTENDED = KF_EXTENDED shr 8
const LLKHF_INJECTED = &h00000010
const LLKHF_ALTDOWN = KF_ALTDOWN shr 8
const LLKHF_UP = KF_UP shr 8
const LLMHF_INJECTED = &h00000001

type tagKBDLLHOOKSTRUCT
	vkCode as DWORD
	scanCode as DWORD
	flags as DWORD
	time as DWORD
	dwExtraInfo as ULONG_PTR
end type

type KBDLLHOOKSTRUCT as tagKBDLLHOOKSTRUCT
type LPKBDLLHOOKSTRUCT as tagKBDLLHOOKSTRUCT ptr
type PKBDLLHOOKSTRUCT as tagKBDLLHOOKSTRUCT ptr

type tagMSLLHOOKSTRUCT
	pt as POINT
	mouseData as DWORD
	flags as DWORD
	time as DWORD
	dwExtraInfo as ULONG_PTR
end type

type MSLLHOOKSTRUCT as tagMSLLHOOKSTRUCT
type LPMSLLHOOKSTRUCT as tagMSLLHOOKSTRUCT ptr
type PMSLLHOOKSTRUCT as tagMSLLHOOKSTRUCT ptr

type tagDEBUGHOOKINFO
	idThread as DWORD
	idThreadInstaller as DWORD
	lParam as LPARAM
	wParam as WPARAM
	code as long
end type

type DEBUGHOOKINFO as tagDEBUGHOOKINFO
type PDEBUGHOOKINFO as tagDEBUGHOOKINFO ptr
type NPDEBUGHOOKINFO as tagDEBUGHOOKINFO ptr
type LPDEBUGHOOKINFO as tagDEBUGHOOKINFO ptr

type tagMOUSEHOOKSTRUCT
	pt as POINT
	hwnd as HWND
	wHitTestCode as UINT
	dwExtraInfo as ULONG_PTR
end type

type MOUSEHOOKSTRUCT as tagMOUSEHOOKSTRUCT
type LPMOUSEHOOKSTRUCT as tagMOUSEHOOKSTRUCT ptr
type PMOUSEHOOKSTRUCT as tagMOUSEHOOKSTRUCT ptr

type tagMOUSEHOOKSTRUCTEX
	__unnamed as MOUSEHOOKSTRUCT
	mouseData as DWORD
end type

type MOUSEHOOKSTRUCTEX as tagMOUSEHOOKSTRUCTEX
type LPMOUSEHOOKSTRUCTEX as tagMOUSEHOOKSTRUCTEX ptr
type PMOUSEHOOKSTRUCTEX as tagMOUSEHOOKSTRUCTEX ptr

type tagHARDWAREHOOKSTRUCT
	hwnd as HWND
	message as UINT
	wParam as WPARAM
	lParam as LPARAM
end type

type HARDWAREHOOKSTRUCT as tagHARDWAREHOOKSTRUCT
type LPHARDWAREHOOKSTRUCT as tagHARDWAREHOOKSTRUCT ptr
type PHARDWAREHOOKSTRUCT as tagHARDWAREHOOKSTRUCT ptr

const HKL_PREV = 0
const HKL_NEXT = 1
const KLF_ACTIVATE = &h00000001
const KLF_SUBSTITUTE_OK = &h00000002
const KLF_REORDER = &h00000008
const KLF_REPLACELANG = &h00000010
const KLF_NOTELLSHELL = &h00000080
const KLF_SETFORPROCESS = &h00000100
const KLF_SHIFTLOCK = &h00010000
const KLF_RESET = &h40000000
const INPUTLANGCHANGE_SYSCHARSET = &h0001
const INPUTLANGCHANGE_FORWARD = &h0002
const INPUTLANGCHANGE_BACKWARD = &h0004
const KL_NAMELENGTH = 9
declare function LoadKeyboardLayoutA(byval pwszKLID as LPCSTR, byval Flags as UINT) as HKL

#ifndef UNICODE
	declare function LoadKeyboardLayout alias "LoadKeyboardLayoutA"(byval pwszKLID as LPCSTR, byval Flags as UINT) as HKL
#endif

declare function LoadKeyboardLayoutW(byval pwszKLID as LPCWSTR, byval Flags as UINT) as HKL

#ifdef UNICODE
	declare function LoadKeyboardLayout alias "LoadKeyboardLayoutW"(byval pwszKLID as LPCWSTR, byval Flags as UINT) as HKL
#endif

declare function ActivateKeyboardLayout(byval hkl as HKL, byval Flags as UINT) as HKL
declare function ToUnicodeEx(byval wVirtKey as UINT, byval wScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval pwszBuff as LPWSTR, byval cchBuff as long, byval wFlags as UINT, byval dwhkl as HKL) as long
declare function UnloadKeyboardLayout(byval hkl as HKL) as WINBOOL
declare function GetKeyboardLayoutNameA(byval pwszKLID as LPSTR) as WINBOOL

#ifndef UNICODE
	declare function GetKeyboardLayoutName alias "GetKeyboardLayoutNameA"(byval pwszKLID as LPSTR) as WINBOOL
#endif

declare function GetKeyboardLayoutNameW(byval pwszKLID as LPWSTR) as WINBOOL

#ifdef UNICODE
	declare function GetKeyboardLayoutName alias "GetKeyboardLayoutNameW"(byval pwszKLID as LPWSTR) as WINBOOL
#endif

declare function GetKeyboardLayoutList(byval nBuff as long, byval lpList as HKL ptr) as long
declare function GetKeyboardLayout(byval idThread as DWORD) as HKL

type tagMOUSEMOVEPOINT
	x as long
	y as long
	time as DWORD
	dwExtraInfo as ULONG_PTR
end type

type MOUSEMOVEPOINT as tagMOUSEMOVEPOINT
type PMOUSEMOVEPOINT as tagMOUSEMOVEPOINT ptr
type LPMOUSEMOVEPOINT as tagMOUSEMOVEPOINT ptr
declare function GetMouseMovePointsEx(byval cbSize as UINT, byval lppt as LPMOUSEMOVEPOINT, byval lpptBuf as LPMOUSEMOVEPOINT, byval nBufPoints as long, byval resolution as DWORD) as long

const GMMP_USE_DISPLAY_POINTS = 1
const GMMP_USE_HIGH_RESOLUTION_POINTS = 2
const DESKTOP_READOBJECTS = &h0001
const DESKTOP_CREATEWINDOW = &h0002
const DESKTOP_CREATEMENU = &h0004
const DESKTOP_HOOKCONTROL = &h0008
const DESKTOP_JOURNALRECORD = &h0010
const DESKTOP_JOURNALPLAYBACK = &h0020
const DESKTOP_ENUMERATE = &h0040
const DESKTOP_WRITEOBJECTS = &h0080
const DESKTOP_SWITCHDESKTOP = &h0100
const DF_ALLOWOTHERACCOUNTHOOK = &h0001
declare function CreateDesktopA(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as LPDEVMODEA, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK

#ifndef UNICODE
	declare function CreateDesktop alias "CreateDesktopA"(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as LPDEVMODEA, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK
#endif

declare function CreateDesktopW(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as LPDEVMODEW, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK

#ifdef UNICODE
	declare function CreateDesktop alias "CreateDesktopW"(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as LPDEVMODEW, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK
#endif

declare function CreateDesktopExA(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as DEVMODEA ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK

#ifndef UNICODE
	declare function CreateDesktopEx alias "CreateDesktopExA"(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as DEVMODEA ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK
#endif

declare function CreateDesktopExW(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as DEVMODEW ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK

#ifdef UNICODE
	declare function CreateDesktopEx alias "CreateDesktopExW"(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as DEVMODEW ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK
#endif

declare function OpenDesktopA(byval lpszDesktop as LPCSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK

#ifndef UNICODE
	declare function OpenDesktop alias "OpenDesktopA"(byval lpszDesktop as LPCSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
#endif

declare function OpenDesktopW(byval lpszDesktop as LPCWSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK

#ifdef UNICODE
	declare function OpenDesktop alias "OpenDesktopW"(byval lpszDesktop as LPCWSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
#endif

declare function OpenInputDesktop(byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
declare function EnumDesktopsA(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCA, byval lParam as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function EnumDesktops alias "EnumDesktopsA"(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCA, byval lParam as LPARAM) as WINBOOL
#endif

declare function EnumDesktopsW(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCW, byval lParam as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function EnumDesktops alias "EnumDesktopsW"(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCW, byval lParam as LPARAM) as WINBOOL
#endif

declare function EnumDesktopWindows(byval hDesktop as HDESK, byval lpfn as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function SwitchDesktop(byval hDesktop as HDESK) as WINBOOL
declare function SetThreadDesktop(byval hDesktop as HDESK) as WINBOOL
declare function CloseDesktop(byval hDesktop as HDESK) as WINBOOL
declare function GetThreadDesktop(byval dwThreadId as DWORD) as HDESK

const WINSTA_ENUMDESKTOPS = &h0001
const WINSTA_READATTRIBUTES = &h0002
const WINSTA_ACCESSCLIPBOARD = &h0004
const WINSTA_CREATEDESKTOP = &h0008
const WINSTA_WRITEATTRIBUTES = &h0010
const WINSTA_ACCESSGLOBALATOMS = &h0020
const WINSTA_EXITWINDOWS = &h0040
const WINSTA_ENUMERATE = &h0100
const WINSTA_READSCREEN = &h0200
const WINSTA_ALL_ACCESS = (((((((WINSTA_ENUMDESKTOPS or WINSTA_READATTRIBUTES) or WINSTA_ACCESSCLIPBOARD) or WINSTA_CREATEDESKTOP) or WINSTA_WRITEATTRIBUTES) or WINSTA_ACCESSGLOBALATOMS) or WINSTA_EXITWINDOWS) or WINSTA_ENUMERATE) or WINSTA_READSCREEN
const CWF_CREATE_ONLY = &h00000001
const WSF_VISIBLE = &h0001
declare function CreateWindowStationA(byval lpwinsta as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA

#ifndef UNICODE
	declare function CreateWindowStation alias "CreateWindowStationA"(byval lpwinsta as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA
#endif

declare function CreateWindowStationW(byval lpwinsta as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA

#ifdef UNICODE
	declare function CreateWindowStation alias "CreateWindowStationW"(byval lpwinsta as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA
#endif

declare function OpenWindowStationA(byval lpszWinSta as LPCSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA

#ifndef UNICODE
	declare function OpenWindowStation alias "OpenWindowStationA"(byval lpszWinSta as LPCSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA
#endif

declare function OpenWindowStationW(byval lpszWinSta as LPCWSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA

#ifdef UNICODE
	declare function OpenWindowStation alias "OpenWindowStationW"(byval lpszWinSta as LPCWSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA
#endif

declare function EnumWindowStationsA(byval lpEnumFunc as WINSTAENUMPROCA, byval lParam as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function EnumWindowStations alias "EnumWindowStationsA"(byval lpEnumFunc as WINSTAENUMPROCA, byval lParam as LPARAM) as WINBOOL
#endif

declare function EnumWindowStationsW(byval lpEnumFunc as WINSTAENUMPROCW, byval lParam as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function EnumWindowStations alias "EnumWindowStationsW"(byval lpEnumFunc as WINSTAENUMPROCW, byval lParam as LPARAM) as WINBOOL
#endif

declare function CloseWindowStation(byval hWinSta as HWINSTA) as WINBOOL
declare function SetProcessWindowStation(byval hWinSta as HWINSTA) as WINBOOL
declare function GetProcessWindowStation() as HWINSTA
declare function SetUserObjectSecurity(byval hObj as HANDLE, byval pSIRequested as PSECURITY_INFORMATION, byval pSID as PSECURITY_DESCRIPTOR) as WINBOOL
declare function GetUserObjectSecurity(byval hObj as HANDLE, byval pSIRequested as PSECURITY_INFORMATION, byval pSID as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL

const UOI_FLAGS = 1
const UOI_NAME = 2
const UOI_TYPE = 3
const UOI_USER_SID = 4

#if _WIN32_WINNT >= &h0600
	const UOI_HEAPSIZE = 5
	const UOI_IO = 6
#endif

type tagUSEROBJECTFLAGS
	fInherit as WINBOOL
	fReserved as WINBOOL
	dwFlags as DWORD
end type

type USEROBJECTFLAGS as tagUSEROBJECTFLAGS
type PUSEROBJECTFLAGS as tagUSEROBJECTFLAGS ptr
declare function GetUserObjectInformationA(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetUserObjectInformation alias "GetUserObjectInformationA"(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
#endif

declare function GetUserObjectInformationW(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetUserObjectInformation alias "GetUserObjectInformationW"(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
#endif

declare function SetUserObjectInformationA(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetUserObjectInformation alias "SetUserObjectInformationA"(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL
#endif

declare function SetUserObjectInformationW(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetUserObjectInformation alias "SetUserObjectInformationW"(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL
#endif

type tagWNDCLASSEXA
	cbSize as UINT
	style as UINT
	lpfnWndProc as WNDPROC
	cbClsExtra as long
	cbWndExtra as long
	hInstance as HINSTANCE
	hIcon as HICON
	hCursor as HCURSOR
	hbrBackground as HBRUSH
	lpszMenuName as LPCSTR
	lpszClassName as LPCSTR
	hIconSm as HICON
end type

type WNDCLASSEXA as tagWNDCLASSEXA
type PWNDCLASSEXA as tagWNDCLASSEXA ptr
type NPWNDCLASSEXA as tagWNDCLASSEXA ptr
type LPWNDCLASSEXA as tagWNDCLASSEXA ptr

type tagWNDCLASSEXW
	cbSize as UINT
	style as UINT
	lpfnWndProc as WNDPROC
	cbClsExtra as long
	cbWndExtra as long
	hInstance as HINSTANCE
	hIcon as HICON
	hCursor as HCURSOR
	hbrBackground as HBRUSH
	lpszMenuName as LPCWSTR
	lpszClassName as LPCWSTR
	hIconSm as HICON
end type

type WNDCLASSEXW as tagWNDCLASSEXW
type PWNDCLASSEXW as tagWNDCLASSEXW ptr
type NPWNDCLASSEXW as tagWNDCLASSEXW ptr
type LPWNDCLASSEXW as tagWNDCLASSEXW ptr

#ifdef UNICODE
	type WNDCLASSEX as WNDCLASSEXW
	type PWNDCLASSEX as PWNDCLASSEXW
	type NPWNDCLASSEX as NPWNDCLASSEXW
	type LPWNDCLASSEX as LPWNDCLASSEXW
#else
	type WNDCLASSEX as WNDCLASSEXA
	type PWNDCLASSEX as PWNDCLASSEXA
	type NPWNDCLASSEX as NPWNDCLASSEXA
	type LPWNDCLASSEX as LPWNDCLASSEXA
#endif

type tagWNDCLASSA
	style as UINT
	lpfnWndProc as WNDPROC
	cbClsExtra as long
	cbWndExtra as long
	hInstance as HINSTANCE
	hIcon as HICON
	hCursor as HCURSOR
	hbrBackground as HBRUSH
	lpszMenuName as LPCSTR
	lpszClassName as LPCSTR
end type

type WNDCLASSA as tagWNDCLASSA
type PWNDCLASSA as tagWNDCLASSA ptr
type NPWNDCLASSA as tagWNDCLASSA ptr
type LPWNDCLASSA as tagWNDCLASSA ptr

type tagWNDCLASSW
	style as UINT
	lpfnWndProc as WNDPROC
	cbClsExtra as long
	cbWndExtra as long
	hInstance as HINSTANCE
	hIcon as HICON
	hCursor as HCURSOR
	hbrBackground as HBRUSH
	lpszMenuName as LPCWSTR
	lpszClassName as LPCWSTR
end type

type WNDCLASSW as tagWNDCLASSW
type PWNDCLASSW as tagWNDCLASSW ptr
type NPWNDCLASSW as tagWNDCLASSW ptr
type LPWNDCLASSW as tagWNDCLASSW ptr

#ifdef UNICODE
	type WNDCLASS as WNDCLASSW
	type PWNDCLASS as PWNDCLASSW
	type NPWNDCLASS as NPWNDCLASSW
	type LPWNDCLASS as LPWNDCLASSW
#else
	type WNDCLASS as WNDCLASSA
	type PWNDCLASS as PWNDCLASSA
	type NPWNDCLASS as NPWNDCLASSA
	type LPWNDCLASS as LPWNDCLASSA
#endif

declare function IsHungAppWindow(byval hwnd as HWND) as WINBOOL
declare sub DisableProcessWindowsGhosting()

type tagMSG
	hwnd as HWND
	message as UINT
	wParam as WPARAM
	lParam as LPARAM
	time as DWORD
	pt as POINT
end type

type MSG as tagMSG
type PMSG as tagMSG ptr
type NPMSG as tagMSG ptr
type LPMSG as tagMSG ptr

#macro POINTSTOPOINT(pt, pts)
	scope
		(pt).x = cast(LONG, cast(SHORT, LOWORD(*cptr(LONG ptr, @pts))))
		(pt).y = cast(LONG, cast(SHORT, HIWORD(*cptr(LONG ptr, @pts))))
	end scope
#endmacro
#define POINTTOPOINTS(pt) MAKELONG(cshort((pt).x), cshort((pt).y))
#define MAKEWPARAM(l, h) cast(WPARAM, cast(DWORD, MAKELONG(l, h)))
#define MAKELPARAM(l, h) cast(LPARAM, cast(DWORD, MAKELONG(l, h)))
#define MAKELRESULT(l, h) cast(LRESULT, cast(DWORD, MAKELONG(l, h)))
const GWL_WNDPROC = -4
const GWL_HINSTANCE = -6
const GWL_HWNDPARENT = -8
const GWL_STYLE = -16
const GWL_EXSTYLE = -20
const GWL_USERDATA = -21
const GWL_ID = -12

#ifdef __FB_64BIT__
	#undef GWL_WNDPROC
	#undef GWL_HINSTANCE
	#undef GWL_HWNDPARENT
	#undef GWL_USERDATA
#endif

const GWLP_WNDPROC = -4
const GWLP_HINSTANCE = -6
const GWLP_HWNDPARENT = -8
const GWLP_USERDATA = -21
const GWLP_ID = -12
const GCL_MENUNAME = -8
const GCL_HBRBACKGROUND = -10
const GCL_HCURSOR = -12
const GCL_HICON = -14
const GCL_HMODULE = -16
const GCL_CBWNDEXTRA = -18
const GCL_CBCLSEXTRA = -20
const GCL_WNDPROC = -24
const GCL_STYLE = -26
const GCW_ATOM = -32
const GCL_HICONSM = -34

#ifdef __FB_64BIT__
	#undef GCL_MENUNAME
	#undef GCL_HBRBACKGROUND
	#undef GCL_HCURSOR
	#undef GCL_HICON
	#undef GCL_HMODULE
	#undef GCL_WNDPROC
	#undef GCL_HICONSM
#endif

const GCLP_MENUNAME = -8
const GCLP_HBRBACKGROUND = -10
const GCLP_HCURSOR = -12
const GCLP_HICON = -14
const GCLP_HMODULE = -16
const GCLP_WNDPROC = -24
const GCLP_HICONSM = -34
const WM_NULL = &h0000
const WM_CREATE = &h0001
const WM_DESTROY = &h0002
const WM_MOVE = &h0003
const WM_SIZE = &h0005
const WM_ACTIVATE = &h0006
const WA_INACTIVE = 0
const WA_ACTIVE = 1
const WA_CLICKACTIVE = 2
const WM_SETFOCUS = &h0007
const WM_KILLFOCUS = &h0008
const WM_ENABLE = &h000A
const WM_SETREDRAW = &h000B
const WM_SETTEXT = &h000C
const WM_GETTEXT = &h000D
const WM_GETTEXTLENGTH = &h000E
const WM_PAINT = &h000F
const WM_CLOSE = &h0010
const WM_QUERYENDSESSION = &h0011
const WM_QUERYOPEN = &h0013
const WM_ENDSESSION = &h0016
const WM_QUIT = &h0012
const WM_ERASEBKGND = &h0014
const WM_SYSCOLORCHANGE = &h0015
const WM_SHOWWINDOW = &h0018
const WM_WININICHANGE = &h001A
const WM_SETTINGCHANGE = WM_WININICHANGE
const WM_DEVMODECHANGE = &h001B
const WM_ACTIVATEAPP = &h001C
const WM_FONTCHANGE = &h001D
const WM_TIMECHANGE = &h001E
const WM_CANCELMODE = &h001F
const WM_SETCURSOR = &h0020
const WM_MOUSEACTIVATE = &h0021
const WM_CHILDACTIVATE = &h0022
const WM_QUEUESYNC = &h0023
const WM_GETMINMAXINFO = &h0024

type tagMINMAXINFO
	ptReserved as POINT
	ptMaxSize as POINT
	ptMaxPosition as POINT
	ptMinTrackSize as POINT
	ptMaxTrackSize as POINT
end type

type MINMAXINFO as tagMINMAXINFO
type PMINMAXINFO as tagMINMAXINFO ptr
type LPMINMAXINFO as tagMINMAXINFO ptr

const WM_PAINTICON = &h0026
const WM_ICONERASEBKGND = &h0027
const WM_NEXTDLGCTL = &h0028
const WM_SPOOLERSTATUS = &h002A
const WM_DRAWITEM = &h002B
const WM_MEASUREITEM = &h002C
const WM_DELETEITEM = &h002D
const WM_VKEYTOITEM = &h002E
const WM_CHARTOITEM = &h002F
const WM_SETFONT = &h0030
const WM_GETFONT = &h0031
const WM_SETHOTKEY = &h0032
const WM_GETHOTKEY = &h0033
const WM_QUERYDRAGICON = &h0037
const WM_COMPAREITEM = &h0039
const WM_GETOBJECT = &h003D
const WM_COMPACTING = &h0041
const WM_COMMNOTIFY = &h0044
const WM_WINDOWPOSCHANGING = &h0046
const WM_WINDOWPOSCHANGED = &h0047
const WM_POWER = &h0048
const PWR_OK = 1
const PWR_FAIL = -1
const PWR_SUSPENDREQUEST = 1
const PWR_SUSPENDRESUME = 2
const PWR_CRITICALRESUME = 3
const WM_COPYDATA = &h004A
const WM_CANCELJOURNAL = &h004B

type tagCOPYDATASTRUCT
	dwData as ULONG_PTR
	cbData as DWORD
	lpData as PVOID
end type

type COPYDATASTRUCT as tagCOPYDATASTRUCT
type PCOPYDATASTRUCT as tagCOPYDATASTRUCT ptr

type tagMDINEXTMENU
	hmenuIn as HMENU
	hmenuNext as HMENU
	hwndNext as HWND
end type

type MDINEXTMENU as tagMDINEXTMENU
type PMDINEXTMENU as tagMDINEXTMENU ptr
type LPMDINEXTMENU as tagMDINEXTMENU ptr

const WM_NOTIFY = &h004E
const WM_INPUTLANGCHANGEREQUEST = &h0050
const WM_INPUTLANGCHANGE = &h0051
const WM_TCARD = &h0052
const WM_HELP = &h0053
const WM_USERCHANGED = &h0054
const WM_NOTIFYFORMAT = &h0055
const NFR_ANSI = 1
const NFR_UNICODE = 2
const NF_QUERY = 3
const NF_REQUERY = 4
const WM_CONTEXTMENU = &h007B
const WM_STYLECHANGING = &h007C
const WM_STYLECHANGED = &h007D
const WM_DISPLAYCHANGE = &h007E
const WM_GETICON = &h007F
const WM_SETICON = &h0080
const WM_NCCREATE = &h0081
const WM_NCDESTROY = &h0082
const WM_NCCALCSIZE = &h0083
const WM_NCHITTEST = &h0084
const WM_NCPAINT = &h0085
const WM_NCACTIVATE = &h0086
const WM_GETDLGCODE = &h0087
const WM_SYNCPAINT = &h0088
const WM_NCMOUSEMOVE = &h00A0
const WM_NCLBUTTONDOWN = &h00A1
const WM_NCLBUTTONUP = &h00A2
const WM_NCLBUTTONDBLCLK = &h00A3
const WM_NCRBUTTONDOWN = &h00A4
const WM_NCRBUTTONUP = &h00A5
const WM_NCRBUTTONDBLCLK = &h00A6
const WM_NCMBUTTONDOWN = &h00A7
const WM_NCMBUTTONUP = &h00A8
const WM_NCMBUTTONDBLCLK = &h00A9
const WM_NCXBUTTONDOWN = &h00AB
const WM_NCXBUTTONUP = &h00AC
const WM_NCXBUTTONDBLCLK = &h00AD
const WM_INPUT_DEVICE_CHANGE = &h00fe
const WM_INPUT = &h00FF
const WM_KEYFIRST = &h0100
const WM_KEYDOWN = &h0100
const WM_KEYUP = &h0101
const WM_CHAR = &h0102
const WM_DEADCHAR = &h0103
const WM_SYSKEYDOWN = &h0104
const WM_SYSKEYUP = &h0105
const WM_SYSCHAR = &h0106
const WM_SYSDEADCHAR = &h0107
const WM_UNICHAR = &h0109
const WM_KEYLAST = &h0109
const UNICODE_NOCHAR = &hFFFF
const WM_IME_STARTCOMPOSITION = &h010D
const WM_IME_ENDCOMPOSITION = &h010E
const WM_IME_COMPOSITION = &h010F
const WM_IME_KEYLAST = &h010F
const WM_INITDIALOG = &h0110
const WM_COMMAND = &h0111
const WM_SYSCOMMAND = &h0112
const WM_TIMER = &h0113
const WM_HSCROLL = &h0114
const WM_VSCROLL = &h0115
const WM_INITMENU = &h0116
const WM_INITMENUPOPUP = &h0117
const WM_MENUSELECT = &h011F

#if _WIN32_WINNT >= &h0601
	const WM_GESTURE = &h0119
	const WM_GESTURENOTIFY = &h011A
#endif

const WM_MENUCHAR = &h0120
const WM_ENTERIDLE = &h0121
const WM_MENURBUTTONUP = &h0122
const WM_MENUDRAG = &h0123
const WM_MENUGETOBJECT = &h0124
const WM_UNINITMENUPOPUP = &h0125
const WM_MENUCOMMAND = &h0126
const WM_CHANGEUISTATE = &h0127
const WM_UPDATEUISTATE = &h0128
const WM_QUERYUISTATE = &h0129
const UIS_SET = 1
const UIS_CLEAR = 2
const UIS_INITIALIZE = 3
const UISF_HIDEFOCUS = &h1
const UISF_HIDEACCEL = &h2
const UISF_ACTIVE = &h4
const WM_CTLCOLORMSGBOX = &h0132
const WM_CTLCOLOREDIT = &h0133
const WM_CTLCOLORLISTBOX = &h0134
const WM_CTLCOLORBTN = &h0135
const WM_CTLCOLORDLG = &h0136
const WM_CTLCOLORSCROLLBAR = &h0137
const WM_CTLCOLORSTATIC = &h0138
const MN_GETHMENU = &h01E1
const WM_MOUSEFIRST = &h0200
const WM_MOUSEMOVE = &h0200
const WM_LBUTTONDOWN = &h0201
const WM_LBUTTONUP = &h0202
const WM_LBUTTONDBLCLK = &h0203
const WM_RBUTTONDOWN = &h0204
const WM_RBUTTONUP = &h0205
const WM_RBUTTONDBLCLK = &h0206
const WM_MBUTTONDOWN = &h0207
const WM_MBUTTONUP = &h0208
const WM_MBUTTONDBLCLK = &h0209
const WM_MOUSEWHEEL = &h020A
const WM_XBUTTONDOWN = &h020B
const WM_XBUTTONUP = &h020C
const WM_XBUTTONDBLCLK = &h020D

#if _WIN32_WINNT <= &h0502
	const WM_MOUSELAST = &h020d
#else
	const WM_MOUSEHWHEEL = &h020e
	const WM_MOUSELAST = &h020e
#endif

const WHEEL_DELTA = 120
#define GET_WHEEL_DELTA_WPARAM(wParam) cshort(HIWORD(wParam))
#define GET_KEYSTATE_WPARAM(wParam) LOWORD(wParam)
#define GET_NCHITTEST_WPARAM(wParam) cshort(LOWORD(wParam))
#define GET_XBUTTON_WPARAM(wParam) HIWORD(wParam)
const XBUTTON1 = &h0001
const XBUTTON2 = &h0002
const WM_PARENTNOTIFY = &h0210
const WM_ENTERMENULOOP = &h0211
const WM_EXITMENULOOP = &h0212
const WM_NEXTMENU = &h0213
const WM_SIZING = &h0214
const WM_CAPTURECHANGED = &h0215
const WM_MOVING = &h0216
const WM_POWERBROADCAST = &h0218
const PBT_APMQUERYSUSPEND = &h0000
const PBT_APMQUERYSTANDBY = &h0001
const PBT_APMQUERYSUSPENDFAILED = &h0002
const PBT_APMQUERYSTANDBYFAILED = &h0003
const PBT_APMSUSPEND = &h0004
const PBT_APMSTANDBY = &h0005
const PBT_APMRESUMECRITICAL = &h0006
const PBT_APMRESUMESUSPEND = &h0007
const PBT_APMRESUMESTANDBY = &h0008
const PBTF_APMRESUMEFROMFAILURE = &h00000001
const PBT_APMBATTERYLOW = &h0009
const PBT_APMPOWERSTATUSCHANGE = &h000A
const PBT_APMOEMEVENT = &h000B
const PBT_APMRESUMEAUTOMATIC = &h0012

#if _WIN32_WINNT >= &h0502
	const PBT_POWERSETTINGCHANGE = 32787

	type POWERBROADCAST_SETTING
		PowerSetting as GUID
		DataLength as DWORD
		Data(0 to 0) as UCHAR
	end type

	type PPOWERBROADCAST_SETTING as POWERBROADCAST_SETTING ptr
#endif

const WM_DEVICECHANGE = &h0219
const WM_MDICREATE = &h0220
const WM_MDIDESTROY = &h0221
const WM_MDIACTIVATE = &h0222
const WM_MDIRESTORE = &h0223
const WM_MDINEXT = &h0224
const WM_MDIMAXIMIZE = &h0225
const WM_MDITILE = &h0226
const WM_MDICASCADE = &h0227
const WM_MDIICONARRANGE = &h0228
const WM_MDIGETACTIVE = &h0229
const WM_MDISETMENU = &h0230
const WM_ENTERSIZEMOVE = &h0231
const WM_EXITSIZEMOVE = &h0232
const WM_DROPFILES = &h0233
const WM_MDIREFRESHMENU = &h0234

#if _WIN32_WINNT = &h0602
	const WM_POINTERDEVICECHANGE = &h238
	const WM_POINTERDEVICEINRANGE = &h239
	const WM_POINTERDEVICEOUTOFRANGE = &h23a
#endif

#if _WIN32_WINNT >= &h0601
	const WM_TOUCH = &h0240
#endif

#if _WIN32_WINNT = &h0602
	const WM_NCPOINTERUPDATE = &h0241
	const WM_NCPOINTERDOWN = &h0242
	const WM_NCPOINTERUP = &h0243
	const WM_POINTERUPDATE = &h0245
	const WM_POINTERDOWN = &h0246
	const WM_POINTERUP = &h0247
	const WM_POINTERENTER = &h0249
	const WM_POINTERLEAVE = &h024a
	const WM_POINTERACTIVATE = &h024b
	const WM_POINTERCAPTURECHANGED = &h024c
	const WM_TOUCHHITTESTING = &h024d
	const WM_POINTERWHEEL = &h024e
	const WM_POINTERHWHEEL = &h024f
#endif

const WM_IME_SETCONTEXT = &h0281
const WM_IME_NOTIFY = &h0282
const WM_IME_CONTROL = &h0283
const WM_IME_COMPOSITIONFULL = &h0284
const WM_IME_SELECT = &h0285
const WM_IME_CHAR = &h0286
const WM_IME_REQUEST = &h0288
const WM_IME_KEYDOWN = &h0290
const WM_IME_KEYUP = &h0291
const WM_MOUSEHOVER = &h02A1
const WM_MOUSELEAVE = &h02A3
const WM_NCMOUSEHOVER = &h02A0
const WM_NCMOUSELEAVE = &h02A2
const WM_WTSSESSION_CHANGE = &h02B1
const WM_TABLET_FIRST = &h02c0
const WM_TABLET_LAST = &h02df
const WM_CUT = &h0300
const WM_COPY = &h0301
const WM_PASTE = &h0302
const WM_CLEAR = &h0303
const WM_UNDO = &h0304
const WM_RENDERFORMAT = &h0305
const WM_RENDERALLFORMATS = &h0306
const WM_DESTROYCLIPBOARD = &h0307
const WM_DRAWCLIPBOARD = &h0308
const WM_PAINTCLIPBOARD = &h0309
const WM_VSCROLLCLIPBOARD = &h030A
const WM_SIZECLIPBOARD = &h030B
const WM_ASKCBFORMATNAME = &h030C
const WM_CHANGECBCHAIN = &h030D
const WM_HSCROLLCLIPBOARD = &h030E
const WM_QUERYNEWPALETTE = &h030F
const WM_PALETTEISCHANGING = &h0310
const WM_PALETTECHANGED = &h0311
const WM_HOTKEY = &h0312
const WM_PRINT = &h0317
const WM_PRINTCLIENT = &h0318
const WM_APPCOMMAND = &h0319
const WM_THEMECHANGED = &h031A
const WM_CLIPBOARDUPDATE = &h031d

#if _WIN32_WINNT >= &h0600
	const WM_DWMCOMPOSITIONCHANGED = &h031e
	const WM_DWMNCRENDERINGCHANGED = &h031f
	const WM_DWMCOLORIZATIONCOLORCHANGED = &h0320
	const WM_DWMWINDOWMAXIMIZEDCHANGE = &h0321
#endif

#if _WIN32_WINNT >= &h0601
	const WM_DWMSENDICONICTHUMBNAIL = &h0323
	const WM_DWMSENDICONICLIVEPREVIEWBITMAP = &h0326
#endif

#if _WIN32_WINNT >= &h0600
	const WM_GETTITLEBARINFOEX = &h033f
#endif

const WM_HANDHELDFIRST = &h0358
const WM_HANDHELDLAST = &h035F
const WM_AFXFIRST = &h0360
const WM_AFXLAST = &h037F
const WM_PENWINFIRST = &h0380
const WM_PENWINLAST = &h038F
const WM_APP = &h8000
const WM_USER = &h0400
const WMSZ_LEFT = 1
const WMSZ_RIGHT = 2
const WMSZ_TOP = 3
const WMSZ_TOPLEFT = 4
const WMSZ_TOPRIGHT = 5
const WMSZ_BOTTOM = 6
const WMSZ_BOTTOMLEFT = 7
const WMSZ_BOTTOMRIGHT = 8
const HTERROR = -2
const HTTRANSPARENT = -1
const HTNOWHERE = 0
const HTCLIENT = 1
const HTCAPTION = 2
const HTSYSMENU = 3
const HTGROWBOX = 4
const HTSIZE = HTGROWBOX
const HTMENU = 5
const HTHSCROLL = 6
const HTVSCROLL = 7
const HTMINBUTTON = 8
const HTMAXBUTTON = 9
const HTLEFT = 10
const HTRIGHT = 11
const HTTOP = 12
const HTTOPLEFT = 13
const HTTOPRIGHT = 14
const HTBOTTOM = 15
const HTBOTTOMLEFT = 16
const HTBOTTOMRIGHT = 17
const HTBORDER = 18
const HTREDUCE = HTMINBUTTON
const HTZOOM = HTMAXBUTTON
const HTSIZEFIRST = HTLEFT
const HTSIZELAST = HTBOTTOMRIGHT
const HTOBJECT = 19
const HTCLOSE = 20
const HTHELP = 21
const SMTO_NORMAL = &h0000
const SMTO_BLOCK = &h0001
const SMTO_ABORTIFHUNG = &h0002
const SMTO_NOTIMEOUTIFNOTHUNG = &h0008

#if _WIN32_WINNT >= &h0600
	const SMTO_ERRORONEXIT = &h0020
#endif

const MA_ACTIVATE = 1
const MA_ACTIVATEANDEAT = 2
const MA_NOACTIVATE = 3
const MA_NOACTIVATEANDEAT = 4
const ICON_SMALL = 0
const ICON_BIG = 1
const ICON_SMALL2 = 2
declare function RegisterWindowMessageA(byval lpString as LPCSTR) as UINT

#ifndef UNICODE
	declare function RegisterWindowMessage alias "RegisterWindowMessageA"(byval lpString as LPCSTR) as UINT
#endif

declare function RegisterWindowMessageW(byval lpString as LPCWSTR) as UINT

#ifdef UNICODE
	declare function RegisterWindowMessage alias "RegisterWindowMessageW"(byval lpString as LPCWSTR) as UINT
#endif

const SIZE_RESTORED = 0
const SIZE_MINIMIZED = 1
const SIZE_MAXIMIZED = 2
const SIZE_MAXSHOW = 3
const SIZE_MAXHIDE = 4
const SIZENORMAL = SIZE_RESTORED
const SIZEICONIC = SIZE_MINIMIZED
const SIZEFULLSCREEN = SIZE_MAXIMIZED
const SIZEZOOMSHOW = SIZE_MAXSHOW
const SIZEZOOMHIDE = SIZE_MAXHIDE

type tagWINDOWPOS
	hwnd as HWND
	hwndInsertAfter as HWND
	x as long
	y as long
	cx as long
	cy as long
	flags as UINT
end type

type WINDOWPOS as tagWINDOWPOS
type LPWINDOWPOS as tagWINDOWPOS ptr
type PWINDOWPOS as tagWINDOWPOS ptr

type tagNCCALCSIZE_PARAMS
	rgrc(0 to 2) as RECT
	lppos as PWINDOWPOS
end type

type NCCALCSIZE_PARAMS as tagNCCALCSIZE_PARAMS
type LPNCCALCSIZE_PARAMS as tagNCCALCSIZE_PARAMS ptr
const WVR_ALIGNTOP = &h0010
const WVR_ALIGNLEFT = &h0020
const WVR_ALIGNBOTTOM = &h0040
const WVR_ALIGNRIGHT = &h0080
const WVR_HREDRAW = &h0100
const WVR_VREDRAW = &h0200
const WVR_REDRAW = WVR_HREDRAW or WVR_VREDRAW
const WVR_VALIDRECTS = &h0400
const MK_LBUTTON = &h0001
const MK_RBUTTON = &h0002
const MK_SHIFT = &h0004
const MK_CONTROL = &h0008
const MK_MBUTTON = &h0010
const MK_XBUTTON1 = &h0020
const MK_XBUTTON2 = &h0040
const TME_HOVER = &h00000001
const TME_LEAVE = &h00000002
const TME_NONCLIENT = &h00000010
const TME_QUERY = &h40000000
const TME_CANCEL = &h80000000
const HOVER_DEFAULT = &hFFFFFFFF

type tagTRACKMOUSEEVENT
	cbSize as DWORD
	dwFlags as DWORD
	hwndTrack as HWND
	dwHoverTime as DWORD
end type

type TRACKMOUSEEVENT as tagTRACKMOUSEEVENT
type LPTRACKMOUSEEVENT as tagTRACKMOUSEEVENT ptr
declare function TrackMouseEvent(byval lpEventTrack as LPTRACKMOUSEEVENT) as WINBOOL
const WS_OVERLAPPED = &h00000000
const WS_POPUP = &h80000000
const WS_CHILD = &h40000000
const WS_MINIMIZE = &h20000000
const WS_VISIBLE = &h10000000
const WS_DISABLED = &h08000000
const WS_CLIPSIBLINGS = &h04000000
const WS_CLIPCHILDREN = &h02000000
const WS_MAXIMIZE = &h01000000
const WS_CAPTION = &h00C00000
const WS_BORDER = &h00800000
const WS_DLGFRAME = &h00400000
const WS_VSCROLL = &h00200000
const WS_HSCROLL = &h00100000
const WS_SYSMENU = &h00080000
const WS_THICKFRAME = &h00040000
const WS_GROUP = &h00020000
const WS_TABSTOP = &h00010000
const WS_MINIMIZEBOX = &h00020000
const WS_MAXIMIZEBOX = &h00010000
const WS_TILED = WS_OVERLAPPED
const WS_ICONIC = WS_MINIMIZE
const WS_SIZEBOX = WS_THICKFRAME
const WS_OVERLAPPEDWINDOW = ((((WS_OVERLAPPED or WS_CAPTION) or WS_SYSMENU) or WS_THICKFRAME) or WS_MINIMIZEBOX) or WS_MAXIMIZEBOX
const WS_TILEDWINDOW = WS_OVERLAPPEDWINDOW
const WS_POPUPWINDOW = (WS_POPUP or WS_BORDER) or WS_SYSMENU
const WS_CHILDWINDOW = WS_CHILD
const WS_EX_DLGMODALFRAME = &h00000001
const WS_EX_NOPARENTNOTIFY = &h00000004
const WS_EX_TOPMOST = &h00000008
const WS_EX_ACCEPTFILES = &h00000010
const WS_EX_TRANSPARENT = &h00000020
const WS_EX_MDICHILD = &h00000040
const WS_EX_TOOLWINDOW = &h00000080
const WS_EX_WINDOWEDGE = &h00000100
const WS_EX_CLIENTEDGE = &h00000200
const WS_EX_CONTEXTHELP = &h00000400
const WS_EX_RIGHT = &h00001000
const WS_EX_LEFT = &h00000000
const WS_EX_RTLREADING = &h00002000
const WS_EX_LTRREADING = &h00000000
const WS_EX_LEFTSCROLLBAR = &h00004000
const WS_EX_RIGHTSCROLLBAR = &h00000000
const WS_EX_CONTROLPARENT = &h00010000
const WS_EX_STATICEDGE = &h00020000
const WS_EX_APPWINDOW = &h00040000
const WS_EX_OVERLAPPEDWINDOW = WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE
const WS_EX_PALETTEWINDOW = (WS_EX_WINDOWEDGE or WS_EX_TOOLWINDOW) or WS_EX_TOPMOST
const WS_EX_LAYERED = &h00080000
const WS_EX_NOINHERITLAYOUT = &h00100000

#if _WIN32_WINNT = &h0602
	const WS_EX_NOREDIRECTIONBITMAP = &h00200000
#endif

const WS_EX_LAYOUTRTL = &h00400000
const WS_EX_COMPOSITED = &h02000000
const WS_EX_NOACTIVATE = &h08000000
const CS_VREDRAW = &h0001
const CS_HREDRAW = &h0002
const CS_DBLCLKS = &h0008
const CS_OWNDC = &h0020
const CS_CLASSDC = &h0040
const CS_PARENTDC = &h0080
const CS_NOCLOSE = &h0200
const CS_SAVEBITS = &h0800
const CS_BYTEALIGNCLIENT = &h1000
const CS_BYTEALIGNWINDOW = &h2000
const CS_GLOBALCLASS = &h4000
const CS_IME = &h00010000
const CS_DROPSHADOW = &h00020000
const PRF_CHECKVISIBLE = &h00000001
const PRF_NONCLIENT = &h00000002
const PRF_CLIENT = &h00000004
const PRF_ERASEBKGND = &h00000008
const PRF_CHILDREN = &h00000010
const PRF_OWNED = &h00000020
const BDR_RAISEDOUTER = &h0001
const BDR_SUNKENOUTER = &h0002
const BDR_RAISEDINNER = &h0004
const BDR_SUNKENINNER = &h0008
const BDR_OUTER = BDR_RAISEDOUTER or BDR_SUNKENOUTER
const BDR_INNER = BDR_RAISEDINNER or BDR_SUNKENINNER
const BDR_RAISED = BDR_RAISEDOUTER or BDR_RAISEDINNER
const BDR_SUNKEN = BDR_SUNKENOUTER or BDR_SUNKENINNER
const EDGE_RAISED = BDR_RAISEDOUTER or BDR_RAISEDINNER
const EDGE_SUNKEN = BDR_SUNKENOUTER or BDR_SUNKENINNER
const EDGE_ETCHED = BDR_SUNKENOUTER or BDR_RAISEDINNER
const EDGE_BUMP = BDR_RAISEDOUTER or BDR_SUNKENINNER
const BF_LEFT = &h0001
const BF_TOP = &h0002
const BF_RIGHT = &h0004
const BF_BOTTOM = &h0008
const BF_TOPLEFT = BF_TOP or BF_LEFT
const BF_TOPRIGHT = BF_TOP or BF_RIGHT
const BF_BOTTOMLEFT = BF_BOTTOM or BF_LEFT
const BF_BOTTOMRIGHT = BF_BOTTOM or BF_RIGHT
const BF_RECT = ((BF_LEFT or BF_TOP) or BF_RIGHT) or BF_BOTTOM
const BF_DIAGONAL = &h0010
const BF_DIAGONAL_ENDTOPRIGHT = (BF_DIAGONAL or BF_TOP) or BF_RIGHT
const BF_DIAGONAL_ENDTOPLEFT = (BF_DIAGONAL or BF_TOP) or BF_LEFT
const BF_DIAGONAL_ENDBOTTOMLEFT = (BF_DIAGONAL or BF_BOTTOM) or BF_LEFT
const BF_DIAGONAL_ENDBOTTOMRIGHT = (BF_DIAGONAL or BF_BOTTOM) or BF_RIGHT
const BF_MIDDLE = &h0800
const BF_SOFT = &h1000
const BF_ADJUST = &h2000
const BF_FLAT = &h4000
const BF_MONO = &h8000
declare function DrawEdge(byval hdc as HDC, byval qrc as LPRECT, byval edge as UINT, byval grfFlags as UINT) as WINBOOL
const DFC_CAPTION = 1
const DFC_MENU = 2
const DFC_SCROLL = 3
const DFC_BUTTON = 4
const DFC_POPUPMENU = 5
const DFCS_CAPTIONCLOSE = &h0000
const DFCS_CAPTIONMIN = &h0001
const DFCS_CAPTIONMAX = &h0002
const DFCS_CAPTIONRESTORE = &h0003
const DFCS_CAPTIONHELP = &h0004
const DFCS_MENUARROW = &h0000
const DFCS_MENUCHECK = &h0001
const DFCS_MENUBULLET = &h0002
const DFCS_MENUARROWRIGHT = &h0004
const DFCS_SCROLLUP = &h0000
const DFCS_SCROLLDOWN = &h0001
const DFCS_SCROLLLEFT = &h0002
const DFCS_SCROLLRIGHT = &h0003
const DFCS_SCROLLCOMBOBOX = &h0005
const DFCS_SCROLLSIZEGRIP = &h0008
const DFCS_SCROLLSIZEGRIPRIGHT = &h0010
const DFCS_BUTTONCHECK = &h0000
const DFCS_BUTTONRADIOIMAGE = &h0001
const DFCS_BUTTONRADIOMASK = &h0002
const DFCS_BUTTONRADIO = &h0004
const DFCS_BUTTON3STATE = &h0008
const DFCS_BUTTONPUSH = &h0010
const DFCS_INACTIVE = &h0100
const DFCS_PUSHED = &h0200
const DFCS_CHECKED = &h0400
const DFCS_TRANSPARENT = &h0800
const DFCS_HOT = &h1000
const DFCS_ADJUSTRECT = &h2000
const DFCS_FLAT = &h4000
const DFCS_MONO = &h8000
declare function DrawFrameControl(byval as HDC, byval as LPRECT, byval as UINT, byval as UINT) as WINBOOL
const DC_ACTIVE = &h0001
const DC_SMALLCAP = &h0002
const DC_ICON = &h0004
const DC_TEXT = &h0008
const DC_INBUTTON = &h0010
const DC_GRADIENT = &h0020
const DC_BUTTONS = &h1000
declare function DrawCaption(byval hwnd as HWND, byval hdc as HDC, byval lprect as const RECT ptr, byval flags as UINT) as WINBOOL
const IDANI_OPEN = 1
const IDANI_CAPTION = 3
declare function DrawAnimatedRects(byval hwnd as HWND, byval idAni as long, byval lprcFrom as const RECT ptr, byval lprcTo as const RECT ptr) as WINBOOL
const CF_TEXT = 1
const CF_BITMAP = 2
const CF_METAFILEPICT = 3
const CF_SYLK = 4
const CF_DIF = 5
const CF_TIFF = 6
const CF_OEMTEXT = 7
const CF_DIB = 8
const CF_PALETTE = 9
const CF_PENDATA = 10
const CF_RIFF = 11
const CF_WAVE = 12
const CF_UNICODETEXT = 13
const CF_ENHMETAFILE = 14
const CF_HDROP = 15
const CF_LOCALE = 16
const CF_DIBV5 = 17
const CF_MAX = 18
const CF_OWNERDISPLAY = &h0080
const CF_DSPTEXT = &h0081
const CF_DSPBITMAP = &h0082
const CF_DSPMETAFILEPICT = &h0083
const CF_DSPENHMETAFILE = &h008E
const CF_PRIVATEFIRST = &h0200
const CF_PRIVATELAST = &h02FF
const CF_GDIOBJFIRST = &h0300
const CF_GDIOBJLAST = &h03FF
const FVIRTKEY = CTRUE
const FNOINVERT = &h02
const FSHIFT = &h04
const FCONTROL = &h08
const FALT = &h10

type tagACCEL
	fVirt as UBYTE
	key as WORD
	cmd as WORD
end type

type ACCEL as tagACCEL
type LPACCEL as tagACCEL ptr

type tagPAINTSTRUCT
	hdc as HDC
	fErase as WINBOOL
	rcPaint as RECT
	fRestore as WINBOOL
	fIncUpdate as WINBOOL
	rgbReserved(0 to 31) as UBYTE
end type

type PAINTSTRUCT as tagPAINTSTRUCT
type PPAINTSTRUCT as tagPAINTSTRUCT ptr
type NPPAINTSTRUCT as tagPAINTSTRUCT ptr
type LPPAINTSTRUCT as tagPAINTSTRUCT ptr

type tagCREATESTRUCTA_
	lpCreateParams as LPVOID
	hInstance as HINSTANCE
	hMenu as HMENU
	hwndParent as HWND
	cy as long
	cx as long
	y as long
	x as long
	style as LONG
	lpszName as LPCSTR
	lpszClass as LPCSTR
	dwExStyle as DWORD
end type

type CREATESTRUCTA as tagCREATESTRUCTA
type LPCREATESTRUCTA as tagCREATESTRUCTA ptr

type tagCREATESTRUCTW_
	lpCreateParams as LPVOID
	hInstance as HINSTANCE
	hMenu as HMENU
	hwndParent as HWND
	cy as long
	cx as long
	y as long
	x as long
	style as LONG
	lpszName as LPCWSTR
	lpszClass as LPCWSTR
	dwExStyle as DWORD
end type

type CREATESTRUCTW as tagCREATESTRUCTW
type LPCREATESTRUCTW as tagCREATESTRUCTW ptr

#ifdef UNICODE
	type CREATESTRUCT as CREATESTRUCTW
	type LPCREATESTRUCT as LPCREATESTRUCTW
#else
	type CREATESTRUCT as CREATESTRUCTA
	type LPCREATESTRUCT as LPCREATESTRUCTA
#endif

type tagWINDOWPLACEMENT
	length as UINT
	flags as UINT
	showCmd as UINT
	ptMinPosition as POINT
	ptMaxPosition as POINT
	rcNormalPosition as RECT
end type

type WINDOWPLACEMENT as tagWINDOWPLACEMENT
type PWINDOWPLACEMENT as WINDOWPLACEMENT ptr
type LPWINDOWPLACEMENT as WINDOWPLACEMENT ptr

const WPF_SETMINPOSITION = &h0001
const WPF_RESTORETOMAXIMIZED = &h0002
const WPF_ASYNCWINDOWPLACEMENT = &h0004

type tagNMHDR
	hwndFrom as HWND
	idFrom as UINT_PTR
	code as UINT
end type

type NMHDR as tagNMHDR
type LPNMHDR as NMHDR ptr

type tagSTYLESTRUCT
	styleOld as DWORD
	styleNew as DWORD
end type

type STYLESTRUCT as tagSTYLESTRUCT
type LPSTYLESTRUCT as tagSTYLESTRUCT ptr
const ODT_MENU = 1
const ODT_LISTBOX = 2
const ODT_COMBOBOX = 3
const ODT_BUTTON = 4
const ODT_STATIC = 5
const ODA_DRAWENTIRE = &h0001
const ODA_SELECT = &h0002
const ODA_FOCUS = &h0004
const ODS_SELECTED = &h0001
const ODS_GRAYED = &h0002
const ODS_DISABLED = &h0004
const ODS_CHECKED = &h0008
const ODS_FOCUS = &h0010
const ODS_DEFAULT = &h0020
const ODS_COMBOBOXEDIT = &h1000
const ODS_HOTLIGHT = &h0040
const ODS_INACTIVE = &h0080
const ODS_NOACCEL = &h0100
const ODS_NOFOCUSRECT = &h0200

type tagMEASUREITEMSTRUCT
	CtlType as UINT
	CtlID as UINT
	itemID as UINT
	itemWidth as UINT
	itemHeight as UINT
	itemData as ULONG_PTR
end type

type MEASUREITEMSTRUCT as tagMEASUREITEMSTRUCT
type PMEASUREITEMSTRUCT as tagMEASUREITEMSTRUCT ptr
type LPMEASUREITEMSTRUCT as tagMEASUREITEMSTRUCT ptr

type tagDRAWITEMSTRUCT
	CtlType as UINT
	CtlID as UINT
	itemID as UINT
	itemAction as UINT
	itemState as UINT
	hwndItem as HWND
	hDC as HDC
	rcItem as RECT
	itemData as ULONG_PTR
end type

type DRAWITEMSTRUCT as tagDRAWITEMSTRUCT
type PDRAWITEMSTRUCT as tagDRAWITEMSTRUCT ptr
type LPDRAWITEMSTRUCT as tagDRAWITEMSTRUCT ptr

type tagDELETEITEMSTRUCT
	CtlType as UINT
	CtlID as UINT
	itemID as UINT
	hwndItem as HWND
	itemData as ULONG_PTR
end type

type DELETEITEMSTRUCT as tagDELETEITEMSTRUCT
type PDELETEITEMSTRUCT as tagDELETEITEMSTRUCT ptr
type LPDELETEITEMSTRUCT as tagDELETEITEMSTRUCT ptr

type tagCOMPAREITEMSTRUCT
	CtlType as UINT
	CtlID as UINT
	hwndItem as HWND
	itemID1 as UINT
	itemData1 as ULONG_PTR
	itemID2 as UINT
	itemData2 as ULONG_PTR
	dwLocaleId as DWORD
end type

type COMPAREITEMSTRUCT as tagCOMPAREITEMSTRUCT
type PCOMPAREITEMSTRUCT as tagCOMPAREITEMSTRUCT ptr
type LPCOMPAREITEMSTRUCT as tagCOMPAREITEMSTRUCT ptr
declare function GetMessageA(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL

#ifndef UNICODE
	declare function GetMessage alias "GetMessageA"(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL
#endif

declare function GetMessageW(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL

#ifdef UNICODE
	declare function GetMessage alias "GetMessageW"(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL
#endif

declare function TranslateMessage(byval lpMsg as const MSG ptr) as WINBOOL
declare function DispatchMessageA(byval lpMsg as const MSG ptr) as LRESULT

#ifndef UNICODE
	declare function DispatchMessage alias "DispatchMessageA"(byval lpMsg as const MSG ptr) as LRESULT
#endif

declare function DispatchMessageW(byval lpMsg as const MSG ptr) as LRESULT

#ifdef UNICODE
	declare function DispatchMessage alias "DispatchMessageW"(byval lpMsg as const MSG ptr) as LRESULT
#endif

declare function SetMessageQueue(byval cMessagesMax as long) as WINBOOL
declare function PeekMessageA(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL

#ifndef UNICODE
	declare function PeekMessage alias "PeekMessageA"(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL
#endif

declare function PeekMessageW(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL

#ifdef UNICODE
	declare function PeekMessage alias "PeekMessageW"(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL
#endif

const PM_NOREMOVE = &h0000
const PM_REMOVE = &h0001
const PM_NOYIELD = &h0002
#define PM_QS_INPUT (QS_INPUT shl 16)
#define PM_QS_POSTMESSAGE (((QS_POSTMESSAGE or QS_HOTKEY) or QS_TIMER) shl 16)
#define PM_QS_PAINT (QS_PAINT shl 16)
#define PM_QS_SENDMESSAGE (QS_SENDMESSAGE shl 16)
declare function RegisterHotKey(byval hWnd as HWND, byval id as long, byval fsModifiers as UINT, byval vk as UINT) as WINBOOL
declare function UnregisterHotKey(byval hWnd as HWND, byval id as long) as WINBOOL
const MOD_ALT = &h0001
const MOD_CONTROL = &h0002
const MOD_SHIFT = &h0004
const MOD_WIN = &h0008

#if _WIN32_WINNT >= &h0601
	const MOD_NOREPEAT = &h4000
#endif

const IDHOT_SNAPWINDOW = -1
const IDHOT_SNAPDESKTOP = -2
const ENDSESSION_CLOSEAPP = &h00000001
const ENDSESSION_CRITICAL = &h40000000
const ENDSESSION_LOGOFF = &h80000000
const EWX_LOGOFF = &h00000000
const EWX_SHUTDOWN = &h00000001
const EWX_REBOOT = &h00000002
const EWX_FORCE = &h00000004
const EWX_POWEROFF = &h00000008
const EWX_FORCEIFHUNG = &h00000010
const EWX_QUICKRESOLVE = &h00000020

#if _WIN32_WINNT >= &h0600
	const EWX_RESTARTAPPS = &h00000040
#endif

const EWX_HYBRID_SHUTDOWN = &h00400000
const EWX_BOOTOPTIONS = &h01000000
#define ExitWindows(dwReserved, Code) ExitWindowsEx(EWX_LOGOFF, &hFFFFFFFF)

declare function ExitWindowsEx(byval uFlags as UINT, byval dwReason as DWORD) as WINBOOL
declare function SwapMouseButton(byval fSwap as WINBOOL) as WINBOOL
declare function GetMessagePos() as DWORD
declare function GetMessageTime() as LONG
declare function GetMessageExtraInfo() as LPARAM

#if _WIN32_WINNT = &h0602
	declare function GetUnpredictedMessagePos() as DWORD
#endif

declare function IsWow64Message() as WINBOOL
declare function SetMessageExtraInfo(byval lParam as LPARAM) as LPARAM
declare function SendMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function SendMessage alias "SendMessageA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function SendMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function SendMessage alias "SendMessageW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function SendMessageTimeoutA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT

#ifndef UNICODE
	declare function SendMessageTimeout alias "SendMessageTimeoutA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT
#endif

declare function SendMessageTimeoutW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT

#ifdef UNICODE
	declare function SendMessageTimeout alias "SendMessageTimeoutW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT
#endif

declare function SendNotifyMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function SendNotifyMessage alias "SendNotifyMessageA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

declare function SendNotifyMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function SendNotifyMessage alias "SendNotifyMessageW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

declare function SendMessageCallbackA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL

#ifndef UNICODE
	declare function SendMessageCallback alias "SendMessageCallbackA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL
#endif

declare function SendMessageCallbackW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL

#ifdef UNICODE
	declare function SendMessageCallback alias "SendMessageCallbackW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL
#endif

type BSMINFO
	cbSize as UINT
	hdesk as HDESK
	hwnd as HWND
	luid as LUID
end type

type PBSMINFO as BSMINFO ptr
declare function BroadcastSystemMessageExA(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long

#ifndef UNICODE
	declare function BroadcastSystemMessageEx alias "BroadcastSystemMessageExA"(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long
#endif

declare function BroadcastSystemMessageExW(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long

#ifdef UNICODE
	declare function BroadcastSystemMessageEx alias "BroadcastSystemMessageExW"(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long
#endif

declare function BroadcastSystemMessageA(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long

#ifndef UNICODE
	declare function BroadcastSystemMessage alias "BroadcastSystemMessageA"(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long
#endif

declare function BroadcastSystemMessageW(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long

#ifdef UNICODE
	declare function BroadcastSystemMessage alias "BroadcastSystemMessageW"(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long
#endif

const BSM_ALLCOMPONENTS = &h00000000
const BSM_VXDS = &h00000001
const BSM_NETDRIVER = &h00000002
const BSM_INSTALLABLEDRIVERS = &h00000004
const BSM_APPLICATIONS = &h00000008
const BSM_ALLDESKTOPS = &h00000010
const BSF_QUERY = &h00000001
const BSF_IGNORECURRENTTASK = &h00000002
const BSF_FLUSHDISK = &h00000004
const BSF_NOHANG = &h00000008
const BSF_POSTMESSAGE = &h00000010
const BSF_FORCEIFHUNG = &h00000020
const BSF_NOTIMEOUTIFNOTHUNG = &h00000040
const BSF_ALLOWSFW = &h00000080
const BSF_SENDNOTIFYMESSAGE = &h00000100
const BSF_RETURNHDESK = &h00000200
const BSF_LUID = &h00000400
const BROADCAST_QUERY_DENY = &h424D5144
type HDEVNOTIFY as PVOID
type PHDEVNOTIFY as HDEVNOTIFY ptr
const DEVICE_NOTIFY_WINDOW_HANDLE = &h00000000
const DEVICE_NOTIFY_SERVICE_HANDLE = &h00000001
const DEVICE_NOTIFY_ALL_INTERFACE_CLASSES = &h00000004

#ifdef UNICODE
	#define PostAppMessage PostAppMessageW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0502)
	#define PostAppMessage PostAppMessageA
#endif

#if _WIN32_WINNT >= &h0502
	#define _HPOWERNOTIFY_DEF_
	type HPOWERNOTIFY as HANDLE
	type PHPOWERNOTIFY as HPOWERNOTIFY ptr
	declare function RegisterPowerSettingNotification(byval hRecipient as HANDLE, byval PowerSettingGuid as LPCGUID, byval Flags as DWORD) as HPOWERNOTIFY
	declare function UnregisterPowerSettingNotification(byval Handle as HPOWERNOTIFY) as WINBOOL
	declare function RegisterSuspendResumeNotification(byval hRecipient as HANDLE, byval Flags as DWORD) as HPOWERNOTIFY
	declare function UnregisterSuspendResumeNotification(byval Handle as HPOWERNOTIFY) as WINBOOL
#elseif (not defined(UNICODE)) and (_WIN32_WINNT <= &h0501)
	#define PostAppMessage PostAppMessageA
#endif

declare function PostMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function PostMessage alias "PostMessageA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

declare function PostMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function PostMessage alias "PostMessageW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

declare function PostThreadMessageA(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifndef UNICODE
	declare function PostThreadMessage alias "PostThreadMessageA"(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

declare function PostThreadMessageW(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#ifdef UNICODE
	declare function PostThreadMessage alias "PostThreadMessageW"(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
#endif

#define PostAppMessageA(idThread, wMsg, wParam, lParam) PostThreadMessageA(cast(DWORD, idThread), wMsg, wParam, lParam)
#define PostAppMessageW(idThread, wMsg, wParam, lParam) PostThreadMessageW(cast(DWORD, idThread), wMsg, wParam, lParam)
declare function AttachThreadInput(byval idAttach as DWORD, byval idAttachTo as DWORD, byval fAttach as WINBOOL) as WINBOOL
declare function ReplyMessage(byval lResult as LRESULT) as WINBOOL
declare function WaitMessage() as WINBOOL
declare function WaitForInputIdle(byval hProcess as HANDLE, byval dwMilliseconds as DWORD) as DWORD
declare function DefWindowProcA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function DefWindowProc alias "DefWindowProcA"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefWindowProcW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function DefWindowProc alias "DefWindowProcW"(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare sub PostQuitMessage(byval nExitCode as long)
declare function InSendMessage() as WINBOOL
declare function InSendMessageEx(byval lpReserved as LPVOID) as DWORD
declare function GetDoubleClickTime() as UINT
declare function SetDoubleClickTime(byval as UINT) as WINBOOL
declare function RegisterClassA(byval lpWndClass as const WNDCLASSA ptr) as ATOM

#ifndef UNICODE
	declare function RegisterClass alias "RegisterClassA"(byval lpWndClass as const WNDCLASSA ptr) as ATOM
#endif

declare function RegisterClassW(byval lpWndClass as const WNDCLASSW ptr) as ATOM

#ifdef UNICODE
	declare function RegisterClass alias "RegisterClassW"(byval lpWndClass as const WNDCLASSW ptr) as ATOM
#endif

declare function UnregisterClassA(byval lpClassName as LPCSTR, byval hInstance as HINSTANCE) as WINBOOL

#ifndef UNICODE
	declare function UnregisterClass alias "UnregisterClassA"(byval lpClassName as LPCSTR, byval hInstance as HINSTANCE) as WINBOOL
#endif

declare function UnregisterClassW(byval lpClassName as LPCWSTR, byval hInstance as HINSTANCE) as WINBOOL

#ifdef UNICODE
	declare function UnregisterClass alias "UnregisterClassW"(byval lpClassName as LPCWSTR, byval hInstance as HINSTANCE) as WINBOOL
#endif

declare function GetClassInfoA(byval hInstance as HINSTANCE, byval lpClassName as LPCSTR, byval lpWndClass as LPWNDCLASSA) as WINBOOL

#ifndef UNICODE
	declare function GetClassInfo alias "GetClassInfoA"(byval hInstance as HINSTANCE, byval lpClassName as LPCSTR, byval lpWndClass as LPWNDCLASSA) as WINBOOL
#endif

declare function GetClassInfoW(byval hInstance as HINSTANCE, byval lpClassName as LPCWSTR, byval lpWndClass as LPWNDCLASSW) as WINBOOL

#ifdef UNICODE
	declare function GetClassInfo alias "GetClassInfoW"(byval hInstance as HINSTANCE, byval lpClassName as LPCWSTR, byval lpWndClass as LPWNDCLASSW) as WINBOOL
#endif

declare function RegisterClassExA(byval as const WNDCLASSEXA ptr) as ATOM

#ifndef UNICODE
	declare function RegisterClassEx alias "RegisterClassExA"(byval as const WNDCLASSEXA ptr) as ATOM
#endif

declare function RegisterClassExW(byval as const WNDCLASSEXW ptr) as ATOM

#ifdef UNICODE
	declare function RegisterClassEx alias "RegisterClassExW"(byval as const WNDCLASSEXW ptr) as ATOM
#endif

declare function GetClassInfoExA(byval hInstance as HINSTANCE, byval lpszClass as LPCSTR, byval lpwcx as LPWNDCLASSEXA) as WINBOOL

#ifndef UNICODE
	declare function GetClassInfoEx alias "GetClassInfoExA"(byval hInstance as HINSTANCE, byval lpszClass as LPCSTR, byval lpwcx as LPWNDCLASSEXA) as WINBOOL
#endif

declare function GetClassInfoExW(byval hInstance as HINSTANCE, byval lpszClass as LPCWSTR, byval lpwcx as LPWNDCLASSEXW) as WINBOOL

#ifdef UNICODE
	declare function GetClassInfoEx alias "GetClassInfoExW"(byval hInstance as HINSTANCE, byval lpszClass as LPCWSTR, byval lpwcx as LPWNDCLASSEXW) as WINBOOL
#endif

declare function CallWindowProcA(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function CallWindowProc alias "CallWindowProcA"(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function CallWindowProcW(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function CallWindowProc alias "CallWindowProcW"(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

const CW_USEDEFAULT = clng(&h80000000)
const HWND_BROADCAST = cast(HWND, &hffff)
const HWND_MESSAGE = cast(HWND, -3)
const HWND_DESKTOP = cast(HWND, 0)
const ISMEX_NOSEND = &h00000000
const ISMEX_SEND = &h00000001
const ISMEX_NOTIFY = &h00000002
const ISMEX_CALLBACK = &h00000004
const ISMEX_REPLIED = &h00000008

#if _WIN32_WINNT >= &h0502
	extern GUID_POWERSCHEME_PERSONALITY as const GUID
	extern GUID_MIN_POWER_SAVINGS as const GUID
	extern GUID_MAX_POWER_SAVINGS as const GUID
	extern GUID_TYPICAL_POWER_SAVINGS as const GUID
	extern GUID_ACDC_POWER_SOURCE as const GUID
	extern GUID_BATTERY_PERCENTAGE_REMAINING as const GUID
	extern GUID_IDLE_BACKGROUND_TASK as const GUID
	extern GUID_SYSTEM_AWAYMODE as const GUID
	extern GUID_MONITOR_POWER_ON as const GUID
#endif

declare function RegisterDeviceNotificationA(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY

#ifndef UNICODE
	declare function RegisterDeviceNotification alias "RegisterDeviceNotificationA"(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY
#endif

declare function RegisterDeviceNotificationW(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY

#ifdef UNICODE
	declare function RegisterDeviceNotification alias "RegisterDeviceNotificationW"(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY
#endif

declare function UnregisterDeviceNotification(byval Handle as HDEVNOTIFY) as WINBOOL
type PREGISTERCLASSNAMEW as function(byval as LPCWSTR) as WINBOOLEAN

#ifdef UNICODE
	#define CreateWindow CreateWindowW
#else
	#define CreateWindow CreateWindowA
#endif

declare function CreateWindowExA(byval dwExStyle as DWORD, byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND

#ifndef UNICODE
	declare function CreateWindowEx alias "CreateWindowExA"(byval dwExStyle as DWORD, byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND
#endif

declare function CreateWindowExW(byval dwExStyle as DWORD, byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND

#ifdef UNICODE
	declare function CreateWindowEx alias "CreateWindowExW"(byval dwExStyle as DWORD, byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND
#endif

#define CreateWindowA(lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam) CreateWindowExA(cast(DWORD, 0), lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
#define CreateWindowW(lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam) CreateWindowExW(cast(DWORD, 0), lpClassName, lpWindowName, dwStyle, x, y, nWidth, nHeight, hWndParent, hMenu, hInstance, lpParam)
declare function IsWindow(byval hWnd as HWND) as WINBOOL
declare function IsMenu(byval hMenu as HMENU) as WINBOOL
declare function IsChild(byval hWndParent as HWND, byval hWnd as HWND) as WINBOOL
declare function DestroyWindow(byval hWnd as HWND) as WINBOOL
declare function ShowWindow(byval hWnd as HWND, byval nCmdShow as long) as WINBOOL
declare function AnimateWindow(byval hWnd as HWND, byval dwTime as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function UpdateLayeredWindow(byval hWnd as HWND, byval hdcDst as HDC, byval pptDst as POINT ptr, byval psize as SIZE ptr, byval hdcSrc as HDC, byval pptSrc as POINT ptr, byval crKey as COLORREF, byval pblend as BLENDFUNCTION ptr, byval dwFlags as DWORD) as WINBOOL

type tagUPDATELAYEREDWINDOWINFO
	cbSize as DWORD
	hdcDst as HDC
	pptDst as const POINT ptr
	psize as const SIZE ptr
	hdcSrc as HDC
	pptSrc as const POINT ptr
	crKey as COLORREF
	pblend as const BLENDFUNCTION ptr
	dwFlags as DWORD
	prcDirty as const RECT ptr
end type

type UPDATELAYEREDWINDOWINFO as tagUPDATELAYEREDWINDOWINFO
type PUPDATELAYEREDWINDOWINFO as tagUPDATELAYEREDWINDOWINFO ptr

#if _WIN32_WINNT >= &h0502
	declare function UpdateLayeredWindowIndirect(byval hWnd as HWND, byval pULWInfo as const UPDATELAYEREDWINDOWINFO ptr) as WINBOOL
#endif

declare function GetLayeredWindowAttributes(byval hwnd as HWND, byval pcrKey as COLORREF ptr, byval pbAlpha as UBYTE ptr, byval pdwFlags as DWORD ptr) as WINBOOL
const PW_CLIENTONLY = &h00000001
declare function PrintWindow(byval hwnd as HWND, byval hdcBlt as HDC, byval nFlags as UINT) as WINBOOL
declare function SetLayeredWindowAttributes(byval hwnd as HWND, byval crKey as COLORREF, byval bAlpha as UBYTE, byval dwFlags as DWORD) as WINBOOL
const LWA_COLORKEY = &h00000001
const LWA_ALPHA = &h00000002
const ULW_COLORKEY = &h00000001
const ULW_ALPHA = &h00000002
const ULW_OPAQUE = &h00000004
const ULW_EX_NORESIZE = &h00000008
const FLASHW_STOP = 0
const FLASHW_CAPTION = &h00000001
const FLASHW_TRAY = &h00000002
const FLASHW_ALL = FLASHW_CAPTION or FLASHW_TRAY
const FLASHW_TIMER = &h00000004
const FLASHW_TIMERNOFG = &h0000000c

type FLASHWINFO
	cbSize as UINT
	hwnd as HWND
	dwFlags as DWORD
	uCount as UINT
	dwTimeout as DWORD
end type

type PFLASHWINFO as FLASHWINFO ptr
declare function ShowWindowAsync(byval hWnd as HWND, byval nCmdShow as long) as WINBOOL
declare function FlashWindow(byval hWnd as HWND, byval bInvert as WINBOOL) as WINBOOL
declare function FlashWindowEx(byval pfwi as PFLASHWINFO) as WINBOOL
declare function ShowOwnedPopups(byval hWnd as HWND, byval fShow as WINBOOL) as WINBOOL
declare function OpenIcon(byval hWnd as HWND) as WINBOOL
declare function CloseWindow(byval hWnd as HWND) as WINBOOL
declare function MoveWindow(byval hWnd as HWND, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval bRepaint as WINBOOL) as WINBOOL
declare function SetWindowPos(byval hWnd as HWND, byval hWndInsertAfter as HWND, byval X as long, byval Y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
declare function GetWindowPlacement(byval hWnd as HWND, byval lpwndpl as WINDOWPLACEMENT ptr) as WINBOOL
declare function SetWindowPlacement(byval hWnd as HWND, byval lpwndpl as const WINDOWPLACEMENT ptr) as WINBOOL

#if _WIN32_WINNT >= &h0601
	const WDA_NONE = &h00000000
	const WDA_MONITOR = &h00000001
	declare function GetWindowDisplayAffinity(byval hWnd as HWND, byval pdwAffinity as DWORD ptr) as WINBOOL
	declare function SetWindowDisplayAffinity(byval hWnd as HWND, byval dwAffinity as DWORD) as WINBOOL
#endif

declare function BeginDeferWindowPos(byval nNumWindows as long) as HDWP
declare function DeferWindowPos(byval hWinPosInfo as HDWP, byval hWnd as HWND, byval hWndInsertAfter as HWND, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as HDWP
declare function EndDeferWindowPos(byval hWinPosInfo as HDWP) as WINBOOL
declare function IsWindowVisible(byval hWnd as HWND) as WINBOOL
declare function IsIconic(byval hWnd as HWND) as WINBOOL
declare function AnyPopup() as WINBOOL
declare function BringWindowToTop(byval hWnd as HWND) as WINBOOL
declare function IsZoomed(byval hWnd as HWND) as WINBOOL

const SWP_NOSIZE = &h0001
const SWP_NOMOVE = &h0002
const SWP_NOZORDER = &h0004
const SWP_NOREDRAW = &h0008
const SWP_NOACTIVATE = &h0010
const SWP_FRAMECHANGED = &h0020
const SWP_SHOWWINDOW = &h0040
const SWP_HIDEWINDOW = &h0080
const SWP_NOCOPYBITS = &h0100
const SWP_NOOWNERZORDER = &h0200
const SWP_NOSENDCHANGING = &h0400
const SWP_DRAWFRAME = SWP_FRAMECHANGED
const SWP_NOREPOSITION = SWP_NOOWNERZORDER
const SWP_DEFERERASE = &h2000
const SWP_ASYNCWINDOWPOS = &h4000
const HWND_TOP = cast(HWND, 0)
const HWND_BOTTOM = cast(HWND, 1)
const HWND_TOPMOST = cast(HWND, -1)
const HWND_NOTOPMOST = cast(HWND, -2)

type DLGTEMPLATE field = 2
	style as DWORD
	dwExtendedStyle as DWORD
	cdit as WORD
	x as short
	y as short
	cx as short
	cy as short
end type

type LPDLGTEMPLATEA as DLGTEMPLATE ptr
type LPDLGTEMPLATEW as DLGTEMPLATE ptr

#ifdef UNICODE
	type LPDLGTEMPLATE as LPDLGTEMPLATEW
#else
	type LPDLGTEMPLATE as LPDLGTEMPLATEA
#endif

type LPCDLGTEMPLATEA as const DLGTEMPLATE ptr
type LPCDLGTEMPLATEW as const DLGTEMPLATE ptr

#ifdef UNICODE
	type LPCDLGTEMPLATE as LPCDLGTEMPLATEW
#else
	type LPCDLGTEMPLATE as LPCDLGTEMPLATEA
#endif

type DLGITEMTEMPLATE field = 2
	style as DWORD
	dwExtendedStyle as DWORD
	x as short
	y as short
	cx as short
	cy as short
	id as WORD
end type

type PDLGITEMTEMPLATEA as DLGITEMTEMPLATE ptr
type PDLGITEMTEMPLATEW as DLGITEMTEMPLATE ptr

#ifdef UNICODE
	type PDLGITEMTEMPLATE as PDLGITEMTEMPLATEW
#else
	type PDLGITEMTEMPLATE as PDLGITEMTEMPLATEA
#endif

type LPDLGITEMTEMPLATEA as DLGITEMTEMPLATE ptr
type LPDLGITEMTEMPLATEW as DLGITEMTEMPLATE ptr

#ifdef UNICODE
	type LPDLGITEMTEMPLATE as LPDLGITEMTEMPLATEW
	#define CreateDialog CreateDialogW
	#define CreateDialogIndirect CreateDialogIndirectW
	#define DialogBox DialogBoxW
	#define DialogBoxIndirect DialogBoxIndirectW
#else
	type LPDLGITEMTEMPLATE as LPDLGITEMTEMPLATEA
	#define CreateDialog CreateDialogA
	#define CreateDialogIndirect CreateDialogIndirectA
	#define DialogBox DialogBoxA
	#define DialogBoxIndirect DialogBoxIndirectA
#endif

declare function CreateDialogParamA(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND

#ifndef UNICODE
	declare function CreateDialogParam alias "CreateDialogParamA"(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
#endif

declare function CreateDialogParamW(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND

#ifdef UNICODE
	declare function CreateDialogParam alias "CreateDialogParamW"(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
#endif

declare function CreateDialogIndirectParamA(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND

#ifndef UNICODE
	declare function CreateDialogIndirectParam alias "CreateDialogIndirectParamA"(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
#endif

declare function CreateDialogIndirectParamW(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND

#ifdef UNICODE
	declare function CreateDialogIndirectParam alias "CreateDialogIndirectParamW"(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
#endif

#define CreateDialogA(hInstance, lpName, hWndParent, lpDialogFunc) CreateDialogParamA(hInstance, lpName, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogW(hInstance, lpName, hWndParent, lpDialogFunc) CreateDialogParamW(hInstance, lpName, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogIndirectA(hInstance, lpTemplate, hWndParent, lpDialogFunc) CreateDialogIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogIndirectW(hInstance, lpTemplate, hWndParent, lpDialogFunc) CreateDialogIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
declare function DialogBoxParamA(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR

#ifndef UNICODE
	declare function DialogBoxParam alias "DialogBoxParamA"(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
#endif

declare function DialogBoxParamW(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR

#ifdef UNICODE
	declare function DialogBoxParam alias "DialogBoxParamW"(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
#endif

declare function DialogBoxIndirectParamA(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR

#ifndef UNICODE
	declare function DialogBoxIndirectParam alias "DialogBoxIndirectParamA"(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
#endif

declare function DialogBoxIndirectParamW(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR

#ifdef UNICODE
	declare function DialogBoxIndirectParam alias "DialogBoxIndirectParamW"(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
#endif

#define DialogBoxA(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxW(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxIndirectA(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxIndirectW(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))

declare function EndDialog(byval hDlg as HWND, byval nResult as INT_PTR) as WINBOOL
declare function GetDlgItem(byval hDlg as HWND, byval nIDDlgItem as long) as HWND
declare function SetDlgItemInt(byval hDlg as HWND, byval nIDDlgItem as long, byval uValue as UINT, byval bSigned as WINBOOL) as WINBOOL
declare function GetDlgItemInt(byval hDlg as HWND, byval nIDDlgItem as long, byval lpTranslated as WINBOOL ptr, byval bSigned as WINBOOL) as UINT
declare function SetDlgItemTextA(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetDlgItemText alias "SetDlgItemTextA"(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCSTR) as WINBOOL
#endif

declare function SetDlgItemTextW(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetDlgItemText alias "SetDlgItemTextW"(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCWSTR) as WINBOOL
#endif

declare function GetDlgItemTextA(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPSTR, byval cchMax as long) as UINT

#ifndef UNICODE
	declare function GetDlgItemText alias "GetDlgItemTextA"(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPSTR, byval cchMax as long) as UINT
#endif

declare function GetDlgItemTextW(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPWSTR, byval cchMax as long) as UINT

#ifdef UNICODE
	declare function GetDlgItemText alias "GetDlgItemTextW"(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPWSTR, byval cchMax as long) as UINT
#endif

declare function CheckDlgButton(byval hDlg as HWND, byval nIDButton as long, byval uCheck as UINT) as WINBOOL
declare function CheckRadioButton(byval hDlg as HWND, byval nIDFirstButton as long, byval nIDLastButton as long, byval nIDCheckButton as long) as WINBOOL
declare function IsDlgButtonChecked(byval hDlg as HWND, byval nIDButton as long) as UINT
declare function SendDlgItemMessageA(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function SendDlgItemMessage alias "SendDlgItemMessageA"(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function SendDlgItemMessageW(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function SendDlgItemMessage alias "SendDlgItemMessageW"(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function GetNextDlgGroupItem(byval hDlg as HWND, byval hCtl as HWND, byval bPrevious as WINBOOL) as HWND
declare function GetNextDlgTabItem(byval hDlg as HWND, byval hCtl as HWND, byval bPrevious as WINBOOL) as HWND
declare function GetDlgCtrlID(byval hWnd as HWND) as long
declare function GetDialogBaseUnits() as long
declare function DefDlgProcA(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function DefDlgProc alias "DefDlgProcA"(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefDlgProcW(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function DefDlgProc alias "DefDlgProcW"(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

const DLGWINDOWEXTRA = 30
declare function CallMsgFilterA(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL

#ifndef UNICODE
	declare function CallMsgFilter alias "CallMsgFilterA"(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL
#endif

declare function CallMsgFilterW(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL

#ifdef UNICODE
	declare function CallMsgFilter alias "CallMsgFilterW"(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL
#endif

declare function OpenClipboard(byval hWndNewOwner as HWND) as WINBOOL
declare function CloseClipboard() as WINBOOL
declare function GetClipboardSequenceNumber() as DWORD
declare function GetClipboardOwner() as HWND
declare function SetClipboardViewer(byval hWndNewViewer as HWND) as HWND
declare function GetClipboardViewer() as HWND
declare function ChangeClipboardChain(byval hWndRemove as HWND, byval hWndNewNext as HWND) as WINBOOL
declare function SetClipboardData(byval uFormat as UINT, byval hMem as HANDLE) as HANDLE
declare function GetClipboardData(byval uFormat as UINT) as HANDLE
declare function RegisterClipboardFormatA(byval lpszFormat as LPCSTR) as UINT

#ifndef UNICODE
	declare function RegisterClipboardFormat alias "RegisterClipboardFormatA"(byval lpszFormat as LPCSTR) as UINT
#endif

declare function RegisterClipboardFormatW(byval lpszFormat as LPCWSTR) as UINT

#ifdef UNICODE
	declare function RegisterClipboardFormat alias "RegisterClipboardFormatW"(byval lpszFormat as LPCWSTR) as UINT
#endif

declare function CountClipboardFormats() as long
declare function EnumClipboardFormats(byval format as UINT) as UINT
declare function GetClipboardFormatNameA(byval format as UINT, byval lpszFormatName as LPSTR, byval cchMaxCount as long) as long

#ifndef UNICODE
	declare function GetClipboardFormatName alias "GetClipboardFormatNameA"(byval format as UINT, byval lpszFormatName as LPSTR, byval cchMaxCount as long) as long
#endif

declare function GetClipboardFormatNameW(byval format as UINT, byval lpszFormatName as LPWSTR, byval cchMaxCount as long) as long

#ifdef UNICODE
	declare function GetClipboardFormatName alias "GetClipboardFormatNameW"(byval format as UINT, byval lpszFormatName as LPWSTR, byval cchMaxCount as long) as long
#endif

declare function EmptyClipboard() as WINBOOL
declare function IsClipboardFormatAvailable(byval format as UINT) as WINBOOL
declare function GetPriorityClipboardFormat(byval paFormatPriorityList as UINT ptr, byval cFormats as long) as long
declare function GetOpenClipboardWindow() as HWND

#if _WIN32_WINNT >= &h0600
	declare function AddClipboardFormatListener(byval hwnd as HWND) as WINBOOL
	declare function RemoveClipboardFormatListener(byval hwnd as HWND) as WINBOOL
	declare function GetUpdatedClipboardFormats(byval lpuiFormats as PUINT, byval cFormats as UINT, byval pcFormatsOut as PUINT) as WINBOOL
#endif

declare function CharToOemA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL

#ifndef UNICODE
	declare function CharToOem alias "CharToOemA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
#endif

declare function CharToOemW(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR) as WINBOOL

#ifdef UNICODE
	declare function CharToOem alias "CharToOemW"(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR) as WINBOOL
#endif

declare function OemToCharA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL

#ifndef UNICODE
	declare function OemToChar alias "OemToCharA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
#endif

declare function OemToCharW(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR) as WINBOOL

#ifdef UNICODE
	declare function OemToChar alias "OemToCharW"(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR) as WINBOOL
#endif

declare function CharToOemBuffA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CharToOemBuff alias "CharToOemBuffA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
#endif

declare function CharToOemBuffW(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CharToOemBuff alias "CharToOemBuffW"(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
#endif

declare function OemToCharBuffA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL

#ifndef UNICODE
	declare function OemToCharBuff alias "OemToCharBuffA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
#endif

declare function OemToCharBuffW(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR, byval cchDstLength as DWORD) as WINBOOL

#ifdef UNICODE
	declare function OemToCharBuff alias "OemToCharBuffW"(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR, byval cchDstLength as DWORD) as WINBOOL
#endif

declare function CharUpperA(byval lpsz as LPSTR) as LPSTR

#ifndef UNICODE
	declare function CharUpper alias "CharUpperA"(byval lpsz as LPSTR) as LPSTR
#endif

declare function CharUpperW(byval lpsz as LPWSTR) as LPWSTR

#ifdef UNICODE
	declare function CharUpper alias "CharUpperW"(byval lpsz as LPWSTR) as LPWSTR
#endif

declare function CharUpperBuffA(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD

#ifndef UNICODE
	declare function CharUpperBuff alias "CharUpperBuffA"(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
#endif

declare function CharUpperBuffW(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD

#ifdef UNICODE
	declare function CharUpperBuff alias "CharUpperBuffW"(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD
#endif

declare function CharLowerA(byval lpsz as LPSTR) as LPSTR

#ifndef UNICODE
	declare function CharLower alias "CharLowerA"(byval lpsz as LPSTR) as LPSTR
#endif

declare function CharLowerW(byval lpsz as LPWSTR) as LPWSTR

#ifdef UNICODE
	declare function CharLower alias "CharLowerW"(byval lpsz as LPWSTR) as LPWSTR
#endif

declare function CharLowerBuffA(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD

#ifndef UNICODE
	declare function CharLowerBuff alias "CharLowerBuffA"(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
#endif

declare function CharLowerBuffW(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD

#ifdef UNICODE
	declare function CharLowerBuff alias "CharLowerBuffW"(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD
#endif

declare function CharNextA(byval lpsz as LPCSTR) as LPSTR

#ifndef UNICODE
	declare function CharNext alias "CharNextA"(byval lpsz as LPCSTR) as LPSTR
#endif

declare function CharNextW(byval lpsz as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function CharNext alias "CharNextW"(byval lpsz as LPCWSTR) as LPWSTR
#endif

declare function CharPrevA(byval lpszStart as LPCSTR, byval lpszCurrent as LPCSTR) as LPSTR

#ifndef UNICODE
	declare function CharPrev alias "CharPrevA"(byval lpszStart as LPCSTR, byval lpszCurrent as LPCSTR) as LPSTR
#endif

declare function CharPrevW(byval lpszStart as LPCWSTR, byval lpszCurrent as LPCWSTR) as LPWSTR

#ifdef UNICODE
	declare function CharPrev alias "CharPrevW"(byval lpszStart as LPCWSTR, byval lpszCurrent as LPCWSTR) as LPWSTR
#endif

declare function CharNextExA(byval CodePage as WORD, byval lpCurrentChar as LPCSTR, byval dwFlags as DWORD) as LPSTR
declare function CharPrevExA(byval CodePage as WORD, byval lpStart as LPCSTR, byval lpCurrentChar as LPCSTR, byval dwFlags as DWORD) as LPSTR
declare function AnsiToOem alias "CharToOemA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
declare function OemToAnsi alias "OemToCharA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
declare function AnsiToOemBuff alias "CharToOemBuffA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
declare function OemToAnsiBuff alias "OemToCharBuffA"(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
declare function AnsiUpper alias "CharUpperA"(byval lpsz as LPSTR) as LPSTR
declare function AnsiUpperBuff alias "CharUpperBuffA"(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
declare function AnsiLower alias "CharLowerA"(byval lpsz as LPSTR) as LPSTR
declare function AnsiLowerBuff alias "CharLowerBuffA"(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
declare function AnsiNext alias "CharNextA"(byval lpsz as LPCSTR) as LPSTR
declare function AnsiPrev alias "CharPrevA"(byval lpszStart as LPCSTR, byval lpszCurrent as LPCSTR) as LPSTR
declare function IsCharAlphaA(byval ch as CHAR) as WINBOOL

#ifndef UNICODE
	declare function IsCharAlpha alias "IsCharAlphaA"(byval ch as CHAR) as WINBOOL
#endif

declare function IsCharAlphaW(byval ch as WCHAR) as WINBOOL

#ifdef UNICODE
	declare function IsCharAlpha alias "IsCharAlphaW"(byval ch as WCHAR) as WINBOOL
#endif

declare function IsCharAlphaNumericA(byval ch as CHAR) as WINBOOL

#ifndef UNICODE
	declare function IsCharAlphaNumeric alias "IsCharAlphaNumericA"(byval ch as CHAR) as WINBOOL
#endif

declare function IsCharAlphaNumericW(byval ch as WCHAR) as WINBOOL

#ifdef UNICODE
	declare function IsCharAlphaNumeric alias "IsCharAlphaNumericW"(byval ch as WCHAR) as WINBOOL
#endif

declare function IsCharUpperA(byval ch as CHAR) as WINBOOL

#ifndef UNICODE
	declare function IsCharUpper alias "IsCharUpperA"(byval ch as CHAR) as WINBOOL
#endif

declare function IsCharUpperW(byval ch as WCHAR) as WINBOOL

#ifdef UNICODE
	declare function IsCharUpper alias "IsCharUpperW"(byval ch as WCHAR) as WINBOOL
#endif

declare function IsCharLowerA(byval ch as CHAR) as WINBOOL

#ifndef UNICODE
	declare function IsCharLower alias "IsCharLowerA"(byval ch as CHAR) as WINBOOL
#endif

declare function IsCharLowerW(byval ch as WCHAR) as WINBOOL

#ifdef UNICODE
	declare function IsCharLower alias "IsCharLowerW"(byval ch as WCHAR) as WINBOOL
#endif

declare function SetFocus(byval hWnd as HWND) as HWND
declare function GetActiveWindow() as HWND
declare function GetFocus() as HWND
declare function GetKBCodePage() as UINT
declare function GetKeyState(byval nVirtKey as long) as SHORT
declare function GetAsyncKeyState(byval vKey as long) as SHORT
declare function GetKeyboardState(byval lpKeyState as PBYTE) as WINBOOL
declare function SetKeyboardState(byval lpKeyState as LPBYTE) as WINBOOL
declare function GetKeyNameTextA(byval lParam as LONG, byval lpString as LPSTR, byval cchSize as long) as long

#ifndef UNICODE
	declare function GetKeyNameText alias "GetKeyNameTextA"(byval lParam as LONG, byval lpString as LPSTR, byval cchSize as long) as long
#endif

declare function GetKeyNameTextW(byval lParam as LONG, byval lpString as LPWSTR, byval cchSize as long) as long

#ifdef UNICODE
	declare function GetKeyNameText alias "GetKeyNameTextW"(byval lParam as LONG, byval lpString as LPWSTR, byval cchSize as long) as long
#endif

declare function GetKeyboardType(byval nTypeFlag as long) as long
declare function ToAscii_ alias "ToAscii"(byval uVirtKey as UINT, byval uScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval lpChar as LPWORD, byval uFlags as UINT) as long
declare function ToAsciiEx(byval uVirtKey as UINT, byval uScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval lpChar as LPWORD, byval uFlags as UINT, byval dwhkl as HKL) as long
declare function ToUnicode(byval wVirtKey as UINT, byval wScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval pwszBuff as LPWSTR, byval cchBuff as long, byval wFlags as UINT) as long
declare function OemKeyScan(byval wOemChar as WORD) as DWORD
declare function VkKeyScanA(byval ch as CHAR) as SHORT

#ifndef UNICODE
	declare function VkKeyScan alias "VkKeyScanA"(byval ch as CHAR) as SHORT
#endif

declare function VkKeyScanW(byval ch as WCHAR) as SHORT

#ifdef UNICODE
	declare function VkKeyScan alias "VkKeyScanW"(byval ch as WCHAR) as SHORT
#endif

declare function VkKeyScanExA(byval ch as CHAR, byval dwhkl as HKL) as SHORT

#ifndef UNICODE
	declare function VkKeyScanEx alias "VkKeyScanExA"(byval ch as CHAR, byval dwhkl as HKL) as SHORT
#endif

declare function VkKeyScanExW(byval ch as WCHAR, byval dwhkl as HKL) as SHORT

#ifdef UNICODE
	declare function VkKeyScanEx alias "VkKeyScanExW"(byval ch as WCHAR, byval dwhkl as HKL) as SHORT
#endif

declare sub keybd_event(byval bVk as UBYTE, byval bScan as UBYTE, byval dwFlags as DWORD, byval dwExtraInfo as ULONG_PTR)
const KEYEVENTF_EXTENDEDKEY = &h0001
const KEYEVENTF_KEYUP = &h0002
const KEYEVENTF_UNICODE = &h0004
const KEYEVENTF_SCANCODE = &h0008
const MOUSEEVENTF_MOVE = &h0001
const MOUSEEVENTF_LEFTDOWN = &h0002
const MOUSEEVENTF_LEFTUP = &h0004
const MOUSEEVENTF_RIGHTDOWN = &h0008
const MOUSEEVENTF_RIGHTUP = &h0010
const MOUSEEVENTF_MIDDLEDOWN = &h0020
const MOUSEEVENTF_MIDDLEUP = &h0040
const MOUSEEVENTF_XDOWN = &h0080
const MOUSEEVENTF_XUP = &h0100
const MOUSEEVENTF_WHEEL = &h0800

#if _WIN32_WINNT >= &h0600
	const MOUSEEVENTF_HWHEEL = &h01000
	const MOUSEEVENTF_MOVE_NOCOALESCE = &h2000
#endif

const MOUSEEVENTF_VIRTUALDESK = &h4000
const MOUSEEVENTF_ABSOLUTE = &h8000
const INPUT_MOUSE = 0
const INPUT_KEYBOARD = 1
const INPUT_HARDWARE = 2

#if _WIN32_WINNT >= &h0601
	#define TOUCH_COORD_TO_PIXEL(l) ((l) / 100)
	const TOUCHEVENTF_MOVE = &h0001
	const TOUCHEVENTF_DOWN = &h0002
	const TOUCHEVENTF_UP = &h0004
	const TOUCHEVENTF_INRANGE = &h0008
	const TOUCHEVENTF_PRIMARY = &h0010
	const TOUCHEVENTF_NOCOALESCE = &h0020
	const TOUCHEVENTF_PEN = &h0040
	const TOUCHEVENTF_PALM = &h0080
	const TOUCHINPUTMASKF_TIMEFROMSYSTEM = &h0001
	const TOUCHINPUTMASKF_EXTRAINFO = &h0002
	const TOUCHINPUTMASKF_CONTACTAREA = &h0004
	const TWF_FINETOUCH = &h00000001
	const TWF_WANTPALM = &h00000002
#endif

#if _WIN32_WINNT = &h0602
	const POINTER_FLAG_NONE = &h00000000
	const POINTER_FLAG_NEW = &h00000001
	const POINTER_FLAG_INRANGE = &h00000002
	const POINTER_FLAG_INCONTACT = &h00000004
	const POINTER_FLAG_FIRSTBUTTON = &h00000010
	const POINTER_FLAG_SECONDBUTTON = &h00000020
	const POINTER_FLAG_THIRDBUTTON = &h00000040
	const POINTER_FLAG_FOURTHBUTTON = &h00000080
	const POINTER_FLAG_FIFTHBUTTON = &h00000100
	const POINTER_FLAG_PRIMARY = &h00002000
	const POINTER_FLAG_CONFIDENCE = &h00004000
	const POINTER_FLAG_CANCELED = &h00008000
	const POINTER_FLAG_DOWN = &h00010000
	const POINTER_FLAG_UPDATE = &h00020000
	const POINTER_FLAG_UP = &h00040000
	const POINTER_FLAG_WHEEL = &h00080000
	const POINTER_FLAG_HWHEEL = &h00100000
	const POINTER_FLAG_CAPTURECHANGED = &h00200000
	const POINTER_MOD_SHIFT = &h0004
	const POINTER_MOD_CTRL = &h0008
	const TOUCH_FLAG_NONE = &h00000000
	const TOUCH_MASK_NONE = &h00000000
	const TOUCH_MASK_CONTACTAREA = &h00000001
	const TOUCH_MASK_ORIENTATION = &h00000002
	const TOUCH_MASK_PRESSURE = &h00000004
	const PEN_FLAG_NONE = &h00000000
	const PEN_FLAG_BARREL = &h00000001
	const PEN_FLAG_INVERTED = &h00000002
	const PEN_FLAG_ERASER = &h00000004
	const PEN_MASK_NONE = &h00000000
	const PEN_MASK_PRESSURE = &h00000001
	const PEN_MASK_ROTATION = &h00000002
	const PEN_MASK_TILT_X = &h00000004
	const PEN_MASK_TILT_Y = &h00000008
	const POINTER_MESSAGE_FLAG_NEW = &h00000001
	const POINTER_MESSAGE_FLAG_INRANGE = &h00000002
	const POINTER_MESSAGE_FLAG_INCONTACT = &h00000004
	const POINTER_MESSAGE_FLAG_FIRSTBUTTON = &h00000010
	const POINTER_MESSAGE_FLAG_SECONDBUTTON = &h00000020
	const POINTER_MESSAGE_FLAG_THIRDBUTTON = &h00000040
	const POINTER_MESSAGE_FLAG_FOURTHBUTTON = &h00000080
	const POINTER_MESSAGE_FLAG_FIFTHBUTTON = &h00000100
	const POINTER_MESSAGE_FLAG_PRIMARY = &h00002000
	const POINTER_MESSAGE_FLAG_CONFIDENCE = &h00004000
	const POINTER_MESSAGE_FLAG_CANCELED = &h00008000
	#define GET_POINTERID_WPARAM(wParam) LOWORD(wParam)
	#define IS_POINTER_FLAG_SET_WPARAM(wParam, flag) ((cast(DWORD, HIWORD(wParam)) and (flag)) = (flag))
	#define IS_POINTER_NEW_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_NEW)
	#define IS_POINTER_INRANGE_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_INRANGE)
	#define IS_POINTER_INCONTACT_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_INCONTACT)
	#define IS_POINTER_FIRSTBUTTON_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FIRSTBUTTON)
	#define IS_POINTER_SECONDBUTTON_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_SECONDBUTTON)
	#define IS_POINTER_THIRDBUTTON_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_THIRDBUTTON)
	#define IS_POINTER_FOURTHBUTTON_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FOURTHBUTTON)
	#define IS_POINTER_FIFTHBUTTON_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_FIFTHBUTTON)
	#define IS_POINTER_PRIMARY_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_PRIMARY)
	#define HAS_POINTER_CONFIDENCE_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_CONFIDENCE)
	#define IS_POINTER_CANCELED_WPARAM(wParam) IS_POINTER_FLAG_SET_WPARAM(wParam, POINTER_MESSAGE_FLAG_CANCELED)
	const PA_ACTIVATE = MA_ACTIVATE
	const PA_NOACTIVATE = MA_NOACTIVATE
	const MAX_TOUCH_COUNT = 256
	const TOUCH_FEEDBACK_DEFAULT = &h1
	const TOUCH_FEEDBACK_INDIRECT = &h2
	const TOUCH_FEEDBACK_NONE = &h3
	const TOUCH_HIT_TESTING_DEFAULT = &h0
	const TOUCH_HIT_TESTING_CLIENT = &h1
	const TOUCH_HIT_TESTING_NONE = &h2
	const TOUCH_HIT_TESTING_PROXIMITY_CLOSEST = &h0
	const TOUCH_HIT_TESTING_PROXIMITY_FARTHEST = &hfff
	const GWFS_INCLUDE_ANCESTORS = &h00000001
#endif

declare sub mouse_event(byval dwFlags as DWORD, byval dx as DWORD, byval dy as DWORD, byval dwData as DWORD, byval dwExtraInfo as ULONG_PTR)

type tagMOUSEINPUT
	dx as LONG
	dy as LONG
	mouseData as DWORD
	dwFlags as DWORD
	time as DWORD
	dwExtraInfo as ULONG_PTR
end type

type MOUSEINPUT as tagMOUSEINPUT
type PMOUSEINPUT as tagMOUSEINPUT ptr
type LPMOUSEINPUT as tagMOUSEINPUT ptr

type tagKEYBDINPUT
	wVk as WORD
	wScan as WORD
	dwFlags as DWORD
	time as DWORD
	dwExtraInfo as ULONG_PTR
end type

type KEYBDINPUT as tagKEYBDINPUT
type PKEYBDINPUT as tagKEYBDINPUT ptr
type LPKEYBDINPUT as tagKEYBDINPUT ptr

type tagHARDWAREINPUT
	uMsg as DWORD
	wParamL as WORD
	wParamH as WORD
end type

type HARDWAREINPUT as tagHARDWAREINPUT
type PHARDWAREINPUT as tagHARDWAREINPUT ptr
type LPHARDWAREINPUT as tagHARDWAREINPUT ptr

type tagINPUT
	as DWORD type

	union
		mi as MOUSEINPUT
		ki as KEYBDINPUT
		hi as HARDWAREINPUT
	end union
end type

type INPUT_ as tagINPUT
type PINPUT as tagINPUT ptr
type LPINPUT as tagINPUT ptr
declare function SendInput(byval cInputs as UINT, byval pInputs as LPINPUT, byval cbSize as long) as UINT

#if _WIN32_WINNT >= &h0601
	type HTOUCHINPUT__
		unused as long
	end type

	type HTOUCHINPUT as HTOUCHINPUT__ ptr

	type tagTOUCHINPUT
		x as LONG
		y as LONG
		hSource as HANDLE
		dwID as DWORD
		dwFlags as DWORD
		dwMask as DWORD
		dwTime as DWORD
		dwExtraInfo as ULONG_PTR
		cxContact as DWORD
		cyContact as DWORD
	end type

	type TOUCHINPUT as tagTOUCHINPUT
	type PTOUCHINPUT as tagTOUCHINPUT ptr
	type PCTOUCHINPUT as const TOUCHINPUT ptr

	declare function GetTouchInputInfo(byval hTouchInput as HTOUCHINPUT, byval cInputs as UINT, byval pInputs as PTOUCHINPUT, byval cbSize as long) as WINBOOL
	declare function CloseTouchInputHandle(byval hTouchInput as HTOUCHINPUT) as WINBOOL
	declare function RegisterTouchWindow(byval hwnd as HWND, byval ulFlags as ULONG) as WINBOOL
	declare function UnregisterTouchWindow(byval hwnd as HWND) as WINBOOL
	declare function IsTouchWindow(byval hwnd as HWND, byval pulFlags as PULONG) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	type POINTER_INPUT_TYPE as DWORD
	type POINTER_FLAGS as UINT32
	type TOUCH_FLAGS as UINT32
	type TOUCH_MASK as UINT32
	type PEN_FLAGS as UINT32
	type PEN_MASK as UINT32

	type tagPOINTER_INPUT_TYPE as long
	enum
		PT_POINTER = &h00000001
		PT_TOUCH = &h00000002
		PT_PEN = &h00000003
		PT_MOUSE = &h00000004
	end enum

	type tagFEEDBACK_TYPE as long
	enum
		FEEDBACK_TOUCH_CONTACTVISUALIZATION = 1
		FEEDBACK_PEN_BARRELVISUALIZATION = 2
		FEEDBACK_PEN_TAP = 3
		FEEDBACK_PEN_DOUBLETAP = 4
		FEEDBACK_PEN_PRESSANDHOLD = 5
		FEEDBACK_PEN_RIGHTTAP = 6
		FEEDBACK_TOUCH_TAP = 7
		FEEDBACK_TOUCH_DOUBLETAP = 8
		FEEDBACK_TOUCH_PRESSANDHOLD = 9
		FEEDBACK_TOUCH_RIGHTTAP = 10
		FEEDBACK_GESTURE_PRESSANDTAP = 11
		FEEDBACK_MAX = &hffffffff
	end enum

	type FEEDBACK_TYPE as tagFEEDBACK_TYPE

	type tagPOINTER_BUTTON_CHANGE_TYPE as long
	enum
		POINTER_CHANGE_NONE
		POINTER_CHANGE_FIRSTBUTTON_DOWN
		POINTER_CHANGE_FIRSTBUTTON_UP
		POINTER_CHANGE_SECONDBUTTON_DOWN
		POINTER_CHANGE_SECONDBUTTON_UP
		POINTER_CHANGE_THIRDBUTTON_DOWN
		POINTER_CHANGE_THIRDBUTTON_UP
		POINTER_CHANGE_FOURTHBUTTON_DOWN
		POINTER_CHANGE_FOURTHBUTTON_UP
		POINTER_CHANGE_FIFTHBUTTON_DOWN
		POINTER_CHANGE_FIFTHBUTTON_UP
	end enum

	type POINTER_BUTTON_CHANGE_TYPE as tagPOINTER_BUTTON_CHANGE_TYPE

	type tagPOINTER_INFO
		pointerType as POINTER_INPUT_TYPE
		pointerId as UINT32
		frameId as UINT32
		pointerFlags as POINTER_FLAGS
		sourceDevice as HANDLE
		hwndTarget as HWND
		ptPixelLocation as POINT
		ptHimetricLocation as POINT
		ptPixelLocationRaw as POINT
		ptHimetricLocationRaw as POINT
		dwTime as DWORD
		historyCount as UINT32
		InputData as INT32
		dwKeyStates as DWORD
		PerformanceCount as UINT64
		ButtonChangeType as POINTER_BUTTON_CHANGE_TYPE
	end type

	type POINTER_INFO as tagPOINTER_INFO

	type tagPOINTER_TOUCH_INFO
		pointerInfo as POINTER_INFO
		touchFlags as TOUCH_FLAGS
		touchMask as TOUCH_MASK
		rcContact as RECT
		rcContactRaw as RECT
		orientation as UINT32
		pressure as UINT32
	end type

	type POINTER_TOUCH_INFO as tagPOINTER_TOUCH_INFO

	type tagPOINTER_PEN_INFO
		pointerInfo as POINTER_INFO
		penFlags as PEN_FLAGS
		penMask as PEN_MASK
		pressure as UINT32
		rotation as UINT32
		tiltX as INT32
		tiltY as INT32
	end type

	type POINTER_PEN_INFO as tagPOINTER_PEN_INFO

	type tagTOUCH_HIT_TESTING_PROXIMITY_EVALUATION
		score as UINT16
		adjustedPoint as POINT
	end type

	type TOUCH_HIT_TESTING_PROXIMITY_EVALUATION as tagTOUCH_HIT_TESTING_PROXIMITY_EVALUATION
	type PTOUCH_HIT_TESTING_PROXIMITY_EVALUATION as tagTOUCH_HIT_TESTING_PROXIMITY_EVALUATION ptr

	type tagTOUCH_HIT_TESTING_INPUT
		pointerId as UINT32
		point as POINT
		boundingBox as RECT
		nonOccludedBoundingBox as RECT
		orientation as UINT32
	end type

	type TOUCH_HIT_TESTING_INPUT as tagTOUCH_HIT_TESTING_INPUT
	type PTOUCH_HIT_TESTING_INPUT as tagTOUCH_HIT_TESTING_INPUT ptr
	declare function InitializeTouchInjection(byval maxCount as UINT32, byval dwMode as DWORD) as WINBOOL
	declare function InjectTouchInput(byval count as UINT32, byval contacts as const POINTER_TOUCH_INFO ptr) as WINBOOL
	declare function GetPointerType(byval pointerId as UINT32, byval pointerType as POINTER_INPUT_TYPE ptr) as WINBOOL
	declare function GetPointerCursorId(byval pointerId as UINT32, byval cursorId as UINT32 ptr) as WINBOOL
	declare function GetPointerInfo(byval pointerId as UINT32, byval pointerInfo as POINTER_INFO ptr) as WINBOOL
	declare function GetPointerInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval pointerInfo as POINTER_INFO ptr) as WINBOOL
	declare function GetPointerFrameInfo(byval pointerId as UINT32, byval pointerCount as UINT32 ptr, byval pointerInfo as POINTER_INFO ptr) as WINBOOL
	declare function GetPointerFrameInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval pointerCount as UINT32 ptr, byval pointerInfo as POINTER_INFO ptr) as WINBOOL
	declare function GetPointerTouchInfo(byval pointerId as UINT32, byval touchInfo as POINTER_TOUCH_INFO ptr) as WINBOOL
	declare function GetPointerTouchInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval touchInfo as POINTER_TOUCH_INFO ptr) as WINBOOL
	declare function GetPointerFrameTouchInfo(byval pointerId as UINT32, byval pointerCount as UINT32 ptr, byval touchInfo as POINTER_TOUCH_INFO ptr) as WINBOOL
	declare function GetPointerFrameTouchInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval pointerCount as UINT32 ptr, byval touchInfo as POINTER_TOUCH_INFO ptr) as WINBOOL
	declare function GetPointerPenInfo(byval pointerId as UINT32, byval penInfo as POINTER_PEN_INFO ptr) as WINBOOL
	declare function GetPointerPenInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval penInfo as POINTER_PEN_INFO ptr) as WINBOOL
	declare function GetPointerFramePenInfo(byval pointerId as UINT32, byval pointerCount as UINT32 ptr, byval penInfo as POINTER_PEN_INFO ptr) as WINBOOL
	declare function GetPointerFramePenInfoHistory(byval pointerId as UINT32, byval entriesCount as UINT32 ptr, byval pointerCount as UINT32 ptr, byval penInfo as POINTER_PEN_INFO ptr) as WINBOOL
	declare function SkipPointerFrameMessages(byval pointerId as UINT32) as WINBOOL
	declare function RegisterPointerInputTarget(byval hwnd as HWND, byval pointerType as POINTER_INPUT_TYPE) as WINBOOL
	declare function UnregisterPointerInputTarget(byval hwnd as HWND, byval pointerType as POINTER_INPUT_TYPE) as WINBOOL
	declare function EnableMouseInPointer(byval fEnable as WINBOOL) as WINBOOL
	declare function IsMouseInPointerEnabled() as WINBOOL
	declare function RegisterTouchHitTestingWindow(byval hwnd as HWND, byval value as ULONG) as WINBOOL
	declare function EvaluateProximityToRect(byval controlBoundingBox as const RECT ptr, byval pHitTestingInput as const TOUCH_HIT_TESTING_INPUT ptr, byval pProximityEval as TOUCH_HIT_TESTING_PROXIMITY_EVALUATION ptr) as WINBOOL
	declare function EvaluateProximityToPolygon(byval numVertices as UINT32, byval controlPolygon as const POINT ptr, byval pHitTestingInput as const TOUCH_HIT_TESTING_INPUT ptr, byval pProximityEval as TOUCH_HIT_TESTING_PROXIMITY_EVALUATION ptr) as WINBOOL
	declare function PackTouchHitTestingProximityEvaluation(byval pHitTestingInput as const TOUCH_HIT_TESTING_INPUT ptr, byval pProximityEval as const TOUCH_HIT_TESTING_PROXIMITY_EVALUATION ptr) as LRESULT
	declare function GetWindowFeedbackSetting(byval hwnd as HWND, byval feedback as FEEDBACK_TYPE, byval dwFlags as DWORD, byval pSize as UINT32 ptr, byval config as any ptr) as WINBOOL
	declare function SetWindowFeedbackSetting(byval hwnd as HWND, byval feedback as FEEDBACK_TYPE, byval dwFlags as DWORD, byval size as UINT32, byval configuration as const any ptr) as WINBOOL
#endif

type tagLASTINPUTINFO
	cbSize as UINT
	dwTime as DWORD
end type

type LASTINPUTINFO as tagLASTINPUTINFO
type PLASTINPUTINFO as tagLASTINPUTINFO ptr
declare function GetLastInputInfo(byval plii as PLASTINPUTINFO) as WINBOOL
declare function MapVirtualKeyA(byval uCode as UINT, byval uMapType as UINT) as UINT

#ifndef UNICODE
	declare function MapVirtualKey alias "MapVirtualKeyA"(byval uCode as UINT, byval uMapType as UINT) as UINT
#endif

declare function MapVirtualKeyW(byval uCode as UINT, byval uMapType as UINT) as UINT

#ifdef UNICODE
	declare function MapVirtualKey alias "MapVirtualKeyW"(byval uCode as UINT, byval uMapType as UINT) as UINT
#endif

declare function MapVirtualKeyExA(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT

#ifndef UNICODE
	declare function MapVirtualKeyEx alias "MapVirtualKeyExA"(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT
#endif

declare function MapVirtualKeyExW(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT

#ifdef UNICODE
	declare function MapVirtualKeyEx alias "MapVirtualKeyExW"(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT
#endif

declare function GetInputState() as WINBOOL
declare function GetQueueStatus(byval flags as UINT) as DWORD
declare function GetCapture() as HWND
declare function SetCapture(byval hWnd as HWND) as HWND
declare function ReleaseCapture() as WINBOOL
declare function MsgWaitForMultipleObjects(byval nCount as DWORD, byval pHandles as const HANDLE ptr, byval fWaitAll as WINBOOL, byval dwMilliseconds as DWORD, byval dwWakeMask as DWORD) as DWORD
declare function MsgWaitForMultipleObjectsEx(byval nCount as DWORD, byval pHandles as const HANDLE ptr, byval dwMilliseconds as DWORD, byval dwWakeMask as DWORD, byval dwFlags as DWORD) as DWORD

const MAPVK_VK_TO_VSC = 0
const MAPVK_VSC_TO_VK = 1
const MAPVK_VK_TO_CHAR = 2
const MAPVK_VSC_TO_VK_EX = 3

#if _WIN32_WINNT >= &h0600
	const MAPVK_VK_TO_VSC_EX = 4
#endif

const MWMO_WAITALL = &h0001
const MWMO_ALERTABLE = &h0002
const MWMO_INPUTAVAILABLE = &h0004
const QS_KEY = &h0001
const QS_MOUSEMOVE = &h0002
const QS_MOUSEBUTTON = &h0004
const QS_POSTMESSAGE = &h0008
const QS_TIMER = &h0010
const QS_PAINT = &h0020
const QS_SENDMESSAGE = &h0040
const QS_HOTKEY = &h0080
const QS_ALLPOSTMESSAGE = &h0100
const QS_RAWINPUT = &h0400

#if _WIN32_WINNT = &h0602
	const QS_TOUCH = &h0800
	const QS_POINTER = &h1000
#endif

const QS_MOUSE = QS_MOUSEMOVE or QS_MOUSEBUTTON

#if _WIN32_WINNT = &h0602
	const QS_INPUT = (((QS_MOUSE or QS_KEY) or QS_RAWINPUT) or QS_TOUCH) or QS_POINTER
#else
	const QS_INPUT = (QS_MOUSE or QS_KEY) or QS_RAWINPUT
#endif

const QS_ALLEVENTS = (((QS_INPUT or QS_POSTMESSAGE) or QS_TIMER) or QS_PAINT) or QS_HOTKEY
const QS_ALLINPUT = ((((QS_INPUT or QS_POSTMESSAGE) or QS_TIMER) or QS_PAINT) or QS_HOTKEY) or QS_SENDMESSAGE
const USER_TIMER_MAXIMUM = &h7FFFFFFF
const USER_TIMER_MINIMUM = &h0000000A

#if _WIN32_WINNT >= &h0601
	const TIMERV_DEFAULT_COALESCING = 0
	const TIMERV_NO_COALESCING = &hffffffff
	const TIMERV_COALESCING_MIN = 1
	const TIMERV_COALESCING_MAX = &h7ffffff5
#endif

declare function SetTimer(byval hWnd as HWND, byval nIDEvent as UINT_PTR, byval uElapse as UINT, byval lpTimerFunc as TIMERPROC) as UINT_PTR
declare function KillTimer(byval hWnd as HWND, byval uIDEvent as UINT_PTR) as WINBOOL
declare function IsWindowUnicode(byval hWnd as HWND) as WINBOOL
declare function EnableWindow(byval hWnd as HWND, byval bEnable as WINBOOL) as WINBOOL
declare function IsWindowEnabled(byval hWnd as HWND) as WINBOOL
declare function LoadAcceleratorsA(byval hInstance as HINSTANCE, byval lpTableName as LPCSTR) as HACCEL

#ifndef UNICODE
	declare function LoadAccelerators alias "LoadAcceleratorsA"(byval hInstance as HINSTANCE, byval lpTableName as LPCSTR) as HACCEL
#endif

declare function LoadAcceleratorsW(byval hInstance as HINSTANCE, byval lpTableName as LPCWSTR) as HACCEL

#ifdef UNICODE
	declare function LoadAccelerators alias "LoadAcceleratorsW"(byval hInstance as HINSTANCE, byval lpTableName as LPCWSTR) as HACCEL
#endif

declare function CreateAcceleratorTableA(byval paccel as LPACCEL, byval cAccel as long) as HACCEL

#ifndef UNICODE
	declare function CreateAcceleratorTable alias "CreateAcceleratorTableA"(byval paccel as LPACCEL, byval cAccel as long) as HACCEL
#endif

declare function CreateAcceleratorTableW(byval paccel as LPACCEL, byval cAccel as long) as HACCEL

#ifdef UNICODE
	declare function CreateAcceleratorTable alias "CreateAcceleratorTableW"(byval paccel as LPACCEL, byval cAccel as long) as HACCEL
#endif

declare function DestroyAcceleratorTable(byval hAccel as HACCEL) as WINBOOL
declare function CopyAcceleratorTableA(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long

#ifndef UNICODE
	declare function CopyAcceleratorTable alias "CopyAcceleratorTableA"(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long
#endif

declare function CopyAcceleratorTableW(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long

#ifdef UNICODE
	declare function CopyAcceleratorTable alias "CopyAcceleratorTableW"(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long
#endif

declare function TranslateAcceleratorA(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long

#ifndef UNICODE
	declare function TranslateAccelerator alias "TranslateAcceleratorA"(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long
#endif

declare function TranslateAcceleratorW(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long

#ifdef UNICODE
	declare function TranslateAccelerator alias "TranslateAcceleratorW"(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long
#endif

#if _WIN32_WINNT >= &h0601
	declare function SetCoalescableTimer(byval hWnd as HWND, byval nIDEvent as UINT_PTR, byval uElapse as UINT, byval lpTimerFunc as TIMERPROC, byval uToleranceDelay as ULONG) as UINT_PTR
#endif

const SM_CXSCREEN = 0
const SM_CYSCREEN = 1
const SM_CXVSCROLL = 2
const SM_CYHSCROLL = 3
const SM_CYCAPTION = 4
const SM_CXBORDER = 5
const SM_CYBORDER = 6
const SM_CXDLGFRAME = 7
const SM_CYDLGFRAME = 8
const SM_CYVTHUMB = 9
const SM_CXHTHUMB = 10
const SM_CXICON = 11
const SM_CYICON = 12
const SM_CXCURSOR = 13
const SM_CYCURSOR = 14
const SM_CYMENU = 15
const SM_CXFULLSCREEN = 16
const SM_CYFULLSCREEN = 17
const SM_CYKANJIWINDOW = 18
const SM_MOUSEPRESENT = 19
const SM_CYVSCROLL = 20
const SM_CXHSCROLL = 21
const SM_DEBUG = 22
const SM_SWAPBUTTON = 23
const SM_RESERVED1 = 24
const SM_RESERVED2 = 25
const SM_RESERVED3 = 26
const SM_RESERVED4 = 27
const SM_CXMIN = 28
const SM_CYMIN = 29
const SM_CXSIZE = 30
const SM_CYSIZE = 31
const SM_CXFRAME = 32
const SM_CYFRAME = 33
const SM_CXMINTRACK = 34
const SM_CYMINTRACK = 35
const SM_CXDOUBLECLK = 36
const SM_CYDOUBLECLK = 37
const SM_CXICONSPACING = 38
const SM_CYICONSPACING = 39
const SM_MENUDROPALIGNMENT = 40
const SM_PENWINDOWS = 41
const SM_DBCSENABLED = 42
const SM_CMOUSEBUTTONS = 43
const SM_CXFIXEDFRAME = SM_CXDLGFRAME
const SM_CYFIXEDFRAME = SM_CYDLGFRAME
const SM_CXSIZEFRAME = SM_CXFRAME
const SM_CYSIZEFRAME = SM_CYFRAME
const SM_SECURE = 44
const SM_CXEDGE = 45
const SM_CYEDGE = 46
const SM_CXMINSPACING = 47
const SM_CYMINSPACING = 48
const SM_CXSMICON = 49
const SM_CYSMICON = 50
const SM_CYSMCAPTION = 51
const SM_CXSMSIZE = 52
const SM_CYSMSIZE = 53
const SM_CXMENUSIZE = 54
const SM_CYMENUSIZE = 55
const SM_ARRANGE = 56
const SM_CXMINIMIZED = 57
const SM_CYMINIMIZED = 58
const SM_CXMAXTRACK = 59
const SM_CYMAXTRACK = 60
const SM_CXMAXIMIZED = 61
const SM_CYMAXIMIZED = 62
const SM_NETWORK = 63
const SM_CLEANBOOT = 67
const SM_CXDRAG = 68
const SM_CYDRAG = 69
const SM_SHOWSOUNDS = 70
const SM_CXMENUCHECK = 71
const SM_CYMENUCHECK = 72
const SM_SLOWMACHINE = 73
const SM_MIDEASTENABLED = 74
const SM_MOUSEWHEELPRESENT = 75
const SM_XVIRTUALSCREEN = 76
const SM_YVIRTUALSCREEN = 77
const SM_CXVIRTUALSCREEN = 78
const SM_CYVIRTUALSCREEN = 79
const SM_CMONITORS = 80
const SM_SAMEDISPLAYFORMAT = 81
const SM_IMMENABLED = 82
const SM_CXFOCUSBORDER = 83
const SM_CYFOCUSBORDER = 84
const SM_TABLETPC = 86
const SM_MEDIACENTER = 87
const SM_STARTER = 88
const SM_SERVERR2 = 89

#if _WIN32_WINNT <= &h0501
	const SM_CMETRICS = 91
#elseif (not defined(__FB_64BIT__)) and defined(UNICODE) and (_WIN32_WINNT = &h0502)
	const SM_CMETRICS = 97
#elseif _WIN32_WINNT >= &h0600
	const SM_MOUSEHORIZONTALWHEELPRESENT = 91
	const SM_CXPADDEDBORDER = 92
#endif

#if _WIN32_WINNT = &h0600
	const SM_CMETRICS = 93
#elseif _WIN32_WINNT >= &h0601
	const SM_DIGITIZER = 94
	const SM_MAXIMUMTOUCHES = 95
#endif

#if ((not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT >= &h0601))) or (defined(UNICODE) and ((defined(__FB_64BIT__) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT >= &h0601))) or ((not defined(__FB_64BIT__)) and (_WIN32_WINNT >= &h0601))))
	const SM_CMETRICS = 97
#endif

const SM_REMOTESESSION = &h1000
const SM_SHUTTINGDOWN = &h2000
const SM_REMOTECONTROL = &h2001
const SM_CARETBLINKINGENABLED = &h2002

#if _WIN32_WINNT = &h0602
	const SM_CONVERTIBLESLATEMODE = &h2003
	const SM_SYSTEMDOCKED = &h2004
#endif

declare function GetSystemMetrics(byval nIndex as long) as long
const PMB_ACTIVE = &h00000001
const MNC_IGNORE = 0
const MNC_CLOSE = 1
const MNC_EXECUTE = 2
const MNC_SELECT = 3
const MNS_NOCHECK = &h80000000
const MNS_MODELESS = &h40000000
const MNS_DRAGDROP = &h20000000
const MNS_AUTODISMISS = &h10000000
const MNS_NOTIFYBYPOS = &h08000000
const MNS_CHECKORBMP = &h04000000
const MIM_MAXHEIGHT = &h00000001
const MIM_BACKGROUND = &h00000002
const MIM_HELPID = &h00000004
const MIM_MENUDATA = &h00000008
const MIM_STYLE = &h00000010
const MIM_APPLYTOSUBMENUS = &h80000000
const MND_CONTINUE = 0
const MND_ENDMENU = 1
const MNGOF_TOPGAP = &h00000001
const MNGOF_BOTTOMGAP = &h00000002
const MNGO_NOINTERFACE = &h00000000
const MNGO_NOERROR = &h00000001
const MIIM_STATE = &h00000001
const MIIM_ID = &h00000002
const MIIM_SUBMENU = &h00000004
const MIIM_CHECKMARKS = &h00000008
const MIIM_TYPE = &h00000010
const MIIM_DATA = &h00000020
const MIIM_STRING = &h00000040
const MIIM_BITMAP = &h00000080
const MIIM_FTYPE = &h00000100
const HBMMENU_CALLBACK = cast(HBITMAP, -1)
const HBMMENU_SYSTEM = cast(HBITMAP, 1)
const HBMMENU_MBAR_RESTORE = cast(HBITMAP, 2)
const HBMMENU_MBAR_MINIMIZE = cast(HBITMAP, 3)
const HBMMENU_MBAR_CLOSE = cast(HBITMAP, 5)
const HBMMENU_MBAR_CLOSE_D = cast(HBITMAP, 6)
const HBMMENU_MBAR_MINIMIZE_D = cast(HBITMAP, 7)
const HBMMENU_POPUP_CLOSE = cast(HBITMAP, 8)
const HBMMENU_POPUP_RESTORE = cast(HBITMAP, 9)
const HBMMENU_POPUP_MAXIMIZE = cast(HBITMAP, 10)
const HBMMENU_POPUP_MINIMIZE = cast(HBITMAP, 11)
declare function LoadMenuA(byval hInstance as HINSTANCE, byval lpMenuName as LPCSTR) as HMENU

#ifndef UNICODE
	declare function LoadMenu alias "LoadMenuA"(byval hInstance as HINSTANCE, byval lpMenuName as LPCSTR) as HMENU
#endif

declare function LoadMenuW(byval hInstance as HINSTANCE, byval lpMenuName as LPCWSTR) as HMENU

#ifdef UNICODE
	declare function LoadMenu alias "LoadMenuW"(byval hInstance as HINSTANCE, byval lpMenuName as LPCWSTR) as HMENU
#endif

declare function LoadMenuIndirectA(byval lpMenuTemplate as const MENUTEMPLATEA ptr) as HMENU

#ifndef UNICODE
	declare function LoadMenuIndirect alias "LoadMenuIndirectA"(byval lpMenuTemplate as const MENUTEMPLATEA ptr) as HMENU
#endif

declare function LoadMenuIndirectW(byval lpMenuTemplate as const MENUTEMPLATEW ptr) as HMENU

#ifdef UNICODE
	declare function LoadMenuIndirect alias "LoadMenuIndirectW"(byval lpMenuTemplate as const MENUTEMPLATEW ptr) as HMENU
#endif

declare function GetMenu(byval hWnd as HWND) as HMENU
declare function SetMenu(byval hWnd as HWND, byval hMenu as HMENU) as WINBOOL
declare function ChangeMenuA(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL

#ifndef UNICODE
	declare function ChangeMenu alias "ChangeMenuA"(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL
#endif

declare function ChangeMenuW(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCWSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL

#ifdef UNICODE
	declare function ChangeMenu alias "ChangeMenuW"(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCWSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL
#endif

declare function HiliteMenuItem(byval hWnd as HWND, byval hMenu as HMENU, byval uIDHiliteItem as UINT, byval uHilite as UINT) as WINBOOL
declare function GetMenuStringA(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPSTR, byval cchMax as long, byval flags as UINT) as long

#ifndef UNICODE
	declare function GetMenuString alias "GetMenuStringA"(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPSTR, byval cchMax as long, byval flags as UINT) as long
#endif

declare function GetMenuStringW(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPWSTR, byval cchMax as long, byval flags as UINT) as long

#ifdef UNICODE
	declare function GetMenuString alias "GetMenuStringW"(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPWSTR, byval cchMax as long, byval flags as UINT) as long
#endif

declare function GetMenuState(byval hMenu as HMENU, byval uId as UINT, byval uFlags as UINT) as UINT
declare function DrawMenuBar(byval hWnd as HWND) as WINBOOL
declare function GetSystemMenu(byval hWnd as HWND, byval bRevert as WINBOOL) as HMENU
declare function CreateMenu() as HMENU
declare function CreatePopupMenu() as HMENU
declare function DestroyMenu(byval hMenu as HMENU) as WINBOOL
declare function CheckMenuItem(byval hMenu as HMENU, byval uIDCheckItem as UINT, byval uCheck as UINT) as DWORD
declare function EnableMenuItem(byval hMenu as HMENU, byval uIDEnableItem as UINT, byval uEnable as UINT) as WINBOOL
declare function GetSubMenu(byval hMenu as HMENU, byval nPos as long) as HMENU
declare function GetMenuItemID(byval hMenu as HMENU, byval nPos as long) as UINT
declare function GetMenuItemCount(byval hMenu as HMENU) as long
declare function InsertMenuA(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function InsertMenu alias "InsertMenuA"(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL
#endif

declare function InsertMenuW(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function InsertMenu alias "InsertMenuW"(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
#endif

declare function AppendMenuA(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function AppendMenu alias "AppendMenuA"(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL
#endif

declare function AppendMenuW(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function AppendMenu alias "AppendMenuW"(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
#endif

declare function ModifyMenuA(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function ModifyMenu alias "ModifyMenuA"(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL
#endif

declare function ModifyMenuW(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function ModifyMenu alias "ModifyMenuW"(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
#endif

declare function RemoveMenu(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT) as WINBOOL
declare function DeleteMenu(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT) as WINBOOL
declare function SetMenuItemBitmaps(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval hBitmapUnchecked as HBITMAP, byval hBitmapChecked as HBITMAP) as WINBOOL
declare function GetMenuCheckMarkDimensions() as LONG
declare function TrackPopupMenu(byval hMenu as HMENU, byval uFlags as UINT, byval x as long, byval y as long, byval nReserved as long, byval hWnd as HWND, byval prcRect as const RECT ptr) as WINBOOL

type tagTPMPARAMS
	cbSize as UINT
	rcExclude as RECT
end type

type TPMPARAMS as tagTPMPARAMS

type tagMENUINFO
	cbSize as DWORD
	fMask as DWORD
	dwStyle as DWORD
	cyMax as UINT
	hbrBack as HBRUSH
	dwContextHelpID as DWORD
	dwMenuData as ULONG_PTR
end type

type MENUINFO as tagMENUINFO
type LPMENUINFO as tagMENUINFO ptr
type LPTPMPARAMS as TPMPARAMS ptr
type LPCMENUINFO as const MENUINFO ptr

declare function TrackPopupMenuEx(byval as HMENU, byval as UINT, byval as long, byval as long, byval as HWND, byval as LPTPMPARAMS) as WINBOOL
declare function GetMenuInfo(byval as HMENU, byval as LPMENUINFO) as WINBOOL
declare function SetMenuInfo(byval as HMENU, byval as LPCMENUINFO) as WINBOOL
declare function EndMenu() as WINBOOL

#if _WIN32_WINNT >= &h0601
	declare function CalculatePopupWindowPosition(byval anchorPoint as const POINT ptr, byval windowSize as const SIZE ptr, byval flags as UINT, byval excludeRect as RECT ptr, byval popupWindowPosition as RECT ptr) as WINBOOL
#endif

type tagMENUGETOBJECTINFO
	dwFlags as DWORD
	uPos as UINT
	hmenu as HMENU
	riid as PVOID
	pvObj as PVOID
end type

type MENUGETOBJECTINFO as tagMENUGETOBJECTINFO
type PMENUGETOBJECTINFO as tagMENUGETOBJECTINFO ptr

type tagMENUITEMINFOA
	cbSize as UINT
	fMask as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hSubMenu as HMENU
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as ULONG_PTR
	dwTypeData as LPSTR
	cch as UINT
	hbmpItem as HBITMAP
end type

type MENUITEMINFOA as tagMENUITEMINFOA
type LPMENUITEMINFOA as tagMENUITEMINFOA ptr

type tagMENUITEMINFOW
	cbSize as UINT
	fMask as UINT
	fType as UINT
	fState as UINT
	wID as UINT
	hSubMenu as HMENU
	hbmpChecked as HBITMAP
	hbmpUnchecked as HBITMAP
	dwItemData as ULONG_PTR
	dwTypeData as LPWSTR
	cch as UINT
	hbmpItem as HBITMAP
end type

type MENUITEMINFOW as tagMENUITEMINFOW
type LPMENUITEMINFOW as tagMENUITEMINFOW ptr

#ifdef UNICODE
	type MENUITEMINFO as MENUITEMINFOW
	type LPMENUITEMINFO as LPMENUITEMINFOW
#else
	type MENUITEMINFO as MENUITEMINFOA
	type LPMENUITEMINFO as LPMENUITEMINFOA
#endif

type LPCMENUITEMINFOA as const MENUITEMINFOA ptr
type LPCMENUITEMINFOW as const MENUITEMINFOW ptr

#ifdef UNICODE
	type LPCMENUITEMINFO as LPCMENUITEMINFOW
#else
	type LPCMENUITEMINFO as LPCMENUITEMINFOA
#endif

declare function InsertMenuItemA(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOA) as WINBOOL

#ifndef UNICODE
	declare function InsertMenuItem alias "InsertMenuItemA"(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOA) as WINBOOL
#endif

declare function InsertMenuItemW(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOW) as WINBOOL

#ifdef UNICODE
	declare function InsertMenuItem alias "InsertMenuItemW"(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOW) as WINBOOL
#endif

declare function GetMenuItemInfoA(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOA) as WINBOOL

#ifndef UNICODE
	declare function GetMenuItemInfo alias "GetMenuItemInfoA"(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOA) as WINBOOL
#endif

declare function GetMenuItemInfoW(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOW) as WINBOOL

#ifdef UNICODE
	declare function GetMenuItemInfo alias "GetMenuItemInfoW"(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOW) as WINBOOL
#endif

declare function SetMenuItemInfoA(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOA) as WINBOOL

#ifndef UNICODE
	declare function SetMenuItemInfo alias "SetMenuItemInfoA"(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOA) as WINBOOL
#endif

declare function SetMenuItemInfoW(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOW) as WINBOOL

#ifdef UNICODE
	declare function SetMenuItemInfo alias "SetMenuItemInfoW"(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOW) as WINBOOL
#endif

const GMDI_USEDISABLED = &h0001
const GMDI_GOINTOPOPUPS = &h0002
declare function GetMenuDefaultItem(byval hMenu as HMENU, byval fByPos as UINT, byval gmdiFlags as UINT) as UINT
declare function SetMenuDefaultItem(byval hMenu as HMENU, byval uItem as UINT, byval fByPos as UINT) as WINBOOL
declare function GetMenuItemRect(byval hWnd as HWND, byval hMenu as HMENU, byval uItem as UINT, byval lprcItem as LPRECT) as WINBOOL
declare function MenuItemFromPoint(byval hWnd as HWND, byval hMenu as HMENU, byval ptScreen as POINT) as long

const TPM_LEFTBUTTON = &h0000
const TPM_RIGHTBUTTON = &h0002
const TPM_LEFTALIGN = &h0000
const TPM_CENTERALIGN = &h0004
const TPM_RIGHTALIGN = &h0008
const TPM_TOPALIGN = &h0000
const TPM_VCENTERALIGN = &h0010
const TPM_BOTTOMALIGN = &h0020
const TPM_HORIZONTAL = &h0000
const TPM_VERTICAL = &h0040
const TPM_NONOTIFY = &h0080
const TPM_RETURNCMD = &h0100
const TPM_RECURSE = &h0001
const TPM_HORPOSANIMATION = &h0400
const TPM_HORNEGANIMATION = &h0800
const TPM_VERPOSANIMATION = &h1000
const TPM_VERNEGANIMATION = &h2000
const TPM_NOANIMATION = &h4000
const TPM_LAYOUTRTL = &h8000

#if _WIN32_WINNT >= &h0601
	const TPM_WORKAREA = &h10000
#endif

type tagDROPSTRUCT
	hwndSource as HWND
	hwndSink as HWND
	wFmt as DWORD
	dwData as ULONG_PTR
	ptDrop as POINT
	dwControlData as DWORD
end type

type DROPSTRUCT as tagDROPSTRUCT
type PDROPSTRUCT as tagDROPSTRUCT ptr
type LPDROPSTRUCT as tagDROPSTRUCT ptr

const DOF_EXECUTABLE = &h8001
const DOF_DOCUMENT = &h8002
const DOF_DIRECTORY = &h8003
const DOF_MULTIPLE = &h8004
const DOF_PROGMAN = &h0001
const DOF_SHELLDATA = &h0002
const DO_DROPFILE = &h454C4946
const DO_PRINTFILE = &h544E5250

declare function DragObject(byval hwndParent as HWND, byval hwndFrom as HWND, byval fmt as UINT, byval data as ULONG_PTR, byval hcur as HCURSOR) as DWORD
declare function DragDetect(byval hwnd as HWND, byval pt as POINT) as WINBOOL
declare function DrawIcon(byval hDC as HDC, byval X as long, byval Y as long, byval hIcon as HICON) as WINBOOL

const DT_TOP = &h00000000
const DT_LEFT = &h00000000
const DT_CENTER = &h00000001
const DT_RIGHT = &h00000002
const DT_VCENTER = &h00000004
const DT_BOTTOM = &h00000008
const DT_WORDBREAK = &h00000010
const DT_SINGLELINE = &h00000020
const DT_EXPANDTABS = &h00000040
const DT_TABSTOP = &h00000080
const DT_NOCLIP = &h00000100
const DT_EXTERNALLEADING = &h00000200
const DT_CALCRECT = &h00000400
const DT_NOPREFIX = &h00000800
const DT_INTERNAL = &h00001000
const DT_EDITCONTROL = &h00002000
const DT_PATH_ELLIPSIS = &h00004000
const DT_END_ELLIPSIS = &h00008000
const DT_MODIFYSTRING = &h00010000
const DT_RTLREADING = &h00020000
const DT_WORD_ELLIPSIS = &h00040000
const DT_NOFULLWIDTHCHARBREAK = &h00080000
const DT_HIDEPREFIX = &h00100000
const DT_PREFIXONLY = &h00200000

type tagDRAWTEXTPARAMS
	cbSize as UINT
	iTabLength as long
	iLeftMargin as long
	iRightMargin as long
	uiLengthDrawn as UINT
end type

type DRAWTEXTPARAMS as tagDRAWTEXTPARAMS
type LPDRAWTEXTPARAMS as tagDRAWTEXTPARAMS ptr
declare function DrawTextA(byval hdc as HDC, byval lpchText as LPCSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long

#ifndef UNICODE
	declare function DrawText alias "DrawTextA"(byval hdc as HDC, byval lpchText as LPCSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long
#endif

declare function DrawTextW(byval hdc as HDC, byval lpchText as LPCWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long

#ifdef UNICODE
	declare function DrawText alias "DrawTextW"(byval hdc as HDC, byval lpchText as LPCWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long
#endif

declare function DrawTextExA(byval hdc as HDC, byval lpchText as LPSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long

#ifndef UNICODE
	declare function DrawTextEx alias "DrawTextExA"(byval hdc as HDC, byval lpchText as LPSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long
#endif

declare function DrawTextExW(byval hdc as HDC, byval lpchText as LPWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long

#ifdef UNICODE
	declare function DrawTextEx alias "DrawTextExW"(byval hdc as HDC, byval lpchText as LPWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long
#endif

declare function GrayStringA(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL

#ifndef UNICODE
	declare function GrayString alias "GrayStringA"(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL
#endif

declare function GrayStringW(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL

#ifdef UNICODE
	declare function GrayString alias "GrayStringW"(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL
#endif

declare function DrawStateA(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL

#ifndef UNICODE
	declare function DrawState alias "DrawStateA"(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
#endif

declare function DrawStateW(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL

#ifdef UNICODE
	declare function DrawState alias "DrawStateW"(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
#endif

declare function TabbedTextOutA(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG

#ifndef UNICODE
	declare function TabbedTextOut alias "TabbedTextOutA"(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG
#endif

declare function TabbedTextOutW(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG

#ifdef UNICODE
	declare function TabbedTextOut alias "TabbedTextOutW"(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG
#endif

declare function GetTabbedTextExtentA(byval hdc as HDC, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD

#ifndef UNICODE
	declare function GetTabbedTextExtent alias "GetTabbedTextExtentA"(byval hdc as HDC, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD
#endif

declare function GetTabbedTextExtentW(byval hdc as HDC, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD

#ifdef UNICODE
	declare function GetTabbedTextExtent alias "GetTabbedTextExtentW"(byval hdc as HDC, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD
#endif

declare function UpdateWindow(byval hWnd as HWND) as WINBOOL
declare function SetActiveWindow(byval hWnd as HWND) as HWND
declare function GetForegroundWindow() as HWND
declare function PaintDesktop(byval hdc as HDC) as WINBOOL
declare sub SwitchToThisWindow(byval hwnd as HWND, byval fUnknown as WINBOOL)
declare function SetForegroundWindow(byval hWnd as HWND) as WINBOOL
declare function AllowSetForegroundWindow(byval dwProcessId as DWORD) as WINBOOL
declare function LockSetForegroundWindow(byval uLockCode as UINT) as WINBOOL
declare function WindowFromDC(byval hDC as HDC) as HWND
declare function GetDC(byval hWnd as HWND) as HDC
declare function GetDCEx(byval hWnd as HWND, byval hrgnClip as HRGN, byval flags as DWORD) as HDC

const DST_COMPLEX = &h0000
const DST_TEXT = &h0001
const DST_PREFIXTEXT = &h0002
const DST_ICON = &h0003
const DST_BITMAP = &h0004
const DSS_NORMAL = &h0000
const DSS_UNION = &h0010
const DSS_DISABLED = &h0020
const DSS_MONO = &h0080
const DSS_HIDEPREFIX = &h0200
const DSS_PREFIXONLY = &h0400
const DSS_RIGHT = &h8000
const ASFW_ANY = cast(DWORD, -1)
const LSFW_LOCK = 1
const LSFW_UNLOCK = 2
const DCX_WINDOW = &h00000001
const DCX_CACHE = &h00000002
const DCX_NORESETATTRS = &h00000004
const DCX_CLIPCHILDREN = &h00000008
const DCX_CLIPSIBLINGS = &h00000010
const DCX_PARENTCLIP = &h00000020
const DCX_EXCLUDERGN = &h00000040
const DCX_INTERSECTRGN = &h00000080
const DCX_EXCLUDEUPDATE = &h00000100
const DCX_INTERSECTUPDATE = &h00000200
const DCX_LOCKWINDOWUPDATE = &h00000400
const DCX_VALIDATE = &h00200000

declare function GetWindowDC(byval hWnd as HWND) as HDC
declare function ReleaseDC(byval hWnd as HWND, byval hDC as HDC) as long
declare function BeginPaint(byval hWnd as HWND, byval lpPaint as LPPAINTSTRUCT) as HDC
declare function EndPaint(byval hWnd as HWND, byval lpPaint as const PAINTSTRUCT ptr) as WINBOOL
declare function GetUpdateRect(byval hWnd as HWND, byval lpRect as LPRECT, byval bErase as WINBOOL) as WINBOOL
declare function GetUpdateRgn(byval hWnd as HWND, byval hRgn as HRGN, byval bErase as WINBOOL) as long
declare function SetWindowRgn(byval hWnd as HWND, byval hRgn as HRGN, byval bRedraw as WINBOOL) as long
declare function GetWindowRgn(byval hWnd as HWND, byval hRgn as HRGN) as long
declare function GetWindowRgnBox(byval hWnd as HWND, byval lprc as LPRECT) as long
declare function ExcludeUpdateRgn(byval hDC as HDC, byval hWnd as HWND) as long
declare function InvalidateRect(byval hWnd as HWND, byval lpRect as const RECT ptr, byval bErase as WINBOOL) as WINBOOL
declare function ValidateRect(byval hWnd as HWND, byval lpRect as const RECT ptr) as WINBOOL
declare function InvalidateRgn(byval hWnd as HWND, byval hRgn as HRGN, byval bErase as WINBOOL) as WINBOOL
declare function ValidateRgn(byval hWnd as HWND, byval hRgn as HRGN) as WINBOOL
declare function RedrawWindow(byval hWnd as HWND, byval lprcUpdate as const RECT ptr, byval hrgnUpdate as HRGN, byval flags as UINT) as WINBOOL

const RDW_INVALIDATE = &h0001
const RDW_INTERNALPAINT = &h0002
const RDW_ERASE = &h0004
const RDW_VALIDATE = &h0008
const RDW_NOINTERNALPAINT = &h0010
const RDW_NOERASE = &h0020
const RDW_NOCHILDREN = &h0040
const RDW_ALLCHILDREN = &h0080
const RDW_UPDATENOW = &h0100
const RDW_ERASENOW = &h0200
const RDW_FRAME = &h0400
const RDW_NOFRAME = &h0800

declare function LockWindowUpdate(byval hWndLock as HWND) as WINBOOL
declare function ScrollWindow(byval hWnd as HWND, byval XAmount as long, byval YAmount as long, byval lpRect as const RECT ptr, byval lpClipRect as const RECT ptr) as WINBOOL
declare function ScrollDC(byval hDC as HDC, byval dx as long, byval dy as long, byval lprcScroll as const RECT ptr, byval lprcClip as const RECT ptr, byval hrgnUpdate as HRGN, byval lprcUpdate as LPRECT) as WINBOOL
declare function ScrollWindowEx(byval hWnd as HWND, byval dx as long, byval dy as long, byval prcScroll as const RECT ptr, byval prcClip as const RECT ptr, byval hrgnUpdate as HRGN, byval prcUpdate as LPRECT, byval flags as UINT) as long

const SW_SCROLLCHILDREN = &h0001
const SW_INVALIDATE = &h0002
const SW_ERASE = &h0004
const SW_SMOOTHSCROLL = &h0010

declare function SetScrollPos(byval hWnd as HWND, byval nBar as long, byval nPos as long, byval bRedraw as WINBOOL) as long
declare function GetScrollPos(byval hWnd as HWND, byval nBar as long) as long
declare function SetScrollRange(byval hWnd as HWND, byval nBar as long, byval nMinPos as long, byval nMaxPos as long, byval bRedraw as WINBOOL) as WINBOOL
declare function GetScrollRange(byval hWnd as HWND, byval nBar as long, byval lpMinPos as LPINT, byval lpMaxPos as LPINT) as WINBOOL
declare function ShowScrollBar(byval hWnd as HWND, byval wBar as long, byval bShow as WINBOOL) as WINBOOL
declare function EnableScrollBar(byval hWnd as HWND, byval wSBflags as UINT, byval wArrows as UINT) as WINBOOL

const ESB_ENABLE_BOTH = &h0000
const ESB_DISABLE_BOTH = &h0003
const ESB_DISABLE_LEFT = &h0001
const ESB_DISABLE_RIGHT = &h0002
const ESB_DISABLE_UP = &h0001
const ESB_DISABLE_DOWN = &h0002
const ESB_DISABLE_LTUP = ESB_DISABLE_LEFT
const ESB_DISABLE_RTDN = ESB_DISABLE_RIGHT
declare function SetPropA(byval hWnd as HWND, byval lpString as LPCSTR, byval hData as HANDLE) as WINBOOL

#ifndef UNICODE
	declare function SetProp alias "SetPropA"(byval hWnd as HWND, byval lpString as LPCSTR, byval hData as HANDLE) as WINBOOL
#endif

declare function SetPropW(byval hWnd as HWND, byval lpString as LPCWSTR, byval hData as HANDLE) as WINBOOL

#ifdef UNICODE
	declare function SetProp alias "SetPropW"(byval hWnd as HWND, byval lpString as LPCWSTR, byval hData as HANDLE) as WINBOOL
#endif

declare function GetPropA(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE

#ifndef UNICODE
	declare function GetProp alias "GetPropA"(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE
#endif

declare function GetPropW(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE

#ifdef UNICODE
	declare function GetProp alias "GetPropW"(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE
#endif

declare function RemovePropA(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE

#ifndef UNICODE
	declare function RemoveProp alias "RemovePropA"(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE
#endif

declare function RemovePropW(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE

#ifdef UNICODE
	declare function RemoveProp alias "RemovePropW"(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE
#endif

declare function EnumPropsExA(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXA, byval lParam as LPARAM) as long

#ifndef UNICODE
	declare function EnumPropsEx alias "EnumPropsExA"(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXA, byval lParam as LPARAM) as long
#endif

declare function EnumPropsExW(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXW, byval lParam as LPARAM) as long

#ifdef UNICODE
	declare function EnumPropsEx alias "EnumPropsExW"(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXW, byval lParam as LPARAM) as long
#endif

declare function EnumPropsA(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCA) as long

#ifndef UNICODE
	declare function EnumProps alias "EnumPropsA"(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCA) as long
#endif

declare function EnumPropsW(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCW) as long

#ifdef UNICODE
	declare function EnumProps alias "EnumPropsW"(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCW) as long
#endif

declare function SetWindowTextA(byval hWnd as HWND, byval lpString as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetWindowText alias "SetWindowTextA"(byval hWnd as HWND, byval lpString as LPCSTR) as WINBOOL
#endif

declare function SetWindowTextW(byval hWnd as HWND, byval lpString as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetWindowText alias "SetWindowTextW"(byval hWnd as HWND, byval lpString as LPCWSTR) as WINBOOL
#endif

declare function GetWindowTextA(byval hWnd as HWND, byval lpString as LPSTR, byval nMaxCount as long) as long

#ifndef UNICODE
	declare function GetWindowText alias "GetWindowTextA"(byval hWnd as HWND, byval lpString as LPSTR, byval nMaxCount as long) as long
#endif

declare function GetWindowTextW(byval hWnd as HWND, byval lpString as LPWSTR, byval nMaxCount as long) as long

#ifdef UNICODE
	declare function GetWindowText alias "GetWindowTextW"(byval hWnd as HWND, byval lpString as LPWSTR, byval nMaxCount as long) as long
#endif

declare function GetWindowTextLengthA(byval hWnd as HWND) as long

#ifndef UNICODE
	declare function GetWindowTextLength alias "GetWindowTextLengthA"(byval hWnd as HWND) as long
#endif

declare function GetWindowTextLengthW(byval hWnd as HWND) as long

#ifdef UNICODE
	declare function GetWindowTextLength alias "GetWindowTextLengthW"(byval hWnd as HWND) as long
#endif

declare function GetClientRect(byval hWnd as HWND, byval lpRect as LPRECT) as WINBOOL
declare function GetWindowRect(byval hWnd as HWND, byval lpRect as LPRECT) as WINBOOL
declare function AdjustWindowRect(byval lpRect as LPRECT, byval dwStyle as DWORD, byval bMenu as WINBOOL) as WINBOOL
declare function AdjustWindowRectEx(byval lpRect as LPRECT, byval dwStyle as DWORD, byval bMenu as WINBOOL, byval dwExStyle as DWORD) as WINBOOL
const HELPINFO_WINDOW = &h0001
const HELPINFO_MENUITEM = &h0002

type tagHELPINFO
	cbSize as UINT
	iContextType as long
	iCtrlId as long
	hItemHandle as HANDLE
	dwContextId as DWORD_PTR
	MousePos as POINT
end type

type HELPINFO as tagHELPINFO
type LPHELPINFO as tagHELPINFO ptr
declare function SetWindowContextHelpId(byval as HWND, byval as DWORD) as WINBOOL
declare function GetWindowContextHelpId(byval as HWND) as DWORD
declare function SetMenuContextHelpId(byval as HMENU, byval as DWORD) as WINBOOL
declare function GetMenuContextHelpId(byval as HMENU) as DWORD

const MB_OK = &h00000000
const MB_OKCANCEL = &h00000001
const MB_ABORTRETRYIGNORE = &h00000002
const MB_YESNOCANCEL = &h00000003
const MB_YESNO = &h00000004
const MB_RETRYCANCEL = &h00000005
const MB_CANCELTRYCONTINUE = &h00000006
const MB_ICONHAND = &h00000010
const MB_ICONQUESTION = &h00000020
const MB_ICONEXCLAMATION = &h00000030
const MB_ICONASTERISK = &h00000040
const MB_USERICON = &h00000080
const MB_ICONWARNING = MB_ICONEXCLAMATION
const MB_ICONERROR = MB_ICONHAND
const MB_ICONINFORMATION = MB_ICONASTERISK
const MB_ICONSTOP = MB_ICONHAND
const MB_DEFBUTTON1 = &h00000000
const MB_DEFBUTTON2 = &h00000100
const MB_DEFBUTTON3 = &h00000200
const MB_DEFBUTTON4 = &h00000300
const MB_APPLMODAL = &h00000000
const MB_SYSTEMMODAL = &h00001000
const MB_TASKMODAL = &h00002000
const MB_HELP = &h00004000
const MB_NOFOCUS = &h00008000
const MB_SETFOREGROUND = &h00010000
const MB_DEFAULT_DESKTOP_ONLY = &h00020000
const MB_TOPMOST = &h00040000
const MB_RIGHT = &h00080000
const MB_RTLREADING = &h00100000
const MB_SERVICE_NOTIFICATION = &h00200000
const MB_SERVICE_NOTIFICATION_NT3X = &h00040000
const MB_TYPEMASK = &h0000000F
const MB_ICONMASK = &h000000F0
const MB_DEFMASK = &h00000F00
const MB_MODEMASK = &h00003000
const MB_MISCMASK = &h0000C000
declare function MessageBoxA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long

#ifndef UNICODE
	declare function MessageBox alias "MessageBoxA"(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long
#endif

declare function MessageBoxW(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT) as long

#ifdef UNICODE
	declare function MessageBox alias "MessageBoxW"(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT) as long
#endif

declare function MessageBoxExA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT, byval wLanguageId as WORD) as long

#ifndef UNICODE
	declare function MessageBoxEx alias "MessageBoxExA"(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT, byval wLanguageId as WORD) as long
#endif

declare function MessageBoxExW(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT, byval wLanguageId as WORD) as long

#ifdef UNICODE
	declare function MessageBoxEx alias "MessageBoxExW"(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT, byval wLanguageId as WORD) as long
#endif

type MSGBOXCALLBACK as sub(byval lpHelpInfo as LPHELPINFO)

type tagMSGBOXPARAMSA
	cbSize as UINT
	hwndOwner as HWND
	hInstance as HINSTANCE
	lpszText as LPCSTR
	lpszCaption as LPCSTR
	dwStyle as DWORD
	lpszIcon as LPCSTR
	dwContextHelpId as DWORD_PTR
	lpfnMsgBoxCallback as MSGBOXCALLBACK
	dwLanguageId as DWORD
end type

type MSGBOXPARAMSA as tagMSGBOXPARAMSA
type PMSGBOXPARAMSA as tagMSGBOXPARAMSA ptr
type LPMSGBOXPARAMSA as tagMSGBOXPARAMSA ptr

type tagMSGBOXPARAMSW
	cbSize as UINT
	hwndOwner as HWND
	hInstance as HINSTANCE
	lpszText as LPCWSTR
	lpszCaption as LPCWSTR
	dwStyle as DWORD
	lpszIcon as LPCWSTR
	dwContextHelpId as DWORD_PTR
	lpfnMsgBoxCallback as MSGBOXCALLBACK
	dwLanguageId as DWORD
end type

type MSGBOXPARAMSW as tagMSGBOXPARAMSW
type PMSGBOXPARAMSW as tagMSGBOXPARAMSW ptr
type LPMSGBOXPARAMSW as tagMSGBOXPARAMSW ptr

#ifdef UNICODE
	type MSGBOXPARAMS as MSGBOXPARAMSW
	type PMSGBOXPARAMS as PMSGBOXPARAMSW
	type LPMSGBOXPARAMS as LPMSGBOXPARAMSW
#else
	type MSGBOXPARAMS as MSGBOXPARAMSA
	type PMSGBOXPARAMS as PMSGBOXPARAMSA
	type LPMSGBOXPARAMS as LPMSGBOXPARAMSA
#endif

declare function MessageBoxIndirectA(byval lpmbp as const MSGBOXPARAMSA ptr) as long

#ifndef UNICODE
	declare function MessageBoxIndirect alias "MessageBoxIndirectA"(byval lpmbp as const MSGBOXPARAMSA ptr) as long
#endif

declare function MessageBoxIndirectW(byval lpmbp as const MSGBOXPARAMSW ptr) as long

#ifdef UNICODE
	declare function MessageBoxIndirect alias "MessageBoxIndirectW"(byval lpmbp as const MSGBOXPARAMSW ptr) as long
#endif

declare function MessageBeep(byval uType as UINT) as WINBOOL
declare function ShowCursor(byval bShow as WINBOOL) as long
declare function SetCursorPos(byval X as long, byval Y as long) as WINBOOL
declare function SetCursor(byval hCursor as HCURSOR) as HCURSOR
declare function GetCursorPos(byval lpPoint as LPPOINT) as WINBOOL
declare function ClipCursor(byval lpRect as const RECT ptr) as WINBOOL
declare function GetClipCursor(byval lpRect as LPRECT) as WINBOOL
declare function GetCursor() as HCURSOR
declare function CreateCaret(byval hWnd as HWND, byval hBitmap as HBITMAP, byval nWidth as long, byval nHeight as long) as WINBOOL
declare function GetCaretBlinkTime() as UINT
declare function SetCaretBlinkTime(byval uMSeconds as UINT) as WINBOOL
declare function DestroyCaret() as WINBOOL
declare function HideCaret(byval hWnd as HWND) as WINBOOL
declare function ShowCaret(byval hWnd as HWND) as WINBOOL
declare function SetCaretPos(byval X as long, byval Y as long) as WINBOOL
declare function GetCaretPos(byval lpPoint as LPPOINT) as WINBOOL
declare function ClientToScreen(byval hWnd as HWND, byval lpPoint as LPPOINT) as WINBOOL
declare function ScreenToClient(byval hWnd as HWND, byval lpPoint as LPPOINT) as WINBOOL
declare function MapWindowPoints(byval hWndFrom as HWND, byval hWndTo as HWND, byval lpPoints as LPPOINT, byval cPoints as UINT) as long
declare function WindowFromPoint(byval Point as POINT) as HWND
declare function ChildWindowFromPoint(byval hWndParent as HWND, byval Point as POINT) as HWND
declare function ChildWindowFromPointEx(byval hwnd as HWND, byval pt as POINT, byval flags as UINT) as HWND

#if _WIN32_WINNT >= &h0600
	declare function SetPhysicalCursorPos(byval X as long, byval Y as long) as WINBOOL
	declare function GetPhysicalCursorPos(byval lpPoint as LPPOINT) as WINBOOL
	declare function LogicalToPhysicalPoint(byval hWnd as HWND, byval lpPoint as LPPOINT) as WINBOOL
	declare function PhysicalToLogicalPoint(byval hWnd as HWND, byval lpPoint as LPPOINT) as WINBOOL
	declare function WindowFromPhysicalPoint(byval Point as POINT) as HWND
#endif

const CWP_ALL = &h0000
const CWP_SKIPINVISIBLE = &h0001
const CWP_SKIPDISABLED = &h0002
const CWP_SKIPTRANSPARENT = &h0004
const CTLCOLOR_MSGBOX = 0
const CTLCOLOR_EDIT = 1
const CTLCOLOR_LISTBOX = 2
const CTLCOLOR_BTN = 3
const CTLCOLOR_DLG = 4
const CTLCOLOR_SCROLLBAR = 5
const CTLCOLOR_STATIC = 6
const CTLCOLOR_MAX = 7
const COLOR_SCROLLBAR = 0
const COLOR_BACKGROUND = 1
const COLOR_ACTIVECAPTION = 2
const COLOR_INACTIVECAPTION = 3
const COLOR_MENU = 4
const COLOR_WINDOW = 5
const COLOR_WINDOWFRAME = 6
const COLOR_MENUTEXT = 7
const COLOR_WINDOWTEXT = 8
const COLOR_CAPTIONTEXT = 9
const COLOR_ACTIVEBORDER = 10
const COLOR_INACTIVEBORDER = 11
const COLOR_APPWORKSPACE = 12
const COLOR_HIGHLIGHT = 13
const COLOR_HIGHLIGHTTEXT = 14
const COLOR_BTNFACE = 15
const COLOR_BTNSHADOW = 16
const COLOR_GRAYTEXT = 17
const COLOR_BTNTEXT = 18
const COLOR_INACTIVECAPTIONTEXT = 19
const COLOR_BTNHIGHLIGHT = 20
const COLOR_3DDKSHADOW = 21
const COLOR_3DLIGHT = 22
const COLOR_INFOTEXT = 23
const COLOR_INFOBK = 24
const COLOR_HOTLIGHT = 26
const COLOR_GRADIENTACTIVECAPTION = 27
const COLOR_GRADIENTINACTIVECAPTION = 28
const COLOR_MENUHILIGHT = 29
const COLOR_MENUBAR = 30
const COLOR_DESKTOP = COLOR_BACKGROUND
const COLOR_3DFACE = COLOR_BTNFACE
const COLOR_3DSHADOW = COLOR_BTNSHADOW
const COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT
const COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT
const COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT

declare function GetSysColor(byval nIndex as long) as DWORD
declare function GetSysColorBrush(byval nIndex as long) as HBRUSH
declare function SetSysColors(byval cElements as long, byval lpaElements as const INT_ ptr, byval lpaRgbValues as const COLORREF ptr) as WINBOOL
declare function DrawFocusRect(byval hDC as HDC, byval lprc as const RECT ptr) as WINBOOL
declare function FillRect(byval hDC as HDC, byval lprc as const RECT ptr, byval hbr as HBRUSH) as long
declare function FrameRect(byval hDC as HDC, byval lprc as const RECT ptr, byval hbr as HBRUSH) as long
declare function InvertRect(byval hDC as HDC, byval lprc as const RECT ptr) as WINBOOL
declare function SetRect(byval lprc as LPRECT, byval xLeft as long, byval yTop as long, byval xRight as long, byval yBottom as long) as WINBOOL
declare function SetRectEmpty(byval lprc as LPRECT) as WINBOOL
declare function CopyRect(byval lprcDst as LPRECT, byval lprcSrc as const RECT ptr) as WINBOOL
declare function InflateRect(byval lprc as LPRECT, byval dx as long, byval dy as long) as WINBOOL
declare function IntersectRect(byval lprcDst as LPRECT, byval lprcSrc1 as const RECT ptr, byval lprcSrc2 as const RECT ptr) as WINBOOL
declare function UnionRect(byval lprcDst as LPRECT, byval lprcSrc1 as const RECT ptr, byval lprcSrc2 as const RECT ptr) as WINBOOL
declare function SubtractRect(byval lprcDst as LPRECT, byval lprcSrc1 as const RECT ptr, byval lprcSrc2 as const RECT ptr) as WINBOOL
declare function OffsetRect(byval lprc as LPRECT, byval dx as long, byval dy as long) as WINBOOL
declare function IsRectEmpty(byval lprc as const RECT ptr) as WINBOOL
declare function EqualRect(byval lprc1 as const RECT ptr, byval lprc2 as const RECT ptr) as WINBOOL
declare function PtInRect(byval lprc as const RECT ptr, byval pt as POINT) as WINBOOL
declare function GetWindowWord(byval hWnd as HWND, byval nIndex as long) as WORD
declare function SetWindowWord(byval hWnd as HWND, byval nIndex as long, byval wNewWord as WORD) as WORD
declare function GetWindowLongA(byval hWnd as HWND, byval nIndex as long) as LONG

#ifndef UNICODE
	declare function GetWindowLong alias "GetWindowLongA"(byval hWnd as HWND, byval nIndex as long) as LONG
#endif

declare function GetWindowLongW(byval hWnd as HWND, byval nIndex as long) as LONG

#ifdef UNICODE
	declare function GetWindowLong alias "GetWindowLongW"(byval hWnd as HWND, byval nIndex as long) as LONG
#endif

declare function SetWindowLongA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG

#ifndef UNICODE
	declare function SetWindowLong alias "SetWindowLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
#endif

declare function SetWindowLongW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG

#ifdef UNICODE
	declare function SetWindowLong alias "SetWindowLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
#endif

#ifndef __FB_64BIT__
	declare function GetWindowLongPtrA alias "GetWindowLongA"(byval hWnd as HWND, byval nIndex as long) as LONG

	#ifndef UNICODE
		declare function GetWindowLongPtr alias "GetWindowLongA"(byval hWnd as HWND, byval nIndex as long) as LONG
	#endif

	declare function GetWindowLongPtrW alias "GetWindowLongW"(byval hWnd as HWND, byval nIndex as long) as LONG

	#ifdef UNICODE
		declare function GetWindowLongPtr alias "GetWindowLongW"(byval hWnd as HWND, byval nIndex as long) as LONG
	#endif

	declare function SetWindowLongPtrA alias "SetWindowLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG

	#ifndef UNICODE
		declare function SetWindowLongPtr alias "SetWindowLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
	#endif

	declare function SetWindowLongPtrW alias "SetWindowLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
#endif

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SetWindowLongPtr alias "SetWindowLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
#elseif defined(__FB_64BIT__)
	declare function GetWindowLongPtrA(byval hWnd as HWND, byval nIndex as long) as LONG_PTR
#endif

#ifdef __FB_64BIT__
	#ifndef UNICODE
		declare function GetWindowLongPtr alias "GetWindowLongPtrA"(byval hWnd as HWND, byval nIndex as long) as LONG_PTR
	#endif

	declare function GetWindowLongPtrW(byval hWnd as HWND, byval nIndex as long) as LONG_PTR

	#ifdef UNICODE
		declare function GetWindowLongPtr alias "GetWindowLongPtrW"(byval hWnd as HWND, byval nIndex as long) as LONG_PTR
	#endif

	declare function SetWindowLongPtrA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR

	#ifndef UNICODE
		declare function SetWindowLongPtr alias "SetWindowLongPtrA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR
	#endif

	declare function SetWindowLongPtrW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR

	#ifdef UNICODE
		declare function SetWindowLongPtr alias "SetWindowLongPtrW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR
	#endif
#endif

declare function GetClassWord(byval hWnd as HWND, byval nIndex as long) as WORD
declare function SetClassWord(byval hWnd as HWND, byval nIndex as long, byval wNewWord as WORD) as WORD
declare function GetClassLongA(byval hWnd as HWND, byval nIndex as long) as DWORD

#ifndef UNICODE
	declare function GetClassLong alias "GetClassLongA"(byval hWnd as HWND, byval nIndex as long) as DWORD
#endif

declare function GetClassLongW(byval hWnd as HWND, byval nIndex as long) as DWORD

#ifdef UNICODE
	declare function GetClassLong alias "GetClassLongW"(byval hWnd as HWND, byval nIndex as long) as DWORD
#endif

declare function SetClassLongA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD

#ifndef UNICODE
	declare function SetClassLong alias "SetClassLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
#endif

declare function SetClassLongW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD

#ifdef UNICODE
	declare function SetClassLong alias "SetClassLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
#endif

#ifndef __FB_64BIT__
	declare function GetClassLongPtrA alias "GetClassLongA"(byval hWnd as HWND, byval nIndex as long) as DWORD

	#ifndef UNICODE
		declare function GetClassLongPtr alias "GetClassLongA"(byval hWnd as HWND, byval nIndex as long) as DWORD
	#endif

	declare function GetClassLongPtrW alias "GetClassLongW"(byval hWnd as HWND, byval nIndex as long) as DWORD

	#ifdef UNICODE
		declare function GetClassLongPtr alias "GetClassLongW"(byval hWnd as HWND, byval nIndex as long) as DWORD
	#endif

	declare function SetClassLongPtrA alias "SetClassLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD

	#ifndef UNICODE
		declare function SetClassLongPtr alias "SetClassLongA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
	#endif

	declare function SetClassLongPtrW alias "SetClassLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
#endif

#if (not defined(__FB_64BIT__)) and defined(UNICODE)
	declare function SetClassLongPtr alias "SetClassLongW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
#elseif defined(__FB_64BIT__)
	declare function GetClassLongPtrA(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR
#endif

#ifdef __FB_64BIT__
	#ifndef UNICODE
		declare function GetClassLongPtr alias "GetClassLongPtrA"(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR
	#endif

	declare function GetClassLongPtrW(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR

	#ifdef UNICODE
		declare function GetClassLongPtr alias "GetClassLongPtrW"(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR
	#endif

	declare function SetClassLongPtrA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR

	#ifndef UNICODE
		declare function SetClassLongPtr alias "SetClassLongPtrA"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR
	#endif

	declare function SetClassLongPtrW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR

	#ifdef UNICODE
		declare function SetClassLongPtr alias "SetClassLongPtrW"(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR
	#endif
#endif

declare function GetProcessDefaultLayout(byval pdwDefaultLayout as DWORD ptr) as WINBOOL
declare function SetProcessDefaultLayout(byval dwDefaultLayout as DWORD) as WINBOOL
declare function GetDesktopWindow() as HWND
declare function GetParent(byval hWnd as HWND) as HWND
declare function SetParent(byval hWndChild as HWND, byval hWndNewParent as HWND) as HWND
declare function EnumChildWindows(byval hWndParent as HWND, byval lpEnumFunc as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function FindWindowA(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR) as HWND

#ifndef UNICODE
	declare function FindWindow alias "FindWindowA"(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR) as HWND
#endif

declare function FindWindowW(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR) as HWND

#ifdef UNICODE
	declare function FindWindow alias "FindWindowW"(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR) as HWND
#endif

declare function FindWindowExA(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCSTR, byval lpszWindow as LPCSTR) as HWND

#ifndef UNICODE
	declare function FindWindowEx alias "FindWindowExA"(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCSTR, byval lpszWindow as LPCSTR) as HWND
#endif

declare function FindWindowExW(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCWSTR, byval lpszWindow as LPCWSTR) as HWND

#ifdef UNICODE
	declare function FindWindowEx alias "FindWindowExW"(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCWSTR, byval lpszWindow as LPCWSTR) as HWND
#endif

declare function GetShellWindow() as HWND
declare function RegisterShellHookWindow(byval hwnd as HWND) as WINBOOL
declare function DeregisterShellHookWindow(byval hwnd as HWND) as WINBOOL
declare function EnumWindows(byval lpEnumFunc as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function EnumThreadWindows(byval dwThreadId as DWORD, byval lpfn as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
#define EnumTaskWindows(hTask, lpfn, lParam) EnumThreadWindows(HandleToUlong(hTask), lpfn, lParam)
declare function GetClassNameA(byval hWnd as HWND, byval lpClassName as LPSTR, byval nMaxCount as long) as long

#ifndef UNICODE
	declare function GetClassName alias "GetClassNameA"(byval hWnd as HWND, byval lpClassName as LPSTR, byval nMaxCount as long) as long
#endif

declare function GetClassNameW(byval hWnd as HWND, byval lpClassName as LPWSTR, byval nMaxCount as long) as long

#ifdef UNICODE
	declare function GetClassName alias "GetClassNameW"(byval hWnd as HWND, byval lpClassName as LPWSTR, byval nMaxCount as long) as long
#endif

declare function GetTopWindow(byval hWnd as HWND) as HWND
#define GetNextWindow(hWnd, wCmd) GetWindow(hWnd, wCmd)
#define GetSysModalWindow() NULL
#define SetSysModalWindow(hWnd) NULL
declare function GetWindowThreadProcessId(byval hWnd as HWND, byval lpdwProcessId as LPDWORD) as DWORD
declare function IsGUIThread(byval bConvert as WINBOOL) as WINBOOL
#define GetWindowTask(hWnd) cast(HANDLE, cast(DWORD_PTR, GetWindowThreadProcessId(hWnd, NULL)))
declare function GetLastActivePopup(byval hWnd as HWND) as HWND
const GW_HWNDFIRST = 0
const GW_HWNDLAST = 1
const GW_HWNDNEXT = 2
const GW_HWNDPREV = 3
const GW_OWNER = 4
const GW_CHILD = 5
const GW_ENABLEDPOPUP = 6
const GW_MAX = 6
declare function GetWindow(byval hWnd as HWND, byval uCmd as UINT) as HWND
declare function SetWindowsHookA(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK

#ifndef UNICODE
	declare function SetWindowsHook alias "SetWindowsHookA"(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK
#endif

declare function SetWindowsHookW(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK

#ifdef UNICODE
	declare function SetWindowsHook alias "SetWindowsHookW"(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK
#endif

#define DefHookProc(nCode, wParam, lParam, phhk) CallNextHookEx(*phhk, nCode, wParam, lParam)
declare function UnhookWindowsHook(byval nCode as long, byval pfnFilterProc as HOOKPROC) as WINBOOL
declare function SetWindowsHookExA(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK

#ifndef UNICODE
	declare function SetWindowsHookEx alias "SetWindowsHookExA"(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK
#endif

declare function SetWindowsHookExW(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK

#ifdef UNICODE
	declare function SetWindowsHookEx alias "SetWindowsHookExW"(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK
#endif

declare function UnhookWindowsHookEx(byval hhk as HHOOK) as WINBOOL
declare function CallNextHookEx(byval hhk as HHOOK, byval nCode as long, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
const MF_INSERT = &h00000000
const MF_CHANGE = &h00000080
const MF_APPEND = &h00000100
const MF_DELETE = &h00000200
const MF_REMOVE = &h00001000
const MF_BYCOMMAND = &h00000000
const MF_BYPOSITION = &h00000400
const MF_SEPARATOR = &h00000800
const MF_ENABLED = &h00000000
const MF_GRAYED = &h00000001
const MF_DISABLED = &h00000002
const MF_UNCHECKED = &h00000000
const MF_CHECKED = &h00000008
const MF_USECHECKBITMAPS = &h00000200
const MF_STRING = &h00000000
const MF_BITMAP = &h00000004
const MF_OWNERDRAW = &h00000100
const MF_POPUP = &h00000010
const MF_MENUBARBREAK = &h00000020
const MF_MENUBREAK = &h00000040
const MF_UNHILITE = &h00000000
const MF_HILITE = &h00000080
const MF_DEFAULT = &h00001000
const MF_SYSMENU = &h00002000
const MF_HELP = &h00004000
const MF_RIGHTJUSTIFY = &h00004000
const MF_MOUSESELECT = &h00008000
const MF_END = &h00000080
const MFT_STRING = MF_STRING
const MFT_BITMAP = MF_BITMAP
const MFT_MENUBARBREAK = MF_MENUBARBREAK
const MFT_MENUBREAK = MF_MENUBREAK
const MFT_OWNERDRAW = MF_OWNERDRAW
const MFT_RADIOCHECK = &h00000200
const MFT_SEPARATOR = MF_SEPARATOR
const MFT_RIGHTORDER = &h00002000
const MFT_RIGHTJUSTIFY = MF_RIGHTJUSTIFY
const MFS_GRAYED = &h00000003
const MFS_DISABLED = MFS_GRAYED
const MFS_CHECKED = MF_CHECKED
const MFS_HILITE = MF_HILITE
const MFS_ENABLED = MF_ENABLED
const MFS_UNCHECKED = MF_UNCHECKED
const MFS_UNHILITE = MF_UNHILITE
const MFS_DEFAULT = MF_DEFAULT
declare function CheckMenuRadioItem(byval hmenu as HMENU, byval first as UINT, byval last as UINT, byval check as UINT, byval flags as UINT) as WINBOOL

type MENUITEMTEMPLATEHEADER
	versionNumber as WORD
	offset as WORD
end type

type PMENUITEMTEMPLATEHEADER as MENUITEMTEMPLATEHEADER ptr

type MENUITEMTEMPLATE
	mtOption as WORD
	mtID as WORD
	mtString as wstring * 1
end type

type PMENUITEMTEMPLATE as MENUITEMTEMPLATE ptr
const MF_END = &h00000080
const SC_SIZE = &hF000
const SC_MOVE = &hF010
const SC_MINIMIZE = &hF020
const SC_MAXIMIZE = &hF030
const SC_NEXTWINDOW = &hF040
const SC_PREVWINDOW = &hF050
const SC_CLOSE = &hF060
const SC_VSCROLL = &hF070
const SC_HSCROLL = &hF080
const SC_MOUSEMENU = &hF090
const SC_KEYMENU = &hF100
const SC_ARRANGE = &hF110
const SC_RESTORE = &hF120
const SC_TASKLIST = &hF130
const SC_SCREENSAVE = &hF140
const SC_HOTKEY = &hF150
const SC_DEFAULT = &hF160
const SC_MONITORPOWER = &hF170
const SC_CONTEXTHELP = &hF180
const SC_SEPARATOR = &hF00F

#if _WIN32_WINNT >= &h0600
	const SCF_ISSECURE = &h00000001
#endif

#define GET_SC_WPARAM(wParam) (clng(wParam) and &hfff0)
const SC_ICON = SC_MINIMIZE
const SC_ZOOM = SC_MAXIMIZE
declare function LoadBitmapA(byval hInstance as HINSTANCE, byval lpBitmapName as LPCSTR) as HBITMAP

#ifndef UNICODE
	declare function LoadBitmap alias "LoadBitmapA"(byval hInstance as HINSTANCE, byval lpBitmapName as LPCSTR) as HBITMAP
#endif

declare function LoadBitmapW(byval hInstance as HINSTANCE, byval lpBitmapName as LPCWSTR) as HBITMAP

#ifdef UNICODE
	declare function LoadBitmap alias "LoadBitmapW"(byval hInstance as HINSTANCE, byval lpBitmapName as LPCWSTR) as HBITMAP
#endif

declare function LoadCursorA(byval hInstance as HINSTANCE, byval lpCursorName as LPCSTR) as HCURSOR

#ifndef UNICODE
	declare function LoadCursor alias "LoadCursorA"(byval hInstance as HINSTANCE, byval lpCursorName as LPCSTR) as HCURSOR
#endif

declare function LoadCursorW(byval hInstance as HINSTANCE, byval lpCursorName as LPCWSTR) as HCURSOR

#ifdef UNICODE
	declare function LoadCursor alias "LoadCursorW"(byval hInstance as HINSTANCE, byval lpCursorName as LPCWSTR) as HCURSOR
#endif

declare function LoadCursorFromFileA(byval lpFileName as LPCSTR) as HCURSOR

#ifndef UNICODE
	declare function LoadCursorFromFile alias "LoadCursorFromFileA"(byval lpFileName as LPCSTR) as HCURSOR
#endif

declare function LoadCursorFromFileW(byval lpFileName as LPCWSTR) as HCURSOR

#ifdef UNICODE
	declare function LoadCursorFromFile alias "LoadCursorFromFileW"(byval lpFileName as LPCWSTR) as HCURSOR
#endif

declare function CreateCursor(byval hInst as HINSTANCE, byval xHotSpot as long, byval yHotSpot as long, byval nWidth as long, byval nHeight as long, byval pvANDPlane as const any ptr, byval pvXORPlane as const any ptr) as HCURSOR
declare function DestroyCursor(byval hCursor as HCURSOR) as WINBOOL
#define CopyCursor(pcur) cast(HCURSOR, CopyIcon(cast(HICON, (pcur))))
#define IDC_ARROW MAKEINTRESOURCE(32512)
#define IDC_IBEAM MAKEINTRESOURCE(32513)
#define IDC_WAIT MAKEINTRESOURCE(32514)
#define IDC_CROSS MAKEINTRESOURCE(32515)
#define IDC_UPARROW MAKEINTRESOURCE(32516)
#define IDC_SIZE MAKEINTRESOURCE(32640)
#define IDC_ICON MAKEINTRESOURCE(32641)
#define IDC_SIZENWSE MAKEINTRESOURCE(32642)
#define IDC_SIZENESW MAKEINTRESOURCE(32643)
#define IDC_SIZEWE MAKEINTRESOURCE(32644)
#define IDC_SIZENS MAKEINTRESOURCE(32645)
#define IDC_SIZEALL MAKEINTRESOURCE(32646)
#define IDC_NO MAKEINTRESOURCE(32648)
#define IDC_HAND MAKEINTRESOURCE(32649)
#define IDC_APPSTARTING MAKEINTRESOURCE(32650)
#define IDC_HELP MAKEINTRESOURCE(32651)

type _ICONINFO
	fIcon as WINBOOL
	xHotspot as DWORD
	yHotspot as DWORD
	hbmMask as HBITMAP
	hbmColor as HBITMAP
end type

type ICONINFO as _ICONINFO
type PICONINFO as ICONINFO ptr
declare function SetSystemCursor(byval hcur as HCURSOR, byval id as DWORD) as WINBOOL
declare function LoadIconA(byval hInstance as HINSTANCE, byval lpIconName as LPCSTR) as HICON

#ifndef UNICODE
	declare function LoadIcon alias "LoadIconA"(byval hInstance as HINSTANCE, byval lpIconName as LPCSTR) as HICON
#endif

declare function LoadIconW(byval hInstance as HINSTANCE, byval lpIconName as LPCWSTR) as HICON

#ifdef UNICODE
	declare function LoadIcon alias "LoadIconW"(byval hInstance as HINSTANCE, byval lpIconName as LPCWSTR) as HICON
#endif

declare function PrivateExtractIconsA(byval szFileName as LPCSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT

#ifndef UNICODE
	declare function PrivateExtractIcons alias "PrivateExtractIconsA"(byval szFileName as LPCSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT
#endif

declare function PrivateExtractIconsW(byval szFileName as LPCWSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT

#ifdef UNICODE
	declare function PrivateExtractIcons alias "PrivateExtractIconsW"(byval szFileName as LPCWSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT
#endif

declare function CreateIcon(byval hInstance as HINSTANCE, byval nWidth as long, byval nHeight as long, byval cPlanes as UBYTE, byval cBitsPixel as UBYTE, byval lpbANDbits as const UBYTE ptr, byval lpbXORbits as const UBYTE ptr) as HICON
declare function DestroyIcon(byval hIcon as HICON) as WINBOOL
declare function LookupIconIdFromDirectory(byval presbits as PBYTE, byval fIcon as WINBOOL) as long
declare function LookupIconIdFromDirectoryEx(byval presbits as PBYTE, byval fIcon as WINBOOL, byval cxDesired as long, byval cyDesired as long, byval Flags as UINT) as long
declare function CreateIconFromResource(byval presbits as PBYTE, byval dwResSize as DWORD, byval fIcon as WINBOOL, byval dwVer as DWORD) as HICON
declare function CreateIconFromResourceEx(byval presbits as PBYTE, byval dwResSize as DWORD, byval fIcon as WINBOOL, byval dwVer as DWORD, byval cxDesired as long, byval cyDesired as long, byval Flags as UINT) as HICON

type tagCURSORSHAPE
	xHotSpot as long
	yHotSpot as long
	cx as long
	cy as long
	cbWidth as long
	Planes as UBYTE
	BitsPixel as UBYTE
end type

type CURSORSHAPE as tagCURSORSHAPE
type LPCURSORSHAPE as tagCURSORSHAPE ptr
const IMAGE_BITMAP = 0
const IMAGE_ICON = 1
const IMAGE_CURSOR = 2
const IMAGE_ENHMETAFILE = 3
const LR_DEFAULTCOLOR = &h0000
const LR_MONOCHROME = &h0001
const LR_COLOR = &h0002
const LR_COPYRETURNORG = &h0004
const LR_COPYDELETEORG = &h0008
const LR_LOADFROMFILE = &h0010
const LR_LOADTRANSPARENT = &h0020
const LR_DEFAULTSIZE = &h0040
const LR_VGACOLOR = &h0080
const LR_LOADMAP3DCOLORS = &h1000
const LR_CREATEDIBSECTION = &h2000
const LR_COPYFROMRESOURCE = &h4000
const LR_SHARED = &h8000
declare function LoadImageA(byval hInst as HINSTANCE, byval name as LPCSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE

#ifndef UNICODE
	declare function LoadImage alias "LoadImageA"(byval hInst as HINSTANCE, byval name as LPCSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE
#endif

declare function LoadImageW(byval hInst as HINSTANCE, byval name as LPCWSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE

#ifdef UNICODE
	declare function LoadImage alias "LoadImageW"(byval hInst as HINSTANCE, byval name as LPCWSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE
#endif

declare function CopyImage(byval h as HANDLE, byval type as UINT, byval cx as long, byval cy as long, byval flags as UINT) as HANDLE
declare function DrawIconEx(byval hdc as HDC, byval xLeft as long, byval yTop as long, byval hIcon as HICON, byval cxWidth as long, byval cyWidth as long, byval istepIfAniCur as UINT, byval hbrFlickerFreeDraw as HBRUSH, byval diFlags as UINT) as WINBOOL
declare function CreateIconIndirect(byval piconinfo as PICONINFO) as HICON
declare function CopyIcon(byval hIcon as HICON) as HICON
declare function GetIconInfo(byval hIcon as HICON, byval piconinfo as PICONINFO) as WINBOOL

#if _WIN32_WINNT >= &h0600
	type _ICONINFOEXA
		cbSize as DWORD
		fIcon as WINBOOL
		xHotspot as DWORD
		yHotspot as DWORD
		hbmMask as HBITMAP
		hbmColor as HBITMAP
		wResID as WORD
		szModName as zstring * 260
		szResName as zstring * 260
	end type

	type ICONINFOEXA as _ICONINFOEXA
	type PICONINFOEXA as _ICONINFOEXA ptr

	type _ICONINFOEXW
		cbSize as DWORD
		fIcon as WINBOOL
		xHotspot as DWORD
		yHotspot as DWORD
		hbmMask as HBITMAP
		hbmColor as HBITMAP
		wResID as WORD
		szModName as wstring * 260
		szResName as wstring * 260
	end type

	type ICONINFOEXW as _ICONINFOEXW
	type PICONINFOEXW as _ICONINFOEXW ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	type ICONINFOEX as ICONINFOEXW
	type PICONINFOEX as PICONINFOEXW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	type ICONINFOEX as ICONINFOEXA
	type PICONINFOEX as PICONINFOEXA
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetIconInfoExA(byval hicon as HICON, byval piconinfo as PICONINFOEXA) as WINBOOL
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetIconInfoEx alias "GetIconInfoExA"(byval hicon as HICON, byval piconinfo as PICONINFOEXA) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetIconInfoExW(byval hicon as HICON, byval piconinfo as PICONINFOEXW) as WINBOOL
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function GetIconInfoEx alias "GetIconInfoExW"(byval hicon as HICON, byval piconinfo as PICONINFOEXW) as WINBOOL
#endif

const DI_MASK = &h0001
const DI_IMAGE = &h0002
const DI_NORMAL = &h0003
const DI_COMPAT = &h0004
const DI_DEFAULTSIZE = &h0008
const DI_NOMIRROR = &h0010
const RES_ICON = 1
const RES_CURSOR = 2
const OBM_CLOSE = 32754
const OBM_UPARROW = 32753
const OBM_DNARROW = 32752
const OBM_RGARROW = 32751
const OBM_LFARROW = 32750
const OBM_REDUCE = 32749
const OBM_ZOOM = 32748
const OBM_RESTORE = 32747
const OBM_REDUCED = 32746
const OBM_ZOOMD = 32745
const OBM_RESTORED = 32744
const OBM_UPARROWD = 32743
const OBM_DNARROWD = 32742
const OBM_RGARROWD = 32741
const OBM_LFARROWD = 32740
const OBM_MNARROW = 32739
const OBM_COMBO = 32738
const OBM_UPARROWI = 32737
const OBM_DNARROWI = 32736
const OBM_RGARROWI = 32735
const OBM_LFARROWI = 32734
const OBM_OLD_CLOSE = 32767
const OBM_SIZE = 32766
const OBM_OLD_UPARROW = 32765
const OBM_OLD_DNARROW = 32764
const OBM_OLD_RGARROW = 32763
const OBM_OLD_LFARROW = 32762
const OBM_BTSIZE = 32761
const OBM_CHECK = 32760
const OBM_CHECKBOXES = 32759
const OBM_BTNCORNERS = 32758
const OBM_OLD_REDUCE = 32757
const OBM_OLD_ZOOM = 32756
const OBM_OLD_RESTORE = 32755
const OCR_NORMAL = 32512
const OCR_IBEAM = 32513
const OCR_WAIT = 32514
const OCR_CROSS = 32515
const OCR_UP = 32516
const OCR_SIZE = 32640
const OCR_ICON = 32641
const OCR_SIZENWSE = 32642
const OCR_SIZENESW = 32643
const OCR_SIZEWE = 32644
const OCR_SIZENS = 32645
const OCR_SIZEALL = 32646
const OCR_ICOCUR = 32647
const OCR_NO = 32648
const OCR_HAND = 32649
const OCR_APPSTARTING = 32650
const OIC_SAMPLE = 32512
const OIC_HAND = 32513
const OIC_QUES = 32514
const OIC_BANG = 32515
const OIC_NOTE = 32516
const OIC_WINLOGO = 32517
const OIC_WARNING = OIC_BANG
const OIC_ERROR = OIC_HAND
const OIC_INFORMATION = OIC_NOTE

#if _WIN32_WINNT >= &h0600
	const OIC_SHIELD = 32518
#endif

const ORD_LANGDRIVER = 1
#define IDI_APPLICATION MAKEINTRESOURCE(32512)
#define IDI_HAND MAKEINTRESOURCE(32513)
#define IDI_QUESTION MAKEINTRESOURCE(32514)
#define IDI_EXCLAMATION MAKEINTRESOURCE(32515)
#define IDI_ASTERISK MAKEINTRESOURCE(32516)
#define IDI_WINLOGO MAKEINTRESOURCE(32517)

#if _WIN32_WINNT >= &h0600
	#define IDI_SHIELD MAKEINTRESOURCE(32518)
#endif

#define IDI_WARNING IDI_EXCLAMATION
#define IDI_ERROR IDI_HAND
#define IDI_INFORMATION IDI_ASTERISK
const IDOK = 1
const IDCANCEL = 2
const IDABORT = 3
const IDRETRY = 4
const IDIGNORE = 5
const IDYES = 6
const IDNO = 7
const IDCLOSE = 8
const IDHELP = 9
const IDTRYAGAIN = 10
const IDCONTINUE = 11
const IDTIMEOUT = 32000
const ES_LEFT = &h0000
const ES_CENTER = &h0001
const ES_RIGHT = &h0002
const ES_MULTILINE = &h0004
const ES_UPPERCASE = &h0008
const ES_LOWERCASE = &h0010
const ES_PASSWORD = &h0020
const ES_AUTOVSCROLL = &h0040
const ES_AUTOHSCROLL = &h0080
const ES_NOHIDESEL = &h0100
const ES_OEMCONVERT = &h0400
const ES_READONLY = &h0800
const ES_WANTRETURN = &h1000
const ES_NUMBER = &h2000
const EN_SETFOCUS = &h0100
const EN_KILLFOCUS = &h0200
const EN_CHANGE = &h0300
const EN_UPDATE = &h0400
const EN_ERRSPACE = &h0500
const EN_MAXTEXT = &h0501
const EN_HSCROLL = &h0601
const EN_VSCROLL = &h0602
const EN_ALIGN_LTR_EC = &h0700
const EN_ALIGN_RTL_EC = &h0701
const EC_LEFTMARGIN = &h0001
const EC_RIGHTMARGIN = &h0002
const EC_USEFONTINFO = &hffff
const EMSIS_COMPOSITIONSTRING = &h0001
const EIMES_GETCOMPSTRATONCE = &h0001
const EIMES_CANCELCOMPSTRINFOCUS = &h0002
const EIMES_COMPLETECOMPSTRKILLFOCUS = &h0004
const EM_GETSEL = &h00B0
const EM_SETSEL = &h00B1
const EM_GETRECT = &h00B2
const EM_SETRECT = &h00B3
const EM_SETRECTNP = &h00B4
const EM_SCROLL = &h00B5
const EM_LINESCROLL = &h00B6
const EM_SCROLLCARET = &h00B7
const EM_GETMODIFY = &h00B8
const EM_SETMODIFY = &h00B9
const EM_GETLINECOUNT = &h00BA
const EM_LINEINDEX = &h00BB
const EM_SETHANDLE = &h00BC
const EM_GETHANDLE = &h00BD
const EM_GETTHUMB = &h00BE
const EM_LINELENGTH = &h00C1
const EM_REPLACESEL = &h00C2
const EM_GETLINE = &h00C4
const EM_LIMITTEXT = &h00C5
const EM_CANUNDO = &h00C6
const EM_UNDO = &h00C7
const EM_FMTLINES = &h00C8
const EM_LINEFROMCHAR = &h00C9
const EM_SETTABSTOPS = &h00CB
const EM_SETPASSWORDCHAR = &h00CC
const EM_EMPTYUNDOBUFFER = &h00CD
const EM_GETFIRSTVISIBLELINE = &h00CE
const EM_SETREADONLY = &h00CF
const EM_SETWORDBREAKPROC = &h00D0
const EM_GETWORDBREAKPROC = &h00D1
const EM_GETPASSWORDCHAR = &h00D2
const EM_SETMARGINS = &h00D3
const EM_GETMARGINS = &h00D4
const EM_SETLIMITTEXT = EM_LIMITTEXT
const EM_GETLIMITTEXT = &h00D5
const EM_POSFROMCHAR = &h00D6
const EM_CHARFROMPOS = &h00D7
const EM_SETIMESTATUS = &h00D8
const EM_GETIMESTATUS = &h00D9
const WB_LEFT = 0
const WB_RIGHT = 1
const WB_ISDELIMITER = 2
const BS_PUSHBUTTON = &h00000000
const BS_DEFPUSHBUTTON = &h00000001
const BS_CHECKBOX = &h00000002
const BS_AUTOCHECKBOX = &h00000003
const BS_RADIOBUTTON = &h00000004
const BS_3STATE = &h00000005
const BS_AUTO3STATE = &h00000006
const BS_GROUPBOX = &h00000007
const BS_USERBUTTON = &h00000008
const BS_AUTORADIOBUTTON = &h00000009
const BS_PUSHBOX = &h0000000A
const BS_OWNERDRAW = &h0000000B
const BS_TYPEMASK = &h0000000F
const BS_LEFTTEXT = &h00000020
const BS_TEXT = &h00000000
const BS_ICON = &h00000040
const BS_BITMAP = &h00000080
const BS_LEFT = &h00000100
const BS_RIGHT = &h00000200
const BS_CENTER = &h00000300
const BS_TOP = &h00000400
const BS_BOTTOM = &h00000800
const BS_VCENTER = &h00000C00
const BS_PUSHLIKE = &h00001000
const BS_MULTILINE = &h00002000
const BS_NOTIFY = &h00004000
const BS_FLAT = &h00008000
const BS_RIGHTBUTTON = BS_LEFTTEXT
const BN_CLICKED = 0
const BN_PAINT = 1
const BN_HILITE = 2
const BN_UNHILITE = 3
const BN_DISABLE = 4
const BN_DOUBLECLICKED = 5
const BN_PUSHED = BN_HILITE
const BN_UNPUSHED = BN_UNHILITE
const BN_DBLCLK = BN_DOUBLECLICKED
const BN_SETFOCUS = 6
const BN_KILLFOCUS = 7
const BM_GETCHECK = &h00F0
const BM_SETCHECK = &h00F1
const BM_GETSTATE = &h00F2
const BM_SETSTATE = &h00F3
const BM_SETSTYLE = &h00F4
const BM_CLICK = &h00F5
const BM_GETIMAGE = &h00F6
const BM_SETIMAGE = &h00F7

#if _WIN32_WINNT >= &h0600
	const BM_SETDONTCLICK = &h00f8
#endif

const BST_UNCHECKED = &h0000
const BST_CHECKED = &h0001
const BST_INDETERMINATE = &h0002
const BST_PUSHED = &h0004
const BST_FOCUS = &h0008
const SS_LEFT = &h00000000
const SS_CENTER = &h00000001
const SS_RIGHT = &h00000002
const SS_ICON = &h00000003
const SS_BLACKRECT = &h00000004
const SS_GRAYRECT = &h00000005
const SS_WHITERECT = &h00000006
const SS_BLACKFRAME = &h00000007
const SS_GRAYFRAME = &h00000008
const SS_WHITEFRAME = &h00000009
const SS_USERITEM = &h0000000A
const SS_SIMPLE = &h0000000B
const SS_LEFTNOWORDWRAP = &h0000000C
const SS_OWNERDRAW = &h0000000D
const SS_BITMAP = &h0000000E
const SS_ENHMETAFILE = &h0000000F
const SS_ETCHEDHORZ = &h00000010
const SS_ETCHEDVERT = &h00000011
const SS_ETCHEDFRAME = &h00000012
const SS_TYPEMASK = &h0000001F
const SS_REALSIZECONTROL = &h00000040
const SS_NOPREFIX = &h00000080
const SS_NOTIFY = &h00000100
const SS_CENTERIMAGE = &h00000200
const SS_RIGHTJUST = &h00000400
const SS_REALSIZEIMAGE = &h00000800
const SS_SUNKEN = &h00001000
const SS_EDITCONTROL = &h00002000
const SS_ENDELLIPSIS = &h00004000
const SS_PATHELLIPSIS = &h00008000
const SS_WORDELLIPSIS = &h0000C000
const SS_ELLIPSISMASK = &h0000C000
const STM_SETICON = &h0170
const STM_GETICON = &h0171
const STM_SETIMAGE = &h0172
const STM_GETIMAGE = &h0173
const STN_CLICKED = 0
const STN_DBLCLK = 1
const STN_ENABLE = 2
const STN_DISABLE = 3
const STM_MSGMAX = &h0174
#define WC_DIALOG MAKEINTATOM(&h8002)
const DWL_MSGRESULT = 0
const DWL_DLGPROC = 4
const DWL_USER = 8

#ifdef __FB_64BIT__
	#undef DWL_MSGRESULT
	#undef DWL_DLGPROC
	#undef DWL_USER
#endif

const DWLP_MSGRESULT = 0
#define DWLP_DLGPROC (DWLP_MSGRESULT + sizeof(LRESULT))
#define DWLP_USER (DWLP_DLGPROC + sizeof(DLGPROC))
const DDL_READWRITE = &h0000
const DDL_READONLY = &h0001
const DDL_HIDDEN = &h0002
const DDL_SYSTEM = &h0004
const DDL_DIRECTORY = &h0010
const DDL_ARCHIVE = &h0020
const DDL_POSTMSGS = &h2000
const DDL_DRIVES = &h4000
const DDL_EXCLUSIVE = &h8000
declare function IsDialogMessageA(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL

#ifndef UNICODE
	declare function IsDialogMessage alias "IsDialogMessageA"(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL
#endif

declare function IsDialogMessageW(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL

#ifdef UNICODE
	declare function IsDialogMessage alias "IsDialogMessageW"(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL
#endif

declare function MapDialogRect(byval hDlg as HWND, byval lpRect as LPRECT) as WINBOOL
declare function DlgDirListA(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long

#ifndef UNICODE
	declare function DlgDirList alias "DlgDirListA"(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long
#endif

declare function DlgDirListW(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long

#ifdef UNICODE
	declare function DlgDirList alias "DlgDirListW"(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long
#endif

declare function DlgDirSelectExA(byval hwndDlg as HWND, byval lpString as LPSTR, byval chCount as long, byval idListBox as long) as WINBOOL

#ifndef UNICODE
	declare function DlgDirSelectEx alias "DlgDirSelectExA"(byval hwndDlg as HWND, byval lpString as LPSTR, byval chCount as long, byval idListBox as long) as WINBOOL
#endif

declare function DlgDirSelectExW(byval hwndDlg as HWND, byval lpString as LPWSTR, byval chCount as long, byval idListBox as long) as WINBOOL

#ifdef UNICODE
	declare function DlgDirSelectEx alias "DlgDirSelectExW"(byval hwndDlg as HWND, byval lpString as LPWSTR, byval chCount as long, byval idListBox as long) as WINBOOL
#endif

declare function DlgDirListComboBoxA(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long

#ifndef UNICODE
	declare function DlgDirListComboBox alias "DlgDirListComboBoxA"(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long
#endif

declare function DlgDirListComboBoxW(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long

#ifdef UNICODE
	declare function DlgDirListComboBox alias "DlgDirListComboBoxW"(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long
#endif

declare function DlgDirSelectComboBoxExA(byval hwndDlg as HWND, byval lpString as LPSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL

#ifndef UNICODE
	declare function DlgDirSelectComboBoxEx alias "DlgDirSelectComboBoxExA"(byval hwndDlg as HWND, byval lpString as LPSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL
#endif

declare function DlgDirSelectComboBoxExW(byval hwndDlg as HWND, byval lpString as LPWSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL

#ifdef UNICODE
	declare function DlgDirSelectComboBoxEx alias "DlgDirSelectComboBoxExW"(byval hwndDlg as HWND, byval lpString as LPWSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL
#endif

const DS_ABSALIGN = &h01
const DS_SYSMODAL = &h02
const DS_LOCALEDIT = &h20
const DS_SETFONT = &h40
const DS_MODALFRAME = &h80
const DS_NOIDLEMSG = &h100
const DS_SETFOREGROUND = &h200
const DS_3DLOOK = &h0004
const DS_FIXEDSYS = &h0008
const DS_NOFAILCREATE = &h0010
const DS_CONTROL = &h0400
const DS_CENTER = &h0800
const DS_CENTERMOUSE = &h1000
const DS_CONTEXTHELP = &h2000
const DS_SHELLFONT = DS_SETFONT or DS_FIXEDSYS
const DM_GETDEFID = WM_USER + 0
const DM_SETDEFID = WM_USER + 1
const DM_REPOSITION = WM_USER + 2
const DC_HASDEFID = &h534B
const DLGC_WANTARROWS = &h0001
const DLGC_WANTTAB = &h0002
const DLGC_WANTALLKEYS = &h0004
const DLGC_WANTMESSAGE = &h0004
const DLGC_HASSETSEL = &h0008
const DLGC_DEFPUSHBUTTON = &h0010
const DLGC_UNDEFPUSHBUTTON = &h0020
const DLGC_RADIOBUTTON = &h0040
const DLGC_WANTCHARS = &h0080
const DLGC_STATIC = &h0100
const DLGC_BUTTON = &h2000
const LB_CTLCODE = 0
const LB_OKAY = 0
const LB_ERR = -1
const LB_ERRSPACE = -2
const LBN_ERRSPACE = -2
const LBN_SELCHANGE = 1
const LBN_DBLCLK = 2
const LBN_SELCANCEL = 3
const LBN_SETFOCUS = 4
const LBN_KILLFOCUS = 5
const LB_ADDSTRING = &h0180
const LB_INSERTSTRING = &h0181
const LB_DELETESTRING = &h0182
const LB_SELITEMRANGEEX = &h0183
const LB_RESETCONTENT = &h0184
const LB_SETSEL = &h0185
const LB_SETCURSEL = &h0186
const LB_GETSEL = &h0187
const LB_GETCURSEL = &h0188
const LB_GETTEXT = &h0189
const LB_GETTEXTLEN = &h018A
const LB_GETCOUNT = &h018B
const LB_SELECTSTRING = &h018C
const LB_DIR = &h018D
const LB_GETTOPINDEX = &h018E
const LB_FINDSTRING = &h018F
const LB_GETSELCOUNT = &h0190
const LB_GETSELITEMS = &h0191
const LB_SETTABSTOPS = &h0192
const LB_GETHORIZONTALEXTENT = &h0193
const LB_SETHORIZONTALEXTENT = &h0194
const LB_SETCOLUMNWIDTH = &h0195
const LB_ADDFILE = &h0196
const LB_SETTOPINDEX = &h0197
const LB_GETITEMRECT = &h0198
const LB_GETITEMDATA = &h0199
const LB_SETITEMDATA = &h019A
const LB_SELITEMRANGE = &h019B
const LB_SETANCHORINDEX = &h019C
const LB_GETANCHORINDEX = &h019D
const LB_SETCARETINDEX = &h019E
const LB_GETCARETINDEX = &h019F
const LB_SETITEMHEIGHT = &h01A0
const LB_GETITEMHEIGHT = &h01A1
const LB_FINDSTRINGEXACT = &h01A2
const LB_SETLOCALE = &h01A5
const LB_GETLOCALE = &h01A6
const LB_SETCOUNT = &h01A7
const LB_INITSTORAGE = &h01A8
const LB_ITEMFROMPOINT = &h01A9
const LB_GETLISTBOXINFO = &h01B2
const LB_MSGMAX = &h01B3
const LBS_NOTIFY = &h0001
const LBS_SORT = &h0002
const LBS_NOREDRAW = &h0004
const LBS_MULTIPLESEL = &h0008
const LBS_OWNERDRAWFIXED = &h0010
const LBS_OWNERDRAWVARIABLE = &h0020
const LBS_HASSTRINGS = &h0040
const LBS_USETABSTOPS = &h0080
const LBS_NOINTEGRALHEIGHT = &h0100
const LBS_MULTICOLUMN = &h0200
const LBS_WANTKEYBOARDINPUT = &h0400
const LBS_EXTENDEDSEL = &h0800
const LBS_DISABLENOSCROLL = &h1000
const LBS_NODATA = &h2000
const LBS_NOSEL = &h4000
const LBS_COMBOBOX = &h8000
const LBS_STANDARD = ((LBS_NOTIFY or LBS_SORT) or WS_VSCROLL) or WS_BORDER
const CB_OKAY = 0
const CB_ERR = -1
const CB_ERRSPACE = -2
const CBN_ERRSPACE = -1
const CBN_SELCHANGE = 1
const CBN_DBLCLK = 2
const CBN_SETFOCUS = 3
const CBN_KILLFOCUS = 4
const CBN_EDITCHANGE = 5
const CBN_EDITUPDATE = 6
const CBN_DROPDOWN = 7
const CBN_CLOSEUP = 8
const CBN_SELENDOK = 9
const CBN_SELENDCANCEL = 10
const CBS_SIMPLE = &h0001
const CBS_DROPDOWN = &h0002
const CBS_DROPDOWNLIST = &h0003
const CBS_OWNERDRAWFIXED = &h0010
const CBS_OWNERDRAWVARIABLE = &h0020
const CBS_AUTOHSCROLL = &h0040
const CBS_OEMCONVERT = &h0080
const CBS_SORT = &h0100
const CBS_HASSTRINGS = &h0200
const CBS_NOINTEGRALHEIGHT = &h0400
const CBS_DISABLENOSCROLL = &h0800
const CBS_UPPERCASE = &h2000
const CBS_LOWERCASE = &h4000
const CB_GETEDITSEL = &h0140
const CB_LIMITTEXT = &h0141
const CB_SETEDITSEL = &h0142
const CB_ADDSTRING = &h0143
const CB_DELETESTRING = &h0144
const CB_DIR = &h0145
const CB_GETCOUNT = &h0146
const CB_GETCURSEL = &h0147
const CB_GETLBTEXT = &h0148
const CB_GETLBTEXTLEN = &h0149
const CB_INSERTSTRING = &h014A
const CB_RESETCONTENT = &h014B
const CB_FINDSTRING = &h014C
const CB_SELECTSTRING = &h014D
const CB_SETCURSEL = &h014E
const CB_SHOWDROPDOWN = &h014F
const CB_GETITEMDATA = &h0150
const CB_SETITEMDATA = &h0151
const CB_GETDROPPEDCONTROLRECT = &h0152
const CB_SETITEMHEIGHT = &h0153
const CB_GETITEMHEIGHT = &h0154
const CB_SETEXTENDEDUI = &h0155
const CB_GETEXTENDEDUI = &h0156
const CB_GETDROPPEDSTATE = &h0157
const CB_FINDSTRINGEXACT = &h0158
const CB_SETLOCALE = &h0159
const CB_GETLOCALE = &h015A
const CB_GETTOPINDEX = &h015b
const CB_SETTOPINDEX = &h015c
const CB_GETHORIZONTALEXTENT = &h015d
const CB_SETHORIZONTALEXTENT = &h015e
const CB_GETDROPPEDWIDTH = &h015f
const CB_SETDROPPEDWIDTH = &h0160
const CB_INITSTORAGE = &h0161
const CB_GETCOMBOBOXINFO = &h0164
const CB_MSGMAX = &h0165
const SBS_HORZ = &h0000
const SBS_VERT = &h0001
const SBS_TOPALIGN = &h0002
const SBS_LEFTALIGN = &h0002
const SBS_BOTTOMALIGN = &h0004
const SBS_RIGHTALIGN = &h0004
const SBS_SIZEBOXTOPLEFTALIGN = &h0002
const SBS_SIZEBOXBOTTOMRIGHTALIGN = &h0004
const SBS_SIZEBOX = &h0008
const SBS_SIZEGRIP = &h0010
const SBM_SETPOS = &h00E0
const SBM_GETPOS = &h00E1
const SBM_SETRANGE = &h00E2
const SBM_SETRANGEREDRAW = &h00E6
const SBM_GETRANGE = &h00E3
const SBM_ENABLE_ARROWS = &h00E4
const SBM_SETSCROLLINFO = &h00E9
const SBM_GETSCROLLINFO = &h00EA
const SBM_GETSCROLLBARINFO = &h00EB
const SIF_RANGE = &h0001
const SIF_PAGE = &h0002
const SIF_POS = &h0004
const SIF_DISABLENOSCROLL = &h0008
const SIF_TRACKPOS = &h0010
const SIF_ALL = ((SIF_RANGE or SIF_PAGE) or SIF_POS) or SIF_TRACKPOS

type tagSCROLLINFO
	cbSize as UINT
	fMask as UINT
	nMin as long
	nMax as long
	nPage as UINT
	nPos as long
	nTrackPos as long
end type

type SCROLLINFO as tagSCROLLINFO
type LPSCROLLINFO as tagSCROLLINFO ptr
type LPCSCROLLINFO as const SCROLLINFO ptr
declare function SetScrollInfo(byval hwnd as HWND, byval nBar as long, byval lpsi as LPCSCROLLINFO, byval redraw as WINBOOL) as long
declare function GetScrollInfo(byval hwnd as HWND, byval nBar as long, byval lpsi as LPSCROLLINFO) as WINBOOL

const MDIS_ALLCHILDSTYLES = &h0001
const MDITILE_VERTICAL = &h0000
const MDITILE_HORIZONTAL = &h0001
const MDITILE_SKIPDISABLED = &h0002
const MDITILE_ZORDER = &h0004

type tagMDICREATESTRUCTA
	szClass as LPCSTR
	szTitle as LPCSTR
	hOwner as HANDLE
	x as long
	y as long
	cx as long
	cy as long
	style as DWORD
	lParam as LPARAM
end type

type MDICREATESTRUCTA as tagMDICREATESTRUCTA
type LPMDICREATESTRUCTA as tagMDICREATESTRUCTA ptr

type tagMDICREATESTRUCTW
	szClass as LPCWSTR
	szTitle as LPCWSTR
	hOwner as HANDLE
	x as long
	y as long
	cx as long
	cy as long
	style as DWORD
	lParam as LPARAM
end type

type MDICREATESTRUCTW as tagMDICREATESTRUCTW
type LPMDICREATESTRUCTW as tagMDICREATESTRUCTW ptr

#ifdef UNICODE
	type MDICREATESTRUCT as MDICREATESTRUCTW
	type LPMDICREATESTRUCT as LPMDICREATESTRUCTW
#else
	type MDICREATESTRUCT as MDICREATESTRUCTA
	type LPMDICREATESTRUCT as LPMDICREATESTRUCTA
#endif

type tagCLIENTCREATESTRUCT
	hWindowMenu as HANDLE
	idFirstChild as UINT
end type

type CLIENTCREATESTRUCT as tagCLIENTCREATESTRUCT
type LPCLIENTCREATESTRUCT as tagCLIENTCREATESTRUCT ptr
declare function DefFrameProcA(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function DefFrameProc alias "DefFrameProcA"(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefFrameProcW(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function DefFrameProc alias "DefFrameProcW"(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefMDIChildProcA(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifndef UNICODE
	declare function DefMDIChildProc alias "DefMDIChildProcA"(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function DefMDIChildProcW(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#ifdef UNICODE
	declare function DefMDIChildProc alias "DefMDIChildProcW"(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#endif

declare function TranslateMDISysAccel(byval hWndClient as HWND, byval lpMsg as LPMSG) as WINBOOL
declare function ArrangeIconicWindows(byval hWnd as HWND) as UINT
declare function CreateMDIWindowA(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND

#ifndef UNICODE
	declare function CreateMDIWindow alias "CreateMDIWindowA"(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND
#endif

declare function CreateMDIWindowW(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND

#ifdef UNICODE
	declare function CreateMDIWindow alias "CreateMDIWindowW"(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND
#endif

declare function TileWindows(byval hwndParent as HWND, byval wHow as UINT, byval lpRect as const RECT ptr, byval cKids as UINT, byval lpKids as const HWND ptr) as WORD
declare function CascadeWindows(byval hwndParent as HWND, byval wHow as UINT, byval lpRect as const RECT ptr, byval cKids as UINT, byval lpKids as const HWND ptr) as WORD
type HELPPOLY as DWORD

type tagMULTIKEYHELPA
	mkSize as DWORD
	mkKeylist as byte
	szKeyphrase as zstring * 1
end type

type MULTIKEYHELPA as tagMULTIKEYHELPA
type PMULTIKEYHELPA as tagMULTIKEYHELPA ptr
type LPMULTIKEYHELPA as tagMULTIKEYHELPA ptr

type tagMULTIKEYHELPW
	mkSize as DWORD
	mkKeylist as wchar_t
	szKeyphrase as wstring * 1
end type

type MULTIKEYHELPW as tagMULTIKEYHELPW
type PMULTIKEYHELPW as tagMULTIKEYHELPW ptr
type LPMULTIKEYHELPW as tagMULTIKEYHELPW ptr

#ifdef UNICODE
	type MULTIKEYHELP as MULTIKEYHELPW
	type PMULTIKEYHELP as PMULTIKEYHELPW
	type LPMULTIKEYHELP as LPMULTIKEYHELPW
#else
	type MULTIKEYHELP as MULTIKEYHELPA
	type PMULTIKEYHELP as PMULTIKEYHELPA
	type LPMULTIKEYHELP as LPMULTIKEYHELPA
#endif

type tagHELPWININFOA
	wStructSize as long
	x as long
	y as long
	dx as long
	dy as long
	wMax as long
	rgchMember as zstring * 2
end type

type HELPWININFOA as tagHELPWININFOA
type PHELPWININFOA as tagHELPWININFOA ptr
type LPHELPWININFOA as tagHELPWININFOA ptr

type tagHELPWININFOW
	wStructSize as long
	x as long
	y as long
	dx as long
	dy as long
	wMax as long
	rgchMember as wstring * 2
end type

type HELPWININFOW as tagHELPWININFOW
type PHELPWININFOW as tagHELPWININFOW ptr
type LPHELPWININFOW as tagHELPWININFOW ptr

#ifdef UNICODE
	type HELPWININFO as HELPWININFOW
	type PHELPWININFO as PHELPWININFOW
	type LPHELPWININFO as LPHELPWININFOW
#else
	type HELPWININFO as HELPWININFOA
	type PHELPWININFO as PHELPWININFOA
	type LPHELPWININFO as LPHELPWININFOA
#endif

declare function WinHelpA(byval hWndMain as HWND, byval lpszHelp as LPCSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL

#ifndef UNICODE
	declare function WinHelp alias "WinHelpA"(byval hWndMain as HWND, byval lpszHelp as LPCSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL
#endif

declare function WinHelpW(byval hWndMain as HWND, byval lpszHelp as LPCWSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL

#ifdef UNICODE
	declare function WinHelp alias "WinHelpW"(byval hWndMain as HWND, byval lpszHelp as LPCWSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL
#endif

const HELP_CONTEXT = &h0001
const HELP_QUIT = &h0002
const HELP_INDEX = &h0003
const HELP_CONTENTS = &h0003
const HELP_HELPONHELP = &h0004
const HELP_SETINDEX = &h0005
const HELP_SETCONTENTS = &h0005
const HELP_CONTEXTPOPUP = &h0008
const HELP_FORCEFILE = &h0009
const HELP_KEY = &h0101
const HELP_COMMAND = &h0102
const HELP_PARTIALKEY = &h0105
const HELP_MULTIKEY = &h0201
const HELP_SETWINPOS = &h0203
const HELP_CONTEXTMENU = &h000a
const HELP_FINDER = &h000b
const HELP_WM_HELP = &h000c
const HELP_SETPOPUP_POS = &h000d
const HELP_TCARD = &h8000
const HELP_TCARD_DATA = &h0010
const HELP_TCARD_OTHER_CALLER = &h0011
const IDH_NO_HELP = 28440
const IDH_MISSING_CONTEXT = 28441
const IDH_GENERIC_HELP_BUTTON = 28442
const IDH_OK = 28443
const IDH_CANCEL = 28444
const IDH_HELP = 28445
const GR_GDIOBJECTS = 0
const GR_USEROBJECTS = 1

#if _WIN32_WINNT >= &h0601
	const GR_GDIOBJECTS_PEAK = 2
	const GR_USEROBJECTS_PEAK = 4
	const GR_GLOBAL = cast(HANDLE, -2)
#endif

declare function GetGuiResources(byval hProcess as HANDLE, byval uiFlags as DWORD) as DWORD
const SPI_GETBEEP = &h0001
const SPI_SETBEEP = &h0002
const SPI_GETMOUSE = &h0003
const SPI_SETMOUSE = &h0004
const SPI_GETBORDER = &h0005
const SPI_SETBORDER = &h0006
const SPI_GETKEYBOARDSPEED = &h000A
const SPI_SETKEYBOARDSPEED = &h000B
const SPI_LANGDRIVER = &h000C
const SPI_ICONHORIZONTALSPACING = &h000D
const SPI_GETSCREENSAVETIMEOUT = &h000E
const SPI_SETSCREENSAVETIMEOUT = &h000F
const SPI_GETSCREENSAVEACTIVE = &h0010
const SPI_SETSCREENSAVEACTIVE = &h0011
const SPI_GETGRIDGRANULARITY = &h0012
const SPI_SETGRIDGRANULARITY = &h0013
const SPI_SETDESKWALLPAPER = &h0014
const SPI_SETDESKPATTERN = &h0015
const SPI_GETKEYBOARDDELAY = &h0016
const SPI_SETKEYBOARDDELAY = &h0017
const SPI_ICONVERTICALSPACING = &h0018
const SPI_GETICONTITLEWRAP = &h0019
const SPI_SETICONTITLEWRAP = &h001A
const SPI_GETMENUDROPALIGNMENT = &h001B
const SPI_SETMENUDROPALIGNMENT = &h001C
const SPI_SETDOUBLECLKWIDTH = &h001D
const SPI_SETDOUBLECLKHEIGHT = &h001E
const SPI_GETICONTITLELOGFONT = &h001F
const SPI_SETDOUBLECLICKTIME = &h0020
const SPI_SETMOUSEBUTTONSWAP = &h0021
const SPI_SETICONTITLELOGFONT = &h0022
const SPI_GETFASTTASKSWITCH = &h0023
const SPI_SETFASTTASKSWITCH = &h0024
const SPI_SETDRAGFULLWINDOWS = &h0025
const SPI_GETDRAGFULLWINDOWS = &h0026
const SPI_GETNONCLIENTMETRICS = &h0029
const SPI_SETNONCLIENTMETRICS = &h002A
const SPI_GETMINIMIZEDMETRICS = &h002B
const SPI_SETMINIMIZEDMETRICS = &h002C
const SPI_GETICONMETRICS = &h002D
const SPI_SETICONMETRICS = &h002E
const SPI_SETWORKAREA = &h002F
const SPI_GETWORKAREA = &h0030
const SPI_SETPENWINDOWS = &h0031
const SPI_GETHIGHCONTRAST = &h0042
const SPI_SETHIGHCONTRAST = &h0043
const SPI_GETKEYBOARDPREF = &h0044
const SPI_SETKEYBOARDPREF = &h0045
const SPI_GETSCREENREADER = &h0046
const SPI_SETSCREENREADER = &h0047
const SPI_GETANIMATION = &h0048
const SPI_SETANIMATION = &h0049
const SPI_GETFONTSMOOTHING = &h004A
const SPI_SETFONTSMOOTHING = &h004B
const SPI_SETDRAGWIDTH = &h004C
const SPI_SETDRAGHEIGHT = &h004D
const SPI_SETHANDHELD = &h004E
const SPI_GETLOWPOWERTIMEOUT = &h004F
const SPI_GETPOWEROFFTIMEOUT = &h0050
const SPI_SETLOWPOWERTIMEOUT = &h0051
const SPI_SETPOWEROFFTIMEOUT = &h0052
const SPI_GETLOWPOWERACTIVE = &h0053
const SPI_GETPOWEROFFACTIVE = &h0054
const SPI_SETLOWPOWERACTIVE = &h0055
const SPI_SETPOWEROFFACTIVE = &h0056
const SPI_SETCURSORS = &h0057
const SPI_SETICONS = &h0058
const SPI_GETDEFAULTINPUTLANG = &h0059
const SPI_SETDEFAULTINPUTLANG = &h005A
const SPI_SETLANGTOGGLE = &h005B
const SPI_GETWINDOWSEXTENSION = &h005C
const SPI_SETMOUSETRAILS = &h005D
const SPI_GETMOUSETRAILS = &h005E
const SPI_SETSCREENSAVERRUNNING = &h0061
const SPI_SCREENSAVERRUNNING = SPI_SETSCREENSAVERRUNNING
const SPI_GETFILTERKEYS = &h0032
const SPI_SETFILTERKEYS = &h0033
const SPI_GETTOGGLEKEYS = &h0034
const SPI_SETTOGGLEKEYS = &h0035
const SPI_GETMOUSEKEYS = &h0036
const SPI_SETMOUSEKEYS = &h0037
const SPI_GETSHOWSOUNDS = &h0038
const SPI_SETSHOWSOUNDS = &h0039
const SPI_GETSTICKYKEYS = &h003A
const SPI_SETSTICKYKEYS = &h003B
const SPI_GETACCESSTIMEOUT = &h003C
const SPI_SETACCESSTIMEOUT = &h003D
const SPI_GETSERIALKEYS = &h003E
const SPI_SETSERIALKEYS = &h003F
const SPI_GETSOUNDSENTRY = &h0040
const SPI_SETSOUNDSENTRY = &h0041
const SPI_GETSNAPTODEFBUTTON = &h005F
const SPI_SETSNAPTODEFBUTTON = &h0060
const SPI_GETMOUSEHOVERWIDTH = &h0062
const SPI_SETMOUSEHOVERWIDTH = &h0063
const SPI_GETMOUSEHOVERHEIGHT = &h0064
const SPI_SETMOUSEHOVERHEIGHT = &h0065
const SPI_GETMOUSEHOVERTIME = &h0066
const SPI_SETMOUSEHOVERTIME = &h0067
const SPI_GETWHEELSCROLLLINES = &h0068
const SPI_SETWHEELSCROLLLINES = &h0069
const SPI_GETMENUSHOWDELAY = &h006A
const SPI_SETMENUSHOWDELAY = &h006B

#if _WIN32_WINNT >= &h0600
	const SPI_GETWHEELSCROLLCHARS = &h006C
	const SPI_SETWHEELSCROLLCHARS = &h006D
#endif

const SPI_GETSHOWIMEUI = &h006E
const SPI_SETSHOWIMEUI = &h006F
const SPI_GETMOUSESPEED = &h0070
const SPI_SETMOUSESPEED = &h0071
const SPI_GETSCREENSAVERRUNNING = &h0072
const SPI_GETDESKWALLPAPER = &h0073

#if _WIN32_WINNT >= &h0600
	const SPI_GETAUDIODESCRIPTION = &h0074
	const SPI_SETAUDIODESCRIPTION = &h0075
	const SPI_GETSCREENSAVESECURE = &h0076
	const SPI_SETSCREENSAVESECURE = &h0077
#endif

#if _WIN32_WINNT >= &h0601
	const SPI_GETHUNGAPPTIMEOUT = &h0078
	const SPI_SETHUNGAPPTIMEOUT = &h0079
	const SPI_GETWAITTOKILLTIMEOUT = &h007a
	const SPI_SETWAITTOKILLTIMEOUT = &h007b
	const SPI_GETWAITTOKILLSERVICETIMEOUT = &h007c
	const SPI_SETWAITTOKILLSERVICETIMEOUT = &h007d
	const SPI_GETMOUSEDOCKTHRESHOLD = &h007e
	const SPI_SETMOUSEDOCKTHRESHOLD = &h007f
	const SPI_GETPENDOCKTHRESHOLD = &h0080
	const SPI_SETPENDOCKTHRESHOLD = &h0081
	const SPI_GETWINARRANGING = &h0082
	const SPI_SETWINARRANGING = &h0083
	const SPI_GETMOUSEDRAGOUTTHRESHOLD = &h0084
	const SPI_SETMOUSEDRAGOUTTHRESHOLD = &h0085
	const SPI_GETPENDRAGOUTTHRESHOLD = &h0086
	const SPI_SETPENDRAGOUTTHRESHOLD = &h0087
	const SPI_GETMOUSESIDEMOVETHRESHOLD = &h0088
	const SPI_SETMOUSESIDEMOVETHRESHOLD = &h0089
	const SPI_GETPENSIDEMOVETHRESHOLD = &h008a
	const SPI_SETPENSIDEMOVETHRESHOLD = &h008b
	const SPI_GETDRAGFROMMAXIMIZE = &h008c
	const SPI_SETDRAGFROMMAXIMIZE = &h008d
	const SPI_GETSNAPSIZING = &h008e
	const SPI_SETSNAPSIZING = &h008f
	const SPI_GETDOCKMOVING = &h0090
	const SPI_SETDOCKMOVING = &h0091
#endif

#if _WIN32_WINNT = &h0602
	const SPI_GETTOUCHPREDICTIONPARAMETERS = &h009c
	const SPI_SETTOUCHPREDICTIONPARAMETERS = &h009d
	const SPI_GETLOGICALDPIOVERRIDE = &h009e
	const SPI_SETLOGICALDPIOVERRIDE = &h009f
	const SPI_GETMOUSECORNERCLIPLENGTH = &h00a0
	const SPI_SETMOUSECORNERCLIPLENGTH = &h00a1
	const SPI_GETMENURECT = &h00a2
	const SPI_SETMENURECT = &h00a3
#endif

const SPI_GETACTIVEWINDOWTRACKING = &h1000
const SPI_SETACTIVEWINDOWTRACKING = &h1001
const SPI_GETMENUANIMATION = &h1002
const SPI_SETMENUANIMATION = &h1003
const SPI_GETCOMBOBOXANIMATION = &h1004
const SPI_SETCOMBOBOXANIMATION = &h1005
const SPI_GETLISTBOXSMOOTHSCROLLING = &h1006
const SPI_SETLISTBOXSMOOTHSCROLLING = &h1007
const SPI_GETGRADIENTCAPTIONS = &h1008
const SPI_SETGRADIENTCAPTIONS = &h1009
const SPI_GETKEYBOARDCUES = &h100A
const SPI_SETKEYBOARDCUES = &h100B
const SPI_GETMENUUNDERLINES = SPI_GETKEYBOARDCUES
const SPI_SETMENUUNDERLINES = SPI_SETKEYBOARDCUES
const SPI_GETACTIVEWNDTRKZORDER = &h100C
const SPI_SETACTIVEWNDTRKZORDER = &h100D
const SPI_GETHOTTRACKING = &h100E
const SPI_SETHOTTRACKING = &h100F
const SPI_GETMENUFADE = &h1012
const SPI_SETMENUFADE = &h1013
const SPI_GETSELECTIONFADE = &h1014
const SPI_SETSELECTIONFADE = &h1015
const SPI_GETTOOLTIPANIMATION = &h1016
const SPI_SETTOOLTIPANIMATION = &h1017
const SPI_GETTOOLTIPFADE = &h1018
const SPI_SETTOOLTIPFADE = &h1019
const SPI_GETCURSORSHADOW = &h101A
const SPI_SETCURSORSHADOW = &h101B
const SPI_GETMOUSESONAR = &h101C
const SPI_SETMOUSESONAR = &h101D
const SPI_GETMOUSECLICKLOCK = &h101E
const SPI_SETMOUSECLICKLOCK = &h101F
const SPI_GETMOUSEVANISH = &h1020
const SPI_SETMOUSEVANISH = &h1021
const SPI_GETFLATMENU = &h1022
const SPI_SETFLATMENU = &h1023
const SPI_GETDROPSHADOW = &h1024
const SPI_SETDROPSHADOW = &h1025
const SPI_GETBLOCKSENDINPUTRESETS = &h1026
const SPI_SETBLOCKSENDINPUTRESETS = &h1027
const SPI_GETUIEFFECTS = &h103E
const SPI_SETUIEFFECTS = &h103F

#if _WIN32_WINNT >= &h0600
	const SPI_GETDISABLEOVERLAPPEDCONTENT = &h1040
	const SPI_SETDISABLEOVERLAPPEDCONTENT = &h1041
	const SPI_GETCLIENTAREAANIMATION = &h1042
	const SPI_SETCLIENTAREAANIMATION = &h1043
	const SPI_GETCLEARTYPE = &h1048
	const SPI_SETCLEARTYPE = &h1049
	const SPI_GETSPEECHRECOGNITION = &h104a
	const SPI_SETSPEECHRECOGNITION = &h104b
#endif

#if _WIN32_WINNT >= &h0601
	const SPI_GETCARETBROWSING = &h104c
	const SPI_SETCARETBROWSING = &h104d
	const SPI_GETTHREADLOCALINPUTSETTINGS = &h104e
	const SPI_SETTHREADLOCALINPUTSETTINGS = &h104f
	const SPI_GETSYSTEMLANGUAGEBAR = &h1050
	const SPI_SETSYSTEMLANGUAGEBAR = &h1051
#endif

const SPI_GETFOREGROUNDLOCKTIMEOUT = &h2000
const SPI_SETFOREGROUNDLOCKTIMEOUT = &h2001
const SPI_GETACTIVEWNDTRKTIMEOUT = &h2002
const SPI_SETACTIVEWNDTRKTIMEOUT = &h2003
const SPI_GETFOREGROUNDFLASHCOUNT = &h2004
const SPI_SETFOREGROUNDFLASHCOUNT = &h2005
const SPI_GETCARETWIDTH = &h2006
const SPI_SETCARETWIDTH = &h2007
const SPI_GETMOUSECLICKLOCKTIME = &h2008
const SPI_SETMOUSECLICKLOCKTIME = &h2009
const SPI_GETFONTSMOOTHINGTYPE = &h200A
const SPI_SETFONTSMOOTHINGTYPE = &h200B
const FE_FONTSMOOTHINGSTANDARD = &h0001
const FE_FONTSMOOTHINGCLEARTYPE = &h0002
const FE_FONTSMOOTHINGDOCKING = &h8000
const SPI_GETFONTSMOOTHINGCONTRAST = &h200C
const SPI_SETFONTSMOOTHINGCONTRAST = &h200D
const SPI_GETFOCUSBORDERWIDTH = &h200E
const SPI_SETFOCUSBORDERWIDTH = &h200F
const SPI_GETFOCUSBORDERHEIGHT = &h2010
const SPI_SETFOCUSBORDERHEIGHT = &h2011
const SPI_GETFONTSMOOTHINGORIENTATION = &h2012
const SPI_SETFONTSMOOTHINGORIENTATION = &h2013

#if _WIN32_WINNT >= &h0600
	const SPI_GETMINIMUMHITRADIUS = &h2014
	const SPI_SETMINIMUMHITRADIUS = &h2015
	const SPI_GETMESSAGEDURATION = &h2016
	const SPI_SETMESSAGEDURATION = &h2017
#endif

#if _WIN32_WINNT = &h0602
	const SPI_GETCONTACTVISUALIZATION = &h2018
	const SPI_SETCONTACTVISUALIZATION = &h2019
	const SPI_GETGESTUREVISUALIZATION = &h201a
	const SPI_SETGESTUREVISUALIZATION = &h201b
	const CONTACTVISUALIZATION_OFF = &h0000
	const CONTACTVISUALIZATION_ON = &h0001
	const CONTACTVISUALIZATION_PRESENTATIONMODE = &h0002
	const GESTUREVISUALIZATION_OFF = &h0000
	const GESTUREVISUALIZATION_ON = &h001f
	const GESTUREVISUALIZATION_TAP = &h0001
	const GESTUREVISUALIZATION_DOUBLETAP = &h0002
	const GESTUREVISUALIZATION_PRESSANDTAP = &h0004
	const GESTUREVISUALIZATION_PRESSANDHOLD = &h0008
	const GESTUREVISUALIZATION_RIGHTTAP = &h0010
	const MAX_TOUCH_PREDICTION_FILTER_TAPS = 3

	type tagTouchPredictionParameters
		cbSize as UINT
		dwLatency as UINT
		dwSampleTime as UINT
		bUseHWTimeStamp as UINT
	end type

	type TOUCHPREDICTIONPARAMETERS as tagTouchPredictionParameters
	type PTOUCHPREDICTIONPARAMETERS as tagTouchPredictionParameters ptr
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_LATENCY = 8
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_SAMPLETIME = 8
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_USE_HW_TIMESTAMP = 1
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_DELTA = 0.001f
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MIN = 0.9f
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MAX = 0.999f
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_LEARNING_RATE = 0.001f
	const TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_EXPO_SMOOTH_ALPHA = 0.99f
	const MAX_LOGICALDPIOVERRIDE = 2
	const MIN_LOGICALDPIOVERRIDE = -2
#endif

const FE_FONTSMOOTHINGORIENTATIONBGR = &h0000
const FE_FONTSMOOTHINGORIENTATIONRGB = &h0001
const SPIF_UPDATEINIFILE = &h0001
const SPIF_SENDWININICHANGE = &h0002
const SPIF_SENDCHANGE = SPIF_SENDWININICHANGE
const METRICS_USEDEFAULT = -1

type tagNONCLIENTMETRICSA
	cbSize as UINT
	iBorderWidth as long
	iScrollWidth as long
	iScrollHeight as long
	iCaptionWidth as long
	iCaptionHeight as long
	lfCaptionFont as LOGFONTA
	iSmCaptionWidth as long
	iSmCaptionHeight as long
	lfSmCaptionFont as LOGFONTA
	iMenuWidth as long
	iMenuHeight as long
	lfMenuFont as LOGFONTA
	lfStatusFont as LOGFONTA
	lfMessageFont as LOGFONTA

	#if _WIN32_WINNT >= &h0600
		iPaddedBorderWidth as long
	#endif
end type

type NONCLIENTMETRICSA as tagNONCLIENTMETRICSA
type PNONCLIENTMETRICSA as tagNONCLIENTMETRICSA ptr
type LPNONCLIENTMETRICSA as tagNONCLIENTMETRICSA ptr

type tagNONCLIENTMETRICSW
	cbSize as UINT
	iBorderWidth as long
	iScrollWidth as long
	iScrollHeight as long
	iCaptionWidth as long
	iCaptionHeight as long
	lfCaptionFont as LOGFONTW
	iSmCaptionWidth as long
	iSmCaptionHeight as long
	lfSmCaptionFont as LOGFONTW
	iMenuWidth as long
	iMenuHeight as long
	lfMenuFont as LOGFONTW
	lfStatusFont as LOGFONTW
	lfMessageFont as LOGFONTW

	#if _WIN32_WINNT >= &h0600
		iPaddedBorderWidth as long
	#endif
end type

type NONCLIENTMETRICSW as tagNONCLIENTMETRICSW
type PNONCLIENTMETRICSW as tagNONCLIENTMETRICSW ptr
type LPNONCLIENTMETRICSW as tagNONCLIENTMETRICSW ptr

#ifdef UNICODE
	type NONCLIENTMETRICS as NONCLIENTMETRICSW
	type PNONCLIENTMETRICS as PNONCLIENTMETRICSW
	type LPNONCLIENTMETRICS as LPNONCLIENTMETRICSW
#else
	type NONCLIENTMETRICS as NONCLIENTMETRICSA
	type PNONCLIENTMETRICS as PNONCLIENTMETRICSA
	type LPNONCLIENTMETRICS as LPNONCLIENTMETRICSA
#endif

const ARW_BOTTOMLEFT = &h0000
const ARW_BOTTOMRIGHT = &h0001
const ARW_TOPLEFT = &h0002
const ARW_TOPRIGHT = &h0003
const ARW_STARTMASK = &h0003
const ARW_STARTRIGHT = &h0001
const ARW_STARTTOP = &h0002
const ARW_LEFT = &h0000
const ARW_RIGHT = &h0000
const ARW_UP = &h0004
const ARW_DOWN = &h0004
const ARW_HIDE = &h0008

type tagMINIMIZEDMETRICS
	cbSize as UINT
	iWidth as long
	iHorzGap as long
	iVertGap as long
	iArrange as long
end type

type MINIMIZEDMETRICS as tagMINIMIZEDMETRICS
type PMINIMIZEDMETRICS as tagMINIMIZEDMETRICS ptr
type LPMINIMIZEDMETRICS as tagMINIMIZEDMETRICS ptr

type tagICONMETRICSA
	cbSize as UINT
	iHorzSpacing as long
	iVertSpacing as long
	iTitleWrap as long
	lfFont as LOGFONTA
end type

type ICONMETRICSA as tagICONMETRICSA
type PICONMETRICSA as tagICONMETRICSA ptr
type LPICONMETRICSA as tagICONMETRICSA ptr

type tagICONMETRICSW
	cbSize as UINT
	iHorzSpacing as long
	iVertSpacing as long
	iTitleWrap as long
	lfFont as LOGFONTW
end type

type ICONMETRICSW as tagICONMETRICSW
type PICONMETRICSW as tagICONMETRICSW ptr
type LPICONMETRICSW as tagICONMETRICSW ptr

#ifdef UNICODE
	type ICONMETRICS as ICONMETRICSW
	type PICONMETRICS as PICONMETRICSW
	type LPICONMETRICS as LPICONMETRICSW
#else
	type ICONMETRICS as ICONMETRICSA
	type PICONMETRICS as PICONMETRICSA
	type LPICONMETRICS as LPICONMETRICSA
#endif

type tagANIMATIONINFO
	cbSize as UINT
	iMinAnimate as long
end type

type ANIMATIONINFO as tagANIMATIONINFO
type LPANIMATIONINFO as tagANIMATIONINFO ptr

type tagSERIALKEYSA
	cbSize as UINT
	dwFlags as DWORD
	lpszActivePort as LPSTR
	lpszPort as LPSTR
	iBaudRate as UINT
	iPortState as UINT
	iActive as UINT
end type

type SERIALKEYSA as tagSERIALKEYSA
type LPSERIALKEYSA as tagSERIALKEYSA ptr

type tagSERIALKEYSW
	cbSize as UINT
	dwFlags as DWORD
	lpszActivePort as LPWSTR
	lpszPort as LPWSTR
	iBaudRate as UINT
	iPortState as UINT
	iActive as UINT
end type

type SERIALKEYSW as tagSERIALKEYSW
type LPSERIALKEYSW as tagSERIALKEYSW ptr

#ifdef UNICODE
	type SERIALKEYS as SERIALKEYSW
	type LPSERIALKEYS as LPSERIALKEYSW
#else
	type SERIALKEYS as SERIALKEYSA
	type LPSERIALKEYS as LPSERIALKEYSA
#endif

type tagHIGHCONTRASTA
	cbSize as UINT
	dwFlags as DWORD
	lpszDefaultScheme as LPSTR
end type

type HIGHCONTRASTA as tagHIGHCONTRASTA
type LPHIGHCONTRASTA as tagHIGHCONTRASTA ptr

type tagHIGHCONTRASTW
	cbSize as UINT
	dwFlags as DWORD
	lpszDefaultScheme as LPWSTR
end type

type HIGHCONTRASTW as tagHIGHCONTRASTW
type LPHIGHCONTRASTW as tagHIGHCONTRASTW ptr

#ifdef UNICODE
	type HIGHCONTRAST as HIGHCONTRASTW
	type LPHIGHCONTRAST as LPHIGHCONTRASTW
#else
	type HIGHCONTRAST as HIGHCONTRASTA
	type LPHIGHCONTRAST as LPHIGHCONTRASTA
#endif

const SERKF_SERIALKEYSON = &h00000001
const SERKF_AVAILABLE = &h00000002
const SERKF_INDICATOR = &h00000004
const HCF_HIGHCONTRASTON = &h00000001
const HCF_AVAILABLE = &h00000002
const HCF_HOTKEYACTIVE = &h00000004
const HCF_CONFIRMHOTKEY = &h00000008
const HCF_HOTKEYSOUND = &h00000010
const HCF_INDICATOR = &h00000020
const HCF_HOTKEYAVAILABLE = &h00000040
const HCF_LOGONDESKTOP = &h00000100
const HCF_DEFAULTDESKTOP = &h00000200
const CDS_UPDATEREGISTRY = &h00000001
const CDS_TEST = &h00000002
const CDS_FULLSCREEN = &h00000004
const CDS_GLOBAL = &h00000008
const CDS_SET_PRIMARY = &h00000010
const CDS_VIDEOPARAMETERS = &h00000020

#if _WIN32_WINNT >= &h0600
	const CDS_ENABLE_UNSAFE_MODES = &h00000100
	const CDS_DISABLE_UNSAFE_MODES = &h00000200
#endif

const CDS_RESET = &h40000000
const CDS_RESET_EX = &h20000000
const CDS_NORESET = &h10000000
#define __TVOUT__

type _VIDEOPARAMETERS
	Guid as GUID
	dwOffset as ULONG
	dwCommand as ULONG
	dwFlags as ULONG
	dwMode as ULONG
	dwTVStandard as ULONG
	dwAvailableModes as ULONG
	dwAvailableTVStandard as ULONG
	dwFlickerFilter as ULONG
	dwOverScanX as ULONG
	dwOverScanY as ULONG
	dwMaxUnscaledX as ULONG
	dwMaxUnscaledY as ULONG
	dwPositionX as ULONG
	dwPositionY as ULONG
	dwBrightness as ULONG
	dwContrast as ULONG
	dwCPType as ULONG
	dwCPCommand as ULONG
	dwCPStandard as ULONG
	dwCPKey as ULONG
	bCP_APSTriggerBits as ULONG
	bOEMCopyProtection(0 to 255) as UCHAR
end type

type VIDEOPARAMETERS as _VIDEOPARAMETERS
type PVIDEOPARAMETERS as _VIDEOPARAMETERS ptr
type LPVIDEOPARAMETERS as _VIDEOPARAMETERS ptr

const VP_COMMAND_GET = &h0001
const VP_COMMAND_SET = &h0002
const VP_FLAGS_TV_MODE = &h0001
const VP_FLAGS_TV_STANDARD = &h0002
const VP_FLAGS_FLICKER = &h0004
const VP_FLAGS_OVERSCAN = &h0008
const VP_FLAGS_MAX_UNSCALED = &h0010
const VP_FLAGS_POSITION = &h0020
const VP_FLAGS_BRIGHTNESS = &h0040
const VP_FLAGS_CONTRAST = &h0080
const VP_FLAGS_COPYPROTECT = &h0100
const VP_MODE_WIN_GRAPHICS = &h0001
const VP_MODE_TV_PLAYBACK = &h0002
const VP_TV_STANDARD_NTSC_M = &h0001
const VP_TV_STANDARD_NTSC_M_J = &h0002
const VP_TV_STANDARD_PAL_B = &h0004
const VP_TV_STANDARD_PAL_D = &h0008
const VP_TV_STANDARD_PAL_H = &h0010
const VP_TV_STANDARD_PAL_I = &h0020
const VP_TV_STANDARD_PAL_M = &h0040
const VP_TV_STANDARD_PAL_N = &h0080
const VP_TV_STANDARD_SECAM_B = &h0100
const VP_TV_STANDARD_SECAM_D = &h0200
const VP_TV_STANDARD_SECAM_G = &h0400
const VP_TV_STANDARD_SECAM_H = &h0800
const VP_TV_STANDARD_SECAM_K = &h1000
const VP_TV_STANDARD_SECAM_K1 = &h2000
const VP_TV_STANDARD_SECAM_L = &h4000
const VP_TV_STANDARD_WIN_VGA = &h8000
const VP_TV_STANDARD_NTSC_433 = &h00010000
const VP_TV_STANDARD_PAL_G = &h00020000
const VP_TV_STANDARD_PAL_60 = &h00040000
const VP_TV_STANDARD_SECAM_L1 = &h00080000
const VP_CP_TYPE_APS_TRIGGER = &h0001
const VP_CP_TYPE_MACROVISION = &h0002
const VP_CP_CMD_ACTIVATE = &h0001
const VP_CP_CMD_DEACTIVATE = &h0002
const VP_CP_CMD_CHANGE = &h0004
const DISP_CHANGE_SUCCESSFUL = 0
const DISP_CHANGE_RESTART = 1
const DISP_CHANGE_FAILED = -1
const DISP_CHANGE_BADMODE = -2
const DISP_CHANGE_NOTUPDATED = -3
const DISP_CHANGE_BADFLAGS = -4
const DISP_CHANGE_BADPARAM = -5
const DISP_CHANGE_BADDUALVIEW = -6
declare function ChangeDisplaySettingsA(byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as LONG

#ifndef UNICODE
	declare function ChangeDisplaySettings alias "ChangeDisplaySettingsA"(byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as LONG
#endif

declare function ChangeDisplaySettingsW(byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as LONG

#ifdef UNICODE
	declare function ChangeDisplaySettings alias "ChangeDisplaySettingsW"(byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as LONG
#endif

declare function ChangeDisplaySettingsExA(byval lpszDeviceName as LPCSTR, byval lpDevMode as LPDEVMODEA, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG

#ifndef UNICODE
	declare function ChangeDisplaySettingsEx alias "ChangeDisplaySettingsExA"(byval lpszDeviceName as LPCSTR, byval lpDevMode as LPDEVMODEA, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG
#endif

declare function ChangeDisplaySettingsExW(byval lpszDeviceName as LPCWSTR, byval lpDevMode as LPDEVMODEW, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG

#ifdef UNICODE
	declare function ChangeDisplaySettingsEx alias "ChangeDisplaySettingsExW"(byval lpszDeviceName as LPCWSTR, byval lpDevMode as LPDEVMODEW, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG
#endif

const ENUM_CURRENT_SETTINGS = cast(DWORD, -1)
const ENUM_REGISTRY_SETTINGS = cast(DWORD, -2)
declare function EnumDisplaySettingsA(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA) as WINBOOL

#ifndef UNICODE
	declare function EnumDisplaySettings alias "EnumDisplaySettingsA"(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA) as WINBOOL
#endif

declare function EnumDisplaySettingsW(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW) as WINBOOL

#ifdef UNICODE
	declare function EnumDisplaySettings alias "EnumDisplaySettingsW"(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW) as WINBOOL
#endif

declare function EnumDisplaySettingsExA(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function EnumDisplaySettingsEx alias "EnumDisplaySettingsExA"(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as WINBOOL
#endif

declare function EnumDisplaySettingsExW(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function EnumDisplaySettingsEx alias "EnumDisplaySettingsExW"(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as WINBOOL
#endif

const EDS_RAWMODE = &h00000002
declare function EnumDisplayDevicesA(byval lpDevice as LPCSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEA, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function EnumDisplayDevices alias "EnumDisplayDevicesA"(byval lpDevice as LPCSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEA, byval dwFlags as DWORD) as WINBOOL
#endif

declare function EnumDisplayDevicesW(byval lpDevice as LPCWSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEW, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function EnumDisplayDevices alias "EnumDisplayDevicesW"(byval lpDevice as LPCWSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEW, byval dwFlags as DWORD) as WINBOOL
#endif

const EDD_GET_DEVICE_INTERFACE_NAME = &h00000001

#if _WIN32_WINNT >= &h0601
	declare function GetDisplayConfigBufferSizes(byval flags as UINT32, byval numPathArrayElements as UINT32 ptr, byval numModeInfoArrayElements as UINT32 ptr) as LONG
	declare function SetDisplayConfig(byval numPathArrayElements as UINT32, byval pathArray as DISPLAYCONFIG_PATH_INFO ptr, byval numModeInfoArrayElements as UINT32, byval modeInfoArray as DISPLAYCONFIG_MODE_INFO ptr, byval flags as UINT32) as LONG
	declare function QueryDisplayConfig(byval flags as UINT32, byval numPathArrayElements as UINT32 ptr, byval pathArray as DISPLAYCONFIG_PATH_INFO ptr, byval numModeInfoArrayElements as UINT32 ptr, byval modeInfoArray as DISPLAYCONFIG_MODE_INFO ptr, byval currentTopologyId as DISPLAYCONFIG_TOPOLOGY_ID ptr) as LONG
	declare function DisplayConfigGetDeviceInfo(byval requestPacket as DISPLAYCONFIG_DEVICE_INFO_HEADER ptr) as LONG
	declare function DisplayConfigSetDeviceInfo(byval setPacket as DISPLAYCONFIG_DEVICE_INFO_HEADER ptr) as LONG
#endif

declare function SystemParametersInfoA(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL

#ifndef UNICODE
	declare function SystemParametersInfo alias "SystemParametersInfoA"(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL
#endif

declare function SystemParametersInfoW(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL

#ifdef UNICODE
	declare function SystemParametersInfo alias "SystemParametersInfoW"(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL
#endif

type tagFILTERKEYS
	cbSize as UINT
	dwFlags as DWORD
	iWaitMSec as DWORD
	iDelayMSec as DWORD
	iRepeatMSec as DWORD
	iBounceMSec as DWORD
end type

type FILTERKEYS as tagFILTERKEYS
type LPFILTERKEYS as tagFILTERKEYS ptr
const FKF_FILTERKEYSON = &h00000001
const FKF_AVAILABLE = &h00000002
const FKF_HOTKEYACTIVE = &h00000004
const FKF_CONFIRMHOTKEY = &h00000008
const FKF_HOTKEYSOUND = &h00000010
const FKF_INDICATOR = &h00000020
const FKF_CLICKON = &h00000040

type tagSTICKYKEYS
	cbSize as UINT
	dwFlags as DWORD
end type

type STICKYKEYS as tagSTICKYKEYS
type LPSTICKYKEYS as tagSTICKYKEYS ptr
const SKF_STICKYKEYSON = &h00000001
const SKF_AVAILABLE = &h00000002
const SKF_HOTKEYACTIVE = &h00000004
const SKF_CONFIRMHOTKEY = &h00000008
const SKF_HOTKEYSOUND = &h00000010
const SKF_INDICATOR = &h00000020
const SKF_AUDIBLEFEEDBACK = &h00000040
const SKF_TRISTATE = &h00000080
const SKF_TWOKEYSOFF = &h00000100
const SKF_LALTLATCHED = &h10000000
const SKF_LCTLLATCHED = &h04000000
const SKF_LSHIFTLATCHED = &h01000000
const SKF_RALTLATCHED = &h20000000
const SKF_RCTLLATCHED = &h08000000
const SKF_RSHIFTLATCHED = &h02000000
const SKF_LWINLATCHED = &h40000000
const SKF_RWINLATCHED = &h80000000
const SKF_LALTLOCKED = &h00100000
const SKF_LCTLLOCKED = &h00040000
const SKF_LSHIFTLOCKED = &h00010000
const SKF_RALTLOCKED = &h00200000
const SKF_RCTLLOCKED = &h00080000
const SKF_RSHIFTLOCKED = &h00020000
const SKF_LWINLOCKED = &h00400000
const SKF_RWINLOCKED = &h00800000

type tagMOUSEKEYS
	cbSize as UINT
	dwFlags as DWORD
	iMaxSpeed as DWORD
	iTimeToMaxSpeed as DWORD
	iCtrlSpeed as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type MOUSEKEYS as tagMOUSEKEYS
type LPMOUSEKEYS as tagMOUSEKEYS ptr
const MKF_MOUSEKEYSON = &h00000001
const MKF_AVAILABLE = &h00000002
const MKF_HOTKEYACTIVE = &h00000004
const MKF_CONFIRMHOTKEY = &h00000008
const MKF_HOTKEYSOUND = &h00000010
const MKF_INDICATOR = &h00000020
const MKF_MODIFIERS = &h00000040
const MKF_REPLACENUMBERS = &h00000080
const MKF_LEFTBUTTONSEL = &h10000000
const MKF_RIGHTBUTTONSEL = &h20000000
const MKF_LEFTBUTTONDOWN = &h01000000
const MKF_RIGHTBUTTONDOWN = &h02000000
const MKF_MOUSEMODE = &h80000000

type tagACCESSTIMEOUT
	cbSize as UINT
	dwFlags as DWORD
	iTimeOutMSec as DWORD
end type

type ACCESSTIMEOUT as tagACCESSTIMEOUT
type LPACCESSTIMEOUT as tagACCESSTIMEOUT ptr
const ATF_TIMEOUTON = &h00000001
const ATF_ONOFFFEEDBACK = &h00000002
const SSGF_NONE = 0
const SSGF_DISPLAY = 3
const SSTF_NONE = 0
const SSTF_CHARS = 1
const SSTF_BORDER = 2
const SSTF_DISPLAY = 3
const SSWF_NONE = 0
const SSWF_TITLE = 1
const SSWF_WINDOW = 2
const SSWF_DISPLAY = 3
const SSWF_CUSTOM = 4

type tagSOUNDSENTRYA
	cbSize as UINT
	dwFlags as DWORD
	iFSTextEffect as DWORD
	iFSTextEffectMSec as DWORD
	iFSTextEffectColorBits as DWORD
	iFSGrafEffect as DWORD
	iFSGrafEffectMSec as DWORD
	iFSGrafEffectColor as DWORD
	iWindowsEffect as DWORD
	iWindowsEffectMSec as DWORD
	lpszWindowsEffectDLL as LPSTR
	iWindowsEffectOrdinal as DWORD
end type

type SOUNDSENTRYA as tagSOUNDSENTRYA
type LPSOUNDSENTRYA as tagSOUNDSENTRYA ptr

type tagSOUNDSENTRYW
	cbSize as UINT
	dwFlags as DWORD
	iFSTextEffect as DWORD
	iFSTextEffectMSec as DWORD
	iFSTextEffectColorBits as DWORD
	iFSGrafEffect as DWORD
	iFSGrafEffectMSec as DWORD
	iFSGrafEffectColor as DWORD
	iWindowsEffect as DWORD
	iWindowsEffectMSec as DWORD
	lpszWindowsEffectDLL as LPWSTR
	iWindowsEffectOrdinal as DWORD
end type

type SOUNDSENTRYW as tagSOUNDSENTRYW
type LPSOUNDSENTRYW as tagSOUNDSENTRYW ptr

#ifdef UNICODE
	type SOUNDSENTRY as SOUNDSENTRYW
	type LPSOUNDSENTRY as LPSOUNDSENTRYW
#else
	type SOUNDSENTRY as SOUNDSENTRYA
	type LPSOUNDSENTRY as LPSOUNDSENTRYA
#endif

const SSF_SOUNDSENTRYON = &h00000001
const SSF_AVAILABLE = &h00000002
const SSF_INDICATOR = &h00000004

type tagTOGGLEKEYS
	cbSize as UINT
	dwFlags as DWORD
end type

type TOGGLEKEYS as tagTOGGLEKEYS
type LPTOGGLEKEYS as tagTOGGLEKEYS ptr

type tagMONITORINFO
	cbSize as DWORD
	rcMonitor as RECT
	rcWork as RECT
	dwFlags as DWORD
end type

type MONITORINFO as tagMONITORINFO
type LPMONITORINFO as tagMONITORINFO ptr

#if _WIN32_WINNT >= &h0600
	type tagAUDIODESCRIPTION
		cbSize as UINT
		Enabled as WINBOOL
		Locale as LCID
	end type

	type AUDIODESCRIPTION as tagAUDIODESCRIPTION
	type LPAUDIODESCRIPTION as tagAUDIODESCRIPTION ptr
#endif

type tagMONITORINFOEXA
	union
		type
			cbSize as DWORD
			rcMonitor as RECT
			rcWork as RECT
			dwFlags as DWORD
		end type
	end union

	szDevice as zstring * 32
end type

type MONITORINFOEXA as tagMONITORINFOEXA
type LPMONITORINFOEXA as tagMONITORINFOEXA ptr

type tagMONITORINFOEXW
	union
		type
			cbSize as DWORD
			rcMonitor as RECT
			rcWork as RECT
			dwFlags as DWORD
		end type
	end union

	szDevice as wstring * 32
end type

type MONITORINFOEXW as tagMONITORINFOEXW
type LPMONITORINFOEXW as tagMONITORINFOEXW ptr

#ifdef UNICODE
	type MONITORINFOEX as MONITORINFOEXW
	type LPMONITORINFOEX as LPMONITORINFOEXW
#else
	type MONITORINFOEX as MONITORINFOEXA
	type LPMONITORINFOEX as LPMONITORINFOEXA
#endif

type MONITORENUMPROC as function(byval as HMONITOR, byval as HDC, byval as LPRECT, byval as LPARAM) as WINBOOL
declare sub SetDebugErrorLevel(byval dwLevel as DWORD)
declare sub SetLastErrorEx(byval dwErrCode as DWORD, byval dwType as DWORD)
declare function InternalGetWindowText(byval hWnd as HWND, byval pString as LPWSTR, byval cchMaxCount as long) as long
declare function CancelShutdown() as WINBOOL
declare function MonitorFromPoint(byval pt as POINT, byval dwFlags as DWORD) as HMONITOR
declare function MonitorFromRect(byval lprc as LPCRECT, byval dwFlags as DWORD) as HMONITOR
declare function MonitorFromWindow(byval hwnd as HWND, byval dwFlags as DWORD) as HMONITOR
declare function EndTask(byval hWnd as HWND, byval fShutDown as WINBOOL, byval fForce as WINBOOL) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function SoundSentry() as WINBOOL
#endif

declare function GetMonitorInfoA(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL

#ifndef UNICODE
	declare function GetMonitorInfo alias "GetMonitorInfoA"(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL
#endif

declare function GetMonitorInfoW(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL

#ifdef UNICODE
	declare function GetMonitorInfo alias "GetMonitorInfoW"(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL
#endif

declare function EnumDisplayMonitors(byval hdc as HDC, byval lprcClip as LPCRECT, byval lpfnEnum as MONITORENUMPROC, byval dwData as LPARAM) as WINBOOL
const TKF_TOGGLEKEYSON = &h00000001
const TKF_AVAILABLE = &h00000002
const TKF_HOTKEYACTIVE = &h00000004
const TKF_CONFIRMHOTKEY = &h00000008
const TKF_HOTKEYSOUND = &h00000010
const TKF_INDICATOR = &h00000020
const SLE_ERROR = &h00000001
const SLE_MINORERROR = &h00000002
const SLE_WARNING = &h00000003
const MONITOR_DEFAULTTONULL = &h00000000
const MONITOR_DEFAULTTOPRIMARY = &h00000001
const MONITOR_DEFAULTTONEAREST = &h00000002
const MONITORINFOF_PRIMARY = &h00000001
type WINEVENTPROC as sub(byval hWinEventHook as HWINEVENTHOOK, byval event as DWORD, byval hwnd as HWND, byval idObject as LONG, byval idChild as LONG, byval idEventThread as DWORD, byval dwmsEventTime as DWORD)

declare sub NotifyWinEvent(byval event as DWORD, byval hwnd as HWND, byval idObject as LONG, byval idChild as LONG)
declare function SetWinEventHook(byval eventMin as DWORD, byval eventMax as DWORD, byval hmodWinEventProc as HMODULE, byval pfnWinEventProc as WINEVENTPROC, byval idProcess as DWORD, byval idThread as DWORD, byval dwFlags as DWORD) as HWINEVENTHOOK
declare function IsWinEventHookInstalled(byval event as DWORD) as WINBOOL

const WINEVENT_OUTOFCONTEXT = &h0000
const WINEVENT_SKIPOWNTHREAD = &h0001
const WINEVENT_SKIPOWNPROCESS = &h0002
const WINEVENT_INCONTEXT = &h0004
declare function UnhookWinEvent(byval hWinEventHook as HWINEVENTHOOK) as WINBOOL
const CHILDID_SELF = 0
const INDEXID_OBJECT = 0
const INDEXID_CONTAINER = 0
#define OBJID_WINDOW cast(LONG, &h00000000)
#define OBJID_SYSMENU cast(LONG, &hFFFFFFFF)
#define OBJID_TITLEBAR cast(LONG, &hFFFFFFFE)
#define OBJID_MENU cast(LONG, &hFFFFFFFD)
#define OBJID_CLIENT cast(LONG, &hFFFFFFFC)
#define OBJID_VSCROLL cast(LONG, &hFFFFFFFB)
#define OBJID_HSCROLL cast(LONG, &hFFFFFFFA)
#define OBJID_SIZEGRIP cast(LONG, &hFFFFFFF9)
#define OBJID_CARET cast(LONG, &hFFFFFFF8)
#define OBJID_CURSOR cast(LONG, &hFFFFFFF7)
#define OBJID_ALERT cast(LONG, &hFFFFFFF6)
#define OBJID_SOUND cast(LONG, &hFFFFFFF5)
#define OBJID_QUERYCLASSNAMEIDX cast(LONG, &hFFFFFFF4)
#define OBJID_NATIVEOM cast(LONG, &hFFFFFFF0)
const EVENT_MIN = &h00000001
const EVENT_MAX = &h7FFFFFFF
const EVENT_SYSTEM_SOUND = &h0001
const EVENT_SYSTEM_ALERT = &h0002
const EVENT_SYSTEM_FOREGROUND = &h0003
const EVENT_SYSTEM_MENUSTART = &h0004
const EVENT_SYSTEM_MENUEND = &h0005
const EVENT_SYSTEM_MENUPOPUPSTART = &h0006
const EVENT_SYSTEM_MENUPOPUPEND = &h0007
const EVENT_SYSTEM_CAPTURESTART = &h0008
const EVENT_SYSTEM_CAPTUREEND = &h0009
const EVENT_SYSTEM_MOVESIZESTART = &h000A
const EVENT_SYSTEM_MOVESIZEEND = &h000B
const EVENT_SYSTEM_CONTEXTHELPSTART = &h000C
const EVENT_SYSTEM_CONTEXTHELPEND = &h000D
const EVENT_SYSTEM_DRAGDROPSTART = &h000E
const EVENT_SYSTEM_DRAGDROPEND = &h000F
const EVENT_SYSTEM_DIALOGSTART = &h0010
const EVENT_SYSTEM_DIALOGEND = &h0011
const EVENT_SYSTEM_SCROLLINGSTART = &h0012
const EVENT_SYSTEM_SCROLLINGEND = &h0013
const EVENT_SYSTEM_SWITCHSTART = &h0014
const EVENT_SYSTEM_SWITCHEND = &h0015
const EVENT_SYSTEM_MINIMIZESTART = &h0016
const EVENT_SYSTEM_MINIMIZEEND = &h0017

#if _WIN32_WINNT >= &h0600
	const EVENT_SYSTEM_DESKTOPSWITCH = &h0020
#endif

#if _WIN32_WINNT = &h0602
	const EVENT_SYSTEM_SWITCHER_APPGRABBED = &h0024
	const EVENT_SYSTEM_SWITCHER_APPOVERTARGET = &h0025
	const EVENT_SYSTEM_SWITCHER_APPDROPPED = &h0026
	const EVENT_SYSTEM_SWITCHER_CANCELLED = &h0027
	const EVENT_SYSTEM_IME_KEY_NOTIFICATION = &h0029
#endif

#if _WIN32_WINNT >= &h0601
	const EVENT_SYSTEM_END = &h00ff
	const EVENT_OEM_DEFINED_START = &h0101
	const EVENT_OEM_DEFINED_END = &h01ff
	const EVENT_UIA_EVENTID_START = &h4e00
	const EVENT_UIA_EVENTID_END = &h4eff
	const EVENT_UIA_PROPID_START = &h7500
	const EVENT_UIA_PROPID_END = &h75ff
#endif

const EVENT_CONSOLE_CARET = &h4001
const EVENT_CONSOLE_UPDATE_REGION = &h4002
const EVENT_CONSOLE_UPDATE_SIMPLE = &h4003
const EVENT_CONSOLE_UPDATE_SCROLL = &h4004
const EVENT_CONSOLE_LAYOUT = &h4005
const EVENT_CONSOLE_START_APPLICATION = &h4006
const EVENT_CONSOLE_END_APPLICATION = &h4007

#ifdef __FB_64BIT__
	const CONSOLE_APPLICATION_16BIT = &h0000
#else
	const CONSOLE_APPLICATION_16BIT = &h0001
#endif

const CONSOLE_CARET_SELECTION = &h0001
const CONSOLE_CARET_VISIBLE = &h0002

#if _WIN32_WINNT >= &h0601
	const EVENT_CONSOLE_END = &h40ff
#endif

const EVENT_OBJECT_CREATE = &h8000
const EVENT_OBJECT_DESTROY = &h8001
const EVENT_OBJECT_SHOW = &h8002
const EVENT_OBJECT_HIDE = &h8003
const EVENT_OBJECT_REORDER = &h8004
const EVENT_OBJECT_FOCUS = &h8005
const EVENT_OBJECT_SELECTION = &h8006
const EVENT_OBJECT_SELECTIONADD = &h8007
const EVENT_OBJECT_SELECTIONREMOVE = &h8008
const EVENT_OBJECT_SELECTIONWITHIN = &h8009
const EVENT_OBJECT_STATECHANGE = &h800A
const EVENT_OBJECT_LOCATIONCHANGE = &h800B
const EVENT_OBJECT_NAMECHANGE = &h800C
const EVENT_OBJECT_DESCRIPTIONCHANGE = &h800D
const EVENT_OBJECT_VALUECHANGE = &h800E
const EVENT_OBJECT_PARENTCHANGE = &h800F
const EVENT_OBJECT_HELPCHANGE = &h8010
const EVENT_OBJECT_DEFACTIONCHANGE = &h8011
const EVENT_OBJECT_ACCELERATORCHANGE = &h8012

#if _WIN32_WINNT >= &h0600
	const EVENT_OBJECT_INVOKED = &h8013
	const EVENT_OBJECT_TEXTSELECTIONCHANGED = &h8014
	const EVENT_OBJECT_CONTENTSCROLLED = &h8015
#endif

#if _WIN32_WINNT >= &h0601
	const EVENT_SYSTEM_ARRANGMENTPREVIEW = &h8016
#endif

#if _WIN32_WINNT = &h0602
	const EVENT_OBJECT_CLOAKED = &h8017
	const EVENT_OBJECT_UNCLOAKED = &h8018
	const EVENT_OBJECT_LIVEREGIONCHANGED = &h8019
	const EVENT_OBJECT_HOSTEDOBJECTSINVALIDATED = &h8020
	const EVENT_OBJECT_DRAGSTART = &h8021
	const EVENT_OBJECT_DRAGCANCEL = &h8022
	const EVENT_OBJECT_DRAGCOMPLETE = &h8023
	const EVENT_OBJECT_DRAGENTER = &h8024
	const EVENT_OBJECT_DRAGLEAVE = &h8025
	const EVENT_OBJECT_DRAGDROPPED = &h8026
	const EVENT_OBJECT_IME_SHOW = &h8027
	const EVENT_OBJECT_IME_HIDE = &h8028
	const EVENT_OBJECT_IME_CHANGE = &h8029
#endif

#if _WIN32_WINNT >= &h0601
	const EVENT_OBJECT_END = &h80ff
	const EVENT_AIA_START = &ha000
	const EVENT_AIA_END = &hafff
#endif

const SOUND_SYSTEM_STARTUP = 1
const SOUND_SYSTEM_SHUTDOWN = 2
const SOUND_SYSTEM_BEEP = 3
const SOUND_SYSTEM_ERROR = 4
const SOUND_SYSTEM_QUESTION = 5
const SOUND_SYSTEM_WARNING = 6
const SOUND_SYSTEM_INFORMATION = 7
const SOUND_SYSTEM_MAXIMIZE = 8
const SOUND_SYSTEM_MINIMIZE = 9
const SOUND_SYSTEM_RESTOREUP = 10
const SOUND_SYSTEM_RESTOREDOWN = 11
const SOUND_SYSTEM_APPSTART = 12
const SOUND_SYSTEM_FAULT = 13
const SOUND_SYSTEM_APPEND = 14
const SOUND_SYSTEM_MENUCOMMAND = 15
const SOUND_SYSTEM_MENUPOPUP = 16
const CSOUND_SYSTEM = 16
const ALERT_SYSTEM_INFORMATIONAL = 1
const ALERT_SYSTEM_WARNING = 2
const ALERT_SYSTEM_ERROR = 3
const ALERT_SYSTEM_QUERY = 4
const ALERT_SYSTEM_CRITICAL = 5
const CALERT_SYSTEM = 6

type tagGUITHREADINFO
	cbSize as DWORD
	flags as DWORD
	hwndActive as HWND
	hwndFocus as HWND
	hwndCapture as HWND
	hwndMenuOwner as HWND
	hwndMoveSize as HWND
	hwndCaret as HWND
	rcCaret as RECT
end type

type GUITHREADINFO as tagGUITHREADINFO
type PGUITHREADINFO as tagGUITHREADINFO ptr
type LPGUITHREADINFO as tagGUITHREADINFO ptr

const GUI_CARETBLINKING = &h00000001
const GUI_INMOVESIZE = &h00000002
const GUI_INMENUMODE = &h00000004
const GUI_SYSTEMMENUMODE = &h00000008
const GUI_POPUPMENUMODE = &h00000010

#ifdef __FB_64BIT__
	const GUI_16BITTASK = &h00000000
#else
	const GUI_16BITTASK = &h00000020
#endif

declare function GetGUIThreadInfo(byval idThread as DWORD, byval pgui as PGUITHREADINFO) as WINBOOL
declare function BlockInput(byval fBlockIt as WINBOOL) as WINBOOL
declare function GetWindowModuleFileNameA(byval hwnd as HWND, byval pszFileName as LPSTR, byval cchFileNameMax as UINT) as UINT

#ifndef UNICODE
	declare function GetWindowModuleFileName alias "GetWindowModuleFileNameA"(byval hwnd as HWND, byval pszFileName as LPSTR, byval cchFileNameMax as UINT) as UINT
#endif

declare function GetWindowModuleFileNameW(byval hwnd as HWND, byval pszFileName as LPWSTR, byval cchFileNameMax as UINT) as UINT

#ifdef UNICODE
	declare function GetWindowModuleFileName alias "GetWindowModuleFileNameW"(byval hwnd as HWND, byval pszFileName as LPWSTR, byval cchFileNameMax as UINT) as UINT
#endif

#if _WIN32_WINNT >= &h0600
	const USER_DEFAULT_SCREEN_DPI = 96
	declare function SetProcessDPIAware() as WINBOOL
	declare function IsProcessDPIAware() as WINBOOL
#endif

const STATE_SYSTEM_UNAVAILABLE = &h00000001
const STATE_SYSTEM_SELECTED = &h00000002
const STATE_SYSTEM_FOCUSED = &h00000004
const STATE_SYSTEM_PRESSED = &h00000008
const STATE_SYSTEM_CHECKED = &h00000010
const STATE_SYSTEM_MIXED = &h00000020
const STATE_SYSTEM_INDETERMINATE = STATE_SYSTEM_MIXED
const STATE_SYSTEM_READONLY = &h00000040
const STATE_SYSTEM_HOTTRACKED = &h00000080
const STATE_SYSTEM_DEFAULT = &h00000100
const STATE_SYSTEM_EXPANDED = &h00000200
const STATE_SYSTEM_COLLAPSED = &h00000400
const STATE_SYSTEM_BUSY = &h00000800
const STATE_SYSTEM_FLOATING = &h00001000
const STATE_SYSTEM_MARQUEED = &h00002000
const STATE_SYSTEM_ANIMATED = &h00004000
const STATE_SYSTEM_INVISIBLE = &h00008000
const STATE_SYSTEM_OFFSCREEN = &h00010000
const STATE_SYSTEM_SIZEABLE = &h00020000
const STATE_SYSTEM_MOVEABLE = &h00040000
const STATE_SYSTEM_SELFVOICING = &h00080000
const STATE_SYSTEM_FOCUSABLE = &h00100000
const STATE_SYSTEM_SELECTABLE = &h00200000
const STATE_SYSTEM_LINKED = &h00400000
const STATE_SYSTEM_TRAVERSED = &h00800000
const STATE_SYSTEM_MULTISELECTABLE = &h01000000
const STATE_SYSTEM_EXTSELECTABLE = &h02000000
const STATE_SYSTEM_ALERT_LOW = &h04000000
const STATE_SYSTEM_ALERT_MEDIUM = &h08000000
const STATE_SYSTEM_ALERT_HIGH = &h10000000
const STATE_SYSTEM_PROTECTED = &h20000000
const STATE_SYSTEM_VALID = &h3FFFFFFF
const CCHILDREN_TITLEBAR = 5
const CCHILDREN_SCROLLBAR = 5

type tagCURSORINFO
	cbSize as DWORD
	flags as DWORD
	hCursor as HCURSOR
	ptScreenPos as POINT
end type

type CURSORINFO as tagCURSORINFO
type PCURSORINFO as tagCURSORINFO ptr
type LPCURSORINFO as tagCURSORINFO ptr
const CURSOR_SHOWING = &h00000001

#if _WIN32_WINNT = &h0602
	const CURSOR_SUPPRESSED = &h00000002
#endif

declare function GetCursorInfo(byval pci as PCURSORINFO) as WINBOOL

type tagWINDOWINFO
	cbSize as DWORD
	rcWindow as RECT
	rcClient as RECT
	dwStyle as DWORD
	dwExStyle as DWORD
	dwWindowStatus as DWORD
	cxWindowBorders as UINT
	cyWindowBorders as UINT
	atomWindowType as ATOM
	wCreatorVersion as WORD
end type

type WINDOWINFO as tagWINDOWINFO
type PWINDOWINFO as tagWINDOWINFO ptr
type LPWINDOWINFO as tagWINDOWINFO ptr
const WS_ACTIVECAPTION = &h0001
declare function GetWindowInfo(byval hwnd as HWND, byval pwi as PWINDOWINFO) as WINBOOL

type tagTITLEBARINFO
	cbSize as DWORD
	rcTitleBar as RECT
	rgstate(0 to (5 + 1) - 1) as DWORD
end type

type TITLEBARINFO as tagTITLEBARINFO
type PTITLEBARINFO as tagTITLEBARINFO ptr
type LPTITLEBARINFO as tagTITLEBARINFO ptr
declare function GetTitleBarInfo(byval hwnd as HWND, byval pti as PTITLEBARINFO) as WINBOOL

#if _WIN32_WINNT >= &h0600
	type tagTITLEBARINFOEX
		cbSize as DWORD
		rcTitleBar as RECT
		rgstate(0 to (5 + 1) - 1) as DWORD
		rgrect(0 to (5 + 1) - 1) as RECT
	end type

	type TITLEBARINFOEX as tagTITLEBARINFOEX
	type PTITLEBARINFOEX as tagTITLEBARINFOEX ptr
	type LPTITLEBARINFOEX as tagTITLEBARINFOEX ptr
#endif

type tagMENUBARINFO
	cbSize as DWORD
	rcBar as RECT
	hMenu as HMENU
	hwndMenu as HWND
	fBarFocused : 1 as WINBOOL
	fFocused : 1 as WINBOOL
end type

type MENUBARINFO as tagMENUBARINFO
type PMENUBARINFO as tagMENUBARINFO ptr
type LPMENUBARINFO as tagMENUBARINFO ptr
declare function GetMenuBarInfo(byval hwnd as HWND, byval idObject as LONG, byval idItem as LONG, byval pmbi as PMENUBARINFO) as WINBOOL

type tagSCROLLBARINFO
	cbSize as DWORD
	rcScrollBar as RECT
	dxyLineButton as long
	xyThumbTop as long
	xyThumbBottom as long
	reserved as long
	rgstate(0 to (5 + 1) - 1) as DWORD
end type

type SCROLLBARINFO as tagSCROLLBARINFO
type PSCROLLBARINFO as tagSCROLLBARINFO ptr
type LPSCROLLBARINFO as tagSCROLLBARINFO ptr
declare function GetScrollBarInfo(byval hwnd as HWND, byval idObject as LONG, byval psbi as PSCROLLBARINFO) as WINBOOL

type tagCOMBOBOXINFO
	cbSize as DWORD
	rcItem as RECT
	rcButton as RECT
	stateButton as DWORD
	hwndCombo as HWND
	hwndItem as HWND
	hwndList as HWND
end type

type COMBOBOXINFO as tagCOMBOBOXINFO
type PCOMBOBOXINFO as tagCOMBOBOXINFO ptr
type LPCOMBOBOXINFO as tagCOMBOBOXINFO ptr
declare function GetComboBoxInfo(byval hwndCombo as HWND, byval pcbi as PCOMBOBOXINFO) as WINBOOL

const GA_PARENT = 1
const GA_ROOT = 2
const GA_ROOTOWNER = 3

declare function GetAncestor(byval hwnd as HWND, byval gaFlags as UINT) as HWND
declare function RealChildWindowFromPoint(byval hwndParent as HWND, byval ptParentClientCoords as POINT) as HWND
declare function RealGetWindowClassA(byval hwnd as HWND, byval ptszClassName as LPSTR, byval cchClassNameMax as UINT) as UINT

#ifndef UNICODE
	declare function RealGetWindowClass alias "RealGetWindowClassA"(byval hwnd as HWND, byval ptszClassName as LPSTR, byval cchClassNameMax as UINT) as UINT
#endif

declare function RealGetWindowClassW(byval hwnd as HWND, byval ptszClassName as LPWSTR, byval cchClassNameMax as UINT) as UINT

#ifdef UNICODE
	declare function RealGetWindowClass alias "RealGetWindowClassW"(byval hwnd as HWND, byval ptszClassName as LPWSTR, byval cchClassNameMax as UINT) as UINT
#endif

type tagALTTABINFO
	cbSize as DWORD
	cItems as long
	cColumns as long
	cRows as long
	iColFocus as long
	iRowFocus as long
	cxItem as long
	cyItem as long
	ptStart as POINT
end type

type ALTTABINFO as tagALTTABINFO
type PALTTABINFO as tagALTTABINFO ptr
type LPALTTABINFO as tagALTTABINFO ptr
declare function GetAltTabInfoA(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPSTR, byval cchItemText as UINT) as WINBOOL

#ifndef UNICODE
	declare function GetAltTabInfo alias "GetAltTabInfoA"(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPSTR, byval cchItemText as UINT) as WINBOOL
#endif

declare function GetAltTabInfoW(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPWSTR, byval cchItemText as UINT) as WINBOOL

#ifdef UNICODE
	declare function GetAltTabInfo alias "GetAltTabInfoW"(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPWSTR, byval cchItemText as UINT) as WINBOOL
#endif

declare function GetListBoxInfo(byval hwnd as HWND) as DWORD
declare function LockWorkStation() as WINBOOL
declare function UserHandleGrantAccess(byval hUserHandle as HANDLE, byval hJob as HANDLE, byval bGrant as WINBOOL) as WINBOOL

type HRAWINPUT__
	unused as long
end type

type HRAWINPUT as HRAWINPUT__ ptr
#define GET_RAWINPUT_CODE_WPARAM(wParam) ((wParam) and &hff)
const RIM_INPUT = 0
const RIM_INPUTSINK = 1

type tagRAWINPUTHEADER
	dwType as DWORD
	dwSize as DWORD
	hDevice as HANDLE
	wParam as WPARAM
end type

type RAWINPUTHEADER as tagRAWINPUTHEADER
type PRAWINPUTHEADER as tagRAWINPUTHEADER ptr
type LPRAWINPUTHEADER as tagRAWINPUTHEADER ptr

const RIM_TYPEMOUSE = 0
const RIM_TYPEKEYBOARD = 1
const RIM_TYPEHID = 2

type tagRAWMOUSE
	usFlags as USHORT

	union
		ulButtons as ULONG

		type
			usButtonFlags as USHORT
			usButtonData as USHORT
		end type
	end union

	ulRawButtons as ULONG
	lLastX as LONG
	lLastY as LONG
	ulExtraInformation as ULONG
end type

type RAWMOUSE as tagRAWMOUSE
type PRAWMOUSE as tagRAWMOUSE ptr
type LPRAWMOUSE as tagRAWMOUSE ptr

const RI_MOUSE_LEFT_BUTTON_DOWN = &h0001
const RI_MOUSE_LEFT_BUTTON_UP = &h0002
const RI_MOUSE_RIGHT_BUTTON_DOWN = &h0004
const RI_MOUSE_RIGHT_BUTTON_UP = &h0008
const RI_MOUSE_MIDDLE_BUTTON_DOWN = &h0010
const RI_MOUSE_MIDDLE_BUTTON_UP = &h0020
const RI_MOUSE_BUTTON_4_DOWN = &h0040
const RI_MOUSE_BUTTON_4_UP = &h0080
const RI_MOUSE_BUTTON_5_DOWN = &h0100
const RI_MOUSE_BUTTON_5_UP = &h0200
const RI_MOUSE_WHEEL = &h0400
const RI_MOUSE_BUTTON_1_DOWN = RI_MOUSE_LEFT_BUTTON_DOWN
const RI_MOUSE_BUTTON_1_UP = RI_MOUSE_LEFT_BUTTON_UP
const RI_MOUSE_BUTTON_2_DOWN = RI_MOUSE_RIGHT_BUTTON_DOWN
const RI_MOUSE_BUTTON_2_UP = RI_MOUSE_RIGHT_BUTTON_UP
const RI_MOUSE_BUTTON_3_DOWN = RI_MOUSE_MIDDLE_BUTTON_DOWN
const RI_MOUSE_BUTTON_3_UP = RI_MOUSE_MIDDLE_BUTTON_UP
const MOUSE_MOVE_RELATIVE = 0
const MOUSE_MOVE_ABSOLUTE = 1
const MOUSE_VIRTUAL_DESKTOP = &h02
const MOUSE_ATTRIBUTES_CHANGED = &h04

#if _WIN32_WINNT >= &h0600
	const MOUSE_MOVE_NOCOALESCE = &h08
#endif

type tagRAWKEYBOARD
	MakeCode as USHORT
	Flags as USHORT
	Reserved as USHORT
	VKey as USHORT
	Message as UINT
	ExtraInformation as ULONG
end type

type RAWKEYBOARD as tagRAWKEYBOARD
type PRAWKEYBOARD as tagRAWKEYBOARD ptr
type LPRAWKEYBOARD as tagRAWKEYBOARD ptr

const KEYBOARD_OVERRUN_MAKE_CODE = &hFF
const RI_KEY_MAKE = 0
const RI_KEY_BREAK = 1
const RI_KEY_E0 = 2
const RI_KEY_E1 = 4
const RI_KEY_TERMSRV_SET_LED = 8
const RI_KEY_TERMSRV_SHADOW = &h10

type tagRAWHID
	dwSizeHid as DWORD
	dwCount as DWORD
	bRawData(0 to 0) as UBYTE
end type

type RAWHID as tagRAWHID
type PRAWHID as tagRAWHID ptr
type LPRAWHID as tagRAWHID ptr

union tagRAWINPUT_data
	mouse as RAWMOUSE
	keyboard as RAWKEYBOARD
	hid as RAWHID
end union

type tagRAWINPUT
	header as RAWINPUTHEADER
	data as tagRAWINPUT_data
end type

type RAWINPUT as tagRAWINPUT
type PRAWINPUT as tagRAWINPUT ptr
type LPRAWINPUT as tagRAWINPUT ptr

#ifdef __FB_64BIT__
	#define RAWINPUT_ALIGN(x) ((((x) + sizeof(QWORD)) - 1) and (not (sizeof(QWORD) - 1)))
#else
	#define RAWINPUT_ALIGN(x) ((((x) + sizeof(DWORD)) - 1) and (not (sizeof(DWORD) - 1)))
#endif

#define NEXTRAWINPUTBLOCK(ptr) cast(PRAWINPUT, RAWINPUT_ALIGN(cast(ULONG_PTR, cast(PBYTE, (ptr)) + (ptr)->header.dwSize)))
const RID_INPUT = &h10000003
const RID_HEADER = &h10000005
declare function GetRawInputData(byval hRawInput as HRAWINPUT, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT, byval cbSizeHeader as UINT) as UINT
const RIDI_PREPARSEDDATA = &h20000005
const RIDI_DEVICENAME = &h20000007
const RIDI_DEVICEINFO = &h2000000b

type tagRID_DEVICE_INFO_MOUSE
	dwId as DWORD
	dwNumberOfButtons as DWORD
	dwSampleRate as DWORD
	fHasHorizontalWheel as WINBOOL
end type

type RID_DEVICE_INFO_MOUSE as tagRID_DEVICE_INFO_MOUSE
type PRID_DEVICE_INFO_MOUSE as tagRID_DEVICE_INFO_MOUSE ptr

type tagRID_DEVICE_INFO_KEYBOARD
	dwType as DWORD
	dwSubType as DWORD
	dwKeyboardMode as DWORD
	dwNumberOfFunctionKeys as DWORD
	dwNumberOfIndicators as DWORD
	dwNumberOfKeysTotal as DWORD
end type

type RID_DEVICE_INFO_KEYBOARD as tagRID_DEVICE_INFO_KEYBOARD
type PRID_DEVICE_INFO_KEYBOARD as tagRID_DEVICE_INFO_KEYBOARD ptr

type tagRID_DEVICE_INFO_HID
	dwVendorId as DWORD
	dwProductId as DWORD
	dwVersionNumber as DWORD
	usUsagePage as USHORT
	usUsage as USHORT
end type

type RID_DEVICE_INFO_HID as tagRID_DEVICE_INFO_HID
type PRID_DEVICE_INFO_HID as tagRID_DEVICE_INFO_HID ptr

type tagRID_DEVICE_INFO
	cbSize as DWORD
	dwType as DWORD

	union
		mouse as RID_DEVICE_INFO_MOUSE
		keyboard as RID_DEVICE_INFO_KEYBOARD
		hid as RID_DEVICE_INFO_HID
	end union
end type

type RID_DEVICE_INFO as tagRID_DEVICE_INFO
type PRID_DEVICE_INFO as tagRID_DEVICE_INFO ptr
type LPRID_DEVICE_INFO as tagRID_DEVICE_INFO ptr
declare function GetRawInputDeviceInfoA(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT

#ifndef UNICODE
	declare function GetRawInputDeviceInfo alias "GetRawInputDeviceInfoA"(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT
#endif

declare function GetRawInputDeviceInfoW(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT

#ifdef UNICODE
	declare function GetRawInputDeviceInfo alias "GetRawInputDeviceInfoW"(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT
#endif

declare function GetRawInputBuffer(byval pData as PRAWINPUT, byval pcbSize as PUINT, byval cbSizeHeader as UINT) as UINT

type tagRAWINPUTDEVICE
	usUsagePage as USHORT
	usUsage as USHORT
	dwFlags as DWORD
	hwndTarget as HWND
end type

type RAWINPUTDEVICE as tagRAWINPUTDEVICE
type PRAWINPUTDEVICE as tagRAWINPUTDEVICE ptr
type LPRAWINPUTDEVICE as tagRAWINPUTDEVICE ptr
type PCRAWINPUTDEVICE as const RAWINPUTDEVICE ptr

const RIDEV_REMOVE = &h00000001
const RIDEV_EXCLUDE = &h00000010
const RIDEV_PAGEONLY = &h00000020
const RIDEV_NOLEGACY = &h00000030
const RIDEV_INPUTSINK = &h00000100
const RIDEV_CAPTUREMOUSE = &h00000200
const RIDEV_NOHOTKEYS = &h00000200
const RIDEV_APPKEYS = &h00000400
const RIDEV_EXINPUTSINK = &h00001000
const RIDEV_DEVNOTIFY = &h00002000
const RIDEV_EXMODEMASK = &h000000F0
#define RIDEV_EXMODE(mode) ((mode) and RIDEV_EXMODEMASK)
const GIDC_ARRIVAL = 1
const GIDC_REMOVAL = 2

#if _WIN32_WINNT <= &h0600
	#define GET_DEVICE_CHANGE_LPARAM(lParam) LOWORD(lParam)
#else
	#define GET_DEVICE_CHANGE_WPARAM(wParam) LOWORD(wParam)
#endif

type tagRAWINPUTDEVICELIST
	hDevice as HANDLE
	dwType as DWORD
end type

type RAWINPUTDEVICELIST as tagRAWINPUTDEVICELIST
type PRAWINPUTDEVICELIST as tagRAWINPUTDEVICELIST ptr
declare function RegisterRawInputDevices(byval pRawInputDevices as PCRAWINPUTDEVICE, byval uiNumDevices as UINT, byval cbSize as UINT) as WINBOOL
declare function GetRegisteredRawInputDevices(byval pRawInputDevices as PRAWINPUTDEVICE, byval puiNumDevices as PUINT, byval cbSize as UINT) as UINT
declare function GetRawInputDeviceList(byval pRawInputDeviceList as PRAWINPUTDEVICELIST, byval puiNumDevices as PUINT, byval cbSize as UINT) as UINT
declare function DefRawInputProc(byval paRawInput as PRAWINPUT ptr, byval nInput as INT_, byval cbSizeHeader as UINT) as LRESULT

#if _WIN32_WINNT = &h0602
	const POINTER_DEVICE_PRODUCT_STRING_MAX = 520
	const PDC_ARRIVAL = &h001
	const PDC_REMOVAL = &h002
	const PDC_ORIENTATION_0 = &h004
	const PDC_ORIENTATION_90 = &h008
	const PDC_ORIENTATION_180 = &h010
	const PDC_ORIENTATION_270 = &h020
	const PDC_MODE_DEFAULT = &h040
	const PDC_MODE_CENTERED = &h080
	const PDC_MAPPING_CHANGE = &h100
	const PDC_RESOLUTION = &h200
	const PDC_ORIGIN = &h400
	const PDC_MODE_ASPECTRATIOPRESERVED = &h800

	type tagPOINTER_DEVICE_TYPE as long
	enum
		POINTER_DEVICE_TYPE_INTEGRATED_PEN = &h00000001
		POINTER_DEVICE_TYPE_EXTERNAL_PEN = &h00000002
		POINTER_DEVICE_TYPE_TOUCH = &h00000003
		POINTER_DEVICE_TYPE_MAX = &hffffffff
	end enum

	type POINTER_DEVICE_TYPE as tagPOINTER_DEVICE_TYPE

	type tagPOINTER_DEVICE_INFO
		displayOrientation as DWORD
		device as HANDLE
		pointerDeviceType as POINTER_DEVICE_TYPE
		monitor as HMONITOR
		startingCursorId as ULONG
		maxActiveContacts as USHORT
		productString as wstring * 520
	end type

	type POINTER_DEVICE_INFO as tagPOINTER_DEVICE_INFO

	type tagPOINTER_DEVICE_PROPERTY
		logicalMin as INT32
		logicalMax as INT32
		physicalMin as INT32
		physicalMax as INT32
		unit as UINT32
		unitExponent as UINT32
		usagePageId as USHORT
		usageId as USHORT
	end type

	type POINTER_DEVICE_PROPERTY as tagPOINTER_DEVICE_PROPERTY

	type tagPOINTER_DEVICE_CURSOR_TYPE as long
	enum
		POINTER_DEVICE_CURSOR_TYPE_UNKNOWN = &h00000000
		POINTER_DEVICE_CURSOR_TYPE_TIP = &h00000001
		POINTER_DEVICE_CURSOR_TYPE_ERASER = &h00000002
		POINTER_DEVICE_CURSOR_TYPE_MAX = &hffffffff
	end enum

	type POINTER_DEVICE_CURSOR_TYPE as tagPOINTER_DEVICE_CURSOR_TYPE

	type tagPOINTER_DEVICE_CURSOR_INFO
		cursorId as UINT32
		cursor as POINTER_DEVICE_CURSOR_TYPE
	end type

	type POINTER_DEVICE_CURSOR_INFO as tagPOINTER_DEVICE_CURSOR_INFO
	declare function GetPointerDevices(byval deviceCount as UINT32 ptr, byval pointerDevices as POINTER_DEVICE_INFO ptr) as WINBOOL
	declare function GetPointerDevice(byval device as HANDLE, byval pointerDevice as POINTER_DEVICE_INFO ptr) as WINBOOL
	declare function GetPointerDeviceProperties(byval device as HANDLE, byval propertyCount as UINT32 ptr, byval pointerProperties as POINTER_DEVICE_PROPERTY ptr) as WINBOOL
	declare function RegisterPointerDeviceNotifications(byval window as HWND, byval notifyRange as WINBOOL) as WINBOOL
	declare function GetPointerDeviceRects(byval device as HANDLE, byval pointerDeviceRect as RECT ptr, byval displayRect as RECT ptr) as WINBOOL
	declare function GetPointerDeviceCursors(byval device as HANDLE, byval cursorCount as UINT32 ptr, byval deviceCursors as POINTER_DEVICE_CURSOR_INFO ptr) as WINBOOL
	declare function GetRawPointerDeviceData(byval pointerId as UINT32, byval historyCount as UINT32, byval propertiesCount as UINT32, byval pProperties as POINTER_DEVICE_PROPERTY ptr, byval pValues as LONG ptr) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	const MSGFLT_ADD = 1
	const MSGFLT_REMOVE = 2
	declare function ChangeWindowMessageFilter(byval message as UINT, byval dwFlag as DWORD) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0601
	const MSGFLTINFO_NONE = 0
	const MSGFLTINFO_ALREADYALLOWED_FORWND = 1
	const MSGFLTINFO_ALREADYDISALLOWED_FORWND = 2
	const MSGFLTINFO_ALLOWED_HIGHER = 3
	const MSGFLT_RESET = 0
	const MSGFLT_ALLOW = 1
	const MSGFLT_DISALLOW = 2

	type tagCHANGEFILTERSTRUCT
		cbSize as DWORD
		ExtStatus as DWORD
	end type

	type CHANGEFILTERSTRUCT as tagCHANGEFILTERSTRUCT
	type PCHANGEFILTERSTRUCT as tagCHANGEFILTERSTRUCT ptr
	declare function ChangeWindowMessageFilterEx(byval hwnd as HWND, byval message as UINT, byval action as DWORD, byval pChangeFilterStruct as PCHANGEFILTERSTRUCT) as WINBOOL
	const GF_BEGIN = &h00000001
	const GF_INERTIA = &h00000002
	const GF_END = &h00000004
	const GID_BEGIN = 1
	const GID_END = 2
	const GID_ZOOM = 3
	const GID_PAN = 4
	const GID_ROTATE = 5
	const GID_TWOFINGERTAP = 6
	const GID_PRESSANDTAP = 7
	const GID_ROLLOVER = GID_PRESSANDTAP

	type HGESTUREINFO__
		unused as long
	end type

	type HGESTUREINFO as HGESTUREINFO__ ptr

	type tagGESTUREINFO
		cbSize as UINT
		dwFlags as DWORD
		dwID as DWORD
		hwndTarget as HWND
		ptsLocation as POINTS
		dwInstanceID as DWORD
		dwSequenceID as DWORD
		ullArguments as ULONGLONG
		cbExtraArgs as UINT
	end type

	type GESTUREINFO as tagGESTUREINFO
	type PGESTUREINFO as tagGESTUREINFO ptr
	type PCGESTUREINFO as const GESTUREINFO ptr

	type tagGESTURENOTIFYSTRUCT
		cbSize as UINT
		dwFlags as DWORD
		hwndTarget as HWND
		ptsLocation as POINTS
		dwInstanceID as DWORD
	end type

	type GESTURENOTIFYSTRUCT as tagGESTURENOTIFYSTRUCT
	type PGESTURENOTIFYSTRUCT as tagGESTURENOTIFYSTRUCT ptr
	#define GID_ROTATE_ANGLE_TO_ARGUMENT(_arg_) cast(USHORT, (((_arg_) + (2.0 * 3.14159265)) / (4.0 * 3.14159265)) * 65535.0)
	#define GID_ROTATE_ANGLE_FROM_ARGUMENT(_arg_) ((((cdbl(_arg_) / 65535.0) * 4.0) * 3.14159265) - (2.0 * 3.14159265))
	declare function GetGestureInfo(byval hGestureInfo as HGESTUREINFO, byval pGestureInfo as PGESTUREINFO) as WINBOOL
	declare function GetGestureExtraArgs(byval hGestureInfo as HGESTUREINFO, byval cbExtraArgs as UINT, byval pExtraArgs as PBYTE) as WINBOOL
	declare function CloseGestureInfoHandle(byval hGestureInfo as HGESTUREINFO) as WINBOOL

	type tagGESTURECONFIG
		dwID as DWORD
		dwWant as DWORD
		dwBlock as DWORD
	end type

	type GESTURECONFIG as tagGESTURECONFIG
	type PGESTURECONFIG as tagGESTURECONFIG ptr
	const GC_ALLGESTURES = &h00000001
	const GC_ZOOM = &h00000001
	const GC_PAN = &h00000001
	const GC_PAN_WITH_SINGLE_FINGER_VERTICALLY = &h00000002
	const GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = &h00000004
	const GC_PAN_WITH_GUTTER = &h00000008
	const GC_PAN_WITH_INERTIA = &h00000010
	const GC_ROTATE = &h00000001
	const GC_TWOFINGERTAP = &h00000001
	const GC_PRESSANDTAP = &h00000001
	const GC_ROLLOVER = GC_PRESSANDTAP
	const GESTURECONFIGMAXCOUNT = 256
	const GCF_INCLUDE_ANCESTORS = &h00000001
	declare function SetGestureConfig(byval hwnd as HWND, byval dwReserved as DWORD, byval cIDs as UINT, byval pGestureConfig as PGESTURECONFIG, byval cbSize as UINT) as WINBOOL
	declare function GetGestureConfig(byval hwnd as HWND, byval dwReserved as DWORD, byval dwFlags as DWORD, byval pcIDs as PUINT, byval pGestureConfig as PGESTURECONFIG, byval cbSize as UINT) as WINBOOL
	const NID_INTEGRATED_TOUCH = &h00000001
	const NID_EXTERNAL_TOUCH = &h00000002
	const NID_INTEGRATED_PEN = &h00000004
	const NID_EXTERNAL_PEN = &h00000008
	const NID_MULTI_INPUT = &h00000040
	const NID_READY = &h00000080
#endif

const MAX_STR_BLOCKREASON = 256
declare function ShutdownBlockReasonCreate(byval hWnd as HWND, byval pwszReason as LPCWSTR) as WINBOOL
declare function ShutdownBlockReasonQuery(byval hWnd as HWND, byval pwszBuff as LPWSTR, byval pcchBuff as DWORD ptr) as WINBOOL
declare function ShutdownBlockReasonDestroy(byval hWnd as HWND) as WINBOOL

#if _WIN32_WINNT >= &h0601
	type tagINPUT_MESSAGE_DEVICE_TYPE as long
	enum
		IMDT_UNAVAILABLE = &h00000000
		IMDT_KEYBOARD = &h00000001
		IMDT_MOUSE = &h00000002
		IMDT_TOUCH = &h00000004
		IMDT_PEN = &h00000008
	end enum

	type INPUT_MESSAGE_DEVICE_TYPE as tagINPUT_MESSAGE_DEVICE_TYPE

	type tagINPUT_MESSAGE_ORIGIN_ID as long
	enum
		IMO_UNAVAILABLE = &h00000000
		IMO_HARDWARE = &h00000001
		IMO_INJECTED = &h00000002
		IMO_SYSTEM = &h00000004
	end enum

	type INPUT_MESSAGE_ORIGIN_ID as tagINPUT_MESSAGE_ORIGIN_ID

	type tagINPUT_MESSAGE_SOURCE
		deviceType as INPUT_MESSAGE_DEVICE_TYPE
		originId as INPUT_MESSAGE_ORIGIN_ID
	end type

	type INPUT_MESSAGE_SOURCE as tagINPUT_MESSAGE_SOURCE
	declare function GetCurrentInputMessageSource(byval inputMessageSource as INPUT_MESSAGE_SOURCE ptr) as WINBOOL
	declare function GetCIMSSM(byval inputMessageSource as INPUT_MESSAGE_SOURCE ptr) as WINBOOL

	type tagAR_STATE as long
	enum
		AR_ENABLED = &h0
		AR_DISABLED = &h1
		AR_SUPPRESSED = &h2
		AR_REMOTESESSION = &h4
		AR_MULTIMON = &h8
		AR_NOSENSOR = &h10
		AR_NOT_SUPPORTED = &h20
		AR_DOCKED = &h40
		AR_LAPTOP = &h80
	end enum

	type AR_STATE as tagAR_STATE
	type PAR_STATE as tagAR_STATE ptr

	type ORIENTATION_PREFERENCE as long
	enum
		ORIENTATION_PREFERENCE_NONE = &h0
		ORIENTATION_PREFERENCE_LANDSCAPE = &h1
		ORIENTATION_PREFERENCE_PORTRAIT = &h2
		ORIENTATION_PREFERENCE_LANDSCAPE_FLIPPED = &h4
		ORIENTATION_PREFERENCE_PORTRAIT_FLIPPED = &h8
	end enum

	declare function GetAutoRotationState(byval pState as PAR_STATE) as WINBOOL
	declare function GetDisplayAutoRotationPreferences(byval pOrientation as ORIENTATION_PREFERENCE ptr) as WINBOOL
	declare function GetDisplayAutoRotationPreferencesByProcessId(byval dwProcessId as DWORD, byval pOrientation as ORIENTATION_PREFERENCE ptr, byval fRotateScreen as WINBOOL ptr) as WINBOOL
	declare function SetDisplayAutoRotationPreferences(byval orientation as ORIENTATION_PREFERENCE) as WINBOOL
	declare function IsImmersiveProcess(byval hProcess as HANDLE) as WINBOOL
	declare function SetProcessRestrictionExemption(byval fEnableExemption as WINBOOL) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	type tagINPUT_TRANSFORM
		union
			type
				_11 as single
				_12 as single
				_13 as single
				_14 as single
				_21 as single
				_22 as single
				_23 as single
				_24 as single
				_31 as single
				_32 as single
				_33 as single
				_34 as single
				_41 as single
				_42 as single
				_43 as single
				_44 as single
			end type

			m(0 to 3, 0 to 3) as single
		end union
	end type

	type INPUT_TRANSFORM as tagINPUT_TRANSFORM
	declare function GetPointerInputTransform(byval pointerId as UINT32, byval historyCount as UINT32, byval inputTransform as UINT32 ptr) as WINBOOL
	declare function IsMousePointerEnabled() as WINBOOL
#endif

end extern
