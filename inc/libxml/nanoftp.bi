'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "libxml/xmlversion.bi"

#ifdef __FB_WIN32__
	#include once "win/winsock2.bi"
#endif

extern "C"

#define __NANO_FTP_H__

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	type SOCKET as long
	#undef INVALID_SOCKET
	const INVALID_SOCKET = -1
#endif

type ftpListCallback as sub(byval userData as any ptr, byval filename as const zstring ptr, byval attrib as const zstring ptr, byval owner as const zstring ptr, byval group as const zstring ptr, byval size as culong, byval links as long, byval year as long, byval month as const zstring ptr, byval day as long, byval hour as long, byval minute as long)
type ftpDataCallback as sub(byval userData as any ptr, byval data as const zstring ptr, byval len as long)
declare sub xmlNanoFTPInit()
declare sub xmlNanoFTPCleanup()
declare function xmlNanoFTPNewCtxt(byval URL as const zstring ptr) as any ptr
declare sub xmlNanoFTPFreeCtxt(byval ctx as any ptr)
declare function xmlNanoFTPConnectTo(byval server as const zstring ptr, byval port as long) as any ptr
declare function xmlNanoFTPOpen(byval URL as const zstring ptr) as any ptr
declare function xmlNanoFTPConnect(byval ctx as any ptr) as long
declare function xmlNanoFTPClose(byval ctx as any ptr) as long
declare function xmlNanoFTPQuit(byval ctx as any ptr) as long
declare sub xmlNanoFTPScanProxy(byval URL as const zstring ptr)
declare sub xmlNanoFTPProxy(byval host as const zstring ptr, byval port as long, byval user as const zstring ptr, byval passwd as const zstring ptr, byval type as long)
declare function xmlNanoFTPUpdateURL(byval ctx as any ptr, byval URL as const zstring ptr) as long
declare function xmlNanoFTPGetResponse(byval ctx as any ptr) as long
declare function xmlNanoFTPCheckResponse(byval ctx as any ptr) as long
declare function xmlNanoFTPCwd(byval ctx as any ptr, byval directory as const zstring ptr) as long
declare function xmlNanoFTPDele(byval ctx as any ptr, byval file as const zstring ptr) as long

#ifdef __FB_WIN32__
	declare function xmlNanoFTPGetConnection(byval ctx as any ptr) as SOCKET
#else
	declare function xmlNanoFTPGetConnection(byval ctx as any ptr) as long
#endif

declare function xmlNanoFTPCloseConnection(byval ctx as any ptr) as long
declare function xmlNanoFTPList(byval ctx as any ptr, byval callback as ftpListCallback, byval userData as any ptr, byval filename as const zstring ptr) as long

#ifdef __FB_WIN32__
	declare function xmlNanoFTPGetSocket(byval ctx as any ptr, byval filename as const zstring ptr) as SOCKET
#else
	declare function xmlNanoFTPGetSocket(byval ctx as any ptr, byval filename as const zstring ptr) as long
#endif

declare function xmlNanoFTPGet(byval ctx as any ptr, byval callback as ftpDataCallback, byval userData as any ptr, byval filename as const zstring ptr) as long
declare function xmlNanoFTPRead(byval ctx as any ptr, byval dest as any ptr, byval len as long) as long

end extern
