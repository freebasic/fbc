'' FreeBASIC binding for pcre-8.37
''
'' based on the C header files:
''    This is the public header file for the PCRE library, to be #included by
''   applications that call the PCRE functions.
''
''              Copyright (c) 1997-2014 University of Cambridge
''
''   -----------------------------------------------------------------------------
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''       * Redistributions of source code must retain the above copyright notice,
''         this list of conditions and the following disclaimer.
''
''       * Redistributions in binary form must reproduce the above copyright
''         notice, this list of conditions and the following disclaimer in the
''         documentation and/or other materials provided with the distribution.
''
''       * Neither the name of the University of Cambridge nor the names of its
''         contributors may be used to endorse or promote products derived from
''         this software without specific prior written permission.
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
''   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
''   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
''   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
''   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
''   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
''   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
''   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
''   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
''   POSSIBILITY OF SUCH DAMAGE.
''   -----------------------------------------------------------------------------
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdlib.bi"

extern "C"

#define _PCRE_H
const PCRE_MAJOR = 8
const PCRE_MINOR = 37
#define PCRE_PRERELEASE
const PCRE_DATE = (2015 - &o4) - 28
const PCRE_CASELESS = &h00000001
const PCRE_MULTILINE = &h00000002
const PCRE_DOTALL = &h00000004
const PCRE_EXTENDED = &h00000008
const PCRE_ANCHORED = &h00000010
const PCRE_DOLLAR_ENDONLY = &h00000020
const PCRE_EXTRA = &h00000040
const PCRE_NOTBOL = &h00000080
const PCRE_NOTEOL = &h00000100
const PCRE_UNGREEDY = &h00000200
const PCRE_NOTEMPTY = &h00000400
const PCRE_UTF8 = &h00000800
const PCRE_UTF16 = &h00000800
const PCRE_UTF32 = &h00000800
const PCRE_NO_AUTO_CAPTURE = &h00001000
const PCRE_NO_UTF8_CHECK = &h00002000
const PCRE_NO_UTF16_CHECK = &h00002000
const PCRE_NO_UTF32_CHECK = &h00002000
const PCRE_AUTO_CALLOUT = &h00004000
const PCRE_PARTIAL_SOFT = &h00008000
const PCRE_PARTIAL = &h00008000
const PCRE_NEVER_UTF = &h00010000
const PCRE_DFA_SHORTEST = &h00010000
const PCRE_NO_AUTO_POSSESS = &h00020000
const PCRE_DFA_RESTART = &h00020000
const PCRE_FIRSTLINE = &h00040000
const PCRE_DUPNAMES = &h00080000
const PCRE_NEWLINE_CR = &h00100000
const PCRE_NEWLINE_LF = &h00200000
const PCRE_NEWLINE_CRLF = &h00300000
const PCRE_NEWLINE_ANY = &h00400000
const PCRE_NEWLINE_ANYCRLF = &h00500000
const PCRE_BSR_ANYCRLF = &h00800000
const PCRE_BSR_UNICODE = &h01000000
const PCRE_JAVASCRIPT_COMPAT = &h02000000
const PCRE_NO_START_OPTIMIZE = &h04000000
const PCRE_NO_START_OPTIMISE = &h04000000
const PCRE_PARTIAL_HARD = &h08000000
const PCRE_NOTEMPTY_ATSTART = &h10000000
const PCRE_UCP = &h20000000
const PCRE_ERROR_NOMATCH = -1
const PCRE_ERROR_NULL = -2
const PCRE_ERROR_BADOPTION = -3
const PCRE_ERROR_BADMAGIC = -4
const PCRE_ERROR_UNKNOWN_OPCODE = -5
const PCRE_ERROR_UNKNOWN_NODE = -5
const PCRE_ERROR_NOMEMORY = -6
const PCRE_ERROR_NOSUBSTRING = -7
const PCRE_ERROR_MATCHLIMIT = -8
const PCRE_ERROR_CALLOUT = -9
const PCRE_ERROR_BADUTF8 = -10
const PCRE_ERROR_BADUTF16 = -10
const PCRE_ERROR_BADUTF32 = -10
const PCRE_ERROR_BADUTF8_OFFSET = -11
const PCRE_ERROR_BADUTF16_OFFSET = -11
const PCRE_ERROR_PARTIAL = -12
const PCRE_ERROR_BADPARTIAL = -13
const PCRE_ERROR_INTERNAL = -14
const PCRE_ERROR_BADCOUNT = -15
const PCRE_ERROR_DFA_UITEM = -16
const PCRE_ERROR_DFA_UCOND = -17
const PCRE_ERROR_DFA_UMLIMIT = -18
const PCRE_ERROR_DFA_WSSIZE = -19
const PCRE_ERROR_DFA_RECURSE = -20
const PCRE_ERROR_RECURSIONLIMIT = -21
const PCRE_ERROR_NULLWSLIMIT = -22
const PCRE_ERROR_BADNEWLINE = -23
const PCRE_ERROR_BADOFFSET = -24
const PCRE_ERROR_SHORTUTF8 = -25
const PCRE_ERROR_SHORTUTF16 = -25
const PCRE_ERROR_RECURSELOOP = -26
const PCRE_ERROR_JIT_STACKLIMIT = -27
const PCRE_ERROR_BADMODE = -28
const PCRE_ERROR_BADENDIANNESS = -29
const PCRE_ERROR_DFA_BADRESTART = -30
const PCRE_ERROR_JIT_BADOPTION = -31
const PCRE_ERROR_BADLENGTH = -32
const PCRE_ERROR_UNSET = -33
const PCRE_UTF8_ERR0 = 0
const PCRE_UTF8_ERR1 = 1
const PCRE_UTF8_ERR2 = 2
const PCRE_UTF8_ERR3 = 3
const PCRE_UTF8_ERR4 = 4
const PCRE_UTF8_ERR5 = 5
const PCRE_UTF8_ERR6 = 6
const PCRE_UTF8_ERR7 = 7
const PCRE_UTF8_ERR8 = 8
const PCRE_UTF8_ERR9 = 9
const PCRE_UTF8_ERR10 = 10
const PCRE_UTF8_ERR11 = 11
const PCRE_UTF8_ERR12 = 12
const PCRE_UTF8_ERR13 = 13
const PCRE_UTF8_ERR14 = 14
const PCRE_UTF8_ERR15 = 15
const PCRE_UTF8_ERR16 = 16
const PCRE_UTF8_ERR17 = 17
const PCRE_UTF8_ERR18 = 18
const PCRE_UTF8_ERR19 = 19
const PCRE_UTF8_ERR20 = 20
const PCRE_UTF8_ERR21 = 21
const PCRE_UTF8_ERR22 = 22
const PCRE_UTF16_ERR0 = 0
const PCRE_UTF16_ERR1 = 1
const PCRE_UTF16_ERR2 = 2
const PCRE_UTF16_ERR3 = 3
const PCRE_UTF16_ERR4 = 4
const PCRE_UTF32_ERR0 = 0
const PCRE_UTF32_ERR1 = 1
const PCRE_UTF32_ERR2 = 2
const PCRE_UTF32_ERR3 = 3
const PCRE_INFO_OPTIONS = 0
const PCRE_INFO_SIZE = 1
const PCRE_INFO_CAPTURECOUNT = 2
const PCRE_INFO_BACKREFMAX = 3
const PCRE_INFO_FIRSTBYTE = 4
const PCRE_INFO_FIRSTCHAR = 4
const PCRE_INFO_FIRSTTABLE = 5
const PCRE_INFO_LASTLITERAL = 6
const PCRE_INFO_NAMEENTRYSIZE = 7
const PCRE_INFO_NAMECOUNT = 8
const PCRE_INFO_NAMETABLE = 9
const PCRE_INFO_STUDYSIZE = 10
const PCRE_INFO_DEFAULT_TABLES = 11
const PCRE_INFO_OKPARTIAL = 12
const PCRE_INFO_JCHANGED = 13
const PCRE_INFO_HASCRORLF = 14
const PCRE_INFO_MINLENGTH = 15
const PCRE_INFO_JIT = 16
const PCRE_INFO_JITSIZE = 17
const PCRE_INFO_MAXLOOKBEHIND = 18
const PCRE_INFO_FIRSTCHARACTER = 19
const PCRE_INFO_FIRSTCHARACTERFLAGS = 20
const PCRE_INFO_REQUIREDCHAR = 21
const PCRE_INFO_REQUIREDCHARFLAGS = 22
const PCRE_INFO_MATCHLIMIT = 23
const PCRE_INFO_RECURSIONLIMIT = 24
const PCRE_INFO_MATCH_EMPTY = 25
const PCRE_CONFIG_UTF8 = 0
const PCRE_CONFIG_NEWLINE = 1
const PCRE_CONFIG_LINK_SIZE = 2
const PCRE_CONFIG_POSIX_MALLOC_THRESHOLD = 3
const PCRE_CONFIG_MATCH_LIMIT = 4
const PCRE_CONFIG_STACKRECURSE = 5
const PCRE_CONFIG_UNICODE_PROPERTIES = 6
const PCRE_CONFIG_MATCH_LIMIT_RECURSION = 7
const PCRE_CONFIG_BSR = 8
const PCRE_CONFIG_JIT = 9
const PCRE_CONFIG_UTF16 = 10
const PCRE_CONFIG_JITTARGET = 11
const PCRE_CONFIG_UTF32 = 12
const PCRE_CONFIG_PARENS_LIMIT = 13
const PCRE_STUDY_JIT_COMPILE = &h0001
const PCRE_STUDY_JIT_PARTIAL_SOFT_COMPILE = &h0002
const PCRE_STUDY_JIT_PARTIAL_HARD_COMPILE = &h0004
const PCRE_STUDY_EXTRA_NEEDED = &h0008
const PCRE_EXTRA_STUDY_DATA = &h0001
const PCRE_EXTRA_MATCH_LIMIT = &h0002
const PCRE_EXTRA_CALLOUT_DATA = &h0004
const PCRE_EXTRA_TABLES = &h0008
const PCRE_EXTRA_MATCH_LIMIT_RECURSION = &h0010
const PCRE_EXTRA_MARK = &h0020
const PCRE_EXTRA_EXECUTABLE_JIT = &h0040

