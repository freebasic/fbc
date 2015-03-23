#pragma once

#inclib "user32"

#include once "_mingw_unicode.bi"
#include once "_mingw.bi"
#include once "crt/stdarg.bi"
#include once "guiddef.bi"

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
type DESKTOPENUMPROCA as NAMEENUMPROCA
type WINSTAENUMPROCW as NAMEENUMPROCW
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
#define DIFFERENCE 11
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

declare function wvsprintfA(byval as LPSTR, byval as LPCSTR, byval arglist as va_list) as long
declare function wvsprintfW(byval as LPWSTR, byval as LPCWSTR, byval arglist as va_list) as long
declare function wsprintfA cdecl(byval as LPSTR, byval as LPCSTR, ...) as long
declare function wsprintfW cdecl(byval as LPWSTR, byval as LPCWSTR, ...) as long

#define SETWALLPAPER_DEFAULT cast(LPWSTR, -1)
#define SB_HORZ 0
#define SB_VERT 1
#define SB_CTL 2
#define SB_BOTH 3
#define SB_LINEUP 0
#define SB_LINELEFT 0
#define SB_LINEDOWN 1
#define SB_LINERIGHT 1
#define SB_PAGEUP 2
#define SB_PAGELEFT 2
#define SB_PAGEDOWN 3
#define SB_PAGERIGHT 3
#define SB_THUMBPOSITION 4
#define SB_THUMBTRACK 5
#define SB_TOP 6
#define SB_LEFT 6
#define SB_BOTTOM 7
#define SB_RIGHT 7
#define SB_ENDSCROLL 8
#define SW_HIDE 0
#define SW_SHOWNORMAL 1
#define SW_NORMAL 1
#define SW_SHOWMINIMIZED 2
#define SW_SHOWMAXIMIZED 3
#define SW_MAXIMIZE 3
#define SW_SHOWNOACTIVATE 4
#define SW_SHOW 5
#define SW_MINIMIZE 6
#define SW_SHOWMINNOACTIVE 7
#define SW_SHOWNA 8
#define SW_RESTORE 9
#define SW_SHOWDEFAULT 10
#define SW_FORCEMINIMIZE 11
#define SW_MAX 11
#define HIDE_WINDOW 0
#define SHOW_OPENWINDOW 1
#define SHOW_ICONWINDOW 2
#define SHOW_FULLSCREEN 3
#define SHOW_OPENNOACTIVATE 4
#define SW_PARENTCLOSING 1
#define SW_OTHERZOOM 2
#define SW_PARENTOPENING 3
#define SW_OTHERUNZOOM 4
#define AW_HOR_POSITIVE &h00000001
#define AW_HOR_NEGATIVE &h00000002
#define AW_VER_POSITIVE &h00000004
#define AW_VER_NEGATIVE &h00000008
#define AW_CENTER &h00000010
#define AW_HIDE &h00010000
#define AW_ACTIVATE &h00020000
#define AW_SLIDE &h00040000
#define AW_BLEND &h00080000
#define KF_EXTENDED &h0100
#define KF_DLGMODE &h0800
#define KF_MENUMODE &h1000
#define KF_ALTDOWN &h2000
#define KF_REPEAT &h4000
#define KF_UP &h8000
#define VK_LBUTTON &h01
#define VK_RBUTTON &h02
#define VK_CANCEL &h03
#define VK_MBUTTON &h04
#define VK_XBUTTON1 &h05
#define VK_XBUTTON2 &h06
#define VK_BACK &h08
#define VK_TAB &h09
#define VK_CLEAR &h0C
#define VK_RETURN &h0D
#define VK_SHIFT &h10
#define VK_CONTROL &h11
#define VK_MENU &h12
#define VK_PAUSE &h13
#define VK_CAPITAL &h14
#define VK_KANA &h15
#define VK_HANGEUL &h15
#define VK_HANGUL &h15
#define VK_JUNJA &h17
#define VK_FINAL &h18
#define VK_HANJA &h19
#define VK_KANJI &h19
#define VK_ESCAPE &h1B
#define VK_CONVERT &h1C
#define VK_NONCONVERT &h1D
#define VK_ACCEPT &h1E
#define VK_MODECHANGE &h1F
#define VK_SPACE &h20
#define VK_PRIOR &h21
#define VK_NEXT &h22
#define VK_END &h23
#define VK_HOME &h24
#define VK_LEFT &h25
#define VK_UP &h26
#define VK_RIGHT &h27
#define VK_DOWN &h28
#define VK_SELECT &h29
#define VK_PRINT &h2A
#define VK_EXECUTE &h2B
#define VK_SNAPSHOT &h2C
#define VK_INSERT &h2D
#define VK_DELETE &h2E
#define VK_HELP &h2F
#define VK_0 &h30
#define VK_1 &h31
#define VK_2 &h32
#define VK_3 &h33
#define VK_4 &h34
#define VK_5 &h35
#define VK_6 &h36
#define VK_7 &h37
#define VK_8 &h38
#define VK_9 &h39
#define VK_A &h41
#define VK_B &h42
#define VK_C &h43
#define VK_D &h44
#define VK_E &h45
#define VK_F &h46
#define VK_G &h47
#define VK_H &h48
#define VK_I &h49
#define VK_J &h4A
#define VK_K &h4B
#define VK_L &h4C
#define VK_M &h4D
#define VK_N &h4E
#define VK_O &h4F
#define VK_P &h50
#define VK_Q &h51
#define VK_R &h52
#define VK_S &h53
#define VK_T &h54
#define VK_U &h55
#define VK_V &h56
#define VK_W &h57
#define VK_X &h58
#define VK_Y &h59
#define VK_Z &h5A
#define VK_LWIN &h5B
#define VK_RWIN &h5C
#define VK_APPS &h5D
#define VK_SLEEP &h5F
#define VK_NUMPAD0 &h60
#define VK_NUMPAD1 &h61
#define VK_NUMPAD2 &h62
#define VK_NUMPAD3 &h63
#define VK_NUMPAD4 &h64
#define VK_NUMPAD5 &h65
#define VK_NUMPAD6 &h66
#define VK_NUMPAD7 &h67
#define VK_NUMPAD8 &h68
#define VK_NUMPAD9 &h69
#define VK_MULTIPLY &h6A
#define VK_ADD &h6B
#define VK_SEPARATOR &h6C
#define VK_SUBTRACT &h6D
#define VK_DECIMAL &h6E
#define VK_DIVIDE &h6F
#define VK_F1 &h70
#define VK_F2 &h71
#define VK_F3 &h72
#define VK_F4 &h73
#define VK_F5 &h74
#define VK_F6 &h75
#define VK_F7 &h76
#define VK_F8 &h77
#define VK_F9 &h78
#define VK_F10 &h79
#define VK_F11 &h7A
#define VK_F12 &h7B
#define VK_F13 &h7C
#define VK_F14 &h7D
#define VK_F15 &h7E
#define VK_F16 &h7F
#define VK_F17 &h80
#define VK_F18 &h81
#define VK_F19 &h82
#define VK_F20 &h83
#define VK_F21 &h84
#define VK_F22 &h85
#define VK_F23 &h86
#define VK_F24 &h87
#define VK_NUMLOCK &h90
#define VK_SCROLL &h91
#define VK_OEM_NEC_EQUAL &h92
#define VK_OEM_FJ_JISHO &h92
#define VK_OEM_FJ_MASSHOU &h93
#define VK_OEM_FJ_TOUROKU &h94
#define VK_OEM_FJ_LOYA &h95
#define VK_OEM_FJ_ROYA &h96
#define VK_LSHIFT &hA0
#define VK_RSHIFT &hA1
#define VK_LCONTROL &hA2
#define VK_RCONTROL &hA3
#define VK_LMENU &hA4
#define VK_RMENU &hA5
#define VK_BROWSER_BACK &hA6
#define VK_BROWSER_FORWARD &hA7
#define VK_BROWSER_REFRESH &hA8
#define VK_BROWSER_STOP &hA9
#define VK_BROWSER_SEARCH &hAA
#define VK_BROWSER_FAVORITES &hAB
#define VK_BROWSER_HOME &hAC
#define VK_VOLUME_MUTE &hAD
#define VK_VOLUME_DOWN &hAE
#define VK_VOLUME_UP &hAF
#define VK_MEDIA_NEXT_TRACK &hB0
#define VK_MEDIA_PREV_TRACK &hB1
#define VK_MEDIA_STOP &hB2
#define VK_MEDIA_PLAY_PAUSE &hB3
#define VK_LAUNCH_MAIL &hB4
#define VK_LAUNCH_MEDIA_SELECT &hB5
#define VK_LAUNCH_APP1 &hB6
#define VK_LAUNCH_APP2 &hB7
#define VK_OEM_1 &hBA
#define VK_OEM_PLUS &hBB
#define VK_OEM_COMMA &hBC
#define VK_OEM_MINUS &hBD
#define VK_OEM_PERIOD &hBE
#define VK_OEM_2 &hBF
#define VK_OEM_3 &hC0
#define VK_OEM_4 &hDB
#define VK_OEM_5 &hDC
#define VK_OEM_6 &hDD
#define VK_OEM_7 &hDE
#define VK_OEM_8 &hDF
#define VK_OEM_AX &hE1
#define VK_OEM_102 &hE2
#define VK_ICO_HELP &hE3
#define VK_ICO_00 &hE4
#define VK_PROCESSKEY &hE5
#define VK_ICO_CLEAR &hE6
#define VK_PACKET &hE7
#define VK_OEM_RESET &hE9
#define VK_OEM_JUMP &hEA
#define VK_OEM_PA1 &hEB
#define VK_OEM_PA2 &hEC
#define VK_OEM_PA3 &hED
#define VK_OEM_WSCTRL &hEE
#define VK_OEM_CUSEL &hEF
#define VK_OEM_ATTN &hF0
#define VK_OEM_FINISH &hF1
#define VK_OEM_COPY &hF2
#define VK_OEM_AUTO &hF3
#define VK_OEM_ENLW &hF4
#define VK_OEM_BACKTAB &hF5
#define VK_ATTN &hF6
#define VK_CRSEL &hF7
#define VK_EXSEL &hF8
#define VK_EREOF &hF9
#define VK_PLAY &hFA
#define VK_ZOOM &hFB
#define VK_NONAME &hFC
#define VK_PA1 &hFD
#define VK_OEM_CLEAR &hFE
#define WH_MIN (-1)
#define WH_MSGFILTER (-1)
#define WH_JOURNALRECORD 0
#define WH_JOURNALPLAYBACK 1
#define WH_KEYBOARD 2
#define WH_GETMESSAGE 3
#define WH_CALLWNDPROC 4
#define WH_CBT 5
#define WH_SYSMSGFILTER 6
#define WH_MOUSE 7
#define WH_HARDWARE 8
#define WH_DEBUG 9
#define WH_SHELL 10
#define WH_FOREGROUNDIDLE 11
#define WH_CALLWNDPROCRET 12
#define WH_KEYBOARD_LL 13
#define WH_MOUSE_LL 14
#define WH_MAX 14
#define WH_MINHOOK WH_MIN
#define WH_MAXHOOK WH_MAX
#define HC_ACTION 0
#define HC_GETNEXT 1
#define HC_SKIP 2
#define HC_NOREMOVE 3
#define HC_NOREM HC_NOREMOVE
#define HC_SYSMODALON 4
#define HC_SYSMODALOFF 5
#define HCBT_MOVESIZE 0
#define HCBT_MINMAX 1
#define HCBT_QS 2
#define HCBT_CREATEWND 3
#define HCBT_DESTROYWND 4
#define HCBT_ACTIVATE 5
#define HCBT_CLICKSKIPPED 6
#define HCBT_KEYSKIPPED 7
#define HCBT_SYSCOMMAND 8
#define HCBT_SETFOCUS 9
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
#define WTS_CONSOLE_CONNECT &h1
#define WTS_CONSOLE_DISCONNECT &h2
#define WTS_REMOTE_CONNECT &h3
#define WTS_REMOTE_DISCONNECT &h4
#define WTS_SESSION_LOGON &h5
#define WTS_SESSION_LOGOFF &h6
#define WTS_SESSION_LOCK &h7
#define WTS_SESSION_UNLOCK &h8
#define WTS_SESSION_REMOTE_CONTROL &h9
#define MSGF_DIALOGBOX 0
#define MSGF_MESSAGEBOX 1
#define MSGF_MENU 2
#define MSGF_SCROLLBAR 5
#define MSGF_NEXTWINDOW 6
#define MSGF_MAX 8
#define MSGF_USER 4096
#define HSHELL_WINDOWCREATED 1
#define HSHELL_WINDOWDESTROYED 2
#define HSHELL_ACTIVATESHELLWINDOW 3
#define HSHELL_WINDOWACTIVATED 4
#define HSHELL_GETMINRECT 5
#define HSHELL_REDRAW 6
#define HSHELL_TASKMAN 7
#define HSHELL_LANGUAGE 8
#define HSHELL_SYSMENU 9
#define HSHELL_ENDTASK 10
#define HSHELL_ACCESSIBILITYSTATE 11
#define HSHELL_APPCOMMAND 12
#define HSHELL_WINDOWREPLACED 13
#define HSHELL_WINDOWREPLACING 14
#define HSHELL_HIGHBIT &h8000
#define HSHELL_FLASH (HSHELL_REDRAW or HSHELL_HIGHBIT)
#define HSHELL_RUDEAPPACTIVATED (HSHELL_WINDOWACTIVATED or HSHELL_HIGHBIT)
#define ACCESS_STICKYKEYS &h0001
#define ACCESS_FILTERKEYS &h0002
#define ACCESS_MOUSEKEYS &h0003
#define APPCOMMAND_BROWSER_BACKWARD 1
#define APPCOMMAND_BROWSER_FORWARD 2
#define APPCOMMAND_BROWSER_REFRESH 3
#define APPCOMMAND_BROWSER_STOP 4
#define APPCOMMAND_BROWSER_SEARCH 5
#define APPCOMMAND_BROWSER_FAVORITES 6
#define APPCOMMAND_BROWSER_HOME 7
#define APPCOMMAND_VOLUME_MUTE 8
#define APPCOMMAND_VOLUME_DOWN 9
#define APPCOMMAND_VOLUME_UP 10
#define APPCOMMAND_MEDIA_NEXTTRACK 11
#define APPCOMMAND_MEDIA_PREVIOUSTRACK 12
#define APPCOMMAND_MEDIA_STOP 13
#define APPCOMMAND_MEDIA_PLAY_PAUSE 14
#define APPCOMMAND_LAUNCH_MAIL 15
#define APPCOMMAND_LAUNCH_MEDIA_SELECT 16
#define APPCOMMAND_LAUNCH_APP1 17
#define APPCOMMAND_LAUNCH_APP2 18
#define APPCOMMAND_BASS_DOWN 19
#define APPCOMMAND_BASS_BOOST 20
#define APPCOMMAND_BASS_UP 21
#define APPCOMMAND_TREBLE_DOWN 22
#define APPCOMMAND_TREBLE_UP 23
#define APPCOMMAND_MICROPHONE_VOLUME_MUTE 24
#define APPCOMMAND_MICROPHONE_VOLUME_DOWN 25
#define APPCOMMAND_MICROPHONE_VOLUME_UP 26
#define APPCOMMAND_HELP 27
#define APPCOMMAND_FIND 28
#define APPCOMMAND_NEW 29
#define APPCOMMAND_OPEN 30
#define APPCOMMAND_CLOSE 31
#define APPCOMMAND_SAVE 32
#define APPCOMMAND_PRINT 33
#define APPCOMMAND_UNDO 34
#define APPCOMMAND_REDO 35
#define APPCOMMAND_COPY 36
#define APPCOMMAND_CUT 37
#define APPCOMMAND_PASTE 38
#define APPCOMMAND_REPLY_TO_MAIL 39
#define APPCOMMAND_FORWARD_MAIL 40
#define APPCOMMAND_SEND_MAIL 41
#define APPCOMMAND_SPELL_CHECK 42
#define APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE 43
#define APPCOMMAND_MIC_ON_OFF_TOGGLE 44
#define APPCOMMAND_CORRECTION_LIST 45
#define APPCOMMAND_MEDIA_PLAY 46
#define APPCOMMAND_MEDIA_PAUSE 47
#define APPCOMMAND_MEDIA_RECORD 48
#define APPCOMMAND_MEDIA_FAST_FORWARD 49
#define APPCOMMAND_MEDIA_REWIND 50
#define APPCOMMAND_MEDIA_CHANNEL_UP 51
#define APPCOMMAND_MEDIA_CHANNEL_DOWN 52
#define FAPPCOMMAND_MOUSE &h8000
#define FAPPCOMMAND_KEY 0
#define FAPPCOMMAND_OEM &h1000
#define FAPPCOMMAND_MASK &hF000
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

#define LLKHF_EXTENDED (KF_EXTENDED shr 8)
#define LLKHF_INJECTED &h00000010
#define LLKHF_ALTDOWN (KF_ALTDOWN shr 8)
#define LLKHF_UP (KF_UP shr 8)
#define LLMHF_INJECTED &h00000001

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
	_unnamed as MOUSEHOOKSTRUCT
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

#define HKL_PREV 0
#define HKL_NEXT 1
#define KLF_ACTIVATE &h00000001
#define KLF_SUBSTITUTE_OK &h00000002
#define KLF_REORDER &h00000008
#define KLF_REPLACELANG &h00000010
#define KLF_NOTELLSHELL &h00000080
#define KLF_SETFORPROCESS &h00000100
#define KLF_SHIFTLOCK &h00010000
#define KLF_RESET &h40000000
#define INPUTLANGCHANGE_SYSCHARSET &h0001
#define INPUTLANGCHANGE_FORWARD &h0002
#define INPUTLANGCHANGE_BACKWARD &h0004
#define KL_NAMELENGTH 9

#ifdef UNICODE
	#define LoadKeyboardLayout LoadKeyboardLayoutW
	#define GetKeyboardLayoutName GetKeyboardLayoutNameW
#else
	#define LoadKeyboardLayout LoadKeyboardLayoutA
	#define GetKeyboardLayoutName GetKeyboardLayoutNameA
#endif

declare function LoadKeyboardLayoutA(byval pwszKLID as LPCSTR, byval Flags as UINT) as HKL
declare function LoadKeyboardLayoutW(byval pwszKLID as LPCWSTR, byval Flags as UINT) as HKL
declare function ActivateKeyboardLayout(byval hkl as HKL, byval Flags as UINT) as HKL
declare function ToUnicodeEx(byval wVirtKey as UINT, byval wScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval pwszBuff as LPWSTR, byval cchBuff as long, byval wFlags as UINT, byval dwhkl as HKL) as long
declare function UnloadKeyboardLayout(byval hkl as HKL) as WINBOOL
declare function GetKeyboardLayoutNameA(byval pwszKLID as LPSTR) as WINBOOL
declare function GetKeyboardLayoutNameW(byval pwszKLID as LPWSTR) as WINBOOL
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
#define GMMP_USE_DISPLAY_POINTS 1
#define GMMP_USE_HIGH_RESOLUTION_POINTS 2
declare function GetMouseMovePointsEx(byval cbSize as UINT, byval lppt as LPMOUSEMOVEPOINT, byval lpptBuf as LPMOUSEMOVEPOINT, byval nBufPoints as long, byval resolution as DWORD) as long

#define DESKTOP_READOBJECTS __MSABI_LONG(&h0001)
#define DESKTOP_CREATEWINDOW __MSABI_LONG(&h0002)
#define DESKTOP_CREATEMENU __MSABI_LONG(&h0004)
#define DESKTOP_HOOKCONTROL __MSABI_LONG(&h0008)
#define DESKTOP_JOURNALRECORD __MSABI_LONG(&h0010)
#define DESKTOP_JOURNALPLAYBACK __MSABI_LONG(&h0020)
#define DESKTOP_ENUMERATE __MSABI_LONG(&h0040)
#define DESKTOP_WRITEOBJECTS __MSABI_LONG(&h0080)
#define DESKTOP_SWITCHDESKTOP __MSABI_LONG(&h0100)
#define DF_ALLOWOTHERACCOUNTHOOK __MSABI_LONG(&h0001)

#ifdef UNICODE
	#define CreateDesktop CreateDesktopW
#else
	#define CreateDesktop CreateDesktopA
#endif

