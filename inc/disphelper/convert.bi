'' FreeBASIC binding for disphelper_081
''
'' based on the C header files:
''   This file is part of the source code for the DispHelper COM helper library.
''   DispHelper allows you to call COM objects with an extremely simple printf style syntax.
''   DispHelper can be used from C++ or even plain C. It works with most Windows compilers
''   including Dev-CPP, Visual C++ and LCC-WIN32. Including DispHelper in your project
''   couldn't be simpler as it is available in a compacted single file version.
''
''   Included with DispHelper are over 20 samples that demonstrate using COM objects
''   including ADO, CDO, Outlook, Eudora, Excel, Word, Internet Explorer, MSHTML,
''   PocketSoap, Word Perfect, MS Agent, SAPI, MSXML, WIA, dexplorer and WMI.
''
''   DispHelper is free open source software provided under the BSD license.
''
''   Find out more and download DispHelper at:
''   http://sourceforge.net/projects/disphelper/
''   http://disphelper.sourceforge.net/
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "win/ole2.bi"
#include once "win/objbase.bi"
#include once "crt/time.bi"

extern "C"

#define CONVERT_H_INCLUDED
declare function ConvertFileTimeToVariantTime(byval pft as FILETIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToFileTime(byval date as DATE_, byval pft as FILETIME ptr) as HRESULT
declare function ConvertVariantTimeToSystemTime(byval date as DATE_, byval pSystemTime as SYSTEMTIME ptr) as HRESULT
declare function ConvertSystemTimeToVariantTime(byval pSystemTime as SYSTEMTIME ptr, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertTimeTToVariantTime(byval timeT as time_t, byval pDate as DATE_ ptr) as HRESULT
declare function ConvertVariantTimeToTimeT(byval date as DATE_, byval pTimeT as time_t ptr) as HRESULT
declare function ConvertAnsiStrToBStr(byval szAnsiIn as LPCSTR, byval lpBstrOut as BSTR ptr) as HRESULT
declare function ConvertBStrToAnsiStr(byval bstrIn as BSTR, byval lpszOut as LPSTR ptr) as HRESULT

end extern
