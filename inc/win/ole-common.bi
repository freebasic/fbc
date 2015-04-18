'' This file contains code from multiple MinGW-w64 header files. These function
'' declarations were duplicated across various header files, and are now unified
'' here in a single file because FB doesn't allow duplicate/redundant function
'' declarations.
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "Windows"

declare sub BSTR_UserFree(byval as ULONG ptr, byval as BSTR ptr)
declare function BSTR_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as BSTR ptr) as ubyte ptr
declare function BSTR_UserSize(byval as ULONG ptr, byval as ULONG, byval as BSTR ptr) as ULONG
declare function BSTR_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as BSTR ptr) as ubyte ptr
declare sub CLIPFORMAT_UserFree(byval as ULONG ptr, byval as CLIPFORMAT ptr)
declare function CLIPFORMAT_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as CLIPFORMAT ptr) as ubyte ptr
declare function CLIPFORMAT_UserSize(byval as ULONG ptr, byval as ULONG, byval as CLIPFORMAT ptr) as ULONG
declare function CLIPFORMAT_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as CLIPFORMAT ptr) as ubyte ptr
declare sub HACCEL_UserFree(byval as ULONG ptr, byval as HACCEL ptr)
declare function HACCEL_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HACCEL ptr) as ubyte ptr
declare function HACCEL_UserSize(byval as ULONG ptr, byval as ULONG, byval as HACCEL ptr) as ULONG
declare function HACCEL_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HACCEL ptr) as ubyte ptr
declare sub HBITMAP_UserFree(byval as ULONG ptr, byval as HBITMAP ptr)
declare function HBITMAP_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HBITMAP ptr) as ubyte ptr
declare function HBITMAP_UserSize(byval as ULONG ptr, byval as ULONG, byval as HBITMAP ptr) as ULONG
declare function HBITMAP_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HBITMAP ptr) as ubyte ptr
declare sub HDC_UserFree(byval as ULONG ptr, byval as HDC ptr)
declare function HDC_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HDC ptr) as ubyte ptr
declare function HDC_UserSize(byval as ULONG ptr, byval as ULONG, byval as HDC ptr) as ULONG
declare function HDC_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HDC ptr) as ubyte ptr
declare sub HGLOBAL_UserFree(byval as ULONG ptr, byval as HGLOBAL ptr)
declare function HGLOBAL_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HGLOBAL ptr) as ubyte ptr
declare function HGLOBAL_UserSize(byval as ULONG ptr, byval as ULONG, byval as HGLOBAL ptr) as ULONG
declare function HGLOBAL_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HGLOBAL ptr) as ubyte ptr
declare sub HICON_UserFree(byval as ULONG ptr, byval as HICON ptr)
declare function HICON_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HICON ptr) as ubyte ptr
declare function HICON_UserSize(byval as ULONG ptr, byval as ULONG, byval as HICON ptr) as ULONG
declare function HICON_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HICON ptr) as ubyte ptr
declare sub HMENU_UserFree(byval as ULONG ptr, byval as HMENU ptr)
declare function HMENU_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HMENU ptr) as ubyte ptr
declare function HMENU_UserSize(byval as ULONG ptr, byval as ULONG, byval as HMENU ptr) as ULONG
declare function HMENU_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HMENU ptr) as ubyte ptr
declare sub HPALETTE_UserFree(byval as ULONG ptr, byval as HPALETTE ptr)
declare function HPALETTE_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HPALETTE ptr) as ubyte ptr
declare function HPALETTE_UserSize(byval as ULONG ptr, byval as ULONG, byval as HPALETTE ptr) as ULONG
declare function HPALETTE_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HPALETTE ptr) as ubyte ptr
declare sub HWND_UserFree(byval as ULONG ptr, byval as HWND ptr)
declare function HWND_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HWND ptr) as ubyte ptr
declare function HWND_UserSize(byval as ULONG ptr, byval as ULONG, byval as HWND ptr) as ULONG
declare function HWND_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as HWND ptr) as ubyte ptr
declare sub STGMEDIUM_UserFree(byval as ULONG ptr, byval as STGMEDIUM ptr)
declare function STGMEDIUM_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as STGMEDIUM ptr) as ubyte ptr
declare function STGMEDIUM_UserSize(byval as ULONG ptr, byval as ULONG, byval as STGMEDIUM ptr) as ULONG
declare function STGMEDIUM_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as STGMEDIUM ptr) as ubyte ptr
type VARIANT as tagVARIANT
declare function VARIANT_UserSize(byval as ULONG ptr, byval as ULONG, byval as VARIANT ptr) as ULONG
declare function VARIANT_UserMarshal(byval as ULONG ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare function VARIANT_UserUnmarshal(byval as ULONG ptr, byval as ubyte ptr, byval as VARIANT ptr) as ubyte ptr
declare sub VARIANT_UserFree(byval as ULONG ptr, byval as VARIANT ptr)

end extern
