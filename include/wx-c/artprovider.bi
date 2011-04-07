''
''
'' artprovider -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_artprovider_bi__
#define __wxc_artprovider_bi__

#include once "wx.bi"

declare function GetArtId (byval id as integer) as wxArtID ptr
declare function GetArtClient (byval id as integer) as wxArtClient ptr
declare function wxArtProvider_GetBitmap (byval artid as integer, byval artclient as integer, byval size as wxSize ptr) as wxBitmap ptr
declare function wxArtProvider_GetIcon (byval artid as integer, byval artclient as integer, byval size as wxSize ptr) as wxIcon ptr

#endif
