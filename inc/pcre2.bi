'' FreeBASIC binding for pcre2-10.20
''
'' based on the C header files:
''    This is the public header file for the PCRE library, second API, to be
''   #included by applications that call PCRE2 functions.
''
''              Copyright (c) 2015 University of Cambridge
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

#ifndef PCRE2_CODE_UNIT_WIDTH
	#error PCRE2_CODE_UNIT_WIDTH must be defined before including pcre2.bi. Use 8, 16, or 32; or 0 for a multi-width application.
#endif

#if PCRE2_CODE_UNIT_WIDTH = 8
	#inclib "pcre2-8"
#elseif PCRE2_CODE_UNIT_WIDTH = 16
	#inclib "pcre2-16"
#elseif PCRE2_CODE_UNIT_WIDTH = 32
	#inclib "pcre2-32"
#endif

#include once "crt/limits.bi"
#include once "crt/stdlib.bi"
#include once "crt/stdint.bi"

extern "C"

#define _PCRE2_H
const PCRE2_MAJOR = 10
const PCRE2_MINOR = 20
#define PCRE2_PRERELEASE
const PCRE2_DATE = (2015 - &o6) - 30
const PCRE2_ANCHORED = &h80000000u
const PCRE2_NO_UTF_CHECK = &h40000000u
const PCRE2_ALLOW_EMPTY_CLASS = &h00000001u
const PCRE2_ALT_BSUX = &h00000002u
const PCRE2_AUTO_CALLOUT = &h00000004u
const PCRE2_CASELESS = &h00000008u
const PCRE2_DOLLAR_ENDONLY = &h00000010u
const PCRE2_DOTALL = &h00000020u
const PCRE2_DUPNAMES = &h00000040u
const PCRE2_EXTENDED = &h00000080u
const PCRE2_FIRSTLINE = &h00000100u
const PCRE2_MATCH_UNSET_BACKREF = &h00000200u
const PCRE2_MULTILINE = &h00000400u
const PCRE2_NEVER_UCP = &h00000800u
const PCRE2_NEVER_UTF = &h00001000u
const PCRE2_NO_AUTO_CAPTURE = &h00002000u
const PCRE2_NO_AUTO_POSSESS = &h00004000u
const PCRE2_NO_DOTSTAR_ANCHOR = &h00008000u
const PCRE2_NO_START_OPTIMIZE = &h00010000u
const PCRE2_UCP = &h00020000u
const PCRE2_UNGREEDY = &h00040000u
const PCRE2_UTF = &h00080000u
const PCRE2_NEVER_BACKSLASH_C = &h00100000u
const PCRE2_ALT_CIRCUMFLEX = &h00200000u
const PCRE2_JIT_COMPLETE = &h00000001u
const PCRE2_JIT_PARTIAL_SOFT = &h00000002u
const PCRE2_JIT_PARTIAL_HARD = &h00000004u
const PCRE2_NOTBOL = &h00000001u
const PCRE2_NOTEOL = &h00000002u
const PCRE2_NOTEMPTY = &h00000004u
const PCRE2_NOTEMPTY_ATSTART = &h00000008u
const PCRE2_PARTIAL_SOFT = &h00000010u
const PCRE2_PARTIAL_HARD = &h00000020u
const PCRE2_DFA_RESTART = &h00000040u
const PCRE2_DFA_SHORTEST = &h00000080u
const PCRE2_SUBSTITUTE_GLOBAL = &h00000100u
const PCRE2_NEWLINE_CR = 1
const PCRE2_NEWLINE_LF = 2
const PCRE2_NEWLINE_CRLF = 3
const PCRE2_NEWLINE_ANY = 4
const PCRE2_NEWLINE_ANYCRLF = 5
const PCRE2_BSR_UNICODE = 1
const PCRE2_BSR_ANYCRLF = 2
const PCRE2_ERROR_NOMATCH = -1
const PCRE2_ERROR_PARTIAL = -2
const PCRE2_ERROR_UTF8_ERR1 = -3
const PCRE2_ERROR_UTF8_ERR2 = -4
const PCRE2_ERROR_UTF8_ERR3 = -5
const PCRE2_ERROR_UTF8_ERR4 = -6
const PCRE2_ERROR_UTF8_ERR5 = -7
const PCRE2_ERROR_UTF8_ERR6 = -8
const PCRE2_ERROR_UTF8_ERR7 = -9
const PCRE2_ERROR_UTF8_ERR8 = -10
const PCRE2_ERROR_UTF8_ERR9 = -11
const PCRE2_ERROR_UTF8_ERR10 = -12
const PCRE2_ERROR_UTF8_ERR11 = -13
const PCRE2_ERROR_UTF8_ERR12 = -14
const PCRE2_ERROR_UTF8_ERR13 = -15
const PCRE2_ERROR_UTF8_ERR14 = -16
const PCRE2_ERROR_UTF8_ERR15 = -17
const PCRE2_ERROR_UTF8_ERR16 = -18
const PCRE2_ERROR_UTF8_ERR17 = -19
const PCRE2_ERROR_UTF8_ERR18 = -20
const PCRE2_ERROR_UTF8_ERR19 = -21
const PCRE2_ERROR_UTF8_ERR20 = -22
const PCRE2_ERROR_UTF8_ERR21 = -23
const PCRE2_ERROR_UTF16_ERR1 = -24
const PCRE2_ERROR_UTF16_ERR2 = -25
const PCRE2_ERROR_UTF16_ERR3 = -26
const PCRE2_ERROR_UTF32_ERR1 = -27
const PCRE2_ERROR_UTF32_ERR2 = -28
const PCRE2_ERROR_BADDATA = -29
const PCRE2_ERROR_MIXEDTABLES = -30
const PCRE2_ERROR_BADMAGIC = -31
const PCRE2_ERROR_BADMODE = -32
const PCRE2_ERROR_BADOFFSET = -33
const PCRE2_ERROR_BADOPTION = -34
const PCRE2_ERROR_BADREPLACEMENT = -35
const PCRE2_ERROR_BADUTFOFFSET = -36
const PCRE2_ERROR_CALLOUT = -37
const PCRE2_ERROR_DFA_BADRESTART = -38
const PCRE2_ERROR_DFA_RECURSE = -39
const PCRE2_ERROR_DFA_UCOND = -40
const PCRE2_ERROR_DFA_UFUNC = -41
const PCRE2_ERROR_DFA_UITEM = -42
const PCRE2_ERROR_DFA_WSSIZE = -43
const PCRE2_ERROR_INTERNAL = -44
const PCRE2_ERROR_JIT_BADOPTION = -45
const PCRE2_ERROR_JIT_STACKLIMIT = -46
const PCRE2_ERROR_MATCHLIMIT = -47
const PCRE2_ERROR_NOMEMORY = -48
const PCRE2_ERROR_NOSUBSTRING = -49
const PCRE2_ERROR_NOUNIQUESUBSTRING = -50
const PCRE2_ERROR_NULL = -51
const PCRE2_ERROR_RECURSELOOP = -52
const PCRE2_ERROR_RECURSIONLIMIT = -53
const PCRE2_ERROR_UNAVAILABLE = -54
const PCRE2_ERROR_UNSET = -55
const PCRE2_INFO_ALLOPTIONS = 0
const PCRE2_INFO_ARGOPTIONS = 1
const PCRE2_INFO_BACKREFMAX = 2
const PCRE2_INFO_BSR = 3
const PCRE2_INFO_CAPTURECOUNT = 4
const PCRE2_INFO_FIRSTCODEUNIT = 5
const PCRE2_INFO_FIRSTCODETYPE = 6
const PCRE2_INFO_FIRSTBITMAP = 7
const PCRE2_INFO_HASCRORLF = 8
const PCRE2_INFO_JCHANGED = 9
const PCRE2_INFO_JITSIZE = 10
const PCRE2_INFO_LASTCODEUNIT = 11
const PCRE2_INFO_LASTCODETYPE = 12
const PCRE2_INFO_MATCHEMPTY = 13
const PCRE2_INFO_MATCHLIMIT = 14
const PCRE2_INFO_MAXLOOKBEHIND = 15
const PCRE2_INFO_MINLENGTH = 16
const PCRE2_INFO_NAMECOUNT = 17
const PCRE2_INFO_NAMEENTRYSIZE = 18
const PCRE2_INFO_NAMETABLE = 19
const PCRE2_INFO_NEWLINE = 20
const PCRE2_INFO_RECURSIONLIMIT = 21
const PCRE2_INFO_SIZE = 22
const PCRE2_CONFIG_BSR = 0
const PCRE2_CONFIG_JIT = 1
const PCRE2_CONFIG_JITTARGET = 2
const PCRE2_CONFIG_LINKSIZE = 3
const PCRE2_CONFIG_MATCHLIMIT = 4
const PCRE2_CONFIG_NEWLINE = 5
const PCRE2_CONFIG_PARENSLIMIT = 6
const PCRE2_CONFIG_RECURSIONLIMIT = 7
const PCRE2_CONFIG_STACKRECURSE = 8
const PCRE2_CONFIG_UNICODE = 9
const PCRE2_CONFIG_UNICODE_VERSION = 10
const PCRE2_CONFIG_VERSION = 11

