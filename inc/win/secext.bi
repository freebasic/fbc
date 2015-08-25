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

#include once "winapifamily.bi"
#include once "_mingw_unicode.bi"
#include once "sspi.bi"

extern "Windows"

#define __SECEXT_H__

type EXTENDED_NAME_FORMAT as long
enum
	NameUnknown = 0
	NameFullyQualifiedDN = 1
	NameSamCompatible = 2
	NameDisplay = 3
	NameUniqueId = 6
	NameCanonical = 7
	NameUserPrincipal = 8
	NameCanonicalEx = 9
	NameServicePrincipal = 10
	NameDnsDomain = 12
	NameGivenName = 13
	NameSurname = 14
end enum

type PEXTENDED_NAME_FORMAT as EXTENDED_NAME_FORMAT ptr
declare function GetUserNameExA(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPSTR, byval nSize as PULONG) as WINBOOLEAN

#ifndef UNICODE
	declare function GetUserNameEx alias "GetUserNameExA"(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

declare function GetUserNameExW(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPWSTR, byval nSize as PULONG) as WINBOOLEAN

#ifdef UNICODE
	declare function GetUserNameEx alias "GetUserNameExW"(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPWSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

declare function GetComputerObjectNameA(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPSTR, byval nSize as PULONG) as WINBOOLEAN

#ifndef UNICODE
	declare function GetComputerObjectName alias "GetComputerObjectNameA"(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

declare function GetComputerObjectNameW(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPWSTR, byval nSize as PULONG) as WINBOOLEAN

#ifdef UNICODE
	declare function GetComputerObjectName alias "GetComputerObjectNameW"(byval NameFormat as EXTENDED_NAME_FORMAT, byval lpNameBuffer as LPWSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

declare function TranslateNameA(byval lpAccountName as LPCSTR, byval AccountNameFormat as EXTENDED_NAME_FORMAT, byval DesiredNameFormat as EXTENDED_NAME_FORMAT, byval lpTranslatedName as LPSTR, byval nSize as PULONG) as WINBOOLEAN

#ifndef UNICODE
	declare function TranslateName alias "TranslateNameA"(byval lpAccountName as LPCSTR, byval AccountNameFormat as EXTENDED_NAME_FORMAT, byval DesiredNameFormat as EXTENDED_NAME_FORMAT, byval lpTranslatedName as LPSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

declare function TranslateNameW(byval lpAccountName as LPCWSTR, byval AccountNameFormat as EXTENDED_NAME_FORMAT, byval DesiredNameFormat as EXTENDED_NAME_FORMAT, byval lpTranslatedName as LPWSTR, byval nSize as PULONG) as WINBOOLEAN

#ifdef UNICODE
	declare function TranslateName alias "TranslateNameW"(byval lpAccountName as LPCWSTR, byval AccountNameFormat as EXTENDED_NAME_FORMAT, byval DesiredNameFormat as EXTENDED_NAME_FORMAT, byval lpTranslatedName as LPWSTR, byval nSize as PULONG) as WINBOOLEAN
#endif

end extern
