'' FreeBASIC binding for e2fsprogs-libs-1.42.13
''
'' based on the C header files:
''   Public include file for the UUID library
''
''   Copyright (C) 1996, 1997, 1998 Theodore Ts'o.
''
''   %Begin-Header%
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''   1. Redistributions of source code must retain the above copyright
''      notice, and the entire permission notice in its entirety,
''      including the disclaimer of warranties.
''   2. Redistributions in binary form must reproduce the above copyright
''      notice, this list of conditions and the following disclaimer in the
''      documentation and/or other materials provided with the distribution.
''   3. The name of the author may not be used to endorse or promote
''      products derived from this software without specific prior
''      written permission.
''
''   THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
''   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
''   WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
''   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
''   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
''   OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
''   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
''   USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
''   DAMAGE.
''   %End-Header%
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "uuid"

#include once "crt/sys/types.bi"
#include once "crt/sys/time.bi"
#include once "crt/time.bi"

extern "C"

#define _UUID_UUID_H
const UUID_VARIANT_NCS = 0
const UUID_VARIANT_DCE = 1
const UUID_VARIANT_MICROSOFT = 2
const UUID_VARIANT_OTHER = 3
const UUID_TYPE_DCE_TIME = 1
const UUID_TYPE_DCE_RANDOM = 4
#define UUID_DEFINE(name,u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15) dim shared name(0 to 15) as const ubyte = {u0,u1,u2,u3,u4,u5,u6,u7,u8,u9,u10,u11,u12,u13,u14,u15}

declare sub uuid_clear(byval uu as ubyte ptr)
declare function uuid_compare(byval uu1 as const ubyte ptr, byval uu2 as const ubyte ptr) as long
declare sub uuid_copy(byval dst as ubyte ptr, byval src as const ubyte ptr)
declare sub uuid_generate(byval out as ubyte ptr)
declare sub uuid_generate_random(byval out as ubyte ptr)
declare sub uuid_generate_time(byval out as ubyte ptr)
declare function uuid_is_null(byval uu as const ubyte ptr) as long
declare function uuid_parse(byval in as const zstring ptr, byval uu as ubyte ptr) as long
declare sub uuid_unparse(byval uu as const ubyte ptr, byval out as zstring ptr)
declare sub uuid_unparse_lower(byval uu as const ubyte ptr, byval out as zstring ptr)
declare sub uuid_unparse_upper(byval uu as const ubyte ptr, byval out as zstring ptr)
declare function uuid_time(byval uu as const ubyte ptr, byval ret_tv as timeval ptr) as time_t
declare function uuid_type(byval uu as const ubyte ptr) as long
declare function uuid_variant(byval uu as const ubyte ptr) as long

end extern
