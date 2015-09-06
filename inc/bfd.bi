'' FreeBASIC binding for binutils-2.16.1, binutils-2.17, binutils-2.18, binutils-2.19.1, binutils-2.20.1, binutils-2.21.1, binutils-2.22, binutils-2.23.2, binutils-2.24, binutils-2.25
''
'' based on the C header files:
''   Main header file for the bfd library -- portable access to object files.
''
''   Copyright (C) 1990-2014 Free Software Foundation, Inc.
''
''   Contributed by Cygnus Support.
''
''   This file is part of BFD, the Binary File Descriptor library.
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or
''   (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __BFD_216__
#define __BFD_VER__ 216
#elseif defined(__BFD_217__)
#define __BFD_VER__ 217
#endif

#ifndef __BFD_VER__
#define __BFD_VER__ 217
#print bfd.bi: warning: defaulting to bfd 2.17 header: please define __BFD_VER__
#endif

#inclib "bfd"
#inclib "iberty"

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
	#inclib "intl"
#endif

#include once "crt/long.bi"
type stat as stat_  '' TODO: remove as soon as fbc's CRT headers define it

'' The following symbols have been renamed:
''     constant TRUE => CTRUE
''     #if __BFD_VER__ <= 218
''         constant DYNAMIC => DYNAMIC_
''     #endif
''     enum bfd_print_symbol => bfd_print_symbol_
''     procedure bfd_copy_private_section_data => bfd_copy_private_section_data_
''     procedure bfd_is_local_label_name => bfd_is_local_label_name_
''     procedure bfd_is_target_special_symbol => bfd_is_target_special_symbol_
''     procedure bfd_copy_private_symbol_data => bfd_copy_private_symbol_data_
''     #if __BFD_VER__ >= 219
''         constant DYNAMIC => DYNAMIC_
''     #endif
''     procedure bfd_copy_private_header_data => bfd_copy_private_header_data_
''     procedure bfd_copy_private_bfd_data => bfd_copy_private_bfd_data_
''     procedure bfd_merge_private_bfd_data => bfd_merge_private_bfd_data_
''     procedure bfd_set_private_flags => bfd_set_private_flags_
''     procedure bfd_link_split_section => bfd_link_split_section_
''     procedure bfd_section_already_linked => bfd_section_already_linked_

extern "C"

#define __BFD_H_SEEN__
#undef CONCAT4
#define CONCAT4(a, b, c, d) XCONCAT2(CONCAT2(a, b), CONCAT2(c, d))

#if __BFD_VER__ >= 220
	const BFD_SUPPORTS_PLUGINS = 1
#endif

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	const BFD_ARCH_SIZE = 64
	const BFD_DEFAULT_TARGET_SIZE = 64
#else
	const BFD_ARCH_SIZE = 32
	const BFD_DEFAULT_TARGET_SIZE = 32
#endif

const BFD_HOST_64BIT_LONG = 0

#if __BFD_VER__ >= 218
	const BFD_HOST_64BIT_LONG_LONG = 1
#endif

#if __BFD_VER__ <= 218
	const BFD_HOST_LONG_LONG = 1
#endif

type BFD_HOST_64_BIT as longint
type BFD_HOST_U_64_BIT as ulongint
type bfd_int64_t as longint
type bfd_uint64_t as ulongint

#if defined(__FB_64BIT__) and (((not defined(__FB_ARM__)) and ((defined(__FB_LINUX__) and (__BFD_VER__ >= 218)) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or (defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__))
	#define BFD64
#endif

#if __BFD_VER__ >= 218
	type bfd_hostptr_t as uinteger
#elseif defined(__FB_LINUX__) and defined(__FB_64BIT__) and (not defined(__FB_ARM__)) and (__BFD_VER__ <= 217)
	#define BFD64
#endif

type bfd_boolean as long
#ifndef FALSE
	const FALSE = 0
#endif
#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif

#if ((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))) or defined(__FB_DOS__)
	type bfd_vma as culong
	type bfd_signed_vma as clong
	type symvalue as culong
	type bfd_size_type as culong
#endif

#if (__BFD_VER__ <= 218) and (((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))) or defined(__FB_DOS__))
	#define fprintf_vma(s, x) fprintf(s, "%08lx", x)
	#define sprintf_vma(s, x) sprintf(s, "%08lx", x)
#elseif (__BFD_VER__ >= 219) and (((not defined(__FB_64BIT__)) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))) or defined(__FB_DOS__))
	#define BFD_VMA_FMT "l"
	#define fprintf_vma(s, x) fprintf(s, "%08" BFD_VMA_FMT "x", x)
	#define sprintf_vma(s, x) sprintf(s, "%08" BFD_VMA_FMT "x", x)
#endif

#if (__BFD_VER__ >= 217) and ((defined(__FB_LINUX__) and (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))) or defined(__FB_DOS__))
	#define HALF_BFD_SIZE_TYPE (cast(bfd_size_type, 1) shl ((8 * sizeof(bfd_size_type)) / 2))
#elseif defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	type bfd_vma as ulongint
	type bfd_signed_vma as longint
	type bfd_size_type as ulongint
	type symvalue as ulongint
#endif

#if defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__)) and (__BFD_VER__ <= 217)
	#define _bfd_int64_low(x) cast(culong, (x) and &hffffffff)
	#define _bfd_int64_high(x) cast(culong, ((x) shr 32) and &hffffffff)
	#define fprintf_vma(s, x) fprintf((s), "%08lx%08lx", _bfd_int64_high(x), _bfd_int64_low(x))
	#define sprintf_vma(s, x) sprintf((s), "%08lx%08lx", _bfd_int64_high(x), _bfd_int64_low(x))
#elseif defined(__FB_64BIT__) and (__BFD_VER__ = 218) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	#define sprintf_vma(s, x) sprintf(s, "%016llx", x)
	#define fprintf_vma(f, x) fprintf(f, "%016llx", x)
#elseif defined(__FB_64BIT__) and (__BFD_VER__ >= 219) and defined(__FB_UNIX__)
	#define BFD_VMA_FMT "ll"
#elseif defined(__FB_WIN32__) and defined(__FB_64BIT__) and (__BFD_VER__ >= 219)
	#define BFD_VMA_FMT "I64"
#endif

#if defined(__FB_64BIT__) and (__BFD_VER__ >= 219) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))
	#define sprintf_vma(s, x) sprintf(s, "%016" BFD_VMA_FMT "x", x)
	#define fprintf_vma(f, x) fprintf(f, "%016" BFD_VMA_FMT "x", x)
#endif

#if (__BFD_VER__ >= 217) and ((defined(__FB_64BIT__) and (defined(__FB_WIN32__) or defined(__FB_UNIX__))) or ((not defined(__FB_64BIT__)) and ((defined(__FB_ARM__) and (defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or ((not defined(__FB_ARM__)) and (defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__))) or defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__))))
	#define HALF_BFD_SIZE_TYPE (cast(bfd_size_type, 1) shl ((8 * sizeof(bfd_size_type)) / 2))
#endif

#ifdef __FB_DOS__
	type file_ptr as clong
	type ufile_ptr as culong
#else
	type file_ptr as longint
	type ufile_ptr as ulongint
#endif

type bfd as bfd_
declare sub bfd_sprintf_vma(byval as bfd ptr, byval as zstring ptr, byval as bfd_vma)
declare sub bfd_fprintf_vma(byval as bfd ptr, byval as any ptr, byval as bfd_vma)
#define printf_vma(x) fprintf_vma(stdout, x)
#define bfd_printf_vma(abfd, x) bfd_fprintf_vma(abfd, stdout, x)
type flagword as ulong
type bfd_byte as ubyte

type bfd_format as long
enum
	bfd_unknown = 0
	bfd_object
	bfd_archive
	bfd_core
	bfd_type_end
end enum

#if __BFD_VER__ <= 218
	const BFD_NO_FLAGS = &h00
	const HAS_RELOC = &h01
	const EXEC_P = &h02
	const HAS_LINENO = &h04
	const HAS_DEBUG = &h08
	const HAS_SYMS = &h10
	const HAS_LOCALS = &h20
	const DYNAMIC_ = &h40
	const WP_TEXT = &h80
	const D_PAGED = &h100
	const BFD_IS_RELAXABLE = &h200
	const BFD_TRADITIONAL_FORMAT = &h400
	const BFD_IN_MEMORY = &h800
	const HAS_LOAD_PAGE = &h1000
	const BFD_LINKER_CREATED = &h2000
#endif

type symindex as culong
type reloc_howto_type as const reloc_howto_struct
const BFD_NO_MORE_SYMBOLS = cast(symindex, not 0)
#define bfd_get_section(x) (x)->section
#define bfd_get_output_section(x) (x)->section->output_section
#define bfd_set_section(x, y) scope : (x)->section = (y) : end scope
#define bfd_asymbol_base(x) (x)->section->vma
#define bfd_asymbol_value(x) (bfd_asymbol_base(x) + (x)->value)
#define bfd_asymbol_name(x) (x)->name
#define bfd_asymbol_bfd(x) (x)->the_bfd

#if __BFD_VER__ <= 218
	#define bfd_asymbol_flavour(x) bfd_asymbol_bfd(x)->xvec->flavour
#else
	#define bfd_asymbol_flavour(x) iif(((x)->flags and BSF_SYNTHETIC) <> 0, bfd_target_unknown_flavour, bfd_asymbol_bfd(x)->xvec->flavour)
#endif

type carsym
	name as zstring ptr
	file_offset as file_ptr
end type

union orl_u
	pos as file_ptr
	abfd as bfd ptr
end union

type orl
	name as zstring ptr ptr
	u as orl_u
	namidx as long
end type

type bfd_symbol as bfd_symbol_

union lineno_cache_entry_u
	sym as bfd_symbol ptr
	offset as bfd_vma
end union

type lineno_cache_entry
	line_number as ulong
	u as lineno_cache_entry_u
end type

type alent as lineno_cache_entry
#define align_power(addr, align) ((((addr) + (cast(bfd_vma, 1) shl (align))) - 1) and (cast(bfd_vma, -1) shl (align)))
type bfd_section as bfd_section_
type sec_ptr as bfd_section ptr

#if __BFD_VER__ <= 222
	#define bfd_get_section_name(bfd, ptr_) ((ptr_)->name + 0)
	#define bfd_get_section_vma(bfd, ptr_) ((ptr_)->vma + 0)
	#define bfd_get_section_lma(bfd, ptr_) ((ptr_)->lma + 0)
	#define bfd_get_section_alignment(bfd, ptr_) ((ptr_)->alignment_power + 0)
#else
	#define bfd_get_section_name(bfd, ptr_) (ptr_)->name
	#define bfd_get_section_vma(bfd, ptr_) (ptr_)->vma
	#define bfd_get_section_lma(bfd, ptr_) (ptr_)->lma
	#define bfd_get_section_alignment(bfd, ptr_) (ptr_)->alignment_power
#endif

#define bfd_section_name(bfd, ptr_) (ptr_)->name
#define bfd_section_size(bfd, ptr_) (ptr_)->size
#define bfd_get_section_size(ptr_) (ptr_)->size
#define bfd_section_vma(bfd, ptr_) (ptr_)->vma
#define bfd_section_lma(bfd, ptr_) (ptr_)->lma
#define bfd_section_alignment(bfd, ptr_) (ptr_)->alignment_power

#if __BFD_VER__ <= 222
	#define bfd_get_section_flags(bfd, ptr_) ((ptr_)->flags + 0)
#else
	#define bfd_get_section_flags(bfd, ptr_) (ptr_)->flags
#endif

#define bfd_get_section_userdata(bfd, ptr_) (ptr_)->userdata
#define bfd_is_com_section(ptr_) (((ptr_)->flags and SEC_IS_COMMON) <> 0)

#if __BFD_VER__ <= 224
	#macro bfd_set_section_vma(bfd, ptr, val)
		scope
			var __val = (val)
			(ptr)->vma = __val
			(ptr)->lma = __val
			(ptr)->user_set_vma = CTRUE
		end scope
	#endmacro
	#define bfd_set_section_alignment(bfd, ptr_, val_) scope : (ptr_)->alignment_power = (val_) : end scope
	#define bfd_set_section_userdata(bfd, ptr_, val_) scope : (ptr_)->userdata = (val_) : end scope
#endif

#if __BFD_VER__ <= 221
	#define bfd_get_section_limit(bfd, sec) (iif((sec)->rawsize, (sec)->rawsize, (sec)->size) / bfd_octets_per_byte(bfd))
#endif

#if __BFD_VER__ <= 217
	type stat_type as stat
#elseif __BFD_VER__ >= 222
	#define bfd_get_section_limit(bfd, sec) (iif(((bfd)->direction <> write_direction) andalso ((sec)->rawsize <> 0), (sec)->rawsize, (sec)->size) / bfd_octets_per_byte(bfd))
#endif

#if (__BFD_VER__ >= 218) and (__BFD_VER__ <= 222)
	#define elf_discarded_section(sec) ((((bfd_is_abs_section(sec) = 0) andalso bfd_is_abs_section((sec)->output_section)) andalso ((sec)->sec_info_type <> ELF_INFO_TYPE_MERGE)) andalso ((sec)->sec_info_type <> ELF_INFO_TYPE_JUST_SYMS))
#elseif __BFD_VER__ >= 223
	#define discarded_section(sec) ((((bfd_is_abs_section(sec) = 0) andalso bfd_is_abs_section((sec)->output_section)) andalso ((sec)->sec_info_type <> SEC_INFO_TYPE_MERGE)) andalso ((sec)->sec_info_type <> SEC_INFO_TYPE_JUST_SYMS))
#endif

type bfd_print_symbol_ as long
enum
	bfd_print_symbol_name
	bfd_print_symbol_more
	bfd_print_symbol_all
end enum

type bfd_print_symbol_type as bfd_print_symbol_

type _symbol_info
	value as symvalue
	as byte type
	name as const zstring ptr
	stab_type as ubyte
	stab_other as byte
	stab_desc as short
	stab_name as const zstring ptr
end type

type symbol_info as _symbol_info
declare function bfd_get_stab_name(byval as long) as const zstring ptr

type bfd_hash_entry
	next as bfd_hash_entry ptr
	string as const zstring ptr
	hash as culong
end type

type bfd_hash_table
	table as bfd_hash_entry ptr ptr

	#if __BFD_VER__ <= 217
		size as ulong
	#endif

	#if __BFD_VER__ = 217
		entsize as ulong
	#endif

	newfunc as function(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr
	memory as any ptr

	#if __BFD_VER__ >= 218
		size as ulong
		count as ulong
		entsize as ulong
		frozen : 1 as ulong
	#endif
end type

#if __BFD_VER__ = 216
	declare function bfd_hash_table_init(byval as bfd_hash_table ptr, byval as function(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr) as bfd_boolean
	declare function bfd_hash_table_init_n(byval as bfd_hash_table ptr, byval as function(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr, byval size as ulong) as bfd_boolean
#else
	declare function bfd_hash_table_init(byval as bfd_hash_table ptr, byval as function(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr, byval as ulong) as bfd_boolean
	declare function bfd_hash_table_init_n(byval as bfd_hash_table ptr, byval as function(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr, byval as ulong, byval as ulong) as bfd_boolean
#endif

declare sub bfd_hash_table_free(byval as bfd_hash_table ptr)
declare function bfd_hash_lookup(byval as bfd_hash_table ptr, byval as const zstring ptr, byval create as bfd_boolean, byval copy as bfd_boolean) as bfd_hash_entry ptr

#if __BFD_VER__ >= 219
	declare function bfd_hash_insert(byval as bfd_hash_table ptr, byval as const zstring ptr, byval as culong) as bfd_hash_entry ptr
#endif

#if __BFD_VER__ >= 221
	declare sub bfd_hash_rename(byval as bfd_hash_table ptr, byval as const zstring ptr, byval as bfd_hash_entry ptr)
#endif

declare sub bfd_hash_replace(byval as bfd_hash_table ptr, byval old as bfd_hash_entry ptr, byval nw as bfd_hash_entry ptr)
declare function bfd_hash_newfunc(byval as bfd_hash_entry ptr, byval as bfd_hash_table ptr, byval as const zstring ptr) as bfd_hash_entry ptr
declare function bfd_hash_allocate(byval as bfd_hash_table ptr, byval as ulong) as any ptr
declare sub bfd_hash_traverse(byval as bfd_hash_table ptr, byval as function(byval as bfd_hash_entry ptr, byval as any ptr) as bfd_boolean, byval info as any ptr)

#if __BFD_VER__ <= 221
	declare sub bfd_hash_set_default_size(byval as bfd_size_type)
#else
	declare function bfd_hash_set_default_size(byval as culong) as culong
#endif

type bfd_strtab_hash as bfd_strtab_hash_

type stab_info
	strings as bfd_strtab_hash ptr
	includes as bfd_hash_table
	stabstr as bfd_section ptr
end type

#define COFF_SWAP_TABLE cptr(any ptr, @bfd_coff_std_swap_table)
declare function bfd_bread(byval as any ptr, byval as bfd_size_type, byval as bfd ptr) as bfd_size_type
declare function bfd_bwrite(byval as const any ptr, byval as bfd_size_type, byval as bfd ptr) as bfd_size_type
declare function bfd_seek(byval as bfd ptr, byval as file_ptr, byval as long) as long
declare function bfd_tell(byval as bfd ptr) as file_ptr
declare function bfd_flush(byval as bfd ptr) as long
declare function bfd_stat(byval as bfd ptr, byval as stat ptr) as long
#define bfd_read(BUF, ELTSIZE, NITEMS, ABFD) bfd_bread((BUF), (ELTSIZE) * (NITEMS), (ABFD))
#define bfd_write(BUF, ELTSIZE, NITEMS, ABFD) bfd_bwrite((BUF), (ELTSIZE) * (NITEMS), (ABFD))
declare sub warn_deprecated(byval as const zstring ptr, byval as const zstring ptr, byval as long, byval as const zstring ptr)

#define bfd_get_filename(abfd) cptr(zstring ptr, (abfd)->filename)
#define bfd_get_cacheable(abfd) (abfd)->cacheable
#define bfd_get_format(abfd) (abfd)->format
#define bfd_get_target(abfd) (abfd)->xvec->name
#define bfd_get_flavour(abfd) (abfd)->xvec->flavour
#define bfd_family_coff(abfd) ((bfd_get_flavour(abfd) = bfd_target_coff_flavour) orelse (bfd_get_flavour(abfd) = bfd_target_xcoff_flavour))
#define bfd_big_endian(abfd) ((abfd)->xvec->byteorder = BFD_ENDIAN_BIG)
#define bfd_little_endian(abfd) ((abfd)->xvec->byteorder = BFD_ENDIAN_LITTLE)
#define bfd_header_big_endian(abfd) ((abfd)->xvec->header_byteorder = BFD_ENDIAN_BIG)
#define bfd_header_little_endian(abfd) ((abfd)->xvec->header_byteorder = BFD_ENDIAN_LITTLE)
#define bfd_get_file_flags(abfd) (abfd)->flags
#define bfd_applicable_file_flags(abfd) (abfd)->xvec->object_flags
#define bfd_applicable_section_flags(abfd) (abfd)->xvec->section_flags
#define bfd_my_archive(abfd) (abfd)->my_archive
#define bfd_has_map(abfd) (abfd)->has_armap

#if __BFD_VER__ >= 219
	#define bfd_is_thin_archive(abfd) (abfd)->is_thin_archive
#endif

#define bfd_valid_reloc_types(abfd) (abfd)->xvec->valid_reloc_types
#define bfd_usrdata(abfd) (abfd)->usrdata
#define bfd_get_start_address(abfd) (abfd)->start_address
#define bfd_get_symcount(abfd) (abfd)->symcount
#define bfd_get_outsymbols(abfd) (abfd)->outsymbols
#define bfd_count_sections(abfd) (abfd)->section_count
#define bfd_get_dynamic_symcount(abfd) (abfd)->dynsymcount
#define bfd_get_symbol_leading_char(abfd) (abfd)->xvec->symbol_leading_char

#if __BFD_VER__ <= 224
	#define bfd_set_cacheable(abfd, bool) scope : (abfd)->cacheable = bool : end scope
#endif

declare function bfd_cache_close(byval abfd as bfd ptr) as bfd_boolean
declare function bfd_cache_close_all() as bfd_boolean
declare function bfd_record_phdr(byval as bfd ptr, byval as culong, byval as bfd_boolean, byval as flagword, byval as bfd_boolean, byval as bfd_vma, byval as bfd_boolean, byval as bfd_boolean, byval as ulong, byval as bfd_section ptr ptr) as bfd_boolean
declare function bfd_getb64(byval as const any ptr) as bfd_uint64_t
declare function bfd_getl64(byval as const any ptr) as bfd_uint64_t
declare function bfd_getb_signed_64(byval as const any ptr) as bfd_int64_t
declare function bfd_getl_signed_64(byval as const any ptr) as bfd_int64_t
declare function bfd_getb32(byval as const any ptr) as bfd_vma
declare function bfd_getl32(byval as const any ptr) as bfd_vma
declare function bfd_getb_signed_32(byval as const any ptr) as bfd_signed_vma
declare function bfd_getl_signed_32(byval as const any ptr) as bfd_signed_vma
declare function bfd_getb16(byval as const any ptr) as bfd_vma
declare function bfd_getl16(byval as const any ptr) as bfd_vma
declare function bfd_getb_signed_16(byval as const any ptr) as bfd_signed_vma
declare function bfd_getl_signed_16(byval as const any ptr) as bfd_signed_vma
declare sub bfd_putb64(byval as bfd_uint64_t, byval as any ptr)
declare sub bfd_putl64(byval as bfd_uint64_t, byval as any ptr)
declare sub bfd_putb32(byval as bfd_vma, byval as any ptr)
declare sub bfd_putl32(byval as bfd_vma, byval as any ptr)
declare sub bfd_putb16(byval as bfd_vma, byval as any ptr)
declare sub bfd_putl16(byval as bfd_vma, byval as any ptr)
declare function bfd_get_bits(byval as const any ptr, byval as long, byval as bfd_boolean) as bfd_uint64_t
declare sub bfd_put_bits(byval as bfd_uint64_t, byval as any ptr, byval as long, byval as bfd_boolean)
declare function bfd_section_already_linked_table_init() as bfd_boolean
declare sub bfd_section_already_linked_table_free()

#if __BFD_VER__ >= 222
	type bfd_section_already_linked_t as bfd_section_already_linked_t_
	type bfd_link_info as bfd_link_info_
	declare function _bfd_handle_already_linked(byval as bfd_section ptr, byval as bfd_section_already_linked_t ptr, byval as bfd_link_info ptr) as bfd_boolean
#endif

declare function bfd_ecoff_get_gp_value(byval abfd as bfd ptr) as bfd_vma
declare function bfd_ecoff_set_gp_value(byval abfd as bfd ptr, byval gp_value as bfd_vma) as bfd_boolean
declare function bfd_ecoff_set_regmasks(byval abfd as bfd ptr, byval gprmask as culong, byval fprmask as culong, byval cprmask as culong ptr) as bfd_boolean
type ecoff_debug_info as ecoff_debug_info_
type ecoff_debug_swap as ecoff_debug_swap_

#if __BFD_VER__ <= 221
	type bfd_link_info as bfd_link_info_
#endif

declare function bfd_ecoff_debug_init(byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as const ecoff_debug_swap ptr, byval as bfd_link_info ptr) as any ptr
declare sub bfd_ecoff_debug_free(byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as const ecoff_debug_swap ptr, byval as bfd_link_info ptr)
declare function bfd_ecoff_debug_accumulate(byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as const ecoff_debug_swap ptr, byval input_bfd as bfd ptr, byval input_debug as ecoff_debug_info ptr, byval input_swap as const ecoff_debug_swap ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_ecoff_debug_accumulate_other(byval handle as any ptr, byval output_bfd as bfd ptr, byval output_debug as ecoff_debug_info ptr, byval output_swap as const ecoff_debug_swap ptr, byval input_bfd as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
type ecoff_extr as ecoff_extr_
declare function bfd_ecoff_debug_externals(byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as const ecoff_debug_swap ptr, byval relocatable as bfd_boolean, byval get_extr as function(byval as bfd_symbol ptr, byval as ecoff_extr ptr) as bfd_boolean, byval set_index as sub(byval as bfd_symbol ptr, byval as bfd_size_type)) as bfd_boolean
declare function bfd_ecoff_debug_one_external(byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as const ecoff_debug_swap ptr, byval name as const zstring ptr, byval esym as ecoff_extr ptr) as bfd_boolean
declare function bfd_ecoff_debug_size(byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as const ecoff_debug_swap ptr) as bfd_size_type
declare function bfd_ecoff_write_debug(byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as const ecoff_debug_swap ptr, byval where as file_ptr) as bfd_boolean
declare function bfd_ecoff_write_accumulated_debug(byval handle as any ptr, byval abfd as bfd ptr, byval debug as ecoff_debug_info ptr, byval swap as const ecoff_debug_swap ptr, byval info as bfd_link_info ptr, byval where as file_ptr) as bfd_boolean

type bfd_link_needed_list
	next as bfd_link_needed_list ptr
	by as bfd ptr
	name as const zstring ptr
end type

type dynamic_lib_link_class as long
enum
	DYN_NORMAL = 0
	DYN_AS_NEEDED = 1
	DYN_DT_NEEDED = 2
	DYN_NO_ADD_NEEDED = 4
	DYN_NO_NEEDED = 8
end enum

#if __BFD_VER__ = 216
	declare function bfd_elf_record_link_assignment(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr, byval as bfd_boolean) as bfd_boolean
#elseif __BFD_VER__ >= 218
	type notice_asneeded_action as long
	enum
		notice_as_needed
		notice_not_needed
		notice_needed
	end enum
#endif

#if __BFD_VER__ >= 217
	declare function bfd_elf_record_link_assignment(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr, byval as bfd_boolean, byval as bfd_boolean) as bfd_boolean
#endif

declare function bfd_elf_get_needed_list(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr
declare function bfd_elf_get_bfd_needed_list(byval as bfd ptr, byval as bfd_link_needed_list ptr ptr) as bfd_boolean

#if __BFD_VER__ <= 221
	type bfd_elf_version_tree as bfd_elf_version_tree_
#endif

#if __BFD_VER__ <= 220
	declare function bfd_elf_size_dynamic_sections(byval as bfd ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring const ptr ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr, byval as bfd_elf_version_tree ptr) as bfd_boolean
#elseif __BFD_VER__ = 221
	declare function bfd_elf_size_dynamic_sections(byval as bfd ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring const ptr ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr, byval as bfd_elf_version_tree ptr) as bfd_boolean
#elseif __BFD_VER__ >= 224
	declare function bfd_elf_stack_segment_size(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr, byval as bfd_vma) as bfd_boolean
#endif

#if __BFD_VER__ >= 222
	declare function bfd_elf_size_dynamic_sections(byval as bfd ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring const ptr ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 217
	declare function bfd_elf_size_dynsym_hash_dynstr(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
#endif

declare sub bfd_elf_set_dt_needed_name(byval as bfd ptr, byval as const zstring ptr)
declare function bfd_elf_get_dt_soname(byval as bfd ptr) as const zstring ptr

#if __BFD_VER__ <= 217
	declare sub bfd_elf_set_dyn_lib_class(byval as bfd ptr, byval as long)
#else
	declare sub bfd_elf_set_dyn_lib_class(byval as bfd ptr, byval as dynamic_lib_link_class)
#endif

declare function bfd_elf_get_dyn_lib_class(byval as bfd ptr) as long
declare function bfd_elf_get_runpath_list(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr

#if __BFD_VER__ = 225
	declare function bfd_elf_discard_info(byval as bfd ptr, byval as bfd_link_info ptr) as long
#else
	declare function bfd_elf_discard_info(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 217
	declare function _bfd_elf_default_action_discarded(byval as bfd_section ptr) as ulong
#endif

declare function bfd_get_elf_phdr_upper_bound(byval abfd as bfd ptr) as clong
declare function bfd_get_elf_phdrs(byval abfd as bfd ptr, byval phdrs as any ptr) as long

#if __BFD_VER__ <= 222
	declare function bfd_elf_bfd_from_remote_memory(byval templ as bfd ptr, byval ehdr_vma as bfd_vma, byval loadbasep as bfd_vma ptr, byval target_read_memory as function(byval vma as bfd_vma, byval myaddr as bfd_byte ptr, byval len as long) as long) as bfd ptr
#elseif (__BFD_VER__ = 223) or (__BFD_VER__ = 224)
	declare function bfd_elf_bfd_from_remote_memory(byval templ as bfd ptr, byval ehdr_vma as bfd_vma, byval loadbasep as bfd_vma ptr, byval target_read_memory as function(byval vma as bfd_vma, byval myaddr as bfd_byte ptr, byval len as bfd_size_type) as long) as bfd ptr
#else
	declare function bfd_elf_bfd_from_remote_memory(byval templ as bfd ptr, byval ehdr_vma as bfd_vma, byval size as bfd_size_type, byval loadbasep as bfd_vma ptr, byval target_read_memory as function(byval vma as bfd_vma, byval myaddr as bfd_byte ptr, byval len as bfd_size_type) as long) as bfd ptr
#endif

declare function _bfd_elf_tls_setup(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_section ptr

#if __BFD_VER__ >= 223
	declare function _bfd_nearby_section(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_vma) as bfd_section ptr
#endif

#if __BFD_VER__ >= 217
	declare sub _bfd_fix_excluded_sec_syms(byval as bfd ptr, byval as bfd_link_info ptr)
	declare function bfd_m68k_mach_to_features(byval as long) as ulong
	declare function bfd_m68k_features_to_mach(byval as ulong) as long
#endif

declare function bfd_m68k_elf32_create_embedded_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as zstring ptr ptr) as bfd_boolean

#if __BFD_VER__ >= 219
	declare sub bfd_elf_m68k_set_target_options(byval as bfd_link_info ptr, byval as long)
#endif

#if __BFD_VER__ >= 217
	declare function bfd_bfin_elf32_create_embedded_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as zstring ptr ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 220
	declare function bfd_cr16_elf32_create_embedded_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as zstring ptr ptr) as bfd_boolean
#endif

declare function bfd_sunos_get_needed_list(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_link_needed_list ptr
declare function bfd_sunos_record_link_assignment(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr) as bfd_boolean
declare function bfd_sunos_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr ptr, byval as bfd_section ptr ptr, byval as bfd_section ptr ptr) as bfd_boolean
declare function bfd_i386linux_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_m68klinux_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_sparclinux_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
type _bfd_window_internal as _bfd_window_internal_
type bfd_window_internal as _bfd_window_internal

type _bfd_window
	data as any ptr
	size as bfd_size_type
	i as _bfd_window_internal ptr
end type

type bfd_window as _bfd_window
declare sub bfd_init_window(byval as bfd_window ptr)
declare sub bfd_free_window(byval as bfd_window ptr)
declare function bfd_get_file_window(byval as bfd ptr, byval as file_ptr, byval as bfd_size_type, byval as bfd_window ptr, byval as bfd_boolean) as bfd_boolean

#if __BFD_VER__ >= 220
	declare function bfd_xcoff_split_import_path(byval as bfd ptr, byval as const zstring ptr, byval as const zstring ptr ptr, byval as const zstring ptr ptr) as bfd_boolean
	declare function bfd_xcoff_set_archive_import_path(byval as bfd_link_info ptr, byval as bfd ptr, byval as const zstring ptr) as bfd_boolean
#endif

type bfd_link_hash_entry as bfd_link_hash_entry_
declare function bfd_xcoff_link_record_set(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr, byval as bfd_size_type) as bfd_boolean
declare function bfd_xcoff_import_symbol(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr, byval as bfd_vma, byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr, byval as ulong) as bfd_boolean
declare function bfd_xcoff_export_symbol(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr) as bfd_boolean
declare function bfd_xcoff_link_count_reloc(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr) as bfd_boolean
declare function bfd_xcoff_record_link_assignment(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr) as bfd_boolean

#if __BFD_VER__ <= 219
	declare function bfd_xcoff_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr, byval as const zstring ptr, byval as culong, byval as culong, byval as culong, byval as bfd_boolean, byval as long, byval as bfd_boolean, byval as bfd_boolean, byval as bfd_section ptr ptr, byval as bfd_boolean) as bfd_boolean
#else
	declare function bfd_xcoff_size_dynamic_sections(byval as bfd ptr, byval as bfd_link_info ptr, byval as const zstring ptr, byval as const zstring ptr, byval as culong, byval as culong, byval as culong, byval as bfd_boolean, byval as long, byval as bfd_boolean, byval as ulong, byval as bfd_section ptr ptr, byval as bfd_boolean) as bfd_boolean
#endif

declare function bfd_xcoff_link_generate_rtinit(byval as bfd ptr, byval as const zstring ptr, byval as const zstring ptr, byval as bfd_boolean) as bfd_boolean
declare function bfd_xcoff_ar_archive_set_magic(byval as bfd ptr, byval as zstring ptr) as bfd_boolean
type internal_syment as internal_syment_
declare function bfd_coff_get_syment(byval as bfd ptr, byval as bfd_symbol ptr, byval as internal_syment ptr) as bfd_boolean
type internal_auxent as internal_auxent_
declare function bfd_coff_get_auxent(byval as bfd ptr, byval as bfd_symbol ptr, byval as long, byval as internal_auxent ptr) as bfd_boolean
declare function bfd_coff_set_symbol_class(byval as bfd ptr, byval as bfd_symbol ptr, byval as ulong) as bfd_boolean
declare function bfd_m68k_coff_create_embedded_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_section ptr, byval as bfd_section ptr, byval as zstring ptr ptr) as bfd_boolean

#if __BFD_VER__ >= 218
	type bfd_arm_vfp11_fix as long
	enum
		BFD_ARM_VFP11_FIX_DEFAULT
		BFD_ARM_VFP11_FIX_NONE
		BFD_ARM_VFP11_FIX_SCALAR
		BFD_ARM_VFP11_FIX_VECTOR
	end enum

	declare sub bfd_elf32_arm_init_maps(byval as bfd ptr)
	declare sub bfd_elf32_arm_set_vfp11_fix(byval as bfd ptr, byval as bfd_link_info ptr)
#endif

#if __BFD_VER__ >= 220
	declare sub bfd_elf32_arm_set_cortex_a8_fix(byval as bfd ptr, byval as bfd_link_info ptr)
#endif

#if __BFD_VER__ >= 218
	declare function bfd_elf32_arm_vfp11_erratum_scan(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	declare sub bfd_elf32_arm_vfp11_fix_veneer_locations(byval as bfd ptr, byval as bfd_link_info ptr)
#endif

declare function bfd_arm_allocate_interworking_sections(byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_process_before_allocation(byval as bfd ptr, byval as bfd_link_info ptr, byval as long) as bfd_boolean
declare function bfd_arm_get_bfd_for_interworking(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_pe_allocate_interworking_sections(byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_arm_pe_process_before_allocation(byval as bfd ptr, byval as bfd_link_info ptr, byval as long) as bfd_boolean
declare function bfd_arm_pe_get_bfd_for_interworking(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_elf32_arm_allocate_interworking_sections(byval as bfd_link_info ptr) as bfd_boolean

#if __BFD_VER__ <= 217
	declare function bfd_elf32_arm_process_before_allocation(byval as bfd ptr, byval as bfd_link_info ptr, byval as long) as bfd_boolean
#endif

#if __BFD_VER__ = 216
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long)
#elseif __BFD_VER__ = 217
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long, byval as long)
#else
	declare function bfd_elf32_arm_process_before_allocation(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
#endif

#if __BFD_VER__ = 218
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long, byval as long, byval as bfd_arm_vfp11_fix, byval as long, byval as long)
#elseif __BFD_VER__ = 219
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long, byval as long, byval as bfd_arm_vfp11_fix, byval as long, byval as long, byval as long)
#elseif (__BFD_VER__ = 220) or (__BFD_VER__ = 221)
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long, byval as long, byval as bfd_arm_vfp11_fix, byval as long, byval as long, byval as long, byval as long)
#elseif __BFD_VER__ >= 222
	declare sub bfd_elf32_arm_set_target_relocs(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as zstring ptr, byval as long, byval as long, byval as bfd_arm_vfp11_fix, byval as long, byval as long, byval as long, byval as long, byval as long)
#endif

declare function bfd_elf32_arm_get_bfd_for_interworking(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
declare function bfd_elf32_arm_add_glue_sections_to_bfd(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean

#if __BFD_VER__ = 217
	declare function bfd_is_arm_mapping_symbol_name(byval name as const zstring ptr) as bfd_boolean
#elseif __BFD_VER__ >= 218
	const BFD_ARM_SPECIAL_SYM_TYPE_MAP = 1 shl 0
	const BFD_ARM_SPECIAL_SYM_TYPE_TAG = 1 shl 1
	const BFD_ARM_SPECIAL_SYM_TYPE_OTHER = 1 shl 2
	const BFD_ARM_SPECIAL_SYM_TYPE_ANY = not 0
#endif

#if (__BFD_VER__ >= 218) and (__BFD_VER__ <= 224)
	declare function bfd_is_arm_special_symbol_name(byval name as const zstring ptr, byval type as long) as bfd_boolean
#elseif __BFD_VER__ = 225
	declare function bfd_is_arm_special_symbol_name(byval as const zstring ptr, byval as long) as bfd_boolean
#endif

#if __BFD_VER__ >= 218
	declare sub bfd_elf32_arm_set_byteswap_code(byval as bfd_link_info ptr, byval as long)
#endif

#if __BFD_VER__ = 225
	declare sub bfd_elf32_arm_use_long_plt()
#endif

declare function bfd_arm_merge_machines(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
declare function bfd_arm_update_notes(byval as bfd ptr, byval as const zstring ptr) as bfd_boolean
declare function bfd_arm_get_mach_from_notes(byval as bfd ptr, byval as const zstring ptr) as ulong

#if __BFD_VER__ >= 219
	declare function elf32_arm_setup_section_lists(byval as bfd ptr, byval as bfd_link_info ptr) as long
	declare sub elf32_arm_next_input_section(byval as bfd_link_info ptr, byval as bfd_section ptr)
#endif

#if (__BFD_VER__ >= 219) and (__BFD_VER__ <= 223)
	declare function elf32_arm_size_stubs(byval as bfd ptr, byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_signed_vma, byval as function(byval as const zstring ptr, byval as bfd_section ptr) as bfd_section ptr, byval as sub()) as bfd_boolean
#elseif __BFD_VER__ >= 224
	declare function elf32_arm_size_stubs(byval as bfd ptr, byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_signed_vma, byval as function(byval as const zstring ptr, byval as bfd_section ptr, byval as ulong) as bfd_section ptr, byval as sub()) as bfd_boolean
#endif

#if __BFD_VER__ >= 219
	declare function elf32_arm_build_stubs(byval as bfd_link_info ptr) as bfd_boolean
#endif

#if __BFD_VER__ = 220
	declare function elf32_arm_fix_exidx_coverage(byval as bfd_section ptr ptr, byval as ulong, byval as bfd_link_info ptr) as bfd_boolean
#elseif __BFD_VER__ >= 221
	declare function elf32_arm_fix_exidx_coverage(byval as bfd_section ptr ptr, byval as ulong, byval as bfd_link_info ptr, byval as bfd_boolean) as bfd_boolean
#endif

#if __BFD_VER__ >= 222
	declare function elf32_tic6x_fix_exidx_coverage(byval as bfd_section ptr ptr, byval as ulong, byval as bfd_link_info ptr, byval as bfd_boolean) as bfd_boolean
#endif

#if __BFD_VER__ >= 220
	declare function _bfd_elf_ppc_at_tls_transform(byval as ulong, byval as ulong) as ulong
	declare function _bfd_elf_ppc_at_tprel_transform(byval as ulong, byval as ulong) as ulong
#endif

#if __BFD_VER__ >= 223
	declare sub bfd_elf64_aarch64_init_maps(byval as bfd ptr)
#endif

#if __BFD_VER__ >= 224
	declare sub bfd_elf32_aarch64_init_maps(byval as bfd ptr)
#endif

#if (__BFD_VER__ = 223) or (__BFD_VER__ = 224)
	declare sub bfd_elf64_aarch64_set_options(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as long, byval as long)
#endif

#if __BFD_VER__ = 224
	declare sub bfd_elf32_aarch64_set_options(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as long, byval as long)
#elseif __BFD_VER__ = 225
	declare sub bfd_elf64_aarch64_set_options(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as long, byval as long, byval as long)
	declare sub bfd_elf32_aarch64_set_options(byval as bfd ptr, byval as bfd_link_info ptr, byval as long, byval as long, byval as long, byval as long)
#endif

#if __BFD_VER__ >= 223
	const BFD_AARCH64_SPECIAL_SYM_TYPE_MAP = 1 shl 0
	const BFD_AARCH64_SPECIAL_SYM_TYPE_TAG = 1 shl 1
	const BFD_AARCH64_SPECIAL_SYM_TYPE_OTHER = 1 shl 2
	const BFD_AARCH64_SPECIAL_SYM_TYPE_ANY = not 0

	declare function bfd_is_aarch64_special_symbol_name(byval name as const zstring ptr, byval type as long) as bfd_boolean
	declare function elf64_aarch64_setup_section_lists(byval as bfd ptr, byval as bfd_link_info ptr) as long
	declare sub elf64_aarch64_next_input_section(byval as bfd_link_info ptr, byval as bfd_section ptr)
	declare function elf64_aarch64_size_stubs(byval as bfd ptr, byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_signed_vma, byval as function(byval as const zstring ptr, byval as bfd_section ptr) as bfd_section ptr, byval as sub()) as bfd_boolean
	declare function elf64_aarch64_build_stubs(byval as bfd_link_info ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 224
	declare function elf32_aarch64_setup_section_lists(byval as bfd ptr, byval as bfd_link_info ptr) as long
	declare sub elf32_aarch64_next_input_section(byval as bfd_link_info ptr, byval as bfd_section ptr)
	declare function elf32_aarch64_size_stubs(byval as bfd ptr, byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_signed_vma, byval as function(byval as const zstring ptr, byval as bfd_section ptr) as bfd_section ptr, byval as sub()) as bfd_boolean
	declare function elf32_aarch64_build_stubs(byval as bfd_link_info ptr) as bfd_boolean
#endif

declare sub bfd_ticoff_set_section_load_page(byval as bfd_section ptr, byval as long)
declare function bfd_ticoff_get_section_load_page(byval as bfd_section ptr) as long
declare function bfd_h8300_pad_address(byval as bfd ptr, byval as bfd_vma) as bfd_vma
declare sub bfd_elf32_ia64_after_parse(byval as long)
declare sub bfd_elf64_ia64_after_parse(byval as long)

type coff_comdat_info
	name as const zstring ptr
	symbol as clong
end type

declare function bfd_coff_get_comdat_section(byval as bfd ptr, byval as bfd_section ptr) as coff_comdat_info ptr
declare sub bfd_init()

#if __BFD_VER__ >= 221
	extern bfd_use_reserved_id as ulong
#endif

#if __BFD_VER__ >= 217
	declare function bfd_fopen(byval filename as const zstring ptr, byval target as const zstring ptr, byval mode as const zstring ptr, byval fd as long) as bfd ptr
#endif

declare function bfd_openr(byval filename as const zstring ptr, byval target as const zstring ptr) as bfd ptr
declare function bfd_fdopenr(byval filename as const zstring ptr, byval target as const zstring ptr, byval fd as long) as bfd ptr

#if __BFD_VER__ <= 224
	declare function bfd_openstreamr(byval as const zstring ptr, byval as const zstring ptr, byval as any ptr) as bfd ptr
#endif

#if __BFD_VER__ <= 217
	declare function bfd_openr_iovec(byval filename as const zstring ptr, byval target as const zstring ptr, byval open as function(byval nbfd as bfd ptr, byval open_closure as any ptr) as any ptr, byval open_closure as any ptr, byval pread as function(byval nbfd as bfd ptr, byval stream as any ptr, byval buf as any ptr, byval nbytes as file_ptr, byval offset as file_ptr) as file_ptr, byval close as function(byval nbfd as bfd ptr, byval stream as any ptr) as long) as bfd ptr
#elseif (__BFD_VER__ >= 218) and (__BFD_VER__ <= 220)
	declare function bfd_openr_iovec(byval filename as const zstring ptr, byval target as const zstring ptr, byval open as function(byval nbfd as bfd ptr, byval open_closure as any ptr) as any ptr, byval open_closure as any ptr, byval pread as function(byval nbfd as bfd ptr, byval stream as any ptr, byval buf as any ptr, byval nbytes as file_ptr, byval offset as file_ptr) as file_ptr, byval close as function(byval nbfd as bfd ptr, byval stream as any ptr) as long, byval stat as function(byval abfd as bfd ptr, byval stream as any ptr, byval sb as stat ptr) as long) as bfd ptr
#elseif __BFD_VER__ = 225
	declare function bfd_openstreamr(byval filename as const zstring ptr, byval target as const zstring ptr, byval stream as any ptr) as bfd ptr
#endif

#if __BFD_VER__ >= 221
	declare function bfd_openr_iovec(byval filename as const zstring ptr, byval target as const zstring ptr, byval open_func as function(byval nbfd as bfd ptr, byval open_closure as any ptr) as any ptr, byval open_closure as any ptr, byval pread_func as function(byval nbfd as bfd ptr, byval stream as any ptr, byval buf as any ptr, byval nbytes as file_ptr, byval offset as file_ptr) as file_ptr, byval close_func as function(byval nbfd as bfd ptr, byval stream as any ptr) as long, byval stat_func as function(byval abfd as bfd ptr, byval stream as any ptr, byval sb as stat ptr) as long) as bfd ptr
#endif

declare function bfd_openw(byval filename as const zstring ptr, byval target as const zstring ptr) as bfd ptr
declare function bfd_close(byval abfd as bfd ptr) as bfd_boolean
declare function bfd_close_all_done(byval as bfd ptr) as bfd_boolean
declare function bfd_create(byval filename as const zstring ptr, byval templ as bfd ptr) as bfd ptr
declare function bfd_make_writable(byval abfd as bfd ptr) as bfd_boolean
declare function bfd_make_readable(byval abfd as bfd ptr) as bfd_boolean

#if __BFD_VER__ >= 221
	declare function bfd_alloc(byval abfd as bfd ptr, byval wanted as bfd_size_type) as any ptr
	declare function bfd_zalloc(byval abfd as bfd ptr, byval wanted as bfd_size_type) as any ptr
#endif

declare function bfd_calc_gnu_debuglink_crc32(byval crc as culong, byval buf as const ubyte ptr, byval len as bfd_size_type) as culong

#if __BFD_VER__ >= 224
	declare function bfd_get_debug_link_info(byval abfd as bfd ptr, byval crc32_out as culong ptr) as zstring ptr
#endif

#if __BFD_VER__ = 224
	declare function bfd_get_alt_debug_link_info(byval abfd as bfd ptr, byval crc32_out as culong ptr) as zstring ptr
#elseif __BFD_VER__ = 225
	declare function bfd_get_alt_debug_link_info(byval abfd as bfd ptr, byval buildid_len as bfd_size_type ptr, byval buildid_out as bfd_byte ptr ptr) as zstring ptr
#endif

declare function bfd_follow_gnu_debuglink(byval abfd as bfd ptr, byval dir as const zstring ptr) as zstring ptr

#if __BFD_VER__ >= 224
	declare function bfd_follow_gnu_debugaltlink(byval abfd as bfd ptr, byval dir as const zstring ptr) as zstring ptr
#endif

declare function bfd_create_gnu_debuglink_section(byval abfd as bfd ptr, byval filename as const zstring ptr) as bfd_section ptr
declare function bfd_fill_in_gnu_debuglink_section(byval abfd as bfd ptr, byval sect as bfd_section ptr, byval filename as const zstring ptr) as bfd_boolean
#define bfd_put_8(abfd, val_, ptr_) scope : (*cptr(ubyte ptr, (ptr_))) = (val_) and &hff : end scope
#define bfd_put_signed_8 bfd_put_8

#if __BFD_VER__ <= 220
	#define bfd_get_8(abfd, ptr_) ((*cptr(ubyte ptr, (ptr_))) and &hff)
	#define bfd_get_signed_8(abfd, ptr_) ((((*cptr(ubyte ptr, (ptr_))) and &hff) xor &h80) - &h80)
#else
	#define bfd_get_8(abfd, ptr_) ((*cptr(const ubyte ptr, (ptr_))) and &hff)
	#define bfd_get_signed_8(abfd, ptr_) ((((*cptr(const ubyte ptr, (ptr_))) and &hff) xor &h80) - &h80)
#endif

#define bfd_put_16(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx16, ((val), (ptr)))
#define bfd_put_signed_16 bfd_put_16
#define bfd_get_16(abfd, ptr_) BFD_SEND(abfd, bfd_getx16, (ptr_))
#define bfd_get_signed_16(abfd, ptr_) BFD_SEND(abfd, bfd_getx_signed_16, (ptr_))
#define bfd_put_32(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx32, ((val), (ptr)))
#define bfd_put_signed_32 bfd_put_32
#define bfd_get_32(abfd, ptr_) BFD_SEND(abfd, bfd_getx32, (ptr_))
#define bfd_get_signed_32(abfd, ptr_) BFD_SEND(abfd, bfd_getx_signed_32, (ptr_))
#define bfd_put_64(abfd, val_, ptr_) BFD_SEND (abfd, bfd_putx64, ((val), (ptr)))
#define bfd_put_signed_64 bfd_put_64
#define bfd_get_64(abfd, ptr_) BFD_SEND(abfd, bfd_getx64, (ptr_))
#define bfd_get_signed_64(abfd, ptr_) BFD_SEND(abfd, bfd_getx_signed_64, (ptr_))
#define bfd_get(bits, abfd, ptr_) iif((bits) = 8, cast(bfd_vma, bfd_get_8(abfd, ptr_)), iif((bits) = 16, bfd_get_16(abfd, ptr_), iif((bits) = 32, bfd_get_32(abfd, ptr_), iif((bits) = 64, bfd_get_64(abfd, ptr_), cast(bfd_vma, -1)))))
#macro bfd_put(bits, abfd, val, ptr)
	select case bits
	case 8  : bfd_put_8(abfd, val, ptr)
	case 16 : bfd_put_16(abfd, val, ptr)
	case 32 : bfd_put_32(abfd, val, ptr)
	case 64 : bfd_put_64(abfd, val, ptr)
	case else
		abort()
	end select
#endmacro
#define bfd_h_put_8(abfd, val_, ptr_) bfd_put_8(abfd, val_, ptr_)
#define bfd_h_put_signed_8(abfd, val_, ptr_) bfd_put_8(abfd, val_, ptr_)
#define bfd_h_get_8(abfd, ptr_) bfd_get_8(abfd, ptr_)
#define bfd_h_get_signed_8(abfd, ptr_) bfd_get_signed_8(abfd, ptr_)
#define bfd_h_put_16(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx16, (val, ptr))
#define bfd_h_put_signed_16 bfd_h_put_16
#define bfd_h_get_16(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx16, (ptr_))
#define bfd_h_get_signed_16(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx_signed_16, (ptr_))
#define bfd_h_put_32(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx32, (val, ptr))
#define bfd_h_put_signed_32 bfd_h_put_32
#define bfd_h_get_32(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx32, (ptr_))
#define bfd_h_get_signed_32(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx_signed_32, (ptr_))
#define bfd_h_put_64(abfd, val_, ptr_) BFD_SEND (abfd, bfd_h_putx64, (val, ptr))
#define bfd_h_put_signed_64 bfd_h_put_64
#define bfd_h_get_64(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx64, (ptr_))
#define bfd_h_get_signed_64(abfd, ptr_) BFD_SEND(abfd, bfd_h_getx_signed_64, (ptr_))
#define H_PUT_64 bfd_h_put_64
#define H_PUT_32 bfd_h_put_32
#define H_PUT_16 bfd_h_put_16
#define H_PUT_8 bfd_h_put_8
#define H_PUT_S64 bfd_h_put_signed_64
#define H_PUT_S32 bfd_h_put_signed_32
#define H_PUT_S16 bfd_h_put_signed_16
#define H_PUT_S8 bfd_h_put_signed_8
#define H_GET_64 bfd_h_get_64
#define H_GET_32 bfd_h_get_32
#define H_GET_16 bfd_h_get_16
#define H_GET_8 bfd_h_get_8
#define H_GET_S64 bfd_h_get_signed_64
#define H_GET_S32 bfd_h_get_signed_32
#define H_GET_S16 bfd_h_get_signed_16
#define H_GET_S8 bfd_h_get_signed_8
declare function bfd_get_mtime(byval abfd as bfd ptr) as clong

#if __BFD_VER__ <= 217
	declare function bfd_get_size(byval abfd as bfd ptr) as clong
#else
	declare function bfd_get_size(byval abfd as bfd ptr) as file_ptr
#endif

#if (__BFD_VER__ = 220) or (__BFD_VER__ = 221)
	declare function bfd_mmap(byval abfd as bfd ptr, byval addr as any ptr, byval len as bfd_size_type, byval prot as long, byval flags as long, byval offset as file_ptr) as any ptr
#elseif __BFD_VER__ >= 222
	declare function bfd_mmap(byval abfd as bfd ptr, byval addr as any ptr, byval len as bfd_size_type, byval prot as long, byval flags as long, byval offset as file_ptr, byval map_addr as any ptr ptr, byval map_len as bfd_size_type ptr) as any ptr
#endif

#if __BFD_VER__ >= 217
	type bfd_link_order as bfd_link_order_

	union bfd_section_map_head
		link_order as bfd_link_order ptr
		s as bfd_section ptr
	end union
#endif

#if __BFD_VER__ >= 220
	type relax_table as relax_table_
#endif

type reloc_cache_entry as reloc_cache_entry_
type relent_chain as relent_chain_

#if __BFD_VER__ = 216
	type bfd_link_order as bfd_link_order_
#elseif __BFD_VER__ = 222
	type flag_info as flag_info_
#endif

type bfd_section_
	name as const zstring ptr
	id as long
	index as long
	next as bfd_section ptr

	#if __BFD_VER__ >= 217
		prev as bfd_section ptr
	#endif

	flags as flagword
	user_set_vma : 1 as ulong
	linker_mark : 1 as ulong
	linker_has_input : 1 as ulong
	gc_mark : 1 as ulong

	#if (__BFD_VER__ = 217) or (__BFD_VER__ = 218)
		gc_mark_from_eh : 1 as ulong
	#elseif __BFD_VER__ >= 221
		compress_status : 2 as ulong
	#endif

	segment_mark : 1 as ulong
	sec_info_type : 3 as ulong
	use_rela_p : 1 as ulong

	#if __BFD_VER__ <= 220
		has_tls_reloc : 1 as ulong
	#endif

	#if __BFD_VER__ = 220
		has_tls_get_addr_call : 1 as ulong
	#endif

	#if __BFD_VER__ <= 220
		has_gp_reloc : 1 as ulong
		need_finalize_relax : 1 as ulong
		reloc_done : 1 as ulong
	#else
		sec_flg0 : 1 as ulong
		sec_flg1 : 1 as ulong
		sec_flg2 : 1 as ulong
		sec_flg3 : 1 as ulong
		sec_flg4 : 1 as ulong
		sec_flg5 : 1 as ulong
	#endif

	vma as bfd_vma
	lma as bfd_vma
	size as bfd_size_type
	rawsize as bfd_size_type

	#if __BFD_VER__ >= 221
		compressed_size as bfd_size_type
	#endif

	#if __BFD_VER__ >= 220
		relax as relax_table ptr
		relax_count as long
	#endif

	output_offset as bfd_vma
	output_section as bfd_section ptr
	alignment_power as ulong
	relocation as reloc_cache_entry ptr
	orelocation as reloc_cache_entry ptr ptr
	reloc_count as ulong
	filepos as file_ptr
	rel_filepos as file_ptr
	line_filepos as file_ptr
	userdata as any ptr
	contents as ubyte ptr
	lineno as alent ptr
	lineno_count as ulong
	entsize as ulong
	kept_section as bfd_section ptr
	moving_line_filepos as file_ptr
	target_index as long
	used_by_bfd as any ptr
	constructor_chain as relent_chain ptr
	owner as bfd ptr

	#if __BFD_VER__ = 222
		section_flag_info as flag_info ptr
	#endif

	symbol as bfd_symbol ptr
	symbol_ptr_ptr as bfd_symbol ptr ptr

	#if __BFD_VER__ = 216
		link_order_head as bfd_link_order ptr
		link_order_tail as bfd_link_order ptr
	#else
		map_head as bfd_section_map_head
		map_tail as bfd_section_map_head
	#endif
end type

type asection as bfd_section
const SEC_NO_FLAGS = &h000
const SEC_ALLOC = &h001
const SEC_LOAD = &h002
const SEC_RELOC = &h004
const SEC_READONLY = &h008
const SEC_CODE = &h010
const SEC_DATA = &h020
const SEC_ROM = &h040
const SEC_CONSTRUCTOR = &h080
const SEC_HAS_CONTENTS = &h100
const SEC_NEVER_LOAD = &h200
const SEC_THREAD_LOCAL = &h400
const SEC_HAS_GOT_REF = &h800
const SEC_IS_COMMON = &h1000
const SEC_DEBUGGING = &h2000
const SEC_IN_MEMORY = &h4000
const SEC_EXCLUDE = &h8000
const SEC_SORT_ENTRIES = &h10000
const SEC_LINK_ONCE = &h20000

#if __BFD_VER__ <= 218
	const SEC_LINK_DUPLICATES = &h40000
#else
	const SEC_LINK_DUPLICATES = &hc0000
#endif

const SEC_LINK_DUPLICATES_DISCARD = &h0

#if __BFD_VER__ <= 218
	const SEC_LINK_DUPLICATES_ONE_ONLY = &h80000
	const SEC_LINK_DUPLICATES_SAME_SIZE = &h100000
#else
	const SEC_LINK_DUPLICATES_ONE_ONLY = &h40000
	const SEC_LINK_DUPLICATES_SAME_SIZE = &h80000
#endif

const SEC_LINK_DUPLICATES_SAME_CONTENTS = SEC_LINK_DUPLICATES_ONE_ONLY or SEC_LINK_DUPLICATES_SAME_SIZE

#if __BFD_VER__ <= 218
	const SEC_LINKER_CREATED = &h200000
	const SEC_KEEP = &h400000
	const SEC_SMALL_DATA = &h800000
	const SEC_MERGE = &h1000000
	const SEC_STRINGS = &h2000000
	const SEC_GROUP = &h4000000
	const SEC_COFF_SHARED_LIBRARY = &h10000000
	const SEC_COFF_SHARED = &h20000000
	const SEC_TIC54X_BLOCK = &h40000000
	const SEC_TIC54X_CLINK = &h80000000
#else
	const SEC_LINKER_CREATED = &h100000
	const SEC_KEEP = &h200000
	const SEC_SMALL_DATA = &h400000
	const SEC_MERGE = &h800000
	const SEC_STRINGS = &h1000000
	const SEC_GROUP = &h2000000
	const SEC_COFF_SHARED_LIBRARY = &h4000000
#endif

#if __BFD_VER__ >= 222
	const SEC_ELF_REVERSE_COPY = &h4000000
#endif

#if __BFD_VER__ >= 219
	const SEC_COFF_SHARED = &h8000000
	const SEC_TIC54X_BLOCK = &h10000000
	const SEC_TIC54X_CLINK = &h20000000
#endif

#if __BFD_VER__ >= 220
	const SEC_COFF_NOREAD = &h40000000
#endif

#if __BFD_VER__ >= 221
	const COMPRESS_SECTION_NONE = 0
	const COMPRESS_SECTION_DONE = 1
	const DECOMPRESS_SECTION_SIZED = 2
#endif

#if __BFD_VER__ <= 222
	const ELF_INFO_TYPE_NONE = 0
	const ELF_INFO_TYPE_STABS = 1
	const ELF_INFO_TYPE_MERGE = 2
	const ELF_INFO_TYPE_EH_FRAME = 3
	const ELF_INFO_TYPE_JUST_SYMS = 4
#else
	const SEC_INFO_TYPE_NONE = 0
	const SEC_INFO_TYPE_STABS = 1
	const SEC_INFO_TYPE_MERGE = 2
	const SEC_INFO_TYPE_EH_FRAME = 3
	const SEC_INFO_TYPE_JUST_SYMS = 4
#endif

#if __BFD_VER__ = 225
	const SEC_INFO_TYPE_TARGET = 5
#endif

#if __BFD_VER__ >= 220
	type relax_table_
		addr as bfd_vma
		size as long
	end type
#endif

#if __BFD_VER__ = 223
	extern std_section(0 to 3) as asection
#elseif __BFD_VER__ = 225
	private function bfd_set_section_userdata(byval abfd as bfd ptr, byval ptr_ as asection ptr, byval val_ as any ptr) as bfd_boolean
		ptr_->userdata = val_
		return 1
	end function

	private function bfd_set_section_vma(byval abfd as bfd ptr, byval ptr_ as asection ptr, byval val_ as bfd_vma) as bfd_boolean
		ptr_->vma = val_
		ptr_->lma = val_
		ptr_->user_set_vma = 1
		return 1
	end function

	private function bfd_set_section_alignment(byval abfd as bfd ptr, byval ptr_ as asection ptr, byval val_ as ulong) as bfd_boolean
		ptr_->alignment_power = val_
		return 1
	end function
#endif

#if __BFD_VER__ >= 224
	extern _bfd_std_section(0 to 3) as asection
#endif

#define BFD_ABS_SECTION_NAME "*ABS*"
#define BFD_UND_SECTION_NAME "*UND*"
#define BFD_COM_SECTION_NAME "*COM*"
#define BFD_IND_SECTION_NAME "*IND*"

#if __BFD_VER__ <= 222
	extern bfd_abs_section as asection
	#define bfd_abs_section_ptr cptr(asection ptr, @bfd_abs_section)
#elseif __BFD_VER__ = 223
	#define bfd_com_section_ptr (@std_section[0])
	#define bfd_und_section_ptr (@std_section[1])
	#define bfd_abs_section_ptr (@std_section[2])
	#define bfd_ind_section_ptr (@std_section[3])
#else
	#define bfd_com_section_ptr (@_bfd_std_section[0])
	#define bfd_und_section_ptr (@_bfd_std_section[1])
	#define bfd_abs_section_ptr (@_bfd_std_section[2])
	#define bfd_ind_section_ptr (@_bfd_std_section[3])
#endif

#if __BFD_VER__ >= 223
	#define bfd_is_und_section(sec) ((sec) = bfd_und_section_ptr)
#endif

#define bfd_is_abs_section(sec) ((sec) = bfd_abs_section_ptr)

#if __BFD_VER__ <= 222
	extern bfd_und_section as asection
	#define bfd_und_section_ptr cptr(asection ptr, @bfd_und_section)
	#define bfd_is_und_section(sec) ((sec) = bfd_und_section_ptr)
	extern bfd_com_section as asection
	#define bfd_com_section_ptr cptr(asection ptr, @bfd_com_section)
	extern bfd_ind_section as asection
	#define bfd_ind_section_ptr cptr(asection ptr, @bfd_ind_section)
#endif

#define bfd_is_ind_section(sec) ((sec) = bfd_ind_section_ptr)
#define bfd_is_const_section(SEC) (((((SEC) = bfd_abs_section_ptr) orelse ((SEC) = bfd_und_section_ptr)) orelse ((SEC) = bfd_com_section_ptr)) orelse ((SEC) = bfd_ind_section_ptr))

#if __BFD_VER__ <= 217
	extern bfd_abs_symbol as const bfd_symbol const ptr
	extern bfd_com_symbol as const bfd_symbol const ptr
	extern bfd_und_symbol as const bfd_symbol const ptr
	extern bfd_ind_symbol as const bfd_symbol const ptr
#endif

#if __BFD_VER__ = 216
	#macro bfd_section_list_remove(ABFD, PS)
		scope
			dim _ps as asection ptr ptr = PS
			dim _s as asection ptr = *_ps
			(*_ps) = _s->next
			if _s->next = NULL then
				(ABFD)->section_tail = _ps
			end if
		end scope
	#endmacro
	#macro bfd_section_list_insert(ABFD, PS, S)
		scope
			dim _ps as asection ptr ptr = PS
			dim _s as asection ptr = S
			_s->next = *_ps
			(*_ps) = _s
			if _s->next = NULL then
				(ABFD)->section_tail = @_s->next
			end if
		end scope
	#endmacro
#else
	#macro bfd_section_list_remove(ABFD, S)
		scope
			dim _s as asection ptr = S
			dim _next as asection ptr = _s->next
			dim _prev as asection ptr = _s->prev
			if _prev then
				_prev->next = _next
			else
				(ABFD)->sections = _next
			end if
			if _next then
				_next->prev = _prev
			else
				(ABFD)->section_last = _prev
			end if
		end scope
	#endmacro
	#macro bfd_section_list_append(ABFD, S)
		scope
			dim _s as asection ptr = S
			dim _abfd as bfd ptr = ABFD
			_s->next = NULL
			if _abfd->section_last then
				_s->prev = _abfd->section_last
				_abfd->section_last->next = _s
			else
				_s->prev = NULL
				_abfd->sections = _s
			end if
			_abfd->section_last = _s
		end scope
	#endmacro
	#macro bfd_section_list_prepend(ABFD, S)
		scope
			dim _s as asection ptr = S
			dim _abfd as bfd ptr = ABFD
			_s->prev = NULL
			if _abfd->sections then
				_s->next = _abfd->sections
				_abfd->sections->prev = _s
			else
				_s->next = NULL
				_abfd->section_last = _s
			end if
			_abfd->sections = _s
		end scope
	#endmacro
	#macro bfd_section_list_insert_after(ABFD, A, S)
		scope
			dim _a as asection ptr = A
			dim _s as asection ptr = S
			dim _next as asection ptr = _a->next
			_s->next = _next
			_s->prev = _a
			_a->next = _s
			if _next then
				_next->prev = _s
			else
				(ABFD)->section_last = _s
			end if
		end scope
	#endmacro
	#macro bfd_section_list_insert_before(ABFD, B, S)
		scope
			dim _b as asection ptr = B
			dim _s as asection ptr = S
			dim _prev as asection ptr = _b->prev
			_s->prev = _prev
			_s->next = _b
			_b->prev = _s
			if _prev then
				_prev->next = _s
			else
				(ABFD)->sections = _s
			end if
		end scope
	#endmacro
	#define bfd_section_removed_from_list(ABFD, S) iif((S)->next = NULL, -((ABFD)->section_last <> (S)), -((S)->next->prev <> (S)))
#endif

#if __BFD_VER__ = 217
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, SYM_PTR, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), cptr(bfd_symbol ptr ptr, SYM_PTR), (NULL), (NULL))
#elseif __BFD_VER__ = 218
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#elseif __BFD_VER__ = 219
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#elseif __BFD_VER__ = 220
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#elseif __BFD_VER__ = 221
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#elseif __BFD_VER__ = 222
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, cptr(bfd_section ptr, @SEC), 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#elseif __BFD_VER__ >= 223
	#define BFD_FAKE_SECTION(SEC, FLAGS, SYM, NAME, IDX) (NAME, IDX, 0, NULL, NULL, FLAGS, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @SEC, 0, NULL, NULL, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, cptr(bfd_symbol ptr, SYM), @SEC.symbol, (NULL), (NULL))
#endif

declare sub bfd_section_list_clear(byval as bfd ptr)
declare function bfd_get_section_by_name(byval abfd as bfd ptr, byval name as const zstring ptr) as asection ptr

#if __BFD_VER__ >= 223
	declare function bfd_get_next_section_by_name(byval sec as asection ptr) as asection ptr
	declare function bfd_get_linker_section(byval abfd as bfd ptr, byval name as const zstring ptr) as asection ptr
#endif

declare function bfd_get_section_by_name_if(byval abfd as bfd ptr, byval name as const zstring ptr, byval func as function(byval abfd as bfd ptr, byval sect as asection ptr, byval obj as any ptr) as bfd_boolean, byval obj as any ptr) as asection ptr
declare function bfd_get_unique_section_name(byval abfd as bfd ptr, byval templat as const zstring ptr, byval count as long ptr) as zstring ptr
declare function bfd_make_section_old_way(byval abfd as bfd ptr, byval name as const zstring ptr) as asection ptr

#if __BFD_VER__ >= 217
	declare function bfd_make_section_anyway_with_flags(byval abfd as bfd ptr, byval name as const zstring ptr, byval flags as flagword) as asection ptr
#endif

declare function bfd_make_section_anyway(byval abfd as bfd ptr, byval name as const zstring ptr) as asection ptr

#if __BFD_VER__ >= 217
	declare function bfd_make_section_with_flags(byval as bfd ptr, byval name as const zstring ptr, byval flags as flagword) as asection ptr
#endif

declare function bfd_make_section(byval as bfd ptr, byval name as const zstring ptr) as asection ptr
declare function bfd_set_section_flags(byval abfd as bfd ptr, byval sec as asection ptr, byval flags as flagword) as bfd_boolean

#if __BFD_VER__ >= 221
	declare sub bfd_rename_section(byval abfd as bfd ptr, byval sec as asection ptr, byval newname as const zstring ptr)
#endif

declare sub bfd_map_over_sections(byval abfd as bfd ptr, byval func as sub(byval abfd as bfd ptr, byval sect as asection ptr, byval obj as any ptr), byval obj as any ptr)
declare function bfd_sections_find_if(byval abfd as bfd ptr, byval operation as function(byval abfd as bfd ptr, byval sect as asection ptr, byval obj as any ptr) as bfd_boolean, byval obj as any ptr) as asection ptr
declare function bfd_set_section_size(byval abfd as bfd ptr, byval sec as asection ptr, byval val_ as bfd_size_type) as bfd_boolean
declare function bfd_set_section_contents(byval abfd as bfd ptr, byval section as asection ptr, byval data as const any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
declare function bfd_get_section_contents(byval abfd as bfd ptr, byval section as asection ptr, byval location as any ptr, byval offset as file_ptr, byval count as bfd_size_type) as bfd_boolean
declare function bfd_malloc_and_get_section(byval abfd as bfd ptr, byval section as asection ptr, byval buf as bfd_byte ptr ptr) as bfd_boolean
declare function bfd_copy_private_section_data_ alias "bfd_copy_private_section_data"(byval ibfd as bfd ptr, byval isec as asection ptr, byval obfd as bfd ptr, byval osec as asection ptr) as bfd_boolean
#define bfd_copy_private_section_data(ibfd, isection, obfd, osection) BFD_SEND (obfd, _bfd_copy_private_section_data, (ibfd, isection, obfd, osection))

#if __BFD_VER__ = 216
	declare sub _bfd_strip_section_from_output(byval info as bfd_link_info ptr, byval section as asection ptr)
#endif

declare function bfd_generic_is_group_section(byval as bfd ptr, byval sec as const asection ptr) as bfd_boolean
declare function bfd_generic_discard_group(byval abfd as bfd ptr, byval group as asection ptr) as bfd_boolean

type bfd_architecture as long
enum
	bfd_arch_unknown
	bfd_arch_obscure
	bfd_arch_m68k
	bfd_arch_vax
	bfd_arch_i960

	#if __BFD_VER__ <= 224
		bfd_arch_or32
	#endif

	#if __BFD_VER__ = 216
		bfd_arch_a29k
	#elseif __BFD_VER__ = 225
		bfd_arch_or1k
	#endif

	bfd_arch_sparc

	#if __BFD_VER__ >= 218
		bfd_arch_spu
	#endif

	bfd_arch_mips
	bfd_arch_i386

	#if __BFD_VER__ >= 220
		bfd_arch_l1om
	#endif

	#if __BFD_VER__ >= 222
		bfd_arch_k1om
	#endif

	bfd_arch_we32k
	bfd_arch_tahoe
	bfd_arch_i860
	bfd_arch_i370
	bfd_arch_romp

	#if __BFD_VER__ = 216
		bfd_arch_alliant
	#endif

	bfd_arch_convex
	bfd_arch_m88k
	bfd_arch_m98k
	bfd_arch_pyramid
	bfd_arch_h8300
	bfd_arch_pdp11

	#if __BFD_VER__ >= 220
		bfd_arch_plugin
	#endif

	bfd_arch_powerpc
	bfd_arch_rs6000
	bfd_arch_hppa
	bfd_arch_d10v
	bfd_arch_d30v
	bfd_arch_dlx
	bfd_arch_m68hc11
	bfd_arch_m68hc12

	#if __BFD_VER__ >= 223
		bfd_arch_m9s12x
		bfd_arch_m9s12xg
	#endif

	bfd_arch_z8k
	bfd_arch_h8500
	bfd_arch_sh
	bfd_arch_alpha
	bfd_arch_arm

	#if __BFD_VER__ = 225
		bfd_arch_nds32
	#endif

	bfd_arch_ns32k
	bfd_arch_w65
	bfd_arch_tic30
	bfd_arch_tic4x
	bfd_arch_tic54x

	#if __BFD_VER__ >= 221
		bfd_arch_tic6x
	#endif

	bfd_arch_tic80
	bfd_arch_v850

	#if __BFD_VER__ >= 224
		bfd_arch_v850_rh850
	#endif

	bfd_arch_arc

	#if __BFD_VER__ >= 217
		bfd_arch_m32c
	#endif

	bfd_arch_m32r
	bfd_arch_mn10200
	bfd_arch_mn10300
	bfd_arch_fr30
	bfd_arch_frv

	#if __BFD_VER__ >= 220
		bfd_arch_moxie
	#endif

	bfd_arch_mcore

	#if __BFD_VER__ >= 218
		bfd_arch_mep
	#endif

	#if __BFD_VER__ >= 224
		bfd_arch_metag
	#endif

	bfd_arch_ia64
	bfd_arch_ip2k
	bfd_arch_iq2000

	#if __BFD_VER__ >= 223
		bfd_arch_epiphany
	#endif

	#if __BFD_VER__ >= 217
		bfd_arch_mt
	#endif

	bfd_arch_pj
	bfd_arch_avr

	#if __BFD_VER__ >= 217
		bfd_arch_bfin
	#endif

	#if __BFD_VER__ >= 218
		bfd_arch_cr16
	#endif

	bfd_arch_cr16c
	bfd_arch_crx
	bfd_arch_cris

	#if __BFD_VER__ >= 223
		bfd_arch_rl78
	#endif

	#if __BFD_VER__ >= 221
		bfd_arch_rx
	#endif

	bfd_arch_s390

	#if __BFD_VER__ >= 218
		bfd_arch_score
	#endif

	#if __BFD_VER__ <= 224
		bfd_arch_openrisc
	#endif

	bfd_arch_mmix
	bfd_arch_xstormy16
	bfd_arch_msp430

	#if __BFD_VER__ >= 217
		bfd_arch_xc16x
	#endif

	#if __BFD_VER__ >= 223
		bfd_arch_xgate
	#endif

	bfd_arch_xtensa

	#if __BFD_VER__ <= 220
		bfd_arch_maxq
	#endif

	#if __BFD_VER__ >= 217
		bfd_arch_z80
	#endif

	#if __BFD_VER__ >= 220
		bfd_arch_lm32
		bfd_arch_microblaze
	#endif

	#if __BFD_VER__ >= 222
		bfd_arch_tilepro
		bfd_arch_tilegx
	#endif

	#if __BFD_VER__ >= 223
		bfd_arch_aarch64
	#endif

	#if __BFD_VER__ >= 224
		bfd_arch_nios2
	#endif

	bfd_arch_last
end enum

const bfd_mach_m68000 = 1
const bfd_mach_m68008 = 2
const bfd_mach_m68010 = 3
const bfd_mach_m68020 = 4
const bfd_mach_m68030 = 5
const bfd_mach_m68040 = 6
const bfd_mach_m68060 = 7
const bfd_mach_cpu32 = 8

#if __BFD_VER__ = 216
	const bfd_mach_mcf5200 = 9
	const bfd_mach_mcf5206e = 10
	const bfd_mach_mcf5307 = 11
	const bfd_mach_mcf5407 = 12
	const bfd_mach_mcf528x = 13
	const bfd_mach_mcfv4e = 14
	const bfd_mach_mcf521x = 15
	const bfd_mach_mcf5249 = 16
	const bfd_mach_mcf547x = 17
	const bfd_mach_mcf548x = 18
#elseif __BFD_VER__ = 217
	const bfd_mach_mcf_isa_a_nodiv = 9
	const bfd_mach_mcf_isa_a = 10
	const bfd_mach_mcf_isa_a_mac = 11
	const bfd_mach_mcf_isa_a_emac = 12
	const bfd_mach_mcf_isa_aplus = 13
	const bfd_mach_mcf_isa_aplus_mac = 14
	const bfd_mach_mcf_isa_aplus_emac = 15
	const bfd_mach_mcf_isa_b_nousp = 16
	const bfd_mach_mcf_isa_b_nousp_mac = 17
	const bfd_mach_mcf_isa_b_nousp_emac = 18
	const bfd_mach_mcf_isa_b = 19
	const bfd_mach_mcf_isa_b_mac = 20
	const bfd_mach_mcf_isa_b_emac = 21
	const bfd_mach_mcf_isa_b_float = 22
	const bfd_mach_mcf_isa_b_float_mac = 23
	const bfd_mach_mcf_isa_b_float_emac = 24
#else
	const bfd_mach_fido = 9
	const bfd_mach_mcf_isa_a_nodiv = 10
	const bfd_mach_mcf_isa_a = 11
	const bfd_mach_mcf_isa_a_mac = 12
	const bfd_mach_mcf_isa_a_emac = 13
	const bfd_mach_mcf_isa_aplus = 14
	const bfd_mach_mcf_isa_aplus_mac = 15
	const bfd_mach_mcf_isa_aplus_emac = 16
	const bfd_mach_mcf_isa_b_nousp = 17
	const bfd_mach_mcf_isa_b_nousp_mac = 18
	const bfd_mach_mcf_isa_b_nousp_emac = 19
	const bfd_mach_mcf_isa_b = 20
	const bfd_mach_mcf_isa_b_mac = 21
	const bfd_mach_mcf_isa_b_emac = 22
	const bfd_mach_mcf_isa_b_float = 23
	const bfd_mach_mcf_isa_b_float_mac = 24
	const bfd_mach_mcf_isa_b_float_emac = 25
	const bfd_mach_mcf_isa_c = 26
	const bfd_mach_mcf_isa_c_mac = 27
	const bfd_mach_mcf_isa_c_emac = 28
#endif

#if __BFD_VER__ >= 219
	const bfd_mach_mcf_isa_c_nodiv = 29
	const bfd_mach_mcf_isa_c_nodiv_mac = 30
	const bfd_mach_mcf_isa_c_nodiv_emac = 31
#endif

const bfd_mach_i960_core = 1
const bfd_mach_i960_ka_sa = 2
const bfd_mach_i960_kb_sb = 3
const bfd_mach_i960_mc = 4
const bfd_mach_i960_xa = 5
const bfd_mach_i960_ca = 6
const bfd_mach_i960_jx = 7
const bfd_mach_i960_hx = 8

#if __BFD_VER__ = 225
	const bfd_mach_or1k = 1
	const bfd_mach_or1knd = 2
#endif

const bfd_mach_sparc = 1
const bfd_mach_sparc_sparclet = 2
const bfd_mach_sparc_sparclite = 3
const bfd_mach_sparc_v8plus = 4
const bfd_mach_sparc_v8plusa = 5
const bfd_mach_sparc_sparclite_le = 6
const bfd_mach_sparc_v9 = 7
const bfd_mach_sparc_v9a = 8
const bfd_mach_sparc_v8plusb = 9
const bfd_mach_sparc_v9b = 10
#define bfd_mach_sparc_v9_p(mach) ((((mach) >= bfd_mach_sparc_v8plus) andalso ((mach) <= bfd_mach_sparc_v9b)) andalso ((mach) <> bfd_mach_sparc_sparclite_le))
#define bfd_mach_sparc_64bit_p(mach) (((mach) >= bfd_mach_sparc_v9) andalso ((mach) <> bfd_mach_sparc_v8plusb))

#if __BFD_VER__ >= 218
	const bfd_mach_spu = 256
#endif

const bfd_mach_mips3000 = 3000
const bfd_mach_mips3900 = 3900
const bfd_mach_mips4000 = 4000
const bfd_mach_mips4010 = 4010
const bfd_mach_mips4100 = 4100
const bfd_mach_mips4111 = 4111
const bfd_mach_mips4120 = 4120
const bfd_mach_mips4300 = 4300
const bfd_mach_mips4400 = 4400
const bfd_mach_mips4600 = 4600
const bfd_mach_mips4650 = 4650
const bfd_mach_mips5000 = 5000
const bfd_mach_mips5400 = 5400
const bfd_mach_mips5500 = 5500

#if __BFD_VER__ >= 224
	const bfd_mach_mips5900 = 5900
#endif

const bfd_mach_mips6000 = 6000
const bfd_mach_mips7000 = 7000
const bfd_mach_mips8000 = 8000
const bfd_mach_mips9000 = 9000
const bfd_mach_mips10000 = 10000
const bfd_mach_mips12000 = 12000

#if __BFD_VER__ >= 220
	const bfd_mach_mips14000 = 14000
	const bfd_mach_mips16000 = 16000
#endif

const bfd_mach_mips16 = 16
const bfd_mach_mips5 = 5

#if __BFD_VER__ >= 219
	const bfd_mach_mips_loongson_2e = 3001
	const bfd_mach_mips_loongson_2f = 3002
#endif

#if __BFD_VER__ >= 222
	const bfd_mach_mips_loongson_3a = 3003
#endif

const bfd_mach_mips_sb1 = 12310201

#if __BFD_VER__ >= 219
	const bfd_mach_mips_octeon = 6501
#endif

#if __BFD_VER__ >= 223
	const bfd_mach_mips_octeonp = 6601
	const bfd_mach_mips_octeon2 = 6502
#endif

#if __BFD_VER__ >= 220
	const bfd_mach_mips_xlr = 887682
#endif

const bfd_mach_mipsisa32 = 32
const bfd_mach_mipsisa32r2 = 33

#if __BFD_VER__ = 225
	const bfd_mach_mipsisa32r3 = 34
	const bfd_mach_mipsisa32r5 = 36
	const bfd_mach_mipsisa32r6 = 37
#endif

const bfd_mach_mipsisa64 = 64
const bfd_mach_mipsisa64r2 = 65

#if __BFD_VER__ <= 221
	const bfd_mach_i386_i386 = 1
	const bfd_mach_i386_i8086 = 2
	const bfd_mach_i386_i386_intel_syntax = 3
	const bfd_mach_x86_64 = 64
	const bfd_mach_x86_64_intel_syntax = 65
#endif

#if (__BFD_VER__ = 220) or (__BFD_VER__ = 221)
	const bfd_mach_l1om = 66
	const bfd_mach_l1om_intel_syntax = 67
#elseif __BFD_VER__ = 225
	const bfd_mach_mipsisa64r3 = 66
	const bfd_mach_mipsisa64r5 = 68
	const bfd_mach_mipsisa64r6 = 69
#endif

#if __BFD_VER__ >= 222
	const bfd_mach_mips_micromips = 96
	const bfd_mach_i386_intel_syntax = 1 shl 0
	const bfd_mach_i386_i8086 = 1 shl 1
	const bfd_mach_i386_i386 = 1 shl 2
	const bfd_mach_x86_64 = 1 shl 3
	const bfd_mach_x64_32 = 1 shl 4
	const bfd_mach_i386_i386_intel_syntax = bfd_mach_i386_i386 or bfd_mach_i386_intel_syntax
	const bfd_mach_x86_64_intel_syntax = bfd_mach_x86_64 or bfd_mach_i386_intel_syntax
	const bfd_mach_x64_32_intel_syntax = bfd_mach_x64_32 or bfd_mach_i386_intel_syntax
	const bfd_mach_l1om = 1 shl 5
	const bfd_mach_l1om_intel_syntax = bfd_mach_l1om or bfd_mach_i386_intel_syntax
	const bfd_mach_k1om = 1 shl 6
	const bfd_mach_k1om_intel_syntax = bfd_mach_k1om or bfd_mach_i386_intel_syntax
#endif

#if __BFD_VER__ >= 224
	const bfd_mach_i386_nacl = 1 shl 7
	const bfd_mach_i386_i386_nacl = bfd_mach_i386_i386 or bfd_mach_i386_nacl
	const bfd_mach_x86_64_nacl = bfd_mach_x86_64 or bfd_mach_i386_nacl
	const bfd_mach_x64_32_nacl = bfd_mach_x64_32 or bfd_mach_i386_nacl
#endif

const bfd_mach_h8300 = 1
const bfd_mach_h8300h = 2
const bfd_mach_h8300s = 3
const bfd_mach_h8300hn = 4
const bfd_mach_h8300sn = 5
const bfd_mach_h8300sx = 6
const bfd_mach_h8300sxn = 7
const bfd_mach_ppc = 32
const bfd_mach_ppc64 = 64
const bfd_mach_ppc_403 = 403
const bfd_mach_ppc_403gc = 4030

#if __BFD_VER__ >= 220
	const bfd_mach_ppc_405 = 405
#endif

const bfd_mach_ppc_505 = 505
const bfd_mach_ppc_601 = 601
const bfd_mach_ppc_602 = 602
const bfd_mach_ppc_603 = 603
const bfd_mach_ppc_ec603e = 6031
const bfd_mach_ppc_604 = 604
const bfd_mach_ppc_620 = 620
const bfd_mach_ppc_630 = 630
const bfd_mach_ppc_750 = 750
const bfd_mach_ppc_860 = 860
const bfd_mach_ppc_a35 = 35
const bfd_mach_ppc_rs64ii = 642
const bfd_mach_ppc_rs64iii = 643
const bfd_mach_ppc_7400 = 7400
const bfd_mach_ppc_e500 = 500

#if __BFD_VER__ >= 219
	const bfd_mach_ppc_e500mc = 5001
#endif

#if __BFD_VER__ >= 221
	const bfd_mach_ppc_e500mc64 = 5005
#endif

#if __BFD_VER__ >= 223
	const bfd_mach_ppc_e5500 = 5006
	const bfd_mach_ppc_e6500 = 5007
#endif

#if __BFD_VER__ >= 221
	const bfd_mach_ppc_titan = 83
#endif

#if __BFD_VER__ >= 223
	const bfd_mach_ppc_vle = 84
#endif

const bfd_mach_rs6k = 6000
const bfd_mach_rs6k_rs1 = 6001
const bfd_mach_rs6k_rsc = 6003
const bfd_mach_rs6k_rs2 = 6002
const bfd_mach_hppa10 = 10
const bfd_mach_hppa11 = 11
const bfd_mach_hppa20 = 20
const bfd_mach_hppa20w = 25
const bfd_mach_d10v = 1
const bfd_mach_d10v_ts2 = 2
const bfd_mach_d10v_ts3 = 3
const bfd_mach_m6812_default = 0
const bfd_mach_m6812 = 1
const bfd_mach_m6812s = 2
const bfd_mach_z8001 = 1
const bfd_mach_z8002 = 2
const bfd_mach_sh = 1
const bfd_mach_sh2 = &h20
const bfd_mach_sh_dsp = &h2d
const bfd_mach_sh2a = &h2a
const bfd_mach_sh2a_nofpu = &h2b
const bfd_mach_sh2a_nofpu_or_sh4_nommu_nofpu = &h2a1
const bfd_mach_sh2a_nofpu_or_sh3_nommu = &h2a2
const bfd_mach_sh2a_or_sh4 = &h2a3
const bfd_mach_sh2a_or_sh3e = &h2a4
const bfd_mach_sh2e = &h2e
const bfd_mach_sh3 = &h30
const bfd_mach_sh3_nommu = &h31
const bfd_mach_sh3_dsp = &h3d
const bfd_mach_sh3e = &h3e
const bfd_mach_sh4 = &h40
const bfd_mach_sh4_nofpu = &h41
const bfd_mach_sh4_nommu_nofpu = &h42
const bfd_mach_sh4a = &h4a
const bfd_mach_sh4a_nofpu = &h4b
const bfd_mach_sh4al_dsp = &h4d
const bfd_mach_sh5 = &h50
const bfd_mach_alpha_ev4 = &h10
const bfd_mach_alpha_ev5 = &h20
const bfd_mach_alpha_ev6 = &h30
const bfd_mach_arm_unknown = 0
const bfd_mach_arm_2 = 1
const bfd_mach_arm_2a = 2
const bfd_mach_arm_3 = 3
const bfd_mach_arm_3M = 4
const bfd_mach_arm_4 = 5
const bfd_mach_arm_4T = 6
const bfd_mach_arm_5 = 7
const bfd_mach_arm_5T = 8
const bfd_mach_arm_5TE = 9
const bfd_mach_arm_XScale = 10
const bfd_mach_arm_ep9312 = 11
const bfd_mach_arm_iWMMXt = 12

#if __BFD_VER__ >= 218
	const bfd_mach_arm_iWMMXt2 = 13
#endif

#if __BFD_VER__ = 225
	const bfd_mach_n1 = 1
	const bfd_mach_n1h = 2
	const bfd_mach_n1h_v2 = 3
	const bfd_mach_n1h_v3 = 4
	const bfd_mach_n1h_v3m = 5
#endif

const bfd_mach_tic3x = 30
const bfd_mach_tic4x = 40
const bfd_mach_v850 = 1
#define bfd_mach_v850e asc("E")
#define bfd_mach_v850e1 asc("1")

#if __BFD_VER__ >= 221
	const bfd_mach_v850e2 = &h4532
	const bfd_mach_v850e2v3 = &h45325633
#endif

#if __BFD_VER__ >= 224
	const bfd_mach_v850e3v5 = &h45335635
#endif

const bfd_mach_arc_5 = 5
const bfd_mach_arc_6 = 6
const bfd_mach_arc_7 = 7
const bfd_mach_arc_8 = 8

#if __BFD_VER__ >= 217
	const bfd_mach_m16c = &h75
	const bfd_mach_m32c = &h78
#endif

const bfd_mach_m32r = 1
#define bfd_mach_m32rx asc("x")
#define bfd_mach_m32r2 asc("2")
const bfd_mach_mn10300 = 300
const bfd_mach_am33 = 330
const bfd_mach_am33_2 = 332
const bfd_mach_fr30 = &h46523330
const bfd_mach_frv = 1
const bfd_mach_frvsimple = 2
const bfd_mach_fr300 = 300
const bfd_mach_fr400 = 400
const bfd_mach_fr450 = 450
const bfd_mach_frvtomcat = 499
const bfd_mach_fr500 = 500
const bfd_mach_fr550 = 550

#if __BFD_VER__ >= 220
	const bfd_mach_moxie = 1
#endif

#if __BFD_VER__ >= 218
	const bfd_mach_mep = 1
	const bfd_mach_mep_h1 = &h6831
#endif

#if __BFD_VER__ >= 220
	const bfd_mach_mep_c5 = &h6335
#endif

#if __BFD_VER__ >= 224
	const bfd_mach_metag = 1
#endif

const bfd_mach_ia64_elf64 = 64
const bfd_mach_ia64_elf32 = 32
const bfd_mach_ip2022 = 1
const bfd_mach_ip2022ext = 2
const bfd_mach_iq2000 = 1
const bfd_mach_iq10 = 2

#if __BFD_VER__ >= 223
	const bfd_mach_epiphany16 = 1
	const bfd_mach_epiphany32 = 2
#endif

#if __BFD_VER__ >= 217
	const bfd_mach_ms1 = 1
	const bfd_mach_mrisc2 = 2
	const bfd_mach_ms2 = 3
#endif

const bfd_mach_avr1 = 1
const bfd_mach_avr2 = 2

#if __BFD_VER__ >= 219
	const bfd_mach_avr25 = 25
#endif

const bfd_mach_avr3 = 3

#if __BFD_VER__ >= 219
	const bfd_mach_avr31 = 31
	const bfd_mach_avr35 = 35
#endif

const bfd_mach_avr4 = 4
const bfd_mach_avr5 = 5

#if __BFD_VER__ >= 219
	const bfd_mach_avr51 = 51
#endif

#if __BFD_VER__ >= 218
	const bfd_mach_avr6 = 6
#endif

#if __BFD_VER__ = 225
	const bfd_mach_avrtiny = 100
#endif

#if __BFD_VER__ >= 222
	const bfd_mach_avrxmega1 = 101
	const bfd_mach_avrxmega2 = 102
	const bfd_mach_avrxmega3 = 103
	const bfd_mach_avrxmega4 = 104
	const bfd_mach_avrxmega5 = 105
	const bfd_mach_avrxmega6 = 106
	const bfd_mach_avrxmega7 = 107
#endif

#if __BFD_VER__ >= 217
	const bfd_mach_bfin = 1
#endif

#if __BFD_VER__ >= 218
	const bfd_mach_cr16 = 1
#endif

const bfd_mach_cr16c = 1
const bfd_mach_crx = 1
const bfd_mach_cris_v0_v10 = 255
const bfd_mach_cris_v32 = 32
const bfd_mach_cris_v10_v32 = 1032

#if __BFD_VER__ >= 223
	const bfd_mach_rl78 = &h75
#endif

#if __BFD_VER__ >= 221
	const bfd_mach_rx = &h75
#endif

const bfd_mach_s390_31 = 31
const bfd_mach_s390_64 = 64

#if __BFD_VER__ >= 220
	const bfd_mach_score3 = 3
	const bfd_mach_score7 = 7
#endif

const bfd_mach_xstormy16 = 1
const bfd_mach_msp11 = 11
const bfd_mach_msp110 = 110
const bfd_mach_msp12 = 12
const bfd_mach_msp13 = 13
const bfd_mach_msp14 = 14
const bfd_mach_msp15 = 15
const bfd_mach_msp16 = 16

#if __BFD_VER__ >= 224
	const bfd_mach_msp20 = 20
#endif

#if __BFD_VER__ >= 217
	const bfd_mach_msp21 = 21
#endif

#if __BFD_VER__ >= 224
	const bfd_mach_msp22 = 22
	const bfd_mach_msp23 = 23
	const bfd_mach_msp24 = 24
	const bfd_mach_msp26 = 26
#endif

const bfd_mach_msp31 = 31
const bfd_mach_msp32 = 32
const bfd_mach_msp33 = 33
const bfd_mach_msp41 = 41
const bfd_mach_msp42 = 42
const bfd_mach_msp43 = 43
const bfd_mach_msp44 = 44

#if __BFD_VER__ >= 224
	const bfd_mach_msp430x = 45
	const bfd_mach_msp46 = 46
	const bfd_mach_msp47 = 47
	const bfd_mach_msp54 = 54
#endif

#if __BFD_VER__ >= 217
	const bfd_mach_xc16x = 1
	const bfd_mach_xc16xl = 2
	const bfd_mach_xc16xs = 3
#endif

#if __BFD_VER__ >= 223
	const bfd_mach_xgate = 1
#endif

const bfd_mach_xtensa = 1

#if __BFD_VER__ <= 220
	const bfd_mach_maxq10 = 10
	const bfd_mach_maxq20 = 20
#endif

#if __BFD_VER__ >= 217
	const bfd_mach_z80strict = 1
	const bfd_mach_z80 = 3
	const bfd_mach_z80full = 7
	const bfd_mach_r800 = 11
#endif

#if __BFD_VER__ >= 220
	const bfd_mach_lm32 = 1
#endif

#if __BFD_VER__ >= 222
	const bfd_mach_tilepro = 1
	const bfd_mach_tilegx = 1
#endif

#if __BFD_VER__ >= 223
	const bfd_mach_tilegx32 = 2
	const bfd_mach_aarch64 = 0
#endif

#if __BFD_VER__ >= 224
	const bfd_mach_aarch64_ilp32 = 32
	const bfd_mach_nios2 = 0
#endif

type bfd_arch_info
	bits_per_word as long
	bits_per_address as long
	bits_per_byte as long
	arch as bfd_architecture
	mach as culong
	arch_name as const zstring ptr
	printable_name as const zstring ptr
	section_align_power as ulong
	the_default as bfd_boolean
	compatible as function(byval a as const bfd_arch_info ptr, byval b as const bfd_arch_info ptr) as const bfd_arch_info ptr
	scan as function(byval as const bfd_arch_info ptr, byval as const zstring ptr) as bfd_boolean

	#if __BFD_VER__ >= 223
		fill as function(byval count as bfd_size_type, byval is_bigendian as bfd_boolean, byval code as bfd_boolean) as any ptr
	#endif

	next as const bfd_arch_info ptr
end type

type bfd_arch_info_type as bfd_arch_info
declare function bfd_printable_name(byval abfd as bfd ptr) as const zstring ptr
declare function bfd_scan_arch(byval string as const zstring ptr) as const bfd_arch_info_type ptr
declare function bfd_arch_list() as const zstring ptr ptr
declare function bfd_arch_get_compatible(byval abfd as const bfd ptr, byval bbfd as const bfd ptr, byval accept_unknowns as bfd_boolean) as const bfd_arch_info_type ptr
declare sub bfd_set_arch_info(byval abfd as bfd ptr, byval arg as const bfd_arch_info_type ptr)
declare function bfd_get_arch(byval abfd as bfd ptr) as bfd_architecture
declare function bfd_get_mach(byval abfd as bfd ptr) as culong
declare function bfd_arch_bits_per_byte(byval abfd as bfd ptr) as ulong
declare function bfd_arch_bits_per_address(byval abfd as bfd ptr) as ulong
declare function bfd_get_arch_info(byval abfd as bfd ptr) as const bfd_arch_info_type ptr
declare function bfd_lookup_arch(byval arch as bfd_architecture, byval machine as culong) as const bfd_arch_info_type ptr
declare function bfd_printable_arch_mach(byval arch as bfd_architecture, byval machine as culong) as const zstring ptr
declare function bfd_octets_per_byte(byval abfd as bfd ptr) as ulong
declare function bfd_arch_mach_octets_per_byte(byval arch as bfd_architecture, byval machine as culong) as ulong

type bfd_reloc_status as long
enum
	bfd_reloc_ok
	bfd_reloc_overflow
	bfd_reloc_outofrange
	bfd_reloc_continue
	bfd_reloc_notsupported
	bfd_reloc_other
	bfd_reloc_undefined
	bfd_reloc_dangerous
end enum

type bfd_reloc_status_type as bfd_reloc_status

type reloc_cache_entry_
	sym_ptr_ptr as bfd_symbol ptr ptr
	address as bfd_size_type
	addend as bfd_vma
	howto as reloc_howto_type ptr
end type

type arelent as reloc_cache_entry

type complain_overflow as long
enum
	complain_overflow_dont
	complain_overflow_bitfield
	complain_overflow_signed
	complain_overflow_unsigned
end enum

type reloc_howto_struct
	as ulong type
	rightshift as ulong
	size as long
	bitsize as ulong
	pc_relative as bfd_boolean
	bitpos as ulong
	complain_on_overflow as complain_overflow
	special_function as function(byval as bfd ptr, byval as arelent ptr, byval as bfd_symbol ptr, byval as any ptr, byval as asection ptr, byval as bfd ptr, byval as zstring ptr ptr) as bfd_reloc_status_type
	name as zstring ptr
	partial_inplace as bfd_boolean
	src_mask as bfd_vma
	dst_mask as bfd_vma
	pcrel_offset as bfd_boolean
end type

#define HOWTO(C, R, S, B, P, BI, O, SF, NAME, INPLACE, MASKSRC, MASKDST, PC) (culng(C), R, S, B, P, BI, O, SF, NAME, INPLACE, MASKSRC, MASKDST, PC)
#define NEWHOWTO(FUNCTION, NAME, SIZE, REL, IN) HOWTO(0, 0, SIZE, 0, REL, 0, complain_overflow_dont, FUNCTION, NAME, FALSE, 0, 0, IN)
#define EMPTY_HOWTO(C) HOWTO((C), 0, 0, 0, FALSE, 0, complain_overflow_dont, NULL, NULL, FALSE, 0, 0, FALSE)
#macro HOWTO_PREPARE(relocation, symbol)
	if symbol <> NULL then
		if bfd_is_com_section(symbol->section) then
			relocation = 0
		else
			relocation = symbol->value
		end if
	end if
#endmacro
declare function bfd_get_reloc_size(byval as reloc_howto_type ptr) as ulong

type relent_chain_
	relent as arelent
	next as relent_chain ptr
end type

type arelent_chain as relent_chain
declare function bfd_check_overflow(byval how as complain_overflow, byval bitsize as ulong, byval rightshift as ulong, byval addrsize as ulong, byval relocation as bfd_vma) as bfd_reloc_status_type
declare function bfd_perform_relocation(byval abfd as bfd ptr, byval reloc_entry as arelent ptr, byval data as any ptr, byval input_section as asection ptr, byval output_bfd as bfd ptr, byval error_message as zstring ptr ptr) as bfd_reloc_status_type
declare function bfd_install_relocation(byval abfd as bfd ptr, byval reloc_entry as arelent ptr, byval data as any ptr, byval data_start as bfd_vma, byval input_section as asection ptr, byval error_message as zstring ptr ptr) as bfd_reloc_status_type

type bfd_reloc_code_real as long
enum
	_dummy_first_bfd_reloc_code_real
	BFD_RELOC_64
	BFD_RELOC_32
	BFD_RELOC_26
	BFD_RELOC_24
	BFD_RELOC_16
	BFD_RELOC_14
	BFD_RELOC_8
	BFD_RELOC_64_PCREL
	BFD_RELOC_32_PCREL
	BFD_RELOC_24_PCREL
	BFD_RELOC_16_PCREL
	BFD_RELOC_12_PCREL
	BFD_RELOC_8_PCREL
	BFD_RELOC_32_SECREL
	BFD_RELOC_32_GOT_PCREL
	BFD_RELOC_16_GOT_PCREL
	BFD_RELOC_8_GOT_PCREL
	BFD_RELOC_32_GOTOFF
	BFD_RELOC_16_GOTOFF
	BFD_RELOC_LO16_GOTOFF
	BFD_RELOC_HI16_GOTOFF
	BFD_RELOC_HI16_S_GOTOFF
	BFD_RELOC_8_GOTOFF
	BFD_RELOC_64_PLT_PCREL
	BFD_RELOC_32_PLT_PCREL
	BFD_RELOC_24_PLT_PCREL
	BFD_RELOC_16_PLT_PCREL
	BFD_RELOC_8_PLT_PCREL
	BFD_RELOC_64_PLTOFF
	BFD_RELOC_32_PLTOFF
	BFD_RELOC_16_PLTOFF
	BFD_RELOC_LO16_PLTOFF
	BFD_RELOC_HI16_PLTOFF
	BFD_RELOC_HI16_S_PLTOFF
	BFD_RELOC_8_PLTOFF

	#if __BFD_VER__ >= 224
		BFD_RELOC_SIZE32
		BFD_RELOC_SIZE64
	#endif

	BFD_RELOC_68K_GLOB_DAT
	BFD_RELOC_68K_JMP_SLOT
	BFD_RELOC_68K_RELATIVE

	#if __BFD_VER__ >= 220
		BFD_RELOC_68K_TLS_GD32
		BFD_RELOC_68K_TLS_GD16
		BFD_RELOC_68K_TLS_GD8
		BFD_RELOC_68K_TLS_LDM32
		BFD_RELOC_68K_TLS_LDM16
		BFD_RELOC_68K_TLS_LDM8
		BFD_RELOC_68K_TLS_LDO32
		BFD_RELOC_68K_TLS_LDO16
		BFD_RELOC_68K_TLS_LDO8
		BFD_RELOC_68K_TLS_IE32
		BFD_RELOC_68K_TLS_IE16
		BFD_RELOC_68K_TLS_IE8
		BFD_RELOC_68K_TLS_LE32
		BFD_RELOC_68K_TLS_LE16
		BFD_RELOC_68K_TLS_LE8
	#endif

	BFD_RELOC_32_BASEREL
	BFD_RELOC_16_BASEREL
	BFD_RELOC_LO16_BASEREL
	BFD_RELOC_HI16_BASEREL
	BFD_RELOC_HI16_S_BASEREL
	BFD_RELOC_8_BASEREL
	BFD_RELOC_RVA
	BFD_RELOC_8_FFnn
	BFD_RELOC_32_PCREL_S2
	BFD_RELOC_16_PCREL_S2
	BFD_RELOC_23_PCREL_S2
	BFD_RELOC_HI22
	BFD_RELOC_LO10
	BFD_RELOC_GPREL16
	BFD_RELOC_GPREL32
	BFD_RELOC_I960_CALLJ
	BFD_RELOC_NONE
	BFD_RELOC_SPARC_WDISP22
	BFD_RELOC_SPARC22
	BFD_RELOC_SPARC13
	BFD_RELOC_SPARC_GOT10
	BFD_RELOC_SPARC_GOT13
	BFD_RELOC_SPARC_GOT22
	BFD_RELOC_SPARC_PC10
	BFD_RELOC_SPARC_PC22
	BFD_RELOC_SPARC_WPLT30
	BFD_RELOC_SPARC_COPY
	BFD_RELOC_SPARC_GLOB_DAT
	BFD_RELOC_SPARC_JMP_SLOT
	BFD_RELOC_SPARC_RELATIVE
	BFD_RELOC_SPARC_UA16
	BFD_RELOC_SPARC_UA32
	BFD_RELOC_SPARC_UA64

	#if __BFD_VER__ >= 219
		BFD_RELOC_SPARC_GOTDATA_HIX22
		BFD_RELOC_SPARC_GOTDATA_LOX10
		BFD_RELOC_SPARC_GOTDATA_OP_HIX22
		BFD_RELOC_SPARC_GOTDATA_OP_LOX10
		BFD_RELOC_SPARC_GOTDATA_OP
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_SPARC_JMP_IREL
		BFD_RELOC_SPARC_IRELATIVE
	#endif

	BFD_RELOC_SPARC_BASE13
	BFD_RELOC_SPARC_BASE22
	BFD_RELOC_SPARC_10
	BFD_RELOC_SPARC_11
	BFD_RELOC_SPARC_OLO10
	BFD_RELOC_SPARC_HH22
	BFD_RELOC_SPARC_HM10
	BFD_RELOC_SPARC_LM22
	BFD_RELOC_SPARC_PC_HH22
	BFD_RELOC_SPARC_PC_HM10
	BFD_RELOC_SPARC_PC_LM22
	BFD_RELOC_SPARC_WDISP16
	BFD_RELOC_SPARC_WDISP19
	BFD_RELOC_SPARC_7
	BFD_RELOC_SPARC_6
	BFD_RELOC_SPARC_5
	BFD_RELOC_SPARC_PLT32
	BFD_RELOC_SPARC_PLT64
	BFD_RELOC_SPARC_HIX22
	BFD_RELOC_SPARC_LOX10
	BFD_RELOC_SPARC_H44
	BFD_RELOC_SPARC_M44
	BFD_RELOC_SPARC_L44
	BFD_RELOC_SPARC_REGISTER

	#if __BFD_VER__ >= 223
		BFD_RELOC_SPARC_H34
		BFD_RELOC_SPARC_SIZE32
		BFD_RELOC_SPARC_SIZE64
		BFD_RELOC_SPARC_WDISP10
	#endif

	BFD_RELOC_SPARC_REV32
	BFD_RELOC_SPARC_TLS_GD_HI22
	BFD_RELOC_SPARC_TLS_GD_LO10
	BFD_RELOC_SPARC_TLS_GD_ADD
	BFD_RELOC_SPARC_TLS_GD_CALL
	BFD_RELOC_SPARC_TLS_LDM_HI22
	BFD_RELOC_SPARC_TLS_LDM_LO10
	BFD_RELOC_SPARC_TLS_LDM_ADD
	BFD_RELOC_SPARC_TLS_LDM_CALL
	BFD_RELOC_SPARC_TLS_LDO_HIX22
	BFD_RELOC_SPARC_TLS_LDO_LOX10
	BFD_RELOC_SPARC_TLS_LDO_ADD
	BFD_RELOC_SPARC_TLS_IE_HI22
	BFD_RELOC_SPARC_TLS_IE_LO10
	BFD_RELOC_SPARC_TLS_IE_LD
	BFD_RELOC_SPARC_TLS_IE_LDX
	BFD_RELOC_SPARC_TLS_IE_ADD
	BFD_RELOC_SPARC_TLS_LE_HIX22
	BFD_RELOC_SPARC_TLS_LE_LOX10
	BFD_RELOC_SPARC_TLS_DTPMOD32
	BFD_RELOC_SPARC_TLS_DTPMOD64
	BFD_RELOC_SPARC_TLS_DTPOFF32
	BFD_RELOC_SPARC_TLS_DTPOFF64
	BFD_RELOC_SPARC_TLS_TPOFF32
	BFD_RELOC_SPARC_TLS_TPOFF64

	#if __BFD_VER__ >= 218
		BFD_RELOC_SPU_IMM7
		BFD_RELOC_SPU_IMM8
		BFD_RELOC_SPU_IMM10
		BFD_RELOC_SPU_IMM10W
		BFD_RELOC_SPU_IMM16
		BFD_RELOC_SPU_IMM16W
		BFD_RELOC_SPU_IMM18
		BFD_RELOC_SPU_PCREL9a
		BFD_RELOC_SPU_PCREL9b
		BFD_RELOC_SPU_PCREL16
		BFD_RELOC_SPU_LO16
		BFD_RELOC_SPU_HI16
		BFD_RELOC_SPU_PPU32
		BFD_RELOC_SPU_PPU64
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_SPU_ADD_PIC
	#endif

	BFD_RELOC_ALPHA_GPDISP_HI16
	BFD_RELOC_ALPHA_GPDISP_LO16
	BFD_RELOC_ALPHA_GPDISP
	BFD_RELOC_ALPHA_LITERAL
	BFD_RELOC_ALPHA_ELF_LITERAL
	BFD_RELOC_ALPHA_LITUSE
	BFD_RELOC_ALPHA_HINT
	BFD_RELOC_ALPHA_LINKAGE
	BFD_RELOC_ALPHA_CODEADDR
	BFD_RELOC_ALPHA_GPREL_HI16
	BFD_RELOC_ALPHA_GPREL_LO16
	BFD_RELOC_ALPHA_BRSGP

	#if __BFD_VER__ >= 220
		BFD_RELOC_ALPHA_NOP
		BFD_RELOC_ALPHA_BSR
		BFD_RELOC_ALPHA_LDA
		BFD_RELOC_ALPHA_BOH
	#endif

	BFD_RELOC_ALPHA_TLSGD
	BFD_RELOC_ALPHA_TLSLDM
	BFD_RELOC_ALPHA_DTPMOD64
	BFD_RELOC_ALPHA_GOTDTPREL16
	BFD_RELOC_ALPHA_DTPREL64
	BFD_RELOC_ALPHA_DTPREL_HI16
	BFD_RELOC_ALPHA_DTPREL_LO16
	BFD_RELOC_ALPHA_DTPREL16
	BFD_RELOC_ALPHA_GOTTPREL16
	BFD_RELOC_ALPHA_TPREL64
	BFD_RELOC_ALPHA_TPREL_HI16
	BFD_RELOC_ALPHA_TPREL_LO16
	BFD_RELOC_ALPHA_TPREL16
	BFD_RELOC_MIPS_JMP

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_JMP
	#endif

	BFD_RELOC_MIPS16_JMP
	BFD_RELOC_MIPS16_GPREL
	BFD_RELOC_HI16
	BFD_RELOC_HI16_S
	BFD_RELOC_LO16

	#if __BFD_VER__ >= 217
		BFD_RELOC_HI16_PCREL
		BFD_RELOC_HI16_S_PCREL
		BFD_RELOC_LO16_PCREL
	#endif

	#if __BFD_VER__ >= 219
		BFD_RELOC_MIPS16_GOT16
		BFD_RELOC_MIPS16_CALL16
	#endif

	BFD_RELOC_MIPS16_HI16
	BFD_RELOC_MIPS16_HI16_S
	BFD_RELOC_MIPS16_LO16

	#if __BFD_VER__ >= 223
		BFD_RELOC_MIPS16_TLS_GD
		BFD_RELOC_MIPS16_TLS_LDM
		BFD_RELOC_MIPS16_TLS_DTPREL_HI16
		BFD_RELOC_MIPS16_TLS_DTPREL_LO16
		BFD_RELOC_MIPS16_TLS_GOTTPREL
		BFD_RELOC_MIPS16_TLS_TPREL_HI16
		BFD_RELOC_MIPS16_TLS_TPREL_LO16
	#endif

	BFD_RELOC_MIPS_LITERAL

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_LITERAL
		BFD_RELOC_MICROMIPS_7_PCREL_S1
		BFD_RELOC_MICROMIPS_10_PCREL_S1
		BFD_RELOC_MICROMIPS_16_PCREL_S1
	#endif

	#if __BFD_VER__ = 225
		BFD_RELOC_MIPS_21_PCREL_S2
		BFD_RELOC_MIPS_26_PCREL_S2
		BFD_RELOC_MIPS_18_PCREL_S3
		BFD_RELOC_MIPS_19_PCREL_S2
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GPREL16
		BFD_RELOC_MICROMIPS_HI16
		BFD_RELOC_MICROMIPS_HI16_S
		BFD_RELOC_MICROMIPS_LO16
	#endif

	BFD_RELOC_MIPS_GOT16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT16
	#endif

	BFD_RELOC_MIPS_CALL16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_CALL16
	#endif

	BFD_RELOC_MIPS_GOT_HI16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT_HI16
	#endif

	BFD_RELOC_MIPS_GOT_LO16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT_LO16
	#endif

	BFD_RELOC_MIPS_CALL_HI16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_CALL_HI16
	#endif

	BFD_RELOC_MIPS_CALL_LO16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_CALL_LO16
	#endif

	BFD_RELOC_MIPS_SUB

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_SUB
	#endif

	BFD_RELOC_MIPS_GOT_PAGE

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT_PAGE
	#endif

	BFD_RELOC_MIPS_GOT_OFST

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT_OFST
	#endif

	BFD_RELOC_MIPS_GOT_DISP

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_GOT_DISP
	#endif

	BFD_RELOC_MIPS_SHIFT5
	BFD_RELOC_MIPS_SHIFT6
	BFD_RELOC_MIPS_INSERT_A
	BFD_RELOC_MIPS_INSERT_B
	BFD_RELOC_MIPS_DELETE
	BFD_RELOC_MIPS_HIGHEST

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_HIGHEST
	#endif

	BFD_RELOC_MIPS_HIGHER

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_HIGHER
	#endif

	BFD_RELOC_MIPS_SCN_DISP

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_SCN_DISP
	#endif

	BFD_RELOC_MIPS_REL16
	BFD_RELOC_MIPS_RELGOT
	BFD_RELOC_MIPS_JALR

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_JALR
	#endif

	BFD_RELOC_MIPS_TLS_DTPMOD32
	BFD_RELOC_MIPS_TLS_DTPREL32
	BFD_RELOC_MIPS_TLS_DTPMOD64
	BFD_RELOC_MIPS_TLS_DTPREL64
	BFD_RELOC_MIPS_TLS_GD

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_GD
	#endif

	BFD_RELOC_MIPS_TLS_LDM

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_LDM
	#endif

	BFD_RELOC_MIPS_TLS_DTPREL_HI16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_DTPREL_HI16
	#endif

	BFD_RELOC_MIPS_TLS_DTPREL_LO16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_DTPREL_LO16
	#endif

	BFD_RELOC_MIPS_TLS_GOTTPREL

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_GOTTPREL
	#endif

	BFD_RELOC_MIPS_TLS_TPREL32
	BFD_RELOC_MIPS_TLS_TPREL64
	BFD_RELOC_MIPS_TLS_TPREL_HI16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_TPREL_HI16
	#endif

	BFD_RELOC_MIPS_TLS_TPREL_LO16

	#if __BFD_VER__ >= 222
		BFD_RELOC_MICROMIPS_TLS_TPREL_LO16
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_MIPS_EH
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_MIPS_COPY
		BFD_RELOC_MIPS_JUMP_SLOT
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_MOXIE_10_PCREL
	#endif

	BFD_RELOC_FRV_LABEL16
	BFD_RELOC_FRV_LABEL24
	BFD_RELOC_FRV_LO16
	BFD_RELOC_FRV_HI16
	BFD_RELOC_FRV_GPREL12
	BFD_RELOC_FRV_GPRELU12
	BFD_RELOC_FRV_GPREL32
	BFD_RELOC_FRV_GPRELHI
	BFD_RELOC_FRV_GPRELLO
	BFD_RELOC_FRV_GOT12
	BFD_RELOC_FRV_GOTHI
	BFD_RELOC_FRV_GOTLO
	BFD_RELOC_FRV_FUNCDESC
	BFD_RELOC_FRV_FUNCDESC_GOT12
	BFD_RELOC_FRV_FUNCDESC_GOTHI
	BFD_RELOC_FRV_FUNCDESC_GOTLO
	BFD_RELOC_FRV_FUNCDESC_VALUE
	BFD_RELOC_FRV_FUNCDESC_GOTOFF12
	BFD_RELOC_FRV_FUNCDESC_GOTOFFHI
	BFD_RELOC_FRV_FUNCDESC_GOTOFFLO
	BFD_RELOC_FRV_GOTOFF12
	BFD_RELOC_FRV_GOTOFFHI
	BFD_RELOC_FRV_GOTOFFLO
	BFD_RELOC_FRV_GETTLSOFF
	BFD_RELOC_FRV_TLSDESC_VALUE
	BFD_RELOC_FRV_GOTTLSDESC12
	BFD_RELOC_FRV_GOTTLSDESCHI
	BFD_RELOC_FRV_GOTTLSDESCLO
	BFD_RELOC_FRV_TLSMOFF12
	BFD_RELOC_FRV_TLSMOFFHI
	BFD_RELOC_FRV_TLSMOFFLO
	BFD_RELOC_FRV_GOTTLSOFF12
	BFD_RELOC_FRV_GOTTLSOFFHI
	BFD_RELOC_FRV_GOTTLSOFFLO
	BFD_RELOC_FRV_TLSOFF
	BFD_RELOC_FRV_TLSDESC_RELAX
	BFD_RELOC_FRV_GETTLSOFF_RELAX
	BFD_RELOC_FRV_TLSOFF_RELAX
	BFD_RELOC_FRV_TLSMOFF
	BFD_RELOC_MN10300_GOTOFF24
	BFD_RELOC_MN10300_GOT32
	BFD_RELOC_MN10300_GOT24
	BFD_RELOC_MN10300_GOT16
	BFD_RELOC_MN10300_COPY
	BFD_RELOC_MN10300_GLOB_DAT
	BFD_RELOC_MN10300_JMP_SLOT
	BFD_RELOC_MN10300_RELATIVE

	#if __BFD_VER__ >= 219
		BFD_RELOC_MN10300_SYM_DIFF
		BFD_RELOC_MN10300_ALIGN
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_MN10300_TLS_GD
		BFD_RELOC_MN10300_TLS_LD
		BFD_RELOC_MN10300_TLS_LDO
		BFD_RELOC_MN10300_TLS_GOTIE
		BFD_RELOC_MN10300_TLS_IE
		BFD_RELOC_MN10300_TLS_LE
		BFD_RELOC_MN10300_TLS_DTPMOD
		BFD_RELOC_MN10300_TLS_DTPOFF
		BFD_RELOC_MN10300_TLS_TPOFF
		BFD_RELOC_MN10300_32_PCREL
		BFD_RELOC_MN10300_16_PCREL
	#endif

	BFD_RELOC_386_GOT32
	BFD_RELOC_386_PLT32
	BFD_RELOC_386_COPY
	BFD_RELOC_386_GLOB_DAT
	BFD_RELOC_386_JUMP_SLOT
	BFD_RELOC_386_RELATIVE
	BFD_RELOC_386_GOTOFF
	BFD_RELOC_386_GOTPC
	BFD_RELOC_386_TLS_TPOFF
	BFD_RELOC_386_TLS_IE
	BFD_RELOC_386_TLS_GOTIE
	BFD_RELOC_386_TLS_LE
	BFD_RELOC_386_TLS_GD
	BFD_RELOC_386_TLS_LDM
	BFD_RELOC_386_TLS_LDO_32
	BFD_RELOC_386_TLS_IE_32
	BFD_RELOC_386_TLS_LE_32
	BFD_RELOC_386_TLS_DTPMOD32
	BFD_RELOC_386_TLS_DTPOFF32
	BFD_RELOC_386_TLS_TPOFF32

	#if __BFD_VER__ >= 217
		BFD_RELOC_386_TLS_GOTDESC
		BFD_RELOC_386_TLS_DESC_CALL
		BFD_RELOC_386_TLS_DESC
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_386_IRELATIVE
	#endif

	BFD_RELOC_X86_64_GOT32
	BFD_RELOC_X86_64_PLT32
	BFD_RELOC_X86_64_COPY
	BFD_RELOC_X86_64_GLOB_DAT
	BFD_RELOC_X86_64_JUMP_SLOT
	BFD_RELOC_X86_64_RELATIVE
	BFD_RELOC_X86_64_GOTPCREL
	BFD_RELOC_X86_64_32S
	BFD_RELOC_X86_64_DTPMOD64
	BFD_RELOC_X86_64_DTPOFF64
	BFD_RELOC_X86_64_TPOFF64
	BFD_RELOC_X86_64_TLSGD
	BFD_RELOC_X86_64_TLSLD
	BFD_RELOC_X86_64_DTPOFF32
	BFD_RELOC_X86_64_GOTTPOFF
	BFD_RELOC_X86_64_TPOFF32

	#if __BFD_VER__ >= 217
		BFD_RELOC_X86_64_GOTOFF64
		BFD_RELOC_X86_64_GOTPC32
		BFD_RELOC_X86_64_GOT64
		BFD_RELOC_X86_64_GOTPCREL64
		BFD_RELOC_X86_64_GOTPC64
		BFD_RELOC_X86_64_GOTPLT64
		BFD_RELOC_X86_64_PLTOFF64
		BFD_RELOC_X86_64_GOTPC32_TLSDESC
		BFD_RELOC_X86_64_TLSDESC_CALL
		BFD_RELOC_X86_64_TLSDESC
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_X86_64_IRELATIVE
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_X86_64_PC32_BND
		BFD_RELOC_X86_64_PLT32_BND
	#endif

	BFD_RELOC_NS32K_IMM_8
	BFD_RELOC_NS32K_IMM_16
	BFD_RELOC_NS32K_IMM_32
	BFD_RELOC_NS32K_IMM_8_PCREL
	BFD_RELOC_NS32K_IMM_16_PCREL
	BFD_RELOC_NS32K_IMM_32_PCREL
	BFD_RELOC_NS32K_DISP_8
	BFD_RELOC_NS32K_DISP_16
	BFD_RELOC_NS32K_DISP_32
	BFD_RELOC_NS32K_DISP_8_PCREL
	BFD_RELOC_NS32K_DISP_16_PCREL
	BFD_RELOC_NS32K_DISP_32_PCREL
	BFD_RELOC_PDP11_DISP_8_PCREL
	BFD_RELOC_PDP11_DISP_6_PCREL
	BFD_RELOC_PJ_CODE_HI16
	BFD_RELOC_PJ_CODE_LO16
	BFD_RELOC_PJ_CODE_DIR16
	BFD_RELOC_PJ_CODE_DIR32
	BFD_RELOC_PJ_CODE_REL16
	BFD_RELOC_PJ_CODE_REL32
	BFD_RELOC_PPC_B26
	BFD_RELOC_PPC_BA26
	BFD_RELOC_PPC_TOC16
	BFD_RELOC_PPC_B16
	BFD_RELOC_PPC_B16_BRTAKEN
	BFD_RELOC_PPC_B16_BRNTAKEN
	BFD_RELOC_PPC_BA16
	BFD_RELOC_PPC_BA16_BRTAKEN
	BFD_RELOC_PPC_BA16_BRNTAKEN
	BFD_RELOC_PPC_COPY
	BFD_RELOC_PPC_GLOB_DAT
	BFD_RELOC_PPC_JMP_SLOT
	BFD_RELOC_PPC_RELATIVE
	BFD_RELOC_PPC_LOCAL24PC
	BFD_RELOC_PPC_EMB_NADDR32
	BFD_RELOC_PPC_EMB_NADDR16
	BFD_RELOC_PPC_EMB_NADDR16_LO
	BFD_RELOC_PPC_EMB_NADDR16_HI
	BFD_RELOC_PPC_EMB_NADDR16_HA
	BFD_RELOC_PPC_EMB_SDAI16
	BFD_RELOC_PPC_EMB_SDA2I16
	BFD_RELOC_PPC_EMB_SDA2REL
	BFD_RELOC_PPC_EMB_SDA21
	BFD_RELOC_PPC_EMB_MRKREF
	BFD_RELOC_PPC_EMB_RELSEC16
	BFD_RELOC_PPC_EMB_RELST_LO
	BFD_RELOC_PPC_EMB_RELST_HI
	BFD_RELOC_PPC_EMB_RELST_HA
	BFD_RELOC_PPC_EMB_BIT_FLD
	BFD_RELOC_PPC_EMB_RELSDA

	#if __BFD_VER__ >= 223
		BFD_RELOC_PPC_VLE_REL8
		BFD_RELOC_PPC_VLE_REL15
		BFD_RELOC_PPC_VLE_REL24
		BFD_RELOC_PPC_VLE_LO16A
		BFD_RELOC_PPC_VLE_LO16D
		BFD_RELOC_PPC_VLE_HI16A
		BFD_RELOC_PPC_VLE_HI16D
		BFD_RELOC_PPC_VLE_HA16A
		BFD_RELOC_PPC_VLE_HA16D
		BFD_RELOC_PPC_VLE_SDA21
		BFD_RELOC_PPC_VLE_SDA21_LO
		BFD_RELOC_PPC_VLE_SDAREL_LO16A
		BFD_RELOC_PPC_VLE_SDAREL_LO16D
		BFD_RELOC_PPC_VLE_SDAREL_HI16A
		BFD_RELOC_PPC_VLE_SDAREL_HI16D
		BFD_RELOC_PPC_VLE_SDAREL_HA16A
		BFD_RELOC_PPC_VLE_SDAREL_HA16D
	#endif

	BFD_RELOC_PPC64_HIGHER
	BFD_RELOC_PPC64_HIGHER_S
	BFD_RELOC_PPC64_HIGHEST
	BFD_RELOC_PPC64_HIGHEST_S
	BFD_RELOC_PPC64_TOC16_LO
	BFD_RELOC_PPC64_TOC16_HI
	BFD_RELOC_PPC64_TOC16_HA
	BFD_RELOC_PPC64_TOC
	BFD_RELOC_PPC64_PLTGOT16
	BFD_RELOC_PPC64_PLTGOT16_LO
	BFD_RELOC_PPC64_PLTGOT16_HI
	BFD_RELOC_PPC64_PLTGOT16_HA
	BFD_RELOC_PPC64_ADDR16_DS
	BFD_RELOC_PPC64_ADDR16_LO_DS
	BFD_RELOC_PPC64_GOT16_DS
	BFD_RELOC_PPC64_GOT16_LO_DS
	BFD_RELOC_PPC64_PLT16_LO_DS
	BFD_RELOC_PPC64_SECTOFF_DS
	BFD_RELOC_PPC64_SECTOFF_LO_DS
	BFD_RELOC_PPC64_TOC16_DS
	BFD_RELOC_PPC64_TOC16_LO_DS
	BFD_RELOC_PPC64_PLTGOT16_DS
	BFD_RELOC_PPC64_PLTGOT16_LO_DS

	#if __BFD_VER__ >= 224
		BFD_RELOC_PPC64_ADDR16_HIGH
		BFD_RELOC_PPC64_ADDR16_HIGHA
	#endif

	#if __BFD_VER__ = 225
		BFD_RELOC_PPC64_ADDR64_LOCAL
	#endif

	BFD_RELOC_PPC_TLS

	#if __BFD_VER__ >= 220
		BFD_RELOC_PPC_TLSGD
		BFD_RELOC_PPC_TLSLD
	#endif

	BFD_RELOC_PPC_DTPMOD
	BFD_RELOC_PPC_TPREL16
	BFD_RELOC_PPC_TPREL16_LO
	BFD_RELOC_PPC_TPREL16_HI
	BFD_RELOC_PPC_TPREL16_HA
	BFD_RELOC_PPC_TPREL
	BFD_RELOC_PPC_DTPREL16
	BFD_RELOC_PPC_DTPREL16_LO
	BFD_RELOC_PPC_DTPREL16_HI
	BFD_RELOC_PPC_DTPREL16_HA
	BFD_RELOC_PPC_DTPREL
	BFD_RELOC_PPC_GOT_TLSGD16
	BFD_RELOC_PPC_GOT_TLSGD16_LO
	BFD_RELOC_PPC_GOT_TLSGD16_HI
	BFD_RELOC_PPC_GOT_TLSGD16_HA
	BFD_RELOC_PPC_GOT_TLSLD16
	BFD_RELOC_PPC_GOT_TLSLD16_LO
	BFD_RELOC_PPC_GOT_TLSLD16_HI
	BFD_RELOC_PPC_GOT_TLSLD16_HA
	BFD_RELOC_PPC_GOT_TPREL16
	BFD_RELOC_PPC_GOT_TPREL16_LO
	BFD_RELOC_PPC_GOT_TPREL16_HI
	BFD_RELOC_PPC_GOT_TPREL16_HA
	BFD_RELOC_PPC_GOT_DTPREL16
	BFD_RELOC_PPC_GOT_DTPREL16_LO
	BFD_RELOC_PPC_GOT_DTPREL16_HI
	BFD_RELOC_PPC_GOT_DTPREL16_HA
	BFD_RELOC_PPC64_TPREL16_DS
	BFD_RELOC_PPC64_TPREL16_LO_DS
	BFD_RELOC_PPC64_TPREL16_HIGHER
	BFD_RELOC_PPC64_TPREL16_HIGHERA
	BFD_RELOC_PPC64_TPREL16_HIGHEST
	BFD_RELOC_PPC64_TPREL16_HIGHESTA
	BFD_RELOC_PPC64_DTPREL16_DS
	BFD_RELOC_PPC64_DTPREL16_LO_DS
	BFD_RELOC_PPC64_DTPREL16_HIGHER
	BFD_RELOC_PPC64_DTPREL16_HIGHERA
	BFD_RELOC_PPC64_DTPREL16_HIGHEST
	BFD_RELOC_PPC64_DTPREL16_HIGHESTA

	#if __BFD_VER__ >= 224
		BFD_RELOC_PPC64_TPREL16_HIGH
		BFD_RELOC_PPC64_TPREL16_HIGHA
		BFD_RELOC_PPC64_DTPREL16_HIGH
		BFD_RELOC_PPC64_DTPREL16_HIGHA
	#endif

	BFD_RELOC_I370_D12
	BFD_RELOC_CTOR
	BFD_RELOC_ARM_PCREL_BRANCH
	BFD_RELOC_ARM_PCREL_BLX
	BFD_RELOC_THUMB_PCREL_BLX

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_PCREL_CALL
		BFD_RELOC_ARM_PCREL_JUMP
		BFD_RELOC_THUMB_PCREL_BRANCH7
		BFD_RELOC_THUMB_PCREL_BRANCH9
		BFD_RELOC_THUMB_PCREL_BRANCH12
		BFD_RELOC_THUMB_PCREL_BRANCH20
		BFD_RELOC_THUMB_PCREL_BRANCH23
		BFD_RELOC_THUMB_PCREL_BRANCH25
		BFD_RELOC_ARM_OFFSET_IMM
		BFD_RELOC_ARM_THUMB_OFFSET
		BFD_RELOC_ARM_TARGET1
		BFD_RELOC_ARM_ROSEGREL32
		BFD_RELOC_ARM_SBREL32
		BFD_RELOC_ARM_TARGET2
		BFD_RELOC_ARM_PREL31
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_ARM_MOVW
		BFD_RELOC_ARM_MOVT
		BFD_RELOC_ARM_MOVW_PCREL
		BFD_RELOC_ARM_MOVT_PCREL
		BFD_RELOC_ARM_THUMB_MOVW
		BFD_RELOC_ARM_THUMB_MOVT
		BFD_RELOC_ARM_THUMB_MOVW_PCREL
		BFD_RELOC_ARM_THUMB_MOVT_PCREL
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_JUMP_SLOT
		BFD_RELOC_ARM_GLOB_DAT
		BFD_RELOC_ARM_GOT32
		BFD_RELOC_ARM_PLT32
		BFD_RELOC_ARM_RELATIVE
		BFD_RELOC_ARM_GOTOFF
		BFD_RELOC_ARM_GOTPC
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_ARM_GOT_PREL
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_TLS_GD32
		BFD_RELOC_ARM_TLS_LDO32
		BFD_RELOC_ARM_TLS_LDM32
		BFD_RELOC_ARM_TLS_DTPOFF32
		BFD_RELOC_ARM_TLS_DTPMOD32
		BFD_RELOC_ARM_TLS_TPOFF32
		BFD_RELOC_ARM_TLS_IE32
		BFD_RELOC_ARM_TLS_LE32
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_ARM_TLS_GOTDESC
		BFD_RELOC_ARM_TLS_CALL
		BFD_RELOC_ARM_THM_TLS_CALL
		BFD_RELOC_ARM_TLS_DESCSEQ
		BFD_RELOC_ARM_THM_TLS_DESCSEQ
		BFD_RELOC_ARM_TLS_DESC
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_ARM_ALU_PC_G0_NC
		BFD_RELOC_ARM_ALU_PC_G0
		BFD_RELOC_ARM_ALU_PC_G1_NC
		BFD_RELOC_ARM_ALU_PC_G1
		BFD_RELOC_ARM_ALU_PC_G2
		BFD_RELOC_ARM_LDR_PC_G0
		BFD_RELOC_ARM_LDR_PC_G1
		BFD_RELOC_ARM_LDR_PC_G2
		BFD_RELOC_ARM_LDRS_PC_G0
		BFD_RELOC_ARM_LDRS_PC_G1
		BFD_RELOC_ARM_LDRS_PC_G2
		BFD_RELOC_ARM_LDC_PC_G0
		BFD_RELOC_ARM_LDC_PC_G1
		BFD_RELOC_ARM_LDC_PC_G2
		BFD_RELOC_ARM_ALU_SB_G0_NC
		BFD_RELOC_ARM_ALU_SB_G0
		BFD_RELOC_ARM_ALU_SB_G1_NC
		BFD_RELOC_ARM_ALU_SB_G1
		BFD_RELOC_ARM_ALU_SB_G2
		BFD_RELOC_ARM_LDR_SB_G0
		BFD_RELOC_ARM_LDR_SB_G1
		BFD_RELOC_ARM_LDR_SB_G2
		BFD_RELOC_ARM_LDRS_SB_G0
		BFD_RELOC_ARM_LDRS_SB_G1
		BFD_RELOC_ARM_LDRS_SB_G2
		BFD_RELOC_ARM_LDC_SB_G0
		BFD_RELOC_ARM_LDC_SB_G1
		BFD_RELOC_ARM_LDC_SB_G2
	#endif

	#if __BFD_VER__ >= 219
		BFD_RELOC_ARM_V4BX
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_ARM_IRELATIVE
	#endif

	BFD_RELOC_ARM_IMMEDIATE
	BFD_RELOC_ARM_ADRL_IMMEDIATE

	#if __BFD_VER__ = 216
		BFD_RELOC_ARM_OFFSET_IMM
	#else
		BFD_RELOC_ARM_T32_IMMEDIATE
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_ARM_T32_ADD_IMM
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_T32_IMM12
		BFD_RELOC_ARM_T32_ADD_PC12
	#endif

	BFD_RELOC_ARM_SHIFT_IMM

	#if __BFD_VER__ = 216
		BFD_RELOC_ARM_SMI
	#else
		BFD_RELOC_ARM_SMC
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_ARM_HVC
	#endif

	BFD_RELOC_ARM_SWI
	BFD_RELOC_ARM_MULTI
	BFD_RELOC_ARM_CP_OFF_IMM
	BFD_RELOC_ARM_CP_OFF_IMM_S2

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_T32_CP_OFF_IMM
		BFD_RELOC_ARM_T32_CP_OFF_IMM_S2
	#endif

	BFD_RELOC_ARM_ADR_IMM
	BFD_RELOC_ARM_LDR_IMM
	BFD_RELOC_ARM_LITERAL
	BFD_RELOC_ARM_IN_POOL
	BFD_RELOC_ARM_OFFSET_IMM8

	#if __BFD_VER__ >= 217
		BFD_RELOC_ARM_T32_OFFSET_U8
		BFD_RELOC_ARM_T32_OFFSET_IMM
	#endif

	BFD_RELOC_ARM_HWLITERAL
	BFD_RELOC_ARM_THUMB_ADD
	BFD_RELOC_ARM_THUMB_IMM
	BFD_RELOC_ARM_THUMB_SHIFT

	#if __BFD_VER__ = 216
		BFD_RELOC_ARM_THUMB_OFFSET
		BFD_RELOC_ARM_GOT12
		BFD_RELOC_ARM_GOT32
		BFD_RELOC_ARM_JUMP_SLOT
		BFD_RELOC_ARM_COPY
		BFD_RELOC_ARM_GLOB_DAT
		BFD_RELOC_ARM_PLT32
		BFD_RELOC_ARM_RELATIVE
		BFD_RELOC_ARM_GOTOFF
		BFD_RELOC_ARM_GOTPC
		BFD_RELOC_ARM_TARGET1
		BFD_RELOC_ARM_ROSEGREL32
		BFD_RELOC_ARM_SBREL32
		BFD_RELOC_ARM_TARGET2
		BFD_RELOC_ARM_PREL31
	#endif

	BFD_RELOC_SH_PCDISP8BY2
	BFD_RELOC_SH_PCDISP12BY2
	BFD_RELOC_SH_IMM3
	BFD_RELOC_SH_IMM3U
	BFD_RELOC_SH_DISP12
	BFD_RELOC_SH_DISP12BY2
	BFD_RELOC_SH_DISP12BY4
	BFD_RELOC_SH_DISP12BY8
	BFD_RELOC_SH_DISP20
	BFD_RELOC_SH_DISP20BY8
	BFD_RELOC_SH_IMM4
	BFD_RELOC_SH_IMM4BY2
	BFD_RELOC_SH_IMM4BY4
	BFD_RELOC_SH_IMM8
	BFD_RELOC_SH_IMM8BY2
	BFD_RELOC_SH_IMM8BY4
	BFD_RELOC_SH_PCRELIMM8BY2
	BFD_RELOC_SH_PCRELIMM8BY4
	BFD_RELOC_SH_SWITCH16
	BFD_RELOC_SH_SWITCH32
	BFD_RELOC_SH_USES
	BFD_RELOC_SH_COUNT
	BFD_RELOC_SH_ALIGN
	BFD_RELOC_SH_CODE
	BFD_RELOC_SH_DATA
	BFD_RELOC_SH_LABEL
	BFD_RELOC_SH_LOOP_START
	BFD_RELOC_SH_LOOP_END
	BFD_RELOC_SH_COPY
	BFD_RELOC_SH_GLOB_DAT
	BFD_RELOC_SH_JMP_SLOT
	BFD_RELOC_SH_RELATIVE
	BFD_RELOC_SH_GOTPC
	BFD_RELOC_SH_GOT_LOW16
	BFD_RELOC_SH_GOT_MEDLOW16
	BFD_RELOC_SH_GOT_MEDHI16
	BFD_RELOC_SH_GOT_HI16
	BFD_RELOC_SH_GOTPLT_LOW16
	BFD_RELOC_SH_GOTPLT_MEDLOW16
	BFD_RELOC_SH_GOTPLT_MEDHI16
	BFD_RELOC_SH_GOTPLT_HI16
	BFD_RELOC_SH_PLT_LOW16
	BFD_RELOC_SH_PLT_MEDLOW16
	BFD_RELOC_SH_PLT_MEDHI16
	BFD_RELOC_SH_PLT_HI16
	BFD_RELOC_SH_GOTOFF_LOW16
	BFD_RELOC_SH_GOTOFF_MEDLOW16
	BFD_RELOC_SH_GOTOFF_MEDHI16
	BFD_RELOC_SH_GOTOFF_HI16
	BFD_RELOC_SH_GOTPC_LOW16
	BFD_RELOC_SH_GOTPC_MEDLOW16
	BFD_RELOC_SH_GOTPC_MEDHI16
	BFD_RELOC_SH_GOTPC_HI16
	BFD_RELOC_SH_COPY64
	BFD_RELOC_SH_GLOB_DAT64
	BFD_RELOC_SH_JMP_SLOT64
	BFD_RELOC_SH_RELATIVE64
	BFD_RELOC_SH_GOT10BY4
	BFD_RELOC_SH_GOT10BY8
	BFD_RELOC_SH_GOTPLT10BY4
	BFD_RELOC_SH_GOTPLT10BY8
	BFD_RELOC_SH_GOTPLT32
	BFD_RELOC_SH_SHMEDIA_CODE
	BFD_RELOC_SH_IMMU5
	BFD_RELOC_SH_IMMS6
	BFD_RELOC_SH_IMMS6BY32
	BFD_RELOC_SH_IMMU6
	BFD_RELOC_SH_IMMS10
	BFD_RELOC_SH_IMMS10BY2
	BFD_RELOC_SH_IMMS10BY4
	BFD_RELOC_SH_IMMS10BY8
	BFD_RELOC_SH_IMMS16
	BFD_RELOC_SH_IMMU16
	BFD_RELOC_SH_IMM_LOW16
	BFD_RELOC_SH_IMM_LOW16_PCREL
	BFD_RELOC_SH_IMM_MEDLOW16
	BFD_RELOC_SH_IMM_MEDLOW16_PCREL
	BFD_RELOC_SH_IMM_MEDHI16
	BFD_RELOC_SH_IMM_MEDHI16_PCREL
	BFD_RELOC_SH_IMM_HI16
	BFD_RELOC_SH_IMM_HI16_PCREL
	BFD_RELOC_SH_PT_16
	BFD_RELOC_SH_TLS_GD_32
	BFD_RELOC_SH_TLS_LD_32
	BFD_RELOC_SH_TLS_LDO_32
	BFD_RELOC_SH_TLS_IE_32
	BFD_RELOC_SH_TLS_LE_32
	BFD_RELOC_SH_TLS_DTPMOD32
	BFD_RELOC_SH_TLS_DTPOFF32
	BFD_RELOC_SH_TLS_TPOFF32

	#if __BFD_VER__ = 216
		BFD_RELOC_THUMB_PCREL_BRANCH9
		BFD_RELOC_THUMB_PCREL_BRANCH12
		BFD_RELOC_THUMB_PCREL_BRANCH23
	#elseif __BFD_VER__ >= 221
		BFD_RELOC_SH_GOT20
		BFD_RELOC_SH_GOTOFF20
		BFD_RELOC_SH_GOTFUNCDESC
		BFD_RELOC_SH_GOTFUNCDESC20
		BFD_RELOC_SH_GOTOFFFUNCDESC
		BFD_RELOC_SH_GOTOFFFUNCDESC20
		BFD_RELOC_SH_FUNCDESC
	#endif

	BFD_RELOC_ARC_B22_PCREL
	BFD_RELOC_ARC_B26

	#if __BFD_VER__ >= 217
		BFD_RELOC_BFIN_16_IMM
		BFD_RELOC_BFIN_16_HIGH
		BFD_RELOC_BFIN_4_PCREL
		BFD_RELOC_BFIN_5_PCREL
		BFD_RELOC_BFIN_16_LOW
		BFD_RELOC_BFIN_10_PCREL
		BFD_RELOC_BFIN_11_PCREL
		BFD_RELOC_BFIN_12_PCREL_JUMP
		BFD_RELOC_BFIN_12_PCREL_JUMP_S
		BFD_RELOC_BFIN_24_PCREL_CALL_X
		BFD_RELOC_BFIN_24_PCREL_JUMP_L
		BFD_RELOC_BFIN_GOT17M4
		BFD_RELOC_BFIN_GOTHI
		BFD_RELOC_BFIN_GOTLO
		BFD_RELOC_BFIN_FUNCDESC
		BFD_RELOC_BFIN_FUNCDESC_GOT17M4
		BFD_RELOC_BFIN_FUNCDESC_GOTHI
		BFD_RELOC_BFIN_FUNCDESC_GOTLO
		BFD_RELOC_BFIN_FUNCDESC_VALUE
		BFD_RELOC_BFIN_FUNCDESC_GOTOFF17M4
		BFD_RELOC_BFIN_FUNCDESC_GOTOFFHI
		BFD_RELOC_BFIN_FUNCDESC_GOTOFFLO
		BFD_RELOC_BFIN_GOTOFF17M4
		BFD_RELOC_BFIN_GOTOFFHI
		BFD_RELOC_BFIN_GOTOFFLO
		BFD_RELOC_BFIN_GOT
		BFD_RELOC_BFIN_PLTPC
		BFD_ARELOC_BFIN_PUSH
		BFD_ARELOC_BFIN_CONST
		BFD_ARELOC_BFIN_ADD
		BFD_ARELOC_BFIN_SUB
		BFD_ARELOC_BFIN_MULT
		BFD_ARELOC_BFIN_DIV
		BFD_ARELOC_BFIN_MOD
		BFD_ARELOC_BFIN_LSHIFT
		BFD_ARELOC_BFIN_RSHIFT
		BFD_ARELOC_BFIN_AND
		BFD_ARELOC_BFIN_OR
		BFD_ARELOC_BFIN_XOR
		BFD_ARELOC_BFIN_LAND
		BFD_ARELOC_BFIN_LOR
		BFD_ARELOC_BFIN_LEN
		BFD_ARELOC_BFIN_NEG
		BFD_ARELOC_BFIN_COMP
		BFD_ARELOC_BFIN_PAGE
		BFD_ARELOC_BFIN_HWPAGE
		BFD_ARELOC_BFIN_ADDR
	#endif

	BFD_RELOC_D10V_10_PCREL_R
	BFD_RELOC_D10V_10_PCREL_L
	BFD_RELOC_D10V_18
	BFD_RELOC_D10V_18_PCREL
	BFD_RELOC_D30V_6
	BFD_RELOC_D30V_9_PCREL
	BFD_RELOC_D30V_9_PCREL_R
	BFD_RELOC_D30V_15
	BFD_RELOC_D30V_15_PCREL
	BFD_RELOC_D30V_15_PCREL_R
	BFD_RELOC_D30V_21
	BFD_RELOC_D30V_21_PCREL
	BFD_RELOC_D30V_21_PCREL_R
	BFD_RELOC_D30V_32
	BFD_RELOC_D30V_32_PCREL
	BFD_RELOC_DLX_HI16_S
	BFD_RELOC_DLX_LO16
	BFD_RELOC_DLX_JMP26

	#if __BFD_VER__ >= 217
		BFD_RELOC_M32C_HI8
		BFD_RELOC_M32C_RL_JUMP
		BFD_RELOC_M32C_RL_1ADDR
		BFD_RELOC_M32C_RL_2ADDR
	#endif

	BFD_RELOC_M32R_24
	BFD_RELOC_M32R_10_PCREL
	BFD_RELOC_M32R_18_PCREL
	BFD_RELOC_M32R_26_PCREL
	BFD_RELOC_M32R_HI16_ULO
	BFD_RELOC_M32R_HI16_SLO
	BFD_RELOC_M32R_LO16
	BFD_RELOC_M32R_SDA16
	BFD_RELOC_M32R_GOT24
	BFD_RELOC_M32R_26_PLTREL
	BFD_RELOC_M32R_COPY
	BFD_RELOC_M32R_GLOB_DAT
	BFD_RELOC_M32R_JMP_SLOT
	BFD_RELOC_M32R_RELATIVE
	BFD_RELOC_M32R_GOTOFF
	BFD_RELOC_M32R_GOTOFF_HI_ULO
	BFD_RELOC_M32R_GOTOFF_HI_SLO
	BFD_RELOC_M32R_GOTOFF_LO
	BFD_RELOC_M32R_GOTPC24
	BFD_RELOC_M32R_GOT16_HI_ULO
	BFD_RELOC_M32R_GOT16_HI_SLO
	BFD_RELOC_M32R_GOT16_LO
	BFD_RELOC_M32R_GOTPC_HI_ULO
	BFD_RELOC_M32R_GOTPC_HI_SLO
	BFD_RELOC_M32R_GOTPC_LO

	#if __BFD_VER__ = 225
		BFD_RELOC_NDS32_20
		BFD_RELOC_NDS32_9_PCREL
		BFD_RELOC_NDS32_WORD_9_PCREL
		BFD_RELOC_NDS32_15_PCREL
		BFD_RELOC_NDS32_17_PCREL
		BFD_RELOC_NDS32_25_PCREL
		BFD_RELOC_NDS32_HI20
		BFD_RELOC_NDS32_LO12S3
		BFD_RELOC_NDS32_LO12S2
		BFD_RELOC_NDS32_LO12S1
		BFD_RELOC_NDS32_LO12S0
		BFD_RELOC_NDS32_LO12S0_ORI
		BFD_RELOC_NDS32_SDA15S3
		BFD_RELOC_NDS32_SDA15S2
		BFD_RELOC_NDS32_SDA15S1
		BFD_RELOC_NDS32_SDA15S0
		BFD_RELOC_NDS32_SDA16S3
		BFD_RELOC_NDS32_SDA17S2
		BFD_RELOC_NDS32_SDA18S1
		BFD_RELOC_NDS32_SDA19S0
		BFD_RELOC_NDS32_GOT20
		BFD_RELOC_NDS32_9_PLTREL
		BFD_RELOC_NDS32_25_PLTREL
		BFD_RELOC_NDS32_COPY
		BFD_RELOC_NDS32_GLOB_DAT
		BFD_RELOC_NDS32_JMP_SLOT
		BFD_RELOC_NDS32_RELATIVE
		BFD_RELOC_NDS32_GOTOFF
		BFD_RELOC_NDS32_GOTOFF_HI20
		BFD_RELOC_NDS32_GOTOFF_LO12
		BFD_RELOC_NDS32_GOTPC20
		BFD_RELOC_NDS32_GOT_HI20
		BFD_RELOC_NDS32_GOT_LO12
		BFD_RELOC_NDS32_GOTPC_HI20
		BFD_RELOC_NDS32_GOTPC_LO12
		BFD_RELOC_NDS32_INSN16
		BFD_RELOC_NDS32_LABEL
		BFD_RELOC_NDS32_LONGCALL1
		BFD_RELOC_NDS32_LONGCALL2
		BFD_RELOC_NDS32_LONGCALL3
		BFD_RELOC_NDS32_LONGJUMP1
		BFD_RELOC_NDS32_LONGJUMP2
		BFD_RELOC_NDS32_LONGJUMP3
		BFD_RELOC_NDS32_LOADSTORE
		BFD_RELOC_NDS32_9_FIXED
		BFD_RELOC_NDS32_15_FIXED
		BFD_RELOC_NDS32_17_FIXED
		BFD_RELOC_NDS32_25_FIXED
		BFD_RELOC_NDS32_LONGCALL4
		BFD_RELOC_NDS32_LONGCALL5
		BFD_RELOC_NDS32_LONGCALL6
		BFD_RELOC_NDS32_LONGJUMP4
		BFD_RELOC_NDS32_LONGJUMP5
		BFD_RELOC_NDS32_LONGJUMP6
		BFD_RELOC_NDS32_LONGJUMP7
		BFD_RELOC_NDS32_PLTREL_HI20
		BFD_RELOC_NDS32_PLTREL_LO12
		BFD_RELOC_NDS32_PLT_GOTREL_HI20
		BFD_RELOC_NDS32_PLT_GOTREL_LO12
		BFD_RELOC_NDS32_SDA12S2_DP
		BFD_RELOC_NDS32_SDA12S2_SP
		BFD_RELOC_NDS32_LO12S2_DP
		BFD_RELOC_NDS32_LO12S2_SP
		BFD_RELOC_NDS32_DWARF2_OP1
		BFD_RELOC_NDS32_DWARF2_OP2
		BFD_RELOC_NDS32_DWARF2_LEB
		BFD_RELOC_NDS32_UPDATE_TA
		BFD_RELOC_NDS32_PLT_GOTREL_LO20
		BFD_RELOC_NDS32_PLT_GOTREL_LO15
		BFD_RELOC_NDS32_PLT_GOTREL_LO19
		BFD_RELOC_NDS32_GOT_LO15
		BFD_RELOC_NDS32_GOT_LO19
		BFD_RELOC_NDS32_GOTOFF_LO15
		BFD_RELOC_NDS32_GOTOFF_LO19
		BFD_RELOC_NDS32_GOT15S2
		BFD_RELOC_NDS32_GOT17S2
		BFD_RELOC_NDS32_5
		BFD_RELOC_NDS32_10_UPCREL
		BFD_RELOC_NDS32_SDA_FP7U2_RELA
		BFD_RELOC_NDS32_RELAX_ENTRY
		BFD_RELOC_NDS32_GOT_SUFF
		BFD_RELOC_NDS32_GOTOFF_SUFF
		BFD_RELOC_NDS32_PLT_GOT_SUFF
		BFD_RELOC_NDS32_MULCALL_SUFF
		BFD_RELOC_NDS32_PTR
		BFD_RELOC_NDS32_PTR_COUNT
		BFD_RELOC_NDS32_PTR_RESOLVED
		BFD_RELOC_NDS32_PLTBLOCK
		BFD_RELOC_NDS32_RELAX_REGION_BEGIN
		BFD_RELOC_NDS32_RELAX_REGION_END
		BFD_RELOC_NDS32_MINUEND
		BFD_RELOC_NDS32_SUBTRAHEND
		BFD_RELOC_NDS32_DIFF8
		BFD_RELOC_NDS32_DIFF16
		BFD_RELOC_NDS32_DIFF32
		BFD_RELOC_NDS32_DIFF_ULEB128
		BFD_RELOC_NDS32_EMPTY
		BFD_RELOC_NDS32_25_ABS
		BFD_RELOC_NDS32_DATA
		BFD_RELOC_NDS32_TRAN
		BFD_RELOC_NDS32_17IFC_PCREL
		BFD_RELOC_NDS32_10IFCU_PCREL
		BFD_RELOC_NDS32_TPOFF
		BFD_RELOC_NDS32_TLS_LE_HI20
		BFD_RELOC_NDS32_TLS_LE_LO12
		BFD_RELOC_NDS32_TLS_LE_ADD
		BFD_RELOC_NDS32_TLS_LE_LS
		BFD_RELOC_NDS32_GOTTPOFF
		BFD_RELOC_NDS32_TLS_IE_HI20
		BFD_RELOC_NDS32_TLS_IE_LO12S2
		BFD_RELOC_NDS32_TLS_TPOFF
		BFD_RELOC_NDS32_TLS_LE_20
		BFD_RELOC_NDS32_TLS_LE_15S0
		BFD_RELOC_NDS32_TLS_LE_15S1
		BFD_RELOC_NDS32_TLS_LE_15S2
	#endif

	BFD_RELOC_V850_9_PCREL
	BFD_RELOC_V850_22_PCREL
	BFD_RELOC_V850_SDA_16_16_OFFSET
	BFD_RELOC_V850_SDA_15_16_OFFSET
	BFD_RELOC_V850_ZDA_16_16_OFFSET
	BFD_RELOC_V850_ZDA_15_16_OFFSET
	BFD_RELOC_V850_TDA_6_8_OFFSET
	BFD_RELOC_V850_TDA_7_8_OFFSET
	BFD_RELOC_V850_TDA_7_7_OFFSET
	BFD_RELOC_V850_TDA_16_16_OFFSET
	BFD_RELOC_V850_TDA_4_5_OFFSET
	BFD_RELOC_V850_TDA_4_4_OFFSET
	BFD_RELOC_V850_SDA_16_16_SPLIT_OFFSET
	BFD_RELOC_V850_ZDA_16_16_SPLIT_OFFSET
	BFD_RELOC_V850_CALLT_6_7_OFFSET
	BFD_RELOC_V850_CALLT_16_16_OFFSET
	BFD_RELOC_V850_LONGCALL
	BFD_RELOC_V850_LONGJUMP
	BFD_RELOC_V850_ALIGN
	BFD_RELOC_V850_LO16_SPLIT_OFFSET

	#if __BFD_VER__ >= 221
		BFD_RELOC_V850_16_PCREL
		BFD_RELOC_V850_17_PCREL
		BFD_RELOC_V850_23
		BFD_RELOC_V850_32_PCREL
		BFD_RELOC_V850_32_ABS
		BFD_RELOC_V850_16_SPLIT_OFFSET
		BFD_RELOC_V850_16_S1
		BFD_RELOC_V850_LO16_S1
		BFD_RELOC_V850_CALLT_15_16_OFFSET
		BFD_RELOC_V850_32_GOTPCREL
		BFD_RELOC_V850_16_GOT
		BFD_RELOC_V850_32_GOT
		BFD_RELOC_V850_22_PLT_PCREL
		BFD_RELOC_V850_32_PLT_PCREL
		BFD_RELOC_V850_COPY
		BFD_RELOC_V850_GLOB_DAT
		BFD_RELOC_V850_JMP_SLOT
		BFD_RELOC_V850_RELATIVE
		BFD_RELOC_V850_16_GOTOFF
		BFD_RELOC_V850_32_GOTOFF
		BFD_RELOC_V850_CODE
		BFD_RELOC_V850_DATA
	#endif

	#if __BFD_VER__ <= 222
		BFD_RELOC_MN10300_32_PCREL
		BFD_RELOC_MN10300_16_PCREL
	#endif

	BFD_RELOC_TIC30_LDP
	BFD_RELOC_TIC54X_PARTLS7
	BFD_RELOC_TIC54X_PARTMS9
	BFD_RELOC_TIC54X_23
	BFD_RELOC_TIC54X_16_OF_23
	BFD_RELOC_TIC54X_MS7_OF_23

	#if __BFD_VER__ >= 221
		BFD_RELOC_C6000_PCR_S21
		BFD_RELOC_C6000_PCR_S12
		BFD_RELOC_C6000_PCR_S10
		BFD_RELOC_C6000_PCR_S7
		BFD_RELOC_C6000_ABS_S16
		BFD_RELOC_C6000_ABS_L16
		BFD_RELOC_C6000_ABS_H16
		BFD_RELOC_C6000_SBR_U15_B
		BFD_RELOC_C6000_SBR_U15_H
		BFD_RELOC_C6000_SBR_U15_W
		BFD_RELOC_C6000_SBR_S16
		BFD_RELOC_C6000_SBR_L16_B
		BFD_RELOC_C6000_SBR_L16_H
		BFD_RELOC_C6000_SBR_L16_W
		BFD_RELOC_C6000_SBR_H16_B
		BFD_RELOC_C6000_SBR_H16_H
		BFD_RELOC_C6000_SBR_H16_W
		BFD_RELOC_C6000_SBR_GOT_U15_W
		BFD_RELOC_C6000_SBR_GOT_L16_W
		BFD_RELOC_C6000_SBR_GOT_H16_W
		BFD_RELOC_C6000_DSBT_INDEX
		BFD_RELOC_C6000_PREL31
		BFD_RELOC_C6000_COPY
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_C6000_JUMP_SLOT
		BFD_RELOC_C6000_EHTYPE
		BFD_RELOC_C6000_PCR_H16
		BFD_RELOC_C6000_PCR_L16
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_C6000_ALIGN
		BFD_RELOC_C6000_FPHEAD
		BFD_RELOC_C6000_NOCMP
	#endif

	BFD_RELOC_FR30_48
	BFD_RELOC_FR30_20
	BFD_RELOC_FR30_6_IN_4
	BFD_RELOC_FR30_8_IN_8
	BFD_RELOC_FR30_9_IN_8
	BFD_RELOC_FR30_10_IN_8
	BFD_RELOC_FR30_9_PCREL
	BFD_RELOC_FR30_12_PCREL
	BFD_RELOC_MCORE_PCREL_IMM8BY4
	BFD_RELOC_MCORE_PCREL_IMM11BY2
	BFD_RELOC_MCORE_PCREL_IMM4BY2
	BFD_RELOC_MCORE_PCREL_32
	BFD_RELOC_MCORE_PCREL_JSR_IMM11BY2
	BFD_RELOC_MCORE_RVA

	#if __BFD_VER__ >= 218
		BFD_RELOC_MEP_8
		BFD_RELOC_MEP_16
		BFD_RELOC_MEP_32
		BFD_RELOC_MEP_PCREL8A2
		BFD_RELOC_MEP_PCREL12A2
		BFD_RELOC_MEP_PCREL17A2
		BFD_RELOC_MEP_PCREL24A2
		BFD_RELOC_MEP_PCABS24A2
		BFD_RELOC_MEP_LOW16
		BFD_RELOC_MEP_HI16U
		BFD_RELOC_MEP_HI16S
		BFD_RELOC_MEP_GPREL
		BFD_RELOC_MEP_TPREL
		BFD_RELOC_MEP_TPREL7
		BFD_RELOC_MEP_TPREL7A2
		BFD_RELOC_MEP_TPREL7A4
		BFD_RELOC_MEP_UIMM24
		BFD_RELOC_MEP_ADDR24A4
		BFD_RELOC_MEP_GNU_VTINHERIT
		BFD_RELOC_MEP_GNU_VTENTRY
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_METAG_HIADDR16
		BFD_RELOC_METAG_LOADDR16
		BFD_RELOC_METAG_RELBRANCH
		BFD_RELOC_METAG_GETSETOFF
		BFD_RELOC_METAG_HIOG
		BFD_RELOC_METAG_LOOG
		BFD_RELOC_METAG_REL8
		BFD_RELOC_METAG_REL16
		BFD_RELOC_METAG_HI16_GOTOFF
		BFD_RELOC_METAG_LO16_GOTOFF
		BFD_RELOC_METAG_GETSET_GOTOFF
		BFD_RELOC_METAG_GETSET_GOT
		BFD_RELOC_METAG_HI16_GOTPC
		BFD_RELOC_METAG_LO16_GOTPC
		BFD_RELOC_METAG_HI16_PLT
		BFD_RELOC_METAG_LO16_PLT
		BFD_RELOC_METAG_RELBRANCH_PLT
		BFD_RELOC_METAG_GOTOFF
		BFD_RELOC_METAG_PLT
		BFD_RELOC_METAG_COPY
		BFD_RELOC_METAG_JMP_SLOT
		BFD_RELOC_METAG_RELATIVE
		BFD_RELOC_METAG_GLOB_DAT
		BFD_RELOC_METAG_TLS_GD
		BFD_RELOC_METAG_TLS_LDM
		BFD_RELOC_METAG_TLS_LDO_HI16
		BFD_RELOC_METAG_TLS_LDO_LO16
		BFD_RELOC_METAG_TLS_LDO
		BFD_RELOC_METAG_TLS_IE
		BFD_RELOC_METAG_TLS_IENONPIC
		BFD_RELOC_METAG_TLS_IENONPIC_HI16
		BFD_RELOC_METAG_TLS_IENONPIC_LO16
		BFD_RELOC_METAG_TLS_TPOFF
		BFD_RELOC_METAG_TLS_DTPMOD
		BFD_RELOC_METAG_TLS_DTPOFF
		BFD_RELOC_METAG_TLS_LE
		BFD_RELOC_METAG_TLS_LE_HI16
		BFD_RELOC_METAG_TLS_LE_LO16
	#endif

	BFD_RELOC_MMIX_GETA
	BFD_RELOC_MMIX_GETA_1
	BFD_RELOC_MMIX_GETA_2
	BFD_RELOC_MMIX_GETA_3
	BFD_RELOC_MMIX_CBRANCH
	BFD_RELOC_MMIX_CBRANCH_J
	BFD_RELOC_MMIX_CBRANCH_1
	BFD_RELOC_MMIX_CBRANCH_2
	BFD_RELOC_MMIX_CBRANCH_3
	BFD_RELOC_MMIX_PUSHJ
	BFD_RELOC_MMIX_PUSHJ_1
	BFD_RELOC_MMIX_PUSHJ_2
	BFD_RELOC_MMIX_PUSHJ_3
	BFD_RELOC_MMIX_PUSHJ_STUBBABLE
	BFD_RELOC_MMIX_JMP
	BFD_RELOC_MMIX_JMP_1
	BFD_RELOC_MMIX_JMP_2
	BFD_RELOC_MMIX_JMP_3
	BFD_RELOC_MMIX_ADDR19
	BFD_RELOC_MMIX_ADDR27
	BFD_RELOC_MMIX_REG_OR_BYTE
	BFD_RELOC_MMIX_REG
	BFD_RELOC_MMIX_BASE_PLUS_OFFSET
	BFD_RELOC_MMIX_LOCAL
	BFD_RELOC_AVR_7_PCREL
	BFD_RELOC_AVR_13_PCREL
	BFD_RELOC_AVR_16_PM
	BFD_RELOC_AVR_LO8_LDI
	BFD_RELOC_AVR_HI8_LDI
	BFD_RELOC_AVR_HH8_LDI

	#if __BFD_VER__ >= 217
		BFD_RELOC_AVR_MS8_LDI
	#endif

	BFD_RELOC_AVR_LO8_LDI_NEG
	BFD_RELOC_AVR_HI8_LDI_NEG
	BFD_RELOC_AVR_HH8_LDI_NEG

	#if __BFD_VER__ >= 217
		BFD_RELOC_AVR_MS8_LDI_NEG
	#endif

	BFD_RELOC_AVR_LO8_LDI_PM

	#if __BFD_VER__ >= 218
		BFD_RELOC_AVR_LO8_LDI_GS
	#endif

	BFD_RELOC_AVR_HI8_LDI_PM

	#if __BFD_VER__ >= 218
		BFD_RELOC_AVR_HI8_LDI_GS
	#endif

	BFD_RELOC_AVR_HH8_LDI_PM
	BFD_RELOC_AVR_LO8_LDI_PM_NEG
	BFD_RELOC_AVR_HI8_LDI_PM_NEG
	BFD_RELOC_AVR_HH8_LDI_PM_NEG
	BFD_RELOC_AVR_CALL
	BFD_RELOC_AVR_LDI
	BFD_RELOC_AVR_6
	BFD_RELOC_AVR_6_ADIW

	#if __BFD_VER__ >= 223
		BFD_RELOC_AVR_8_LO
		BFD_RELOC_AVR_8_HI
		BFD_RELOC_AVR_8_HLO
	#endif

	#if __BFD_VER__ = 225
		BFD_RELOC_AVR_DIFF8
		BFD_RELOC_AVR_DIFF16
		BFD_RELOC_AVR_DIFF32
		BFD_RELOC_AVR_LDS_STS_16
		BFD_RELOC_AVR_PORT6
		BFD_RELOC_AVR_PORT5
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_RL78_NEG8
		BFD_RELOC_RL78_NEG16
		BFD_RELOC_RL78_NEG24
		BFD_RELOC_RL78_NEG32
		BFD_RELOC_RL78_16_OP
		BFD_RELOC_RL78_24_OP
		BFD_RELOC_RL78_32_OP
		BFD_RELOC_RL78_8U
		BFD_RELOC_RL78_16U
		BFD_RELOC_RL78_24U
		BFD_RELOC_RL78_DIR3U_PCREL
		BFD_RELOC_RL78_DIFF
		BFD_RELOC_RL78_GPRELB
		BFD_RELOC_RL78_GPRELW
		BFD_RELOC_RL78_GPRELL
		BFD_RELOC_RL78_SYM
		BFD_RELOC_RL78_OP_SUBTRACT
		BFD_RELOC_RL78_OP_NEG
		BFD_RELOC_RL78_OP_AND
		BFD_RELOC_RL78_OP_SHRA
		BFD_RELOC_RL78_ABS8
		BFD_RELOC_RL78_ABS16
		BFD_RELOC_RL78_ABS16_REV
		BFD_RELOC_RL78_ABS32
		BFD_RELOC_RL78_ABS32_REV
		BFD_RELOC_RL78_ABS16U
		BFD_RELOC_RL78_ABS16UW
		BFD_RELOC_RL78_ABS16UL
		BFD_RELOC_RL78_RELAX
		BFD_RELOC_RL78_HI16
		BFD_RELOC_RL78_HI8
		BFD_RELOC_RL78_LO16
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_RL78_CODE
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_RX_NEG8
		BFD_RELOC_RX_NEG16
		BFD_RELOC_RX_NEG24
		BFD_RELOC_RX_NEG32
		BFD_RELOC_RX_16_OP
		BFD_RELOC_RX_24_OP
		BFD_RELOC_RX_32_OP
		BFD_RELOC_RX_8U
		BFD_RELOC_RX_16U
		BFD_RELOC_RX_24U
		BFD_RELOC_RX_DIR3U_PCREL
		BFD_RELOC_RX_DIFF
		BFD_RELOC_RX_GPRELB
		BFD_RELOC_RX_GPRELW
		BFD_RELOC_RX_GPRELL
		BFD_RELOC_RX_SYM
		BFD_RELOC_RX_OP_SUBTRACT
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_RX_OP_NEG
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_RX_ABS8
		BFD_RELOC_RX_ABS16
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_RX_ABS16_REV
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_RX_ABS32
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_RX_ABS32_REV
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_RX_ABS16U
		BFD_RELOC_RX_ABS16UW
		BFD_RELOC_RX_ABS16UL
		BFD_RELOC_RX_RELAX
	#endif

	BFD_RELOC_390_12
	BFD_RELOC_390_GOT12
	BFD_RELOC_390_PLT32
	BFD_RELOC_390_COPY
	BFD_RELOC_390_GLOB_DAT
	BFD_RELOC_390_JMP_SLOT
	BFD_RELOC_390_RELATIVE
	BFD_RELOC_390_GOTPC
	BFD_RELOC_390_GOT16

	#if __BFD_VER__ >= 224
		BFD_RELOC_390_PC12DBL
		BFD_RELOC_390_PLT12DBL
	#endif

	BFD_RELOC_390_PC16DBL
	BFD_RELOC_390_PLT16DBL

	#if __BFD_VER__ >= 224
		BFD_RELOC_390_PC24DBL
		BFD_RELOC_390_PLT24DBL
	#endif

	BFD_RELOC_390_PC32DBL
	BFD_RELOC_390_PLT32DBL
	BFD_RELOC_390_GOTPCDBL
	BFD_RELOC_390_GOT64
	BFD_RELOC_390_PLT64
	BFD_RELOC_390_GOTENT
	BFD_RELOC_390_GOTOFF64
	BFD_RELOC_390_GOTPLT12
	BFD_RELOC_390_GOTPLT16
	BFD_RELOC_390_GOTPLT32
	BFD_RELOC_390_GOTPLT64
	BFD_RELOC_390_GOTPLTENT
	BFD_RELOC_390_PLTOFF16
	BFD_RELOC_390_PLTOFF32
	BFD_RELOC_390_PLTOFF64
	BFD_RELOC_390_TLS_LOAD
	BFD_RELOC_390_TLS_GDCALL
	BFD_RELOC_390_TLS_LDCALL
	BFD_RELOC_390_TLS_GD32
	BFD_RELOC_390_TLS_GD64
	BFD_RELOC_390_TLS_GOTIE12
	BFD_RELOC_390_TLS_GOTIE32
	BFD_RELOC_390_TLS_GOTIE64
	BFD_RELOC_390_TLS_LDM32
	BFD_RELOC_390_TLS_LDM64
	BFD_RELOC_390_TLS_IE32
	BFD_RELOC_390_TLS_IE64
	BFD_RELOC_390_TLS_IEENT
	BFD_RELOC_390_TLS_LE32
	BFD_RELOC_390_TLS_LE64
	BFD_RELOC_390_TLS_LDO32
	BFD_RELOC_390_TLS_LDO64
	BFD_RELOC_390_TLS_DTPMOD
	BFD_RELOC_390_TLS_DTPOFF
	BFD_RELOC_390_TLS_TPOFF
	BFD_RELOC_390_20
	BFD_RELOC_390_GOT20
	BFD_RELOC_390_GOTPLT20
	BFD_RELOC_390_TLS_GOTIE20

	#if (__BFD_VER__ = 218) or (__BFD_VER__ = 219)
		BFD_RELOC_SCORE_DUMMY1
	#elseif __BFD_VER__ >= 223
		BFD_RELOC_390_IRELATIVE
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_SCORE_GPREL15
		BFD_RELOC_SCORE_DUMMY2
		BFD_RELOC_SCORE_JMP
		BFD_RELOC_SCORE_BRANCH
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_SCORE_IMM30
		BFD_RELOC_SCORE_IMM32
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_SCORE16_JMP
		BFD_RELOC_SCORE16_BRANCH
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_SCORE_BCMP
	#endif

	#if __BFD_VER__ >= 218
		BFD_RELOC_SCORE_GOT15
		BFD_RELOC_SCORE_GOT_LO16
		BFD_RELOC_SCORE_CALL15
		BFD_RELOC_SCORE_DUMMY_HI16
	#endif

	BFD_RELOC_IP2K_FR9
	BFD_RELOC_IP2K_BANK
	BFD_RELOC_IP2K_ADDR16CJP
	BFD_RELOC_IP2K_PAGE3
	BFD_RELOC_IP2K_LO8DATA
	BFD_RELOC_IP2K_HI8DATA
	BFD_RELOC_IP2K_EX8DATA
	BFD_RELOC_IP2K_LO8INSN
	BFD_RELOC_IP2K_HI8INSN
	BFD_RELOC_IP2K_PC_SKIP
	BFD_RELOC_IP2K_TEXT
	BFD_RELOC_IP2K_FR_OFFSET
	BFD_RELOC_VPE4KMATH_DATA
	BFD_RELOC_VPE4KMATH_INSN
	BFD_RELOC_VTABLE_INHERIT
	BFD_RELOC_VTABLE_ENTRY
	BFD_RELOC_IA64_IMM14
	BFD_RELOC_IA64_IMM22
	BFD_RELOC_IA64_IMM64
	BFD_RELOC_IA64_DIR32MSB
	BFD_RELOC_IA64_DIR32LSB
	BFD_RELOC_IA64_DIR64MSB
	BFD_RELOC_IA64_DIR64LSB
	BFD_RELOC_IA64_GPREL22
	BFD_RELOC_IA64_GPREL64I
	BFD_RELOC_IA64_GPREL32MSB
	BFD_RELOC_IA64_GPREL32LSB
	BFD_RELOC_IA64_GPREL64MSB
	BFD_RELOC_IA64_GPREL64LSB
	BFD_RELOC_IA64_LTOFF22
	BFD_RELOC_IA64_LTOFF64I
	BFD_RELOC_IA64_PLTOFF22
	BFD_RELOC_IA64_PLTOFF64I
	BFD_RELOC_IA64_PLTOFF64MSB
	BFD_RELOC_IA64_PLTOFF64LSB
	BFD_RELOC_IA64_FPTR64I
	BFD_RELOC_IA64_FPTR32MSB
	BFD_RELOC_IA64_FPTR32LSB
	BFD_RELOC_IA64_FPTR64MSB
	BFD_RELOC_IA64_FPTR64LSB
	BFD_RELOC_IA64_PCREL21B
	BFD_RELOC_IA64_PCREL21BI
	BFD_RELOC_IA64_PCREL21M
	BFD_RELOC_IA64_PCREL21F
	BFD_RELOC_IA64_PCREL22
	BFD_RELOC_IA64_PCREL60B
	BFD_RELOC_IA64_PCREL64I
	BFD_RELOC_IA64_PCREL32MSB
	BFD_RELOC_IA64_PCREL32LSB
	BFD_RELOC_IA64_PCREL64MSB
	BFD_RELOC_IA64_PCREL64LSB
	BFD_RELOC_IA64_LTOFF_FPTR22
	BFD_RELOC_IA64_LTOFF_FPTR64I
	BFD_RELOC_IA64_LTOFF_FPTR32MSB
	BFD_RELOC_IA64_LTOFF_FPTR32LSB
	BFD_RELOC_IA64_LTOFF_FPTR64MSB
	BFD_RELOC_IA64_LTOFF_FPTR64LSB
	BFD_RELOC_IA64_SEGREL32MSB
	BFD_RELOC_IA64_SEGREL32LSB
	BFD_RELOC_IA64_SEGREL64MSB
	BFD_RELOC_IA64_SEGREL64LSB
	BFD_RELOC_IA64_SECREL32MSB
	BFD_RELOC_IA64_SECREL32LSB
	BFD_RELOC_IA64_SECREL64MSB
	BFD_RELOC_IA64_SECREL64LSB
	BFD_RELOC_IA64_REL32MSB
	BFD_RELOC_IA64_REL32LSB
	BFD_RELOC_IA64_REL64MSB
	BFD_RELOC_IA64_REL64LSB
	BFD_RELOC_IA64_LTV32MSB
	BFD_RELOC_IA64_LTV32LSB
	BFD_RELOC_IA64_LTV64MSB
	BFD_RELOC_IA64_LTV64LSB
	BFD_RELOC_IA64_IPLTMSB
	BFD_RELOC_IA64_IPLTLSB
	BFD_RELOC_IA64_COPY
	BFD_RELOC_IA64_LTOFF22X
	BFD_RELOC_IA64_LDXMOV
	BFD_RELOC_IA64_TPREL14
	BFD_RELOC_IA64_TPREL22
	BFD_RELOC_IA64_TPREL64I
	BFD_RELOC_IA64_TPREL64MSB
	BFD_RELOC_IA64_TPREL64LSB
	BFD_RELOC_IA64_LTOFF_TPREL22
	BFD_RELOC_IA64_DTPMOD64MSB
	BFD_RELOC_IA64_DTPMOD64LSB
	BFD_RELOC_IA64_LTOFF_DTPMOD22
	BFD_RELOC_IA64_DTPREL14
	BFD_RELOC_IA64_DTPREL22
	BFD_RELOC_IA64_DTPREL64I
	BFD_RELOC_IA64_DTPREL32MSB
	BFD_RELOC_IA64_DTPREL32LSB
	BFD_RELOC_IA64_DTPREL64MSB
	BFD_RELOC_IA64_DTPREL64LSB
	BFD_RELOC_IA64_LTOFF_DTPREL22
	BFD_RELOC_M68HC11_HI8
	BFD_RELOC_M68HC11_LO8
	BFD_RELOC_M68HC11_3B
	BFD_RELOC_M68HC11_RL_JUMP
	BFD_RELOC_M68HC11_RL_GROUP
	BFD_RELOC_M68HC11_LO16
	BFD_RELOC_M68HC11_PAGE
	BFD_RELOC_M68HC11_24
	BFD_RELOC_M68HC12_5B

	#if __BFD_VER__ >= 223
		BFD_RELOC_XGATE_RL_JUMP
		BFD_RELOC_XGATE_RL_GROUP
		BFD_RELOC_XGATE_LO16
		BFD_RELOC_XGATE_GPAGE
		BFD_RELOC_XGATE_24
		BFD_RELOC_XGATE_PCREL_9
		BFD_RELOC_XGATE_PCREL_10
		BFD_RELOC_XGATE_IMM8_LO
		BFD_RELOC_XGATE_IMM8_HI
		BFD_RELOC_XGATE_IMM3
		BFD_RELOC_XGATE_IMM4
		BFD_RELOC_XGATE_IMM5
		BFD_RELOC_M68HC12_9B
		BFD_RELOC_M68HC12_16B
		BFD_RELOC_M68HC12_9_PCREL
		BFD_RELOC_M68HC12_10_PCREL
		BFD_RELOC_M68HC12_LO8XG
		BFD_RELOC_M68HC12_HI8XG
	#endif

	BFD_RELOC_16C_NUM08
	BFD_RELOC_16C_NUM08_C
	BFD_RELOC_16C_NUM16
	BFD_RELOC_16C_NUM16_C
	BFD_RELOC_16C_NUM32
	BFD_RELOC_16C_NUM32_C
	BFD_RELOC_16C_DISP04
	BFD_RELOC_16C_DISP04_C
	BFD_RELOC_16C_DISP08
	BFD_RELOC_16C_DISP08_C
	BFD_RELOC_16C_DISP16
	BFD_RELOC_16C_DISP16_C
	BFD_RELOC_16C_DISP24
	BFD_RELOC_16C_DISP24_C
	BFD_RELOC_16C_DISP24a
	BFD_RELOC_16C_DISP24a_C
	BFD_RELOC_16C_REG04
	BFD_RELOC_16C_REG04_C
	BFD_RELOC_16C_REG04a
	BFD_RELOC_16C_REG04a_C
	BFD_RELOC_16C_REG14
	BFD_RELOC_16C_REG14_C
	BFD_RELOC_16C_REG16
	BFD_RELOC_16C_REG16_C
	BFD_RELOC_16C_REG20
	BFD_RELOC_16C_REG20_C
	BFD_RELOC_16C_ABS20
	BFD_RELOC_16C_ABS20_C
	BFD_RELOC_16C_ABS24
	BFD_RELOC_16C_ABS24_C
	BFD_RELOC_16C_IMM04
	BFD_RELOC_16C_IMM04_C
	BFD_RELOC_16C_IMM16
	BFD_RELOC_16C_IMM16_C
	BFD_RELOC_16C_IMM20
	BFD_RELOC_16C_IMM20_C
	BFD_RELOC_16C_IMM24
	BFD_RELOC_16C_IMM24_C
	BFD_RELOC_16C_IMM32
	BFD_RELOC_16C_IMM32_C

	#if __BFD_VER__ >= 218
		BFD_RELOC_CR16_NUM8
		BFD_RELOC_CR16_NUM16
		BFD_RELOC_CR16_NUM32
		BFD_RELOC_CR16_NUM32a
		BFD_RELOC_CR16_REGREL0
		BFD_RELOC_CR16_REGREL4
		BFD_RELOC_CR16_REGREL4a
		BFD_RELOC_CR16_REGREL14
		BFD_RELOC_CR16_REGREL14a
		BFD_RELOC_CR16_REGREL16
		BFD_RELOC_CR16_REGREL20
		BFD_RELOC_CR16_REGREL20a
		BFD_RELOC_CR16_ABS20
		BFD_RELOC_CR16_ABS24
		BFD_RELOC_CR16_IMM4
		BFD_RELOC_CR16_IMM8
		BFD_RELOC_CR16_IMM16
		BFD_RELOC_CR16_IMM20
		BFD_RELOC_CR16_IMM24
		BFD_RELOC_CR16_IMM32
		BFD_RELOC_CR16_IMM32a
		BFD_RELOC_CR16_DISP4
		BFD_RELOC_CR16_DISP8
		BFD_RELOC_CR16_DISP16
		BFD_RELOC_CR16_DISP20
		BFD_RELOC_CR16_DISP24
		BFD_RELOC_CR16_DISP24a
	#endif

	#if __BFD_VER__ >= 219
		BFD_RELOC_CR16_SWITCH8
		BFD_RELOC_CR16_SWITCH16
		BFD_RELOC_CR16_SWITCH32
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_CR16_GOT_REGREL20
		BFD_RELOC_CR16_GOTC_REGREL20
		BFD_RELOC_CR16_GLOB_DAT
	#endif

	BFD_RELOC_CRX_REL4
	BFD_RELOC_CRX_REL8
	BFD_RELOC_CRX_REL8_CMP
	BFD_RELOC_CRX_REL16
	BFD_RELOC_CRX_REL24
	BFD_RELOC_CRX_REL32
	BFD_RELOC_CRX_REGREL12
	BFD_RELOC_CRX_REGREL22
	BFD_RELOC_CRX_REGREL28
	BFD_RELOC_CRX_REGREL32
	BFD_RELOC_CRX_ABS16
	BFD_RELOC_CRX_ABS32
	BFD_RELOC_CRX_NUM8
	BFD_RELOC_CRX_NUM16
	BFD_RELOC_CRX_NUM32
	BFD_RELOC_CRX_IMM16
	BFD_RELOC_CRX_IMM32
	BFD_RELOC_CRX_SWITCH8
	BFD_RELOC_CRX_SWITCH16
	BFD_RELOC_CRX_SWITCH32
	BFD_RELOC_CRIS_BDISP8
	BFD_RELOC_CRIS_UNSIGNED_5
	BFD_RELOC_CRIS_SIGNED_6
	BFD_RELOC_CRIS_UNSIGNED_6
	BFD_RELOC_CRIS_SIGNED_8
	BFD_RELOC_CRIS_UNSIGNED_8
	BFD_RELOC_CRIS_SIGNED_16
	BFD_RELOC_CRIS_UNSIGNED_16
	BFD_RELOC_CRIS_LAPCQ_OFFSET
	BFD_RELOC_CRIS_UNSIGNED_4
	BFD_RELOC_CRIS_COPY
	BFD_RELOC_CRIS_GLOB_DAT
	BFD_RELOC_CRIS_JUMP_SLOT
	BFD_RELOC_CRIS_RELATIVE
	BFD_RELOC_CRIS_32_GOT
	BFD_RELOC_CRIS_16_GOT
	BFD_RELOC_CRIS_32_GOTPLT
	BFD_RELOC_CRIS_16_GOTPLT
	BFD_RELOC_CRIS_32_GOTREL
	BFD_RELOC_CRIS_32_PLT_GOTREL
	BFD_RELOC_CRIS_32_PLT_PCREL

	#if __BFD_VER__ >= 220
		BFD_RELOC_CRIS_32_GOT_GD
		BFD_RELOC_CRIS_16_GOT_GD
		BFD_RELOC_CRIS_32_GD
		BFD_RELOC_CRIS_DTP
		BFD_RELOC_CRIS_32_DTPREL
		BFD_RELOC_CRIS_16_DTPREL
		BFD_RELOC_CRIS_32_GOT_TPREL
		BFD_RELOC_CRIS_16_GOT_TPREL
		BFD_RELOC_CRIS_32_TPREL
		BFD_RELOC_CRIS_16_TPREL
		BFD_RELOC_CRIS_DTPMOD
		BFD_RELOC_CRIS_32_IE
	#endif

	BFD_RELOC_860_COPY
	BFD_RELOC_860_GLOB_DAT
	BFD_RELOC_860_JUMP_SLOT
	BFD_RELOC_860_RELATIVE
	BFD_RELOC_860_PC26
	BFD_RELOC_860_PLT26
	BFD_RELOC_860_PC16
	BFD_RELOC_860_LOW0
	BFD_RELOC_860_SPLIT0
	BFD_RELOC_860_LOW1
	BFD_RELOC_860_SPLIT1
	BFD_RELOC_860_LOW2
	BFD_RELOC_860_SPLIT2
	BFD_RELOC_860_LOW3
	BFD_RELOC_860_LOGOT0
	BFD_RELOC_860_SPGOT0
	BFD_RELOC_860_LOGOT1
	BFD_RELOC_860_SPGOT1
	BFD_RELOC_860_LOGOTOFF0
	BFD_RELOC_860_SPGOTOFF0
	BFD_RELOC_860_LOGOTOFF1
	BFD_RELOC_860_SPGOTOFF1
	BFD_RELOC_860_LOGOTOFF2
	BFD_RELOC_860_LOGOTOFF3
	BFD_RELOC_860_LOPC
	BFD_RELOC_860_HIGHADJ
	BFD_RELOC_860_HAGOT
	BFD_RELOC_860_HAGOTOFF
	BFD_RELOC_860_HAPC
	BFD_RELOC_860_HIGH
	BFD_RELOC_860_HIGOT
	BFD_RELOC_860_HIGOTOFF

	#if __BFD_VER__ = 225
		BFD_RELOC_OR1K_REL_26
		BFD_RELOC_OR1K_GOTPC_HI16
		BFD_RELOC_OR1K_GOTPC_LO16
		BFD_RELOC_OR1K_GOT16
		BFD_RELOC_OR1K_PLT26
		BFD_RELOC_OR1K_GOTOFF_HI16
		BFD_RELOC_OR1K_GOTOFF_LO16
		BFD_RELOC_OR1K_COPY
		BFD_RELOC_OR1K_GLOB_DAT
		BFD_RELOC_OR1K_JMP_SLOT
		BFD_RELOC_OR1K_RELATIVE
		BFD_RELOC_OR1K_TLS_GD_HI16
		BFD_RELOC_OR1K_TLS_GD_LO16
		BFD_RELOC_OR1K_TLS_LDM_HI16
		BFD_RELOC_OR1K_TLS_LDM_LO16
		BFD_RELOC_OR1K_TLS_LDO_HI16
		BFD_RELOC_OR1K_TLS_LDO_LO16
		BFD_RELOC_OR1K_TLS_IE_HI16
		BFD_RELOC_OR1K_TLS_IE_LO16
		BFD_RELOC_OR1K_TLS_LE_HI16
		BFD_RELOC_OR1K_TLS_LE_LO16
		BFD_RELOC_OR1K_TLS_TPOFF
		BFD_RELOC_OR1K_TLS_DTPOFF
		BFD_RELOC_OR1K_TLS_DTPMOD
	#else
		BFD_RELOC_OPENRISC_ABS_26
		BFD_RELOC_OPENRISC_REL_26
	#endif

	BFD_RELOC_H8_DIR16A8
	BFD_RELOC_H8_DIR16R8
	BFD_RELOC_H8_DIR24A8
	BFD_RELOC_H8_DIR24R8
	BFD_RELOC_H8_DIR32A16

	#if __BFD_VER__ >= 224
		BFD_RELOC_H8_DISP32A16
	#endif

	BFD_RELOC_XSTORMY16_REL_12
	BFD_RELOC_XSTORMY16_12
	BFD_RELOC_XSTORMY16_24
	BFD_RELOC_XSTORMY16_FPTR16

	#if __BFD_VER__ >= 218
		BFD_RELOC_RELC
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_XC16X_PAG
		BFD_RELOC_XC16X_POF
		BFD_RELOC_XC16X_SEG
		BFD_RELOC_XC16X_SOF
	#endif

	BFD_RELOC_VAX_GLOB_DAT
	BFD_RELOC_VAX_JMP_SLOT
	BFD_RELOC_VAX_RELATIVE

	#if __BFD_VER__ >= 217
		BFD_RELOC_MT_PC16
		BFD_RELOC_MT_HI16
		BFD_RELOC_MT_LO16
		BFD_RELOC_MT_GNU_VTINHERIT
		BFD_RELOC_MT_GNU_VTENTRY
		BFD_RELOC_MT_PCINSN8
	#endif

	BFD_RELOC_MSP430_10_PCREL
	BFD_RELOC_MSP430_16_PCREL
	BFD_RELOC_MSP430_16
	BFD_RELOC_MSP430_16_PCREL_BYTE
	BFD_RELOC_MSP430_16_BYTE
	BFD_RELOC_MSP430_2X_PCREL
	BFD_RELOC_MSP430_RL_PCREL

	#if __BFD_VER__ >= 224
		BFD_RELOC_MSP430_ABS8
		BFD_RELOC_MSP430X_PCR20_EXT_SRC
		BFD_RELOC_MSP430X_PCR20_EXT_DST
		BFD_RELOC_MSP430X_PCR20_EXT_ODST
		BFD_RELOC_MSP430X_ABS20_EXT_SRC
		BFD_RELOC_MSP430X_ABS20_EXT_DST
		BFD_RELOC_MSP430X_ABS20_EXT_ODST
		BFD_RELOC_MSP430X_ABS20_ADR_SRC
		BFD_RELOC_MSP430X_ABS20_ADR_DST
		BFD_RELOC_MSP430X_PCR16
		BFD_RELOC_MSP430X_PCR20_CALL
		BFD_RELOC_MSP430X_ABS16
		BFD_RELOC_MSP430_ABS_HI16
		BFD_RELOC_MSP430_PREL31
		BFD_RELOC_MSP430_SYM_DIFF
		BFD_RELOC_NIOS2_S16
		BFD_RELOC_NIOS2_U16
		BFD_RELOC_NIOS2_CALL26
		BFD_RELOC_NIOS2_IMM5
		BFD_RELOC_NIOS2_CACHE_OPX
		BFD_RELOC_NIOS2_IMM6
		BFD_RELOC_NIOS2_IMM8
		BFD_RELOC_NIOS2_HI16
		BFD_RELOC_NIOS2_LO16
		BFD_RELOC_NIOS2_HIADJ16
		BFD_RELOC_NIOS2_GPREL
		BFD_RELOC_NIOS2_UJMP
		BFD_RELOC_NIOS2_CJMP
		BFD_RELOC_NIOS2_CALLR
		BFD_RELOC_NIOS2_ALIGN
		BFD_RELOC_NIOS2_GOT16
		BFD_RELOC_NIOS2_CALL16
		BFD_RELOC_NIOS2_GOTOFF_LO
		BFD_RELOC_NIOS2_GOTOFF_HA
		BFD_RELOC_NIOS2_PCREL_LO
		BFD_RELOC_NIOS2_PCREL_HA
		BFD_RELOC_NIOS2_TLS_GD16
		BFD_RELOC_NIOS2_TLS_LDM16
		BFD_RELOC_NIOS2_TLS_LDO16
		BFD_RELOC_NIOS2_TLS_IE16
		BFD_RELOC_NIOS2_TLS_LE16
		BFD_RELOC_NIOS2_TLS_DTPMOD
		BFD_RELOC_NIOS2_TLS_DTPREL
		BFD_RELOC_NIOS2_TLS_TPREL
		BFD_RELOC_NIOS2_COPY
		BFD_RELOC_NIOS2_GLOB_DAT
		BFD_RELOC_NIOS2_JUMP_SLOT
		BFD_RELOC_NIOS2_RELATIVE
		BFD_RELOC_NIOS2_GOTOFF
	#endif

	#if __BFD_VER__ = 225
		BFD_RELOC_NIOS2_CALL26_NOAT
		BFD_RELOC_NIOS2_GOT_LO
		BFD_RELOC_NIOS2_GOT_HA
		BFD_RELOC_NIOS2_CALL_LO
		BFD_RELOC_NIOS2_CALL_HA
	#endif

	BFD_RELOC_IQ2000_OFFSET_16
	BFD_RELOC_IQ2000_OFFSET_21
	BFD_RELOC_IQ2000_UHI16
	BFD_RELOC_XTENSA_RTLD
	BFD_RELOC_XTENSA_GLOB_DAT
	BFD_RELOC_XTENSA_JMP_SLOT
	BFD_RELOC_XTENSA_RELATIVE
	BFD_RELOC_XTENSA_PLT
	BFD_RELOC_XTENSA_DIFF8
	BFD_RELOC_XTENSA_DIFF16
	BFD_RELOC_XTENSA_DIFF32
	BFD_RELOC_XTENSA_SLOT0_OP
	BFD_RELOC_XTENSA_SLOT1_OP
	BFD_RELOC_XTENSA_SLOT2_OP
	BFD_RELOC_XTENSA_SLOT3_OP
	BFD_RELOC_XTENSA_SLOT4_OP
	BFD_RELOC_XTENSA_SLOT5_OP
	BFD_RELOC_XTENSA_SLOT6_OP
	BFD_RELOC_XTENSA_SLOT7_OP
	BFD_RELOC_XTENSA_SLOT8_OP
	BFD_RELOC_XTENSA_SLOT9_OP
	BFD_RELOC_XTENSA_SLOT10_OP
	BFD_RELOC_XTENSA_SLOT11_OP
	BFD_RELOC_XTENSA_SLOT12_OP
	BFD_RELOC_XTENSA_SLOT13_OP
	BFD_RELOC_XTENSA_SLOT14_OP
	BFD_RELOC_XTENSA_SLOT0_ALT
	BFD_RELOC_XTENSA_SLOT1_ALT
	BFD_RELOC_XTENSA_SLOT2_ALT
	BFD_RELOC_XTENSA_SLOT3_ALT
	BFD_RELOC_XTENSA_SLOT4_ALT
	BFD_RELOC_XTENSA_SLOT5_ALT
	BFD_RELOC_XTENSA_SLOT6_ALT
	BFD_RELOC_XTENSA_SLOT7_ALT
	BFD_RELOC_XTENSA_SLOT8_ALT
	BFD_RELOC_XTENSA_SLOT9_ALT
	BFD_RELOC_XTENSA_SLOT10_ALT
	BFD_RELOC_XTENSA_SLOT11_ALT
	BFD_RELOC_XTENSA_SLOT12_ALT
	BFD_RELOC_XTENSA_SLOT13_ALT
	BFD_RELOC_XTENSA_SLOT14_ALT
	BFD_RELOC_XTENSA_OP0
	BFD_RELOC_XTENSA_OP1
	BFD_RELOC_XTENSA_OP2
	BFD_RELOC_XTENSA_ASM_EXPAND
	BFD_RELOC_XTENSA_ASM_SIMPLIFY

	#if __BFD_VER__ >= 219
		BFD_RELOC_XTENSA_TLSDESC_FN
		BFD_RELOC_XTENSA_TLSDESC_ARG
		BFD_RELOC_XTENSA_TLS_DTPOFF
		BFD_RELOC_XTENSA_TLS_TPOFF
		BFD_RELOC_XTENSA_TLS_FUNC
		BFD_RELOC_XTENSA_TLS_ARG
		BFD_RELOC_XTENSA_TLS_CALL
	#endif

	#if __BFD_VER__ >= 217
		BFD_RELOC_Z80_DISP8
		BFD_RELOC_Z8K_DISP7
		BFD_RELOC_Z8K_CALLR
		BFD_RELOC_Z8K_IMM4L
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_LM32_CALL
		BFD_RELOC_LM32_BRANCH
		BFD_RELOC_LM32_16_GOT
		BFD_RELOC_LM32_GOTOFF_HI16
		BFD_RELOC_LM32_GOTOFF_LO16
		BFD_RELOC_LM32_COPY
		BFD_RELOC_LM32_GLOB_DAT
		BFD_RELOC_LM32_JMP_SLOT
		BFD_RELOC_LM32_RELATIVE
		BFD_RELOC_MACH_O_SECTDIFF
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_MACH_O_LOCAL_SECTDIFF
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_MACH_O_PAIR
	#endif

	#if __BFD_VER__ >= 221
		BFD_RELOC_MACH_O_X86_64_BRANCH32
		BFD_RELOC_MACH_O_X86_64_BRANCH8
		BFD_RELOC_MACH_O_X86_64_GOT
		BFD_RELOC_MACH_O_X86_64_GOT_LOAD
		BFD_RELOC_MACH_O_X86_64_SUBTRACTOR32
		BFD_RELOC_MACH_O_X86_64_SUBTRACTOR64
		BFD_RELOC_MACH_O_X86_64_PCREL32_1
		BFD_RELOC_MACH_O_X86_64_PCREL32_2
		BFD_RELOC_MACH_O_X86_64_PCREL32_4
	#endif

	#if __BFD_VER__ >= 220
		BFD_RELOC_MICROBLAZE_32_LO
		BFD_RELOC_MICROBLAZE_32_LO_PCREL
		BFD_RELOC_MICROBLAZE_32_ROSDA
		BFD_RELOC_MICROBLAZE_32_RWSDA
		BFD_RELOC_MICROBLAZE_32_SYM_OP_SYM
		BFD_RELOC_MICROBLAZE_64_NONE
		BFD_RELOC_MICROBLAZE_64_GOTPC
		BFD_RELOC_MICROBLAZE_64_GOT
		BFD_RELOC_MICROBLAZE_64_PLT
		BFD_RELOC_MICROBLAZE_64_GOTOFF
		BFD_RELOC_MICROBLAZE_32_GOTOFF
		BFD_RELOC_MICROBLAZE_COPY
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_ADD_LO12
		BFD_RELOC_AARCH64_ADR_GOT_PAGE
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_MICROBLAZE_64_TLS
		BFD_RELOC_MICROBLAZE_64_TLSGD
		BFD_RELOC_MICROBLAZE_64_TLSLD
		BFD_RELOC_MICROBLAZE_32_TLSDTPMOD
		BFD_RELOC_MICROBLAZE_32_TLSDTPREL
		BFD_RELOC_MICROBLAZE_64_TLSDTPREL
		BFD_RELOC_MICROBLAZE_64_TLSGOTTPREL
		BFD_RELOC_MICROBLAZE_64_TLSTPREL
		BFD_RELOC_AARCH64_RELOC_START
		BFD_RELOC_AARCH64_NONE
		BFD_RELOC_AARCH64_64
		BFD_RELOC_AARCH64_32
		BFD_RELOC_AARCH64_16
		BFD_RELOC_AARCH64_64_PCREL
		BFD_RELOC_AARCH64_32_PCREL
		BFD_RELOC_AARCH64_16_PCREL
		BFD_RELOC_AARCH64_MOVW_G0
		BFD_RELOC_AARCH64_MOVW_G0_NC
		BFD_RELOC_AARCH64_MOVW_G1
		BFD_RELOC_AARCH64_MOVW_G1_NC
		BFD_RELOC_AARCH64_MOVW_G2
		BFD_RELOC_AARCH64_MOVW_G2_NC
		BFD_RELOC_AARCH64_MOVW_G3
		BFD_RELOC_AARCH64_MOVW_G0_S
		BFD_RELOC_AARCH64_MOVW_G1_S
		BFD_RELOC_AARCH64_MOVW_G2_S
		BFD_RELOC_AARCH64_LD_LO19_PCREL
		BFD_RELOC_AARCH64_ADR_LO21_PCREL
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_ADR_HI21_PCREL
		BFD_RELOC_AARCH64_ADR_HI21_NC_PCREL
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_ADR_LO21_PCREL
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_ADD_LO12
		BFD_RELOC_AARCH64_LDST8_LO12
		BFD_RELOC_AARCH64_TSTBR14
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_BRANCH19
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_JUMP26
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_CALL26
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_GAS_INTERNAL_FIXUP
		BFD_RELOC_AARCH64_JUMP26
		BFD_RELOC_AARCH64_LD_LO19_PCREL
		BFD_RELOC_AARCH64_LD64_GOT_LO12_NC
		BFD_RELOC_AARCH64_LDST_LO12
		BFD_RELOC_AARCH64_LDST8_LO12
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_LDST16_LO12
		BFD_RELOC_AARCH64_LDST32_LO12
		BFD_RELOC_AARCH64_LDST64_LO12
		BFD_RELOC_AARCH64_LDST128_LO12
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_MOVW_G0
		BFD_RELOC_AARCH64_MOVW_G0_S
		BFD_RELOC_AARCH64_MOVW_G0_NC
		BFD_RELOC_AARCH64_MOVW_G1
		BFD_RELOC_AARCH64_MOVW_G1_NC
		BFD_RELOC_AARCH64_MOVW_G1_S
		BFD_RELOC_AARCH64_MOVW_G2
		BFD_RELOC_AARCH64_MOVW_G2_NC
		BFD_RELOC_AARCH64_MOVW_G2_S
		BFD_RELOC_AARCH64_MOVW_G3
		BFD_RELOC_AARCH64_TLSDESC
		BFD_RELOC_AARCH64_TLSDESC_ADD
		BFD_RELOC_AARCH64_TLSDESC_ADD_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_ADR_PAGE
		BFD_RELOC_AARCH64_TLSDESC_ADR_PREL21
		BFD_RELOC_AARCH64_TLSDESC_CALL
		BFD_RELOC_AARCH64_TLSDESC_LD64_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_LD64_PREL19
		BFD_RELOC_AARCH64_TLSDESC_LDR
		BFD_RELOC_AARCH64_TLSDESC_OFF_G0_NC
		BFD_RELOC_AARCH64_TLSDESC_OFF_G1
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_GOT_LD_PREL19
		BFD_RELOC_AARCH64_ADR_GOT_PAGE
		BFD_RELOC_AARCH64_LD64_GOT_LO12_NC
		BFD_RELOC_AARCH64_LD32_GOT_LO12_NC
		BFD_RELOC_AARCH64_TLSGD_ADR_PAGE21
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_TLSGD_ADD_LO12_NC
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_TLSGD_ADR_PAGE21
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_TLSIE_MOVW_GOTTPREL_G1
		BFD_RELOC_AARCH64_TLSIE_MOVW_GOTTPREL_G0_NC
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_TLSIE_ADR_GOTTPREL_PAGE21
	#endif

	#if __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC
		BFD_RELOC_AARCH64_TLSIE_LD32_GOTTPREL_LO12_NC
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_TLSIE_LD_GOTTPREL_PREL19
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_TLSIE_LD64_GOTTPREL_LO12_NC
		BFD_RELOC_AARCH64_TLSIE_MOVW_GOTTPREL_G0_NC
		BFD_RELOC_AARCH64_TLSIE_MOVW_GOTTPREL_G1
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G2
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G1
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G1_NC
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G0
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G0_NC
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_AARCH64_TLSLE_ADD_TPREL_HI12
		BFD_RELOC_AARCH64_TLSLE_ADD_TPREL_LO12
		BFD_RELOC_AARCH64_TLSLE_ADD_TPREL_LO12_NC
	#endif

	#if __BFD_VER__ = 223
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G0
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G0_NC
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G1
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G1_NC
		BFD_RELOC_AARCH64_TLSLE_MOVW_TPREL_G2
		BFD_RELOC_AARCH64_TLS_DTPMOD64
		BFD_RELOC_AARCH64_TLS_DTPREL64
		BFD_RELOC_AARCH64_TLS_TPREL64
		BFD_RELOC_AARCH64_TSTBR14
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_AARCH64_TLSDESC_LD_PREL19
		BFD_RELOC_AARCH64_TLSDESC_ADR_PREL21
		BFD_RELOC_AARCH64_TLSDESC_ADR_PAGE21
		BFD_RELOC_AARCH64_TLSDESC_LD64_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_LD32_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_ADD_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_OFF_G1
		BFD_RELOC_AARCH64_TLSDESC_OFF_G0_NC
		BFD_RELOC_AARCH64_TLSDESC_LDR
		BFD_RELOC_AARCH64_TLSDESC_ADD
		BFD_RELOC_AARCH64_TLSDESC_CALL
		BFD_RELOC_AARCH64_COPY
		BFD_RELOC_AARCH64_GLOB_DAT
		BFD_RELOC_AARCH64_JUMP_SLOT
		BFD_RELOC_AARCH64_RELATIVE
		BFD_RELOC_AARCH64_TLS_DTPMOD
		BFD_RELOC_AARCH64_TLS_DTPREL
		BFD_RELOC_AARCH64_TLS_TPREL
		BFD_RELOC_AARCH64_TLSDESC
		BFD_RELOC_AARCH64_IRELATIVE
		BFD_RELOC_AARCH64_RELOC_END
		BFD_RELOC_AARCH64_GAS_INTERNAL_FIXUP
		BFD_RELOC_AARCH64_LDST_LO12
		BFD_RELOC_AARCH64_LD_GOT_LO12_NC
		BFD_RELOC_AARCH64_TLSIE_LD_GOTTPREL_LO12_NC
		BFD_RELOC_AARCH64_TLSDESC_LD_LO12_NC
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEPRO_COPY
		BFD_RELOC_TILEPRO_GLOB_DAT
		BFD_RELOC_TILEPRO_JMP_SLOT
		BFD_RELOC_TILEPRO_RELATIVE
		BFD_RELOC_TILEPRO_BROFF_X1
		BFD_RELOC_TILEPRO_JOFFLONG_X1
		BFD_RELOC_TILEPRO_JOFFLONG_X1_PLT
		BFD_RELOC_TILEPRO_IMM8_X0
		BFD_RELOC_TILEPRO_IMM8_Y0
		BFD_RELOC_TILEPRO_IMM8_X1
		BFD_RELOC_TILEPRO_IMM8_Y1
		BFD_RELOC_TILEPRO_DEST_IMM8_X1
		BFD_RELOC_TILEPRO_MT_IMM15_X1
		BFD_RELOC_TILEPRO_MF_IMM15_X1
		BFD_RELOC_TILEPRO_IMM16_X0
		BFD_RELOC_TILEPRO_IMM16_X1
		BFD_RELOC_TILEPRO_IMM16_X0_LO
		BFD_RELOC_TILEPRO_IMM16_X1_LO
		BFD_RELOC_TILEPRO_IMM16_X0_HI
		BFD_RELOC_TILEPRO_IMM16_X1_HI
		BFD_RELOC_TILEPRO_IMM16_X0_HA
		BFD_RELOC_TILEPRO_IMM16_X1_HA
		BFD_RELOC_TILEPRO_IMM16_X0_PCREL
		BFD_RELOC_TILEPRO_IMM16_X1_PCREL
		BFD_RELOC_TILEPRO_IMM16_X0_LO_PCREL
		BFD_RELOC_TILEPRO_IMM16_X1_LO_PCREL
		BFD_RELOC_TILEPRO_IMM16_X0_HI_PCREL
		BFD_RELOC_TILEPRO_IMM16_X1_HI_PCREL
		BFD_RELOC_TILEPRO_IMM16_X0_HA_PCREL
		BFD_RELOC_TILEPRO_IMM16_X1_HA_PCREL
		BFD_RELOC_TILEPRO_IMM16_X0_GOT
		BFD_RELOC_TILEPRO_IMM16_X1_GOT
		BFD_RELOC_TILEPRO_IMM16_X0_GOT_LO
		BFD_RELOC_TILEPRO_IMM16_X1_GOT_LO
		BFD_RELOC_TILEPRO_IMM16_X0_GOT_HI
		BFD_RELOC_TILEPRO_IMM16_X1_GOT_HI
		BFD_RELOC_TILEPRO_IMM16_X0_GOT_HA
		BFD_RELOC_TILEPRO_IMM16_X1_GOT_HA
		BFD_RELOC_TILEPRO_MMSTART_X0
		BFD_RELOC_TILEPRO_MMEND_X0
		BFD_RELOC_TILEPRO_MMSTART_X1
		BFD_RELOC_TILEPRO_MMEND_X1
		BFD_RELOC_TILEPRO_SHAMT_X0
		BFD_RELOC_TILEPRO_SHAMT_X1
		BFD_RELOC_TILEPRO_SHAMT_Y0
		BFD_RELOC_TILEPRO_SHAMT_Y1
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_TILEPRO_TLS_GD_CALL
		BFD_RELOC_TILEPRO_IMM8_X0_TLS_GD_ADD
		BFD_RELOC_TILEPRO_IMM8_X1_TLS_GD_ADD
		BFD_RELOC_TILEPRO_IMM8_Y0_TLS_GD_ADD
		BFD_RELOC_TILEPRO_IMM8_Y1_TLS_GD_ADD
		BFD_RELOC_TILEPRO_TLS_IE_LOAD
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_GD
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_GD
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_GD_LO
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_GD_LO
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_GD_HI
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_GD_HI
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_GD_HA
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_GD_HA
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_IE
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_IE
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_IE_LO
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_IE_LO
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_IE_HI
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_IE_HI
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_IE_HA
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_IE_HA
		BFD_RELOC_TILEPRO_TLS_DTPMOD32
		BFD_RELOC_TILEPRO_TLS_DTPOFF32
		BFD_RELOC_TILEPRO_TLS_TPOFF32
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_LE
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_LE
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_LE_LO
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_LE_LO
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_LE_HI
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_LE_HI
		BFD_RELOC_TILEPRO_IMM16_X0_TLS_LE_HA
		BFD_RELOC_TILEPRO_IMM16_X1_TLS_LE_HA
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_HW0
		BFD_RELOC_TILEGX_HW1
		BFD_RELOC_TILEGX_HW2
		BFD_RELOC_TILEGX_HW3
		BFD_RELOC_TILEGX_HW0_LAST
		BFD_RELOC_TILEGX_HW1_LAST
		BFD_RELOC_TILEGX_HW2_LAST
		BFD_RELOC_TILEGX_COPY
		BFD_RELOC_TILEGX_GLOB_DAT
		BFD_RELOC_TILEGX_JMP_SLOT
		BFD_RELOC_TILEGX_RELATIVE
		BFD_RELOC_TILEGX_BROFF_X1
		BFD_RELOC_TILEGX_JUMPOFF_X1
		BFD_RELOC_TILEGX_JUMPOFF_X1_PLT
		BFD_RELOC_TILEGX_IMM8_X0
		BFD_RELOC_TILEGX_IMM8_Y0
		BFD_RELOC_TILEGX_IMM8_X1
		BFD_RELOC_TILEGX_IMM8_Y1
		BFD_RELOC_TILEGX_DEST_IMM8_X1
		BFD_RELOC_TILEGX_MT_IMM14_X1
		BFD_RELOC_TILEGX_MF_IMM14_X1
		BFD_RELOC_TILEGX_MMSTART_X0
		BFD_RELOC_TILEGX_MMEND_X0
		BFD_RELOC_TILEGX_SHAMT_X0
		BFD_RELOC_TILEGX_SHAMT_X1
		BFD_RELOC_TILEGX_SHAMT_Y0
		BFD_RELOC_TILEGX_SHAMT_Y1
		BFD_RELOC_TILEGX_IMM16_X0_HW0
		BFD_RELOC_TILEGX_IMM16_X1_HW0
		BFD_RELOC_TILEGX_IMM16_X0_HW1
		BFD_RELOC_TILEGX_IMM16_X1_HW1
		BFD_RELOC_TILEGX_IMM16_X0_HW2
		BFD_RELOC_TILEGX_IMM16_X1_HW2
		BFD_RELOC_TILEGX_IMM16_X0_HW3
		BFD_RELOC_TILEGX_IMM16_X1_HW3
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST
		BFD_RELOC_TILEGX_IMM16_X0_HW0_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW0_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW1_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW1_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW2_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW2_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW3_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW3_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW0_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW0_GOT
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW1_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW1_GOT
		BFD_RELOC_TILEGX_IMM16_X0_HW2_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW2_GOT
		BFD_RELOC_TILEGX_IMM16_X0_HW3_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW3_GOT
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_TILEGX_IMM16_X0_HW0_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW0_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW1_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW1_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW2_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW2_PLT_PCREL
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_GOT
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_GOT
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST_GOT
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST_GOT
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_TILEGX_IMM16_X0_HW3_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW3_PLT_PCREL
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_IMM16_X0_HW0_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW0_TLS_GD
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW1_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW1_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X0_HW2_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW2_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X0_HW3_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW3_TLS_GD
	#elseif __BFD_VER__ >= 223
		BFD_RELOC_TILEGX_IMM16_X0_HW0_TLS_LE
		BFD_RELOC_TILEGX_IMM16_X1_HW0_TLS_LE
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_TLS_LE
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_TLS_LE
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_TLS_LE
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_TLS_LE
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_TLS_GD
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST_TLS_GD
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST_TLS_GD
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_IMM16_X0_HW0_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW0_TLS_IE
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW1_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW1_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X0_HW2_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW2_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X0_HW3_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW3_TLS_IE
	#elseif __BFD_VER__ >= 224
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST_PLT_PCREL
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST_PLT_PCREL
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_IMM16_X0_HW0_LAST_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW0_LAST_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X0_HW1_LAST_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW1_LAST_TLS_IE
	#endif

	#if __BFD_VER__ = 222
		BFD_RELOC_TILEGX_IMM16_X0_HW2_LAST_TLS_IE
		BFD_RELOC_TILEGX_IMM16_X1_HW2_LAST_TLS_IE
	#endif

	#if __BFD_VER__ >= 222
		BFD_RELOC_TILEGX_TLS_DTPMOD64
		BFD_RELOC_TILEGX_TLS_DTPOFF64
		BFD_RELOC_TILEGX_TLS_TPOFF64
		BFD_RELOC_TILEGX_TLS_DTPMOD32
		BFD_RELOC_TILEGX_TLS_DTPOFF32
		BFD_RELOC_TILEGX_TLS_TPOFF32
	#endif

	#if __BFD_VER__ >= 223
		BFD_RELOC_TILEGX_TLS_GD_CALL
		BFD_RELOC_TILEGX_IMM8_X0_TLS_GD_ADD
		BFD_RELOC_TILEGX_IMM8_X1_TLS_GD_ADD
		BFD_RELOC_TILEGX_IMM8_Y0_TLS_GD_ADD
		BFD_RELOC_TILEGX_IMM8_Y1_TLS_GD_ADD
		BFD_RELOC_TILEGX_TLS_IE_LOAD
		BFD_RELOC_TILEGX_IMM8_X0_TLS_ADD
		BFD_RELOC_TILEGX_IMM8_X1_TLS_ADD
		BFD_RELOC_TILEGX_IMM8_Y0_TLS_ADD
		BFD_RELOC_TILEGX_IMM8_Y1_TLS_ADD
		BFD_RELOC_EPIPHANY_SIMM8
		BFD_RELOC_EPIPHANY_SIMM24
		BFD_RELOC_EPIPHANY_HIGH
		BFD_RELOC_EPIPHANY_LOW
		BFD_RELOC_EPIPHANY_SIMM11
		BFD_RELOC_EPIPHANY_IMM11
		BFD_RELOC_EPIPHANY_IMM8
	#endif

	BFD_RELOC_UNUSED
end enum

const BFD_RELOC_SPARC_64 = BFD_RELOC_64
const BFD_RELOC_SPARC_DISP64 = BFD_RELOC_64_PCREL
type bfd_reloc_code_real_type as bfd_reloc_code_real
declare function bfd_reloc_type_lookup(byval abfd as bfd ptr, byval code as bfd_reloc_code_real_type) as reloc_howto_type ptr

#if __BFD_VER__ >= 218
	declare function bfd_reloc_name_lookup(byval abfd as bfd ptr, byval reloc_name as const zstring ptr) as reloc_howto_type ptr
#endif

declare function bfd_get_reloc_code_name(byval code as bfd_reloc_code_real_type) as const zstring ptr

union bfd_symbol_udata
	p as any ptr
	i as bfd_vma
end union

type bfd_symbol_
	the_bfd as bfd ptr
	name as const zstring ptr
	value as symvalue
	flags as flagword
	section as bfd_section ptr
	udata as bfd_symbol_udata
end type

type asymbol as bfd_symbol
const BSF_NO_FLAGS = &h00

#if __BFD_VER__ <= 219
	const BSF_LOCAL = &h01
	const BSF_GLOBAL = &h02
#else
	const BSF_LOCAL = 1 shl 0
	const BSF_GLOBAL = 1 shl 1
#endif

const BSF_EXPORT = BSF_GLOBAL

#if __BFD_VER__ <= 219
	const BSF_DEBUGGING = &h08
	const BSF_FUNCTION = &h10
	const BSF_KEEP = &h20
	const BSF_KEEP_G = &h40
	const BSF_WEAK = &h80
	const BSF_SECTION_SYM = &h100
	const BSF_OLD_COMMON = &h200
	const BFD_FORT_COMM_DEFAULT_VALUE = 0
	const BSF_NOT_AT_END = &h400
	const BSF_CONSTRUCTOR = &h800
	const BSF_WARNING = &h1000
	const BSF_INDIRECT = &h2000
	const BSF_FILE = &h4000
	const BSF_DYNAMIC = &h8000
	const BSF_OBJECT = &h10000
	const BSF_DEBUGGING_RELOC = &h20000
	const BSF_THREAD_LOCAL = &h40000
#endif

#if (__BFD_VER__ = 218) or (__BFD_VER__ = 219)
	const BSF_RELC = &h80000
	const BSF_SRELC = &h100000
#endif

#if __BFD_VER__ = 219
	const BSF_SYNTHETIC = &h200000
#elseif __BFD_VER__ >= 220
	const BSF_DEBUGGING = 1 shl 2
	const BSF_FUNCTION = 1 shl 3
	const BSF_KEEP = 1 shl 5
	const BSF_KEEP_G = 1 shl 6
	const BSF_WEAK = 1 shl 7
	const BSF_SECTION_SYM = 1 shl 8
	const BSF_OLD_COMMON = 1 shl 9
	const BSF_NOT_AT_END = 1 shl 10
	const BSF_CONSTRUCTOR = 1 shl 11
	const BSF_WARNING = 1 shl 12
	const BSF_INDIRECT = 1 shl 13
	const BSF_FILE = 1 shl 14
	const BSF_DYNAMIC = 1 shl 15
	const BSF_OBJECT = 1 shl 16
	const BSF_DEBUGGING_RELOC = 1 shl 17
	const BSF_THREAD_LOCAL = 1 shl 18
	const BSF_RELC = 1 shl 19
	const BSF_SRELC = 1 shl 20
	const BSF_SYNTHETIC = 1 shl 21
	const BSF_GNU_INDIRECT_FUNCTION = 1 shl 22
	const BSF_GNU_UNIQUE = 1 shl 23
#endif

#define bfd_get_symtab_upper_bound(abfd) BFD_SEND(abfd, _bfd_get_symtab_upper_bound, (abfd))
declare function bfd_is_local_label(byval abfd as bfd ptr, byval sym as asymbol ptr) as bfd_boolean
declare function bfd_is_local_label_name_ alias "bfd_is_local_label_name"(byval abfd as bfd ptr, byval name as const zstring ptr) as bfd_boolean
#define bfd_is_local_label_name(abfd, name) BFD_SEND (abfd, _bfd_is_local_label_name, (abfd, name))
declare function bfd_is_target_special_symbol_ alias "bfd_is_target_special_symbol"(byval abfd as bfd ptr, byval sym as asymbol ptr) as bfd_boolean
#define bfd_is_target_special_symbol(abfd, sym) BFD_SEND (abfd, _bfd_is_target_special_symbol, (abfd, sym))
#define bfd_canonicalize_symtab(abfd, location) BFD_SEND (abfd, _bfd_canonicalize_symtab, (abfd, location))
declare function bfd_set_symtab(byval abfd as bfd ptr, byval location as asymbol ptr ptr, byval count as ulong) as bfd_boolean
declare sub bfd_print_symbol_vandf(byval abfd as bfd ptr, byval file as any ptr, byval symbol as asymbol ptr)
#define bfd_make_empty_symbol(abfd) BFD_SEND(abfd, _bfd_make_empty_symbol, (abfd))
declare function _bfd_generic_make_empty_symbol(byval as bfd ptr) as asymbol ptr
#define bfd_make_debug_symbol(abfd, ptr_, size) BFD_SEND (abfd, _bfd_make_debug_symbol, (abfd, ptr, size))
declare function bfd_decode_symclass(byval symbol as asymbol ptr) as long
declare function bfd_is_undefined_symclass(byval symclass as long) as bfd_boolean
declare sub bfd_symbol_info(byval symbol as asymbol ptr, byval ret as symbol_info ptr)
declare function bfd_copy_private_symbol_data_ alias "bfd_copy_private_symbol_data"(byval ibfd as bfd ptr, byval isym as asymbol ptr, byval obfd as bfd ptr, byval osym as asymbol ptr) as bfd_boolean
#define bfd_copy_private_symbol_data(ibfd, isymbol, obfd, osymbol) BFD_SEND (obfd, _bfd_copy_private_symbol_data, (ibfd, isymbol, obfd, osymbol))

type bfd_direction as long
enum
	no_direction = 0
	read_direction = 1
	write_direction = 2
	both_direction = 3
end enum

#if __BFD_VER__ = 225
	type bfd_link_hash_table as bfd_link_hash_table_

	union bfd_link
		next as bfd ptr
		hash as bfd_link_hash_table ptr
	end union
#endif

type aout_data_struct as aout_data_struct_
type artdata as artdata_
type _oasys_data as _oasys_data_
type _oasys_ar_data as _oasys_ar_data_
type coff_tdata as coff_tdata_
type pe_tdata as pe_tdata_
type xcoff_tdata as xcoff_tdata_
type ecoff_tdata as ecoff_tdata_
type ieee_data_struct as ieee_data_struct_
type ieee_ar_data_struct as ieee_ar_data_struct_
type srec_data_struct as srec_data_struct_

#if __BFD_VER__ >= 220
	type verilog_data_struct as verilog_data_struct_
#endif

type ihex_data_struct as ihex_data_struct_
type tekhex_data_struct as tekhex_data_struct_
type elf_obj_tdata as elf_obj_tdata_
type nlm_obj_tdata as nlm_obj_tdata_
type bout_data_struct as bout_data_struct_
type mmo_data_struct as mmo_data_struct_
type sun_core_struct as sun_core_struct_
type sco5_core_struct as sco5_core_struct_
type trad_core_struct as trad_core_struct_
type som_data_struct as som_data_struct_
type hpux_core_struct as hpux_core_struct_
type hppabsd_core_struct as hppabsd_core_struct_
type sgi_core_struct as sgi_core_struct_
type lynx_core_struct as lynx_core_struct_
type osf_core_struct as osf_core_struct_
type cisco_core_struct as cisco_core_struct_
type versados_data_struct as versados_data_struct_
type netbsd_core_struct as netbsd_core_struct_
type mach_o_data_struct as mach_o_data_struct_
type mach_o_fat_data_struct as mach_o_fat_data_struct_

#if __BFD_VER__ >= 220
	type plugin_data_struct as plugin_data_struct_
#endif

type bfd_pef_data_struct as bfd_pef_data_struct_
type bfd_pef_xlib_data_struct as bfd_pef_xlib_data_struct_
type bfd_sym_data_struct as bfd_sym_data_struct_

union bfd_tdata
	aout_data as aout_data_struct ptr
	aout_ar_data as artdata ptr
	oasys_obj_data as _oasys_data ptr
	oasys_ar_data as _oasys_ar_data ptr
	coff_obj_data as coff_tdata ptr
	pe_obj_data as pe_tdata ptr
	xcoff_obj_data as xcoff_tdata ptr
	ecoff_obj_data as ecoff_tdata ptr
	ieee_data as ieee_data_struct ptr
	ieee_ar_data as ieee_ar_data_struct ptr
	srec_data as srec_data_struct ptr

	#if __BFD_VER__ >= 220
		verilog_data as verilog_data_struct ptr
	#endif

	ihex_data as ihex_data_struct ptr
	tekhex_data as tekhex_data_struct ptr
	elf_obj_data as elf_obj_tdata ptr
	nlm_obj_data as nlm_obj_tdata ptr
	bout_data as bout_data_struct ptr
	mmo_data as mmo_data_struct ptr
	sun_core_data as sun_core_struct ptr
	sco5_core_data as sco5_core_struct ptr
	trad_core_data as trad_core_struct ptr
	som_data as som_data_struct ptr
	hpux_core_data as hpux_core_struct ptr
	hppabsd_core_data as hppabsd_core_struct ptr
	sgi_core_data as sgi_core_struct ptr
	lynx_core_data as lynx_core_struct ptr
	osf_core_data as osf_core_struct ptr
	cisco_core_data as cisco_core_struct ptr
	versados_data as versados_data_struct ptr
	netbsd_core_data as netbsd_core_struct ptr
	mach_o_data as mach_o_data_struct ptr
	mach_o_fat_data as mach_o_fat_data_struct ptr

	#if __BFD_VER__ >= 220
		plugin_data as plugin_data_struct ptr
	#endif

	pef_data as bfd_pef_data_struct ptr
	pef_xlib_data as bfd_pef_xlib_data_struct ptr
	sym_data as bfd_sym_data_struct ptr
	any as any ptr
end union

type bfd_target as bfd_target_
type bfd_iovec as bfd_iovec_

type bfd_
	#if __BFD_VER__ <= 224
		id as ulong
	#endif

	filename as const zstring ptr
	xvec as const bfd_target ptr
	iostream as any ptr
	iovec as const bfd_iovec ptr

	#if __BFD_VER__ <= 218
		cacheable as bfd_boolean
		target_defaulted as bfd_boolean
	#endif

	lru_prev as bfd ptr
	lru_next as bfd ptr
	where as ufile_ptr

	#if __BFD_VER__ <= 218
		opened_once as bfd_boolean
		mtime_set as bfd_boolean
	#endif

	mtime as clong

	#if __BFD_VER__ <= 224
		ifd as long
		format as bfd_format
		direction as bfd_direction
		flags as flagword
		origin as ufile_ptr
	#endif

	#if __BFD_VER__ <= 218
		output_has_begun as bfd_boolean
	#elseif (__BFD_VER__ >= 219) and (__BFD_VER__ <= 224)
		proxy_origin as ufile_ptr
	#endif

	#if __BFD_VER__ <= 224
		section_htab as bfd_hash_table
		sections as bfd_section ptr
	#endif

	#if __BFD_VER__ = 216
		section_tail as bfd_section ptr ptr
	#elseif (__BFD_VER__ >= 217) and (__BFD_VER__ <= 224)
		section_last as bfd_section ptr
	#endif

	#if __BFD_VER__ <= 224
		section_count as ulong
		start_address as bfd_vma
		symcount as ulong
		outsymbols as bfd_symbol ptr ptr
		dynsymcount as ulong
		arch_info as const bfd_arch_info ptr
	#endif

	#if __BFD_VER__ <= 218
		no_export as bfd_boolean
	#endif

	#if __BFD_VER__ <= 224
		arelt_data as any ptr
		my_archive as bfd ptr
	#endif

	#if __BFD_VER__ <= 217
		next as bfd ptr
	#elseif (__BFD_VER__ >= 218) and (__BFD_VER__ <= 224)
		archive_next as bfd ptr
	#endif

	#if __BFD_VER__ <= 224
		archive_head as bfd ptr
	#endif

	#if __BFD_VER__ <= 218
		has_armap as bfd_boolean
	#elseif (__BFD_VER__ >= 219) and (__BFD_VER__ <= 224)
		nested_archives as bfd ptr
	#endif

	#if __BFD_VER__ = 225
		id as ulong
		format : 3 as bfd_format
		direction : 2 as bfd_direction
		flags : 17 as flagword
	#else
		link_next as bfd ptr
		archive_pass as long
		tdata as bfd_tdata
		usrdata as any ptr
		memory as any ptr
	#endif

	#if __BFD_VER__ >= 219
		cacheable : 1 as ulong
		target_defaulted : 1 as ulong
		opened_once : 1 as ulong
		mtime_set : 1 as ulong
		no_export : 1 as ulong
		output_has_begun : 1 as ulong
		has_armap : 1 as ulong
		is_thin_archive : 1 as ulong
	#endif

	#if __BFD_VER__ >= 221
		selective_search : 1 as ulong
	#endif

	#if __BFD_VER__ = 225
		is_linker_output : 1 as ulong
		origin as ufile_ptr
		proxy_origin as ufile_ptr
		section_htab as bfd_hash_table
		sections as bfd_section ptr
		section_last as bfd_section ptr
		section_count as ulong
		archive_pass as long
		start_address as bfd_vma
		outsymbols as bfd_symbol ptr ptr
		symcount as ulong
		dynsymcount as ulong
		arch_info as const bfd_arch_info ptr
		arelt_data as any ptr
		my_archive as bfd ptr
		archive_next as bfd ptr
		archive_head as bfd ptr
		nested_archives as bfd ptr
		link as bfd_link
		tdata as bfd_tdata
		usrdata as any ptr
		memory as any ptr
	#endif
end type

#if __BFD_VER__ >= 219
	const BFD_NO_FLAGS = &h00
	const HAS_RELOC = &h01
	const EXEC_P = &h02
	const HAS_LINENO = &h04
	const HAS_DEBUG = &h08
	const HAS_SYMS = &h10
	const HAS_LOCALS = &h20
	const DYNAMIC_ = &h40
	const WP_TEXT = &h80
	const D_PAGED = &h100
	const BFD_IS_RELAXABLE = &h200
	const BFD_TRADITIONAL_FORMAT = &h400
	const BFD_IN_MEMORY = &h800
#endif

#if (__BFD_VER__ >= 219) and (__BFD_VER__ <= 224)
	const HAS_LOAD_PAGE = &h1000
	const BFD_LINKER_CREATED = &h2000
#endif

#if (__BFD_VER__ >= 220) and (__BFD_VER__ <= 224)
	const BFD_DETERMINISTIC_OUTPUT = &h4000
#endif

#if (__BFD_VER__ >= 221) and (__BFD_VER__ <= 224)
	const BFD_COMPRESS = &h8000
	const BFD_DECOMPRESS = &h10000
	const BFD_PLUGIN = &h20000
#elseif __BFD_VER__ = 225
	const BFD_LINKER_CREATED = &h1000
	const BFD_DETERMINISTIC_OUTPUT = &h2000
	const BFD_COMPRESS = &h4000
	const BFD_DECOMPRESS = &h8000
	const BFD_PLUGIN = &h10000
#endif

#if __BFD_VER__ >= 221
	const BFD_FLAGS_SAVED = ((BFD_IN_MEMORY or BFD_COMPRESS) or BFD_DECOMPRESS) or BFD_PLUGIN
	const BFD_FLAGS_FOR_BFD_USE_MASK = (((((BFD_IN_MEMORY or BFD_COMPRESS) or BFD_DECOMPRESS) or BFD_LINKER_CREATED) or BFD_PLUGIN) or BFD_TRADITIONAL_FORMAT) or BFD_DETERMINISTIC_OUTPUT
#endif

#if __BFD_VER__ = 225
	private function bfd_set_cacheable(byval abfd as bfd ptr, byval val_ as bfd_boolean) as bfd_boolean
		abfd->cacheable = val_
		return 1
	end function
#endif

type bfd_error as long
enum
	bfd_error_no_error = 0
	bfd_error_system_call
	bfd_error_invalid_target
	bfd_error_wrong_format
	bfd_error_wrong_object_format
	bfd_error_invalid_operation
	bfd_error_no_memory
	bfd_error_no_symbols
	bfd_error_no_armap
	bfd_error_no_more_archived_files
	bfd_error_malformed_archive

	#if __BFD_VER__ >= 224
		bfd_error_missing_dso
	#endif

	bfd_error_file_not_recognized
	bfd_error_file_ambiguously_recognized
	bfd_error_no_contents
	bfd_error_nonrepresentable_section
	bfd_error_no_debug_section
	bfd_error_bad_value
	bfd_error_file_truncated
	bfd_error_file_too_big

	#if __BFD_VER__ >= 218
		bfd_error_on_input
	#endif

	bfd_error_invalid_error_code
end enum

type bfd_error_type as bfd_error
declare function bfd_get_error() as bfd_error_type

#if __BFD_VER__ <= 217
	declare sub bfd_set_error(byval error_tag as bfd_error_type)
#else
	declare sub bfd_set_error(byval error_tag as bfd_error_type, ...)
#endif

declare function bfd_errmsg(byval error_tag as bfd_error_type) as const zstring ptr
declare sub bfd_perror(byval message as const zstring ptr)
type bfd_error_handler_type as sub(byval as const zstring ptr, ...)
declare function bfd_set_error_handler(byval as bfd_error_handler_type) as bfd_error_handler_type
declare sub bfd_set_error_program_name(byval as const zstring ptr)
declare function bfd_get_error_handler() as bfd_error_handler_type

#if __BFD_VER__ >= 223
	type bfd_assert_handler_type as sub(byval bfd_formatmsg as const zstring ptr, byval bfd_version as const zstring ptr, byval bfd_file as const zstring ptr, byval bfd_line as long)
	declare function bfd_set_assert_handler(byval as bfd_assert_handler_type) as bfd_assert_handler_type
	declare function bfd_get_assert_handler() as bfd_assert_handler_type
#endif

declare function bfd_get_reloc_upper_bound(byval abfd as bfd ptr, byval sect as asection ptr) as clong
declare function bfd_canonicalize_reloc(byval abfd as bfd ptr, byval sec as asection ptr, byval loc as arelent ptr ptr, byval syms as asymbol ptr ptr) as clong
declare sub bfd_set_reloc(byval abfd as bfd ptr, byval sec as asection ptr, byval rel as arelent ptr ptr, byval count as ulong)
declare function bfd_set_file_flags(byval abfd as bfd ptr, byval flags as flagword) as bfd_boolean
declare function bfd_get_arch_size(byval abfd as bfd ptr) as long
declare function bfd_get_sign_extend_vma(byval abfd as bfd ptr) as long
declare function bfd_set_start_address(byval abfd as bfd ptr, byval vma as bfd_vma) as bfd_boolean
declare function bfd_get_gp_size(byval abfd as bfd ptr) as ulong
declare sub bfd_set_gp_size(byval abfd as bfd ptr, byval i as ulong)
declare function bfd_scan_vma(byval string as const zstring ptr, byval end as const zstring ptr ptr, byval base as long) as bfd_vma
declare function bfd_copy_private_header_data_ alias "bfd_copy_private_header_data"(byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
#define bfd_copy_private_header_data(ibfd, obfd) BFD_SEND (obfd, _bfd_copy_private_header_data, (ibfd, obfd))
declare function bfd_copy_private_bfd_data_ alias "bfd_copy_private_bfd_data"(byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
#define bfd_copy_private_bfd_data(ibfd, obfd) BFD_SEND (obfd, _bfd_copy_private_bfd_data, (ibfd, obfd))
declare function bfd_merge_private_bfd_data_ alias "bfd_merge_private_bfd_data"(byval ibfd as bfd ptr, byval obfd as bfd ptr) as bfd_boolean
#define bfd_merge_private_bfd_data(ibfd, obfd) BFD_SEND (obfd, _bfd_merge_private_bfd_data, (ibfd, obfd))
declare function bfd_set_private_flags_ alias "bfd_set_private_flags"(byval abfd as bfd ptr, byval flags as flagword) as bfd_boolean
#define bfd_set_private_flags(abfd, flags) BFD_SEND (abfd, _bfd_set_private_flags, (abfd, flags))

#if __BFD_VER__ <= 217
	#define bfd_sizeof_headers(abfd, reloc) BFD_SEND (abfd, _bfd_sizeof_headers, (abfd, reloc))
#else
	#define bfd_sizeof_headers(abfd, info) BFD_SEND (abfd, _bfd_sizeof_headers, (abfd, info))
#endif

#if __BFD_VER__ <= 224
	#define bfd_find_nearest_line(abfd, sec, syms, off, file, func, line) BFD_SEND (abfd, _bfd_find_nearest_line, (abfd, sec, syms, off, file, func, line))
#endif

#if (__BFD_VER__ = 223) or (__BFD_VER__ = 224)
	#define bfd_find_nearest_line_discriminator(abfd, sec, syms, off, file, func, line, disc) BFD_SEND (abfd, _bfd_find_nearest_line_discriminator, (abfd, sec, syms, off, file, func, line, disc))
#elseif __BFD_VER__ = 225
	#define bfd_find_nearest_line(abfd, sec, syms, off, file, func, line) BFD_SEND (abfd, _bfd_find_nearest_line, (abfd, syms, sec, off, file, func, line, NULL))
	#define bfd_find_nearest_line_discriminator(abfd, sec, syms, off, file, func, line, disc) BFD_SEND (abfd, _bfd_find_nearest_line, (abfd, syms, sec, off, file, func, line, disc))
#endif

#if __BFD_VER__ >= 217
	#define bfd_find_line(abfd, syms, sym, file, line) BFD_SEND (abfd, _bfd_find_line, (abfd, syms, sym, file, line))
	#define bfd_find_inliner_info(abfd, file, func, line) BFD_SEND (abfd, _bfd_find_inliner_info, (abfd, file, func, line))
#endif

#define bfd_debug_info_start(abfd) BFD_SEND(abfd, _bfd_debug_info_start, (abfd))
#define bfd_debug_info_end(abfd) BFD_SEND(abfd, _bfd_debug_info_end, (abfd))
#define bfd_debug_info_accumulate(abfd, section) BFD_SEND (abfd, _bfd_debug_info_accumulate, (abfd, section))
#define bfd_stat_arch_elt(abfd, stat) BFD_SEND (abfd, _bfd_stat_arch_elt, (abfd, stat))
#define bfd_update_armap_timestamp(abfd) BFD_SEND(abfd, _bfd_update_armap_timestamp, (abfd))
#define bfd_set_arch_mach(abfd, arch, mach) BFD_SEND (abfd, _bfd_set_arch_mach, (abfd, arch, mach))
#define bfd_relax_section(abfd, section, link_info, again) BFD_SEND (abfd, _bfd_relax_section, (abfd, section, link_info, again))
#define bfd_gc_sections(abfd, link_info) BFD_SEND (abfd, _bfd_gc_sections, (abfd, link_info))

#if __BFD_VER__ = 222
	#define bfd_lookup_section_flags(link_info, flag_info) BFD_SEND (abfd, _bfd_lookup_section_flags, (link_info, flag_info))
#elseif __BFD_VER__ >= 223
	#define bfd_lookup_section_flags(link_info, flag_info, section) BFD_SEND (abfd, _bfd_lookup_section_flags, (link_info, flag_info, section))
#endif

#define bfd_merge_sections(abfd, link_info) BFD_SEND (abfd, _bfd_merge_sections, (abfd, link_info))
#define bfd_is_group_section(abfd, sec) BFD_SEND (abfd, _bfd_is_group_section, (abfd, sec))
#define bfd_discard_group(abfd, sec) BFD_SEND (abfd, _bfd_discard_group, (abfd, sec))
#define bfd_link_hash_table_create(abfd) BFD_SEND(abfd, _bfd_link_hash_table_create, (abfd))

#if __BFD_VER__ <= 224
	#define bfd_link_hash_table_free(abfd, hash) BFD_SEND(abfd, _bfd_link_hash_table_free, (hash))
#endif

#define bfd_link_add_symbols(abfd, info) BFD_SEND (abfd, _bfd_link_add_symbols, (abfd, info))
#define bfd_link_just_syms(abfd, sec, info) BFD_SEND (abfd, _bfd_link_just_syms, (sec, info))
#define bfd_final_link(abfd, info) BFD_SEND (abfd, _bfd_final_link, (abfd, info))
#define bfd_free_cached_info(abfd) BFD_SEND(abfd, _bfd_free_cached_info, (abfd))
#define bfd_get_dynamic_symtab_upper_bound(abfd) BFD_SEND(abfd, _bfd_get_dynamic_symtab_upper_bound, (abfd))
#define bfd_print_private_bfd_data(abfd, file) BFD_SEND (abfd, _bfd_print_private_bfd_data, (abfd, file))
#define bfd_canonicalize_dynamic_symtab(abfd, asymbols) BFD_SEND (abfd, _bfd_canonicalize_dynamic_symtab, (abfd, asymbols))
#define bfd_get_synthetic_symtab(abfd, count, syms, dyncount, dynsyms, ret) BFD_SEND (abfd, _bfd_get_synthetic_symtab, (abfd, count, syms, dyncount, dynsyms, ret))
#define bfd_get_dynamic_reloc_upper_bound(abfd) BFD_SEND(abfd, _bfd_get_dynamic_reloc_upper_bound, (abfd))
#define bfd_canonicalize_dynamic_reloc(abfd, arels, asyms) BFD_SEND (abfd, _bfd_canonicalize_dynamic_reloc, (abfd, arels, asyms))
declare function bfd_get_relocated_section_contents(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_order ptr, byval as bfd_byte ptr, byval as bfd_boolean, byval as asymbol ptr ptr) as bfd_byte ptr
declare function bfd_alt_mach_code(byval abfd as bfd ptr, byval alternative as long) as bfd_boolean

#if __BFD_VER__ <= 223
	type bfd_preserve
		marker as any ptr
		tdata as any ptr
		flags as flagword
		arch_info as const bfd_arch_info ptr
		sections as bfd_section ptr

		#if __BFD_VER__ = 216
			section_tail as bfd_section ptr ptr
		#elseif (__BFD_VER__ >= 217) and (__BFD_VER__ <= 223)
			section_last as bfd_section ptr
		#endif

		section_count as ulong
		section_htab as bfd_hash_table
	end type

	declare function bfd_preserve_save(byval as bfd ptr, byval as bfd_preserve ptr) as bfd_boolean
	declare sub bfd_preserve_restore(byval as bfd ptr, byval as bfd_preserve ptr)
	declare sub bfd_preserve_finish(byval as bfd ptr, byval as bfd_preserve ptr)
#endif

#if __BFD_VER__ >= 218
	declare function bfd_emul_get_maxpagesize(byval as const zstring ptr) as bfd_vma
	declare sub bfd_emul_set_maxpagesize(byval as const zstring ptr, byval as bfd_vma)
	declare function bfd_emul_get_commonpagesize(byval as const zstring ptr) as bfd_vma
	declare sub bfd_emul_set_commonpagesize(byval as const zstring ptr, byval as bfd_vma)
	declare function bfd_demangle(byval as bfd ptr, byval as const zstring ptr, byval as long) as zstring ptr
#endif

declare function bfd_get_next_mapent(byval abfd as bfd ptr, byval previous as symindex, byval sym as carsym ptr ptr) as symindex
declare function bfd_set_archive_head(byval output as bfd ptr, byval new_head as bfd ptr) as bfd_boolean
declare function bfd_openr_next_archived_file(byval archive as bfd ptr, byval previous as bfd ptr) as bfd ptr
declare function bfd_core_file_failing_command(byval abfd as bfd ptr) as const zstring ptr
declare function bfd_core_file_failing_signal(byval abfd as bfd ptr) as long

#if __BFD_VER__ >= 221
	declare function bfd_core_file_pid(byval abfd as bfd ptr) as long
#endif

declare function core_file_matches_executable_p(byval core_bfd as bfd ptr, byval exec_bfd as bfd ptr) as bfd_boolean

#if __BFD_VER__ >= 217
	declare function generic_core_file_matches_executable_p(byval core_bfd as bfd ptr, byval exec_bfd as bfd ptr) as bfd_boolean
#endif

#define BFD_SEND(bfd, message, arglist) ((* ((bfd)-> xvec -> message))arglist)
#define BFD_SEND_FMT(bfd, message, arglist) (((bfd)->xvec->message[  clng((bfd)->format)]) arglist)

type bfd_flavour as long
enum
	bfd_target_unknown_flavour
	bfd_target_aout_flavour
	bfd_target_coff_flavour
	bfd_target_ecoff_flavour
	bfd_target_xcoff_flavour
	bfd_target_elf_flavour
	bfd_target_ieee_flavour
	bfd_target_nlm_flavour
	bfd_target_oasys_flavour
	bfd_target_tekhex_flavour
	bfd_target_srec_flavour

	#if __BFD_VER__ >= 220
		bfd_target_verilog_flavour
	#endif

	bfd_target_ihex_flavour
	bfd_target_som_flavour
	bfd_target_os9k_flavour
	bfd_target_versados_flavour
	bfd_target_msdos_flavour
	bfd_target_ovax_flavour
	bfd_target_evax_flavour
	bfd_target_mmo_flavour
	bfd_target_mach_o_flavour
	bfd_target_pef_flavour
	bfd_target_pef_xlib_flavour
	bfd_target_sym_flavour
end enum

type bfd_endian as long
enum
	BFD_ENDIAN_BIG
	BFD_ENDIAN_LITTLE
	BFD_ENDIAN_UNKNOWN
end enum

type _bfd_link_info as bfd_link_info

#if __BFD_VER__ <= 224
	type bfd_link_hash_table as bfd_link_hash_table_
#endif

#if __BFD_VER__ >= 223
	type flag_info as flag_info_
#endif

type bfd_target_
	name as zstring ptr
	flavour as bfd_flavour
	byteorder as bfd_endian
	header_byteorder as bfd_endian
	object_flags as flagword
	section_flags as flagword
	symbol_leading_char as byte
	ar_pad_char as byte

	#if __BFD_VER__ <= 221
		ar_max_namelen as ushort
	#else
		ar_max_namelen as ubyte
		match_priority as ubyte
	#endif

	bfd_getx64 as function(byval as const any ptr) as bfd_uint64_t
	bfd_getx_signed_64 as function(byval as const any ptr) as bfd_int64_t
	bfd_putx64 as sub(byval as bfd_uint64_t, byval as any ptr)
	bfd_getx32 as function(byval as const any ptr) as bfd_vma
	bfd_getx_signed_32 as function(byval as const any ptr) as bfd_signed_vma
	bfd_putx32 as sub(byval as bfd_vma, byval as any ptr)
	bfd_getx16 as function(byval as const any ptr) as bfd_vma
	bfd_getx_signed_16 as function(byval as const any ptr) as bfd_signed_vma
	bfd_putx16 as sub(byval as bfd_vma, byval as any ptr)
	bfd_h_getx64 as function(byval as const any ptr) as bfd_uint64_t
	bfd_h_getx_signed_64 as function(byval as const any ptr) as bfd_int64_t
	bfd_h_putx64 as sub(byval as bfd_uint64_t, byval as any ptr)
	bfd_h_getx32 as function(byval as const any ptr) as bfd_vma
	bfd_h_getx_signed_32 as function(byval as const any ptr) as bfd_signed_vma
	bfd_h_putx32 as sub(byval as bfd_vma, byval as any ptr)
	bfd_h_getx16 as function(byval as const any ptr) as bfd_vma
	bfd_h_getx_signed_16 as function(byval as const any ptr) as bfd_signed_vma
	bfd_h_putx16 as sub(byval as bfd_vma, byval as any ptr)
	_bfd_check_format(0 to bfd_type_end - 1) as function(byval as bfd ptr) as const bfd_target ptr
	_bfd_set_format(0 to bfd_type_end - 1) as function(byval as bfd ptr) as bfd_boolean
	_bfd_write_contents(0 to bfd_type_end - 1) as function(byval as bfd ptr) as bfd_boolean
	_close_and_cleanup as function(byval as bfd ptr) as bfd_boolean
	_bfd_free_cached_info as function(byval as bfd ptr) as bfd_boolean
	_new_section_hook as function(byval as bfd ptr, byval as sec_ptr) as bfd_boolean
	_bfd_get_section_contents as function(byval as bfd ptr, byval as sec_ptr, byval as any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
	_bfd_get_section_contents_in_window as function(byval as bfd ptr, byval as sec_ptr, byval as bfd_window ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean
	_bfd_copy_private_bfd_data as function(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_merge_private_bfd_data as function(byval as bfd ptr, byval as bfd ptr) as bfd_boolean

	#if __BFD_VER__ >= 217
		_bfd_init_private_section_data as function(byval as bfd ptr, byval as sec_ptr, byval as bfd ptr, byval as sec_ptr, byval as bfd_link_info ptr) as bfd_boolean
	#endif

	_bfd_copy_private_section_data as function(byval as bfd ptr, byval as sec_ptr, byval as bfd ptr, byval as sec_ptr) as bfd_boolean
	_bfd_copy_private_symbol_data as function(byval as bfd ptr, byval as asymbol ptr, byval as bfd ptr, byval as asymbol ptr) as bfd_boolean
	_bfd_copy_private_header_data as function(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	_bfd_set_private_flags as function(byval as bfd ptr, byval as flagword) as bfd_boolean
	_bfd_print_private_bfd_data as function(byval as bfd ptr, byval as any ptr) as bfd_boolean
	_core_file_failing_command as function(byval as bfd ptr) as zstring ptr
	_core_file_failing_signal as function(byval as bfd ptr) as long
	_core_file_matches_executable_p as function(byval as bfd ptr, byval as bfd ptr) as bfd_boolean

	#if __BFD_VER__ >= 221
		_core_file_pid as function(byval as bfd ptr) as long
	#endif

	_bfd_slurp_armap as function(byval as bfd ptr) as bfd_boolean
	_bfd_slurp_extended_name_table as function(byval as bfd ptr) as bfd_boolean
	_bfd_construct_extended_name_table as function(byval as bfd ptr, byval as zstring ptr ptr, byval as bfd_size_type ptr, byval as const zstring ptr ptr) as bfd_boolean
	_bfd_truncate_arname as sub(byval as bfd ptr, byval as const zstring ptr, byval as zstring ptr)
	write_armap as function(byval as bfd ptr, byval as ulong, byval as orl ptr, byval as ulong, byval as long) as bfd_boolean
	_bfd_read_ar_hdr_fn as function(byval as bfd ptr) as any ptr

	#if __BFD_VER__ >= 221
		_bfd_write_ar_hdr_fn as function(byval as bfd ptr, byval as bfd ptr) as bfd_boolean
	#endif

	openr_next_archived_file as function(byval as bfd ptr, byval as bfd ptr) as bfd ptr
	_bfd_get_elt_at_index as function(byval as bfd ptr, byval as symindex) as bfd ptr
	_bfd_stat_arch_elt as function(byval as bfd ptr, byval as stat ptr) as long
	_bfd_update_armap_timestamp as function(byval as bfd ptr) as bfd_boolean
	_bfd_get_symtab_upper_bound as function(byval as bfd ptr) as clong
	_bfd_canonicalize_symtab as function(byval as bfd ptr, byval as bfd_symbol ptr ptr) as clong
	_bfd_make_empty_symbol as function(byval as bfd ptr) as bfd_symbol ptr
	_bfd_print_symbol as sub(byval as bfd ptr, byval as any ptr, byval as bfd_symbol ptr, byval as bfd_print_symbol_type)
	_bfd_get_symbol_info as sub(byval as bfd ptr, byval as bfd_symbol ptr, byval as symbol_info ptr)
	_bfd_is_local_label_name as function(byval as bfd ptr, byval as const zstring ptr) as bfd_boolean
	_bfd_is_target_special_symbol as function(byval as bfd ptr, byval as asymbol ptr) as bfd_boolean
	_get_lineno as function(byval as bfd ptr, byval as bfd_symbol ptr) as alent ptr

	#if __BFD_VER__ <= 224
		_bfd_find_nearest_line as function(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_symbol ptr ptr, byval as bfd_vma, byval as const zstring ptr ptr, byval as const zstring ptr ptr, byval as ulong ptr) as bfd_boolean
	#endif

	#if (__BFD_VER__ = 223) or (__BFD_VER__ = 224)
		_bfd_find_nearest_line_discriminator as function(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_symbol ptr ptr, byval as bfd_vma, byval as const zstring ptr ptr, byval as const zstring ptr ptr, byval as ulong ptr, byval as ulong ptr) as bfd_boolean
	#elseif __BFD_VER__ = 225
		_bfd_find_nearest_line as function(byval as bfd ptr, byval as bfd_symbol ptr ptr, byval as bfd_section ptr, byval as bfd_vma, byval as const zstring ptr ptr, byval as const zstring ptr ptr, byval as ulong ptr, byval as ulong ptr) as bfd_boolean
	#endif

	#if __BFD_VER__ >= 217
		_bfd_find_line as function(byval as bfd ptr, byval as bfd_symbol ptr ptr, byval as bfd_symbol ptr, byval as const zstring ptr ptr, byval as ulong ptr) as bfd_boolean
		_bfd_find_inliner_info as function(byval as bfd ptr, byval as const zstring ptr ptr, byval as const zstring ptr ptr, byval as ulong ptr) as bfd_boolean
	#endif

	_bfd_make_debug_symbol as function(byval as bfd ptr, byval as any ptr, byval size as culong) as asymbol ptr
	_read_minisymbols as function(byval as bfd ptr, byval as bfd_boolean, byval as any ptr ptr, byval as ulong ptr) as clong
	_minisymbol_to_symbol as function(byval as bfd ptr, byval as bfd_boolean, byval as const any ptr, byval as asymbol ptr) as asymbol ptr
	_get_reloc_upper_bound as function(byval as bfd ptr, byval as sec_ptr) as clong
	_bfd_canonicalize_reloc as function(byval as bfd ptr, byval as sec_ptr, byval as arelent ptr ptr, byval as bfd_symbol ptr ptr) as clong
	reloc_type_lookup as function(byval as bfd ptr, byval as bfd_reloc_code_real_type) as reloc_howto_type ptr

	#if __BFD_VER__ >= 218
		reloc_name_lookup as function(byval as bfd ptr, byval as const zstring ptr) as reloc_howto_type ptr
	#endif

	_bfd_set_arch_mach as function(byval as bfd ptr, byval as bfd_architecture, byval as culong) as bfd_boolean
	_bfd_set_section_contents as function(byval as bfd ptr, byval as sec_ptr, byval as const any ptr, byval as file_ptr, byval as bfd_size_type) as bfd_boolean

	#if __BFD_VER__ <= 217
		_bfd_sizeof_headers as function(byval as bfd ptr, byval as bfd_boolean) as long
	#else
		_bfd_sizeof_headers as function(byval as bfd ptr, byval as bfd_link_info ptr) as long
	#endif

	_bfd_get_relocated_section_contents as function(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_order ptr, byval as bfd_byte ptr, byval as bfd_boolean, byval as bfd_symbol ptr ptr) as bfd_byte ptr
	_bfd_relax_section as function(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_link_info ptr, byval as bfd_boolean ptr) as bfd_boolean
	_bfd_link_hash_table_create as function(byval as bfd ptr) as bfd_link_hash_table ptr

	#if __BFD_VER__ <= 224
		_bfd_link_hash_table_free as sub(byval as bfd_link_hash_table ptr)
	#endif

	_bfd_link_add_symbols as function(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_link_just_syms as sub(byval as asection ptr, byval as bfd_link_info ptr)

	#if __BFD_VER__ >= 221
		_bfd_copy_link_hash_symbol_type as sub(byval as bfd ptr, byval as bfd_link_hash_entry ptr, byval as bfd_link_hash_entry ptr)
	#endif

	_bfd_final_link as function(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_link_split_section as function(byval as bfd ptr, byval as bfd_section ptr) as bfd_boolean
	_bfd_gc_sections as function(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean

	#if __BFD_VER__ = 222
		_bfd_lookup_section_flags as sub(byval as bfd_link_info ptr, byval as flag_info ptr)
	#elseif __BFD_VER__ >= 223
		_bfd_lookup_section_flags as function(byval as bfd_link_info ptr, byval as flag_info ptr, byval as asection ptr) as bfd_boolean
	#endif

	_bfd_merge_sections as function(byval as bfd ptr, byval as bfd_link_info ptr) as bfd_boolean
	_bfd_is_group_section as function(byval as bfd ptr, byval as const bfd_section ptr) as bfd_boolean
	_bfd_discard_group as function(byval as bfd ptr, byval as bfd_section ptr) as bfd_boolean

	#if __BFD_VER__ <= 217
		_section_already_linked as sub(byval as bfd ptr, byval as bfd_section ptr)
	#elseif (__BFD_VER__ >= 218) and (__BFD_VER__ <= 221)
		_section_already_linked as sub(byval as bfd ptr, byval as bfd_section ptr, byval as bfd_link_info ptr)
	#else
		_section_already_linked as function(byval as bfd ptr, byval as asection ptr, byval as bfd_link_info ptr) as bfd_boolean
	#endif

	#if __BFD_VER__ >= 220
		_bfd_define_common_symbol as function(byval as bfd ptr, byval as bfd_link_info ptr, byval as bfd_link_hash_entry ptr) as bfd_boolean
	#endif

	_bfd_get_dynamic_symtab_upper_bound as function(byval as bfd ptr) as clong
	_bfd_canonicalize_dynamic_symtab as function(byval as bfd ptr, byval as bfd_symbol ptr ptr) as clong
	_bfd_get_synthetic_symtab as function(byval as bfd ptr, byval as clong, byval as bfd_symbol ptr ptr, byval as clong, byval as bfd_symbol ptr ptr, byval as bfd_symbol ptr ptr) as clong
	_bfd_get_dynamic_reloc_upper_bound as function(byval as bfd ptr) as clong
	_bfd_canonicalize_dynamic_reloc as function(byval as bfd ptr, byval as arelent ptr ptr, byval as bfd_symbol ptr ptr) as clong
	alternative_target as const bfd_target ptr
	backend_data as const any ptr
end type

#define BFD_JUMP_TABLE_GENERIC(NAME) NAME##_close_and_cleanup, NAME##_bfd_free_cached_info, NAME##_new_section_hook, NAME##_get_section_contents, NAME##_get_section_contents_in_window

#if __BFD_VER__ = 216
	#define BFD_JUMP_TABLE_COPY(NAME) NAME##_bfd_copy_private_bfd_data, NAME##_bfd_merge_private_bfd_data, NAME##_bfd_copy_private_section_data, NAME##_bfd_copy_private_symbol_data, NAME##_bfd_copy_private_header_data, NAME##_bfd_set_private_flags, NAME##_bfd_print_private_bfd_data
#else
	#define BFD_JUMP_TABLE_COPY(NAME) NAME##_bfd_copy_private_bfd_data, NAME##_bfd_merge_private_bfd_data, _bfd_generic_init_private_section_data, NAME##_bfd_copy_private_section_data, NAME##_bfd_copy_private_symbol_data, NAME##_bfd_copy_private_header_data, NAME##_bfd_set_private_flags, NAME##_bfd_print_private_bfd_data
	#define bfd_init_private_section_data(ibfd, isec, obfd, osec, link_info) BFD_SEND (obfd, _bfd_init_private_section_data, (ibfd, isec, obfd, osec, link_info))
#endif

#if __BFD_VER__ <= 220
	#define BFD_JUMP_TABLE_CORE(NAME) NAME##_core_file_failing_command, NAME##_core_file_failing_signal, NAME##_core_file_matches_executable_p
	#define BFD_JUMP_TABLE_ARCHIVE(NAME) NAME##_slurp_armap, NAME##_slurp_extended_name_table, NAME##_construct_extended_name_table, NAME##_truncate_arname, NAME##_write_armap, NAME##_read_ar_hdr, NAME##_openr_next_archived_file, NAME##_get_elt_at_index, NAME##_generic_stat_arch_elt, NAME##_update_armap_timestamp
#else
	#define BFD_JUMP_TABLE_CORE(NAME) NAME##_core_file_failing_command, NAME##_core_file_failing_signal, NAME##_core_file_matches_executable_p, NAME##_core_file_pid
	#define BFD_JUMP_TABLE_ARCHIVE(NAME) NAME##_slurp_armap, NAME##_slurp_extended_name_table, NAME##_construct_extended_name_table, NAME##_truncate_arname, NAME##_write_armap, NAME##_read_ar_hdr, NAME##_write_ar_hdr, NAME##_openr_next_archived_file, NAME##_get_elt_at_index, NAME##_generic_stat_arch_elt, NAME##_update_armap_timestamp
#endif

#define bfd_get_elt_at_index(b, i) BFD_SEND (b, _bfd_get_elt_at_index, (b, i))

#if __BFD_VER__ = 216
	#define BFD_JUMP_TABLE_SYMBOLS(NAME) NAME##_get_symtab_upper_bound, NAME##_canonicalize_symtab, NAME##_make_empty_symbol, NAME##_print_symbol, NAME##_get_symbol_info, NAME##_bfd_is_local_label_name, NAME##_bfd_is_target_special_symbol, NAME##_get_lineno, NAME##_find_nearest_line, NAME##_bfd_make_debug_symbol, NAME##_read_minisymbols, NAME##_minisymbol_to_symbol
#elseif (__BFD_VER__ >= 217) and (__BFD_VER__ <= 222)
	#define BFD_JUMP_TABLE_SYMBOLS(NAME) NAME##_get_symtab_upper_bound, NAME##_canonicalize_symtab, NAME##_make_empty_symbol, NAME##_print_symbol, NAME##_get_symbol_info, NAME##_bfd_is_local_label_name, NAME##_bfd_is_target_special_symbol, NAME##_get_lineno, NAME##_find_nearest_line, _bfd_generic_find_line, NAME##_find_inliner_info, NAME##_bfd_make_debug_symbol, NAME##_read_minisymbols, NAME##_minisymbol_to_symbol
#elseif (__BFD_VER__ = 223) or (__BFD_VER__ = 224)
	#define BFD_JUMP_TABLE_SYMBOLS(NAME) NAME##_get_symtab_upper_bound, NAME##_canonicalize_symtab, NAME##_make_empty_symbol, NAME##_print_symbol, NAME##_get_symbol_info, NAME##_bfd_is_local_label_name, NAME##_bfd_is_target_special_symbol, NAME##_get_lineno, NAME##_find_nearest_line, _bfd_generic_find_nearest_line_discriminator, _bfd_generic_find_line, NAME##_find_inliner_info, NAME##_bfd_make_debug_symbol, NAME##_read_minisymbols, NAME##_minisymbol_to_symbol
#else
	#define BFD_JUMP_TABLE_SYMBOLS(NAME) NAME##_get_symtab_upper_bound, NAME##_canonicalize_symtab, NAME##_make_empty_symbol, NAME##_print_symbol, NAME##_get_symbol_info, NAME##_bfd_is_local_label_name, NAME##_bfd_is_target_special_symbol, NAME##_get_lineno, NAME##_find_nearest_line, NAME##_find_line, NAME##_find_inliner_info, NAME##_bfd_make_debug_symbol, NAME##_read_minisymbols, NAME##_minisymbol_to_symbol
#endif

#define bfd_print_symbol(b, p, s, e) BFD_SEND (b, _bfd_print_symbol, (b, p, s, e))
#define bfd_get_symbol_info(b, p, e) BFD_SEND (b, _bfd_get_symbol_info, (b, p, e))
#define bfd_read_minisymbols(b, d, m, s) BFD_SEND (b, _read_minisymbols, (b, d, m, s))
#define bfd_minisymbol_to_symbol(b, d, m, f) BFD_SEND (b, _minisymbol_to_symbol, (b, d, m, f))

#if __BFD_VER__ <= 217
	#define BFD_JUMP_TABLE_RELOCS(NAME) NAME##_get_reloc_upper_bound, NAME##_canonicalize_reloc, NAME##_bfd_reloc_type_lookup
#else
	#define BFD_JUMP_TABLE_RELOCS(NAME) NAME##_get_reloc_upper_bound, NAME##_canonicalize_reloc, NAME##_bfd_reloc_type_lookup, NAME##_bfd_reloc_name_lookup
#endif

#define BFD_JUMP_TABLE_WRITE(NAME) NAME##_set_arch_mach, NAME##_set_section_contents

#if __BFD_VER__ <= 219
	#define BFD_JUMP_TABLE_LINK(NAME) NAME##_sizeof_headers, NAME##_bfd_get_relocated_section_contents, NAME##_bfd_relax_section, NAME##_bfd_link_hash_table_create, NAME##_bfd_link_hash_table_free, NAME##_bfd_link_add_symbols, NAME##_bfd_link_just_syms, NAME##_bfd_final_link, NAME##_bfd_link_split_section, NAME##_bfd_gc_sections, NAME##_bfd_merge_sections, NAME##_bfd_is_group_section, NAME##_bfd_discard_group, NAME##_section_already_linked
#elseif __BFD_VER__ = 220
	#define BFD_JUMP_TABLE_LINK(NAME) NAME##_sizeof_headers, NAME##_bfd_get_relocated_section_contents, NAME##_bfd_relax_section, NAME##_bfd_link_hash_table_create, NAME##_bfd_link_hash_table_free, NAME##_bfd_link_add_symbols, NAME##_bfd_link_just_syms, NAME##_bfd_final_link, NAME##_bfd_link_split_section, NAME##_bfd_gc_sections, NAME##_bfd_merge_sections, NAME##_bfd_is_group_section, NAME##_bfd_discard_group, NAME##_section_already_linked, NAME##_bfd_define_common_symbol
#elseif __BFD_VER__ = 221
	#define BFD_JUMP_TABLE_LINK(NAME) NAME##_sizeof_headers, NAME##_bfd_get_relocated_section_contents, NAME##_bfd_relax_section, NAME##_bfd_link_hash_table_create, NAME##_bfd_link_hash_table_free, NAME##_bfd_link_add_symbols, NAME##_bfd_link_just_syms, NAME##_bfd_copy_link_hash_symbol_type, NAME##_bfd_final_link, NAME##_bfd_link_split_section, NAME##_bfd_gc_sections, NAME##_bfd_merge_sections, NAME##_bfd_is_group_section, NAME##_bfd_discard_group, NAME##_section_already_linked, NAME##_bfd_define_common_symbol
#elseif (__BFD_VER__ >= 222) and (__BFD_VER__ <= 224)
	#define BFD_JUMP_TABLE_LINK(NAME) NAME##_sizeof_headers, NAME##_bfd_get_relocated_section_contents, NAME##_bfd_relax_section, NAME##_bfd_link_hash_table_create, NAME##_bfd_link_hash_table_free, NAME##_bfd_link_add_symbols, NAME##_bfd_link_just_syms, NAME##_bfd_copy_link_hash_symbol_type, NAME##_bfd_final_link, NAME##_bfd_link_split_section, NAME##_bfd_gc_sections, NAME##_bfd_lookup_section_flags, NAME##_bfd_merge_sections, NAME##_bfd_is_group_section, NAME##_bfd_discard_group, NAME##_section_already_linked, NAME##_bfd_define_common_symbol
#else
	#define BFD_JUMP_TABLE_LINK(NAME) NAME##_sizeof_headers, NAME##_bfd_get_relocated_section_contents, NAME##_bfd_relax_section, NAME##_bfd_link_hash_table_create, NAME##_bfd_link_add_symbols, NAME##_bfd_link_just_syms, NAME##_bfd_copy_link_hash_symbol_type, NAME##_bfd_final_link, NAME##_bfd_link_split_section, NAME##_bfd_gc_sections, NAME##_bfd_lookup_section_flags, NAME##_bfd_merge_sections, NAME##_bfd_is_group_section, NAME##_bfd_discard_group, NAME##_section_already_linked, NAME##_bfd_define_common_symbol
#endif

#if __BFD_VER__ >= 221
	#define bfd_copy_link_hash_symbol_type(b, t, f) BFD_SEND (b, _bfd_copy_link_hash_symbol_type, (b, t, f))
#endif

#define BFD_JUMP_TABLE_DYNAMIC(NAME) NAME##_get_dynamic_symtab_upper_bound, NAME##_canonicalize_dynamic_symtab, NAME##_get_synthetic_symtab, NAME##_get_dynamic_reloc_upper_bound, NAME##_canonicalize_dynamic_reloc
declare function bfd_set_default_target(byval name as const zstring ptr) as bfd_boolean
declare function bfd_find_target(byval target_name as const zstring ptr, byval abfd as bfd ptr) as const bfd_target ptr

#if __BFD_VER__ >= 221
	declare function bfd_get_target_info(byval target_name as const zstring ptr, byval abfd as bfd ptr, byval is_bigendian as bfd_boolean ptr, byval underscoring as long ptr, byval def_target_arch as const zstring ptr ptr) as const bfd_target ptr
#endif

declare function bfd_target_list() as const zstring ptr ptr
declare function bfd_search_for_target(byval search_func as function(byval as const bfd_target ptr, byval as any ptr) as long, byval as any ptr) as const bfd_target ptr
declare function bfd_check_format(byval abfd as bfd ptr, byval format as bfd_format) as bfd_boolean
declare function bfd_check_format_matches(byval abfd as bfd ptr, byval format as bfd_format, byval matching as zstring ptr ptr ptr) as bfd_boolean
declare function bfd_set_format(byval abfd as bfd ptr, byval format as bfd_format) as bfd_boolean
declare function bfd_format_string(byval format as bfd_format) as const zstring ptr
declare function bfd_link_split_section_ alias "bfd_link_split_section"(byval abfd as bfd ptr, byval sec as asection ptr) as bfd_boolean
#define bfd_link_split_section(abfd, sec) BFD_SEND (abfd, _bfd_link_split_section, (abfd, sec))

#if __BFD_VER__ <= 217
	declare sub bfd_section_already_linked_ alias "bfd_section_already_linked"(byval abfd as bfd ptr, byval sec as asection ptr)
	#define bfd_section_already_linked(abfd, sec) BFD_SEND (abfd, _section_already_linked, (abfd, sec))
#elseif (__BFD_VER__ >= 218) and (__BFD_VER__ <= 221)
	declare sub bfd_section_already_linked_ alias "bfd_section_already_linked"(byval abfd as bfd ptr, byval sec as asection ptr, byval info as bfd_link_info ptr)
#else
	declare function bfd_section_already_linked_ alias "bfd_section_already_linked"(byval abfd as bfd ptr, byval sec as asection ptr, byval info as bfd_link_info ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 218
	#define bfd_section_already_linked(abfd, sec, info) BFD_SEND (abfd, _section_already_linked, (abfd, sec, info))
#endif

#if __BFD_VER__ >= 220
	declare function bfd_generic_define_common_symbol(byval output_bfd as bfd ptr, byval info as bfd_link_info ptr, byval h as bfd_link_hash_entry ptr) as bfd_boolean
	#define bfd_define_common_symbol(output_bfd, info, h) BFD_SEND (output_bfd, _bfd_define_common_symbol, (output_bfd, info, h))
#endif

#if __BFD_VER__ >= 222
	type bfd_elf_version_tree as bfd_elf_version_tree_
#endif

#if __BFD_VER__ >= 220
	declare function bfd_find_version_for_sym(byval verdefs as bfd_elf_version_tree ptr, byval sym_name as const zstring ptr, byval hide as bfd_boolean ptr) as bfd_elf_version_tree ptr
#endif

#if __BFD_VER__ >= 222
	declare function bfd_hide_sym_by_version(byval verdefs as bfd_elf_version_tree ptr, byval sym_name as const zstring ptr) as bfd_boolean
#endif

declare function bfd_simple_get_relocated_section_contents(byval abfd as bfd ptr, byval sec as asection ptr, byval outbuf as bfd_byte ptr, byval symbol_table as asymbol ptr ptr) as bfd_byte ptr

#if (__BFD_VER__ = 219) or (__BFD_VER__ = 220)
	declare function bfd_uncompress_section_contents(byval buffer as bfd_byte ptr ptr, byval size as bfd_size_type ptr) as bfd_boolean
#elseif __BFD_VER__ >= 221
	declare function bfd_compress_section_contents(byval abfd as bfd ptr, byval section as asection ptr, byval uncompressed_buffer as bfd_byte ptr, byval uncompressed_size as bfd_size_type) as bfd_boolean
	declare function bfd_get_full_section_contents(byval abfd as bfd ptr, byval section as asection ptr, byval ptr_ as bfd_byte ptr ptr) as bfd_boolean
#endif

#if __BFD_VER__ >= 224
	declare sub bfd_cache_section_contents(byval sec as asection ptr, byval contents as any ptr)
#endif

#if __BFD_VER__ >= 221
	declare function bfd_is_section_compressed(byval abfd as bfd ptr, byval section as asection ptr) as bfd_boolean
	declare function bfd_init_section_decompress_status(byval abfd as bfd ptr, byval section as asection ptr) as bfd_boolean
	declare function bfd_init_section_compress_status(byval abfd as bfd ptr, byval section as asection ptr) as bfd_boolean
#endif

end extern
