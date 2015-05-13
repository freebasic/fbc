''
''
'' extutil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __extutil_bi__
#define __extutil_bi__

type _XExtDisplayInfo
	next as _XExtDisplayInfo ptr
	display as Display ptr
	codes as XExtCodes ptr
	data as XPointer
end type

type XExtDisplayInfo as _XExtDisplayInfo

type _XExtensionInfo
	head as XExtDisplayInfo ptr
	cur as XExtDisplayInfo ptr
	ndisplays as integer
end type

type XExtensionInfo as _XExtensionInfo

type _XExtensionHooks
	create_gc as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
	copy_gc as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
	flush_gc as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
	free_gc as function cdecl(byval as Display ptr, byval as GC, byval as XExtCodes ptr) as integer
	create_font as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer
	free_font as function cdecl(byval as Display ptr, byval as XFontStruct ptr, byval as XExtCodes ptr) as integer
	close_display as function cdecl(byval as Display ptr, byval as XExtCodes ptr) as integer
	wire_to_event as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Bool
	event_to_wire as function cdecl(byval as Display ptr, byval as XEvent ptr, byval as xEvent ptr) as Status
	error as function cdecl(byval as Display ptr, byval as xError ptr, byval as XExtCodes ptr, byval as integer ptr) as integer
	error_string as function cdecl(byval as Display ptr, byval as integer, byval as XExtCodes ptr, byval as zstring ptr, byval as integer) as byte ptr
end type

type XExtensionHooks as _XExtensionHooks

declare function XextCreateExtension cdecl alias "XextCreateExtension" () as XExtensionInfo ptr
declare sub XextDestroyExtension cdecl alias "XextDestroyExtension" (byval as XExtensionInfo ptr)
declare function XextAddDisplay cdecl alias "XextAddDisplay" (byval as XExtensionInfo ptr, byval as Display ptr, byval as zstring ptr, byval as XExtensionHooks ptr, byval as integer, byval as XPointer) as XExtDisplayInfo ptr
declare function XextRemoveDisplay cdecl alias "XextRemoveDisplay" (byval as XExtensionInfo ptr, byval as Display ptr) as integer
declare function XextFindDisplay cdecl alias "XextFindDisplay" (byval as XExtensionInfo ptr, byval as Display ptr) as XExtDisplayInfo ptr

#endif
