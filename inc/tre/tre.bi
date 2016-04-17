'' FreeBASIC binding for tre-0.8.0
''
'' based on the C header files:
''   This is the license, copyright notice, and disclaimer for TRE, a regex
''   matching package (library and tools) with support for approximate
''   matching.
''
''   Copyright (c) 2001-2009 Ville Laurikari <vl@iki.fi>
''   All rights reserved.
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''
''     1. Redistributions of source code must retain the above copyright
''        notice, this list of conditions and the following disclaimer.
''
''     2. Redistributions in binary form must reproduce the above copyright
''        notice, this list of conditions and the following disclaimer in the
''        documentation and/or other materials provided with the distribution.
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS
''   ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
''   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
''   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
''   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
''   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
''   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "tre"

#include once "crt/sys/types.bi"

#ifdef TRE_USE_SYSTEM_REGEX_H
	#include once "crt/regex.bi"
#endif

#include once "crt/wchar.bi"

extern "C"

const TRE_H = 1

#ifdef TRE_USE_SYSTEM_REGEX_H
	const REG_OK = 0
	type reg_errcode_t as long
	const REG_LITERAL = &h1000
#else
	type regoff_t as long

	type regex_t
		re_nsub as uinteger
		value as any ptr
	end type

	type regmatch_t
		rm_so as regoff_t
		rm_eo as regoff_t
	end type

	type reg_errcode_t as long
	enum
		REG_OK = 0
		REG_NOMATCH
		REG_BADPAT
		REG_ECOLLATE
		REG_ECTYPE
		REG_EESCAPE
		REG_ESUBREG
		REG_EBRACK
		REG_EPAREN
		REG_EBRACE
		REG_BADBR
		REG_ERANGE
		REG_ESPACE
		REG_BADRPT
	end enum

	const REG_EXTENDED = 1
	const REG_ICASE = REG_EXTENDED shl 1
	const REG_NEWLINE = REG_ICASE shl 1
	const REG_NOSUB = REG_NEWLINE shl 1
#endif

const REG_BASIC = 0

#ifndef TRE_USE_SYSTEM_REGEX_H
	const REG_LITERAL = REG_NOSUB shl 1
#endif

const REG_RIGHT_ASSOC = REG_LITERAL shl 1
const REG_UNGREEDY = REG_RIGHT_ASSOC shl 1

#ifdef TRE_USE_SYSTEM_REGEX_H
	const REG_APPROX_MATCHER = &h1000
#else
	const REG_NOTBOL = 1
	const REG_NOTEOL = REG_NOTBOL shl 1
	const REG_APPROX_MATCHER = REG_NOTEOL shl 1
#endif

const REG_BACKTRACKING_MATCHER = REG_APPROX_MATCHER shl 1
const REG_NOSPEC = REG_LITERAL
#undef RE_DUP_MAX
const RE_DUP_MAX = 255

#ifdef TRE_USE_SYSTEM_REGEX_H
	declare function tre_regcomp alias "regcomp"(byval preg as regex_t ptr, byval regex as const zstring ptr, byval cflags as long) as long
	declare function tre_regexec alias "regexec"(byval preg as const regex_t ptr, byval string as const zstring ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
	declare function tre_regerror alias "regerror"(byval errcode as long, byval preg as const regex_t ptr, byval errbuf as zstring ptr, byval errbuf_size as uinteger) as uinteger
	declare sub tre_regfree alias "regfree"(byval preg as regex_t ptr)
#else
	declare function tre_regcomp(byval preg as regex_t ptr, byval regex as const zstring ptr, byval cflags as long) as long
	declare function tre_regexec(byval preg as const regex_t ptr, byval string as const zstring ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
	declare function tre_regerror(byval errcode as long, byval preg as const regex_t ptr, byval errbuf as zstring ptr, byval errbuf_size as uinteger) as uinteger
	declare sub tre_regfree(byval preg as regex_t ptr)
#endif

declare function tre_regwcomp(byval preg as regex_t ptr, byval regex as const wstring ptr, byval cflags as long) as long
declare function tre_regwexec(byval preg as const regex_t ptr, byval string as const wstring ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
declare function tre_regncomp(byval preg as regex_t ptr, byval regex as const zstring ptr, byval len as uinteger, byval cflags as long) as long
declare function tre_regnexec(byval preg as const regex_t ptr, byval string as const zstring ptr, byval len as uinteger, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
declare function tre_regwncomp(byval preg as regex_t ptr, byval regex as const wstring ptr, byval len as uinteger, byval cflags as long) as long
declare function tre_regwnexec(byval preg as const regex_t ptr, byval string as const wstring ptr, byval len as uinteger, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long

type regaparams_t
	cost_ins as long
	cost_del as long
	cost_subst as long
	max_cost as long
	max_ins as long
	max_del as long
	max_subst as long
	max_err as long
end type

type regamatch_t
	nmatch as uinteger
	pmatch as regmatch_t ptr
	cost as long
	num_ins as long
	num_del as long
	num_subst as long
end type

declare function tre_regaexec(byval preg as const regex_t ptr, byval string as const zstring ptr, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
declare function tre_reganexec(byval preg as const regex_t ptr, byval string as const zstring ptr, byval len as uinteger, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
declare function tre_regawexec(byval preg as const regex_t ptr, byval string as const wstring ptr, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
declare function tre_regawnexec(byval preg as const regex_t ptr, byval string as const wstring ptr, byval len as uinteger, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
declare sub tre_regaparams_default(byval params as regaparams_t ptr)
type tre_char_t as wstring

type tre_str_source
	get_next_char as function(byval c as tre_char_t ptr, byval pos_add as ulong ptr, byval context as any ptr) as long
	rewind as sub(byval pos as uinteger, byval context as any ptr)
	compare as function(byval pos1 as uinteger, byval pos2 as uinteger, byval len as uinteger, byval context as any ptr) as long
	context as any ptr
end type

declare function tre_reguexec(byval preg as const regex_t ptr, byval string as const tre_str_source ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
declare function tre_version() as zstring ptr
declare function tre_config(byval query as long, byval result as any ptr) as long

enum
	TRE_CONFIG_APPROX
	TRE_CONFIG_WCHAR
	TRE_CONFIG_MULTIBYTE
	TRE_CONFIG_SYSTEM_ABI
	TRE_CONFIG_VERSION
end enum

declare function tre_have_backrefs(byval preg as const regex_t ptr) as long
declare function tre_have_approx(byval preg as const regex_t ptr) as long

end extern
