/*
 *	FreeBASIC - 32-bit BASIC Compiler.
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.
 */

/*
 * c-objinfo.c -- fb friendly wrapper for libbfd.a
 *
 * chng: mar/2008 written
 *
 */

#include "bfd.h"

/* must match delcarations in fb-bfd-bridge.bi 
 * and data type sizes may be same or larger
 * than those actually used in bfd.h
 */

typedef int fb_bfd_boolean;
typedef unsigned long int fb_bfd_size_type;
typedef long long int fb_file_ptr;
typedef unsigned int fb_flagword;

#define FB_SEC_HAS_CONTENTS 0x100

int hMapFlag( int flag ) {
	flagword ret = 0;
	if( flag & FB_SEC_HAS_CONTENTS )
		ret |= SEC_HAS_CONTENTS;
	return ret;
}

enum FB_bfd_format {
	FB_bfd_unknown = 0, 
	FB_bfd_object, 
	FB_bfd_archive, 
	FB_bfd_core, 
	FB_bfd_type_end
} FB_bfd_format;

bfd_format hMapFormat ( enum FB_bfd_format format ) {
	switch (format) {
		case FB_bfd_object:
			return bfd_object;
		case FB_bfd_archive:
			return bfd_archive;
		case FB_bfd_core:
			return bfd_core;
		case FB_bfd_type_end:
			return bfd_type_end;
		case FB_bfd_unknown:
		default:
			break;
	}
	return bfd_unknown;
}

enum FB_bfd_architecture {
	FB_bfd_arch_unknown = 0,
	FB_bfd_arch_i386
} FB_bfd_architecture;

enum bfd_architecture hMapArch( enum FB_bfd_architecture arch ) {
	switch (arch) {
		case FB_bfd_arch_i386:
			return bfd_arch_i386;
		case FB_bfd_arch_unknown:
		default:
			break;
	}
	return bfd_arch_unknown;
}

void fb_bfd_init( void ) {
	bfd_init( );
}

bfd *fb_bfd_openr (char *filename, char *target) {
	return bfd_openr( filename, target );
}

fb_bfd_boolean fb_bfd_close (bfd *abfd) {
	return bfd_close( abfd );
}

fb_bfd_boolean fb_bfd_check_format (bfd *abfd, enum FB_bfd_format format) {
	return bfd_check_format( abfd, hMapFormat( format ) );
}

bfd *fb_bfd_openr_next_archived_file (bfd *archive, bfd *previous) {
	return bfd_openr_next_archived_file( archive, previous );
}

bfd *fb_bfd_openw (char *filename, char *target) {
	return bfd_openw( filename, target );
}

fb_bfd_boolean fb_bfd_set_format (bfd *abfd, enum FB_bfd_format format) {
	return bfd_set_format( abfd, hMapFormat( format ) );
}

asection *fb_bfd_get_section_by_name (bfd *abfd, char *name) {
	return bfd_get_section_by_name( abfd, name );
}

fb_bfd_size_type fb_bfd_get_section_size (asection *section) {
	return bfd_get_section_size( section );
}

fb_bfd_boolean fb_bfd_set_section_size (bfd *abfd, asection *sec, fb_bfd_size_type val) {
	return bfd_set_section_size( abfd, sec, (bfd_size_type)val );
}

char *fb_bfd_get_filename (bfd *abfd) {
	return bfd_get_filename( abfd );
}

asection *fb_bfd_make_section (bfd *abfd, char *name) {
	return bfd_make_section( abfd, name );
}

fb_bfd_boolean fb_bfd_check_format_matches (bfd *abfd, enum FB_bfd_format format, char ***matching) {
	return bfd_check_format_matches( abfd, hMapFormat(format), matching );
}

fb_bfd_boolean fb_bfd_set_section_flags (bfd *abfd, asection *sec, fb_flagword flags) {
	return bfd_set_section_flags( abfd, sec, hMapFlag( flags ) );
}

fb_bfd_boolean fb_bfd_get_section_contents (bfd *abfd, asection *section, void *location, fb_file_ptr offset, fb_bfd_size_type count) {
	return bfd_get_section_contents( abfd, section, location, (file_ptr)offset, (bfd_size_type)count );
}

fb_bfd_boolean fb_bfd_set_section_contents (bfd *abfd, asection *section, void *data, fb_file_ptr offset, fb_bfd_size_type count) {
	return bfd_set_section_contents( abfd, section, data, (file_ptr)offset, (bfd_size_type)count );
}

fb_bfd_boolean fb_bfd_set_arch_mach (bfd *abfd, enum FB_bfd_architecture arch, unsigned int mach) {
	return bfd_set_arch_mach( abfd, hMapArch( arch ), mach );
}
