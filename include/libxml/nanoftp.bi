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

#include once "xmlversion.bi"

type ftpListCallback as any ptr
type ftpDataCallback as any ptr

extern "c"
declare sub xmlNanoFTPInit ()
declare sub xmlNanoFTPCleanup ()
declare function xmlNanoFTPNewCtxt (byval URL as zstring ptr) as any ptr
declare sub xmlNanoFTPFreeCtxt (byval ctx as any ptr)
declare function xmlNanoFTPConnectTo (byval server as zstring ptr, byval port as integer) as any ptr
declare function xmlNanoFTPOpen (byval URL as zstring ptr) as any ptr
declare function xmlNanoFTPConnect (byval ctx as any ptr) as integer
declare function xmlNanoFTPClose (byval ctx as any ptr) as integer
declare function xmlNanoFTPQuit (byval ctx as any ptr) as integer
declare sub xmlNanoFTPScanProxy (byval URL as zstring ptr)
declare sub xmlNanoFTPProxy (byval host as zstring ptr, byval port as integer, byval user as zstring ptr, byval passwd as zstring ptr, byval type as integer)
declare function xmlNanoFTPUpdateURL (byval ctx as any ptr, byval URL as zstring ptr) as integer
declare function xmlNanoFTPGetResponse (byval ctx as any ptr) as integer
declare function xmlNanoFTPCheckResponse (byval ctx as any ptr) as integer
declare function xmlNanoFTPCwd (byval ctx as any ptr, byval directory as zstring ptr) as integer
declare function xmlNanoFTPDele (byval ctx as any ptr, byval file as zstring ptr) as integer
declare function xmlNanoFTPGetConnection (byval ctx as any ptr) as integer
declare function xmlNanoFTPCloseConnection (byval ctx as any ptr) as integer
declare function xmlNanoFTPList (byval ctx as any ptr, byval callback as ftpListCallback, byval userData as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPGetSocket (byval ctx as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPGet (byval ctx as any ptr, byval callback as ftpDataCallback, byval userData as any ptr, byval filename as zstring ptr) as integer
declare function xmlNanoFTPRead (byval ctx as any ptr, byval dest as any ptr, byval len as integer) as integer
end extern

#endif
