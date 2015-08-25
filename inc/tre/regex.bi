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

#include once "tre.bi"

extern "C"

const TRE_REGEX_H = 1

#ifndef TRE_USE_SYSTEM_REGEX_H
	declare function regcomp alias "tre_regcomp"(byval preg as regex_t ptr, byval regex as const zstring ptr, byval cflags as long) as long
	declare function regerror alias "tre_regerror"(byval errcode as long, byval preg as const regex_t ptr, byval errbuf as zstring ptr, byval errbuf_size as uinteger) as uinteger
	declare function regexec alias "tre_regexec"(byval preg as const regex_t ptr, byval string as const zstring ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
	declare sub regfree alias "tre_regfree"(byval preg as regex_t ptr)
#endif

#define regacomp tre_regacomp
declare function regaexec alias "tre_regaexec"(byval preg as const regex_t ptr, byval string as const zstring ptr, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
#define regancomp tre_regancomp
declare function reganexec alias "tre_reganexec"(byval preg as const regex_t ptr, byval string as const zstring ptr, byval len as uinteger, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
#define regawncomp tre_regawncomp
declare function regawnexec alias "tre_regawnexec"(byval preg as const regex_t ptr, byval string as const wstring ptr, byval len as uinteger, byval match as regamatch_t ptr, byval params as regaparams_t, byval eflags as long) as long
declare function regncomp alias "tre_regncomp"(byval preg as regex_t ptr, byval regex as const zstring ptr, byval len as uinteger, byval cflags as long) as long
declare function regnexec alias "tre_regnexec"(byval preg as const regex_t ptr, byval string as const zstring ptr, byval len as uinteger, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
declare function regwcomp alias "tre_regwcomp"(byval preg as regex_t ptr, byval regex as const wstring ptr, byval cflags as long) as long
declare function regwexec alias "tre_regwexec"(byval preg as const regex_t ptr, byval string as const wstring ptr, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long
declare function regwncomp alias "tre_regwncomp"(byval preg as regex_t ptr, byval regex as const wstring ptr, byval len as uinteger, byval cflags as long) as long
declare function regwnexec alias "tre_regwnexec"(byval preg as const regex_t ptr, byval string as const wstring ptr, byval len as uinteger, byval nmatch as uinteger, byval pmatch as regmatch_t ptr, byval eflags as long) as long

end extern