type pcre as real_pcre
type pcre16 as real_pcre16
type pcre32 as real_pcre32
type pcre_jit_stack as real_pcre_jit_stack
type pcre16_jit_stack as real_pcre16_jit_stack
type pcre32_jit_stack as real_pcre32_jit_stack
type PCRE_UCHAR16 as ushort
type PCRE_SPTR16 as const PCRE_UCHAR16 ptr
type PCRE_UCHAR32 as ulong
type PCRE_SPTR32 as const PCRE_UCHAR32 ptr
type PCRE_SPTR as const zstring ptr

type pcre_extra
	flags as culong
	study_data as any ptr
	match_limit as culong
	callout_data as any ptr
	tables as const ubyte ptr
	match_limit_recursion as culong
	mark as ubyte ptr ptr
	executable_jit as any ptr
end type

type pcre16_extra
	flags as culong
	study_data as any ptr
	match_limit as culong
	callout_data as any ptr
	tables as const ubyte ptr
	match_limit_recursion as culong
	mark as ushort ptr ptr
	executable_jit as any ptr
end type

type pcre32_extra
	flags as culong
	study_data as any ptr
	match_limit as culong
	callout_data as any ptr
	tables as const ubyte ptr
	match_limit_recursion as culong
	mark as ulong ptr ptr
	executable_jit as any ptr
