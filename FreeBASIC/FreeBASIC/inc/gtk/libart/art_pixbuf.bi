''
''
'' art_pixbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_pixbuf_bi__
#define __art_pixbuf_bi__

#include once "art_misc.bi"

type ArtDestroyNotify as sub cdecl(byval as any ptr, byval as any ptr)
type ArtPixBuf as _ArtPixBuf

enum ArtPixFormat
	ART_PIX_RGB
end enum


type _ArtPixBuf
	format as ArtPixFormat
	n_channels as integer
	has_alpha as integer
	bits_per_sample as integer
	pixels as art_u8 ptr
	width as integer
	height as integer
	rowstride as integer
	destroy_data as any ptr
	destroy as ArtDestroyNotify
end type

declare function art_pixbuf_new_rgb (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer) as ArtPixBuf ptr
declare function art_pixbuf_new_rgba (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer) as ArtPixBuf ptr
declare function art_pixbuf_new_const_rgb (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer) as ArtPixBuf ptr
declare function art_pixbuf_new_const_rgba (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer) as ArtPixBuf ptr
declare function art_pixbuf_new_rgb_dnotify (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer, byval dfunc_data as any ptr, byval dfunc as ArtDestroyNotify) as ArtPixBuf ptr
declare function art_pixbuf_new_rgba_dnotify (byval pixels as art_u8 ptr, byval width as integer, byval height as integer, byval rowstride as integer, byval dfunc_data as any ptr, byval dfunc as ArtDestroyNotify) as ArtPixBuf ptr
declare sub art_pixbuf_free (byval pixbuf as ArtPixBuf ptr)
declare sub art_pixbuf_free_shallow (byval pixbuf as ArtPixBuf ptr)
declare function art_pixbuf_duplicate (byval pixbuf as ArtPixBuf ptr) as ArtPixBuf ptr

#endif
