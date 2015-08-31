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

#include once "_mingw.bi"

#define _API_SET_H_
#define API_SET_PREFIX_NAME_A "API-"
#define API_SET_PREFIX_NAME_U wstr("API-")
#define API_SET_EXTENSION_NAME_A "EXT-"
#define API_SET_EXTENSION_NAME_U wstr("EXT-")
#define API_SET_SCHEMA_NAME ApiSetSchema
#define API_SET_SECTION_NAME ".apiset"
#define API_SET_SCHEMA_SUFFIX wstr(".sys")
const API_SET_SCHEMA_VERSION = 2u
#define API_SET_HELPER_NAME ApiSetHelp
const API_SET_LOAD_SCHEMA_ORDINAL = 1
const API_SET_LOOKUP_ORDINAL = 2
const API_SET_RELEASE_SCHEMA_ORDINAL = 3
#define API_SET_STRING_X(s) #s
#define API_SET_STRING(s) API_SET_STRING_X(s)
#define API_SET_STRING_U_Y(s) wstr(s)
#define API_SET_STRING_U_X(s) API_SET_STRING_U_Y(s)
#define API_SET_STRING_U(s) API_SET_STRING_U_X(API_SET_STRING(s))
#define API_SET_OVERRIDE(X) X##Implementation
#define API_SET_LEGACY_OVERRIDE_DEF(X) scope : X = API_SET_OVERRIDE(X) : end scope
'' TODO: #define API_SET_OVERRIDE_DEF(X) API_SET_LEGACY_OVERRIDE_DEF(X) PRIVATE
#define API_SET_PRIVATE(X) X PRIVATE
#undef API_SET
#undef API_SET_LIBRARY
#define API_SET_LIBRARY(X) LIBRARY X
#define API_SET(X) X