type PCRE2_UCHAR8 as ubyte
type PCRE2_UCHAR16 as ushort
type PCRE2_UCHAR32 as ulong
type PCRE2_SPTR8 as const PCRE2_UCHAR8 ptr
type PCRE2_SPTR16 as const PCRE2_UCHAR16 ptr
type PCRE2_SPTR32 as const PCRE2_UCHAR32 ptr
type PCRE2_SIZE as uinteger

const PCRE2_ZERO_TERMINATED = not cast(PCRE2_SIZE, 0)
const PCRE2_UNSET = not cast(PCRE2_SIZE, 0)
#define PCRE2_JOIN(a, b) a##b
#define PCRE2_GLUE(a, b) PCRE2_JOIN(a, b)
#define PCRE2_SUFFIX(a) PCRE2_GLUE(a, PCRE2_LOCAL_WIDTH)
#define PCRE2_UCHAR PCRE2_SUFFIX(PCRE2_UCHAR)
#define PCRE2_SPTR PCRE2_SUFFIX(PCRE2_SPTR)
#define pcre2_code PCRE2_SUFFIX(pcre2_code_)
#define pcre2_jit_callback PCRE2_SUFFIX(pcre2_jit_callback_)
#define pcre2_jit_stack PCRE2_SUFFIX(pcre2_jit_stack_)
#define pcre2_real_code PCRE2_SUFFIX(pcre2_real_code_)
#define pcre2_real_general_context PCRE2_SUFFIX(pcre2_real_general_context_)
#define pcre2_real_compile_context PCRE2_SUFFIX(pcre2_real_compile_context_)
#define pcre2_real_match_context PCRE2_SUFFIX(pcre2_real_match_context_)
#define pcre2_real_jit_stack PCRE2_SUFFIX(pcre2_real_jit_stack_)
#define pcre2_real_match_data PCRE2_SUFFIX(pcre2_real_match_data_)
#define pcre2_callout_block PCRE2_SUFFIX(pcre2_callout_block_)
#define pcre2_callout_enumerate_block PCRE2_SUFFIX(pcre2_callout_enumerate_block_)
#define pcre2_general_context PCRE2_SUFFIX(pcre2_general_context_)
#define pcre2_compile_context PCRE2_SUFFIX(pcre2_compile_context_)
#define pcre2_match_context PCRE2_SUFFIX(pcre2_match_context_)
#define pcre2_match_data PCRE2_SUFFIX(pcre2_match_data_)
#define pcre2_callout_enumerate PCRE2_SUFFIX(pcre2_callout_enumerate_)
#define pcre2_code_free PCRE2_SUFFIX(pcre2_code_free_)
#define pcre2_compile PCRE2_SUFFIX(pcre2_compile_)
#define pcre2_compile_context_copy PCRE2_SUFFIX(pcre2_compile_context_copy_)
#define pcre2_compile_context_create PCRE2_SUFFIX(pcre2_compile_context_create_)
#define pcre2_compile_context_free PCRE2_SUFFIX(pcre2_compile_context_free_)
#define pcre2_config PCRE2_SUFFIX(pcre2_config_)
#define pcre2_dfa_match PCRE2_SUFFIX(pcre2_dfa_match_)
#define pcre2_general_context_copy PCRE2_SUFFIX(pcre2_general_context_copy_)
#define pcre2_general_context_create PCRE2_SUFFIX(pcre2_general_context_create_)
#define pcre2_general_context_free PCRE2_SUFFIX(pcre2_general_context_free_)
#define pcre2_get_error_message PCRE2_SUFFIX(pcre2_get_error_message_)
#define pcre2_get_mark PCRE2_SUFFIX(pcre2_get_mark_)
#define pcre2_get_ovector_pointer PCRE2_SUFFIX(pcre2_get_ovector_pointer_)
#define pcre2_get_ovector_count PCRE2_SUFFIX(pcre2_get_ovector_count_)
#define pcre2_get_startchar PCRE2_SUFFIX(pcre2_get_startchar_)
#define pcre2_jit_compile PCRE2_SUFFIX(pcre2_jit_compile_)
#define pcre2_jit_match PCRE2_SUFFIX(pcre2_jit_match_)
#define pcre2_jit_free_unused_memory PCRE2_SUFFIX(pcre2_jit_free_unused_memory_)
#define pcre2_jit_stack_assign PCRE2_SUFFIX(pcre2_jit_stack_assign_)
#define pcre2_jit_stack_create PCRE2_SUFFIX(pcre2_jit_stack_create_)
#define pcre2_jit_stack_free PCRE2_SUFFIX(pcre2_jit_stack_free_)
#define pcre2_maketables PCRE2_SUFFIX(pcre2_maketables_)
#define pcre2_match PCRE2_SUFFIX(pcre2_match_)
#define pcre2_match_context_copy PCRE2_SUFFIX(pcre2_match_context_copy_)
#define pcre2_match_context_create PCRE2_SUFFIX(pcre2_match_context_create_)
#define pcre2_match_context_free PCRE2_SUFFIX(pcre2_match_context_free_)
#define pcre2_match_data_create PCRE2_SUFFIX(pcre2_match_data_create_)
#define pcre2_match_data_create_from_pattern PCRE2_SUFFIX(pcre2_match_data_create_from_pattern_)
#define pcre2_match_data_free PCRE2_SUFFIX(pcre2_match_data_free_)
#define pcre2_pattern_info PCRE2_SUFFIX(pcre2_pattern_info_)
#define pcre2_serialize_decode PCRE2_SUFFIX(pcre2_serialize_decode_)
#define pcre2_serialize_encode PCRE2_SUFFIX(pcre2_serialize_encode_)
#define pcre2_serialize_free PCRE2_SUFFIX(pcre2_serialize_free_)
#define pcre2_serialize_get_number_of_codes PCRE2_SUFFIX(pcre2_serialize_get_number_of_codes_)
#define pcre2_set_bsr PCRE2_SUFFIX(pcre2_set_bsr_)
#define pcre2_set_callout PCRE2_SUFFIX(pcre2_set_callout_)
#define pcre2_set_character_tables PCRE2_SUFFIX(pcre2_set_character_tables_)
#define pcre2_set_compile_recursion_guard PCRE2_SUFFIX(pcre2_set_compile_recursion_guard_)
#define pcre2_set_match_limit PCRE2_SUFFIX(pcre2_set_match_limit_)
#define pcre2_set_newline PCRE2_SUFFIX(pcre2_set_newline_)
#define pcre2_set_parens_nest_limit PCRE2_SUFFIX(pcre2_set_parens_nest_limit_)
#define pcre2_set_recursion_limit PCRE2_SUFFIX(pcre2_set_recursion_limit_)
#define pcre2_set_recursion_memory_management PCRE2_SUFFIX(pcre2_set_recursion_memory_management_)
#define pcre2_substitute PCRE2_SUFFIX(pcre2_substitute_)
#define pcre2_substring_copy_byname PCRE2_SUFFIX(pcre2_substring_copy_byname_)
#define pcre2_substring_copy_bynumber PCRE2_SUFFIX(pcre2_substring_copy_bynumber_)
#define pcre2_substring_free PCRE2_SUFFIX(pcre2_substring_free_)
#define pcre2_substring_get_byname PCRE2_SUFFIX(pcre2_substring_get_byname_)
#define pcre2_substring_get_bynumber PCRE2_SUFFIX(pcre2_substring_get_bynumber_)
#define pcre2_substring_length_byname PCRE2_SUFFIX(pcre2_substring_length_byname_)
#define pcre2_substring_length_bynumber PCRE2_SUFFIX(pcre2_substring_length_bynumber_)
#define pcre2_substring_list_get PCRE2_SUFFIX(pcre2_substring_list_get_)
#define pcre2_substring_list_free PCRE2_SUFFIX(pcre2_substring_list_free_)
#define pcre2_substring_nametable_scan PCRE2_SUFFIX(pcre2_substring_nametable_scan_)
#define pcre2_substring_number_from_name PCRE2_SUFFIX(pcre2_substring_number_from_name_)
const PCRE2_LOCAL_WIDTH = 8

