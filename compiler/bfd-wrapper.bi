type bfd as bfd_
type asection as asection_

type bfd_boolean as integer
type bfd_size_type as ulong
type file_ptr as longint
type flagword as uinteger

#define SEC_HAS_CONTENTS &h100

enum fb_bfd_format
	bfd_unknown = 0
	bfd_object
	bfd_archive
	bfd_core
	bfd_type_end
end enum

enum fb_bfd_architecture
	bfd_arch_unknown = 0
	bfd_arch_i386
end enum

extern "c"
declare sub fb_bfd_init()
declare function fb_bfd_openr(byval as zstring ptr, byval as zstring ptr) as bfd ptr
declare function fb_bfd_close(byval as bfd ptr) as bfd_boolean
declare function fb_bfd_check_format(byval as bfd ptr, byval as fb_bfd_format) as bfd_boolean
declare function fb_bfd_openr_next_archived_file(byval as bfd ptr, byval as bfd ptr) as bfd ptr
declare function fb_bfd_openw(byval as zstring ptr, byval as zstring ptr) as bfd ptr
declare function fb_bfd_set_format(byval as bfd ptr, byval as fb_bfd_format) as bfd_boolean
declare function fb_bfd_get_section_by_name(byval as bfd ptr, byval as zstring ptr) as asection ptr
declare function fb_bfd_get_section_size(byval as asection ptr) as bfd_size_type
declare function fb_bfd_set_section_size(byval as bfd ptr, byval as asection ptr, byval as bfd_size_type) as bfd_boolean
declare function fb_bfd_get_filename(byval as bfd ptr) as zstring ptr
declare function fb_bfd_make_section(byval as bfd ptr, byval as zstring ptr) as asection ptr
declare function fb_bfd_check_format_matches(byval as bfd ptr, byval as fb_bfd_format, byval as byte ptr ptr ptr) as bfd_boolean
declare function fb_bfd_set_section_flags(byval as bfd ptr, byval as asection ptr, byval as flagword) as bfd_boolean
declare function fb_bfd_get_section_contents(byval as bfd ptr, byval as asection ptr, byval as any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
declare function fb_bfd_set_section_contents(byval as bfd ptr, byval as asection ptr, byval as any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
declare function fb_bfd_set_arch_mach(byval as bfd ptr, byval as fb_bfd_architecture, byval as uinteger) as bfd_boolean
end extern

#define bfd_init                        fb_bfd_init
#define bfd_openr                       fb_bfd_openr
#define bfd_close                       fb_bfd_close
#define bfd_check_format                fb_bfd_check_format
#define bfd_openr_next_archived_file    fb_bfd_openr_next_archived_file
#define bfd_openw                       fb_bfd_openw
#define bfd_set_format                  fb_bfd_set_format
#define bfd_get_section_by_name         fb_bfd_get_section_by_name
#define bfd_get_section_size            fb_bfd_get_section_size
#define bfd_set_section_size            fb_bfd_set_section_size
#define bfd_get_filename                fb_bfd_get_filename
#define bfd_make_section                fb_bfd_make_section
#define bfd_check_format_matches        fb_bfd_check_format_matches
#define bfd_set_section_flags           fb_bfd_set_section_flags
#define bfd_get_section_contents        fb_bfd_get_section_contents
#define bfd_set_section_contents        fb_bfd_set_section_contents
#define bfd_set_arch_mach               fb_bfd_set_arch_mach
