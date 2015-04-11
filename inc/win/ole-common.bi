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
