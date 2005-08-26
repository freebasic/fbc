''
''
'' accel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __accel_bi__
#define __accel_bi__

#include once "wx-c/wx.bi"

declare function wxAcceleratorEntry cdecl alias "wxAcceleratorEntry_ctor" (byval flags as integer, byval keyCode as integer, byval cmd as integer, byval item as wxMenuItem ptr) as wxAcceleratorEntry ptr
declare sub wxAcceleratorEntry_RegisterDisposable cdecl alias "wxAcceleratorEntry_RegisterDisposable" (byval self as _AcceleratorEntry ptr, byval onDispose as Virtual_Dispose)
declare sub wxAcceleratorEntry_dtor cdecl alias "wxAcceleratorEntry_dtor" (byval self as wxAcceleratorEntry ptr)
declare sub wxAcceleratorEntry_Set cdecl alias "wxAcceleratorEntry_Set" (byval self as wxAcceleratorEntry ptr, byval flags as integer, byval keyCode as integer, byval cmd as integer, byval item as wxMenuItem ptr)
declare sub wxAcceleratorEntry_SetMenuItem cdecl alias "wxAcceleratorEntry_SetMenuItem" (byval self as wxAcceleratorEntry ptr, byval item as wxMenuItem ptr)
declare function wxAcceleratorEntry_GetFlags cdecl alias "wxAcceleratorEntry_GetFlags" (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetKeyCode cdecl alias "wxAcceleratorEntry_GetKeyCode" (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetCommand cdecl alias "wxAcceleratorEntry_GetCommand" (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetMenuItem cdecl alias "wxAcceleratorEntry_GetMenuItem" (byval self as wxAcceleratorEntry ptr) as wxMenuItem ptr
declare function wxAcceleratorEntry_GetAccelFromString cdecl alias "wxAcceleratorEntry_GetAccelFromString" (byval label as zstring ptr) as wxAcceleratorEntry ptr
declare function wxAcceleratorTable cdecl alias "wxAcceleratorTable_ctor" () as wxAcceleratorTable ptr
declare function wxAcceleratorTable_Ok cdecl alias "wxAcceleratorTable_Ok" (byval self as wxAcceleratorTable ptr) as integer

#endif
