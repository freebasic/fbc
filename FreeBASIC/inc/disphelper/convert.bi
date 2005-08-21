''
''
'' convert -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __convert_bi__
#define __convert_bi__

#include once "win/objbase.bi"

declare function ConvertFileTimeToVariantTime cdecl alias "ConvertFileTimeToVariantTime" (byval pft as FILETIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToFileTime cdecl alias "ConvertVariantTimeToFileTime" (byval date as DATE_, byval pft as FILETIME ptr) as HRESULT
declare function ConvertVariantTimeToSystemTime cdecl alias "ConvertVariantTimeToSystemTime" (byval date as DATE_, byval pSystemTime as SYSTEMTIME ptr) as HRESULT
declare function ConvertSystemTimeToVariantTime cdecl alias "ConvertSystemTimeToVariantTime" (byval pSystemTime as SYSTEMTIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertTimeTToVariantTime cdecl alias "ConvertTimeTToVariantTime" (byval timeT as time_t, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToTimeT cdecl alias "ConvertVariantTimeToTimeT" (byval date as DATE_, byval pTimeT as time_t ptr) as HRESULT
declare function ConvertAnsiStrToBStr cdecl alias "ConvertAnsiStrToBStr" (byval szAnsiIn as LPCSTR, byval lpBstrOut as BSTR ptr) as HRESULT
declare function ConvertBStrToAnsiStr cdecl alias "ConvertBStrToAnsiStr" (byval bstrIn as BSTR, byval lpszOut as LPSTR ptr) as HRESULT

#endif