type pcre2_general_context_8 as pcre2_real_general_context_8
type pcre2_compile_context_8 as pcre2_real_compile_context_8
type pcre2_match_context_8 as pcre2_real_match_context_8
type pcre2_code_8 as pcre2_real_code_8
type pcre2_match_data_8 as pcre2_real_match_data_8
type pcre2_jit_stack_8 as pcre2_real_jit_stack_8
type pcre2_jit_callback_8 as function(byval as any ptr) as pcre2_jit_stack_8 ptr

type pcre2_callout_block_8
	version as ulong
	callout_number as ulong
	capture_top as ulong
	capture_last as ulong
	offset_vector as uinteger ptr
	mark as PCRE2_SPTR8
	subject as PCRE2_SPTR8
	subject_length as uinteger
	start_match as uinteger
	current_position as uinteger
	pattern_position as uinteger
	next_item_length as uinteger
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR8
end type

type pcre2_callout_enumerate_block_8
	version as ulong
	pattern_position as uinteger
	next_item_length as uinteger
	callout_number as ulong
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR8
end type

declare function pcre2_config_8(byval as ulong, byval as any ptr) as long
declare function pcre2_general_context_copy_8(byval as pcre2_general_context_8 ptr) as pcre2_general_context_8 ptr
declare function pcre2_general_context_create_8(byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as pcre2_general_context_8 ptr
declare sub pcre2_general_context_free_8(byval as pcre2_general_context_8 ptr)
declare function pcre2_compile_context_copy_8(byval as pcre2_compile_context_8 ptr) as pcre2_compile_context_8 ptr
declare function pcre2_compile_context_create_8(byval as pcre2_general_context_8 ptr) as pcre2_compile_context_8 ptr
declare sub pcre2_compile_context_free_8(byval as pcre2_compile_context_8 ptr)
declare function pcre2_set_bsr_8(byval as pcre2_compile_context_8 ptr, byval as ulong) as long
declare function pcre2_set_character_tables_8(byval as pcre2_compile_context_8 ptr, byval as const ubyte ptr) as long
declare function pcre2_set_newline_8(byval as pcre2_compile_context_8 ptr, byval as ulong) as long
declare function pcre2_set_parens_nest_limit_8(byval as pcre2_compile_context_8 ptr, byval as ulong) as long
declare function pcre2_set_compile_recursion_guard_8(byval as pcre2_compile_context_8 ptr, byval as function(byval as ulong, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_context_copy_8(byval as pcre2_match_context_8 ptr) as pcre2_match_context_8 ptr
declare function pcre2_match_context_create_8(byval as pcre2_general_context_8 ptr) as pcre2_match_context_8 ptr
declare sub pcre2_match_context_free_8(byval as pcre2_match_context_8 ptr)
declare function pcre2_set_callout_8(byval as pcre2_match_context_8 ptr, byval as function(byval as pcre2_callout_block_8 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_set_match_limit_8(byval as pcre2_match_context_8 ptr, byval as ulong) as long
declare function pcre2_set_recursion_limit_8(byval as pcre2_match_context_8 ptr, byval as ulong) as long
declare function pcre2_set_recursion_memory_management_8(byval as pcre2_match_context_8 ptr, byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as long
declare function pcre2_compile_8(byval as PCRE2_SPTR8, byval as uinteger, byval as ulong, byval as long ptr, byval as uinteger ptr, byval as pcre2_compile_context_8 ptr) as pcre2_code_8 ptr
declare sub pcre2_code_free_8(byval as pcre2_code_8 ptr)
declare function pcre2_pattern_info_8(byval as const pcre2_code_8 ptr, byval as ulong, byval as any ptr) as long
declare function pcre2_callout_enumerate_8(byval as const pcre2_code_8 ptr, byval as function(byval as pcre2_callout_enumerate_block_8 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_data_create_8(byval as ulong, byval as pcre2_general_context_8 ptr) as pcre2_match_data_8 ptr
declare function pcre2_match_data_create_from_pattern_8(byval as const pcre2_code_8 ptr, byval as pcre2_general_context_8 ptr) as pcre2_match_data_8 ptr
declare function pcre2_dfa_match_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_8 ptr, byval as pcre2_match_context_8 ptr, byval as long ptr, byval as uinteger) as long
declare function pcre2_match_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_8 ptr, byval as pcre2_match_context_8 ptr) as long
declare sub pcre2_match_data_free_8(byval as pcre2_match_data_8 ptr)
declare function pcre2_get_mark_8(byval as pcre2_match_data_8 ptr) as PCRE2_SPTR8
declare function pcre2_get_ovector_count_8(byval as pcre2_match_data_8 ptr) as ulong
declare function pcre2_get_ovector_pointer_8(byval as pcre2_match_data_8 ptr) as uinteger ptr
declare function pcre2_get_startchar_8(byval as pcre2_match_data_8 ptr) as uinteger
declare function pcre2_substring_copy_byname_8(byval as pcre2_match_data_8 ptr, byval as PCRE2_SPTR8, byval as PCRE2_UCHAR8 ptr, byval as uinteger ptr) as long
declare function pcre2_substring_copy_bynumber_8(byval as pcre2_match_data_8 ptr, byval as ulong, byval as PCRE2_UCHAR8 ptr, byval as uinteger ptr) as long
declare sub pcre2_substring_free_8(byval as PCRE2_UCHAR8 ptr)
declare function pcre2_substring_get_byname_8(byval as pcre2_match_data_8 ptr, byval as PCRE2_SPTR8, byval as PCRE2_UCHAR8 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_get_bynumber_8(byval as pcre2_match_data_8 ptr, byval as ulong, byval as PCRE2_UCHAR8 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_length_byname_8(byval as pcre2_match_data_8 ptr, byval as PCRE2_SPTR8, byval as uinteger ptr) as long
declare function pcre2_substring_length_bynumber_8(byval as pcre2_match_data_8 ptr, byval as ulong, byval as uinteger ptr) as long
declare function pcre2_substring_nametable_scan_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8, byval as PCRE2_SPTR8 ptr, byval as PCRE2_SPTR8 ptr) as long
declare function pcre2_substring_number_from_name_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8) as long
declare sub pcre2_substring_list_free_8(byval as PCRE2_SPTR8 ptr)
declare function pcre2_substring_list_get_8(byval as pcre2_match_data_8 ptr, byval as PCRE2_UCHAR8 ptr ptr ptr, byval as uinteger ptr ptr) as long
declare function pcre2_serialize_encode_8(byval as const pcre2_code_8 ptr ptr, byval as long, byval as ubyte ptr ptr, byval as uinteger ptr, byval as pcre2_general_context_8 ptr) as long
declare function pcre2_serialize_decode_8(byval as pcre2_code_8 ptr ptr, byval as long, byval as const ubyte ptr, byval as pcre2_general_context_8 ptr) as long
declare function pcre2_serialize_get_number_of_codes_8(byval as const ubyte ptr) as long
declare sub pcre2_serialize_free_8(byval as ubyte ptr)
declare function pcre2_substitute_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_8 ptr, byval as pcre2_match_context_8 ptr, byval as PCRE2_SPTR8, byval as uinteger, byval as PCRE2_UCHAR8 ptr, byval as uinteger ptr) as long
declare function pcre2_jit_compile_8(byval as pcre2_code_8 ptr, byval as ulong) as long
declare function pcre2_jit_match_8(byval as const pcre2_code_8 ptr, byval as PCRE2_SPTR8, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_8 ptr, byval as pcre2_match_context_8 ptr) as long
declare sub pcre2_jit_free_unused_memory_8(byval as pcre2_general_context_8 ptr)
declare function pcre2_jit_stack_create_8(byval as uinteger, byval as uinteger, byval as pcre2_general_context_8 ptr) as pcre2_jit_stack_8 ptr
declare sub pcre2_jit_stack_assign_8(byval as pcre2_match_context_8 ptr, byval as pcre2_jit_callback_8, byval as any ptr)
declare sub pcre2_jit_stack_free_8(byval as pcre2_jit_stack_8 ptr)
declare function pcre2_get_error_message_8(byval as long, byval as PCRE2_UCHAR8 ptr, byval as uinteger) as long
declare function pcre2_maketables_8(byval as pcre2_general_context_8 ptr) as const ubyte ptr
#undef PCRE2_LOCAL_WIDTH
const PCRE2_LOCAL_WIDTH = 16

type pcre2_general_context_16 as pcre2_real_general_context_16
type pcre2_compile_context_16 as pcre2_real_compile_context_16
type pcre2_match_context_16 as pcre2_real_match_context_16
type pcre2_code_16 as pcre2_real_code_16
type pcre2_match_data_16 as pcre2_real_match_data_16
type pcre2_jit_stack_16 as pcre2_real_jit_stack_16
type pcre2_jit_callback_16 as function(byval as any ptr) as pcre2_jit_stack_16 ptr

type pcre2_callout_block_16
	version as ulong
	callout_number as ulong
	capture_top as ulong
	capture_last as ulong
	offset_vector as uinteger ptr
	mark as PCRE2_SPTR16
	subject as PCRE2_SPTR16
	subject_length as uinteger
	start_match as uinteger
	current_position as uinteger
	pattern_position as uinteger
	next_item_length as uinteger
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR16
end type

type pcre2_callout_enumerate_block_16
	version as ulong
	pattern_position as uinteger
	next_item_length as uinteger
	callout_number as ulong
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR16
end type

declare function pcre2_config_16(byval as ulong, byval as any ptr) as long
declare function pcre2_general_context_copy_16(byval as pcre2_general_context_16 ptr) as pcre2_general_context_16 ptr
declare function pcre2_general_context_create_16(byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as pcre2_general_context_16 ptr
declare sub pcre2_general_context_free_16(byval as pcre2_general_context_16 ptr)
declare function pcre2_compile_context_copy_16(byval as pcre2_compile_context_16 ptr) as pcre2_compile_context_16 ptr
declare function pcre2_compile_context_create_16(byval as pcre2_general_context_16 ptr) as pcre2_compile_context_16 ptr
declare sub pcre2_compile_context_free_16(byval as pcre2_compile_context_16 ptr)
declare function pcre2_set_bsr_16(byval as pcre2_compile_context_16 ptr, byval as ulong) as long
declare function pcre2_set_character_tables_16(byval as pcre2_compile_context_16 ptr, byval as const ubyte ptr) as long
declare function pcre2_set_newline_16(byval as pcre2_compile_context_16 ptr, byval as ulong) as long
declare function pcre2_set_parens_nest_limit_16(byval as pcre2_compile_context_16 ptr, byval as ulong) as long
declare function pcre2_set_compile_recursion_guard_16(byval as pcre2_compile_context_16 ptr, byval as function(byval as ulong, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_context_copy_16(byval as pcre2_match_context_16 ptr) as pcre2_match_context_16 ptr
declare function pcre2_match_context_create_16(byval as pcre2_general_context_16 ptr) as pcre2_match_context_16 ptr
declare sub pcre2_match_context_free_16(byval as pcre2_match_context_16 ptr)
declare function pcre2_set_callout_16(byval as pcre2_match_context_16 ptr, byval as function(byval as pcre2_callout_block_16 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_set_match_limit_16(byval as pcre2_match_context_16 ptr, byval as ulong) as long
declare function pcre2_set_recursion_limit_16(byval as pcre2_match_context_16 ptr, byval as ulong) as long
declare function pcre2_set_recursion_memory_management_16(byval as pcre2_match_context_16 ptr, byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as long
declare function pcre2_compile_16(byval as PCRE2_SPTR16, byval as uinteger, byval as ulong, byval as long ptr, byval as uinteger ptr, byval as pcre2_compile_context_16 ptr) as pcre2_code_16 ptr
declare sub pcre2_code_free_16(byval as pcre2_code_16 ptr)
declare function pcre2_pattern_info_16(byval as const pcre2_code_16 ptr, byval as ulong, byval as any ptr) as long
declare function pcre2_callout_enumerate_16(byval as const pcre2_code_16 ptr, byval as function(byval as pcre2_callout_enumerate_block_16 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_data_create_16(byval as ulong, byval as pcre2_general_context_16 ptr) as pcre2_match_data_16 ptr
declare function pcre2_match_data_create_from_pattern_16(byval as const pcre2_code_16 ptr, byval as pcre2_general_context_16 ptr) as pcre2_match_data_16 ptr
declare function pcre2_dfa_match_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_16 ptr, byval as pcre2_match_context_16 ptr, byval as long ptr, byval as uinteger) as long
declare function pcre2_match_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_16 ptr, byval as pcre2_match_context_16 ptr) as long
declare sub pcre2_match_data_free_16(byval as pcre2_match_data_16 ptr)
declare function pcre2_get_mark_16(byval as pcre2_match_data_16 ptr) as PCRE2_SPTR16
declare function pcre2_get_ovector_count_16(byval as pcre2_match_data_16 ptr) as ulong
declare function pcre2_get_ovector_pointer_16(byval as pcre2_match_data_16 ptr) as uinteger ptr
declare function pcre2_get_startchar_16(byval as pcre2_match_data_16 ptr) as uinteger
declare function pcre2_substring_copy_byname_16(byval as pcre2_match_data_16 ptr, byval as PCRE2_SPTR16, byval as PCRE2_UCHAR16 ptr, byval as uinteger ptr) as long
declare function pcre2_substring_copy_bynumber_16(byval as pcre2_match_data_16 ptr, byval as ulong, byval as PCRE2_UCHAR16 ptr, byval as uinteger ptr) as long
declare sub pcre2_substring_free_16(byval as PCRE2_UCHAR16 ptr)
declare function pcre2_substring_get_byname_16(byval as pcre2_match_data_16 ptr, byval as PCRE2_SPTR16, byval as PCRE2_UCHAR16 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_get_bynumber_16(byval as pcre2_match_data_16 ptr, byval as ulong, byval as PCRE2_UCHAR16 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_length_byname_16(byval as pcre2_match_data_16 ptr, byval as PCRE2_SPTR16, byval as uinteger ptr) as long
declare function pcre2_substring_length_bynumber_16(byval as pcre2_match_data_16 ptr, byval as ulong, byval as uinteger ptr) as long
declare function pcre2_substring_nametable_scan_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16, byval as PCRE2_SPTR16 ptr, byval as PCRE2_SPTR16 ptr) as long
declare function pcre2_substring_number_from_name_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16) as long
declare sub pcre2_substring_list_free_16(byval as PCRE2_SPTR16 ptr)
declare function pcre2_substring_list_get_16(byval as pcre2_match_data_16 ptr, byval as PCRE2_UCHAR16 ptr ptr ptr, byval as uinteger ptr ptr) as long
declare function pcre2_serialize_encode_16(byval as const pcre2_code_16 ptr ptr, byval as long, byval as ubyte ptr ptr, byval as uinteger ptr, byval as pcre2_general_context_16 ptr) as long
declare function pcre2_serialize_decode_16(byval as pcre2_code_16 ptr ptr, byval as long, byval as const ubyte ptr, byval as pcre2_general_context_16 ptr) as long
declare function pcre2_serialize_get_number_of_codes_16(byval as const ubyte ptr) as long
declare sub pcre2_serialize_free_16(byval as ubyte ptr)
declare function pcre2_substitute_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_16 ptr, byval as pcre2_match_context_16 ptr, byval as PCRE2_SPTR16, byval as uinteger, byval as PCRE2_UCHAR16 ptr, byval as uinteger ptr) as long
declare function pcre2_jit_compile_16(byval as pcre2_code_16 ptr, byval as ulong) as long
declare function pcre2_jit_match_16(byval as const pcre2_code_16 ptr, byval as PCRE2_SPTR16, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_16 ptr, byval as pcre2_match_context_16 ptr) as long
declare sub pcre2_jit_free_unused_memory_16(byval as pcre2_general_context_16 ptr)
declare function pcre2_jit_stack_create_16(byval as uinteger, byval as uinteger, byval as pcre2_general_context_16 ptr) as pcre2_jit_stack_16 ptr
declare sub pcre2_jit_stack_assign_16(byval as pcre2_match_context_16 ptr, byval as pcre2_jit_callback_16, byval as any ptr)
declare sub pcre2_jit_stack_free_16(byval as pcre2_jit_stack_16 ptr)
declare function pcre2_get_error_message_16(byval as long, byval as PCRE2_UCHAR16 ptr, byval as uinteger) as long
declare function pcre2_maketables_16(byval as pcre2_general_context_16 ptr) as const ubyte ptr
#undef PCRE2_LOCAL_WIDTH
const PCRE2_LOCAL_WIDTH = 32

type pcre2_general_context_32 as pcre2_real_general_context_32
type pcre2_compile_context_32 as pcre2_real_compile_context_32
type pcre2_match_context_32 as pcre2_real_match_context_32
type pcre2_code_32 as pcre2_real_code_32
type pcre2_match_data_32 as pcre2_real_match_data_32
type pcre2_jit_stack_32 as pcre2_real_jit_stack_32
type pcre2_jit_callback_32 as function(byval as any ptr) as pcre2_jit_stack_32 ptr

type pcre2_callout_block_32
	version as ulong
	callout_number as ulong
	capture_top as ulong
	capture_last as ulong
	offset_vector as uinteger ptr
	mark as PCRE2_SPTR32
	subject as PCRE2_SPTR32
	subject_length as uinteger
	start_match as uinteger
	current_position as uinteger
	pattern_position as uinteger
	next_item_length as uinteger
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR32
end type

type pcre2_callout_enumerate_block_32
	version as ulong
	pattern_position as uinteger
	next_item_length as uinteger
	callout_number as ulong
	callout_string_offset as uinteger
	callout_string_length as uinteger
	callout_string as PCRE2_SPTR32
end type

declare function pcre2_config_32(byval as ulong, byval as any ptr) as long
declare function pcre2_general_context_copy_32(byval as pcre2_general_context_32 ptr) as pcre2_general_context_32 ptr
declare function pcre2_general_context_create_32(byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as pcre2_general_context_32 ptr
declare sub pcre2_general_context_free_32(byval as pcre2_general_context_32 ptr)
declare function pcre2_compile_context_copy_32(byval as pcre2_compile_context_32 ptr) as pcre2_compile_context_32 ptr
declare function pcre2_compile_context_create_32(byval as pcre2_general_context_32 ptr) as pcre2_compile_context_32 ptr
declare sub pcre2_compile_context_free_32(byval as pcre2_compile_context_32 ptr)
declare function pcre2_set_bsr_32(byval as pcre2_compile_context_32 ptr, byval as ulong) as long
declare function pcre2_set_character_tables_32(byval as pcre2_compile_context_32 ptr, byval as const ubyte ptr) as long
declare function pcre2_set_newline_32(byval as pcre2_compile_context_32 ptr, byval as ulong) as long
declare function pcre2_set_parens_nest_limit_32(byval as pcre2_compile_context_32 ptr, byval as ulong) as long
declare function pcre2_set_compile_recursion_guard_32(byval as pcre2_compile_context_32 ptr, byval as function(byval as ulong, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_context_copy_32(byval as pcre2_match_context_32 ptr) as pcre2_match_context_32 ptr
declare function pcre2_match_context_create_32(byval as pcre2_general_context_32 ptr) as pcre2_match_context_32 ptr
declare sub pcre2_match_context_free_32(byval as pcre2_match_context_32 ptr)
declare function pcre2_set_callout_32(byval as pcre2_match_context_32 ptr, byval as function(byval as pcre2_callout_block_32 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_set_match_limit_32(byval as pcre2_match_context_32 ptr, byval as ulong) as long
declare function pcre2_set_recursion_limit_32(byval as pcre2_match_context_32 ptr, byval as ulong) as long
declare function pcre2_set_recursion_memory_management_32(byval as pcre2_match_context_32 ptr, byval as function(byval as uinteger, byval as any ptr) as any ptr, byval as sub(byval as any ptr, byval as any ptr), byval as any ptr) as long
declare function pcre2_compile_32(byval as PCRE2_SPTR32, byval as uinteger, byval as ulong, byval as long ptr, byval as uinteger ptr, byval as pcre2_compile_context_32 ptr) as pcre2_code_32 ptr
declare sub pcre2_code_free_32(byval as pcre2_code_32 ptr)
declare function pcre2_pattern_info_32(byval as const pcre2_code_32 ptr, byval as ulong, byval as any ptr) as long
declare function pcre2_callout_enumerate_32(byval as const pcre2_code_32 ptr, byval as function(byval as pcre2_callout_enumerate_block_32 ptr, byval as any ptr) as long, byval as any ptr) as long
declare function pcre2_match_data_create_32(byval as ulong, byval as pcre2_general_context_32 ptr) as pcre2_match_data_32 ptr
declare function pcre2_match_data_create_from_pattern_32(byval as const pcre2_code_32 ptr, byval as pcre2_general_context_32 ptr) as pcre2_match_data_32 ptr
declare function pcre2_dfa_match_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_32 ptr, byval as pcre2_match_context_32 ptr, byval as long ptr, byval as uinteger) as long
declare function pcre2_match_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_32 ptr, byval as pcre2_match_context_32 ptr) as long
declare sub pcre2_match_data_free_32(byval as pcre2_match_data_32 ptr)
declare function pcre2_get_mark_32(byval as pcre2_match_data_32 ptr) as PCRE2_SPTR32
declare function pcre2_get_ovector_count_32(byval as pcre2_match_data_32 ptr) as ulong
declare function pcre2_get_ovector_pointer_32(byval as pcre2_match_data_32 ptr) as uinteger ptr
declare function pcre2_get_startchar_32(byval as pcre2_match_data_32 ptr) as uinteger
declare function pcre2_substring_copy_byname_32(byval as pcre2_match_data_32 ptr, byval as PCRE2_SPTR32, byval as PCRE2_UCHAR32 ptr, byval as uinteger ptr) as long
declare function pcre2_substring_copy_bynumber_32(byval as pcre2_match_data_32 ptr, byval as ulong, byval as PCRE2_UCHAR32 ptr, byval as uinteger ptr) as long
declare sub pcre2_substring_free_32(byval as PCRE2_UCHAR32 ptr)
declare function pcre2_substring_get_byname_32(byval as pcre2_match_data_32 ptr, byval as PCRE2_SPTR32, byval as PCRE2_UCHAR32 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_get_bynumber_32(byval as pcre2_match_data_32 ptr, byval as ulong, byval as PCRE2_UCHAR32 ptr ptr, byval as uinteger ptr) as long
declare function pcre2_substring_length_byname_32(byval as pcre2_match_data_32 ptr, byval as PCRE2_SPTR32, byval as uinteger ptr) as long
declare function pcre2_substring_length_bynumber_32(byval as pcre2_match_data_32 ptr, byval as ulong, byval as uinteger ptr) as long
declare function pcre2_substring_nametable_scan_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32, byval as PCRE2_SPTR32 ptr, byval as PCRE2_SPTR32 ptr) as long
declare function pcre2_substring_number_from_name_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32) as long
declare sub pcre2_substring_list_free_32(byval as PCRE2_SPTR32 ptr)
declare function pcre2_substring_list_get_32(byval as pcre2_match_data_32 ptr, byval as PCRE2_UCHAR32 ptr ptr ptr, byval as uinteger ptr ptr) as long
declare function pcre2_serialize_encode_32(byval as const pcre2_code_32 ptr ptr, byval as long, byval as ubyte ptr ptr, byval as uinteger ptr, byval as pcre2_general_context_32 ptr) as long
declare function pcre2_serialize_decode_32(byval as pcre2_code_32 ptr ptr, byval as long, byval as const ubyte ptr, byval as pcre2_general_context_32 ptr) as long
declare function pcre2_serialize_get_number_of_codes_32(byval as const ubyte ptr) as long
declare sub pcre2_serialize_free_32(byval as ubyte ptr)
declare function pcre2_substitute_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_32 ptr, byval as pcre2_match_context_32 ptr, byval as PCRE2_SPTR32, byval as uinteger, byval as PCRE2_UCHAR32 ptr, byval as uinteger ptr) as long
declare function pcre2_jit_compile_32(byval as pcre2_code_32 ptr, byval as ulong) as long
declare function pcre2_jit_match_32(byval as const pcre2_code_32 ptr, byval as PCRE2_SPTR32, byval as uinteger, byval as uinteger, byval as ulong, byval as pcre2_match_data_32 ptr, byval as pcre2_match_context_32 ptr) as long
declare sub pcre2_jit_free_unused_memory_32(byval as pcre2_general_context_32 ptr)
declare function pcre2_jit_stack_create_32(byval as uinteger, byval as uinteger, byval as pcre2_general_context_32 ptr) as pcre2_jit_stack_32 ptr
declare sub pcre2_jit_stack_assign_32(byval as pcre2_match_context_32 ptr, byval as pcre2_jit_callback_32, byval as any ptr)
declare sub pcre2_jit_stack_free_32(byval as pcre2_jit_stack_32 ptr)
declare function pcre2_get_error_message_32(byval as long, byval as PCRE2_UCHAR32 ptr, byval as uinteger) as long
declare function pcre2_maketables_32(byval as pcre2_general_context_32 ptr) as const ubyte ptr
#undef PCRE2_LOCAL_WIDTH
#undef PCRE2_SUFFIX

#if PCRE2_CODE_UNIT_WIDTH = 0
	#undef PCRE2_JOIN
	#undef PCRE2_GLUE
	#define PCRE2_SUFFIX(a) a
#else
	#define PCRE2_SUFFIX(a) PCRE2_GLUE(a, PCRE2_CODE_UNIT_WIDTH)
#endif

end extern
