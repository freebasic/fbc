''
''
'' artprovider -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __artprovider_bi__
#define __artprovider_bi__

#include once "wx-c/wx.bi"

declare function GetArtId cdecl alias "GetArtId" (byval id as integer) as wxArtID ptr
declare function GetArtClient cdecl alias "GetArtClient" (byval id as integer) as wxArtClient ptr
declare function wxArtProvider_GetBitmap cdecl alias "wxArtProvider_GetBitmap" (byval artid as integer, byval artclient as integer, byval size as wxSize ptr) as wxBitmap ptr
declare function wxArtProvider_GetIcon cdecl alias "wxArtProvider_GetIcon" (byval artid as integer, byval artclient as integer, byval size as wxSize ptr) as wxIcon ptr

#endif
