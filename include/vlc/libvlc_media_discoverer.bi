''
''
'' libvlc_media_discoverer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_discoverer_bi__
#define __libvlc_media_discoverer_bi__

#define VLC_LIBVLC_MEDIA_DISCOVERER_H 1

type libvlc_media_discoverer_t as any

declare sub libvlc_media_discoverer_release cdecl alias "libvlc_media_discoverer_release" (byval p_mdis as libvlc_media_discoverer_t ptr)
declare function libvlc_media_discoverer_localized_name cdecl alias "libvlc_media_discoverer_localized_name" (byval p_mdis as libvlc_media_discoverer_t ptr) as zstring ptr
declare function libvlc_media_discoverer_is_running cdecl alias "libvlc_media_discoverer_is_running" (byval p_mdis as libvlc_media_discoverer_t ptr) as integer

#endif
