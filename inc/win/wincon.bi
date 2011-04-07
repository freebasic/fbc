''
''
'' wincon -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_wincon_bi__
#define __win_wincon_bi__

#define FOREGROUND_BLUE 1
#define FOREGROUND_GREEN 2
#define FOREGROUND_RED 4
#define FOREGROUND_INTENSITY 8
#define BACKGROUND_BLUE 16
#define BACKGROUND_GREEN 32
#define BACKGROUND_RED 64
#define BACKGROUND_INTENSITY 128
#define CONSOLE_FULLSCREEN_MODE 1
#define CONSOLE_WINDOWED_MODE 2
#define CTRL_C_EVENT 0
#define CTRL_BREAK_EVENT 1
#define CTRL_CLOSE_EVENT 2
#define CTRL_LOGOFF_EVENT 5
#define CTRL_SHUTDOWN_EVENT 6
#define ENABLE_LINE_INPUT 2
#define ENABLE_ECHO_INPUT 4
#define ENABLE_PROCESSED_INPUT 1
#define ENABLE_WINDOW_INPUT 8
#define ENABLE_MOUSE_INPUT 16
#define ENABLE_PROCESSED_OUTPUT 1
#define ENABLE_WRAP_AT_EOL_OUTPUT 2
#define KEY_EVENT 1
#define MOUSE_EVENT_ 2
#define WINDOW_BUFFER_SIZE_EVENT 4
#define MENU_EVENT 8
#define FOCUS_EVENT 16
#define CAPSLOCK_ON 128
#define ENHANCED_KEY 256
#define RIGHT_ALT_PRESSED 1
#define LEFT_ALT_PRESSED 2
#define RIGHT_CTRL_PRESSED 4
#define LEFT_CTRL_PRESSED 8
#define SHIFT_PRESSED 16
#define NUMLOCK_ON 32
#define SCROLLLOCK_ON 64
#define FROM_LEFT_1ST_BUTTON_PRESSED 1
#define RIGHTMOST_BUTTON_PRESSED 2
#define FROM_LEFT_2ND_BUTTON_PRESSED 4
#define FROM_LEFT_3RD_BUTTON_PRESSED 8
#define FROM_LEFT_4TH_BUTTON_PRESSED 16
#define MOUSE_MOVED 1
#define DOUBLE_CLICK 2
#define MOUSE_WHEELED 4

union CHAR_INFO_Char
	UnicodeChar as WCHAR
	AsciiChar as CHAR
end union

type CHAR_INFO
	Char as CHAR_INFO_Char
	Attributes as WORD
end type

type PCHAR_INFO as CHAR_INFO ptr

type SMALL_RECT
	Left as SHORT
	Top as SHORT
	Right as SHORT
	Bottom as SHORT
end type

type PSMALL_RECT as SMALL_RECT ptr

type CONSOLE_CURSOR_INFO
	dwSize as DWORD
	bVisible as BOOL
end type

type PCONSOLE_CURSOR_INFO as CONSOLE_CURSOR_INFO ptr

type COORD
	X as SHORT
	Y as SHORT
end type

type CONSOLE_FONT_INFO
	nFont as DWORD
	dwFontSize as COORD
end type

type PCONSOLE_FONT_INFO as CONSOLE_FONT_INFO ptr

type CONSOLE_SCREEN_BUFFER_INFO
	dwSize as COORD
	dwCursorPosition as COORD
	wAttributes as WORD
	srWindow as SMALL_RECT
	dwMaximumWindowSize as COORD
end type

type PCONSOLE_SCREEN_BUFFER_INFO as CONSOLE_SCREEN_BUFFER_INFO ptr
type PHANDLER_ROUTINE as function (byval as DWORD) as BOOL

union KEY_EVENT_RECORD_uChar
	UnicodeChar as WCHAR
	AsciiChar as CHAR
end union

type KEY_EVENT_RECORD
	bKeyDown as BOOL
	wRepeatCount as WORD
	wVirtualKeyCode as WORD
	wVirtualScanCode as WORD
	uChar as KEY_EVENT_RECORD_uChar
	dwControlKeyState as DWORD
end type

type MOUSE_EVENT_RECORD
	dwMousePosition as COORD
	dwButtonState as DWORD
	dwControlKeyState as DWORD
	dwEventFlags as DWORD
end type

type WINDOW_BUFFER_SIZE_RECORD
	dwSize as COORD
end type

type MENU_EVENT_RECORD
	dwCommandId as UINT
end type

type PMENU_EVENT_RECORD as MENU_EVENT_RECORD ptr

