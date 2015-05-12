''
''
'' Xfixes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xfixes_bi__
#define __Xfixes_bi__

#define XFIXES_REVISION 1

type XFixesSelectionNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
	owner as Window
	selection as Atom
	timestamp as Time
	selection_timestamp as Time
end type

type XFixesCursorNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	subtype as integer
	cursor_serial as uinteger
	timestamp as Time
	cursor_name as Atom
end type

type XFixesCursorImage
	x as short
	y as short
	width as ushort
	height as ushort
	xhot as ushort
	yhot as ushort
	cursor_serial as uinteger
	pixels as uinteger ptr
end type

declare function XFixesVersion cdecl alias "XFixesVersion" () as integer
declare sub XFixesChangeSaveSet cdecl alias "XFixesChangeSaveSet" (byval dpy as Display ptr, byval win as Window, byval mode as integer, byval target as integer, byval map as integer)
declare sub XFixesSelectSelectionInput cdecl alias "XFixesSelectSelectionInput" (byval dpy as Display ptr, byval win as Window, byval selection as Atom, byval eventMask as uinteger)
declare sub XFixesSelectCursorInput cdecl alias "XFixesSelectCursorInput" (byval dpy as Display ptr, byval win as Window, byval eventMask as uinteger)
declare function XFixesGetCursorImage cdecl alias "XFixesGetCursorImage" (byval dpy as Display ptr) as XFixesCursorImage ptr

#endif
