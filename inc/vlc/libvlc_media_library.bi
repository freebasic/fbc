''
''
'' libvlc_media_library -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_library_bi__
#define __libvlc_media_library_bi__

#define VLC_LIBVLC_MEDIA_LIBRARY_H 1

type libvlc_media_library_t as any

declare sub libvlc_media_library_release cdecl alias "libvlc_media_library_release" (byval p_mlib as libvlc_media_library_t ptr)
declare sub libvlc_media_library_retain cdecl alias "libvlc_media_library_retain" (byval p_mlib as libvlc_media_library_t ptr)
declare function libvlc_media_library_load cdecl alias "libvlc_media_library_load" (byval p_mlib as libvlc_media_library_t ptr) as integer

#endif
