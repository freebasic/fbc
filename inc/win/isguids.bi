'' FreeBASIC binding for mingw-w64-v3.3.0

#pragma once

#inclib "uuid"

#include once "_mingw_unicode.bi"

extern "C"

#define _ISGUIDS_H_

#ifdef UNICODE
	#define IID_IUniformResourceLocator IID_IUniformResourceLocatorW
#else
	#define IID_IUniformResourceLocator IID_IUniformResourceLocatorA
#endif

extern CLSID_InternetShortcut as const GUID
extern IID_IUniformResourceLocatorA as const GUID
extern IID_IUniformResourceLocatorW as const GUID

end extern
