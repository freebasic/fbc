''
''
'' panoramiXext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __panoramiXext_bi__
#define __panoramiXext_bi__

#define PANORAMIX_MAJOR_VERSION 1
#define PANORAMIX_MINOR_VERSION 1

type XPanoramiXInfo
	window as Window
	screen as integer
	State as integer
	width as integer
	height as integer
	ScreenCount as integer
	eventMask as XID
end type

declare function XPanoramiXAllocInfo cdecl alias "XPanoramiXAllocInfo" () as XPanoramiXInfo ptr

#endif