type FOCUS_EVENT_RECORD
	bSetFocus as BOOL
end type

union INPUT_RECORD_Event
	KeyEvent as KEY_EVENT_RECORD
	MouseEvent as MOUSE_EVENT_RECORD
	WindowBufferSizeEvent as WINDOW_BUFFER_SIZE_RECORD
	MenuEvent as MENU_EVENT_RECORD
	FocusEvent as FOCUS_EVENT_RECORD
end union

type INPUT_RECORD
	EventType as WORD
	Event as INPUT_RECORD_Event
end type

type PINPUT_RECORD as INPUT_RECORD ptr

declare function AllocConsole alias "AllocConsole" () as BOOL
declare function AttachConsole alias "AttachConsole" (byval as DWORD) as BOOL
declare function CreateConsoleScreenBuffer alias "CreateConsoleScreenBuffer" (byval as DWORD, byval as DWORD, byval as SECURITY_ATTRIBUTES ptr, byval as DWORD, byval as LPVOID) as HANDLE
declare function FillConsoleOutputAttribute alias "FillConsoleOutputAttribute" (byval as HANDLE, byval as WORD, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
declare function FlushConsoleInputBuffer alias "FlushConsoleInputBuffer" (byval as HANDLE) as BOOL
declare function FreeConsole alias "FreeConsole" () as BOOL
declare function GenerateConsoleCtrlEvent alias "GenerateConsoleCtrlEvent" (byval as DWORD, byval as DWORD) as BOOL
declare function GetConsoleCP alias "GetConsoleCP" () as UINT
declare function GetConsoleCursorInfo alias "GetConsoleCursorInfo" (byval as HANDLE, byval as PCONSOLE_CURSOR_INFO) as BOOL
declare function GetConsoleMode alias "GetConsoleMode" (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetConsoleOutputCP alias "GetConsoleOutputCP" () as UINT
declare function GetConsoleScreenBufferInfo alias "GetConsoleScreenBufferInfo" (byval as HANDLE, byval as PCONSOLE_SCREEN_BUFFER_INFO) as BOOL
declare function GetConsoleDisplayMode alias "GetConsoleDisplayMode" (byval as LPDWORD) as BOOL
declare function GetConsoleWindow alias "GetConsoleWindow" () as HWND
declare function GetLargestConsoleWindowSize alias "GetLargestConsoleWindowSize" (byval as HANDLE) as COORD
declare function GetNumberOfConsoleInputEvents alias "GetNumberOfConsoleInputEvents" (byval as HANDLE, byval as PDWORD) as BOOL
declare function GetNumberOfConsoleMouseButtons alias "GetNumberOfConsoleMouseButtons" (byval as PDWORD) as BOOL
declare function ReadConsoleOutputAttribute alias "ReadConsoleOutputAttribute" (byval as HANDLE, byval as LPWORD, byval as DWORD, byval as COORD, byval as LPDWORD) as BOOL
declare function SetConsoleActiveScreenBuffer alias "SetConsoleActiveScreenBuffer" (byval as HANDLE) as BOOL
declare function SetConsoleCP alias "SetConsoleCP" (byval as UINT) as BOOL
declare function SetConsoleCtrlHandler alias "SetConsoleCtrlHandler" (byval as PHANDLER_ROUTINE, byval as BOOL) as BOOL
declare function SetConsoleCursorInfo alias "SetConsoleCursorInfo" (byval as HANDLE, byval as CONSOLE_CURSOR_INFO ptr) as BOOL
declare function SetConsoleCursorPosition alias "SetConsoleCursorPosition" (byval as HANDLE, byval as COORD) as BOOL
declare function SetConsoleDisplayMode alias "SetConsoleDisplayMode" (byval as HANDLE, byval as DWORD, byval as COORD ptr) as BOOL
declare function SetConsoleMode alias "SetConsoleMode" (byval as HANDLE, byval as DWORD) as BOOL
declare function SetConsoleOutputCP alias "SetConsoleOutputCP" (byval as UINT) as BOOL
declare function SetConsoleScreenBufferSize alias "SetConsoleScreenBufferSize" (byval as HANDLE, byval as COORD) as BOOL
declare function SetConsoleTextAttribute alias "SetConsoleTextAttribute" (byval as HANDLE, byval as WORD) as BOOL
declare function SetConsoleWindowInfo alias "SetConsoleWindowInfo" (byval as HANDLE, byval as BOOL, byval as SMALL_RECT ptr) as BOOL
declare function WriteConsoleOutputAttribute alias "WriteConsoleOutputAttribute" (byval as HANDLE, byval as WORD ptr, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL

#ifdef UNICODE
declare function FillConsoleOutputCharacter alias "FillConsoleOutputCharacterW" (byval as HANDLE, byval as WCHAR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
declare function GetConsoleTitle alias "GetConsoleTitleW" (byval as LPWSTR, byval as DWORD) as DWORD
declare function PeekConsoleInput alias "PeekConsoleInputW" (byval as HANDLE, byval as PINPUT_RECORD, byval as DWORD, byval as PDWORD) as BOOL
declare function ReadConsole alias "ReadConsoleW" (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD, byval as PVOID) as BOOL
declare function ReadConsoleInput alias "ReadConsoleInputW" (byval as HANDLE, byval as PINPUT_RECORD, byval as DWORD, byval as PDWORD) as BOOL
declare function ReadConsoleOutputCharacter alias "ReadConsoleOutputCharacterW" (byval as HANDLE, byval as LPWSTR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
declare function ReadConsoleOutput alias "ReadConsoleOutputW" (byval as HANDLE, byval as PCHAR_INFO, byval as COORD, byval as COORD, byval as PSMALL_RECT) as BOOL
declare function ScrollConsoleScreenBuffer alias "ScrollConsoleScreenBufferW" (byval as HANDLE, byval as SMALL_RECT ptr, byval as SMALL_RECT ptr, byval as COORD, byval as CHAR_INFO ptr) as BOOL
declare function SetConsoleTitle alias "SetConsoleTitleW" (byval as LPCWSTR) as BOOL
declare function WriteConsole alias "WriteConsoleW" (byval as HANDLE, byval as PCVOID, byval as DWORD, byval as PDWORD, byval as PVOID) as BOOL
declare function WriteConsoleInput alias "WriteConsoleInputW" (byval as HANDLE, byval as INPUT_RECORD ptr, byval as DWORD, byval as PDWORD) as BOOL
declare function WriteConsoleOutput alias "WriteConsoleOutputW" (byval as HANDLE, byval as CHAR_INFO ptr, byval as COORD, byval as COORD, byval as PSMALL_RECT) as BOOL
declare function WriteConsoleOutputCharacter alias "WriteConsoleOutputCharacterW" (byval as HANDLE, byval as LPCWSTR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL

#else ''UNICODE
declare function FillConsoleOutputCharacter alias "FillConsoleOutputCharacterA" (byval as HANDLE, byval as CHAR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
declare function GetConsoleTitle alias "GetConsoleTitleA" (byval as LPSTR, byval as DWORD) as DWORD
declare function PeekConsoleInput alias "PeekConsoleInputA" (byval as HANDLE, byval as PINPUT_RECORD, byval as DWORD, byval as PDWORD) as BOOL
declare function ReadConsole alias "ReadConsoleA" (byval as HANDLE, byval as PVOID, byval as DWORD, byval as PDWORD, byval as PVOID) as BOOL
declare function ReadConsoleInput alias "ReadConsoleInputA" (byval as HANDLE, byval as PINPUT_RECORD, byval as DWORD, byval as PDWORD) as BOOL
declare function ReadConsoleOutputCharacter alias "ReadConsoleOutputCharacterA" (byval as HANDLE, byval as LPSTR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
declare function ReadConsoleOutput alias "ReadConsoleOutputA" (byval as HANDLE, byval as PCHAR_INFO, byval as COORD, byval as COORD, byval as PSMALL_RECT) as BOOL
declare function ScrollConsoleScreenBuffer alias "ScrollConsoleScreenBufferA" (byval as HANDLE, byval as SMALL_RECT ptr, byval as SMALL_RECT ptr, byval as COORD, byval as CHAR_INFO ptr) as BOOL
declare function SetConsoleTitle alias "SetConsoleTitleA" (byval as LPCSTR) as BOOL
declare function WriteConsole alias "WriteConsoleA" (byval as HANDLE, byval as PCVOID, byval as DWORD, byval as PDWORD, byval as PVOID) as BOOL
declare function WriteConsoleInput alias "WriteConsoleInputA" (byval as HANDLE, byval as INPUT_RECORD ptr, byval as DWORD, byval as PDWORD) as BOOL
declare function WriteConsoleOutput alias "WriteConsoleOutputA" (byval as HANDLE, byval as CHAR_INFO ptr, byval as COORD, byval as COORD, byval as PSMALL_RECT) as BOOL
declare function WriteConsoleOutputCharacter alias "WriteConsoleOutputCharacterA" (byval as HANDLE, byval as LPCSTR, byval as DWORD, byval as COORD, byval as PDWORD) as BOOL
#endif ''UNICODE

#endif
