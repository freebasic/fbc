'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "_mingw_unicode.bi"
#include once "winapifamily.bi"

'' The following symbols have been renamed:
''     constant MOUSE_EVENT => MOUSE_EVENT_

extern "Windows"

#define _WINCON_

type _COORD
	X as SHORT
	Y as SHORT
end type

type COORD as _COORD
type PCOORD as _COORD ptr

type _SMALL_RECT
	Left as SHORT
	Top as SHORT
	Right as SHORT
	Bottom as SHORT
end type

type SMALL_RECT as _SMALL_RECT
type PSMALL_RECT as _SMALL_RECT ptr

union _KEY_EVENT_RECORD_uChar
	UnicodeChar as WCHAR
	AsciiChar as CHAR
end union

type _KEY_EVENT_RECORD
	bKeyDown as WINBOOL
	wRepeatCount as WORD
	wVirtualKeyCode as WORD
	wVirtualScanCode as WORD
	uChar as _KEY_EVENT_RECORD_uChar
	dwControlKeyState as DWORD
end type

type KEY_EVENT_RECORD as _KEY_EVENT_RECORD
type PKEY_EVENT_RECORD as _KEY_EVENT_RECORD ptr
const RIGHT_ALT_PRESSED = &h1
const LEFT_ALT_PRESSED = &h2
const RIGHT_CTRL_PRESSED = &h4
const LEFT_CTRL_PRESSED = &h8
const SHIFT_PRESSED = &h10
const NUMLOCK_ON = &h20
const SCROLLLOCK_ON = &h40
const CAPSLOCK_ON = &h80
const ENHANCED_KEY = &h100
const NLS_DBCSCHAR = &h10000
const NLS_ALPHANUMERIC = &h0
const NLS_KATAKANA = &h20000
const NLS_HIRAGANA = &h40000
const NLS_ROMAN = &h400000
const NLS_IME_CONVERSION = &h800000
const NLS_IME_DISABLE = &h20000000

type _MOUSE_EVENT_RECORD
	dwMousePosition as COORD
	dwButtonState as DWORD
	dwControlKeyState as DWORD
	dwEventFlags as DWORD
end type

type MOUSE_EVENT_RECORD as _MOUSE_EVENT_RECORD
type PMOUSE_EVENT_RECORD as _MOUSE_EVENT_RECORD ptr
const FROM_LEFT_1ST_BUTTON_PRESSED = &h1
const RIGHTMOST_BUTTON_PRESSED = &h2
const FROM_LEFT_2ND_BUTTON_PRESSED = &h4
const FROM_LEFT_3RD_BUTTON_PRESSED = &h8
const FROM_LEFT_4TH_BUTTON_PRESSED = &h10
const MOUSE_MOVED = &h1
const DOUBLE_CLICK = &h2
const MOUSE_WHEELED = &h4

#if _WIN32_WINNT >= &h0600
	const MOUSE_HWHEELED = &h8
#endif

type _WINDOW_BUFFER_SIZE_RECORD
	dwSize as COORD
end type

type WINDOW_BUFFER_SIZE_RECORD as _WINDOW_BUFFER_SIZE_RECORD
type PWINDOW_BUFFER_SIZE_RECORD as _WINDOW_BUFFER_SIZE_RECORD ptr

type _MENU_EVENT_RECORD
	dwCommandId as UINT
end type

type MENU_EVENT_RECORD as _MENU_EVENT_RECORD
type PMENU_EVENT_RECORD as _MENU_EVENT_RECORD ptr

type _FOCUS_EVENT_RECORD
	bSetFocus as WINBOOL
end type

type FOCUS_EVENT_RECORD as _FOCUS_EVENT_RECORD
type PFOCUS_EVENT_RECORD as _FOCUS_EVENT_RECORD ptr

