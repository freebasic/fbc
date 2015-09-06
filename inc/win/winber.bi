'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "wldap32"

#include once "winapifamily.bi"

extern "C"

#define _WINBER_DEFINED_
const LBER_ERROR = &hffffffff
const LBER_DEFAULT = &hffffffff

type ber_tag_t as ulong
type ber_int_t as long
type ber_uint_t as ulong
type ber_len_t as ulong
type ber_slen_t as long
type BerElement as BerElement_
type BERVAL as BERVAL_

declare function ber_init(byval pBerVal as BERVAL ptr) as BerElement ptr
declare sub ber_free(byval pBerElement as BerElement ptr, byval fbuf as INT_)
declare sub ber_bvfree(byval pBerVal as BERVAL ptr)
type PBERVAL as PBERVAL_
declare sub ber_bvecfree(byval pBerVal as PBERVAL ptr)
declare function ber_bvdup(byval pBerVal as BERVAL ptr) as BERVAL ptr
declare function ber_alloc_t(byval options as INT_) as BerElement ptr
declare function ber_skip_tag(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr) as ULONG
declare function ber_peek_tag(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr) as ULONG
declare function ber_first_element(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr, byval ppOpaque as CHAR ptr ptr) as ULONG
declare function ber_next_element(byval pBerElement as BerElement ptr, byval pLen as ULONG ptr, byval opaque as CHAR ptr) as ULONG
declare function ber_flatten(byval pBerElement as BerElement ptr, byval pBerVal as PBERVAL ptr) as INT_
declare function ber_printf(byval pBerElement as BerElement ptr, byval fmt as PSTR, ...) as INT_
declare function ber_scanf(byval pBerElement as BerElement ptr, byval fmt as PSTR, ...) as ULONG

end extern
