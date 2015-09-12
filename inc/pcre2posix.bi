'' FreeBASIC binding for pcre2-10.20
''
'' based on the C header files:
''    PCRE2 is a library of functions to support regular expressions whose syntax
''   and semantics are as close as possible to those of the Perl 5 language.
''
''                          Written by Philip Hazel
''        Original API code Copyright (c) 1997-2012 University of Cambridge
''            New API code Copyright (c) 2014 University of Cambridge
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

#inclib "pcre2-8"
#inclib "pcre2-posix"

#include once "crt/stdlib.bi"

extern "C"

const REG_ICASE = &h0001
const REG_NEWLINE = &h0002
const REG_NOTBOL = &h0004
const REG_NOTEOL = &h0008
const REG_DOTALL = &h0010
const REG_NOSUB = &h0020
const REG_UTF = &h0040
const REG_STARTEND = &h0080
const REG_NOTEMPTY = &h0100
const REG_UNGREEDY = &h0200
const REG_UCP = &h0400
const REG_EXTENDED = 0

enum
	REG_ASSERT = 1
	REG_BADBR
	REG_BADPAT
	REG_BADRPT
	REG_EBRACE
	REG_EBRACK
	REG_ECOLLATE
	REG_ECTYPE
	REG_EESCAPE
	REG_EMPTY
	REG_EPAREN
	REG_ERANGE
	REG_ESIZE
	REG_ESPACE
	REG_ESUBREG
	REG_INVARG
	REG_NOMATCH
end enum

type regex_t
	re_pcre2_code as any ptr
	re_match_data as any ptr
	re_nsub as uinteger
	re_erroffset as uinteger
end type

type regoff_t as long

type regmatch_t
	rm_so as regoff_t
	rm_eo as regoff_t
end type

declare function regcomp(byval as regex_t ptr, byval as const zstring ptr, byval as long) as long
declare function regexec(byval as const regex_t ptr, byval as const zstring ptr, byval as uinteger, byval as regmatch_t ptr, byval as long) as long
declare function regerror(byval as long, byval as const regex_t ptr, byval as zstring ptr, byval as uinteger) as uinteger
declare sub regfree(byval as regex_t ptr)

end extern
