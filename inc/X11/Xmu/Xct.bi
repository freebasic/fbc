'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _Xct_h
const XctVersion = 1
type XctString as ubyte ptr

type XctHDirection as long
enum
	XctUnspecified
	XctLeftToRight
	XctRightToLeft
end enum

type XctFlags as culong
const XctSingleSetSegments = &h0001
const XctProvideExtensions = &h0002
const XctAcceptC0Extensions = &h0004
const XctAcceptC1Extensions = &h0008
const XctHideDirection = &h0010
const XctFreeString = &h0020
const XctShiftMultiGRToGL = &h0040

type XctResult as long
enum
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

type _XctPriv as _XctPriv_

type _XctRec
	total_string as XctString
	total_length as long
	flags as XctFlags
	version as long
	can_ignore_exts as long
	item as XctString
	item_length as ulong
	char_size as long
	encoding as zstring ptr
	horizontal as XctHDirection
	horz_depth as ulong
	GL as zstring ptr
	GL_encoding as zstring ptr
	GL_set_size as long
	GL_char_size as long
	GR as zstring ptr
	GR_encoding as zstring ptr
	GR_set_size as long
	GR_char_size as long
	GLGR_encoding as zstring ptr
	priv as _XctPriv ptr
end type

type XctData as _XctRec ptr
declare function XctCreate(byval string as const ubyte ptr, byval length as long, byval flags as XctFlags) as XctData
declare function XctNextItem(byval data as XctData) as XctResult
declare sub XctFree(byval data as XctData)
declare sub XctReset(byval data as XctData)

end extern