union _INPUT_RECORD_Event
	KeyEvent as KEY_EVENT_RECORD
	MouseEvent as MOUSE_EVENT_RECORD
	WindowBufferSizeEvent as WINDOW_BUFFER_SIZE_RECORD
	MenuEvent as MENU_EVENT_RECORD
	FocusEvent as FOCUS_EVENT_RECORD
end union

type _INPUT_RECORD
	EventType as WORD
	Event as _INPUT_RECORD_Event
end type

type INPUT_RECORD as _INPUT_RECORD
type PINPUT_RECORD as _INPUT_RECORD ptr
const KEY_EVENT = &h1
const MOUSE_EVENT_ = &h2
const WINDOW_BUFFER_SIZE_EVENT = &h4
const MENU_EVENT = &h8
const FOCUS_EVENT = &h10

union _CHAR_INFO_Char
	UnicodeChar as WCHAR
	AsciiChar as CHAR
end union

type _CHAR_INFO
	Char as _CHAR_INFO_Char
	Attributes as WORD
end type

type CHAR_INFO as _CHAR_INFO
type PCHAR_INFO as _CHAR_INFO ptr
const FOREGROUND_BLUE = &h1
const FOREGROUND_GREEN = &h2
const FOREGROUND_RED = &h4
const FOREGROUND_INTENSITY = &h8
const BACKGROUND_BLUE = &h10
const BACKGROUND_GREEN = &h20
const BACKGROUND_RED = &h40
const BACKGROUND_INTENSITY = &h80
const COMMON_LVB_LEADING_BYTE = &h100
const COMMON_LVB_TRAILING_BYTE = &h200
const COMMON_LVB_GRID_HORIZONTAL = &h400
const COMMON_LVB_GRID_LVERTICAL = &h800
const COMMON_LVB_GRID_RVERTICAL = &h1000
const COMMON_LVB_REVERSE_VIDEO = &h4000
const COMMON_LVB_UNDERSCORE = &h8000
const COMMON_LVB_SBCSDBCS = &h300

type _CONSOLE_SCREEN_BUFFER_INFO
	dwSize as COORD
	dwCursorPosition as COORD
	wAttributes as WORD
	srWindow as SMALL_RECT
	dwMaximumWindowSize as COORD
end type

type CONSOLE_SCREEN_BUFFER_INFO as _CONSOLE_SCREEN_BUFFER_INFO
type PCONSOLE_SCREEN_BUFFER_INFO as _CONSOLE_SCREEN_BUFFER_INFO ptr

type _CONSOLE_CURSOR_INFO
	dwSize as DWORD
	bVisible as WINBOOL
end type

type CONSOLE_CURSOR_INFO as _CONSOLE_CURSOR_INFO
type PCONSOLE_CURSOR_INFO as _CONSOLE_CURSOR_INFO ptr

type _CONSOLE_FONT_INFO
	nFont as DWORD
	dwFontSize as COORD
end type

type CONSOLE_FONT_INFO as _CONSOLE_FONT_INFO
type PCONSOLE_FONT_INFO as _CONSOLE_FONT_INFO ptr

type _CONSOLE_SELECTION_INFO
	dwFlags as DWORD
	dwSelectionAnchor as COORD
	srSelection as SMALL_RECT
end type

