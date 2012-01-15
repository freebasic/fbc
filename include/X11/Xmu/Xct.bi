''
''
'' Xct -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xct_bi__
#define __Xct_bi__

#define XctVersion 1

type XctString as ubyte ptr

enum XctHDirection
	XctUnspecified
	XctLeftToRight
	XctRightToLeft
end enum

type XctFlags as uinteger

#define XctSingleSetSegments &h0001
#define XctProvideExtensions &h0002
#define XctAcceptC0Extensions &h0004
#define XctAcceptC1Extensions &h0008
#define XctHideDirection &h0010
#define XctFreeString &h0020
#define XctShiftMultiGRToGL &h0040

enum XctResult
	XctSegment
	XctC0Segment
	XctGLSegment
	XctC1Segment
	XctGRSegment
	XctExtendedSegment
	XctExtension
	XctHorizontal
	XctEndOfText
	XctError
end enum


type _XctRec
	total_string as XctString
	total_length as integer
	flags as XctFlags
	version as integer
	can_ignore_exts as integer
	item as XctString
	item_length as uinteger
	char_size as integer
	encoding as zstring ptr
	horizontal as XctHDirection
	horz_depth as uinteger
	GL as zstring ptr
	GL_encoding as zstring ptr
	GL_set_size as integer
	GL_char_size as integer
	GR as zstring ptr
	GR_encoding as zstring ptr
	GR_set_size as integer
	GR_char_size as integer
	GLGR_encoding as zstring ptr
	priv as _XctPriv ptr
end type

type XctData as _XctRec ptr

declare sub XctFree cdecl alias "XctFree" (byval data as XctData)
declare sub XctReset cdecl alias "XctReset" (byval data as XctData)

#endif
