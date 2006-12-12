''
''
'' convert -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __disphelper_convert_bi__
#define __disphelper_convert_bi__

#include once "win/objbase.bi"

extern "c"
declare function ConvertFileTimeToVariantTime (byval pft as FILETIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToFileTime (byval date as DATE_, byval pft as FILETIME ptr) as HRESULT
declare function ConvertVariantTimeToSystemTime (byval date as DATE_, byval pSystemTime as SYSTEMTIME ptr) as HRESULT
declare function ConvertSystemTimeToVariantTime (byval pSystemTime as SYSTEMTIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertTimeTToVariantTime (byval timeT as time_t, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToTimeT (byval date as DATE_, byval pTimeT as time_t ptr) as HRESULT
declare function ConvertAnsiStrToBStr (byval szAnsiIn as LPCSTR, byval lpBstrOut as BSTR ptr) as HRESULT
declare function ConvertBStrToAnsiStr (byval bstrIn as BSTR, byval lpszOut as LPSTR ptr) as HRESULT
end extern

#endif
