''
''
'' accel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_accel_bi__
#define __wxc_accel_bi__

#include once "wx-c/wx.bi"

declare function wxAcceleratorEntry alias "wxAcceleratorEntry_ctor" (byval flags as integer, byval keyCode as integer, byval cmd as integer, byval item as wxMenuItem ptr) as wxAcceleratorEntry ptr
declare sub wxAcceleratorEntry_RegisterDisposable (byval self as _AcceleratorEntry ptr, byval onDispose as Virtual_Dispose)
declare sub wxAcceleratorEntry_dtor (byval self as wxAcceleratorEntry ptr)
declare sub wxAcceleratorEntry_Set (byval self as wxAcceleratorEntry ptr, byval flags as integer, byval keyCode as integer, byval cmd as integer, byval item as wxMenuItem ptr)
declare sub wxAcceleratorEntry_SetMenuItem (byval self as wxAcceleratorEntry ptr, byval item as wxMenuItem ptr)
declare function wxAcceleratorEntry_GetFlags (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetKeyCode (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetCommand (byval self as wxAcceleratorEntry ptr) as integer
declare function wxAcceleratorEntry_GetMenuItem (byval self as wxAcceleratorEntry ptr) as wxMenuItem ptr
declare function wxAcceleratorEntry_GetAccelFromString (byval label as zstring ptr) as wxAcceleratorEntry ptr
declare function wxAcceleratorTable alias "wxAcceleratorTable_ctor" () as wxAcceleratorTable ptr
declare function wxAcceleratorTable_Ok (byval self as wxAcceleratorTable ptr) as integer

#endif
