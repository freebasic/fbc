' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
#ifndef __dj_include_sys_movedata_h_
#define __dj_include_sys_movedata_h_

#include "dos/sys/djtypes.bi"

' This header is intended to be included only by other
'   headers, like <go32.h> and <string.h>.  You may
'   include this directly, but it will be non-portable.

' These lengths are in bytes, optimized for speed
declare sub		dosmemget cdecl alias "dosmemget"	( byval _offset as uinteger, byval _length as uinteger, byval _buffer as any ptr )
declare sub		dosmemput cdecl alias "dosmemput"	( byval _buffer as any ptr, byval _length as uinteger, byval _offset as uinteger )

' The lengths here are in TRANSFERS, not bytes!
declare sub		_dosmemgetb cdecl alias "_dosmemgetb"	( byval _offset as uinteger, byval _xfers as uinteger, byval _buffer as any ptr )
declare sub		_dosmemgetw cdecl alias "_dosmemgetw"	( byval _offset as uinteger, byval _xfers as uinteger, byval _buffer as any ptr )
declare sub		_dosmemgetl cdecl alias "_dosmemgetl"	( byval _offset as uinteger, byval _xfers as uinteger, byval _buffer as any ptr )
declare sub		_dosmemputb cdecl alias "_dosmemputb"	( byval _buffer as any ptr, byval _xfers as uinteger, byval _offset as uinteger )
declare sub		_dosmemputw cdecl alias "_dosmemputw"	( byval _buffer as any ptr, byval _xfers as uinteger, byval _offset as uinteger )
declare sub		_dosmemputl cdecl alias "_dosmemputl"	( byval _buffer as any ptr, byval _xfers as uinteger, byval _offset as uinteger )

' This length is in bytes, optimized for speed
declare sub		movedata cdecl alias "movedata"		( byval _source_selector as uinteger, byval _source_offset as uinteger, byval _dest_selector as uinteger, byval _dest_offset as uinteger, byval _length as uinteger )

' The lengths here are in TRANSFERS, not bytes!
declare sub		_movedatab cdecl alias "_movedatab"	( byval _source_selector as uinteger, byval _source_offset as uinteger, byval _dest_selector as uinteger, byval _dest_offset as uinteger, byval xfers as uinteger )
declare sub		_movedataw cdecl alias "_movedataw"	( byval _source_selector as uinteger, byval _source_offset as uinteger, byval _dest_selector as uinteger, byval _dest_offset as uinteger, byval xfers as uinteger )
declare sub		_movedatal cdecl alias "_movedatal"	( byval _source_selector as uinteger, byval _source_offset as uinteger, byval _dest_selector as uinteger, byval _dest_offset as uinteger, byval xfers as uinteger )

#endif ' !__dj_include_sys_movedata_h_
