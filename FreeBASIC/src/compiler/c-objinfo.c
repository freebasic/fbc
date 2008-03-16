//	FreeBASIC - 32-bit BASIC Compiler.
//	Copyright (C) 2004-2007 The FreeBASIC development team.
//
//	This program is free software; you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation; either version 2 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program; if not, write to the Free Software
//	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.

#include "bfd.h"

#define FB_SEC_HAS_CONTENTS 0x100

int hMapFlag( int flag ) {
	switch (flag) {
	    case FB_SEC_HAS_CONTENTS:
	    	return SEC_HAS_CONTENTS;
	}
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
	}
}

enum FB_bfd_architecture {
        FB_bfd_arch_i386
} FB_bfd_architecture;

bfd_format hMapArch( enum FB_bfd_architecture arch ) {
	switch (arch) {
	    case FB_bfd_arch_i386:
	    	return bfd_arch_i386;
	}
}

void fb_bfd_init( void ) {
	bfd_init( );
}

bfd *fb_bfd_openr (char *filename, char *target) {
	return bfd_openr( filename, target );
}

bfd_boolean fb_bfd_close (bfd *abfd) {
	return bfd_close( abfd );
}

bfd_boolean fb_bfd_check_format (bfd *abfd, enum FB_bfd_format format) {
	return bfd_check_format( abfd, hMapFormat( format ) );
}

bfd *fb_bfd_openr_next_archived_file (bfd *archive, bfd *previous) {
	return bfd_openr_next_archived_file( archive, previous );
}

bfd *fb_bfd_openw (char *filename, char *target) {
	return bfd_openw( filename, target );
}

bfd_boolean fb_bfd_set_format (bfd *abfd, enum FB_bfd_format format) {
	return bfd_set_format( abfd, hMapFormat( format ) );
}

asection *fb_bfd_get_section_by_name (bfd *abfd, char *name) {
	return bfd_get_section_by_name( abfd, name );
}

bfd_size_type fb_bfd_get_section_size (asection *section) {
	bfd_get_section_size( section );
}

bfd_boolean fb_bfd_set_section_size (bfd *abfd, asection *sec, bfd_size_type val) {
	bfd_set_section_size( abfd, sec, val );
}

char *fb_bfd_get_filename (bfd *abfd) {
	bfd_get_filename( abfd );
}

asection *fb_bfd_make_section (bfd *abfd, char *name) {
	bfd_make_section( abfd, name );
}

bfd_boolean fb_bfd_check_format_matches (bfd *abfd, enum FB_bfd_format format, char ***matching) {
	fb_bfd_check_format_matches( abfd, format, matching );
}

bfd_boolean fb_bfd_set_section_flags (bfd *abfd, asection *sec, flagword flags) {
	bfd_set_section_flags( abfd, sec, hMapFlag( flags ) );
}

bfd_boolean fb_bfd_get_section_contents (bfd *abfd, asection *section, void *location, file_ptr offset, bfd_size_type count) {
	bfd_get_section_contents( abfd, section, location, offset, count );
}

bfd_boolean fb_bfd_set_section_contents (bfd *abfd, asection *section, void *data, file_ptr offset, bfd_size_type count) {
	bfd_set_section_contents( abfd, section, data, offset, count );
}

bfd_boolean fb_bfd_set_arch_mach (bfd *abfd, enum FB_bfd_architecture arch, unsigned int mach) {
	bfd_set_arch_mach( abfd, hMapArch( arch ), mach );
}
