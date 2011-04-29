#ifndef __FB_BFD_BRIDGE_BI__
#define __FB_BFD_BRIDGE_BI__

''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2011 The FreeBASIC development team.
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

#if defined(USE_FB_BFD_HEADER)

#include once "bfd.bi"

#else

'' NOTE: these are the types that fb
'' uses to interface to the bfd wrapper.
'' the wrapper (which includes bfd.h)
'' may use types of other (smaller) sizes
'' and/or different values for enumerations.
'' The FB ones defined here are mapped to
'' the "real" ones in c-objinfo.c

'' must match declarations in c-objinfo.c

'' PTR types
type bfd as bfd_
type asection as asection_

'' numeric types
type bfd_boolean as integer
type bfd_size_type as unsigned long
type file_ptr as longint
type flagword as uinteger

'' must match c-objinfo.c flags
#define SEC_HAS_CONTENTS &h100

'' must match c-objinfo.c::FB_bfd_format
enum fb_bfd_format
        bfd_unknown = 0
        bfd_object
        bfd_archive
        bfd_core
        bfd_type_end
end enum

'' must match c-objinfo.c::FB_bfd_architecture
enum fb_bfd_architecture
        bfd_arch_unknown = 0
        bfd_arch_i386
end enum

extern "c"
        declare sub fb_bfd_init( )
        declare function fb_bfd_openr (byval filename as zstring ptr, byval target as zstring ptr) as bfd ptr
        declare function fb_bfd_close (byval abfd as bfd ptr) as bfd_boolean
        declare function fb_bfd_check_format (byval abfd as bfd ptr, byval format as fb_bfd_format) as bfd_boolean
        declare function fb_bfd_openr_next_archived_file (byval archive as bfd ptr, byval previous as bfd ptr) as bfd ptr
        declare function fb_bfd_openw (byval filename as zstring ptr, byval target as zstring ptr) as bfd ptr
        declare function fb_bfd_set_format (byval abfd as bfd ptr, byval format as fb_bfd_format) as bfd_boolean
        declare function fb_bfd_get_section_by_name (byval abfd as bfd ptr, byval name as zstring ptr) as asection ptr
        declare function fb_bfd_get_section_size (byval section as asection ptr) as bfd_size_type
        declare function fb_bfd_set_section_size (byval abfd as bfd ptr, byval sec as asection ptr, byval val as bfd_size_type) as bfd_boolean
        declare function fb_bfd_get_filename (byval abfd as bfd ptr) as zstring ptr
        declare function fb_bfd_make_section (byval as bfd ptr, byval name as zstring ptr) as asection ptr
        declare function fb_bfd_check_format_matches (byval abfd as bfd ptr, byval format as fb_bfd_format, byval matching as byte ptr ptr ptr) as bfd_boolean
        declare function fb_bfd_set_section_flags (byval abfd as bfd ptr, byval sec as asection ptr, byval flags as flagword) as bfd_boolean
        declare function fb_bfd_get_section_contents (byval abfd as bfd ptr, byval section as asection ptr, byval location as any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
        declare function fb_bfd_set_section_contents (byval abfd as bfd ptr, byval section as asection ptr, byval data as any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
        declare function fb_bfd_set_arch_mach (byval abfd as bfd ptr, byval arch as fb_bfd_architecture, byval mach as uinteger) as bfd_boolean
end extern

#define bfd_init fb_bfd_init
#define bfd_openr fb_bfd_openr
#define bfd_close fb_bfd_close
#define bfd_check_format fb_bfd_check_format
#define bfd_openr_next_archived_file fb_bfd_openr_next_archived_file
#define bfd_openw fb_bfd_openw
#define bfd_set_format fb_bfd_set_format
#define bfd_get_section_by_name fb_bfd_get_section_by_name
#define bfd_get_section_size fb_bfd_get_section_size
#define bfd_set_section_size fb_bfd_set_section_size
#define bfd_get_filename fb_bfd_get_filename
#define bfd_make_section fb_bfd_make_section
#define bfd_check_format_matches fb_bfd_check_format_matches
#define bfd_set_section_flags fb_bfd_set_section_flags
#define bfd_get_section_contents fb_bfd_get_section_contents
#define bfd_set_section_contents fb_bfd_set_section_contents
#define bfd_set_arch_mach fb_bfd_set_arch_mach

#endif '' defined(USE_FB_BFD_HEADER)

#endif '' __FB_BFD_BRIDGE_BI__
