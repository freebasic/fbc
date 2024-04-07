'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   FreeBASIC development team

#pragma once

#inclib "uuid"

#include once "_mingw_unicode.bi"

extern "C"

#define _ISGUIDS_H_
extern CLSID_InternetShortcut as const GUID
extern IID_IUniformResourceLocatorA as const GUID

#ifndef UNICODE
	extern IID_IUniformResourceLocator alias "IID_IUniformResourceLocatorA" as const GUID
#endif

extern IID_IUniformResourceLocatorW as const GUID

#ifdef UNICODE
	extern IID_IUniformResourceLocator alias "IID_IUniformResourceLocatorW" as const GUID
#endif

end extern
