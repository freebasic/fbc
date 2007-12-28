''
''
'' colour -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_colour_bi__
#define __wxc_colour_bi__

#include once "wx.bi"


declare function wxColour alias "wxColour_ctor" () as wxColour ptr
declare sub wxColour_dtor (byval self as wxColour ptr)
declare function wxColour_ctorByName (byval name as zstring ptr) as wxColour ptr
declare function wxColour_ctorByParts (byval red as ubyte, byval green as ubyte, byval blue as ubyte) as wxColour ptr
declare function wxColour_Blue (byval self as wxColour ptr) as ubyte
declare function wxColour_Red (byval self as wxColour ptr) as ubyte
declare function wxColour_Green (byval self as wxColour ptr) as ubyte
declare function wxColour_Ok (byval self as wxColour ptr) as integer
declare sub wxColour_Set (byval self as wxColour ptr, byval red as ubyte, byval green as ubyte, byval blue as ubyte)

#endif
