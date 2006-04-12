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

#include once "wx-c/wx.bi"


declare function wxColour cdecl alias "wxColour_ctor" () as wxColour ptr
declare sub wxColour_dtor cdecl alias "wxColour_dtor" (byval self as wxColour ptr)
declare function wxColour_ctorByName cdecl alias "wxColour_ctorByName" (byval name as zstring ptr) as wxColour ptr
declare function wxColour_ctorByParts cdecl alias "wxColour_ctorByParts" (byval red as ubyte, byval green as ubyte, byval blue as ubyte) as wxColour ptr
declare function wxColour_Blue cdecl alias "wxColour_Blue" (byval self as wxColour ptr) as ubyte
declare function wxColour_Red cdecl alias "wxColour_Red" (byval self as wxColour ptr) as ubyte
declare function wxColour_Green cdecl alias "wxColour_Green" (byval self as wxColour ptr) as ubyte
declare function wxColour_Ok cdecl alias "wxColour_Ok" (byval self as wxColour ptr) as integer
declare sub wxColour_Set cdecl alias "wxColour_Set" (byval self as wxColour ptr, byval red as ubyte, byval green as ubyte, byval blue as ubyte)

#endif
