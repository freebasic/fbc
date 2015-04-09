'' FreeBASIC binding for libXmu-1.1.2

#pragma once

#include once "crt/long.bi"
#include once "X11/Intrinsic.bi"
#include once "X11/Xfuncproto.bi"

extern "C"

#define _XMU_SELECTION_H_
declare function XmuConvertStandardSelection(byval w as Widget, byval timev as Time, byval selection as XAtom ptr, byval target as XAtom ptr, byval type_return as XAtom ptr, byval value_return as XPointer ptr, byval length_return as culong ptr, byval format_return as long ptr) as byte

end extern
