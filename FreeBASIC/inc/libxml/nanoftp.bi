''
''
'' nanoftp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_nanoftp_bi__
#define __xml_nanoftp_bi__

#include once "libxml/xmlversion.bi"

type ftpListCallback as any ptr
type ftpDataCallback as any ptr

declare sub xmlNanoFTPInit cdecl alias "xmlNanoFTPInit" ()
declare sub xmlNanoFTPCleanup cdecl alias "xmlNanoFTPCleanup" ()
declare function xmlNanoFTPNewCtxt cdecl alias "xmlNanoFTPNewCtxt" (byval URL as zstring ptr) as any ptr
declare sub xmlNanoFTPFreeCtxt cdecl alias "xmlNanoFTPFreeCtxt" (byval ctx as any ptr)
declare function xmlNanoFTPConnectTo cdecl alias "xmlNanoFTPConnectTo" (byval server as zstring ptr, byval port as integer) as any ptr
declare function xmlNanoFTPOpen cdecl alias "xmlNanoFTPOpen" (byval URL as zstring ptr) as any ptr
declare function xmlNanoFTPConnect cdecl alias "xmlNanoFTPConnect" (byval ctx as any ptr) as integer
declare function xmlNanoFTPClose cdecl alias "xmlNanoFTPClose" (byval ctx as any ptr) as integer
declare function xmlNanoFTPQuit cdecl alias "xmlNanoFTPQuit" (byval ctx as any ptr) as integer
declare sub xmlNanoFTPScanProxy cdecl alias "xmlNanoFTPScanProxy" (byval URL as zstring ptr)
declare sub xmlNanoFTPProxy cdecl alias "xmlNanoFTPProxy" (byval host as zstring ptr, byval port as integer, byval user as zstring ptr, byval passwd as zstring ptr, byval type as integer)
declare function xmlNanoFTPUpdateURL cdecl alias "xmlNanoFTPUpdateURL" (byval ctx as any ptr, byval URL as zstring ptr) as integer
declare function xmlNanoFTPGetResponse cdecl alias "xmlNanoFTPGetResponse" (byval ctx as any ptr) as integer
declare function xmlNanoFTPCheckResponse cdecl alias "xmlNanoFTPCheckResponse" (byval ctx as any ptr) as integer
declare function xmlNanoFTPCwd cdecl alias "xmlNanoFTPCwd" (byval ctx as any ptr, byval directory as zstring ptr) as integer
declare function xmlNanoFTPDele cdecl alias "xmlNanoFTPDele" (byval ctx as any ptr, byval file as zstring ptr) as integer
declare function xmlNanoFTPGetConnection cdecl alias "xmlNanoFTPGetConnection" (byval ctx as any ptr) as integer
declare function xmlNanoFTPCloseConnection cdecl alias "xmlNanoFTPCloseConnection" (byval ctx as any ptr) as integer
declare function xmlNanoFTPList cdecl alias "xmlNanoFTPList" (byval ctx as any ptr, byval callback as ftpListCallback, byval userData as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPGetSocket cdecl alias "xmlNanoFTPGetSocket" (byval ctx as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPGet cdecl alias "xmlNanoFTPGet" (byval ctx as any ptr, byval callback as ftpDataCallback, byval userData as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPRead cdecl alias "xmlNanoFTPRead" (byval ctx as any ptr, byval dest as any ptr, byval len as integer) as integer

#endif