type CONSOLE_SELECTION_INFO as _CONSOLE_SELECTION_INFO
type PCONSOLE_SELECTION_INFO as _CONSOLE_SELECTION_INFO ptr
const CONSOLE_NO_SELECTION = &h0
const CONSOLE_SELECTION_IN_PROGRESS = &h1
const CONSOLE_SELECTION_NOT_EMPTY = &h2
const CONSOLE_MOUSE_SELECTION = &h4
const CONSOLE_MOUSE_DOWN = &h8
type PHANDLER_ROUTINE as function(byval CtrlType as DWORD) as WINBOOL
const CTRL_C_EVENT = 0
const CTRL_BREAK_EVENT = 1
const CTRL_CLOSE_EVENT = 2
const CTRL_LOGOFF_EVENT = 5
const CTRL_SHUTDOWN_EVENT = 6
const ENABLE_PROCESSED_INPUT = &h1
const ENABLE_LINE_INPUT = &h2
const ENABLE_ECHO_INPUT = &h4
const ENABLE_WINDOW_INPUT = &h8
const ENABLE_MOUSE_INPUT = &h10
const ENABLE_INSERT_MODE = &h20
const ENABLE_QUICK_EDIT_MODE = &h40
const ENABLE_EXTENDED_FLAGS = &h80
const ENABLE_AUTO_POSITION = &h100
const ENABLE_PROCESSED_OUTPUT = &h1
const ENABLE_WRAP_AT_EOL_OUTPUT = &h2
declare function PeekConsoleInputA(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function PeekConsoleInput alias "PeekConsoleInputA"(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL
#endif

declare function PeekConsoleInputW(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function PeekConsoleInput alias "PeekConsoleInputW"(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL
#endif

declare function ReadConsoleInputA(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function ReadConsoleInput alias "ReadConsoleInputA"(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL
#endif

declare function ReadConsoleInputW(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function ReadConsoleInput alias "ReadConsoleInputW"(byval hConsoleInput as HANDLE, byval lpBuffer as PINPUT_RECORD, byval nLength as DWORD, byval lpNumberOfEventsRead as LPDWORD) as WINBOOL
#endif

declare function WriteConsoleInputA(byval hConsoleInput as HANDLE, byval lpBuffer as const INPUT_RECORD ptr, byval nLength as DWORD, byval lpNumberOfEventsWritten as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function WriteConsoleInput alias "WriteConsoleInputA"(byval hConsoleInput as HANDLE, byval lpBuffer as const INPUT_RECORD ptr, byval nLength as DWORD, byval lpNumberOfEventsWritten as LPDWORD) as WINBOOL
#endif

declare function WriteConsoleInputW(byval hConsoleInput as HANDLE, byval lpBuffer as const INPUT_RECORD ptr, byval nLength as DWORD, byval lpNumberOfEventsWritten as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function WriteConsoleInput alias "WriteConsoleInputW"(byval hConsoleInput as HANDLE, byval lpBuffer as const INPUT_RECORD ptr, byval nLength as DWORD, byval lpNumberOfEventsWritten as LPDWORD) as WINBOOL
#endif

declare function ReadConsoleOutputA(byval hConsoleOutput as HANDLE, byval lpBuffer as PCHAR_INFO, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpReadRegion as PSMALL_RECT) as WINBOOL

#ifndef UNICODE
	declare function ReadConsoleOutput alias "ReadConsoleOutputA"(byval hConsoleOutput as HANDLE, byval lpBuffer as PCHAR_INFO, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpReadRegion as PSMALL_RECT) as WINBOOL
#endif

declare function ReadConsoleOutputW(byval hConsoleOutput as HANDLE, byval lpBuffer as PCHAR_INFO, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpReadRegion as PSMALL_RECT) as WINBOOL

#ifdef UNICODE
	declare function ReadConsoleOutput alias "ReadConsoleOutputW"(byval hConsoleOutput as HANDLE, byval lpBuffer as PCHAR_INFO, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpReadRegion as PSMALL_RECT) as WINBOOL
#endif

declare function WriteConsoleOutputA(byval hConsoleOutput as HANDLE, byval lpBuffer as const CHAR_INFO ptr, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpWriteRegion as PSMALL_RECT) as WINBOOL

#ifndef UNICODE
	declare function WriteConsoleOutput alias "WriteConsoleOutputA"(byval hConsoleOutput as HANDLE, byval lpBuffer as const CHAR_INFO ptr, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpWriteRegion as PSMALL_RECT) as WINBOOL
#endif

declare function WriteConsoleOutputW(byval hConsoleOutput as HANDLE, byval lpBuffer as const CHAR_INFO ptr, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpWriteRegion as PSMALL_RECT) as WINBOOL

#ifdef UNICODE
	declare function WriteConsoleOutput alias "WriteConsoleOutputW"(byval hConsoleOutput as HANDLE, byval lpBuffer as const CHAR_INFO ptr, byval dwBufferSize as COORD, byval dwBufferCoord as COORD, byval lpWriteRegion as PSMALL_RECT) as WINBOOL
#endif

declare function ReadConsoleOutputCharacterA(byval hConsoleOutput as HANDLE, byval lpCharacter as LPSTR, byval nLength as DWORD, byval dwReadCoord as COORD, byval lpNumberOfCharsRead as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function ReadConsoleOutputCharacter alias "ReadConsoleOutputCharacterA"(byval hConsoleOutput as HANDLE, byval lpCharacter as LPSTR, byval nLength as DWORD, byval dwReadCoord as COORD, byval lpNumberOfCharsRead as LPDWORD) as WINBOOL
#endif

declare function ReadConsoleOutputCharacterW(byval hConsoleOutput as HANDLE, byval lpCharacter as LPWSTR, byval nLength as DWORD, byval dwReadCoord as COORD, byval lpNumberOfCharsRead as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function ReadConsoleOutputCharacter alias "ReadConsoleOutputCharacterW"(byval hConsoleOutput as HANDLE, byval lpCharacter as LPWSTR, byval nLength as DWORD, byval dwReadCoord as COORD, byval lpNumberOfCharsRead as LPDWORD) as WINBOOL
#endif

declare function ReadConsoleOutputAttribute(byval hConsoleOutput as HANDLE, byval lpAttribute as LPWORD, byval nLength as DWORD, byval dwReadCoord as COORD, byval lpNumberOfAttrsRead as LPDWORD) as WINBOOL
declare function WriteConsoleOutputCharacterA(byval hConsoleOutput as HANDLE, byval lpCharacter as LPCSTR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function WriteConsoleOutputCharacter alias "WriteConsoleOutputCharacterA"(byval hConsoleOutput as HANDLE, byval lpCharacter as LPCSTR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL
#endif

declare function WriteConsoleOutputCharacterW(byval hConsoleOutput as HANDLE, byval lpCharacter as LPCWSTR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function WriteConsoleOutputCharacter alias "WriteConsoleOutputCharacterW"(byval hConsoleOutput as HANDLE, byval lpCharacter as LPCWSTR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL
#endif

declare function WriteConsoleOutputAttribute(byval hConsoleOutput as HANDLE, byval lpAttribute as const WORD ptr, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfAttrsWritten as LPDWORD) as WINBOOL
declare function FillConsoleOutputCharacterA(byval hConsoleOutput as HANDLE, byval cCharacter as CHAR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function FillConsoleOutputCharacter alias "FillConsoleOutputCharacterA"(byval hConsoleOutput as HANDLE, byval cCharacter as CHAR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL
#endif

declare function FillConsoleOutputCharacterW(byval hConsoleOutput as HANDLE, byval cCharacter as WCHAR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function FillConsoleOutputCharacter alias "FillConsoleOutputCharacterW"(byval hConsoleOutput as HANDLE, byval cCharacter as WCHAR, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfCharsWritten as LPDWORD) as WINBOOL
#endif

declare function FillConsoleOutputAttribute(byval hConsoleOutput as HANDLE, byval wAttribute as WORD, byval nLength as DWORD, byval dwWriteCoord as COORD, byval lpNumberOfAttrsWritten as LPDWORD) as WINBOOL
declare function GetConsoleMode(byval hConsoleHandle as HANDLE, byval lpMode as LPDWORD) as WINBOOL
declare function GetNumberOfConsoleInputEvents(byval hConsoleInput as HANDLE, byval lpNumberOfEvents as LPDWORD) as WINBOOL
declare function GetConsoleScreenBufferInfo(byval hConsoleOutput as HANDLE, byval lpConsoleScreenBufferInfo as PCONSOLE_SCREEN_BUFFER_INFO) as WINBOOL
declare function GetLargestConsoleWindowSize(byval hConsoleOutput as HANDLE) as COORD
declare function GetConsoleCursorInfo(byval hConsoleOutput as HANDLE, byval lpConsoleCursorInfo as PCONSOLE_CURSOR_INFO) as WINBOOL
declare function GetCurrentConsoleFont(byval hConsoleOutput as HANDLE, byval bMaximumWindow as WINBOOL, byval lpConsoleCurrentFont as PCONSOLE_FONT_INFO) as WINBOOL
declare function GetConsoleFontSize(byval hConsoleOutput as HANDLE, byval nFont as DWORD) as COORD
declare function GetConsoleSelectionInfo(byval lpConsoleSelectionInfo as PCONSOLE_SELECTION_INFO) as WINBOOL
declare function GetNumberOfConsoleMouseButtons(byval lpNumberOfMouseButtons as LPDWORD) as WINBOOL
declare function SetConsoleMode(byval hConsoleHandle as HANDLE, byval dwMode as DWORD) as WINBOOL
declare function SetConsoleActiveScreenBuffer(byval hConsoleOutput as HANDLE) as WINBOOL
declare function FlushConsoleInputBuffer(byval hConsoleInput as HANDLE) as WINBOOL
declare function SetConsoleScreenBufferSize(byval hConsoleOutput as HANDLE, byval dwSize as COORD) as WINBOOL
declare function SetConsoleCursorPosition(byval hConsoleOutput as HANDLE, byval dwCursorPosition as COORD) as WINBOOL
declare function SetConsoleCursorInfo(byval hConsoleOutput as HANDLE, byval lpConsoleCursorInfo as const CONSOLE_CURSOR_INFO ptr) as WINBOOL
declare function ScrollConsoleScreenBufferA(byval hConsoleOutput as HANDLE, byval lpScrollRectangle as const SMALL_RECT ptr, byval lpClipRectangle as const SMALL_RECT ptr, byval dwDestinationOrigin as COORD, byval lpFill as const CHAR_INFO ptr) as WINBOOL

#ifndef UNICODE
	declare function ScrollConsoleScreenBuffer alias "ScrollConsoleScreenBufferA"(byval hConsoleOutput as HANDLE, byval lpScrollRectangle as const SMALL_RECT ptr, byval lpClipRectangle as const SMALL_RECT ptr, byval dwDestinationOrigin as COORD, byval lpFill as const CHAR_INFO ptr) as WINBOOL
#endif

declare function ScrollConsoleScreenBufferW(byval hConsoleOutput as HANDLE, byval lpScrollRectangle as const SMALL_RECT ptr, byval lpClipRectangle as const SMALL_RECT ptr, byval dwDestinationOrigin as COORD, byval lpFill as const CHAR_INFO ptr) as WINBOOL

#ifdef UNICODE
	declare function ScrollConsoleScreenBuffer alias "ScrollConsoleScreenBufferW"(byval hConsoleOutput as HANDLE, byval lpScrollRectangle as const SMALL_RECT ptr, byval lpClipRectangle as const SMALL_RECT ptr, byval dwDestinationOrigin as COORD, byval lpFill as const CHAR_INFO ptr) as WINBOOL
#endif

declare function SetConsoleWindowInfo(byval hConsoleOutput as HANDLE, byval bAbsolute as WINBOOL, byval lpConsoleWindow as const SMALL_RECT ptr) as WINBOOL
declare function SetConsoleTextAttribute(byval hConsoleOutput as HANDLE, byval wAttributes as WORD) as WINBOOL
declare function SetConsoleCtrlHandler(byval HandlerRoutine as PHANDLER_ROUTINE, byval Add as WINBOOL) as WINBOOL
declare function GenerateConsoleCtrlEvent(byval dwCtrlEvent as DWORD, byval dwProcessGroupId as DWORD) as WINBOOL
declare function AllocConsole() as WINBOOL
declare function FreeConsole() as WINBOOL
declare function AttachConsole(byval dwProcessId as DWORD) as WINBOOL
const ATTACH_PARENT_PROCESS = cast(DWORD, -1)
declare function GetConsoleTitleA(byval lpConsoleTitle as LPSTR, byval nSize as DWORD) as DWORD

#ifndef UNICODE
	declare function GetConsoleTitle alias "GetConsoleTitleA"(byval lpConsoleTitle as LPSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetConsoleTitleW(byval lpConsoleTitle as LPWSTR, byval nSize as DWORD) as DWORD

#ifdef UNICODE
	declare function GetConsoleTitle alias "GetConsoleTitleW"(byval lpConsoleTitle as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function SetConsoleTitleA(byval lpConsoleTitle as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function SetConsoleTitle alias "SetConsoleTitleA"(byval lpConsoleTitle as LPCSTR) as WINBOOL
#endif

declare function SetConsoleTitleW(byval lpConsoleTitle as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function SetConsoleTitle alias "SetConsoleTitleW"(byval lpConsoleTitle as LPCWSTR) as WINBOOL
#endif

declare function ReadConsoleA(byval hConsoleInput as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfCharsToRead as DWORD, byval lpNumberOfCharsRead as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function ReadConsole alias "ReadConsoleA"(byval hConsoleInput as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfCharsToRead as DWORD, byval lpNumberOfCharsRead as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function ReadConsoleW(byval hConsoleInput as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfCharsToRead as DWORD, byval lpNumberOfCharsRead as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function ReadConsole alias "ReadConsoleW"(byval hConsoleInput as HANDLE, byval lpBuffer as LPVOID, byval nNumberOfCharsToRead as DWORD, byval lpNumberOfCharsRead as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function WriteConsoleA(byval hConsoleOutput as HANDLE, byval lpBuffer as const any ptr, byval nNumberOfCharsToWrite as DWORD, byval lpNumberOfCharsWritten as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function WriteConsole alias "WriteConsoleA"(byval hConsoleOutput as HANDLE, byval lpBuffer as const any ptr, byval nNumberOfCharsToWrite as DWORD, byval lpNumberOfCharsWritten as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function WriteConsoleW(byval hConsoleOutput as HANDLE, byval lpBuffer as const any ptr, byval nNumberOfCharsToWrite as DWORD, byval lpNumberOfCharsWritten as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function WriteConsole alias "WriteConsoleW"(byval hConsoleOutput as HANDLE, byval lpBuffer as const any ptr, byval nNumberOfCharsToWrite as DWORD, byval lpNumberOfCharsWritten as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

const CONSOLE_TEXTMODE_BUFFER = 1
declare function CreateConsoleScreenBuffer(byval dwDesiredAccess as DWORD, byval dwShareMode as DWORD, byval lpSecurityAttributes as const SECURITY_ATTRIBUTES ptr, byval dwFlags as DWORD, byval lpScreenBufferData as LPVOID) as HANDLE
declare function GetConsoleCP() as UINT
declare function SetConsoleCP(byval wCodePageID as UINT) as WINBOOL
declare function GetConsoleOutputCP() as UINT
declare function SetConsoleOutputCP(byval wCodePageID as UINT) as WINBOOL
const CONSOLE_FULLSCREEN = 1
const CONSOLE_FULLSCREEN_HARDWARE = 2
declare function GetConsoleDisplayMode(byval lpModeFlags as LPDWORD) as WINBOOL
const CONSOLE_FULLSCREEN_MODE = 1
const CONSOLE_WINDOWED_MODE = 2
declare function SetConsoleDisplayMode(byval hConsoleOutput as HANDLE, byval dwFlags as DWORD, byval lpNewScreenBufferDimensions as PCOORD) as WINBOOL
declare function GetConsoleWindow() as HWND
declare function GetConsoleProcessList(byval lpdwProcessList as LPDWORD, byval dwProcessCount as DWORD) as DWORD
declare function AddConsoleAliasA(byval Source as LPSTR, byval Target as LPSTR, byval ExeName as LPSTR) as WINBOOL

#ifndef UNICODE
	declare function AddConsoleAlias alias "AddConsoleAliasA"(byval Source as LPSTR, byval Target as LPSTR, byval ExeName as LPSTR) as WINBOOL
#endif

declare function AddConsoleAliasW(byval Source as LPWSTR, byval Target as LPWSTR, byval ExeName as LPWSTR) as WINBOOL

#ifdef UNICODE
	declare function AddConsoleAlias alias "AddConsoleAliasW"(byval Source as LPWSTR, byval Target as LPWSTR, byval ExeName as LPWSTR) as WINBOOL
#endif

declare function GetConsoleAliasA(byval Source as LPSTR, byval TargetBuffer as LPSTR, byval TargetBufferLength as DWORD, byval ExeName as LPSTR) as DWORD

#ifndef UNICODE
	declare function GetConsoleAlias alias "GetConsoleAliasA"(byval Source as LPSTR, byval TargetBuffer as LPSTR, byval TargetBufferLength as DWORD, byval ExeName as LPSTR) as DWORD
#endif

declare function GetConsoleAliasW(byval Source as LPWSTR, byval TargetBuffer as LPWSTR, byval TargetBufferLength as DWORD, byval ExeName as LPWSTR) as DWORD

#ifdef UNICODE
	declare function GetConsoleAlias alias "GetConsoleAliasW"(byval Source as LPWSTR, byval TargetBuffer as LPWSTR, byval TargetBufferLength as DWORD, byval ExeName as LPWSTR) as DWORD
#endif

declare function GetConsoleAliasesLengthA(byval ExeName as LPSTR) as DWORD

#ifndef UNICODE
	declare function GetConsoleAliasesLength alias "GetConsoleAliasesLengthA"(byval ExeName as LPSTR) as DWORD
#endif

declare function GetConsoleAliasesLengthW(byval ExeName as LPWSTR) as DWORD

#ifdef UNICODE
	declare function GetConsoleAliasesLength alias "GetConsoleAliasesLengthW"(byval ExeName as LPWSTR) as DWORD
#endif

declare function GetConsoleAliasExesLengthA() as DWORD

#ifndef UNICODE
	declare function GetConsoleAliasExesLength alias "GetConsoleAliasExesLengthA"() as DWORD
#endif

declare function GetConsoleAliasExesLengthW() as DWORD

#ifdef UNICODE
	declare function GetConsoleAliasExesLength alias "GetConsoleAliasExesLengthW"() as DWORD
#endif

declare function GetConsoleAliasesA(byval AliasBuffer as LPSTR, byval AliasBufferLength as DWORD, byval ExeName as LPSTR) as DWORD

#ifndef UNICODE
	declare function GetConsoleAliases alias "GetConsoleAliasesA"(byval AliasBuffer as LPSTR, byval AliasBufferLength as DWORD, byval ExeName as LPSTR) as DWORD
#endif

declare function GetConsoleAliasesW(byval AliasBuffer as LPWSTR, byval AliasBufferLength as DWORD, byval ExeName as LPWSTR) as DWORD

#ifdef UNICODE
	declare function GetConsoleAliases alias "GetConsoleAliasesW"(byval AliasBuffer as LPWSTR, byval AliasBufferLength as DWORD, byval ExeName as LPWSTR) as DWORD
#endif

declare function GetConsoleAliasExesA(byval ExeNameBuffer as LPSTR, byval ExeNameBufferLength as DWORD) as DWORD

#ifndef UNICODE
	declare function GetConsoleAliasExes alias "GetConsoleAliasExesA"(byval ExeNameBuffer as LPSTR, byval ExeNameBufferLength as DWORD) as DWORD
#endif

declare function GetConsoleAliasExesW(byval ExeNameBuffer as LPWSTR, byval ExeNameBufferLength as DWORD) as DWORD

#ifdef UNICODE
	declare function GetConsoleAliasExes alias "GetConsoleAliasExesW"(byval ExeNameBuffer as LPWSTR, byval ExeNameBufferLength as DWORD) as DWORD
#endif

type _CONSOLE_FONT_INFOEX
	cbSize as ULONG
	nFont as DWORD
	dwFontSize as COORD
	FontFamily as UINT
	FontWeight as UINT
	FaceName as wstring * 32
end type

type CONSOLE_FONT_INFOEX as _CONSOLE_FONT_INFOEX
type PCONSOLE_FONT_INFOEX as _CONSOLE_FONT_INFOEX ptr

type _CONSOLE_HISTORY_INFO
	cbSize as UINT
	HistoryBufferSize as UINT
	NumberOfHistoryBuffers as UINT
	dwFlags as DWORD
end type

type CONSOLE_HISTORY_INFO as _CONSOLE_HISTORY_INFO
type PCONSOLE_HISTORY_INFO as _CONSOLE_HISTORY_INFO ptr

type _CONSOLE_READCONSOLE_CONTROL
	nLength as ULONG
	nInitialChars as ULONG
	dwCtrlWakeupMask as ULONG
	dwControlKeyState as ULONG
end type

type CONSOLE_READCONSOLE_CONTROL as _CONSOLE_READCONSOLE_CONTROL
type PCONSOLE_READCONSOLE_CONTROL as _CONSOLE_READCONSOLE_CONTROL ptr

type _CONSOLE_SCREEN_BUFFER_INFOEX
	cbSize as ULONG
	dwSize as COORD
	dwCursorPosition as COORD
	wAttributes as WORD
	srWindow as SMALL_RECT
	dwMaximumWindowSize as COORD
	wPopupAttributes as WORD
	bFullscreenSupported as WINBOOL
	ColorTable(0 to 15) as COLORREF
end type

type CONSOLE_SCREEN_BUFFER_INFOEX as _CONSOLE_SCREEN_BUFFER_INFOEX
type PCONSOLE_SCREEN_BUFFER_INFOEX as _CONSOLE_SCREEN_BUFFER_INFOEX ptr
declare function GetConsoleHistoryInfo(byval lpConsoleHistoryInfo as PCONSOLE_HISTORY_INFO) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function GetConsoleOriginalTitleA(byval lpConsoleTitle as LPSTR, byval nSize as DWORD) as DWORD
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function GetConsoleOriginalTitle alias "GetConsoleOriginalTitleA"(byval lpConsoleTitle as LPSTR, byval nSize as DWORD) as DWORD
#endif

#if _WIN32_WINNT >= &h0600
	declare function GetConsoleOriginalTitleW(byval lpConsoleTitle as LPWSTR, byval nSize as DWORD) as DWORD
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function GetConsoleOriginalTitle alias "GetConsoleOriginalTitleW"(byval lpConsoleTitle as LPWSTR, byval nSize as DWORD) as DWORD
#endif

declare function GetConsoleScreenBufferInfoEx(byval hConsoleOutput as HANDLE, byval lpConsoleScreenBufferInfoEx as PCONSOLE_SCREEN_BUFFER_INFOEX) as WINBOOL
declare function GetCurrentConsoleFontEx(byval hConsoleOutput as HANDLE, byval bMaximumWindow as WINBOOL, byval lpConsoleCurrentFontEx as PCONSOLE_FONT_INFOEX) as WINBOOL
declare function SetConsoleHistoryInfo(byval lpConsoleHistoryInfo as PCONSOLE_HISTORY_INFO) as WINBOOL
declare function SetConsoleScreenBufferInfoEx(byval hConsoleOutput as HANDLE, byval lpConsoleScreenBufferInfoEx as PCONSOLE_SCREEN_BUFFER_INFOEX) as WINBOOL
declare function SetCurrentConsoleFontEx(byval hConsoleOutput as HANDLE, byval bMaximumWindow as WINBOOL, byval lpConsoleCurrentFontEx as PCONSOLE_FONT_INFOEX) as WINBOOL

end extern