declare function CreateDesktopA(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as LPDEVMODEA, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK
declare function CreateDesktopW(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as LPDEVMODEW, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HDESK

#ifdef UNICODE
	#define OpenDesktop OpenDesktopW
	#define EnumDesktops EnumDesktopsW
#else
	#define OpenDesktop OpenDesktopA
	#define EnumDesktops EnumDesktopsA
#endif

declare function OpenDesktopA(byval lpszDesktop as LPCSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
declare function OpenDesktopW(byval lpszDesktop as LPCWSTR, byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
declare function OpenInputDesktop(byval dwFlags as DWORD, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HDESK
declare function EnumDesktopsA(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCA, byval lParam as LPARAM) as WINBOOL
declare function EnumDesktopsW(byval hwinsta as HWINSTA, byval lpEnumFunc as DESKTOPENUMPROCW, byval lParam as LPARAM) as WINBOOL
declare function EnumDesktopWindows(byval hDesktop as HDESK, byval lpfn as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function SwitchDesktop(byval hDesktop as HDESK) as WINBOOL
declare function SetThreadDesktop(byval hDesktop as HDESK) as WINBOOL
declare function CloseDesktop(byval hDesktop as HDESK) as WINBOOL
declare function GetThreadDesktop(byval dwThreadId as DWORD) as HDESK

#define WINSTA_ENUMDESKTOPS __MSABI_LONG(&h0001)
#define WINSTA_READATTRIBUTES __MSABI_LONG(&h0002)
#define WINSTA_ACCESSCLIPBOARD __MSABI_LONG(&h0004)
#define WINSTA_CREATEDESKTOP __MSABI_LONG(&h0008)
#define WINSTA_WRITEATTRIBUTES __MSABI_LONG(&h0010)
#define WINSTA_ACCESSGLOBALATOMS __MSABI_LONG(&h0020)
#define WINSTA_EXITWINDOWS __MSABI_LONG(&h0040)
#define WINSTA_ENUMERATE __MSABI_LONG(&h0100)
#define WINSTA_READSCREEN __MSABI_LONG(&h0200)
#define WINSTA_ALL_ACCESS ((((((((WINSTA_ENUMDESKTOPS or WINSTA_READATTRIBUTES) or WINSTA_ACCESSCLIPBOARD) or WINSTA_CREATEDESKTOP) or WINSTA_WRITEATTRIBUTES) or WINSTA_ACCESSGLOBALATOMS) or WINSTA_EXITWINDOWS) or WINSTA_ENUMERATE) or WINSTA_READSCREEN)
#define CWF_CREATE_ONLY __MSABI_LONG(&h0001)
#define WSF_VISIBLE __MSABI_LONG(&h0001)

#ifdef UNICODE
	#define CreateWindowStation CreateWindowStationW
	#define OpenWindowStation OpenWindowStationW
	#define EnumWindowStations EnumWindowStationsW
#else
	#define CreateWindowStation CreateWindowStationA
	#define OpenWindowStation OpenWindowStationA
	#define EnumWindowStations EnumWindowStationsA
#endif

declare function CreateWindowStationA(byval lpwinsta as LPCSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA
declare function CreateWindowStationW(byval lpwinsta as LPCWSTR, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES) as HWINSTA
declare function OpenWindowStationA(byval lpszWinSta as LPCSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA
declare function OpenWindowStationW(byval lpszWinSta as LPCWSTR, byval fInherit as WINBOOL, byval dwDesiredAccess as ACCESS_MASK) as HWINSTA
declare function EnumWindowStationsA(byval lpEnumFunc as WINSTAENUMPROCA, byval lParam as LPARAM) as WINBOOL
declare function EnumWindowStationsW(byval lpEnumFunc as WINSTAENUMPROCW, byval lParam as LPARAM) as WINBOOL
declare function CloseWindowStation(byval hWinSta as HWINSTA) as WINBOOL
declare function SetProcessWindowStation(byval hWinSta as HWINSTA) as WINBOOL
declare function GetProcessWindowStation() as HWINSTA
declare function SetUserObjectSecurity(byval hObj as HANDLE, byval pSIRequested as PSECURITY_INFORMATION, byval pSID as PSECURITY_DESCRIPTOR) as WINBOOL
declare function GetUserObjectSecurity(byval hObj as HANDLE, byval pSIRequested as PSECURITY_INFORMATION, byval pSID as PSECURITY_DESCRIPTOR, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL

#define UOI_FLAGS 1
#define UOI_NAME 2
#define UOI_TYPE 3
#define UOI_USER_SID 4

type tagUSEROBJECTFLAGS
	fInherit as WINBOOL
	fReserved as WINBOOL
	dwFlags as DWORD
end type

type USEROBJECTFLAGS as tagUSEROBJECTFLAGS
type PUSEROBJECTFLAGS as tagUSEROBJECTFLAGS ptr

#ifdef UNICODE
	#define GetUserObjectInformation GetUserObjectInformationW
	#define SetUserObjectInformation SetUserObjectInformationW
#else
	#define GetUserObjectInformation GetUserObjectInformationA
	#define SetUserObjectInformation SetUserObjectInformationA
#endif

declare function GetUserObjectInformationA(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
declare function GetUserObjectInformationW(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD, byval lpnLengthNeeded as LPDWORD) as WINBOOL
declare function SetUserObjectInformationA(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL
declare function SetUserObjectInformationW(byval hObj as HANDLE, byval nIndex as long, byval pvInfo as PVOID, byval nLength as DWORD) as WINBOOL

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

#ifndef __FB_64BIT__
	#define GWL_WNDPROC (-4)
	#define GWL_HINSTANCE (-6)
	#define GWL_HWNDPARENT (-8)
#endif

#define GWL_STYLE (-16)
#define GWL_EXSTYLE (-20)

#ifndef __FB_64BIT__
	#define GWL_USERDATA (-21)
#endif

#define GWL_ID (-12)
#define GWLP_WNDPROC (-4)
#define GWLP_HINSTANCE (-6)
#define GWLP_HWNDPARENT (-8)
#define GWLP_USERDATA (-21)
#define GWLP_ID (-12)

#ifndef __FB_64BIT__
	#define GCL_MENUNAME (-8)
	#define GCL_HBRBACKGROUND (-10)
	#define GCL_HCURSOR (-12)
	#define GCL_HICON (-14)
	#define GCL_HMODULE (-16)
#endif

#define GCL_CBWNDEXTRA (-18)
#define GCL_CBCLSEXTRA (-20)

#ifndef __FB_64BIT__
	#define GCL_WNDPROC (-24)
#endif

#define GCL_STYLE (-26)
#define GCW_ATOM (-32)

#ifndef __FB_64BIT__
	#define GCL_HICONSM (-34)
#endif

#define GCLP_MENUNAME (-8)
#define GCLP_HBRBACKGROUND (-10)
#define GCLP_HCURSOR (-12)
#define GCLP_HICON (-14)
#define GCLP_HMODULE (-16)
#define GCLP_WNDPROC (-24)
#define GCLP_HICONSM (-34)
#define WM_NULL &h0000
#define WM_CREATE &h0001
#define WM_DESTROY &h0002
#define WM_MOVE &h0003
#define WM_SIZE &h0005
#define WM_ACTIVATE &h0006
#define WA_INACTIVE 0
#define WA_ACTIVE 1
#define WA_CLICKACTIVE 2
#define WM_SETFOCUS &h0007
#define WM_KILLFOCUS &h0008
#define WM_ENABLE &h000A
#define WM_SETREDRAW &h000B
#define WM_SETTEXT &h000C
#define WM_GETTEXT &h000D
#define WM_GETTEXTLENGTH &h000E
#define WM_PAINT &h000F
#define WM_CLOSE &h0010
#define WM_QUERYENDSESSION &h0011
#define WM_QUERYOPEN &h0013
#define WM_ENDSESSION &h0016
#define WM_QUIT &h0012
#define WM_ERASEBKGND &h0014
#define WM_SYSCOLORCHANGE &h0015
#define WM_SHOWWINDOW &h0018
#define WM_WININICHANGE &h001A
#define WM_SETTINGCHANGE WM_WININICHANGE
#define WM_DEVMODECHANGE &h001B
#define WM_ACTIVATEAPP &h001C
#define WM_FONTCHANGE &h001D
#define WM_TIMECHANGE &h001E
#define WM_CANCELMODE &h001F
#define WM_SETCURSOR &h0020
#define WM_MOUSEACTIVATE &h0021
#define WM_CHILDACTIVATE &h0022
#define WM_QUEUESYNC &h0023
#define WM_GETMINMAXINFO &h0024

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

#define WM_PAINTICON &h0026
#define WM_ICONERASEBKGND &h0027
#define WM_NEXTDLGCTL &h0028
#define WM_SPOOLERSTATUS &h002A
#define WM_DRAWITEM &h002B
#define WM_MEASUREITEM &h002C
#define WM_DELETEITEM &h002D
#define WM_VKEYTOITEM &h002E
#define WM_CHARTOITEM &h002F
#define WM_SETFONT &h0030
#define WM_GETFONT &h0031
#define WM_SETHOTKEY &h0032
#define WM_GETHOTKEY &h0033
#define WM_QUERYDRAGICON &h0037
#define WM_COMPAREITEM &h0039
#define WM_GETOBJECT &h003D
#define WM_COMPACTING &h0041
#define WM_COMMNOTIFY &h0044
#define WM_WINDOWPOSCHANGING &h0046
#define WM_WINDOWPOSCHANGED &h0047
#define WM_POWER &h0048
#define PWR_OK 1
#define PWR_FAIL (-1)
#define PWR_SUSPENDREQUEST 1
#define PWR_SUSPENDRESUME 2
#define PWR_CRITICALRESUME 3
#define WM_COPYDATA &h004A
#define WM_CANCELJOURNAL &h004B

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

#define WM_NOTIFY &h004E
#define WM_INPUTLANGCHANGEREQUEST &h0050
#define WM_INPUTLANGCHANGE &h0051
#define WM_TCARD &h0052
#define WM_HELP &h0053
#define WM_USERCHANGED &h0054
#define WM_NOTIFYFORMAT &h0055
#define NFR_ANSI 1
#define NFR_UNICODE 2
#define NF_QUERY 3
#define NF_REQUERY 4
#define WM_CONTEXTMENU &h007B
#define WM_STYLECHANGING &h007C
#define WM_STYLECHANGED &h007D
#define WM_DISPLAYCHANGE &h007E
#define WM_GETICON &h007F
#define WM_SETICON &h0080
#define WM_NCCREATE &h0081
#define WM_NCDESTROY &h0082
#define WM_NCCALCSIZE &h0083
#define WM_NCHITTEST &h0084
#define WM_NCPAINT &h0085
#define WM_NCACTIVATE &h0086
#define WM_GETDLGCODE &h0087
#define WM_SYNCPAINT &h0088
#define WM_NCMOUSEMOVE &h00A0
#define WM_NCLBUTTONDOWN &h00A1
#define WM_NCLBUTTONUP &h00A2
#define WM_NCLBUTTONDBLCLK &h00A3
#define WM_NCRBUTTONDOWN &h00A4
#define WM_NCRBUTTONUP &h00A5
#define WM_NCRBUTTONDBLCLK &h00A6
#define WM_NCMBUTTONDOWN &h00A7
#define WM_NCMBUTTONUP &h00A8
#define WM_NCMBUTTONDBLCLK &h00A9
#define WM_NCXBUTTONDOWN &h00AB
#define WM_NCXBUTTONUP &h00AC
#define WM_NCXBUTTONDBLCLK &h00AD
#define WM_INPUT &h00FF
#define WM_KEYFIRST &h0100
#define WM_KEYDOWN &h0100
#define WM_KEYUP &h0101
#define WM_CHAR &h0102
#define WM_DEADCHAR &h0103
#define WM_SYSKEYDOWN &h0104
#define WM_SYSKEYUP &h0105
#define WM_SYSCHAR &h0106
#define WM_SYSDEADCHAR &h0107
#define WM_UNICHAR &h0109
#define WM_KEYLAST &h0109
#define UNICODE_NOCHAR &hFFFF
#define WM_IME_STARTCOMPOSITION &h010D
#define WM_IME_ENDCOMPOSITION &h010E
#define WM_IME_COMPOSITION &h010F
#define WM_IME_KEYLAST &h010F
#define WM_INITDIALOG &h0110
#define WM_COMMAND &h0111
#define WM_SYSCOMMAND &h0112
#define WM_TIMER &h0113
#define WM_HSCROLL &h0114
#define WM_VSCROLL &h0115
#define WM_INITMENU &h0116
#define WM_INITMENUPOPUP &h0117
#define WM_MENUSELECT &h011F

#if _WIN32_WINNT = &h0602
	#define WM_GESTURE &h0119
	#define WM_GESTURENOTIFY &h011A
#endif

#define WM_MENUCHAR &h0120
#define WM_ENTERIDLE &h0121
#define WM_MENURBUTTONUP &h0122
#define WM_MENUDRAG &h0123
#define WM_MENUGETOBJECT &h0124
#define WM_UNINITMENUPOPUP &h0125
#define WM_MENUCOMMAND &h0126
#define WM_CHANGEUISTATE &h0127
#define WM_UPDATEUISTATE &h0128
#define WM_QUERYUISTATE &h0129
#define UIS_SET 1
#define UIS_CLEAR 2
#define UIS_INITIALIZE 3
#define UISF_HIDEFOCUS &h1
#define UISF_HIDEACCEL &h2
#define UISF_ACTIVE &h4
#define WM_CTLCOLORMSGBOX &h0132
#define WM_CTLCOLOREDIT &h0133
#define WM_CTLCOLORLISTBOX &h0134
#define WM_CTLCOLORBTN &h0135
#define WM_CTLCOLORDLG &h0136
#define WM_CTLCOLORSCROLLBAR &h0137
#define WM_CTLCOLORSTATIC &h0138
#define MN_GETHMENU &h01E1
#define WM_MOUSEFIRST &h0200
#define WM_MOUSEMOVE &h0200
#define WM_LBUTTONDOWN &h0201
#define WM_LBUTTONUP &h0202
#define WM_LBUTTONDBLCLK &h0203
#define WM_RBUTTONDOWN &h0204
#define WM_RBUTTONUP &h0205
#define WM_RBUTTONDBLCLK &h0206
#define WM_MBUTTONDOWN &h0207
#define WM_MBUTTONUP &h0208
#define WM_MBUTTONDBLCLK &h0209
#define WM_MOUSEWHEEL &h020A
#define WM_XBUTTONDOWN &h020B
#define WM_XBUTTONUP &h020C
#define WM_XBUTTONDBLCLK &h020D

#if (_WIN32_WINNT = &h0400) or (_WIN32_WINNT = &h0502)
	#define WM_MOUSELAST &h020D
#else
	#define WM_MOUSEHWHEEL &h020E
	#define WM_MOUSELAST &h020E
#endif

#define WHEEL_DELTA 120
#define GET_WHEEL_DELTA_WPARAM(wParam) cshort(HIWORD(wParam))
#define WHEEL_PAGESCROLL UINT_MAX
#define GET_KEYSTATE_WPARAM(wParam) LOWORD(wParam)
#define GET_NCHITTEST_WPARAM(wParam) cshort(LOWORD(wParam))
#define GET_XBUTTON_WPARAM(wParam) HIWORD(wParam)
#define XBUTTON1 &h0001
#define XBUTTON2 &h0002
#define WM_PARENTNOTIFY &h0210
#define WM_ENTERMENULOOP &h0211
#define WM_EXITMENULOOP &h0212
#define WM_NEXTMENU &h0213
#define WM_SIZING &h0214
#define WM_CAPTURECHANGED &h0215
#define WM_MOVING &h0216
#define WM_POWERBROADCAST &h0218
#define PBT_APMQUERYSUSPEND &h0000
#define PBT_APMQUERYSTANDBY &h0001
#define PBT_APMQUERYSUSPENDFAILED &h0002
#define PBT_APMQUERYSTANDBYFAILED &h0003
#define PBT_APMSUSPEND &h0004
#define PBT_APMSTANDBY &h0005
#define PBT_APMRESUMECRITICAL &h0006
#define PBT_APMRESUMESUSPEND &h0007
#define PBT_APMRESUMESTANDBY &h0008
#define PBTF_APMRESUMEFROMFAILURE &h00000001
#define PBT_APMBATTERYLOW &h0009
#define PBT_APMPOWERSTATUSCHANGE &h000A
#define PBT_APMOEMEVENT &h000B
#define PBT_APMRESUMEAUTOMATIC &h0012

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	#define PBT_POWERSETTINGCHANGE 32787
#endif

#define WM_MDICREATE &h0220
#define WM_MDIDESTROY &h0221
#define WM_MDIACTIVATE &h0222
#define WM_MDIRESTORE &h0223
#define WM_MDINEXT &h0224
#define WM_MDIMAXIMIZE &h0225
#define WM_MDITILE &h0226
#define WM_MDICASCADE &h0227
#define WM_MDIICONARRANGE &h0228
#define WM_MDIGETACTIVE &h0229
#define WM_MDISETMENU &h0230
#define WM_ENTERSIZEMOVE &h0231
#define WM_EXITSIZEMOVE &h0232
#define WM_DROPFILES &h0233
#define WM_MDIREFRESHMENU &h0234
#define WM_IME_SETCONTEXT &h0281
#define WM_IME_NOTIFY &h0282
#define WM_IME_CONTROL &h0283
#define WM_IME_COMPOSITIONFULL &h0284
#define WM_IME_SELECT &h0285
#define WM_IME_CHAR &h0286
#define WM_IME_REQUEST &h0288
#define WM_IME_KEYDOWN &h0290
#define WM_IME_KEYUP &h0291
#define WM_MOUSEHOVER &h02A1
#define WM_MOUSELEAVE &h02A3
#define WM_NCMOUSEHOVER &h02A0
#define WM_NCMOUSELEAVE &h02A2
#define WM_WTSSESSION_CHANGE &h02B1
#define WM_TABLET_FIRST &h02c0
#define WM_TABLET_LAST &h02df
#define WM_CUT &h0300
#define WM_COPY &h0301
#define WM_PASTE &h0302
#define WM_CLEAR &h0303
#define WM_UNDO &h0304
#define WM_RENDERFORMAT &h0305
#define WM_RENDERALLFORMATS &h0306
#define WM_DESTROYCLIPBOARD &h0307
#define WM_DRAWCLIPBOARD &h0308
#define WM_PAINTCLIPBOARD &h0309
#define WM_VSCROLLCLIPBOARD &h030A
#define WM_SIZECLIPBOARD &h030B
#define WM_ASKCBFORMATNAME &h030C
#define WM_CHANGECBCHAIN &h030D
#define WM_HSCROLLCLIPBOARD &h030E
#define WM_QUERYNEWPALETTE &h030F
#define WM_PALETTEISCHANGING &h0310
#define WM_PALETTECHANGED &h0311
#define WM_HOTKEY &h0312
#define WM_PRINT &h0317
#define WM_PRINTCLIENT &h0318
#define WM_APPCOMMAND &h0319
#define WM_THEMECHANGED &h031A
#define WM_HANDHELDFIRST &h0358
#define WM_HANDHELDLAST &h035F
#define WM_AFXFIRST &h0360
#define WM_AFXLAST &h037F
#define WM_PENWINFIRST &h0380
#define WM_PENWINLAST &h038F
#define WM_APP &h8000
#define WM_USER &h0400
#define WMSZ_LEFT 1
#define WMSZ_RIGHT 2
#define WMSZ_TOP 3
#define WMSZ_TOPLEFT 4
#define WMSZ_TOPRIGHT 5
#define WMSZ_BOTTOM 6
#define WMSZ_BOTTOMLEFT 7
#define WMSZ_BOTTOMRIGHT 8
#define HTERROR (-2)
#define HTTRANSPARENT (-1)
#define HTNOWHERE 0
#define HTCLIENT 1
#define HTCAPTION 2
#define HTSYSMENU 3
#define HTGROWBOX 4
#define HTSIZE HTGROWBOX
#define HTMENU 5
#define HTHSCROLL 6
#define HTVSCROLL 7
#define HTMINBUTTON 8
#define HTMAXBUTTON 9
#define HTLEFT 10
#define HTRIGHT 11
#define HTTOP 12
#define HTTOPLEFT 13
#define HTTOPRIGHT 14
#define HTBOTTOM 15
#define HTBOTTOMLEFT 16
#define HTBOTTOMRIGHT 17
#define HTBORDER 18
#define HTREDUCE HTMINBUTTON
#define HTZOOM HTMAXBUTTON
#define HTSIZEFIRST HTLEFT
#define HTSIZELAST HTBOTTOMRIGHT
#define HTOBJECT 19
#define HTCLOSE 20
#define HTHELP 21
#define SMTO_NORMAL &h0000
#define SMTO_BLOCK &h0001
#define SMTO_ABORTIFHUNG &h0002
#define SMTO_NOTIMEOUTIFNOTHUNG &h0008
#define MA_ACTIVATE 1
#define MA_ACTIVATEANDEAT 2
#define MA_NOACTIVATE 3
#define MA_NOACTIVATEANDEAT 4
#define ICON_SMALL 0
#define ICON_BIG 1
#define ICON_SMALL2 2

#ifdef UNICODE
	#define RegisterWindowMessage RegisterWindowMessageW
#else
	#define RegisterWindowMessage RegisterWindowMessageA
#endif

declare function RegisterWindowMessageA(byval lpString as LPCSTR) as UINT
declare function RegisterWindowMessageW(byval lpString as LPCWSTR) as UINT
#define SIZE_RESTORED 0
#define SIZE_MINIMIZED 1
#define SIZE_MAXIMIZED 2
#define SIZE_MAXSHOW 3
#define SIZE_MAXHIDE 4
#define SIZENORMAL SIZE_RESTORED
#define SIZEICONIC SIZE_MINIMIZED
#define SIZEFULLSCREEN SIZE_MAXIMIZED
#define SIZEZOOMSHOW SIZE_MAXSHOW
#define SIZEZOOMHIDE SIZE_MAXHIDE

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
#define WVR_ALIGNTOP &h0010
#define WVR_ALIGNLEFT &h0020
#define WVR_ALIGNBOTTOM &h0040
#define WVR_ALIGNRIGHT &h0080
#define WVR_HREDRAW &h0100
#define WVR_VREDRAW &h0200
#define WVR_REDRAW (WVR_HREDRAW or WVR_VREDRAW)
#define WVR_VALIDRECTS &h0400
#define MK_LBUTTON &h0001
#define MK_RBUTTON &h0002
#define MK_SHIFT &h0004
#define MK_CONTROL &h0008
#define MK_MBUTTON &h0010
#define MK_XBUTTON1 &h0020
#define MK_XBUTTON2 &h0040
#define TME_HOVER &h00000001
#define TME_LEAVE &h00000002
#define TME_NONCLIENT &h00000010
#define TME_QUERY &h40000000
#define TME_CANCEL &h80000000
#define HOVER_DEFAULT &hFFFFFFFF

type tagTRACKMOUSEEVENT
	cbSize as DWORD
	dwFlags as DWORD
	hwndTrack as HWND
	dwHoverTime as DWORD
end type

type TRACKMOUSEEVENT as tagTRACKMOUSEEVENT
type LPTRACKMOUSEEVENT as tagTRACKMOUSEEVENT ptr
declare function TrackMouseEvent(byval lpEventTrack as LPTRACKMOUSEEVENT) as WINBOOL
#define WS_OVERLAPPED __MSABI_LONG(&h00000000)
#define WS_POPUP __MSABI_LONG(&h80000000)
#define WS_CHILD __MSABI_LONG(&h40000000)
#define WS_MINIMIZE __MSABI_LONG(&h20000000)
#define WS_VISIBLE __MSABI_LONG(&h10000000)
#define WS_DISABLED __MSABI_LONG(&h08000000)
#define WS_CLIPSIBLINGS __MSABI_LONG(&h04000000)
#define WS_CLIPCHILDREN __MSABI_LONG(&h02000000)
#define WS_MAXIMIZE __MSABI_LONG(&h01000000)
#define WS_CAPTION __MSABI_LONG(&h00C00000)
#define WS_BORDER __MSABI_LONG(&h00800000)
#define WS_DLGFRAME __MSABI_LONG(&h00400000)
#define WS_VSCROLL __MSABI_LONG(&h00200000)
#define WS_HSCROLL __MSABI_LONG(&h00100000)
#define WS_SYSMENU __MSABI_LONG(&h00080000)
#define WS_THICKFRAME __MSABI_LONG(&h00040000)
#define WS_GROUP __MSABI_LONG(&h00020000)
#define WS_TABSTOP __MSABI_LONG(&h00010000)
#define WS_MINIMIZEBOX __MSABI_LONG(&h00020000)
#define WS_MAXIMIZEBOX __MSABI_LONG(&h00010000)
#define WS_TILED WS_OVERLAPPED
#define WS_ICONIC WS_MINIMIZE
#define WS_SIZEBOX WS_THICKFRAME
#define WS_TILEDWINDOW WS_OVERLAPPEDWINDOW
#define WS_OVERLAPPEDWINDOW (((((WS_OVERLAPPED or WS_CAPTION) or WS_SYSMENU) or WS_THICKFRAME) or WS_MINIMIZEBOX) or WS_MAXIMIZEBOX)
#define WS_POPUPWINDOW ((WS_POPUP or WS_BORDER) or WS_SYSMENU)
#define WS_CHILDWINDOW WS_CHILD
#define WS_EX_DLGMODALFRAME __MSABI_LONG(&h00000001)
#define WS_EX_NOPARENTNOTIFY __MSABI_LONG(&h00000004)
#define WS_EX_TOPMOST __MSABI_LONG(&h00000008)
#define WS_EX_ACCEPTFILES __MSABI_LONG(&h00000010)
#define WS_EX_TRANSPARENT __MSABI_LONG(&h00000020)
#define WS_EX_MDICHILD __MSABI_LONG(&h00000040)
#define WS_EX_TOOLWINDOW __MSABI_LONG(&h00000080)
#define WS_EX_WINDOWEDGE __MSABI_LONG(&h00000100)
#define WS_EX_CLIENTEDGE __MSABI_LONG(&h00000200)
#define WS_EX_CONTEXTHELP __MSABI_LONG(&h00000400)
#define WS_EX_RIGHT __MSABI_LONG(&h00001000)
#define WS_EX_LEFT __MSABI_LONG(&h00000000)
#define WS_EX_RTLREADING __MSABI_LONG(&h00002000)
#define WS_EX_LTRREADING __MSABI_LONG(&h00000000)
#define WS_EX_LEFTSCROLLBAR __MSABI_LONG(&h00004000)
#define WS_EX_RIGHTSCROLLBAR __MSABI_LONG(&h00000000)
#define WS_EX_CONTROLPARENT __MSABI_LONG(&h00010000)
#define WS_EX_STATICEDGE __MSABI_LONG(&h00020000)
#define WS_EX_APPWINDOW __MSABI_LONG(&h00040000)
#define WS_EX_OVERLAPPEDWINDOW (WS_EX_WINDOWEDGE or WS_EX_CLIENTEDGE)
#define WS_EX_PALETTEWINDOW ((WS_EX_WINDOWEDGE or WS_EX_TOOLWINDOW) or WS_EX_TOPMOST)
#define WS_EX_LAYERED &h00080000
#define WS_EX_NOINHERITLAYOUT __MSABI_LONG(&h00100000)
#define WS_EX_LAYOUTRTL __MSABI_LONG(&h00400000)
#define WS_EX_COMPOSITED __MSABI_LONG(&h02000000)
#define WS_EX_NOACTIVATE __MSABI_LONG(&h08000000)
#define CS_VREDRAW &h0001
#define CS_HREDRAW &h0002
#define CS_DBLCLKS &h0008
#define CS_OWNDC &h0020
#define CS_CLASSDC &h0040
#define CS_PARENTDC &h0080
#define CS_NOCLOSE &h0200
#define CS_SAVEBITS &h0800
#define CS_BYTEALIGNCLIENT &h1000
#define CS_BYTEALIGNWINDOW &h2000
#define CS_GLOBALCLASS &h4000
#define CS_IME &h00010000
#define CS_DROPSHADOW &h00020000
#define PRF_CHECKVISIBLE __MSABI_LONG(&h00000001)
#define PRF_NONCLIENT __MSABI_LONG(&h00000002)
#define PRF_CLIENT __MSABI_LONG(&h00000004)
#define PRF_ERASEBKGND __MSABI_LONG(&h00000008)
#define PRF_CHILDREN __MSABI_LONG(&h00000010)
#define PRF_OWNED __MSABI_LONG(&h00000020)
#define BDR_RAISEDOUTER &h0001
#define BDR_SUNKENOUTER &h0002
#define BDR_RAISEDINNER &h0004
#define BDR_SUNKENINNER &h0008
#define BDR_OUTER (BDR_RAISEDOUTER or BDR_SUNKENOUTER)
#define BDR_INNER (BDR_RAISEDINNER or BDR_SUNKENINNER)
#define BDR_RAISED (BDR_RAISEDOUTER or BDR_RAISEDINNER)
#define BDR_SUNKEN (BDR_SUNKENOUTER or BDR_SUNKENINNER)
#define EDGE_RAISED (BDR_RAISEDOUTER or BDR_RAISEDINNER)
#define EDGE_SUNKEN (BDR_SUNKENOUTER or BDR_SUNKENINNER)
#define EDGE_ETCHED (BDR_SUNKENOUTER or BDR_RAISEDINNER)
#define EDGE_BUMP (BDR_RAISEDOUTER or BDR_SUNKENINNER)
#define BF_LEFT &h0001
#define BF_TOP &h0002
#define BF_RIGHT &h0004
#define BF_BOTTOM &h0008
#define BF_TOPLEFT (BF_TOP or BF_LEFT)
#define BF_TOPRIGHT (BF_TOP or BF_RIGHT)
#define BF_BOTTOMLEFT (BF_BOTTOM or BF_LEFT)
#define BF_BOTTOMRIGHT (BF_BOTTOM or BF_RIGHT)
#define BF_RECT (((BF_LEFT or BF_TOP) or BF_RIGHT) or BF_BOTTOM)
#define BF_DIAGONAL &h0010
#define BF_DIAGONAL_ENDTOPRIGHT ((BF_DIAGONAL or BF_TOP) or BF_RIGHT)
#define BF_DIAGONAL_ENDTOPLEFT ((BF_DIAGONAL or BF_TOP) or BF_LEFT)
#define BF_DIAGONAL_ENDBOTTOMLEFT ((BF_DIAGONAL or BF_BOTTOM) or BF_LEFT)
#define BF_DIAGONAL_ENDBOTTOMRIGHT ((BF_DIAGONAL or BF_BOTTOM) or BF_RIGHT)
#define BF_MIDDLE &h0800
#define BF_SOFT &h1000
#define BF_ADJUST &h2000
#define BF_FLAT &h4000
#define BF_MONO &h8000
declare function DrawEdge(byval hdc as HDC, byval qrc as LPRECT, byval edge as UINT, byval grfFlags as UINT) as WINBOOL
#define DFC_CAPTION 1
#define DFC_MENU 2
#define DFC_SCROLL 3
#define DFC_BUTTON 4
#define DFC_POPUPMENU 5
#define DFCS_CAPTIONCLOSE &h0000
#define DFCS_CAPTIONMIN &h0001
#define DFCS_CAPTIONMAX &h0002
#define DFCS_CAPTIONRESTORE &h0003
#define DFCS_CAPTIONHELP &h0004
#define DFCS_MENUARROW &h0000
#define DFCS_MENUCHECK &h0001
#define DFCS_MENUBULLET &h0002
#define DFCS_MENUARROWRIGHT &h0004
#define DFCS_SCROLLUP &h0000
#define DFCS_SCROLLDOWN &h0001
#define DFCS_SCROLLLEFT &h0002
#define DFCS_SCROLLRIGHT &h0003
#define DFCS_SCROLLCOMBOBOX &h0005
#define DFCS_SCROLLSIZEGRIP &h0008
#define DFCS_SCROLLSIZEGRIPRIGHT &h0010
#define DFCS_BUTTONCHECK &h0000
#define DFCS_BUTTONRADIOIMAGE &h0001
#define DFCS_BUTTONRADIOMASK &h0002
#define DFCS_BUTTONRADIO &h0004
#define DFCS_BUTTON3STATE &h0008
#define DFCS_BUTTONPUSH &h0010
#define DFCS_INACTIVE &h0100
#define DFCS_PUSHED &h0200
#define DFCS_CHECKED &h0400
#define DFCS_TRANSPARENT &h0800
#define DFCS_HOT &h1000
#define DFCS_ADJUSTRECT &h2000
#define DFCS_FLAT &h4000
#define DFCS_MONO &h8000
declare function DrawFrameControl(byval as HDC, byval as LPRECT, byval as UINT, byval as UINT) as WINBOOL
#define DC_ACTIVE &h0001
#define DC_SMALLCAP &h0002
#define DC_ICON &h0004
#define DC_TEXT &h0008
#define DC_INBUTTON &h0010
#define DC_GRADIENT &h0020
#define DC_BUTTONS &h1000
declare function DrawCaption(byval hwnd as HWND, byval hdc as HDC, byval lprect as const RECT ptr, byval flags as UINT) as WINBOOL
#define IDANI_OPEN 1
#define IDANI_CAPTION 3
declare function DrawAnimatedRects(byval hwnd as HWND, byval idAni as long, byval lprcFrom as const RECT ptr, byval lprcTo as const RECT ptr) as WINBOOL
#define CF_TEXT 1
#define CF_BITMAP 2
#define CF_METAFILEPICT 3
#define CF_SYLK 4
#define CF_DIF 5
#define CF_TIFF 6
#define CF_OEMTEXT 7
#define CF_DIB 8
#define CF_PALETTE 9
#define CF_PENDATA 10
#define CF_RIFF 11
#define CF_WAVE 12
#define CF_UNICODETEXT 13
#define CF_ENHMETAFILE 14
#define CF_HDROP 15
#define CF_LOCALE 16
#define CF_DIBV5 17
#define CF_MAX 18
#define CF_OWNERDISPLAY &h0080
#define CF_DSPTEXT &h0081
#define CF_DSPBITMAP &h0082
#define CF_DSPMETAFILEPICT &h0083
#define CF_DSPENHMETAFILE &h008E
#define CF_PRIVATEFIRST &h0200
#define CF_PRIVATELAST &h02FF
#define CF_GDIOBJFIRST &h0300
#define CF_GDIOBJLAST &h03FF
#define FVIRTKEY TRUE
#define FNOINVERT &h02
#define FSHIFT &h04
#define FCONTROL &h08
#define FALT &h10

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

#define WPF_SETMINPOSITION &h0001
#define WPF_RESTORETOMAXIMIZED &h0002
#define WPF_ASYNCWINDOWPLACEMENT &h0004

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
#define ODT_MENU 1
#define ODT_LISTBOX 2
#define ODT_COMBOBOX 3
#define ODT_BUTTON 4
#define ODT_STATIC 5
#define ODA_DRAWENTIRE &h0001
#define ODA_SELECT &h0002
#define ODA_FOCUS &h0004
#define ODS_SELECTED &h0001
#define ODS_GRAYED &h0002
#define ODS_DISABLED &h0004
#define ODS_CHECKED &h0008
#define ODS_FOCUS &h0010
#define ODS_DEFAULT &h0020
#define ODS_COMBOBOXEDIT &h1000
#define ODS_HOTLIGHT &h0040
#define ODS_INACTIVE &h0080
#define ODS_NOACCEL &h0100
#define ODS_NOFOCUSRECT &h0200

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

#ifdef UNICODE
	#define GetMessage GetMessageW
	#define DispatchMessage DispatchMessageW
	#define PeekMessage PeekMessageW
#else
	#define GetMessage GetMessageA
	#define DispatchMessage DispatchMessageA
	#define PeekMessage PeekMessageA
#endif

declare function GetMessageA(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL
declare function GetMessageW(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT) as WINBOOL
declare function TranslateMessage(byval lpMsg as const MSG ptr) as WINBOOL
declare function DispatchMessageA(byval lpMsg as const MSG ptr) as LRESULT
declare function DispatchMessageW(byval lpMsg as const MSG ptr) as LRESULT
declare function SetMessageQueue(byval cMessagesMax as long) as WINBOOL
declare function PeekMessageA(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL
declare function PeekMessageW(byval lpMsg as LPMSG, byval hWnd as HWND, byval wMsgFilterMin as UINT, byval wMsgFilterMax as UINT, byval wRemoveMsg as UINT) as WINBOOL

#define PM_NOREMOVE &h0000
#define PM_REMOVE &h0001
#define PM_NOYIELD &h0002
#define PM_QS_INPUT (QS_INPUT shl 16)
#define PM_QS_POSTMESSAGE (((QS_POSTMESSAGE or QS_HOTKEY) or QS_TIMER) shl 16)
#define PM_QS_PAINT (QS_PAINT shl 16)
#define PM_QS_SENDMESSAGE (QS_SENDMESSAGE shl 16)
declare function RegisterHotKey(byval hWnd as HWND, byval id as long, byval fsModifiers as UINT, byval vk as UINT) as WINBOOL
declare function UnregisterHotKey(byval hWnd as HWND, byval id as long) as WINBOOL
#define MOD_WIN &h0008

#if _WIN32_WINNT = &h0602
	#define MOD_NOREPEAT &h4000
#endif

#define IDHOT_SNAPWINDOW (-1)
#define IDHOT_SNAPDESKTOP (-2)
#define ENDSESSION_LOGOFF &h80000000
#define EWX_LOGOFF 0
#define EWX_SHUTDOWN &h00000001
#define EWX_REBOOT &h00000002
#define EWX_FORCE &h00000004
#define EWX_POWEROFF &h00000008
#define EWX_FORCEIFHUNG &h00000010
#define ExitWindows(dwReserved, Code) ExitWindowsEx(EWX_LOGOFF, &hFFFFFFFF)

#ifdef UNICODE
	#define SendMessage SendMessageW
	#define SendMessageTimeout SendMessageTimeoutW
	#define SendNotifyMessage SendNotifyMessageW
	#define SendMessageCallback SendMessageCallbackW
#else
	#define SendMessage SendMessageA
	#define SendMessageTimeout SendMessageTimeoutA
	#define SendNotifyMessage SendNotifyMessageA
	#define SendMessageCallback SendMessageCallbackA
#endif

declare function ExitWindowsEx(byval uFlags as UINT, byval dwReason as DWORD) as WINBOOL
declare function SwapMouseButton(byval fSwap as WINBOOL) as WINBOOL
declare function GetMessagePos() as DWORD
declare function GetMessageTime() as LONG
declare function GetMessageExtraInfo() as LPARAM
declare function IsWow64Message() as WINBOOL
declare function SetMessageExtraInfo(byval lParam as LPARAM) as LPARAM
declare function SendMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function SendMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function SendMessageTimeoutA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT
declare function SendMessageTimeoutW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval fuFlags as UINT, byval uTimeout as UINT, byval lpdwResult as PDWORD_PTR) as LRESULT
declare function SendNotifyMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function SendNotifyMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function SendMessageCallbackA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL
declare function SendMessageCallbackW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval lpResultCallBack as SENDASYNCPROC, byval dwData as ULONG_PTR) as WINBOOL

type BSMINFO
	cbSize as UINT
	hdesk as HDESK
	hwnd as HWND
	luid as LUID
end type

type PBSMINFO as BSMINFO ptr

#ifdef UNICODE
	#define BroadcastSystemMessageEx BroadcastSystemMessageExW
	#define BroadcastSystemMessage BroadcastSystemMessageW
#else
	#define BroadcastSystemMessageEx BroadcastSystemMessageExA
	#define BroadcastSystemMessage BroadcastSystemMessageA
#endif

declare function BroadcastSystemMessageExA(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long
declare function BroadcastSystemMessageExW(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM, byval pbsmInfo as PBSMINFO) as long
declare function BroadcastSystemMessageA(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long
declare function BroadcastSystemMessageW(byval flags as DWORD, byval lpInfo as LPDWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as long

#define BSM_ALLDESKTOPS &h00000010
#define BSF_ALLOWSFW &h00000080
#define BSF_SENDNOTIFYMESSAGE &h00000100
#define BSF_RETURNHDESK &h00000200
#define BSF_LUID &h00000400
#define BROADCAST_QUERY_DENY &h424D5144
type HDEVNOTIFY as PVOID
type PHDEVNOTIFY as HDEVNOTIFY ptr
#define DEVICE_NOTIFY_WINDOW_HANDLE &h00000000
#define DEVICE_NOTIFY_SERVICE_HANDLE &h00000001
#define DEVICE_NOTIFY_ALL_INTERFACE_CLASSES &h00000004

#ifdef UNICODE
	#define RegisterDeviceNotification RegisterDeviceNotificationW
	#define PostMessage PostMessageW
	#define PostThreadMessage PostThreadMessageW
	#define PostAppMessage PostAppMessageW
	#define DefWindowProc DefWindowProcW
	#define CallWindowProc CallWindowProcW
	#define RegisterClass RegisterClassW
	#define UnregisterClass UnregisterClassW
	#define GetClassInfo GetClassInfoW
	#define RegisterClassEx RegisterClassExW
	#define GetClassInfoEx GetClassInfoExW
#elseif (not defined(UNICODE)) and ((_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602))
	#define RegisterDeviceNotification RegisterDeviceNotificationA
	#define PostMessage PostMessageA
	#define PostThreadMessage PostThreadMessageA
	#define PostAppMessage PostAppMessageA
	#define DefWindowProc DefWindowProcA
	#define CallWindowProc CallWindowProcA
	#define RegisterClass RegisterClassA
	#define UnregisterClass UnregisterClassA
	#define GetClassInfo GetClassInfoA
	#define RegisterClassEx RegisterClassExA
	#define GetClassInfoEx GetClassInfoExA
#endif

#if (_WIN32_WINNT = &h0502) or (_WIN32_WINNT = &h0602)
	type HPOWERNOTIFY as HANDLE
	type PHPOWERNOTIFY as HPOWERNOTIFY ptr

	type POWERBROADCAST_SETTING
		PowerSetting as GUID
		DataLength as DWORD
		Data(0 to 0) as UCHAR
	end type

	type PPOWERBROADCAST_SETTING as POWERBROADCAST_SETTING ptr
	extern GUID_POWERSCHEME_PERSONALITY as const GUID
	extern GUID_MIN_POWER_SAVINGS as const GUID
	extern GUID_MAX_POWER_SAVINGS as const GUID
	extern GUID_TYPICAL_POWER_SAVINGS as const GUID
	extern GUID_ACDC_POWER_SOURCE as const GUID
	extern GUID_BATTERY_PERCENTAGE_REMAINING as const GUID
	extern GUID_IDLE_BACKGROUND_TASK as const GUID
	extern GUID_SYSTEM_AWAYMODE as const GUID
	extern GUID_MONITOR_POWER_ON as const GUID
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0400)
	#define RegisterDeviceNotification RegisterDeviceNotificationA
	#define PostMessage PostMessageA
	#define PostThreadMessage PostThreadMessageA
	#define PostAppMessage PostAppMessageA
	#define DefWindowProc DefWindowProcA
	#define CallWindowProc CallWindowProcA
	#define RegisterClass RegisterClassA
	#define UnregisterClass UnregisterClassA
	#define GetClassInfo GetClassInfoA
	#define RegisterClassEx RegisterClassExA
	#define GetClassInfoEx GetClassInfoExA
#endif

declare function RegisterDeviceNotificationA(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY
declare function RegisterDeviceNotificationW(byval hRecipient as HANDLE, byval NotificationFilter as LPVOID, byval Flags as DWORD) as HDEVNOTIFY

#if _WIN32_WINNT = &h0602
	declare function RegisterPowerSettingNotification(byval hRecipient as HANDLE, byval PowerSettingGuid as LPCGUID, byval Flags as DWORD) as HPOWERNOTIFY
	declare function UnregisterPowerSettingNotification(byval Handle as HPOWERNOTIFY) as WINBOOL
#endif

declare function UnregisterDeviceNotification(byval Handle as HDEVNOTIFY) as WINBOOL
declare function PostMessageA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function PostMessageW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function PostThreadMessageA(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL
declare function PostThreadMessageW(byval idThread as DWORD, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as WINBOOL

#define PostAppMessageA(idThread, wMsg, wParam, lParam) PostThreadMessageA(cast(DWORD, idThread), wMsg, wParam, lParam)
#define PostAppMessageW(idThread, wMsg, wParam, lParam) PostThreadMessageW(cast(DWORD, idThread), wMsg, wParam, lParam)
#define HWND_BROADCAST cast(HWND, &hffff)
#define HWND_MESSAGE cast(HWND, -3)

declare function AttachThreadInput(byval idAttach as DWORD, byval idAttachTo as DWORD, byval fAttach as WINBOOL) as WINBOOL
declare function ReplyMessage(byval lResult as LRESULT) as WINBOOL
declare function WaitMessage() as WINBOOL
declare function WaitForInputIdle(byval hProcess as HANDLE, byval dwMilliseconds as DWORD) as DWORD
declare function DefWindowProcA(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DefWindowProcW(byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare sub PostQuitMessage(byval nExitCode as long)
declare function CallWindowProcA(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function CallWindowProcW(byval lpPrevWndFunc as WNDPROC, byval hWnd as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function InSendMessage() as WINBOOL
declare function InSendMessageEx(byval lpReserved as LPVOID) as DWORD

#define ISMEX_NOSEND &h00000000
#define ISMEX_SEND &h00000001
#define ISMEX_NOTIFY &h00000002
#define ISMEX_CALLBACK &h00000004
#define ISMEX_REPLIED &h00000008

declare function GetDoubleClickTime() as UINT
declare function SetDoubleClickTime(byval as UINT) as WINBOOL
declare function RegisterClassA(byval lpWndClass as const WNDCLASSA ptr) as ATOM
declare function RegisterClassW(byval lpWndClass as const WNDCLASSW ptr) as ATOM
declare function UnregisterClassA(byval lpClassName as LPCSTR, byval hInstance as HINSTANCE) as WINBOOL
declare function UnregisterClassW(byval lpClassName as LPCWSTR, byval hInstance as HINSTANCE) as WINBOOL
declare function GetClassInfoA(byval hInstance as HINSTANCE, byval lpClassName as LPCSTR, byval lpWndClass as LPWNDCLASSA) as WINBOOL
declare function GetClassInfoW(byval hInstance as HINSTANCE, byval lpClassName as LPCWSTR, byval lpWndClass as LPWNDCLASSW) as WINBOOL
declare function RegisterClassExA(byval as const WNDCLASSEXA ptr) as ATOM
declare function RegisterClassExW(byval as const WNDCLASSEXW ptr) as ATOM
declare function GetClassInfoExA(byval hInstance as HINSTANCE, byval lpszClass as LPCSTR, byval lpwcx as LPWNDCLASSEXA) as WINBOOL
declare function GetClassInfoExW(byval hInstance as HINSTANCE, byval lpszClass as LPCWSTR, byval lpwcx as LPWNDCLASSEXW) as WINBOOL
#define CW_USEDEFAULT clng(&h80000000)
#define HWND_DESKTOP cast(HWND, 0)
type PREGISTERCLASSNAMEW as function(byval as LPCWSTR) as BOOLEAN

#ifdef UNICODE
	#define CreateWindowEx CreateWindowExW
	#define CreateWindow CreateWindowW
#else
	#define CreateWindowEx CreateWindowExA
	#define CreateWindow CreateWindowA
#endif

declare function CreateWindowExA(byval dwExStyle as DWORD, byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND
declare function CreateWindowExW(byval dwExStyle as DWORD, byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hMenu as HMENU, byval hInstance as HINSTANCE, byval lpParam as LPVOID) as HWND
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
declare function UpdateLayeredWindowIndirect(byval hWnd as HWND, byval pULWInfo as const UPDATELAYEREDWINDOWINFO ptr) as WINBOOL
declare function GetLayeredWindowAttributes(byval hwnd as HWND, byval pcrKey as COLORREF ptr, byval pbAlpha as UBYTE ptr, byval pdwFlags as DWORD ptr) as WINBOOL
#define PW_CLIENTONLY &h00000001
declare function PrintWindow(byval hwnd as HWND, byval hdcBlt as HDC, byval nFlags as UINT) as WINBOOL
declare function SetLayeredWindowAttributes(byval hwnd as HWND, byval crKey as COLORREF, byval bAlpha as UBYTE, byval dwFlags as DWORD) as WINBOOL
#define LWA_COLORKEY &h00000001
#define LWA_ALPHA &h00000002
#define ULW_COLORKEY &h00000001
#define ULW_ALPHA &h00000002
#define ULW_OPAQUE &h00000004
#define ULW_EX_NORESIZE &h00000008
declare function ShowWindowAsync(byval hWnd as HWND, byval nCmdShow as long) as WINBOOL
declare function FlashWindow(byval hWnd as HWND, byval bInvert as WINBOOL) as WINBOOL

type FLASHWINFO
	cbSize as UINT
	hwnd as HWND
	dwFlags as DWORD
	uCount as UINT
	dwTimeout as DWORD
end type

type PFLASHWINFO as FLASHWINFO ptr
declare function FlashWindowEx(byval pfwi as PFLASHWINFO) as WINBOOL
#define FLASHW_STOP 0
#define FLASHW_CAPTION &h00000001
#define FLASHW_TRAY &h00000002
#define FLASHW_ALL (FLASHW_CAPTION or FLASHW_TRAY)
#define FLASHW_TIMER &h00000004
#define FLASHW_TIMERNOFG &h0000000C

declare function ShowOwnedPopups(byval hWnd as HWND, byval fShow as WINBOOL) as WINBOOL
declare function OpenIcon(byval hWnd as HWND) as WINBOOL
declare function CloseWindow(byval hWnd as HWND) as WINBOOL
declare function MoveWindow(byval hWnd as HWND, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval bRepaint as WINBOOL) as WINBOOL
declare function SetWindowPos(byval hWnd as HWND, byval hWndInsertAfter as HWND, byval X as long, byval Y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
declare function GetWindowPlacement(byval hWnd as HWND, byval lpwndpl as WINDOWPLACEMENT ptr) as WINBOOL
declare function SetWindowPlacement(byval hWnd as HWND, byval lpwndpl as const WINDOWPLACEMENT ptr) as WINBOOL
declare function BeginDeferWindowPos(byval nNumWindows as long) as HDWP
declare function DeferWindowPos(byval hWinPosInfo as HDWP, byval hWnd as HWND, byval hWndInsertAfter as HWND, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as HDWP
declare function EndDeferWindowPos(byval hWinPosInfo as HDWP) as WINBOOL
declare function IsWindowVisible(byval hWnd as HWND) as WINBOOL
declare function IsIconic(byval hWnd as HWND) as WINBOOL
declare function AnyPopup() as WINBOOL
declare function BringWindowToTop(byval hWnd as HWND) as WINBOOL
declare function IsZoomed(byval hWnd as HWND) as WINBOOL

#define SWP_NOSIZE &h0001
#define SWP_NOMOVE &h0002
#define SWP_NOZORDER &h0004
#define SWP_NOREDRAW &h0008
#define SWP_NOACTIVATE &h0010
#define SWP_FRAMECHANGED &h0020
#define SWP_SHOWWINDOW &h0040
#define SWP_HIDEWINDOW &h0080
#define SWP_NOCOPYBITS &h0100
#define SWP_NOOWNERZORDER &h0200
#define SWP_NOSENDCHANGING &h0400
#define SWP_DRAWFRAME SWP_FRAMECHANGED
#define SWP_NOREPOSITION SWP_NOOWNERZORDER
#define SWP_DEFERERASE &h2000
#define SWP_ASYNCWINDOWPOS &h4000
#define HWND_TOP cast(HWND, 0)
#define HWND_BOTTOM cast(HWND, 1)
#define HWND_TOPMOST cast(HWND, -1)
#define HWND_NOTOPMOST cast(HWND, -2)

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
	#define CreateDialogParam CreateDialogParamW
	#define CreateDialogIndirectParam CreateDialogIndirectParamW
	#define CreateDialog CreateDialogW
	#define CreateDialogIndirect CreateDialogIndirectW
	#define DialogBoxParam DialogBoxParamW
	#define DialogBoxIndirectParam DialogBoxIndirectParamW
	#define DialogBox DialogBoxW
	#define DialogBoxIndirect DialogBoxIndirectW
	#define SetDlgItemText SetDlgItemTextW
	#define GetDlgItemText GetDlgItemTextW
	#define SendDlgItemMessage SendDlgItemMessageW
	#define DefDlgProc DefDlgProcW
#else
	type LPDLGITEMTEMPLATE as LPDLGITEMTEMPLATEA
	#define CreateDialogParam CreateDialogParamA
	#define CreateDialogIndirectParam CreateDialogIndirectParamA
	#define CreateDialog CreateDialogA
	#define CreateDialogIndirect CreateDialogIndirectA
	#define DialogBoxParam DialogBoxParamA
	#define DialogBoxIndirectParam DialogBoxIndirectParamA
	#define DialogBox DialogBoxA
	#define DialogBoxIndirect DialogBoxIndirectA
	#define SetDlgItemText SetDlgItemTextA
	#define GetDlgItemText GetDlgItemTextA
	#define SendDlgItemMessage SendDlgItemMessageA
	#define DefDlgProc DefDlgProcA
#endif

declare function CreateDialogParamA(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
declare function CreateDialogParamW(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
declare function CreateDialogIndirectParamA(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND
declare function CreateDialogIndirectParamW(byval hInstance as HINSTANCE, byval lpTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as HWND

#define CreateDialogA(hInstance, lpName, hWndParent, lpDialogFunc) CreateDialogParamA(hInstance, lpName, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogW(hInstance, lpName, hWndParent, lpDialogFunc) CreateDialogParamW(hInstance, lpName, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogIndirectA(hInstance, lpTemplate, hWndParent, lpDialogFunc) CreateDialogIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define CreateDialogIndirectW(hInstance, lpTemplate, hWndParent, lpDialogFunc) CreateDialogIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))

declare function DialogBoxParamA(byval hInstance as HINSTANCE, byval lpTemplateName as LPCSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
declare function DialogBoxParamW(byval hInstance as HINSTANCE, byval lpTemplateName as LPCWSTR, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
declare function DialogBoxIndirectParamA(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEA, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR
declare function DialogBoxIndirectParamW(byval hInstance as HINSTANCE, byval hDialogTemplate as LPCDLGTEMPLATEW, byval hWndParent as HWND, byval lpDialogFunc as DLGPROC, byval dwInitParam as LPARAM) as INT_PTR

#define DialogBoxA(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxW(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxIndirectA(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxIndirectParamA(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))
#define DialogBoxIndirectW(hInstance, lpTemplate, hWndParent, lpDialogFunc) DialogBoxIndirectParamW(hInstance, lpTemplate, hWndParent, lpDialogFunc, cast(LPARAM, 0))

declare function EndDialog(byval hDlg as HWND, byval nResult as INT_PTR) as WINBOOL
declare function GetDlgItem(byval hDlg as HWND, byval nIDDlgItem as long) as HWND
declare function SetDlgItemInt(byval hDlg as HWND, byval nIDDlgItem as long, byval uValue as UINT, byval bSigned as WINBOOL) as WINBOOL
declare function GetDlgItemInt(byval hDlg as HWND, byval nIDDlgItem as long, byval lpTranslated as WINBOOL ptr, byval bSigned as WINBOOL) as UINT
declare function SetDlgItemTextA(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCSTR) as WINBOOL
declare function SetDlgItemTextW(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPCWSTR) as WINBOOL
declare function GetDlgItemTextA(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPSTR, byval cchMax as long) as UINT
declare function GetDlgItemTextW(byval hDlg as HWND, byval nIDDlgItem as long, byval lpString as LPWSTR, byval cchMax as long) as UINT
declare function CheckDlgButton(byval hDlg as HWND, byval nIDButton as long, byval uCheck as UINT) as WINBOOL
declare function CheckRadioButton(byval hDlg as HWND, byval nIDFirstButton as long, byval nIDLastButton as long, byval nIDCheckButton as long) as WINBOOL
declare function IsDlgButtonChecked(byval hDlg as HWND, byval nIDButton as long) as UINT
declare function SendDlgItemMessageA(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function SendDlgItemMessageW(byval hDlg as HWND, byval nIDDlgItem as long, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function GetNextDlgGroupItem(byval hDlg as HWND, byval hCtl as HWND, byval bPrevious as WINBOOL) as HWND
declare function GetNextDlgTabItem(byval hDlg as HWND, byval hCtl as HWND, byval bPrevious as WINBOOL) as HWND
declare function GetDlgCtrlID(byval hWnd as HWND) as long
declare function GetDialogBaseUnits() as long
declare function DefDlgProcA(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DefDlgProcW(byval hDlg as HWND, byval Msg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
#define DLGWINDOWEXTRA 30

#ifdef UNICODE
	#define CallMsgFilter CallMsgFilterW
#else
	#define CallMsgFilter CallMsgFilterA
#endif

declare function CallMsgFilterA(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL
declare function CallMsgFilterW(byval lpMsg as LPMSG, byval nCode as long) as WINBOOL

#ifdef UNICODE
	#define RegisterClipboardFormat RegisterClipboardFormatW
	#define GetClipboardFormatName GetClipboardFormatNameW
#else
	#define RegisterClipboardFormat RegisterClipboardFormatA
	#define GetClipboardFormatName GetClipboardFormatNameA
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
declare function RegisterClipboardFormatW(byval lpszFormat as LPCWSTR) as UINT
declare function CountClipboardFormats() as long
declare function EnumClipboardFormats(byval format as UINT) as UINT
declare function GetClipboardFormatNameA(byval format as UINT, byval lpszFormatName as LPSTR, byval cchMaxCount as long) as long
declare function GetClipboardFormatNameW(byval format as UINT, byval lpszFormatName as LPWSTR, byval cchMaxCount as long) as long
declare function EmptyClipboard() as WINBOOL
declare function IsClipboardFormatAvailable(byval format as UINT) as WINBOOL
declare function GetPriorityClipboardFormat(byval paFormatPriorityList as UINT ptr, byval cFormats as long) as long
declare function GetOpenClipboardWindow() as HWND

#ifdef UNICODE
	#define CharToOem CharToOemW
	#define OemToChar OemToCharW
	#define CharToOemBuff CharToOemBuffW
	#define OemToCharBuff OemToCharBuffW
	#define CharUpper CharUpperW
	#define CharUpperBuff CharUpperBuffW
	#define CharLower CharLowerW
	#define CharLowerBuff CharLowerBuffW
	#define CharNext CharNextW
	#define CharPrev CharPrevW
#else
	#define CharToOem CharToOemA
	#define OemToChar OemToCharA
	#define CharToOemBuff CharToOemBuffA
	#define OemToCharBuff OemToCharBuffA
	#define CharUpper CharUpperA
	#define CharUpperBuff CharUpperBuffA
	#define CharLower CharLowerA
	#define CharLowerBuff CharLowerBuffA
	#define CharNext CharNextA
	#define CharPrev CharPrevA
#endif

declare function CharToOemA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
declare function CharToOemW(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR) as WINBOOL
declare function OemToCharA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR) as WINBOOL
declare function OemToCharW(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR) as WINBOOL
declare function CharToOemBuffA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
declare function CharToOemBuffW(byval lpszSrc as LPCWSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
declare function OemToCharBuffA(byval lpszSrc as LPCSTR, byval lpszDst as LPSTR, byval cchDstLength as DWORD) as WINBOOL
declare function OemToCharBuffW(byval lpszSrc as LPCSTR, byval lpszDst as LPWSTR, byval cchDstLength as DWORD) as WINBOOL
declare function CharUpperA(byval lpsz as LPSTR) as LPSTR
declare function CharUpperW(byval lpsz as LPWSTR) as LPWSTR
declare function CharUpperBuffA(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
declare function CharUpperBuffW(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD
declare function CharLowerA(byval lpsz as LPSTR) as LPSTR
declare function CharLowerW(byval lpsz as LPWSTR) as LPWSTR
declare function CharLowerBuffA(byval lpsz as LPSTR, byval cchLength as DWORD) as DWORD
declare function CharLowerBuffW(byval lpsz as LPWSTR, byval cchLength as DWORD) as DWORD
declare function CharNextA(byval lpsz as LPCSTR) as LPSTR
declare function CharNextW(byval lpsz as LPCWSTR) as LPWSTR
declare function CharPrevA(byval lpszStart as LPCSTR, byval lpszCurrent as LPCSTR) as LPSTR
declare function CharPrevW(byval lpszStart as LPCWSTR, byval lpszCurrent as LPCWSTR) as LPWSTR
declare function CharNextExA(byval CodePage as WORD, byval lpCurrentChar as LPCSTR, byval dwFlags as DWORD) as LPSTR
declare function CharPrevExA(byval CodePage as WORD, byval lpStart as LPCSTR, byval lpCurrentChar as LPCSTR, byval dwFlags as DWORD) as LPSTR

#define AnsiToOem CharToOemA
#define OemToAnsi OemToCharA
#define AnsiToOemBuff CharToOemBuffA
#define OemToAnsiBuff OemToCharBuffA
#define AnsiUpper CharUpperA
#define AnsiUpperBuff CharUpperBuffA
#define AnsiLower CharLowerA
#define AnsiLowerBuff CharLowerBuffA
#define AnsiNext CharNextA
#define AnsiPrev CharPrevA

#ifdef UNICODE
	#define IsCharAlpha IsCharAlphaW
	#define IsCharAlphaNumeric IsCharAlphaNumericW
	#define IsCharUpper IsCharUpperW
	#define IsCharLower IsCharLowerW
#else
	#define IsCharAlpha IsCharAlphaA
	#define IsCharAlphaNumeric IsCharAlphaNumericA
	#define IsCharUpper IsCharUpperA
	#define IsCharLower IsCharLowerA
#endif

declare function IsCharAlphaA(byval ch as byte) as WINBOOL
declare function IsCharAlphaW(byval ch as wchar_t) as WINBOOL
declare function IsCharAlphaNumericA(byval ch as byte) as WINBOOL
declare function IsCharAlphaNumericW(byval ch as wchar_t) as WINBOOL
declare function IsCharUpperA(byval ch as byte) as WINBOOL
declare function IsCharUpperW(byval ch as wchar_t) as WINBOOL
declare function IsCharLowerA(byval ch as byte) as WINBOOL
declare function IsCharLowerW(byval ch as wchar_t) as WINBOOL

#ifdef UNICODE
	#define GetKeyNameText GetKeyNameTextW
	#define VkKeyScan VkKeyScanW
	#define VkKeyScanEx VkKeyScanExW
#else
	#define GetKeyNameText GetKeyNameTextA
	#define VkKeyScan VkKeyScanA
	#define VkKeyScanEx VkKeyScanExA
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
declare function GetKeyNameTextW(byval lParam as LONG, byval lpString as LPWSTR, byval cchSize as long) as long
declare function GetKeyboardType(byval nTypeFlag as long) as long
declare function ToAscii_ alias "ToAscii"(byval uVirtKey as UINT, byval uScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval lpChar as LPWORD, byval uFlags as UINT) as long
declare function ToAsciiEx(byval uVirtKey as UINT, byval uScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval lpChar as LPWORD, byval uFlags as UINT, byval dwhkl as HKL) as long
declare function ToUnicode(byval wVirtKey as UINT, byval wScanCode as UINT, byval lpKeyState as const UBYTE ptr, byval pwszBuff as LPWSTR, byval cchBuff as long, byval wFlags as UINT) as long
declare function OemKeyScan(byval wOemChar as WORD) as DWORD
declare function VkKeyScanA(byval ch as byte) as SHORT
declare function VkKeyScanW(byval ch as wchar_t) as SHORT
declare function VkKeyScanExA(byval ch as byte, byval dwhkl as HKL) as SHORT
declare function VkKeyScanExW(byval ch as wchar_t, byval dwhkl as HKL) as SHORT

#define KEYEVENTF_EXTENDEDKEY &h0001
#define KEYEVENTF_KEYUP &h0002
#define KEYEVENTF_UNICODE &h0004
#define KEYEVENTF_SCANCODE &h0008
declare sub keybd_event(byval bVk as UBYTE, byval bScan as UBYTE, byval dwFlags as DWORD, byval dwExtraInfo as ULONG_PTR)
#define MOUSEEVENTF_MOVE &h0001
#define MOUSEEVENTF_LEFTDOWN &h0002
#define MOUSEEVENTF_LEFTUP &h0004
#define MOUSEEVENTF_RIGHTDOWN &h0008
#define MOUSEEVENTF_RIGHTUP &h0010
#define MOUSEEVENTF_MIDDLEDOWN &h0020
#define MOUSEEVENTF_MIDDLEUP &h0040
#define MOUSEEVENTF_XDOWN &h0080
#define MOUSEEVENTF_XUP &h0100
#define MOUSEEVENTF_WHEEL &h0800
#define MOUSEEVENTF_VIRTUALDESK &h4000
#define MOUSEEVENTF_ABSOLUTE &h8000
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

#define INPUT_MOUSE 0
#define INPUT_KEYBOARD 1
#define INPUT_HARDWARE 2

type tagINPUT
	as DWORD type

	union
		mi as MOUSEINPUT
		ki as KEYBDINPUT
		hi as HARDWAREINPUT
	end union
end type

type INPUT as tagINPUT
type PINPUT as tagINPUT ptr
type LPINPUT as tagINPUT ptr
declare function SendInput(byval cInputs as UINT, byval pInputs as LPINPUT, byval cbSize as long) as UINT

type tagLASTINPUTINFO
	cbSize as UINT
	dwTime as DWORD
end type

type LASTINPUTINFO as tagLASTINPUTINFO
type PLASTINPUTINFO as tagLASTINPUTINFO ptr

#ifdef UNICODE
	#define MapVirtualKey MapVirtualKeyW
	#define MapVirtualKeyEx MapVirtualKeyExW
#else
	#define MapVirtualKey MapVirtualKeyA
	#define MapVirtualKeyEx MapVirtualKeyExA
#endif

declare function GetLastInputInfo(byval plii as PLASTINPUTINFO) as WINBOOL
declare function MapVirtualKeyA(byval uCode as UINT, byval uMapType as UINT) as UINT
declare function MapVirtualKeyW(byval uCode as UINT, byval uMapType as UINT) as UINT
declare function MapVirtualKeyExA(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT
declare function MapVirtualKeyExW(byval uCode as UINT, byval uMapType as UINT, byval dwhkl as HKL) as UINT
declare function GetInputState() as WINBOOL
declare function GetQueueStatus(byval flags as UINT) as DWORD
declare function GetCapture() as HWND
declare function SetCapture(byval hWnd as HWND) as HWND
declare function ReleaseCapture() as WINBOOL
declare function MsgWaitForMultipleObjects(byval nCount as DWORD, byval pHandles as const HANDLE ptr, byval fWaitAll as WINBOOL, byval dwMilliseconds as DWORD, byval dwWakeMask as DWORD) as DWORD
declare function MsgWaitForMultipleObjectsEx(byval nCount as DWORD, byval pHandles as const HANDLE ptr, byval dwMilliseconds as DWORD, byval dwWakeMask as DWORD, byval dwFlags as DWORD) as DWORD

#define MWMO_WAITALL &h0001
#define MWMO_ALERTABLE &h0002
#define MWMO_INPUTAVAILABLE &h0004
#define QS_KEY &h0001
#define QS_MOUSEMOVE &h0002
#define QS_MOUSEBUTTON &h0004
#define QS_POSTMESSAGE &h0008
#define QS_TIMER &h0010
#define QS_PAINT &h0020
#define QS_SENDMESSAGE &h0040
#define QS_HOTKEY &h0080
#define QS_ALLPOSTMESSAGE &h0100
#define QS_RAWINPUT &h0400
#define QS_MOUSE (QS_MOUSEMOVE or QS_MOUSEBUTTON)
#define QS_INPUT ((QS_MOUSE or QS_KEY) or QS_RAWINPUT)
#define QS_ALLEVENTS ((((QS_INPUT or QS_POSTMESSAGE) or QS_TIMER) or QS_PAINT) or QS_HOTKEY)
#define QS_ALLINPUT (((((QS_INPUT or QS_POSTMESSAGE) or QS_TIMER) or QS_PAINT) or QS_HOTKEY) or QS_SENDMESSAGE)
#define USER_TIMER_MAXIMUM &h7FFFFFFF
#define USER_TIMER_MINIMUM &h0000000A

#ifdef UNICODE
	#define LoadAccelerators LoadAcceleratorsW
	#define CreateAcceleratorTable CreateAcceleratorTableW
	#define CopyAcceleratorTable CopyAcceleratorTableW
#else
	#define LoadAccelerators LoadAcceleratorsA
	#define CreateAcceleratorTable CreateAcceleratorTableA
	#define CopyAcceleratorTable CopyAcceleratorTableA
#endif

declare function SetTimer(byval hWnd as HWND, byval nIDEvent as UINT_PTR, byval uElapse as UINT, byval lpTimerFunc as TIMERPROC) as UINT_PTR
declare function KillTimer(byval hWnd as HWND, byval uIDEvent as UINT_PTR) as WINBOOL
declare function IsWindowUnicode(byval hWnd as HWND) as WINBOOL
declare function EnableWindow(byval hWnd as HWND, byval bEnable as WINBOOL) as WINBOOL
declare function IsWindowEnabled(byval hWnd as HWND) as WINBOOL
declare function LoadAcceleratorsA(byval hInstance as HINSTANCE, byval lpTableName as LPCSTR) as HACCEL
declare function LoadAcceleratorsW(byval hInstance as HINSTANCE, byval lpTableName as LPCWSTR) as HACCEL
declare function CreateAcceleratorTableA(byval paccel as LPACCEL, byval cAccel as long) as HACCEL
declare function CreateAcceleratorTableW(byval paccel as LPACCEL, byval cAccel as long) as HACCEL
declare function DestroyAcceleratorTable(byval hAccel as HACCEL) as WINBOOL
declare function CopyAcceleratorTableA(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long
declare function CopyAcceleratorTableW(byval hAccelSrc as HACCEL, byval lpAccelDst as LPACCEL, byval cAccelEntries as long) as long

#ifdef UNICODE
	#define TranslateAccelerator TranslateAcceleratorW
#else
	#define TranslateAccelerator TranslateAcceleratorA
#endif

declare function TranslateAcceleratorA(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long
declare function TranslateAcceleratorW(byval hWnd as HWND, byval hAccTable as HACCEL, byval lpMsg as LPMSG) as long
#define SM_CXSCREEN 0
#define SM_CYSCREEN 1
#define SM_CXVSCROLL 2
#define SM_CYHSCROLL 3
#define SM_CYCAPTION 4
#define SM_CXBORDER 5
#define SM_CYBORDER 6
#define SM_CXDLGFRAME 7
#define SM_CYDLGFRAME 8
#define SM_CYVTHUMB 9
#define SM_CXHTHUMB 10
#define SM_CXICON 11
#define SM_CYICON 12
#define SM_CXCURSOR 13
#define SM_CYCURSOR 14
#define SM_CYMENU 15
#define SM_CXFULLSCREEN 16
#define SM_CYFULLSCREEN 17
#define SM_CYKANJIWINDOW 18
#define SM_MOUSEPRESENT 19
#define SM_CYVSCROLL 20
#define SM_CXHSCROLL 21
#define SM_DEBUG 22
#define SM_SWAPBUTTON 23
#define SM_RESERVED1 24
#define SM_RESERVED2 25
#define SM_RESERVED3 26
#define SM_RESERVED4 27
#define SM_CXMIN 28
#define SM_CYMIN 29
#define SM_CXSIZE 30
#define SM_CYSIZE 31
#define SM_CXFRAME 32
#define SM_CYFRAME 33
#define SM_CXMINTRACK 34
#define SM_CYMINTRACK 35
#define SM_CXDOUBLECLK 36
#define SM_CYDOUBLECLK 37
#define SM_CXICONSPACING 38
#define SM_CYICONSPACING 39
#define SM_MENUDROPALIGNMENT 40
#define SM_PENWINDOWS 41
#define SM_DBCSENABLED 42
#define SM_CMOUSEBUTTONS 43
#define SM_CXFIXEDFRAME SM_CXDLGFRAME
#define SM_CYFIXEDFRAME SM_CYDLGFRAME
#define SM_CXSIZEFRAME SM_CXFRAME
#define SM_CYSIZEFRAME SM_CYFRAME
#define SM_SECURE 44
#define SM_CXEDGE 45
#define SM_CYEDGE 46
#define SM_CXMINSPACING 47
#define SM_CYMINSPACING 48
#define SM_CXSMICON 49
#define SM_CYSMICON 50
#define SM_CYSMCAPTION 51
#define SM_CXSMSIZE 52
#define SM_CYSMSIZE 53
#define SM_CXMENUSIZE 54
#define SM_CYMENUSIZE 55
#define SM_ARRANGE 56
#define SM_CXMINIMIZED 57
#define SM_CYMINIMIZED 58
#define SM_CXMAXTRACK 59
#define SM_CYMAXTRACK 60
#define SM_CXMAXIMIZED 61
#define SM_CYMAXIMIZED 62
#define SM_NETWORK 63
#define SM_CLEANBOOT 67
#define SM_CXDRAG 68
#define SM_CYDRAG 69
#define SM_SHOWSOUNDS 70
#define SM_CXMENUCHECK 71
#define SM_CYMENUCHECK 72
#define SM_SLOWMACHINE 73
#define SM_MIDEASTENABLED 74
#define SM_MOUSEWHEELPRESENT 75
#define SM_XVIRTUALSCREEN 76
#define SM_YVIRTUALSCREEN 77
#define SM_CXVIRTUALSCREEN 78
#define SM_CYVIRTUALSCREEN 79
#define SM_CMONITORS 80
#define SM_SAMEDISPLAYFORMAT 81
#define SM_IMMENABLED 82
#define SM_CXFOCUSBORDER 83
#define SM_CYFOCUSBORDER 84
#define SM_TABLETPC 86
#define SM_MEDIACENTER 87
#define SM_STARTER 88
#define SM_SERVERR2 89

#if (_WIN32_WINNT = &h0400) or (_WIN32_WINNT = &h0502)
	#define SM_CMETRICS 90
#endif

#define SM_REMOTESESSION &h1000
#define SM_SHUTTINGDOWN &h2000
#define SM_REMOTECONTROL &h2001
#define SM_CARETBLINKINGENABLED &h2002

#if _WIN32_WINNT = &h0602
	#define SM_MOUSEHORIZONTALWHEELPRESENT 91
	#define SM_CXPADDEDBORDER 92
	#define SM_DIGITIZER 94
	#define SM_MAXIMUMTOUCHES 95
	#define SM_CMETRICS 96
	#define NID_INTEGRATED_TOUCH &h01
	#define NID_EXTERNAL_TOUCH &h02
	#define NID_INTEGRATED_PEN &h04
	#define NID_EXTERNAL_PEN &h08
	#define NID_MULTI_INPUT &h40
	#define NID_READY &h80
#endif

declare function GetSystemMetrics(byval nIndex as long) as long

#ifdef UNICODE
	#define LoadMenu LoadMenuW
	#define LoadMenuIndirect LoadMenuIndirectW
	#define ChangeMenu ChangeMenuW
	#define GetMenuString GetMenuStringW
	#define InsertMenu InsertMenuW
	#define AppendMenu AppendMenuW
	#define ModifyMenu ModifyMenuW
#else
	#define LoadMenu LoadMenuA
	#define LoadMenuIndirect LoadMenuIndirectA
	#define ChangeMenu ChangeMenuA
	#define GetMenuString GetMenuStringA
	#define InsertMenu InsertMenuA
	#define AppendMenu AppendMenuA
	#define ModifyMenu ModifyMenuA
#endif

declare function LoadMenuA(byval hInstance as HINSTANCE, byval lpMenuName as LPCSTR) as HMENU
declare function LoadMenuW(byval hInstance as HINSTANCE, byval lpMenuName as LPCWSTR) as HMENU
declare function LoadMenuIndirectA(byval lpMenuTemplate as const MENUTEMPLATEA ptr) as HMENU
declare function LoadMenuIndirectW(byval lpMenuTemplate as const MENUTEMPLATEW ptr) as HMENU
declare function GetMenu(byval hWnd as HWND) as HMENU
declare function SetMenu(byval hWnd as HWND, byval hMenu as HMENU) as WINBOOL
declare function ChangeMenuA(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL
declare function ChangeMenuW(byval hMenu as HMENU, byval cmd as UINT, byval lpszNewItem as LPCWSTR, byval cmdInsert as UINT, byval flags as UINT) as WINBOOL
declare function HiliteMenuItem(byval hWnd as HWND, byval hMenu as HMENU, byval uIDHiliteItem as UINT, byval uHilite as UINT) as WINBOOL
declare function GetMenuStringA(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPSTR, byval cchMax as long, byval flags as UINT) as long
declare function GetMenuStringW(byval hMenu as HMENU, byval uIDItem as UINT, byval lpString as LPWSTR, byval cchMax as long, byval flags as UINT) as long
declare function GetMenuState(byval hMenu as HMENU, byval uId as UINT, byval uFlags as UINT) as UINT
declare function DrawMenuBar(byval hWnd as HWND) as WINBOOL
#define PMB_ACTIVE &h00000001
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
declare function InsertMenuW(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
declare function AppendMenuA(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL
declare function AppendMenuW(byval hMenu as HMENU, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
declare function ModifyMenuA(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCSTR) as WINBOOL
declare function ModifyMenuW(byval hMnu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval uIDNewItem as UINT_PTR, byval lpNewItem as LPCWSTR) as WINBOOL
declare function RemoveMenu(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT) as WINBOOL
declare function DeleteMenu(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT) as WINBOOL
declare function SetMenuItemBitmaps(byval hMenu as HMENU, byval uPosition as UINT, byval uFlags as UINT, byval hBitmapUnchecked as HBITMAP, byval hBitmapChecked as HBITMAP) as WINBOOL
declare function GetMenuCheckMarkDimensions() as LONG
declare function TrackPopupMenu(byval hMenu as HMENU, byval uFlags as UINT, byval x as long, byval y as long, byval nReserved as long, byval hWnd as HWND, byval prcRect as const RECT ptr) as WINBOOL

#define MNC_IGNORE 0
#define MNC_CLOSE 1
#define MNC_EXECUTE 2
#define MNC_SELECT 3

type tagTPMPARAMS
	cbSize as UINT
	rcExclude as RECT
end type

type TPMPARAMS as tagTPMPARAMS
type LPTPMPARAMS as TPMPARAMS ptr
declare function TrackPopupMenuEx(byval as HMENU, byval as UINT, byval as long, byval as long, byval as HWND, byval as LPTPMPARAMS) as WINBOOL
#define MNS_NOCHECK &h80000000
#define MNS_MODELESS &h40000000
#define MNS_DRAGDROP &h20000000
#define MNS_AUTODISMISS &h10000000
#define MNS_NOTIFYBYPOS &h08000000
#define MNS_CHECKORBMP &h04000000
#define MIM_MAXHEIGHT &h00000001
#define MIM_BACKGROUND &h00000002
#define MIM_HELPID &h00000004
#define MIM_MENUDATA &h00000008
#define MIM_STYLE &h00000010
#define MIM_APPLYTOSUBMENUS &h80000000

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
type LPCMENUINFO as const MENUINFO ptr

declare function GetMenuInfo(byval as HMENU, byval as LPMENUINFO) as WINBOOL
declare function SetMenuInfo(byval as HMENU, byval as LPCMENUINFO) as WINBOOL
declare function EndMenu() as WINBOOL
#define MND_CONTINUE 0
#define MND_ENDMENU 1

type tagMENUGETOBJECTINFO
	dwFlags as DWORD
	uPos as UINT
	hmenu as HMENU
	riid as PVOID
	pvObj as PVOID
end type

type MENUGETOBJECTINFO as tagMENUGETOBJECTINFO
type PMENUGETOBJECTINFO as tagMENUGETOBJECTINFO ptr
#define MNGOF_TOPGAP &h00000001
#define MNGOF_BOTTOMGAP &h00000002
#define MNGO_NOINTERFACE &h00000000
#define MNGO_NOERROR &h00000001
#define MIIM_STATE &h00000001
#define MIIM_ID &h00000002
#define MIIM_SUBMENU &h00000004
#define MIIM_CHECKMARKS &h00000008
#define MIIM_TYPE &h00000010
#define MIIM_DATA &h00000020
#define MIIM_STRING &h00000040
#define MIIM_BITMAP &h00000080
#define MIIM_FTYPE &h00000100
#define HBMMENU_CALLBACK cast(HBITMAP, -1)
#define HBMMENU_SYSTEM cast(HBITMAP, 1)
#define HBMMENU_MBAR_RESTORE cast(HBITMAP, 2)
#define HBMMENU_MBAR_MINIMIZE cast(HBITMAP, 3)
#define HBMMENU_MBAR_CLOSE cast(HBITMAP, 5)
#define HBMMENU_MBAR_CLOSE_D cast(HBITMAP, 6)
#define HBMMENU_MBAR_MINIMIZE_D cast(HBITMAP, 7)
#define HBMMENU_POPUP_CLOSE cast(HBITMAP, 8)
#define HBMMENU_POPUP_RESTORE cast(HBITMAP, 9)
#define HBMMENU_POPUP_MAXIMIZE cast(HBITMAP, 10)
#define HBMMENU_POPUP_MINIMIZE cast(HBITMAP, 11)

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
	#define InsertMenuItem InsertMenuItemW
	#define GetMenuItemInfo GetMenuItemInfoW
	#define SetMenuItemInfo SetMenuItemInfoW
#else
	type LPCMENUITEMINFO as LPCMENUITEMINFOA
	#define InsertMenuItem InsertMenuItemA
	#define GetMenuItemInfo GetMenuItemInfoA
	#define SetMenuItemInfo SetMenuItemInfoA
#endif

declare function InsertMenuItemA(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOA) as WINBOOL
declare function InsertMenuItemW(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmi as LPCMENUITEMINFOW) as WINBOOL
declare function GetMenuItemInfoA(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOA) as WINBOOL
declare function GetMenuItemInfoW(byval hmenu as HMENU, byval item as UINT, byval fByPosition as WINBOOL, byval lpmii as LPMENUITEMINFOW) as WINBOOL
declare function SetMenuItemInfoA(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOA) as WINBOOL
declare function SetMenuItemInfoW(byval hmenu as HMENU, byval item as UINT, byval fByPositon as WINBOOL, byval lpmii as LPCMENUITEMINFOW) as WINBOOL
#define GMDI_USEDISABLED __MSABI_LONG(&h0001)
#define GMDI_GOINTOPOPUPS __MSABI_LONG(&h0002)
declare function GetMenuDefaultItem(byval hMenu as HMENU, byval fByPos as UINT, byval gmdiFlags as UINT) as UINT
declare function SetMenuDefaultItem(byval hMenu as HMENU, byval uItem as UINT, byval fByPos as UINT) as WINBOOL
declare function GetMenuItemRect(byval hWnd as HWND, byval hMenu as HMENU, byval uItem as UINT, byval lprcItem as LPRECT) as WINBOOL
declare function MenuItemFromPoint(byval hWnd as HWND, byval hMenu as HMENU, byval ptScreen as POINT) as long

#define TPM_LEFTBUTTON __MSABI_LONG(&h0000)
#define TPM_RIGHTBUTTON __MSABI_LONG(&h0002)
#define TPM_LEFTALIGN __MSABI_LONG(&h0000)
#define TPM_CENTERALIGN __MSABI_LONG(&h0004)
#define TPM_RIGHTALIGN __MSABI_LONG(&h0008)
#define TPM_TOPALIGN __MSABI_LONG(&h0000)
#define TPM_VCENTERALIGN __MSABI_LONG(&h0010)
#define TPM_BOTTOMALIGN __MSABI_LONG(&h0020)
#define TPM_HORIZONTAL __MSABI_LONG(&h0000)
#define TPM_VERTICAL __MSABI_LONG(&h0040)
#define TPM_NONOTIFY __MSABI_LONG(&h0080)
#define TPM_RETURNCMD __MSABI_LONG(&h0100)
#define TPM_RECURSE __MSABI_LONG(&h0001)
#define TPM_HORPOSANIMATION __MSABI_LONG(&h0400)
#define TPM_HORNEGANIMATION __MSABI_LONG(&h0800)
#define TPM_VERPOSANIMATION __MSABI_LONG(&h1000)
#define TPM_VERNEGANIMATION __MSABI_LONG(&h2000)
#define TPM_NOANIMATION __MSABI_LONG(&h4000)
#define TPM_LAYOUTRTL __MSABI_LONG(&h8000)

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

#define DOF_EXECUTABLE &h8001
#define DOF_DOCUMENT &h8002
#define DOF_DIRECTORY &h8003
#define DOF_MULTIPLE &h8004
#define DOF_PROGMAN &h0001
#define DOF_SHELLDATA &h0002
#define DO_DROPFILE __MSABI_LONG(&h454C4946)
#define DO_PRINTFILE __MSABI_LONG(&h544E5250)

declare function DragObject(byval hwndParent as HWND, byval hwndFrom as HWND, byval fmt as UINT, byval data as ULONG_PTR, byval hcur as HCURSOR) as DWORD
declare function DragDetect(byval hwnd as HWND, byval pt as POINT) as WINBOOL
declare function DrawIcon(byval hDC as HDC, byval X as long, byval Y as long, byval hIcon as HICON) as WINBOOL

#define DT_TOP &h00000000
#define DT_LEFT &h00000000
#define DT_CENTER &h00000001
#define DT_RIGHT &h00000002
#define DT_VCENTER &h00000004
#define DT_BOTTOM &h00000008
#define DT_WORDBREAK &h00000010
#define DT_SINGLELINE &h00000020
#define DT_EXPANDTABS &h00000040
#define DT_TABSTOP &h00000080
#define DT_NOCLIP &h00000100
#define DT_EXTERNALLEADING &h00000200
#define DT_CALCRECT &h00000400
#define DT_NOPREFIX &h00000800
#define DT_INTERNAL &h00001000
#define DT_EDITCONTROL &h00002000
#define DT_PATH_ELLIPSIS &h00004000
#define DT_END_ELLIPSIS &h00008000
#define DT_MODIFYSTRING &h00010000
#define DT_RTLREADING &h00020000
#define DT_WORD_ELLIPSIS &h00040000
#define DT_NOFULLWIDTHCHARBREAK &h00080000
#define DT_HIDEPREFIX &h00100000
#define DT_PREFIXONLY &h00200000

type tagDRAWTEXTPARAMS
	cbSize as UINT
	iTabLength as long
	iLeftMargin as long
	iRightMargin as long
	uiLengthDrawn as UINT
end type

type DRAWTEXTPARAMS as tagDRAWTEXTPARAMS
type LPDRAWTEXTPARAMS as tagDRAWTEXTPARAMS ptr

#ifdef UNICODE
	#define DrawText DrawTextW
	#define DrawTextEx DrawTextExW
#else
	#define DrawText DrawTextA
	#define DrawTextEx DrawTextExA
#endif

declare function DrawTextA(byval hdc as HDC, byval lpchText as LPCSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long
declare function DrawTextW(byval hdc as HDC, byval lpchText as LPCWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT) as long
declare function DrawTextExA(byval hdc as HDC, byval lpchText as LPSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long
declare function DrawTextExW(byval hdc as HDC, byval lpchText as LPWSTR, byval cchText as long, byval lprc as LPRECT, byval format as UINT, byval lpdtp as LPDRAWTEXTPARAMS) as long

#ifdef UNICODE
	#define GrayString GrayStringW
	#define DrawState DrawStateW
	#define TabbedTextOut TabbedTextOutW
	#define GetTabbedTextExtent GetTabbedTextExtentW
#else
	#define GrayString GrayStringA
	#define DrawState DrawStateA
	#define TabbedTextOut TabbedTextOutA
	#define GetTabbedTextExtent GetTabbedTextExtentA
#endif

declare function GrayStringA(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL
declare function GrayStringW(byval hDC as HDC, byval hBrush as HBRUSH, byval lpOutputFunc as GRAYSTRINGPROC, byval lpData as LPARAM, byval nCount as long, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long) as WINBOOL
#define DST_COMPLEX &h0000
#define DST_TEXT &h0001
#define DST_PREFIXTEXT &h0002
#define DST_ICON &h0003
#define DST_BITMAP &h0004
#define DSS_NORMAL &h0000
#define DSS_UNION &h0010
#define DSS_DISABLED &h0020
#define DSS_MONO &h0080
#define DSS_HIDEPREFIX &h0200
#define DSS_PREFIXONLY &h0400
#define DSS_RIGHT &h8000

declare function DrawStateA(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
declare function DrawStateW(byval hdc as HDC, byval hbrFore as HBRUSH, byval qfnCallBack as DRAWSTATEPROC, byval lData as LPARAM, byval wData as WPARAM, byval x as long, byval y as long, byval cx as long, byval cy as long, byval uFlags as UINT) as WINBOOL
declare function TabbedTextOutA(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG
declare function TabbedTextOutW(byval hdc as HDC, byval x as long, byval y as long, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr, byval nTabOrigin as long) as LONG
declare function GetTabbedTextExtentA(byval hdc as HDC, byval lpString as LPCSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD
declare function GetTabbedTextExtentW(byval hdc as HDC, byval lpString as LPCWSTR, byval chCount as long, byval nTabPositions as long, byval lpnTabStopPositions as const INT_ ptr) as DWORD
declare function UpdateWindow(byval hWnd as HWND) as WINBOOL
declare function SetActiveWindow(byval hWnd as HWND) as HWND
declare function GetForegroundWindow() as HWND
declare function PaintDesktop(byval hdc as HDC) as WINBOOL
declare sub SwitchToThisWindow(byval hwnd as HWND, byval fUnknown as WINBOOL)
declare function SetForegroundWindow(byval hWnd as HWND) as WINBOOL
declare function AllowSetForegroundWindow(byval dwProcessId as DWORD) as WINBOOL
#define ASFW_ANY cast(DWORD, -1)
declare function LockSetForegroundWindow(byval uLockCode as UINT) as WINBOOL
#define LSFW_LOCK 1
#define LSFW_UNLOCK 2
declare function WindowFromDC(byval hDC as HDC) as HWND
declare function GetDC(byval hWnd as HWND) as HDC
declare function GetDCEx(byval hWnd as HWND, byval hrgnClip as HRGN, byval flags as DWORD) as HDC

#define DCX_WINDOW __MSABI_LONG(&h00000001)
#define DCX_CACHE __MSABI_LONG(&h00000002)
#define DCX_NORESETATTRS __MSABI_LONG(&h00000004)
#define DCX_CLIPCHILDREN __MSABI_LONG(&h00000008)
#define DCX_CLIPSIBLINGS __MSABI_LONG(&h00000010)
#define DCX_PARENTCLIP __MSABI_LONG(&h00000020)
#define DCX_EXCLUDERGN __MSABI_LONG(&h00000040)
#define DCX_INTERSECTRGN __MSABI_LONG(&h00000080)
#define DCX_EXCLUDEUPDATE __MSABI_LONG(&h00000100)
#define DCX_INTERSECTUPDATE __MSABI_LONG(&h00000200)
#define DCX_LOCKWINDOWUPDATE __MSABI_LONG(&h00000400)
#define DCX_VALIDATE __MSABI_LONG(&h00200000)

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

#define RDW_INVALIDATE &h0001
#define RDW_INTERNALPAINT &h0002
#define RDW_ERASE &h0004
#define RDW_VALIDATE &h0008
#define RDW_NOINTERNALPAINT &h0010
#define RDW_NOERASE &h0020
#define RDW_NOCHILDREN &h0040
#define RDW_ALLCHILDREN &h0080
#define RDW_UPDATENOW &h0100
#define RDW_ERASENOW &h0200
#define RDW_FRAME &h0400
#define RDW_NOFRAME &h0800

declare function LockWindowUpdate(byval hWndLock as HWND) as WINBOOL
declare function ScrollWindow(byval hWnd as HWND, byval XAmount as long, byval YAmount as long, byval lpRect as const RECT ptr, byval lpClipRect as const RECT ptr) as WINBOOL
declare function ScrollDC(byval hDC as HDC, byval dx as long, byval dy as long, byval lprcScroll as const RECT ptr, byval lprcClip as const RECT ptr, byval hrgnUpdate as HRGN, byval lprcUpdate as LPRECT) as WINBOOL
declare function ScrollWindowEx(byval hWnd as HWND, byval dx as long, byval dy as long, byval prcScroll as const RECT ptr, byval prcClip as const RECT ptr, byval hrgnUpdate as HRGN, byval prcUpdate as LPRECT, byval flags as UINT) as long

#define SW_SCROLLCHILDREN &h0001
#define SW_INVALIDATE &h0002
#define SW_ERASE &h0004
#define SW_SMOOTHSCROLL &h0010

declare function SetScrollPos(byval hWnd as HWND, byval nBar as long, byval nPos as long, byval bRedraw as WINBOOL) as long
declare function GetScrollPos(byval hWnd as HWND, byval nBar as long) as long
declare function SetScrollRange(byval hWnd as HWND, byval nBar as long, byval nMinPos as long, byval nMaxPos as long, byval bRedraw as WINBOOL) as WINBOOL
declare function GetScrollRange(byval hWnd as HWND, byval nBar as long, byval lpMinPos as LPINT, byval lpMaxPos as LPINT) as WINBOOL
declare function ShowScrollBar(byval hWnd as HWND, byval wBar as long, byval bShow as WINBOOL) as WINBOOL
declare function EnableScrollBar(byval hWnd as HWND, byval wSBflags as UINT, byval wArrows as UINT) as WINBOOL

#define ESB_ENABLE_BOTH &h0000
#define ESB_DISABLE_BOTH &h0003
#define ESB_DISABLE_LEFT &h0001
#define ESB_DISABLE_RIGHT &h0002
#define ESB_DISABLE_UP &h0001
#define ESB_DISABLE_DOWN &h0002
#define ESB_DISABLE_LTUP ESB_DISABLE_LEFT
#define ESB_DISABLE_RTDN ESB_DISABLE_RIGHT

#ifdef UNICODE
	#define SetProp SetPropW
	#define GetProp GetPropW
	#define RemoveProp RemovePropW
	#define EnumPropsEx EnumPropsExW
	#define EnumProps EnumPropsW
	#define SetWindowText SetWindowTextW
	#define GetWindowText GetWindowTextW
	#define GetWindowTextLength GetWindowTextLengthW
#else
	#define SetProp SetPropA
	#define GetProp GetPropA
	#define RemoveProp RemovePropA
	#define EnumPropsEx EnumPropsExA
	#define EnumProps EnumPropsA
	#define SetWindowText SetWindowTextA
	#define GetWindowText GetWindowTextA
	#define GetWindowTextLength GetWindowTextLengthA
#endif

declare function SetPropA(byval hWnd as HWND, byval lpString as LPCSTR, byval hData as HANDLE) as WINBOOL
declare function SetPropW(byval hWnd as HWND, byval lpString as LPCWSTR, byval hData as HANDLE) as WINBOOL
declare function GetPropA(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE
declare function GetPropW(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE
declare function RemovePropA(byval hWnd as HWND, byval lpString as LPCSTR) as HANDLE
declare function RemovePropW(byval hWnd as HWND, byval lpString as LPCWSTR) as HANDLE
declare function EnumPropsExA(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXA, byval lParam as LPARAM) as long
declare function EnumPropsExW(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCEXW, byval lParam as LPARAM) as long
declare function EnumPropsA(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCA) as long
declare function EnumPropsW(byval hWnd as HWND, byval lpEnumFunc as PROPENUMPROCW) as long
declare function SetWindowTextA(byval hWnd as HWND, byval lpString as LPCSTR) as WINBOOL
declare function SetWindowTextW(byval hWnd as HWND, byval lpString as LPCWSTR) as WINBOOL
declare function GetWindowTextA(byval hWnd as HWND, byval lpString as LPSTR, byval nMaxCount as long) as long
declare function GetWindowTextW(byval hWnd as HWND, byval lpString as LPWSTR, byval nMaxCount as long) as long
declare function GetWindowTextLengthA(byval hWnd as HWND) as long
declare function GetWindowTextLengthW(byval hWnd as HWND) as long
declare function GetClientRect(byval hWnd as HWND, byval lpRect as LPRECT) as WINBOOL
declare function GetWindowRect(byval hWnd as HWND, byval lpRect as LPRECT) as WINBOOL
declare function AdjustWindowRect(byval lpRect as LPRECT, byval dwStyle as DWORD, byval bMenu as WINBOOL) as WINBOOL
declare function AdjustWindowRectEx(byval lpRect as LPRECT, byval dwStyle as DWORD, byval bMenu as WINBOOL, byval dwExStyle as DWORD) as WINBOOL
#define HELPINFO_WINDOW &h0001
#define HELPINFO_MENUITEM &h0002

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

#define MB_OK __MSABI_LONG(&h00000000)
#define MB_OKCANCEL __MSABI_LONG(&h00000001)
#define MB_ABORTRETRYIGNORE __MSABI_LONG(&h00000002)
#define MB_YESNOCANCEL __MSABI_LONG(&h00000003)
#define MB_YESNO __MSABI_LONG(&h00000004)
#define MB_RETRYCANCEL __MSABI_LONG(&h00000005)
#define MB_CANCELTRYCONTINUE __MSABI_LONG(&h00000006)
#define MB_ICONHAND __MSABI_LONG(&h00000010)
#define MB_ICONQUESTION __MSABI_LONG(&h00000020)
#define MB_ICONEXCLAMATION __MSABI_LONG(&h00000030)
#define MB_ICONASTERISK __MSABI_LONG(&h00000040)
#define MB_USERICON __MSABI_LONG(&h00000080)
#define MB_ICONWARNING MB_ICONEXCLAMATION
#define MB_ICONERROR MB_ICONHAND
#define MB_ICONINFORMATION MB_ICONASTERISK
#define MB_ICONSTOP MB_ICONHAND
#define MB_DEFBUTTON1 __MSABI_LONG(&h00000000)
#define MB_DEFBUTTON2 __MSABI_LONG(&h00000100)
#define MB_DEFBUTTON3 __MSABI_LONG(&h00000200)
#define MB_DEFBUTTON4 __MSABI_LONG(&h00000300)
#define MB_APPLMODAL __MSABI_LONG(&h00000000)
#define MB_SYSTEMMODAL __MSABI_LONG(&h00001000)
#define MB_TASKMODAL __MSABI_LONG(&h00002000)
#define MB_HELP __MSABI_LONG(&h00004000)
#define MB_NOFOCUS __MSABI_LONG(&h00008000)
#define MB_SETFOREGROUND __MSABI_LONG(&h00010000)
#define MB_DEFAULT_DESKTOP_ONLY __MSABI_LONG(&h00020000)
#define MB_TOPMOST __MSABI_LONG(&h00040000)
#define MB_RIGHT __MSABI_LONG(&h00080000)
#define MB_RTLREADING __MSABI_LONG(&h00100000)
#define MB_SERVICE_NOTIFICATION __MSABI_LONG(&h00200000)
#define MB_SERVICE_NOTIFICATION_NT3X __MSABI_LONG(&h00040000)
#define MB_TYPEMASK __MSABI_LONG(&h0000000F)
#define MB_ICONMASK __MSABI_LONG(&h000000F0)
#define MB_DEFMASK __MSABI_LONG(&h00000F00)
#define MB_MODEMASK __MSABI_LONG(&h00003000)
#define MB_MISCMASK __MSABI_LONG(&h0000C000)

#ifdef UNICODE
	#define MessageBox MessageBoxW
	#define MessageBoxEx MessageBoxExW
#else
	#define MessageBox MessageBoxA
	#define MessageBoxEx MessageBoxExA
#endif

declare function MessageBoxA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT) as long
declare function MessageBoxW(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT) as long
declare function MessageBoxExA(byval hWnd as HWND, byval lpText as LPCSTR, byval lpCaption as LPCSTR, byval uType as UINT, byval wLanguageId as WORD) as long
declare function MessageBoxExW(byval hWnd as HWND, byval lpText as LPCWSTR, byval lpCaption as LPCWSTR, byval uType as UINT, byval wLanguageId as WORD) as long
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
	#define MessageBoxIndirect MessageBoxIndirectW
#else
	type MSGBOXPARAMS as MSGBOXPARAMSA
	type PMSGBOXPARAMS as PMSGBOXPARAMSA
	type LPMSGBOXPARAMS as LPMSGBOXPARAMSA
	#define MessageBoxIndirect MessageBoxIndirectA
#endif

declare function MessageBoxIndirectA(byval lpmbp as const MSGBOXPARAMSA ptr) as long
declare function MessageBoxIndirectW(byval lpmbp as const MSGBOXPARAMSW ptr) as long
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

#define CWP_ALL &h0000
#define CWP_SKIPINVISIBLE &h0001
#define CWP_SKIPDISABLED &h0002
#define CWP_SKIPTRANSPARENT &h0004
declare function ChildWindowFromPointEx(byval hwnd as HWND, byval pt as POINT, byval flags as UINT) as HWND
#define CTLCOLOR_MSGBOX 0
#define CTLCOLOR_EDIT 1
#define CTLCOLOR_LISTBOX 2
#define CTLCOLOR_BTN 3
#define CTLCOLOR_DLG 4
#define CTLCOLOR_SCROLLBAR 5
#define CTLCOLOR_STATIC 6
#define CTLCOLOR_MAX 7
#define COLOR_SCROLLBAR 0
#define COLOR_BACKGROUND 1
#define COLOR_ACTIVECAPTION 2
#define COLOR_INACTIVECAPTION 3
#define COLOR_MENU 4
#define COLOR_WINDOW 5
#define COLOR_WINDOWFRAME 6
#define COLOR_MENUTEXT 7
#define COLOR_WINDOWTEXT 8
#define COLOR_CAPTIONTEXT 9
#define COLOR_ACTIVEBORDER 10
#define COLOR_INACTIVEBORDER 11
#define COLOR_APPWORKSPACE 12
#define COLOR_HIGHLIGHT 13
#define COLOR_HIGHLIGHTTEXT 14
#define COLOR_BTNFACE 15
#define COLOR_BTNSHADOW 16
#define COLOR_GRAYTEXT 17
#define COLOR_BTNTEXT 18
#define COLOR_INACTIVECAPTIONTEXT 19
#define COLOR_BTNHIGHLIGHT 20
#define COLOR_3DDKSHADOW 21
#define COLOR_3DLIGHT 22
#define COLOR_INFOTEXT 23
#define COLOR_INFOBK 24
#define COLOR_HOTLIGHT 26
#define COLOR_GRADIENTACTIVECAPTION 27
#define COLOR_GRADIENTINACTIVECAPTION 28
#define COLOR_MENUHILIGHT 29
#define COLOR_MENUBAR 30
#define COLOR_DESKTOP COLOR_BACKGROUND
#define COLOR_3DFACE COLOR_BTNFACE
#define COLOR_3DSHADOW COLOR_BTNSHADOW
#define COLOR_3DHIGHLIGHT COLOR_BTNHIGHLIGHT
#define COLOR_3DHILIGHT COLOR_BTNHIGHLIGHT
#define COLOR_BTNHILIGHT COLOR_BTNHIGHLIGHT

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

#ifdef UNICODE
	#define GetWindowLong GetWindowLongW
	#define SetWindowLong SetWindowLongW
#else
	#define GetWindowLong GetWindowLongA
	#define SetWindowLong SetWindowLongA
#endif

declare function GetWindowWord(byval hWnd as HWND, byval nIndex as long) as WORD
declare function SetWindowWord(byval hWnd as HWND, byval nIndex as long, byval wNewWord as WORD) as WORD
declare function GetWindowLongA(byval hWnd as HWND, byval nIndex as long) as LONG
declare function GetWindowLongW(byval hWnd as HWND, byval nIndex as long) as LONG
declare function SetWindowLongA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG
declare function SetWindowLongW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as LONG

#ifdef UNICODE
	#define GetWindowLongPtr GetWindowLongPtrW
	#define SetWindowLongPtr SetWindowLongPtrW
#else
	#define GetWindowLongPtr GetWindowLongPtrA
	#define SetWindowLongPtr SetWindowLongPtrA
#endif

#ifdef __FB_64BIT__
	declare function GetWindowLongPtrA(byval hWnd as HWND, byval nIndex as long) as LONG_PTR
	declare function GetWindowLongPtrW(byval hWnd as HWND, byval nIndex as long) as LONG_PTR
	declare function SetWindowLongPtrA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR
	declare function SetWindowLongPtrW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as LONG_PTR
#else
	#define GetWindowLongPtrA GetWindowLongA
	#define GetWindowLongPtrW GetWindowLongW
	#define SetWindowLongPtrA SetWindowLongA
	#define SetWindowLongPtrW SetWindowLongW
#endif

#ifdef UNICODE
	#define GetClassLong GetClassLongW
	#define SetClassLong SetClassLongW
#else
	#define GetClassLong GetClassLongA
	#define SetClassLong SetClassLongA
#endif

declare function GetClassWord(byval hWnd as HWND, byval nIndex as long) as WORD
declare function SetClassWord(byval hWnd as HWND, byval nIndex as long, byval wNewWord as WORD) as WORD
declare function GetClassLongA(byval hWnd as HWND, byval nIndex as long) as DWORD
declare function GetClassLongW(byval hWnd as HWND, byval nIndex as long) as DWORD
declare function SetClassLongA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD
declare function SetClassLongW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG) as DWORD

#ifdef UNICODE
	#define GetClassLongPtr GetClassLongPtrW
	#define SetClassLongPtr SetClassLongPtrW
#else
	#define GetClassLongPtr GetClassLongPtrA
	#define SetClassLongPtr SetClassLongPtrA
#endif

#ifdef __FB_64BIT__
	declare function GetClassLongPtrA(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR
	declare function GetClassLongPtrW(byval hWnd as HWND, byval nIndex as long) as ULONG_PTR
	declare function SetClassLongPtrA(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR
	declare function SetClassLongPtrW(byval hWnd as HWND, byval nIndex as long, byval dwNewLong as LONG_PTR) as ULONG_PTR
#else
	#define GetClassLongPtrA GetClassLongA
	#define GetClassLongPtrW GetClassLongW
	#define SetClassLongPtrA SetClassLongA
	#define SetClassLongPtrW SetClassLongW
#endif

#ifdef UNICODE
	#define FindWindow FindWindowW
	#define FindWindowEx FindWindowExW
	#define GetClassName GetClassNameW
#else
	#define FindWindow FindWindowA
	#define FindWindowEx FindWindowExA
	#define GetClassName GetClassNameA
#endif

declare function GetProcessDefaultLayout(byval pdwDefaultLayout as DWORD ptr) as WINBOOL
declare function SetProcessDefaultLayout(byval dwDefaultLayout as DWORD) as WINBOOL
declare function GetDesktopWindow() as HWND
declare function GetParent(byval hWnd as HWND) as HWND
declare function SetParent(byval hWndChild as HWND, byval hWndNewParent as HWND) as HWND
declare function EnumChildWindows(byval hWndParent as HWND, byval lpEnumFunc as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function FindWindowA(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR) as HWND
declare function FindWindowW(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR) as HWND
declare function FindWindowExA(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCSTR, byval lpszWindow as LPCSTR) as HWND
declare function FindWindowExW(byval hWndParent as HWND, byval hWndChildAfter as HWND, byval lpszClass as LPCWSTR, byval lpszWindow as LPCWSTR) as HWND
declare function GetShellWindow() as HWND
declare function RegisterShellHookWindow(byval hwnd as HWND) as WINBOOL
declare function DeregisterShellHookWindow(byval hwnd as HWND) as WINBOOL
declare function EnumWindows(byval lpEnumFunc as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
declare function EnumThreadWindows(byval dwThreadId as DWORD, byval lpfn as WNDENUMPROC, byval lParam as LPARAM) as WINBOOL
#define EnumTaskWindows(hTask, lpfn, lParam) EnumThreadWindows(HandleToUlong(hTask), lpfn, lParam)
declare function GetClassNameA(byval hWnd as HWND, byval lpClassName as LPSTR, byval nMaxCount as long) as long
declare function GetClassNameW(byval hWnd as HWND, byval lpClassName as LPWSTR, byval nMaxCount as long) as long
declare function GetTopWindow(byval hWnd as HWND) as HWND

#define GetNextWindow(hWnd, wCmd) GetWindow(hWnd, wCmd)
#define GetSysModalWindow() NULL
#define SetSysModalWindow(hWnd) NULL
declare function GetWindowThreadProcessId(byval hWnd as HWND, byval lpdwProcessId as LPDWORD) as DWORD
declare function IsGUIThread(byval bConvert as WINBOOL) as WINBOOL
#define GetWindowTask(hWnd) cast(HANDLE, cast(DWORD_PTR, GetWindowThreadProcessId(hWnd, NULL)))
declare function GetLastActivePopup(byval hWnd as HWND) as HWND
#define GW_HWNDFIRST 0
#define GW_HWNDLAST 1
#define GW_HWNDNEXT 2
#define GW_HWNDPREV 3
#define GW_OWNER 4
#define GW_CHILD 5
#define GW_ENABLEDPOPUP 6
#define GW_MAX 6
declare function GetWindow(byval hWnd as HWND, byval uCmd as UINT) as HWND

#ifdef UNICODE
	#define SetWindowsHook SetWindowsHookW
	#define SetWindowsHookEx SetWindowsHookExW
#else
	#define SetWindowsHook SetWindowsHookA
	#define SetWindowsHookEx SetWindowsHookExA
#endif

declare function SetWindowsHookA(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK
declare function SetWindowsHookW(byval nFilterType as long, byval pfnFilterProc as HOOKPROC) as HHOOK
declare function UnhookWindowsHook(byval nCode as long, byval pfnFilterProc as HOOKPROC) as WINBOOL
declare function SetWindowsHookExA(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK
declare function SetWindowsHookExW(byval idHook as long, byval lpfn as HOOKPROC, byval hmod as HINSTANCE, byval dwThreadId as DWORD) as HHOOK
declare function UnhookWindowsHookEx(byval hhk as HHOOK) as WINBOOL
declare function CallNextHookEx(byval hhk as HHOOK, byval nCode as long, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT

#define DefHookProc(nCode, wParam, lParam, phhk) CallNextHookEx(*phhk, nCode, wParam, lParam)
#define MF_INSERT __MSABI_LONG(&h00000000)
#define MF_CHANGE __MSABI_LONG(&h00000080)
#define MF_APPEND __MSABI_LONG(&h00000100)
#define MF_DELETE __MSABI_LONG(&h00000200)
#define MF_REMOVE __MSABI_LONG(&h00001000)
#define MF_BYCOMMAND __MSABI_LONG(&h00000000)
#define MF_BYPOSITION __MSABI_LONG(&h00000400)
#define MF_SEPARATOR __MSABI_LONG(&h00000800)
#define MF_ENABLED __MSABI_LONG(&h00000000)
#define MF_GRAYED __MSABI_LONG(&h00000001)
#define MF_DISABLED __MSABI_LONG(&h00000002)
#define MF_UNCHECKED __MSABI_LONG(&h00000000)
#define MF_CHECKED __MSABI_LONG(&h00000008)
#define MF_USECHECKBITMAPS __MSABI_LONG(&h00000200)
#define MF_STRING __MSABI_LONG(&h00000000)
#define MF_BITMAP __MSABI_LONG(&h00000004)
#define MF_OWNERDRAW __MSABI_LONG(&h00000100)
#define MF_POPUP __MSABI_LONG(&h00000010)
#define MF_MENUBARBREAK __MSABI_LONG(&h00000020)
#define MF_MENUBREAK __MSABI_LONG(&h00000040)
#define MF_UNHILITE __MSABI_LONG(&h00000000)
#define MF_HILITE __MSABI_LONG(&h00000080)
#define MF_DEFAULT __MSABI_LONG(&h00001000)
#define MF_SYSMENU __MSABI_LONG(&h00002000)
#define MF_HELP __MSABI_LONG(&h00004000)
#define MF_RIGHTJUSTIFY __MSABI_LONG(&h00004000)
#define MF_MOUSESELECT __MSABI_LONG(&h00008000)
#define MFT_STRING MF_STRING
#define MFT_BITMAP MF_BITMAP
#define MFT_MENUBARBREAK MF_MENUBARBREAK
#define MFT_MENUBREAK MF_MENUBREAK
#define MFT_OWNERDRAW MF_OWNERDRAW
#define MFT_RADIOCHECK __MSABI_LONG(&h00000200)
#define MFT_SEPARATOR MF_SEPARATOR
#define MFT_RIGHTORDER __MSABI_LONG(&h00002000)
#define MFT_RIGHTJUSTIFY MF_RIGHTJUSTIFY
#define MFS_GRAYED __MSABI_LONG(&h00000003)
#define MFS_DISABLED MFS_GRAYED
#define MFS_CHECKED MF_CHECKED
#define MFS_HILITE MF_HILITE
#define MFS_ENABLED MF_ENABLED
#define MFS_UNCHECKED MF_UNCHECKED
#define MFS_UNHILITE MF_UNHILITE
#define MFS_DEFAULT MF_DEFAULT
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
#define MF_END __MSABI_LONG(&h00000080)
#define SC_SIZE &hF000
#define SC_MOVE &hF010
#define SC_MINIMIZE &hF020
#define SC_MAXIMIZE &hF030
#define SC_NEXTWINDOW &hF040
#define SC_PREVWINDOW &hF050
#define SC_CLOSE &hF060
#define SC_VSCROLL &hF070
#define SC_HSCROLL &hF080
#define SC_MOUSEMENU &hF090
#define SC_KEYMENU &hF100
#define SC_ARRANGE &hF110
#define SC_RESTORE &hF120
#define SC_TASKLIST &hF130
#define SC_SCREENSAVE &hF140
#define SC_HOTKEY &hF150
#define SC_DEFAULT &hF160
#define SC_MONITORPOWER &hF170
#define SC_CONTEXTHELP &hF180
#define SC_SEPARATOR &hF00F
#define SC_ICON SC_MINIMIZE
#define SC_ZOOM SC_MAXIMIZE

#ifdef UNICODE
	#define LoadBitmap LoadBitmapW
	#define LoadCursor LoadCursorW
	#define LoadCursorFromFile LoadCursorFromFileW
#else
	#define LoadBitmap LoadBitmapA
	#define LoadCursor LoadCursorA
	#define LoadCursorFromFile LoadCursorFromFileA
#endif

declare function LoadBitmapA(byval hInstance as HINSTANCE, byval lpBitmapName as LPCSTR) as HBITMAP
declare function LoadBitmapW(byval hInstance as HINSTANCE, byval lpBitmapName as LPCWSTR) as HBITMAP
declare function LoadCursorA(byval hInstance as HINSTANCE, byval lpCursorName as LPCSTR) as HCURSOR
declare function LoadCursorW(byval hInstance as HINSTANCE, byval lpCursorName as LPCWSTR) as HCURSOR
declare function LoadCursorFromFileA(byval lpFileName as LPCSTR) as HCURSOR
declare function LoadCursorFromFileW(byval lpFileName as LPCWSTR) as HCURSOR
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
declare function SetSystemCursor(byval hcur as HCURSOR, byval id as DWORD) as WINBOOL

type _ICONINFO
	fIcon as WINBOOL
	xHotspot as DWORD
	yHotspot as DWORD
	hbmMask as HBITMAP
	hbmColor as HBITMAP
end type

type ICONINFO as _ICONINFO
type PICONINFO as ICONINFO ptr

#ifdef UNICODE
	#define LoadIcon LoadIconW
	#define PrivateExtractIcons PrivateExtractIconsW
#else
	#define LoadIcon LoadIconA
	#define PrivateExtractIcons PrivateExtractIconsA
#endif

declare function LoadIconA(byval hInstance as HINSTANCE, byval lpIconName as LPCSTR) as HICON
declare function LoadIconW(byval hInstance as HINSTANCE, byval lpIconName as LPCWSTR) as HICON
declare function PrivateExtractIconsA(byval szFileName as LPCSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT
declare function PrivateExtractIconsW(byval szFileName as LPCWSTR, byval nIconIndex as long, byval cxIcon as long, byval cyIcon as long, byval phicon as HICON ptr, byval piconid as UINT ptr, byval nIcons as UINT, byval flags as UINT) as UINT
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
#define IMAGE_BITMAP 0
#define IMAGE_ICON 1
#define IMAGE_CURSOR 2
#define IMAGE_ENHMETAFILE 3
#define LR_DEFAULTCOLOR &h0000
#define LR_MONOCHROME &h0001
#define LR_COLOR &h0002
#define LR_COPYRETURNORG &h0004
#define LR_COPYDELETEORG &h0008
#define LR_LOADFROMFILE &h0010
#define LR_LOADTRANSPARENT &h0020
#define LR_DEFAULTSIZE &h0040
#define LR_VGACOLOR &h0080
#define LR_LOADMAP3DCOLORS &h1000
#define LR_CREATEDIBSECTION &h2000
#define LR_COPYFROMRESOURCE &h4000
#define LR_SHARED &h8000

#ifdef UNICODE
	#define LoadImage LoadImageW
#else
	#define LoadImage LoadImageA
#endif

declare function LoadImageA(byval hInst as HINSTANCE, byval name as LPCSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE
declare function LoadImageW(byval hInst as HINSTANCE, byval name as LPCWSTR, byval type as UINT, byval cx as long, byval cy as long, byval fuLoad as UINT) as HANDLE
declare function CopyImage(byval h as HANDLE, byval type as UINT, byval cx as long, byval cy as long, byval flags as UINT) as HANDLE

#define DI_MASK &h0001
#define DI_IMAGE &h0002
#define DI_NORMAL &h0003
#define DI_COMPAT &h0004
#define DI_DEFAULTSIZE &h0008
#define DI_NOMIRROR &h0010

declare function DrawIconEx(byval hdc as HDC, byval xLeft as long, byval yTop as long, byval hIcon as HICON, byval cxWidth as long, byval cyWidth as long, byval istepIfAniCur as UINT, byval hbrFlickerFreeDraw as HBRUSH, byval diFlags as UINT) as WINBOOL
declare function CreateIconIndirect(byval piconinfo as PICONINFO) as HICON
declare function CopyIcon(byval hIcon as HICON) as HICON
declare function GetIconInfo(byval hIcon as HICON, byval piconinfo as PICONINFO) as WINBOOL

#define RES_ICON 1
#define RES_CURSOR 2
#define ORD_LANGDRIVER 1
#define IDI_APPLICATION MAKEINTRESOURCE(32512)
#define IDI_HAND MAKEINTRESOURCE(32513)
#define IDI_QUESTION MAKEINTRESOURCE(32514)
#define IDI_EXCLAMATION MAKEINTRESOURCE(32515)
#define IDI_ASTERISK MAKEINTRESOURCE(32516)
#define IDI_WINLOGO MAKEINTRESOURCE(32517)
#define IDI_WARNING IDI_EXCLAMATION
#define IDI_ERROR IDI_HAND
#define IDI_INFORMATION IDI_ASTERISK
#define IDOK 1
#define IDCANCEL 2
#define IDABORT 3
#define IDRETRY 4
#define IDIGNORE 5
#define IDYES 6
#define IDNO 7
#define IDCLOSE 8
#define IDHELP 9
#define IDTRYAGAIN 10
#define IDCONTINUE 11
#define IDTIMEOUT 32000
#define ES_LEFT __MSABI_LONG(&h0000)
#define ES_CENTER __MSABI_LONG(&h0001)
#define ES_RIGHT __MSABI_LONG(&h0002)
#define ES_MULTILINE __MSABI_LONG(&h0004)
#define ES_UPPERCASE __MSABI_LONG(&h0008)
#define ES_LOWERCASE __MSABI_LONG(&h0010)
#define ES_PASSWORD __MSABI_LONG(&h0020)
#define ES_AUTOVSCROLL __MSABI_LONG(&h0040)
#define ES_AUTOHSCROLL __MSABI_LONG(&h0080)
#define ES_NOHIDESEL __MSABI_LONG(&h0100)
#define ES_OEMCONVERT __MSABI_LONG(&h0400)
#define ES_READONLY __MSABI_LONG(&h0800)
#define ES_WANTRETURN __MSABI_LONG(&h1000)
#define ES_NUMBER __MSABI_LONG(&h2000)
#define EN_SETFOCUS &h0100
#define EN_KILLFOCUS &h0200
#define EN_CHANGE &h0300
#define EN_UPDATE &h0400
#define EN_ERRSPACE &h0500
#define EN_MAXTEXT &h0501
#define EN_HSCROLL &h0601
#define EN_VSCROLL &h0602
#define EN_ALIGN_LTR_EC &h0700
#define EN_ALIGN_RTL_EC &h0701
#define EC_LEFTMARGIN &h0001
#define EC_RIGHTMARGIN &h0002
#define EC_USEFONTINFO &hffff
#define EMSIS_COMPOSITIONSTRING &h0001
#define EIMES_GETCOMPSTRATONCE &h0001
#define EIMES_CANCELCOMPSTRINFOCUS &h0002
#define EIMES_COMPLETECOMPSTRKILLFOCUS &h0004
#define EM_GETSEL &h00B0
#define EM_SETSEL &h00B1
#define EM_GETRECT &h00B2
#define EM_SETRECT &h00B3
#define EM_SETRECTNP &h00B4
#define EM_SCROLL &h00B5
#define EM_LINESCROLL &h00B6
#define EM_SCROLLCARET &h00B7
#define EM_GETMODIFY &h00B8
#define EM_SETMODIFY &h00B9
#define EM_GETLINECOUNT &h00BA
#define EM_LINEINDEX &h00BB
#define EM_SETHANDLE &h00BC
#define EM_GETHANDLE &h00BD
#define EM_GETTHUMB &h00BE
#define EM_LINELENGTH &h00C1
#define EM_REPLACESEL &h00C2
#define EM_GETLINE &h00C4
#define EM_LIMITTEXT &h00C5
#define EM_CANUNDO &h00C6
#define EM_UNDO &h00C7
#define EM_FMTLINES &h00C8
#define EM_LINEFROMCHAR &h00C9
#define EM_SETTABSTOPS &h00CB
#define EM_SETPASSWORDCHAR &h00CC
#define EM_EMPTYUNDOBUFFER &h00CD
#define EM_GETFIRSTVISIBLELINE &h00CE
#define EM_SETREADONLY &h00CF
#define EM_SETWORDBREAKPROC &h00D0
#define EM_GETWORDBREAKPROC &h00D1
#define EM_GETPASSWORDCHAR &h00D2
#define EM_SETMARGINS &h00D3
#define EM_GETMARGINS &h00D4
#define EM_SETLIMITTEXT EM_LIMITTEXT
#define EM_GETLIMITTEXT &h00D5
#define EM_POSFROMCHAR &h00D6
#define EM_CHARFROMPOS &h00D7
#define EM_SETIMESTATUS &h00D8
#define EM_GETIMESTATUS &h00D9
#define WB_LEFT 0
#define WB_RIGHT 1
#define WB_ISDELIMITER 2
#define BS_PUSHBUTTON __MSABI_LONG(&h00000000)
#define BS_DEFPUSHBUTTON __MSABI_LONG(&h00000001)
#define BS_CHECKBOX __MSABI_LONG(&h00000002)
#define BS_AUTOCHECKBOX __MSABI_LONG(&h00000003)
#define BS_RADIOBUTTON __MSABI_LONG(&h00000004)
#define BS_3STATE __MSABI_LONG(&h00000005)
#define BS_AUTO3STATE __MSABI_LONG(&h00000006)
#define BS_GROUPBOX __MSABI_LONG(&h00000007)
#define BS_USERBUTTON __MSABI_LONG(&h00000008)
#define BS_AUTORADIOBUTTON __MSABI_LONG(&h00000009)
#define BS_PUSHBOX __MSABI_LONG(&h0000000A)
#define BS_OWNERDRAW __MSABI_LONG(&h0000000B)
#define BS_TYPEMASK __MSABI_LONG(&h0000000F)
#define BS_LEFTTEXT __MSABI_LONG(&h00000020)
#define BS_TEXT __MSABI_LONG(&h00000000)
#define BS_ICON __MSABI_LONG(&h00000040)
#define BS_BITMAP __MSABI_LONG(&h00000080)
#define BS_LEFT __MSABI_LONG(&h00000100)
#define BS_RIGHT __MSABI_LONG(&h00000200)
#define BS_CENTER __MSABI_LONG(&h00000300)
#define BS_TOP __MSABI_LONG(&h00000400)
#define BS_BOTTOM __MSABI_LONG(&h00000800)
#define BS_VCENTER __MSABI_LONG(&h00000C00)
#define BS_PUSHLIKE __MSABI_LONG(&h00001000)
#define BS_MULTILINE __MSABI_LONG(&h00002000)
#define BS_NOTIFY __MSABI_LONG(&h00004000)
#define BS_FLAT __MSABI_LONG(&h00008000)
#define BS_RIGHTBUTTON BS_LEFTTEXT
#define BN_CLICKED 0
#define BN_PAINT 1
#define BN_HILITE 2
#define BN_UNHILITE 3
#define BN_DISABLE 4
#define BN_DOUBLECLICKED 5
#define BN_PUSHED BN_HILITE
#define BN_UNPUSHED BN_UNHILITE
#define BN_DBLCLK BN_DOUBLECLICKED
#define BN_SETFOCUS 6
#define BN_KILLFOCUS 7
#define BM_GETCHECK &h00F0
#define BM_SETCHECK &h00F1
#define BM_GETSTATE &h00F2
#define BM_SETSTATE &h00F3
#define BM_SETSTYLE &h00F4
#define BM_CLICK &h00F5
#define BM_GETIMAGE &h00F6
#define BM_SETIMAGE &h00F7
#define BST_UNCHECKED &h0000
#define BST_CHECKED &h0001
#define BST_INDETERMINATE &h0002
#define BST_PUSHED &h0004
#define BST_FOCUS &h0008
#define SS_LEFT __MSABI_LONG(&h00000000)
#define SS_CENTER __MSABI_LONG(&h00000001)
#define SS_RIGHT __MSABI_LONG(&h00000002)
#define SS_ICON __MSABI_LONG(&h00000003)
#define SS_BLACKRECT __MSABI_LONG(&h00000004)
#define SS_GRAYRECT __MSABI_LONG(&h00000005)
#define SS_WHITERECT __MSABI_LONG(&h00000006)
#define SS_BLACKFRAME __MSABI_LONG(&h00000007)
#define SS_GRAYFRAME __MSABI_LONG(&h00000008)
#define SS_WHITEFRAME __MSABI_LONG(&h00000009)
#define SS_USERITEM __MSABI_LONG(&h0000000A)
#define SS_SIMPLE __MSABI_LONG(&h0000000B)
#define SS_LEFTNOWORDWRAP __MSABI_LONG(&h0000000C)
#define SS_OWNERDRAW __MSABI_LONG(&h0000000D)
#define SS_BITMAP __MSABI_LONG(&h0000000E)
#define SS_ENHMETAFILE __MSABI_LONG(&h0000000F)
#define SS_ETCHEDHORZ __MSABI_LONG(&h00000010)
#define SS_ETCHEDVERT __MSABI_LONG(&h00000011)
#define SS_ETCHEDFRAME __MSABI_LONG(&h00000012)
#define SS_TYPEMASK __MSABI_LONG(&h0000001F)
#define SS_REALSIZECONTROL __MSABI_LONG(&h00000040)
#define SS_NOPREFIX __MSABI_LONG(&h00000080)
#define SS_NOTIFY __MSABI_LONG(&h00000100)
#define SS_CENTERIMAGE __MSABI_LONG(&h00000200)
#define SS_RIGHTJUST __MSABI_LONG(&h00000400)
#define SS_REALSIZEIMAGE __MSABI_LONG(&h00000800)
#define SS_SUNKEN __MSABI_LONG(&h00001000)
#define SS_EDITCONTROL __MSABI_LONG(&h00002000)
#define SS_ENDELLIPSIS __MSABI_LONG(&h00004000)
#define SS_PATHELLIPSIS __MSABI_LONG(&h00008000)
#define SS_WORDELLIPSIS __MSABI_LONG(&h0000C000)
#define SS_ELLIPSISMASK __MSABI_LONG(&h0000C000)
#define STM_SETICON &h0170
#define STM_GETICON &h0171
#define STM_SETIMAGE &h0172
#define STM_GETIMAGE &h0173
#define STN_CLICKED 0
#define STN_DBLCLK 1
#define STN_ENABLE 2
#define STN_DISABLE 3
#define STM_MSGMAX &h0174
#define WC_DIALOG MAKEINTATOM(&h8002)

#ifndef __FB_64BIT__
	#define DWL_MSGRESULT 0
	#define DWL_DLGPROC 4
	#define DWL_USER 8
#endif

#define DWLP_MSGRESULT 0
#define DWLP_DLGPROC (DWLP_MSGRESULT + sizeof(LRESULT))
#define DWLP_USER (DWLP_DLGPROC + sizeof(DLGPROC))

#ifdef UNICODE
	#define IsDialogMessage IsDialogMessageW
#else
	#define IsDialogMessage IsDialogMessageA
#endif

declare function IsDialogMessageA(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL
declare function IsDialogMessageW(byval hDlg as HWND, byval lpMsg as LPMSG) as WINBOOL

#ifdef UNICODE
	#define DlgDirList DlgDirListW
	#define DlgDirSelectEx DlgDirSelectExW
	#define DlgDirListComboBox DlgDirListComboBoxW
	#define DlgDirSelectComboBoxEx DlgDirSelectComboBoxExW
#else
	#define DlgDirList DlgDirListA
	#define DlgDirSelectEx DlgDirSelectExA
	#define DlgDirListComboBox DlgDirListComboBoxA
	#define DlgDirSelectComboBoxEx DlgDirSelectComboBoxExA
#endif

declare function MapDialogRect(byval hDlg as HWND, byval lpRect as LPRECT) as WINBOOL
declare function DlgDirListA(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long
declare function DlgDirListW(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDListBox as long, byval nIDStaticPath as long, byval uFileType as UINT) as long

#define DDL_READWRITE &h0000
#define DDL_READONLY &h0001
#define DDL_HIDDEN &h0002
#define DDL_SYSTEM &h0004
#define DDL_DIRECTORY &h0010
#define DDL_ARCHIVE &h0020
#define DDL_POSTMSGS &h2000
#define DDL_DRIVES &h4000
#define DDL_EXCLUSIVE &h8000

declare function DlgDirSelectExA(byval hwndDlg as HWND, byval lpString as LPSTR, byval chCount as long, byval idListBox as long) as WINBOOL
declare function DlgDirSelectExW(byval hwndDlg as HWND, byval lpString as LPWSTR, byval chCount as long, byval idListBox as long) as WINBOOL
declare function DlgDirListComboBoxA(byval hDlg as HWND, byval lpPathSpec as LPSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long
declare function DlgDirListComboBoxW(byval hDlg as HWND, byval lpPathSpec as LPWSTR, byval nIDComboBox as long, byval nIDStaticPath as long, byval uFiletype as UINT) as long
declare function DlgDirSelectComboBoxExA(byval hwndDlg as HWND, byval lpString as LPSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL
declare function DlgDirSelectComboBoxExW(byval hwndDlg as HWND, byval lpString as LPWSTR, byval cchOut as long, byval idComboBox as long) as WINBOOL

#define DS_ABSALIGN __MSABI_LONG(&h01)
#define DS_SYSMODAL __MSABI_LONG(&h02)
#define DS_LOCALEDIT __MSABI_LONG(&h20)
#define DS_SETFONT __MSABI_LONG(&h40)
#define DS_MODALFRAME __MSABI_LONG(&h80)
#define DS_NOIDLEMSG __MSABI_LONG(&h100)
#define DS_SETFOREGROUND __MSABI_LONG(&h200)
#define DS_3DLOOK __MSABI_LONG(&h0004)
#define DS_FIXEDSYS __MSABI_LONG(&h0008)
#define DS_NOFAILCREATE __MSABI_LONG(&h0010)
#define DS_CONTROL __MSABI_LONG(&h0400)
#define DS_CENTER __MSABI_LONG(&h0800)
#define DS_CENTERMOUSE __MSABI_LONG(&h1000)
#define DS_CONTEXTHELP __MSABI_LONG(&h2000)
#define DS_SHELLFONT (DS_SETFONT or DS_FIXEDSYS)
#define DM_GETDEFID (WM_USER + 0)
#define DM_SETDEFID (WM_USER + 1)
#define DM_REPOSITION (WM_USER + 2)
#define DC_HASDEFID &h534B
#define DLGC_WANTARROWS &h0001
#define DLGC_WANTTAB &h0002
#define DLGC_WANTALLKEYS &h0004
#define DLGC_WANTMESSAGE &h0004
#define DLGC_HASSETSEL &h0008
#define DLGC_DEFPUSHBUTTON &h0010
#define DLGC_UNDEFPUSHBUTTON &h0020
#define DLGC_RADIOBUTTON &h0040
#define DLGC_WANTCHARS &h0080
#define DLGC_STATIC &h0100
#define DLGC_BUTTON &h2000
#define LB_CTLCODE __MSABI_LONG(0)
#define LB_OKAY 0
#define LB_ERR (-1)
#define LB_ERRSPACE (-2)
#define LBN_ERRSPACE (-2)
#define LBN_SELCHANGE 1
#define LBN_DBLCLK 2
#define LBN_SELCANCEL 3
#define LBN_SETFOCUS 4
#define LBN_KILLFOCUS 5
#define LB_ADDSTRING &h0180
#define LB_INSERTSTRING &h0181
#define LB_DELETESTRING &h0182
#define LB_SELITEMRANGEEX &h0183
#define LB_RESETCONTENT &h0184
#define LB_SETSEL &h0185
#define LB_SETCURSEL &h0186
#define LB_GETSEL &h0187
#define LB_GETCURSEL &h0188
#define LB_GETTEXT &h0189
#define LB_GETTEXTLEN &h018A
#define LB_GETCOUNT &h018B
#define LB_SELECTSTRING &h018C
#define LB_DIR &h018D
#define LB_GETTOPINDEX &h018E
#define LB_FINDSTRING &h018F
#define LB_GETSELCOUNT &h0190
#define LB_GETSELITEMS &h0191
#define LB_SETTABSTOPS &h0192
#define LB_GETHORIZONTALEXTENT &h0193
#define LB_SETHORIZONTALEXTENT &h0194
#define LB_SETCOLUMNWIDTH &h0195
#define LB_ADDFILE &h0196
#define LB_SETTOPINDEX &h0197
#define LB_GETITEMRECT &h0198
#define LB_GETITEMDATA &h0199
#define LB_SETITEMDATA &h019A
#define LB_SELITEMRANGE &h019B
#define LB_SETANCHORINDEX &h019C
#define LB_GETANCHORINDEX &h019D
#define LB_SETCARETINDEX &h019E
#define LB_GETCARETINDEX &h019F
#define LB_SETITEMHEIGHT &h01A0
#define LB_GETITEMHEIGHT &h01A1
#define LB_FINDSTRINGEXACT &h01A2
#define LB_SETLOCALE &h01A5
#define LB_GETLOCALE &h01A6
#define LB_SETCOUNT &h01A7
#define LB_INITSTORAGE &h01A8
#define LB_ITEMFROMPOINT &h01A9
#define LB_GETLISTBOXINFO &h01B2
#define LB_MSGMAX &h01B3
#define LBS_NOTIFY __MSABI_LONG(&h0001)
#define LBS_SORT __MSABI_LONG(&h0002)
#define LBS_NOREDRAW __MSABI_LONG(&h0004)
#define LBS_MULTIPLESEL __MSABI_LONG(&h0008)
#define LBS_OWNERDRAWFIXED __MSABI_LONG(&h0010)
#define LBS_OWNERDRAWVARIABLE __MSABI_LONG(&h0020)
#define LBS_HASSTRINGS __MSABI_LONG(&h0040)
#define LBS_USETABSTOPS __MSABI_LONG(&h0080)
#define LBS_NOINTEGRALHEIGHT __MSABI_LONG(&h0100)
#define LBS_MULTICOLUMN __MSABI_LONG(&h0200)
#define LBS_WANTKEYBOARDINPUT __MSABI_LONG(&h0400)
#define LBS_EXTENDEDSEL __MSABI_LONG(&h0800)
#define LBS_DISABLENOSCROLL __MSABI_LONG(&h1000)
#define LBS_NODATA __MSABI_LONG(&h2000)
#define LBS_NOSEL __MSABI_LONG(&h4000)
#define LBS_COMBOBOX __MSABI_LONG(&h8000)
#define LBS_STANDARD (((LBS_NOTIFY or LBS_SORT) or WS_VSCROLL) or WS_BORDER)
#define CB_OKAY 0
#define CB_ERR (-1)
#define CB_ERRSPACE (-2)
#define CBN_ERRSPACE (-1)
#define CBN_SELCHANGE 1
#define CBN_DBLCLK 2
#define CBN_SETFOCUS 3
#define CBN_KILLFOCUS 4
#define CBN_EDITCHANGE 5
#define CBN_EDITUPDATE 6
#define CBN_DROPDOWN 7
#define CBN_CLOSEUP 8
#define CBN_SELENDOK 9
#define CBN_SELENDCANCEL 10
#define CBS_SIMPLE __MSABI_LONG(&h0001)
#define CBS_DROPDOWN __MSABI_LONG(&h0002)
#define CBS_DROPDOWNLIST __MSABI_LONG(&h0003)
#define CBS_OWNERDRAWFIXED __MSABI_LONG(&h0010)
#define CBS_OWNERDRAWVARIABLE __MSABI_LONG(&h0020)
#define CBS_AUTOHSCROLL __MSABI_LONG(&h0040)
#define CBS_OEMCONVERT __MSABI_LONG(&h0080)
#define CBS_SORT __MSABI_LONG(&h0100)
#define CBS_HASSTRINGS __MSABI_LONG(&h0200)
#define CBS_NOINTEGRALHEIGHT __MSABI_LONG(&h0400)
#define CBS_DISABLENOSCROLL __MSABI_LONG(&h0800)
#define CBS_UPPERCASE __MSABI_LONG(&h2000)
#define CBS_LOWERCASE __MSABI_LONG(&h4000)
#define CB_GETEDITSEL &h0140
#define CB_LIMITTEXT &h0141
#define CB_SETEDITSEL &h0142
#define CB_ADDSTRING &h0143
#define CB_DELETESTRING &h0144
#define CB_DIR &h0145
#define CB_GETCOUNT &h0146
#define CB_GETCURSEL &h0147
#define CB_GETLBTEXT &h0148
#define CB_GETLBTEXTLEN &h0149
#define CB_INSERTSTRING &h014A
#define CB_RESETCONTENT &h014B
#define CB_FINDSTRING &h014C
#define CB_SELECTSTRING &h014D
#define CB_SETCURSEL &h014E
#define CB_SHOWDROPDOWN &h014F
#define CB_GETITEMDATA &h0150
#define CB_SETITEMDATA &h0151
#define CB_GETDROPPEDCONTROLRECT &h0152
#define CB_SETITEMHEIGHT &h0153
#define CB_GETITEMHEIGHT &h0154
#define CB_SETEXTENDEDUI &h0155
#define CB_GETEXTENDEDUI &h0156
#define CB_GETDROPPEDSTATE &h0157
#define CB_FINDSTRINGEXACT &h0158
#define CB_SETLOCALE &h0159
#define CB_GETLOCALE &h015A
#define CB_GETTOPINDEX &h015b
#define CB_SETTOPINDEX &h015c
#define CB_GETHORIZONTALEXTENT &h015d
#define CB_SETHORIZONTALEXTENT &h015e
#define CB_GETDROPPEDWIDTH &h015f
#define CB_SETDROPPEDWIDTH &h0160
#define CB_INITSTORAGE &h0161
#define CB_GETCOMBOBOXINFO &h0164
#define CB_MSGMAX &h0165
#define SBS_HORZ __MSABI_LONG(&h0000)
#define SBS_VERT __MSABI_LONG(&h0001)
#define SBS_TOPALIGN __MSABI_LONG(&h0002)
#define SBS_LEFTALIGN __MSABI_LONG(&h0002)
#define SBS_BOTTOMALIGN __MSABI_LONG(&h0004)
#define SBS_RIGHTALIGN __MSABI_LONG(&h0004)
#define SBS_SIZEBOXTOPLEFTALIGN __MSABI_LONG(&h0002)
#define SBS_SIZEBOXBOTTOMRIGHTALIGN __MSABI_LONG(&h0004)
#define SBS_SIZEBOX __MSABI_LONG(&h0008)
#define SBS_SIZEGRIP __MSABI_LONG(&h0010)
#define SBM_SETPOS &h00E0
#define SBM_GETPOS &h00E1
#define SBM_SETRANGE &h00E2
#define SBM_SETRANGEREDRAW &h00E6
#define SBM_GETRANGE &h00E3
#define SBM_ENABLE_ARROWS &h00E4
#define SBM_SETSCROLLINFO &h00E9
#define SBM_GETSCROLLINFO &h00EA
#define SBM_GETSCROLLBARINFO &h00EB
#define SIF_RANGE &h0001
#define SIF_PAGE &h0002
#define SIF_POS &h0004
#define SIF_DISABLENOSCROLL &h0008
#define SIF_TRACKPOS &h0010
#define SIF_ALL (((SIF_RANGE or SIF_PAGE) or SIF_POS) or SIF_TRACKPOS)

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

#define MDIS_ALLCHILDSTYLES &h0001
#define MDITILE_VERTICAL &h0000
#define MDITILE_HORIZONTAL &h0001
#define MDITILE_SKIPDISABLED &h0002
#define MDITILE_ZORDER &h0004

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

#ifdef UNICODE
	#define DefFrameProc DefFrameProcW
	#define DefMDIChildProc DefMDIChildProcW
	#define CreateMDIWindow CreateMDIWindowW
#else
	#define DefFrameProc DefFrameProcA
	#define DefMDIChildProc DefMDIChildProcA
	#define CreateMDIWindow CreateMDIWindowA
#endif

declare function DefFrameProcA(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DefFrameProcW(byval hWnd as HWND, byval hWndMDIClient as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DefMDIChildProcA(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function DefMDIChildProcW(byval hWnd as HWND, byval uMsg as UINT, byval wParam as WPARAM, byval lParam as LPARAM) as LRESULT
declare function TranslateMDISysAccel(byval hWndClient as HWND, byval lpMsg as LPMSG) as WINBOOL
declare function ArrangeIconicWindows(byval hWnd as HWND) as UINT
declare function CreateMDIWindowA(byval lpClassName as LPCSTR, byval lpWindowName as LPCSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND
declare function CreateMDIWindowW(byval lpClassName as LPCWSTR, byval lpWindowName as LPCWSTR, byval dwStyle as DWORD, byval X as long, byval Y as long, byval nWidth as long, byval nHeight as long, byval hWndParent as HWND, byval hInstance as HINSTANCE, byval lParam as LPARAM) as HWND
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

#define HELP_CONTEXT &h0001
#define HELP_QUIT &h0002
#define HELP_INDEX &h0003
#define HELP_CONTENTS &h0003
#define HELP_HELPONHELP &h0004
#define HELP_SETINDEX &h0005
#define HELP_SETCONTENTS &h0005
#define HELP_CONTEXTPOPUP &h0008
#define HELP_FORCEFILE &h0009
#define HELP_KEY &h0101
#define HELP_COMMAND &h0102
#define HELP_PARTIALKEY &h0105
#define HELP_MULTIKEY &h0201
#define HELP_SETWINPOS &h0203
#define HELP_CONTEXTMENU &h000a
#define HELP_FINDER &h000b
#define HELP_WM_HELP &h000c
#define HELP_SETPOPUP_POS &h000d
#define HELP_TCARD &h8000
#define HELP_TCARD_DATA &h0010
#define HELP_TCARD_OTHER_CALLER &h0011
#define IDH_NO_HELP 28440
#define IDH_MISSING_CONTEXT 28441
#define IDH_GENERIC_HELP_BUTTON 28442
#define IDH_OK 28443
#define IDH_CANCEL 28444
#define IDH_HELP 28445

#ifdef UNICODE
	#define WinHelp WinHelpW
#else
	#define WinHelp WinHelpA
#endif

declare function WinHelpA(byval hWndMain as HWND, byval lpszHelp as LPCSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL
declare function WinHelpW(byval hWndMain as HWND, byval lpszHelp as LPCWSTR, byval uCommand as UINT, byval dwData as ULONG_PTR) as WINBOOL
#define GR_GDIOBJECTS 0
#define GR_USEROBJECTS 1
declare function GetGuiResources(byval hProcess as HANDLE, byval uiFlags as DWORD) as DWORD
#define SPI_GETBEEP &h0001
#define SPI_SETBEEP &h0002
#define SPI_GETMOUSE &h0003
#define SPI_SETMOUSE &h0004
#define SPI_GETBORDER &h0005
#define SPI_SETBORDER &h0006
#define SPI_GETKEYBOARDSPEED &h000A
#define SPI_SETKEYBOARDSPEED &h000B
#define SPI_LANGDRIVER &h000C
#define SPI_ICONHORIZONTALSPACING &h000D
#define SPI_GETSCREENSAVETIMEOUT &h000E
#define SPI_SETSCREENSAVETIMEOUT &h000F
#define SPI_GETSCREENSAVEACTIVE &h0010
#define SPI_SETSCREENSAVEACTIVE &h0011
#define SPI_GETGRIDGRANULARITY &h0012
#define SPI_SETGRIDGRANULARITY &h0013
#define SPI_SETDESKWALLPAPER &h0014
#define SPI_SETDESKPATTERN &h0015
#define SPI_GETKEYBOARDDELAY &h0016
#define SPI_SETKEYBOARDDELAY &h0017
#define SPI_ICONVERTICALSPACING &h0018
#define SPI_GETICONTITLEWRAP &h0019
#define SPI_SETICONTITLEWRAP &h001A
#define SPI_GETMENUDROPALIGNMENT &h001B
#define SPI_SETMENUDROPALIGNMENT &h001C
#define SPI_SETDOUBLECLKWIDTH &h001D
#define SPI_SETDOUBLECLKHEIGHT &h001E
#define SPI_GETICONTITLELOGFONT &h001F
#define SPI_SETDOUBLECLICKTIME &h0020
#define SPI_SETMOUSEBUTTONSWAP &h0021
#define SPI_SETICONTITLELOGFONT &h0022
#define SPI_GETFASTTASKSWITCH &h0023
#define SPI_SETFASTTASKSWITCH &h0024
#define SPI_SETDRAGFULLWINDOWS &h0025
#define SPI_GETDRAGFULLWINDOWS &h0026
#define SPI_GETNONCLIENTMETRICS &h0029
#define SPI_SETNONCLIENTMETRICS &h002A
#define SPI_GETMINIMIZEDMETRICS &h002B
#define SPI_SETMINIMIZEDMETRICS &h002C
#define SPI_GETICONMETRICS &h002D
#define SPI_SETICONMETRICS &h002E
#define SPI_SETWORKAREA &h002F
#define SPI_GETWORKAREA &h0030
#define SPI_SETPENWINDOWS &h0031
#define SPI_GETHIGHCONTRAST &h0042
#define SPI_SETHIGHCONTRAST &h0043
#define SPI_GETKEYBOARDPREF &h0044
#define SPI_SETKEYBOARDPREF &h0045
#define SPI_GETSCREENREADER &h0046
#define SPI_SETSCREENREADER &h0047
#define SPI_GETANIMATION &h0048
#define SPI_SETANIMATION &h0049
#define SPI_GETFONTSMOOTHING &h004A
#define SPI_SETFONTSMOOTHING &h004B
#define SPI_SETDRAGWIDTH &h004C
#define SPI_SETDRAGHEIGHT &h004D
#define SPI_SETHANDHELD &h004E
#define SPI_GETLOWPOWERTIMEOUT &h004F
#define SPI_GETPOWEROFFTIMEOUT &h0050
#define SPI_SETLOWPOWERTIMEOUT &h0051
#define SPI_SETPOWEROFFTIMEOUT &h0052
#define SPI_GETLOWPOWERACTIVE &h0053
#define SPI_GETPOWEROFFACTIVE &h0054
#define SPI_SETLOWPOWERACTIVE &h0055
#define SPI_SETPOWEROFFACTIVE &h0056
#define SPI_SETCURSORS &h0057
#define SPI_SETICONS &h0058
#define SPI_GETDEFAULTINPUTLANG &h0059
#define SPI_SETDEFAULTINPUTLANG &h005A
#define SPI_SETLANGTOGGLE &h005B
#define SPI_GETWINDOWSEXTENSION &h005C
#define SPI_SETMOUSETRAILS &h005D
#define SPI_GETMOUSETRAILS &h005E
#define SPI_SETSCREENSAVERRUNNING &h0061
#define SPI_SCREENSAVERRUNNING SPI_SETSCREENSAVERRUNNING
#define SPI_GETFILTERKEYS &h0032
#define SPI_SETFILTERKEYS &h0033
#define SPI_GETTOGGLEKEYS &h0034
#define SPI_SETTOGGLEKEYS &h0035
#define SPI_GETMOUSEKEYS &h0036
#define SPI_SETMOUSEKEYS &h0037
#define SPI_GETSHOWSOUNDS &h0038
#define SPI_SETSHOWSOUNDS &h0039
#define SPI_GETSTICKYKEYS &h003A
#define SPI_SETSTICKYKEYS &h003B
#define SPI_GETACCESSTIMEOUT &h003C
#define SPI_SETACCESSTIMEOUT &h003D
#define SPI_GETSERIALKEYS &h003E
#define SPI_SETSERIALKEYS &h003F
#define SPI_GETSOUNDSENTRY &h0040
#define SPI_SETSOUNDSENTRY &h0041
#define SPI_GETSNAPTODEFBUTTON &h005F
#define SPI_SETSNAPTODEFBUTTON &h0060
#define SPI_GETMOUSEHOVERWIDTH &h0062
#define SPI_SETMOUSEHOVERWIDTH &h0063
#define SPI_GETMOUSEHOVERHEIGHT &h0064
#define SPI_SETMOUSEHOVERHEIGHT &h0065
#define SPI_GETMOUSEHOVERTIME &h0066
#define SPI_SETMOUSEHOVERTIME &h0067
#define SPI_GETWHEELSCROLLLINES &h0068
#define SPI_SETWHEELSCROLLLINES &h0069
#define SPI_GETMENUSHOWDELAY &h006A
#define SPI_SETMENUSHOWDELAY &h006B
#define SPI_GETWHEELSCROLLCHARS &h006C
#define SPI_SETWHEELSCROLLCHARS &h006D
#define SPI_GETSHOWIMEUI &h006E
#define SPI_SETSHOWIMEUI &h006F
#define SPI_GETMOUSESPEED &h0070
#define SPI_SETMOUSESPEED &h0071
#define SPI_GETSCREENSAVERRUNNING &h0072
#define SPI_GETDESKWALLPAPER &h0073

#if (_WIN32_WINNT = &h0400) or (_WIN32_WINNT = &h0502)
	#define SPI_GETAUDIODESCRIPTION &h0074
	#define SPI_SETAUDIODESCRIPTION &h0075
#endif

#define SPI_GETSCREENSAVESECURE &h0076
#define SPI_SETSCREENSAVESECURE &h0077
#define SPI_GETHUNGAPPTIMEOUT &h0078
#define SPI_SETHUNGAPPTIMEOUT &h0079
#define SPI_GETWAITTOKILLTIMEOUT &h007A
#define SPI_SETWAITTOKILLTIMEOUT &h007B
#define SPI_GETWAITTOKILLSERVICETIMEOUT &h007C
#define SPI_SETWAITTOKILLSERVICETIMEOUT &h007D
#define SPI_GETMOUSEDOCKTHRESHOLD &h007E
#define SPI_SETMOUSEDOCKTHRESHOLD &h007F
#define SPI_GETPENDOCKTHRESHOLD &h0080
#define SPI_SETPENDOCKTHRESHOLD &h0081
#define SPI_GETWINARRANGING &h0082
#define SPI_SETWINARRANGING &h0083
#define SPI_GETMOUSEDRAGOUTTHRESHOLD &h0084
#define SPI_SETMOUSEDRAGOUTTHRESHOLD &h0085
#define SPI_GETPENDRAGOUTTHRESHOLD &h0086
#define SPI_SETPENDRAGOUTTHRESHOLD &h0087
#define SPI_GETMOUSESIDEMOVETHRESHOLD &h0088
#define SPI_SETMOUSESIDEMOVETHRESHOLD &h0089
#define SPI_GETPENSIDEMOVETHRESHOLD &h008A
#define SPI_SETPENSIDEMOVETHRESHOLD &h008B
#define SPI_GETDRAGFROMMAXIMIZE &h008C
#define SPI_SETDRAGFROMMAXIMIZE &h008D
#define SPI_GETSNAPSIZING &h008E
#define SPI_GETDOCKMOVING &h0090
#define SPI_SETDOCKMOVING &h0091

#if _WIN32_WINNT = &h0602
	#define SPI_GETAUDIODESCRIPTION &h0074
	#define SPI_SETAUDIODESCRIPTION &h0075
#endif

#define SPI_GETACTIVEWINDOWTRACKING &h1000
#define SPI_SETACTIVEWINDOWTRACKING &h1001
#define SPI_GETMENUANIMATION &h1002
#define SPI_SETMENUANIMATION &h1003
#define SPI_GETCOMBOBOXANIMATION &h1004
#define SPI_SETCOMBOBOXANIMATION &h1005
#define SPI_GETLISTBOXSMOOTHSCROLLING &h1006
#define SPI_SETLISTBOXSMOOTHSCROLLING &h1007
#define SPI_GETGRADIENTCAPTIONS &h1008
#define SPI_SETGRADIENTCAPTIONS &h1009
#define SPI_GETKEYBOARDCUES &h100A
#define SPI_SETKEYBOARDCUES &h100B
#define SPI_GETMENUUNDERLINES SPI_GETKEYBOARDCUES
#define SPI_SETMENUUNDERLINES SPI_SETKEYBOARDCUES
#define SPI_GETACTIVEWNDTRKZORDER &h100C
#define SPI_SETACTIVEWNDTRKZORDER &h100D
#define SPI_GETHOTTRACKING &h100E
#define SPI_SETHOTTRACKING &h100F
#define SPI_GETMENUFADE &h1012
#define SPI_SETMENUFADE &h1013
#define SPI_GETSELECTIONFADE &h1014
#define SPI_SETSELECTIONFADE &h1015
#define SPI_GETTOOLTIPANIMATION &h1016
#define SPI_SETTOOLTIPANIMATION &h1017
#define SPI_GETTOOLTIPFADE &h1018
#define SPI_SETTOOLTIPFADE &h1019
#define SPI_GETCURSORSHADOW &h101A
#define SPI_SETCURSORSHADOW &h101B
#define SPI_GETMOUSESONAR &h101C
#define SPI_SETMOUSESONAR &h101D
#define SPI_GETMOUSECLICKLOCK &h101E
#define SPI_SETMOUSECLICKLOCK &h101F
#define SPI_GETMOUSEVANISH &h1020
#define SPI_SETMOUSEVANISH &h1021
#define SPI_GETFLATMENU &h1022
#define SPI_SETFLATMENU &h1023
#define SPI_GETDROPSHADOW &h1024
#define SPI_SETDROPSHADOW &h1025
#define SPI_GETBLOCKSENDINPUTRESETS &h1026
#define SPI_SETBLOCKSENDINPUTRESETS &h1027
#define SPI_GETUIEFFECTS &h103E
#define SPI_SETUIEFFECTS &h103F
#define SPI_GETDISABLEOVERLAPPEDCONTENT &h1040
#define SPI_SETDISABLEOVERLAPPEDCONTENT &h1041
#define SPI_GETCLIENTAREAANIMATION &h1042
#define SPI_SETCLIENTAREAANIMATION &h1043
#define SPI_GETCLEARTYPE &h1048
#define SPI_SETCLEARTYPE &h1049
#define SPI_GETFOREGROUNDLOCKTIMEOUT &h2000
#define SPI_SETFOREGROUNDLOCKTIMEOUT &h2001
#define SPI_GETACTIVEWNDTRKTIMEOUT &h2002
#define SPI_SETACTIVEWNDTRKTIMEOUT &h2003
#define SPI_GETFOREGROUNDFLASHCOUNT &h2004
#define SPI_SETFOREGROUNDFLASHCOUNT &h2005
#define SPI_GETCARETWIDTH &h2006
#define SPI_SETCARETWIDTH &h2007
#define SPI_GETMOUSECLICKLOCKTIME &h2008
#define SPI_SETMOUSECLICKLOCKTIME &h2009
#define SPI_GETFONTSMOOTHINGTYPE &h200A
#define SPI_SETFONTSMOOTHINGTYPE &h200B
#define FE_FONTSMOOTHINGSTANDARD &h0001
#define FE_FONTSMOOTHINGCLEARTYPE &h0002
#define FE_FONTSMOOTHINGDOCKING &h8000
#define SPI_GETFONTSMOOTHINGCONTRAST &h200C
#define SPI_SETFONTSMOOTHINGCONTRAST &h200D
#define SPI_GETFOCUSBORDERWIDTH &h200E
#define SPI_SETFOCUSBORDERWIDTH &h200F
#define SPI_GETFOCUSBORDERHEIGHT &h2010
#define SPI_SETFOCUSBORDERHEIGHT &h2011
#define SPI_GETFONTSMOOTHINGORIENTATION &h2012
#define SPI_SETFONTSMOOTHINGORIENTATION &h2013
#define SPI_GETMESSAGEDURATION &h2016
#define SPI_SETMESSAGEDURATION &h2017
#define FE_FONTSMOOTHINGORIENTATIONBGR &h0000
#define FE_FONTSMOOTHINGORIENTATIONRGB &h0001
#define SPIF_UPDATEINIFILE &h0001
#define SPIF_SENDWININICHANGE &h0002
#define SPIF_SENDCHANGE SPIF_SENDWININICHANGE
#define METRICS_USEDEFAULT (-1)

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

#define ARW_BOTTOMLEFT __MSABI_LONG(&h0000)
#define ARW_BOTTOMRIGHT __MSABI_LONG(&h0001)
#define ARW_TOPLEFT __MSABI_LONG(&h0002)
#define ARW_TOPRIGHT __MSABI_LONG(&h0003)
#define ARW_STARTMASK __MSABI_LONG(&h0003)
#define ARW_STARTRIGHT __MSABI_LONG(&h0001)
#define ARW_STARTTOP __MSABI_LONG(&h0002)
#define ARW_LEFT __MSABI_LONG(&h0000)
#define ARW_RIGHT __MSABI_LONG(&h0000)
#define ARW_UP __MSABI_LONG(&h0004)
#define ARW_DOWN __MSABI_LONG(&h0004)
#define ARW_HIDE __MSABI_LONG(&h0008)

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

#define SERKF_SERIALKEYSON &h00000001
#define SERKF_AVAILABLE &h00000002
#define SERKF_INDICATOR &h00000004

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

#define HCF_HIGHCONTRASTON &h00000001
#define HCF_AVAILABLE &h00000002
#define HCF_HOTKEYACTIVE &h00000004
#define HCF_CONFIRMHOTKEY &h00000008
#define HCF_HOTKEYSOUND &h00000010
#define HCF_INDICATOR &h00000020
#define HCF_HOTKEYAVAILABLE &h00000040
#define HCF_LOGONDESKTOP &h00000100
#define HCF_DEFAULTDESKTOP &h00000200
#define CDS_UPDATEREGISTRY &h00000001
#define CDS_TEST &h00000002
#define CDS_FULLSCREEN &h00000004
#define CDS_GLOBAL &h00000008
#define CDS_SET_PRIMARY &h00000010
#define CDS_VIDEOPARAMETERS &h00000020
#define CDS_RESET &h40000000
#define CDS_NORESET &h10000000
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

#define VP_COMMAND_GET &h0001
#define VP_COMMAND_SET &h0002
#define VP_FLAGS_TV_MODE &h0001
#define VP_FLAGS_TV_STANDARD &h0002
#define VP_FLAGS_FLICKER &h0004
#define VP_FLAGS_OVERSCAN &h0008
#define VP_FLAGS_MAX_UNSCALED &h0010
#define VP_FLAGS_POSITION &h0020
#define VP_FLAGS_BRIGHTNESS &h0040
#define VP_FLAGS_CONTRAST &h0080
#define VP_FLAGS_COPYPROTECT &h0100
#define VP_MODE_WIN_GRAPHICS &h0001
#define VP_MODE_TV_PLAYBACK &h0002
#define VP_TV_STANDARD_NTSC_M &h0001
#define VP_TV_STANDARD_NTSC_M_J &h0002
#define VP_TV_STANDARD_PAL_B &h0004
#define VP_TV_STANDARD_PAL_D &h0008
#define VP_TV_STANDARD_PAL_H &h0010
#define VP_TV_STANDARD_PAL_I &h0020
#define VP_TV_STANDARD_PAL_M &h0040
#define VP_TV_STANDARD_PAL_N &h0080
#define VP_TV_STANDARD_SECAM_B &h0100
#define VP_TV_STANDARD_SECAM_D &h0200
#define VP_TV_STANDARD_SECAM_G &h0400
#define VP_TV_STANDARD_SECAM_H &h0800
#define VP_TV_STANDARD_SECAM_K &h1000
#define VP_TV_STANDARD_SECAM_K1 &h2000
#define VP_TV_STANDARD_SECAM_L &h4000
#define VP_TV_STANDARD_WIN_VGA &h8000
#define VP_TV_STANDARD_NTSC_433 &h00010000
#define VP_TV_STANDARD_PAL_G &h00020000
#define VP_TV_STANDARD_PAL_60 &h00040000
#define VP_TV_STANDARD_SECAM_L1 &h00080000
#define VP_CP_TYPE_APS_TRIGGER &h0001
#define VP_CP_TYPE_MACROVISION &h0002
#define VP_CP_CMD_ACTIVATE &h0001
#define VP_CP_CMD_DEACTIVATE &h0002
#define VP_CP_CMD_CHANGE &h0004
#define DISP_CHANGE_SUCCESSFUL 0
#define DISP_CHANGE_RESTART 1
#define DISP_CHANGE_FAILED (-1)
#define DISP_CHANGE_BADMODE (-2)
#define DISP_CHANGE_NOTUPDATED (-3)
#define DISP_CHANGE_BADFLAGS (-4)
#define DISP_CHANGE_BADPARAM (-5)
#define DISP_CHANGE_BADDUALVIEW (-6)

#ifdef UNICODE
	#define ChangeDisplaySettings ChangeDisplaySettingsW
	#define ChangeDisplaySettingsEx ChangeDisplaySettingsExW
	#define EnumDisplaySettings EnumDisplaySettingsW
	#define EnumDisplaySettingsEx EnumDisplaySettingsExW
	#define EnumDisplayDevices EnumDisplayDevicesW
#else
	#define ChangeDisplaySettings ChangeDisplaySettingsA
	#define ChangeDisplaySettingsEx ChangeDisplaySettingsExA
	#define EnumDisplaySettings EnumDisplaySettingsA
	#define EnumDisplaySettingsEx EnumDisplaySettingsExA
	#define EnumDisplayDevices EnumDisplayDevicesA
#endif

declare function ChangeDisplaySettingsA(byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as LONG
declare function ChangeDisplaySettingsW(byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as LONG
declare function ChangeDisplaySettingsExA(byval lpszDeviceName as LPCSTR, byval lpDevMode as LPDEVMODEA, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG
declare function ChangeDisplaySettingsExW(byval lpszDeviceName as LPCWSTR, byval lpDevMode as LPDEVMODEW, byval hwnd as HWND, byval dwflags as DWORD, byval lParam as LPVOID) as LONG
#define ENUM_CURRENT_SETTINGS cast(DWORD, -1)
#define ENUM_REGISTRY_SETTINGS cast(DWORD, -2)
declare function EnumDisplaySettingsA(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA) as WINBOOL
declare function EnumDisplaySettingsW(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW) as WINBOOL
declare function EnumDisplaySettingsExA(byval lpszDeviceName as LPCSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEA, byval dwFlags as DWORD) as WINBOOL
declare function EnumDisplaySettingsExW(byval lpszDeviceName as LPCWSTR, byval iModeNum as DWORD, byval lpDevMode as LPDEVMODEW, byval dwFlags as DWORD) as WINBOOL
#define EDS_RAWMODE &h00000002
declare function EnumDisplayDevicesA(byval lpDevice as LPCSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEA, byval dwFlags as DWORD) as WINBOOL
declare function EnumDisplayDevicesW(byval lpDevice as LPCWSTR, byval iDevNum as DWORD, byval lpDisplayDevice as PDISPLAY_DEVICEW, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	#define SystemParametersInfo SystemParametersInfoW
#else
	#define SystemParametersInfo SystemParametersInfoA
#endif

declare function SystemParametersInfoA(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL
declare function SystemParametersInfoW(byval uiAction as UINT, byval uiParam as UINT, byval pvParam as PVOID, byval fWinIni as UINT) as WINBOOL

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
#define FKF_FILTERKEYSON &h00000001
#define FKF_AVAILABLE &h00000002
#define FKF_HOTKEYACTIVE &h00000004
#define FKF_CONFIRMHOTKEY &h00000008
#define FKF_HOTKEYSOUND &h00000010
#define FKF_INDICATOR &h00000020
#define FKF_CLICKON &h00000040

type tagSTICKYKEYS
	cbSize as UINT
	dwFlags as DWORD
end type

type STICKYKEYS as tagSTICKYKEYS
type LPSTICKYKEYS as tagSTICKYKEYS ptr
#define SKF_STICKYKEYSON &h00000001
#define SKF_AVAILABLE &h00000002
#define SKF_HOTKEYACTIVE &h00000004
#define SKF_CONFIRMHOTKEY &h00000008
#define SKF_HOTKEYSOUND &h00000010
#define SKF_INDICATOR &h00000020
#define SKF_AUDIBLEFEEDBACK &h00000040
#define SKF_TRISTATE &h00000080
#define SKF_TWOKEYSOFF &h00000100
#define SKF_LALTLATCHED &h10000000
#define SKF_LCTLLATCHED &h04000000
#define SKF_LSHIFTLATCHED &h01000000
#define SKF_RALTLATCHED &h20000000
#define SKF_RCTLLATCHED &h08000000
#define SKF_RSHIFTLATCHED &h02000000
#define SKF_LWINLATCHED &h40000000
#define SKF_RWINLATCHED &h80000000
#define SKF_LALTLOCKED &h00100000
#define SKF_LCTLLOCKED &h00040000
#define SKF_LSHIFTLOCKED &h00010000
#define SKF_RALTLOCKED &h00200000
#define SKF_RCTLLOCKED &h00080000
#define SKF_RSHIFTLOCKED &h00020000
#define SKF_LWINLOCKED &h00400000
#define SKF_RWINLOCKED &h00800000

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
#define MKF_MOUSEKEYSON &h00000001
#define MKF_AVAILABLE &h00000002
#define MKF_HOTKEYACTIVE &h00000004
#define MKF_CONFIRMHOTKEY &h00000008
#define MKF_HOTKEYSOUND &h00000010
#define MKF_INDICATOR &h00000020
#define MKF_MODIFIERS &h00000040
#define MKF_REPLACENUMBERS &h00000080
#define MKF_LEFTBUTTONSEL &h10000000
#define MKF_RIGHTBUTTONSEL &h20000000
#define MKF_LEFTBUTTONDOWN &h01000000
#define MKF_RIGHTBUTTONDOWN &h02000000
#define MKF_MOUSEMODE &h80000000

type tagACCESSTIMEOUT
	cbSize as UINT
	dwFlags as DWORD
	iTimeOutMSec as DWORD
end type

type ACCESSTIMEOUT as tagACCESSTIMEOUT
type LPACCESSTIMEOUT as tagACCESSTIMEOUT ptr
#define ATF_TIMEOUTON &h00000001
#define ATF_ONOFFFEEDBACK &h00000002
#define SSGF_NONE 0
#define SSGF_DISPLAY 3
#define SSTF_NONE 0
#define SSTF_CHARS 1
#define SSTF_BORDER 2
#define SSTF_DISPLAY 3
#define SSWF_NONE 0
#define SSWF_TITLE 1
#define SSWF_WINDOW 2
#define SSWF_DISPLAY 3
#define SSWF_CUSTOM 4

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

#define SSF_SOUNDSENTRYON &h00000001
#define SSF_AVAILABLE &h00000002
#define SSF_INDICATOR &h00000004

type tagTOGGLEKEYS
	cbSize as UINT
	dwFlags as DWORD
end type

type TOGGLEKEYS as tagTOGGLEKEYS
type LPTOGGLEKEYS as tagTOGGLEKEYS ptr
#define TKF_TOGGLEKEYSON &h00000001
#define TKF_AVAILABLE &h00000002
#define TKF_HOTKEYACTIVE &h00000004
#define TKF_CONFIRMHOTKEY &h00000008
#define TKF_HOTKEYSOUND &h00000010
#define TKF_INDICATOR &h00000020
declare sub SetDebugErrorLevel(byval dwLevel as DWORD)
#define SLE_ERROR &h00000001
#define SLE_MINORERROR &h00000002
#define SLE_WARNING &h00000003

declare sub SetLastErrorEx(byval dwErrCode as DWORD, byval dwType as DWORD)
declare function InternalGetWindowText(byval hWnd as HWND, byval pString as LPWSTR, byval cchMaxCount as long) as long
declare function EndTask(byval hWnd as HWND, byval fShutDown as WINBOOL, byval fForce as WINBOOL) as WINBOOL

#define MONITOR_DEFAULTTONULL &h00000000
#define MONITOR_DEFAULTTOPRIMARY &h00000001
#define MONITOR_DEFAULTTONEAREST &h00000002

declare function MonitorFromPoint(byval pt as POINT, byval dwFlags as DWORD) as HMONITOR
declare function MonitorFromRect(byval lprc as LPCRECT, byval dwFlags as DWORD) as HMONITOR
declare function MonitorFromWindow(byval hwnd as HWND, byval dwFlags as DWORD) as HMONITOR
#define MONITORINFOF_PRIMARY &h00000001

type tagMONITORINFO
	cbSize as DWORD
	rcMonitor as RECT
	rcWork as RECT
	dwFlags as DWORD
end type

type MONITORINFO as tagMONITORINFO
type LPMONITORINFO as tagMONITORINFO ptr

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
	#define GetMonitorInfo GetMonitorInfoW
#else
	type MONITORINFOEX as MONITORINFOEXA
	type LPMONITORINFOEX as LPMONITORINFOEXA
	#define GetMonitorInfo GetMonitorInfoA
#endif

declare function GetMonitorInfoA(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL
declare function GetMonitorInfoW(byval hMonitor as HMONITOR, byval lpmi as LPMONITORINFO) as WINBOOL
type MONITORENUMPROC as function(byval as HMONITOR, byval as HDC, byval as LPRECT, byval as LPARAM) as WINBOOL
declare function EnumDisplayMonitors(byval hdc as HDC, byval lprcClip as LPCRECT, byval lpfnEnum as MONITORENUMPROC, byval dwData as LPARAM) as WINBOOL
declare sub NotifyWinEvent(byval event as DWORD, byval hwnd as HWND, byval idObject as LONG, byval idChild as LONG)
type WINEVENTPROC as sub(byval hWinEventHook as HWINEVENTHOOK, byval event as DWORD, byval hwnd as HWND, byval idObject as LONG, byval idChild as LONG, byval idEventThread as DWORD, byval dwmsEventTime as DWORD)
declare function SetWinEventHook(byval eventMin as DWORD, byval eventMax as DWORD, byval hmodWinEventProc as HMODULE, byval pfnWinEventProc as WINEVENTPROC, byval idProcess as DWORD, byval idThread as DWORD, byval dwFlags as DWORD) as HWINEVENTHOOK
declare function IsWinEventHookInstalled(byval event as DWORD) as WINBOOL
#define WINEVENT_OUTOFCONTEXT &h0000
#define WINEVENT_SKIPOWNTHREAD &h0001
#define WINEVENT_SKIPOWNPROCESS &h0002
#define WINEVENT_INCONTEXT &h0004
declare function UnhookWinEvent(byval hWinEventHook as HWINEVENTHOOK) as WINBOOL
#define CHILDID_SELF 0
#define INDEXID_OBJECT 0
#define INDEXID_CONTAINER 0
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
#define EVENT_MIN &h00000001
#define EVENT_MAX &h7FFFFFFF
#define EVENT_SYSTEM_SOUND &h0001
#define EVENT_SYSTEM_ALERT &h0002
#define EVENT_SYSTEM_FOREGROUND &h0003
#define EVENT_SYSTEM_MENUSTART &h0004
#define EVENT_SYSTEM_MENUEND &h0005
#define EVENT_SYSTEM_MENUPOPUPSTART &h0006
#define EVENT_SYSTEM_MENUPOPUPEND &h0007
#define EVENT_SYSTEM_CAPTURESTART &h0008
#define EVENT_SYSTEM_CAPTUREEND &h0009
#define EVENT_SYSTEM_MOVESIZESTART &h000A
#define EVENT_SYSTEM_MOVESIZEEND &h000B
#define EVENT_SYSTEM_CONTEXTHELPSTART &h000C
#define EVENT_SYSTEM_CONTEXTHELPEND &h000D
#define EVENT_SYSTEM_DRAGDROPSTART &h000E
#define EVENT_SYSTEM_DRAGDROPEND &h000F
#define EVENT_SYSTEM_DIALOGSTART &h0010
#define EVENT_SYSTEM_DIALOGEND &h0011
#define EVENT_SYSTEM_SCROLLINGSTART &h0012
#define EVENT_SYSTEM_SCROLLINGEND &h0013
#define EVENT_SYSTEM_SWITCHSTART &h0014
#define EVENT_SYSTEM_SWITCHEND &h0015
#define EVENT_SYSTEM_MINIMIZESTART &h0016
#define EVENT_SYSTEM_MINIMIZEEND &h0017
#define EVENT_CONSOLE_CARET &h4001
#define EVENT_CONSOLE_UPDATE_REGION &h4002
#define EVENT_CONSOLE_UPDATE_SIMPLE &h4003
#define EVENT_CONSOLE_UPDATE_SCROLL &h4004
#define EVENT_CONSOLE_LAYOUT &h4005
#define EVENT_CONSOLE_START_APPLICATION &h4006
#define EVENT_CONSOLE_END_APPLICATION &h4007
#define CONSOLE_APPLICATION_16BIT &h0001
#define CONSOLE_CARET_SELECTION &h0001
#define CONSOLE_CARET_VISIBLE &h0002
#define EVENT_OBJECT_CREATE &h8000
#define EVENT_OBJECT_DESTROY &h8001
#define EVENT_OBJECT_SHOW &h8002
#define EVENT_OBJECT_HIDE &h8003
#define EVENT_OBJECT_REORDER &h8004
#define EVENT_OBJECT_FOCUS &h8005
#define EVENT_OBJECT_SELECTION &h8006
#define EVENT_OBJECT_SELECTIONADD &h8007
#define EVENT_OBJECT_SELECTIONREMOVE &h8008
#define EVENT_OBJECT_SELECTIONWITHIN &h8009
#define EVENT_OBJECT_STATECHANGE &h800A
#define EVENT_OBJECT_LOCATIONCHANGE &h800B
#define EVENT_OBJECT_NAMECHANGE &h800C
#define EVENT_OBJECT_DESCRIPTIONCHANGE &h800D
#define EVENT_OBJECT_VALUECHANGE &h800E
#define EVENT_OBJECT_PARENTCHANGE &h800F
#define EVENT_OBJECT_HELPCHANGE &h8010
#define EVENT_OBJECT_DEFACTIONCHANGE &h8011
#define EVENT_OBJECT_ACCELERATORCHANGE &h8012
#define SOUND_SYSTEM_STARTUP 1
#define SOUND_SYSTEM_SHUTDOWN 2
#define SOUND_SYSTEM_BEEP 3
#define SOUND_SYSTEM_ERROR 4
#define SOUND_SYSTEM_QUESTION 5
#define SOUND_SYSTEM_WARNING 6
#define SOUND_SYSTEM_INFORMATION 7
#define SOUND_SYSTEM_MAXIMIZE 8
#define SOUND_SYSTEM_MINIMIZE 9
#define SOUND_SYSTEM_RESTOREUP 10
#define SOUND_SYSTEM_RESTOREDOWN 11
#define SOUND_SYSTEM_APPSTART 12
#define SOUND_SYSTEM_FAULT 13
#define SOUND_SYSTEM_APPEND 14
#define SOUND_SYSTEM_MENUCOMMAND 15
#define SOUND_SYSTEM_MENUPOPUP 16
#define CSOUND_SYSTEM 16
#define ALERT_SYSTEM_INFORMATIONAL 1
#define ALERT_SYSTEM_WARNING 2
#define ALERT_SYSTEM_ERROR 3
#define ALERT_SYSTEM_QUERY 4
#define ALERT_SYSTEM_CRITICAL 5
#define CALERT_SYSTEM 6

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

#define GUI_CARETBLINKING &h00000001
#define GUI_INMOVESIZE &h00000002
#define GUI_INMENUMODE &h00000004
#define GUI_SYSTEMMENUMODE &h00000008
#define GUI_POPUPMENUMODE &h00000010
#define GUI_16BITTASK &h00000020

#ifdef UNICODE
	#define GetWindowModuleFileName GetWindowModuleFileNameW
#else
	#define GetWindowModuleFileName GetWindowModuleFileNameA
#endif

declare function GetGUIThreadInfo(byval idThread as DWORD, byval pgui as PGUITHREADINFO) as WINBOOL
declare function GetWindowModuleFileNameA(byval hwnd as HWND, byval pszFileName as LPSTR, byval cchFileNameMax as UINT) as UINT
declare function GetWindowModuleFileNameW(byval hwnd as HWND, byval pszFileName as LPWSTR, byval cchFileNameMax as UINT) as UINT

#define STATE_SYSTEM_UNAVAILABLE &h00000001
#define STATE_SYSTEM_SELECTED &h00000002
#define STATE_SYSTEM_FOCUSED &h00000004
#define STATE_SYSTEM_PRESSED &h00000008
#define STATE_SYSTEM_CHECKED &h00000010
#define STATE_SYSTEM_MIXED &h00000020
#define STATE_SYSTEM_INDETERMINATE STATE_SYSTEM_MIXED
#define STATE_SYSTEM_READONLY &h00000040
#define STATE_SYSTEM_HOTTRACKED &h00000080
#define STATE_SYSTEM_DEFAULT &h00000100
#define STATE_SYSTEM_EXPANDED &h00000200
#define STATE_SYSTEM_COLLAPSED &h00000400
#define STATE_SYSTEM_BUSY &h00000800
#define STATE_SYSTEM_FLOATING &h00001000
#define STATE_SYSTEM_MARQUEED &h00002000
#define STATE_SYSTEM_ANIMATED &h00004000
#define STATE_SYSTEM_INVISIBLE &h00008000
#define STATE_SYSTEM_OFFSCREEN &h00010000
#define STATE_SYSTEM_SIZEABLE &h00020000
#define STATE_SYSTEM_MOVEABLE &h00040000
#define STATE_SYSTEM_SELFVOICING &h00080000
#define STATE_SYSTEM_FOCUSABLE &h00100000
#define STATE_SYSTEM_SELECTABLE &h00200000
#define STATE_SYSTEM_LINKED &h00400000
#define STATE_SYSTEM_TRAVERSED &h00800000
#define STATE_SYSTEM_MULTISELECTABLE &h01000000
#define STATE_SYSTEM_EXTSELECTABLE &h02000000
#define STATE_SYSTEM_ALERT_LOW &h04000000
#define STATE_SYSTEM_ALERT_MEDIUM &h08000000
#define STATE_SYSTEM_ALERT_HIGH &h10000000
#define STATE_SYSTEM_PROTECTED &h20000000
#define STATE_SYSTEM_VALID &h3FFFFFFF
#define CCHILDREN_TITLEBAR 5
#define CCHILDREN_SCROLLBAR 5

type tagCURSORINFO
	cbSize as DWORD
	flags as DWORD
	hCursor as HCURSOR
	ptScreenPos as POINT
end type

type CURSORINFO as tagCURSORINFO
type PCURSORINFO as tagCURSORINFO ptr
type LPCURSORINFO as tagCURSORINFO ptr
#define CURSOR_SHOWING &h00000001
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
#define WS_ACTIVECAPTION &h0001
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

#define GA_PARENT 1
#define GA_ROOT 2
#define GA_ROOTOWNER 3

declare function GetAncestor(byval hwnd as HWND, byval gaFlags as UINT) as HWND
declare function RealChildWindowFromPoint(byval hwndParent as HWND, byval ptParentClientCoords as POINT) as HWND
declare function RealGetWindowClassA(byval hwnd as HWND, byval ptszClassName as LPSTR, byval cchClassNameMax as UINT) as UINT
declare function RealGetWindowClassW(byval hwnd as HWND, byval ptszClassName as LPWSTR, byval cchClassNameMax as UINT) as UINT

#ifdef UNICODE
	#define RealGetWindowClass RealGetWindowClassW
#else
	#define RealGetWindowClass RealGetWindowClassA
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

#ifdef UNICODE
	#define GetAltTabInfo GetAltTabInfoW
#else
	#define GetAltTabInfo GetAltTabInfoA
#endif

declare function GetAltTabInfoA(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPSTR, byval cchItemText as UINT) as WINBOOL
declare function GetAltTabInfoW(byval hwnd as HWND, byval iItem as long, byval pati as PALTTABINFO, byval pszItemText as LPWSTR, byval cchItemText as UINT) as WINBOOL
declare function GetListBoxInfo(byval hwnd as HWND) as DWORD
declare function LockWorkStation() as WINBOOL
declare function UserHandleGrantAccess(byval hUserHandle as HANDLE, byval hJob as HANDLE, byval bGrant as WINBOOL) as WINBOOL

type HRAWINPUT__
	unused as long
end type

type HRAWINPUT as HRAWINPUT__ ptr
#define GET_RAWINPUT_CODE_WPARAM(wParam) ((wParam) and &hff)
#define RIM_INPUT 0
#define RIM_INPUTSINK 1

type tagRAWINPUTHEADER
	dwType as DWORD
	dwSize as DWORD
	hDevice as HANDLE
	wParam as WPARAM
end type

type RAWINPUTHEADER as tagRAWINPUTHEADER
type PRAWINPUTHEADER as tagRAWINPUTHEADER ptr
type LPRAWINPUTHEADER as tagRAWINPUTHEADER ptr

#define RIM_TYPEMOUSE 0
#define RIM_TYPEKEYBOARD 1
#define RIM_TYPEHID 2

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

#define RI_MOUSE_LEFT_BUTTON_DOWN &h0001
#define RI_MOUSE_LEFT_BUTTON_UP &h0002
#define RI_MOUSE_RIGHT_BUTTON_DOWN &h0004
#define RI_MOUSE_RIGHT_BUTTON_UP &h0008
#define RI_MOUSE_MIDDLE_BUTTON_DOWN &h0010
#define RI_MOUSE_MIDDLE_BUTTON_UP &h0020
#define RI_MOUSE_BUTTON_1_DOWN RI_MOUSE_LEFT_BUTTON_DOWN
#define RI_MOUSE_BUTTON_1_UP RI_MOUSE_LEFT_BUTTON_UP
#define RI_MOUSE_BUTTON_2_DOWN RI_MOUSE_RIGHT_BUTTON_DOWN
#define RI_MOUSE_BUTTON_2_UP RI_MOUSE_RIGHT_BUTTON_UP
#define RI_MOUSE_BUTTON_3_DOWN RI_MOUSE_MIDDLE_BUTTON_DOWN
#define RI_MOUSE_BUTTON_3_UP RI_MOUSE_MIDDLE_BUTTON_UP
#define RI_MOUSE_BUTTON_4_DOWN &h0040
#define RI_MOUSE_BUTTON_4_UP &h0080
#define RI_MOUSE_BUTTON_5_DOWN &h0100
#define RI_MOUSE_BUTTON_5_UP &h0200
#define RI_MOUSE_WHEEL &h0400
#define MOUSE_MOVE_RELATIVE 0
#define MOUSE_MOVE_ABSOLUTE 1
#define MOUSE_VIRTUAL_DESKTOP &h02
#define MOUSE_ATTRIBUTES_CHANGED &h04

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

#define KEYBOARD_OVERRUN_MAKE_CODE &hFF
#define RI_KEY_MAKE 0
#define RI_KEY_BREAK 1
#define RI_KEY_E0 2
#define RI_KEY_E1 4
#define RI_KEY_TERMSRV_SET_LED 8
#define RI_KEY_TERMSRV_SHADOW &h10

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
#define RID_INPUT &h10000003
#define RID_HEADER &h10000005
declare function GetRawInputData(byval hRawInput as HRAWINPUT, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT, byval cbSizeHeader as UINT) as UINT
#define RIDI_PREPARSEDDATA &h20000005
#define RIDI_DEVICENAME &h20000007
#define RIDI_DEVICEINFO &h2000000b

type tagRID_DEVICE_INFO_MOUSE
	dwId as DWORD
	dwNumberOfButtons as DWORD
	dwSampleRate as DWORD
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

#ifdef UNICODE
	#define GetRawInputDeviceInfo GetRawInputDeviceInfoW
#else
	#define GetRawInputDeviceInfo GetRawInputDeviceInfoA
#endif

declare function GetRawInputDeviceInfoA(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT
declare function GetRawInputDeviceInfoW(byval hDevice as HANDLE, byval uiCommand as UINT, byval pData as LPVOID, byval pcbSize as PUINT) as UINT
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

#define RIDEV_REMOVE &h00000001
#define RIDEV_EXCLUDE &h00000010
#define RIDEV_PAGEONLY &h00000020
#define RIDEV_NOLEGACY &h00000030
#define RIDEV_INPUTSINK &h00000100
#define RIDEV_CAPTUREMOUSE &h00000200
#define RIDEV_NOHOTKEYS &h00000200
#define RIDEV_APPKEYS &h00000400
#define RIDEV_EXMODEMASK &h000000F0
#define RIDEV_EXMODE(mode) ((mode) and RIDEV_EXMODEMASK)
#define MAPVK_VK_TO_VSC 0
#define MAPVK_VSC_TO_VK 1
#define MAPVK_VK_TO_CHAR 2
#define MAPVK_VSC_TO_VK_EX 3

#if _WIN32_WINNT = &h0602
	#define MAPVK_VK_TO_VSC_EX 4
	#define WM_TOUCHMOVE 576
	#define WM_TOUCHDOWN 577
	#define WM_TOUCHUP 578
	#define TOUCHEVENTF_MOVE &h0001
	#define TOUCHEVENTF_DOWN &h0002
	#define TOUCHEVENTF_UP &h0004
	#define TOUCHEVENTF_INRANGE &h0008
	#define TOUCHEVENTF_PRIMARY &h0010
	#define TOUCHEVENTF_NOCOALESCE &h0020
	#define TOUCHEVENTF_PEN &h0040
	#define TOUCHEVENTF_PALM &h0080
	#define TOUCHINPUTMASKF_TIMEFROMSYSTEM &h0001
	#define TOUCHINPUTMASKF_EXTRAINFO &h0002
	#define TOUCHINPUTMASKF_CONTACTAREA &h0004

	type HTOUCHINPUT__
		unused as long
	end type

	type HTOUCHINPUT as HTOUCHINPUT__ ptr

	type _TOUCHINPUT
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

	type TOUCHINPUT as _TOUCHINPUT
	type PTOUCHINPUT as _TOUCHINPUT ptr
	declare function CloseTouchInputHandle(byval hTouchInput as HANDLE) as WINBOOL
	declare function GetTouchInputInfo(byval hTouchInput as HANDLE, byval cInputs as UINT, byval pInputs as PTOUCHINPUT, byval cbSize as long) as WINBOOL
	declare function IsTouchWindow(byval hWnd as HWND, byval pulFlags as PULONG) as WINBOOL
	declare function RegisterTouchWindow(byval hWnd as HWND, byval ulFlags as ULONG) as WINBOOL
	declare function UnregisterTouchWindow(byval hWnd as HWND) as WINBOOL
#endif

declare function RegisterRawInputDevices(byval pRawInputDevices as PCRAWINPUTDEVICE, byval uiNumDevices as UINT, byval cbSize as UINT) as WINBOOL
declare function GetRegisteredRawInputDevices(byval pRawInputDevices as PRAWINPUTDEVICE, byval puiNumDevices as PUINT, byval cbSize as UINT) as UINT

type tagRAWINPUTDEVICELIST
	hDevice as HANDLE
	dwType as DWORD
end type

type RAWINPUTDEVICELIST as tagRAWINPUTDEVICELIST
type PRAWINPUTDEVICELIST as tagRAWINPUTDEVICELIST ptr
declare function GetRawInputDeviceList(byval pRawInputDeviceList as PRAWINPUTDEVICELIST, byval puiNumDevices as PUINT, byval cbSize as UINT) as UINT
declare function DefRawInputProc(byval paRawInput as PRAWINPUT ptr, byval nInput as INT_, byval cbSizeHeader as UINT) as LRESULT

#if _WIN32_WINNT = &h0602
	type _AUDIODESCRIPTION
		cbSize as UINT
		Enabled as BOOL
		Locale as LCID
	end type

	type AUDIODESCRIPTION as _AUDIODESCRIPTION
	type PAUDIODESCRIPTION as _AUDIODESCRIPTION ptr
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define CreateDesktopEx CreateDesktopExW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define CreateDesktopEx CreateDesktopExA
#endif

#if _WIN32_WINNT = &h0602
	declare function CreateDesktopExA(byval lpszDesktop as LPCSTR, byval lpszDevice as LPCSTR, byval pDevmode as DEVMODE ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK
	declare function CreateDesktopExW(byval lpszDesktop as LPCWSTR, byval lpszDevice as LPCWSTR, byval pDevmode as DEVMODE ptr, byval dwFlags as DWORD, byval dwDesiredAccess as ACCESS_MASK, byval lpsa as LPSECURITY_ATTRIBUTES, byval ulHeapSize as ULONG, byval pvoid as PVOID) as HDESK
	declare function ShutdownBlockReasonCreate(byval hWnd as HWND, byval pwszReason as LPCWSTR) as WINBOOL
	declare function ShutdownBlockReasonDestroy(byval hWnd as HWND) as WINBOOL
	declare function ShutdownBlockReasonQuery(byval hWnd as HWND, byval pwszBuff as LPWSTR, byval pcchBuff as DWORD ptr) as WINBOOL

	#define GF_BEGIN &h00000001
	#define GF_INERTIA &h00000002
	#define GF_END &h00000004
	#define GID_BEGIN 1
	#define GID_END 2
	#define GID_ZOOM 3
	#define GID_PAN 4
	#define GID_ROTATE 5
	#define GID_TWOFINGERTAP 6
	#define GID_PRESSANDTAP 7
	#define GID_ROLLOVER GID_PRESSANDTAP
	#define GC_ALLGESTURES &h00000001
	#define GC_ZOOM &h00000001
	#define GC_PAN &h00000001
	#define GC_PAN_WITH_SINGLE_FINGER_VERTICALLY &h00000002
	#define GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY &h00000004
	#define GC_PAN_WITH_GUTTER &h00000008
	#define GC_PAN_WITH_INERTIA &h00000010
	#define GC_ROTATE &h00000001
	#define GC_TWOFINGERTAP &h00000001
	#define GC_PRESSANDTAP &h00000001
	#define GC_ROLLOVER GC_PRESSANDTAP
	#define GCF_INCLUDE_ANCESTORS &h00000001
	#define GESTURECONFIGMAXCOUNT 256

	type HGESTUREINFO__
		unused as long
	end type

	type HGESTUREINFO as HGESTUREINFO__ ptr
	#define GID_ROTATE_ANGLE_TO_ARGUMENT(_arg_) cast(USHORT, (((_arg_) + (2.0 * 3.14159265)) / (4.0 * 3.14159265)) * 65535.0)
	#define GID_ROTATE_ANGLE_FROM_ARGUMENT(_arg_) ((((cdbl((_arg_)) / 65535.0) * 4.0) * 3.14159265) - (2.0 * 3.14159265))

	type _GESTUREINFO
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

	type GESTUREINFO as _GESTUREINFO
	type PGESTUREINFO as _GESTUREINFO ptr
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

	type _GESTURECONFIG
		dwID as DWORD
		dwWant as DWORD
		dwBlock as DWORD
	end type

	type GESTURECONFIG as _GESTURECONFIG
	type PGESTURECONFIG as _GESTURECONFIG ptr
	declare function SetGestureConfig(byval hwnd as HWND, byval dwReserved as DWORD, byval cIDs as UINT, byval pGestureConfig as PGESTURECONFIG, byval cbSize as UINT) as WINBOOL
	declare function GetGestureConfig(byval hwnd as HWND, byval dwReserved as DWORD, byval dwFlags as DWORD, byval pcIDs as PUINT, byval pGestureConfig as PGESTURECONFIG, byval cbSize as UINT) as WINBOOL
	declare function GetGestureInfo(byval hGestureInfo as HGESTUREINFO, byval pGestureInfo as PGESTUREINFO) as WINBOOL
	declare function GetGestureExtraArgs(byval hGestureInfo as HGESTUREINFO, byval cbExtraArgs as UINT, byval pExtraArgs as PBYTE) as WINBOOL
	declare function CloseGestureInfoHandle(byval hGestureInfo as HGESTUREINFO) as WINBOOL
#endif

end extern