end type

type pcre_callout_block
	version as long
	callout_number as long
	offset_vector as long ptr
	subject as const zstring ptr
	subject_length as long
	start_match as long
	current_position as long
	capture_top as long
	capture_last as long
	callout_data as any ptr
	pattern_position as long
	next_item_length as long
	mark as const ubyte ptr
end type

type pcre16_callout_block
	version as long
	callout_number as long
	offset_vector as long ptr
	subject as const ushort ptr
	subject_length as long
	start_match as long
	current_position as long
	capture_top as long
	capture_last as long
	callout_data as any ptr
	pattern_position as long
	next_item_length as long
	mark as const ushort ptr
end type

type pcre32_callout_block
	version as long
	callout_number as long
	offset_vector as long ptr
	subject as const ulong ptr
	subject_length as long
	start_match as long
	current_position as long
	capture_top as long
	capture_last as long
	callout_data as any ptr
	pattern_position as long
	next_item_length as long
	mark as const ulong ptr
end type

#if defined(__FB_WIN32__) and (not defined(PCRE_STATIC))
	extern import pcre_malloc as function(byval as uinteger) as any ptr
	extern import pcre_free as sub(byval as any ptr)
	extern import pcre_stack_malloc as function(byval as uinteger) as any ptr
	extern import pcre_stack_free as sub(byval as any ptr)
	extern import pcre_callout as function(byval as pcre_callout_block ptr) as long
	extern import pcre_stack_guard as function() as long
	extern import pcre16_malloc as function(byval as uinteger) as any ptr
	extern import pcre16_free as sub(byval as any ptr)
	extern import pcre16_stack_malloc as function(byval as uinteger) as any ptr
	extern import pcre16_stack_free as sub(byval as any ptr)
	extern import pcre16_callout as function(byval as pcre16_callout_block ptr) as long
	extern import pcre16_stack_guard as function() as long
	extern import pcre32_malloc as function(byval as uinteger) as any ptr
	extern import pcre32_free as sub(byval as any ptr)
	extern import pcre32_stack_malloc as function(byval as uinteger) as any ptr
	extern import pcre32_stack_free as sub(byval as any ptr)
	extern import pcre32_callout as function(byval as pcre32_callout_block ptr) as long
	extern import pcre32_stack_guard as function() as long
