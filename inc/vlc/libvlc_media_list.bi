''
''
'' libvlc_media_list -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __libvlc_media_list_bi__
#define __libvlc_media_list_bi__

#define LIBVLC_MEDIA_LIST_H 1

type libvlc_media_list_t as any

declare sub libvlc_media_list_release cdecl alias "libvlc_media_list_release" (byval p_ml as libvlc_media_list_t ptr)
declare sub libvlc_media_list_retain cdecl alias "libvlc_media_list_retain" (byval p_ml as libvlc_media_list_t ptr)
declare function libvlc_media_list_add_file_content cdecl alias "libvlc_media_list_add_file_content" (byval p_ml as libvlc_media_list_t ptr, byval psz_uri as zstring ptr) as integer
declare sub libvlc_media_list_set_media cdecl alias "libvlc_media_list_set_media" (byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr)
declare function libvlc_media_list_add_media cdecl alias "libvlc_media_list_add_media" (byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr) as integer
declare function libvlc_media_list_insert_media cdecl alias "libvlc_media_list_insert_media" (byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr, byval i_pos as integer) as integer
declare function libvlc_media_list_remove_index cdecl alias "libvlc_media_list_remove_index" (byval p_ml as libvlc_media_list_t ptr, byval i_pos as integer) as integer
declare function libvlc_media_list_count cdecl alias "libvlc_media_list_count" (byval p_ml as libvlc_media_list_t ptr) as integer
declare function libvlc_media_list_index_of_item cdecl alias "libvlc_media_list_index_of_item" (byval p_ml as libvlc_media_list_t ptr, byval p_md as libvlc_media_t ptr) as integer
declare function libvlc_media_list_is_readonly cdecl alias "libvlc_media_list_is_readonly" (byval p_ml as libvlc_media_list_t ptr) as integer
declare sub libvlc_media_list_lock cdecl alias "libvlc_media_list_lock" (byval p_ml as libvlc_media_list_t ptr)
declare sub libvlc_media_list_unlock cdecl alias "libvlc_media_list_unlock" (byval p_ml as libvlc_media_list_t ptr)

#endif
