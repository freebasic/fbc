/*
 * FB friendly libbfd wrapper
 * (allowing fbc to use libbfd versions for which no FB header has been made)
 *
 * Must match the declarations in bfd-wrapper.bi; although data type sizes
 * may be the same or larger than those actually used in bfd.h.
 */

#include "bfd.h"

typedef int fb_bfd_boolean;
typedef unsigned long int fb_bfd_size_type;
typedef long long int fb_file_ptr;
typedef unsigned int fb_flagword;

#define FB_SEC_HAS_CONTENTS 0x100

int hMapFlag(int flag) {
	flagword ret = 0;
	if (flag & FB_SEC_HAS_CONTENTS)
		ret |= SEC_HAS_CONTENTS;
	return ret;
}

enum fb_bfd_format {
	fb_bfd_unknown = 0,
	fb_bfd_object,
	fb_bfd_archive,
	fb_bfd_core,
	fb_bfd_type_end
} fb_bfd_format;

bfd_format hMapFormat(enum fb_bfd_format format) {
	switch (format) {
	case fb_bfd_object:
		return bfd_object;
	case fb_bfd_archive:
		return bfd_archive;
	case fb_bfd_core:
		return bfd_core;
	case fb_bfd_type_end:
		return bfd_type_end;
	}
	return bfd_unknown;
}

enum fb_bfd_architecture {
	fb_bfd_arch_unknown = 0,
	fb_bfd_arch_i386
} fb_bfd_architecture;

enum bfd_architecture hMapArch(enum fb_bfd_architecture arch) {
	switch (arch) {
	case fb_bfd_arch_i386:
		return bfd_arch_i386;
	}
	return bfd_arch_unknown;
}

void fb_bfd_init(void) {
	bfd_init();
}

bfd *fb_bfd_openr(char *filename, char *target) {
	return bfd_openr(filename, target);
}

fb_bfd_boolean fb_bfd_close(bfd *abfd) {
	return bfd_close(abfd);
}

fb_bfd_boolean fb_bfd_check_format(bfd *abfd, enum fb_bfd_format format) {
	return bfd_check_format(abfd, hMapFormat(format));
}

bfd *fb_bfd_openr_next_archived_file(bfd *archive, bfd *previous) {
	return bfd_openr_next_archived_file(archive, previous);
}

bfd *fb_bfd_openw(char *filename, char *target) {
	return bfd_openw(filename, target);
}

fb_bfd_boolean fb_bfd_set_format(bfd *abfd, enum fb_bfd_format format) {
	return bfd_set_format(abfd, hMapFormat(format));
}

asection *fb_bfd_get_section_by_name(bfd *abfd, char *name) {
	return bfd_get_section_by_name(abfd, name);
}

fb_bfd_size_type fb_bfd_get_section_size(asection *section) {
	return bfd_get_section_size(section);
}

fb_bfd_boolean fb_bfd_set_section_size(bfd *abfd, asection *sec, fb_bfd_size_type val) {
	return bfd_set_section_size(abfd, sec, (bfd_size_type)val);
}

char *fb_bfd_get_filename(bfd *abfd) {
	return bfd_get_filename(abfd);
}

asection *fb_bfd_make_section(bfd *abfd, char *name) {
	return bfd_make_section(abfd, name);
}

fb_bfd_boolean fb_bfd_check_format_matches(bfd *abfd, enum fb_bfd_format format, char ***matching) {
	return bfd_check_format_matches(abfd, hMapFormat(format), matching);
}

fb_bfd_boolean fb_bfd_set_section_flags(bfd *abfd, asection *sec, fb_flagword flags) {
	return bfd_set_section_flags(abfd, sec, hMapFlag(flags));
}

fb_bfd_boolean fb_bfd_get_section_contents(bfd *abfd, asection *section, void *location, fb_file_ptr offset, fb_bfd_size_type count) {
	return bfd_get_section_contents(abfd, section, location, (file_ptr)offset, (bfd_size_type)count);
}

fb_bfd_boolean fb_bfd_set_section_contents(bfd *abfd, asection *section, void *data, fb_file_ptr offset, fb_bfd_size_type count) {
	return bfd_set_section_contents(abfd, section, data, (file_ptr)offset, (bfd_size_type)count);
}

fb_bfd_boolean fb_bfd_set_arch_mach(bfd *abfd, enum fb_bfd_architecture arch, unsigned int mach) {
	return bfd_set_arch_mach(abfd, hMapArch(arch), mach);
}