#else
	extern pcre_malloc as function(byval as uinteger) as any ptr
	extern pcre_free as sub(byval as any ptr)
	extern pcre_stack_malloc as function(byval as uinteger) as any ptr
	extern pcre_stack_free as sub(byval as any ptr)
	extern pcre_callout as function(byval as pcre_callout_block ptr) as long
	extern pcre_stack_guard as function() as long
	extern pcre16_malloc as function(byval as uinteger) as any ptr
	extern pcre16_free as sub(byval as any ptr)
	extern pcre16_stack_malloc as function(byval as uinteger) as any ptr
	extern pcre16_stack_free as sub(byval as any ptr)
	extern pcre16_callout as function(byval as pcre16_callout_block ptr) as long
	extern pcre16_stack_guard as function() as long
	extern pcre32_malloc as function(byval as uinteger) as any ptr
	extern pcre32_free as sub(byval as any ptr)
	extern pcre32_stack_malloc as function(byval as uinteger) as any ptr
	extern pcre32_stack_free as sub(byval as any ptr)
	extern pcre32_callout as function(byval as pcre32_callout_block ptr) as long
	extern pcre32_stack_guard as function() as long
#endif

type pcre_jit_callback as function(byval as any ptr) as pcre_jit_stack ptr
type pcre16_jit_callback as function(byval as any ptr) as pcre16_jit_stack ptr
type pcre32_jit_callback as function(byval as any ptr) as pcre32_jit_stack ptr

declare function pcre_compile(byval as const zstring ptr, byval as long, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre ptr
declare function pcre16_compile(byval as const ushort ptr, byval as long, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre16 ptr
declare function pcre32_compile(byval as const ulong ptr, byval as long, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre32 ptr
declare function pcre_compile2(byval as const zstring ptr, byval as long, byval as long ptr, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre ptr
declare function pcre16_compile2(byval as const ushort ptr, byval as long, byval as long ptr, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre16 ptr
declare function pcre32_compile2(byval as const ulong ptr, byval as long, byval as long ptr, byval as const zstring ptr ptr, byval as long ptr, byval as const ubyte ptr) as pcre32 ptr
declare function pcre_config(byval as long, byval as any ptr) as long
declare function pcre16_config(byval as long, byval as any ptr) as long
declare function pcre32_config(byval as long, byval as any ptr) as long
declare function pcre_copy_named_substring(byval as const pcre ptr, byval as const zstring ptr, byval as long ptr, byval as long, byval as const zstring ptr, byval as zstring ptr, byval as long) as long
declare function pcre16_copy_named_substring(byval as const pcre16 ptr, byval as const ushort ptr, byval as long ptr, byval as long, byval as const ushort ptr, byval as ushort ptr, byval as long) as long
declare function pcre32_copy_named_substring(byval as const pcre32 ptr, byval as const ulong ptr, byval as long ptr, byval as long, byval as const ulong ptr, byval as ulong ptr, byval as long) as long
declare function pcre_copy_substring(byval as const zstring ptr, byval as long ptr, byval as long, byval as long, byval as zstring ptr, byval as long) as long
declare function pcre16_copy_substring(byval as const ushort ptr, byval as long ptr, byval as long, byval as long, byval as ushort ptr, byval as long) as long
declare function pcre32_copy_substring(byval as const ulong ptr, byval as long ptr, byval as long, byval as long, byval as ulong ptr, byval as long) as long
declare function pcre_dfa_exec(byval as const pcre ptr, byval as const pcre_extra ptr, byval as const zstring ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as long ptr, byval as long) as long
declare function pcre16_dfa_exec(byval as const pcre16 ptr, byval as const pcre16_extra ptr, byval as const ushort ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as long ptr, byval as long) as long
declare function pcre32_dfa_exec(byval as const pcre32 ptr, byval as const pcre32_extra ptr, byval as const ulong ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as long ptr, byval as long) as long
declare function pcre_exec(byval as const pcre ptr, byval as const pcre_extra ptr, byval as const zstring ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long) as long
declare function pcre16_exec(byval as const pcre16 ptr, byval as const pcre16_extra ptr, byval as const ushort ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long) as long
declare function pcre32_exec(byval as const pcre32 ptr, byval as const pcre32_extra ptr, byval as const ulong ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long) as long
declare function pcre_jit_exec(byval as const pcre ptr, byval as const pcre_extra ptr, byval as const zstring ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as pcre_jit_stack ptr) as long
declare function pcre16_jit_exec(byval as const pcre16 ptr, byval as const pcre16_extra ptr, byval as const ushort ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as pcre16_jit_stack ptr) as long
declare function pcre32_jit_exec(byval as const pcre32 ptr, byval as const pcre32_extra ptr, byval as const ulong ptr, byval as long, byval as long, byval as long, byval as long ptr, byval as long, byval as pcre32_jit_stack ptr) as long
declare sub pcre_free_substring(byval as const zstring ptr)
declare sub pcre16_free_substring(byval as const ushort ptr)
declare sub pcre32_free_substring(byval as const ulong ptr)
declare sub pcre_free_substring_list(byval as const zstring ptr ptr)
declare sub pcre16_free_substring_list(byval as const ushort ptr ptr)
declare sub pcre32_free_substring_list(byval as const ulong ptr ptr)
declare function pcre_fullinfo(byval as const pcre ptr, byval as const pcre_extra ptr, byval as long, byval as any ptr) as long
declare function pcre16_fullinfo(byval as const pcre16 ptr, byval as const pcre16_extra ptr, byval as long, byval as any ptr) as long
declare function pcre32_fullinfo(byval as const pcre32 ptr, byval as const pcre32_extra ptr, byval as long, byval as any ptr) as long
declare function pcre_get_named_substring(byval as const pcre ptr, byval as const zstring ptr, byval as long ptr, byval as long, byval as const zstring ptr, byval as const zstring ptr ptr) as long
declare function pcre16_get_named_substring(byval as const pcre16 ptr, byval as const ushort ptr, byval as long ptr, byval as long, byval as const ushort ptr, byval as const ushort ptr ptr) as long
declare function pcre32_get_named_substring(byval as const pcre32 ptr, byval as const ulong ptr, byval as long ptr, byval as long, byval as const ulong ptr, byval as const ulong ptr ptr) as long
declare function pcre_get_stringnumber(byval as const pcre ptr, byval as const zstring ptr) as long
declare function pcre16_get_stringnumber(byval as const pcre16 ptr, byval as const ushort ptr) as long
declare function pcre32_get_stringnumber(byval as const pcre32 ptr, byval as const ulong ptr) as long
declare function pcre_get_stringtable_entries(byval as const pcre ptr, byval as const zstring ptr, byval as zstring ptr ptr, byval as zstring ptr ptr) as long
declare function pcre16_get_stringtable_entries(byval as const pcre16 ptr, byval as const ushort ptr, byval as ushort ptr ptr, byval as ushort ptr ptr) as long
declare function pcre32_get_stringtable_entries(byval as const pcre32 ptr, byval as const ulong ptr, byval as ulong ptr ptr, byval as ulong ptr ptr) as long
declare function pcre_get_substring(byval as const zstring ptr, byval as long ptr, byval as long, byval as long, byval as const zstring ptr ptr) as long
declare function pcre16_get_substring(byval as const ushort ptr, byval as long ptr, byval as long, byval as long, byval as const ushort ptr ptr) as long
declare function pcre32_get_substring(byval as const ulong ptr, byval as long ptr, byval as long, byval as long, byval as const ulong ptr ptr) as long
declare function pcre_get_substring_list(byval as const zstring ptr, byval as long ptr, byval as long, byval as const zstring ptr ptr ptr) as long
declare function pcre16_get_substring_list(byval as const ushort ptr, byval as long ptr, byval as long, byval as const ushort ptr ptr ptr) as long
declare function pcre32_get_substring_list(byval as const ulong ptr, byval as long ptr, byval as long, byval as const ulong ptr ptr ptr) as long
declare function pcre_maketables() as const ubyte ptr
declare function pcre16_maketables() as const ubyte ptr
declare function pcre32_maketables() as const ubyte ptr
declare function pcre_refcount(byval as pcre ptr, byval as long) as long
declare function pcre16_refcount(byval as pcre16 ptr, byval as long) as long
declare function pcre32_refcount(byval as pcre32 ptr, byval as long) as long
declare function pcre_study(byval as const pcre ptr, byval as long, byval as const zstring ptr ptr) as pcre_extra ptr
declare function pcre16_study(byval as const pcre16 ptr, byval as long, byval as const zstring ptr ptr) as pcre16_extra ptr
declare function pcre32_study(byval as const pcre32 ptr, byval as long, byval as const zstring ptr ptr) as pcre32_extra ptr
declare sub pcre_free_study(byval as pcre_extra ptr)
declare sub pcre16_free_study(byval as pcre16_extra ptr)
declare sub pcre32_free_study(byval as pcre32_extra ptr)
declare function pcre_version() as const zstring ptr
declare function pcre16_version() as const zstring ptr
declare function pcre32_version() as const zstring ptr
declare function pcre_pattern_to_host_byte_order(byval as pcre ptr, byval as pcre_extra ptr, byval as const ubyte ptr) as long
declare function pcre16_pattern_to_host_byte_order(byval as pcre16 ptr, byval as pcre16_extra ptr, byval as const ubyte ptr) as long
declare function pcre32_pattern_to_host_byte_order(byval as pcre32 ptr, byval as pcre32_extra ptr, byval as const ubyte ptr) as long
declare function pcre16_utf16_to_host_byte_order(byval as ushort ptr, byval as const ushort ptr, byval as long, byval as long ptr, byval as long) as long
declare function pcre32_utf32_to_host_byte_order(byval as ulong ptr, byval as const ulong ptr, byval as long, byval as long ptr, byval as long) as long
declare function pcre_jit_stack_alloc(byval as long, byval as long) as pcre_jit_stack ptr
declare function pcre16_jit_stack_alloc(byval as long, byval as long) as pcre16_jit_stack ptr
declare function pcre32_jit_stack_alloc(byval as long, byval as long) as pcre32_jit_stack ptr
declare sub pcre_jit_stack_free(byval as pcre_jit_stack ptr)
declare sub pcre16_jit_stack_free(byval as pcre16_jit_stack ptr)
declare sub pcre32_jit_stack_free(byval as pcre32_jit_stack ptr)
declare sub pcre_assign_jit_stack(byval as pcre_extra ptr, byval as pcre_jit_callback, byval as any ptr)
declare sub pcre16_assign_jit_stack(byval as pcre16_extra ptr, byval as pcre16_jit_callback, byval as any ptr)
declare sub pcre32_assign_jit_stack(byval as pcre32_extra ptr, byval as pcre32_jit_callback, byval as any ptr)
declare sub pcre_jit_free_unused_memory()
declare sub pcre16_jit_free_unused_memory()
declare sub pcre32_jit_free_unused_memory()

end extern
