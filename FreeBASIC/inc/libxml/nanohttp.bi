''
''
'' nanohttp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __nanohttp_bi__
#define __nanohttp_bi__

#include once "libxml/xmlversion.bi"

declare sub xmlNanoHTTPInit cdecl alias "xmlNanoHTTPInit" ()
declare sub xmlNanoHTTPCleanup cdecl alias "xmlNanoHTTPCleanup" ()
declare sub xmlNanoHTTPScanProxy cdecl alias "xmlNanoHTTPScanProxy" (byval URL as string)
declare function xmlNanoHTTPFetch cdecl alias "xmlNanoHTTPFetch" (byval URL as string, byval filename as string, byval contentType as byte ptr ptr) as integer
declare function xmlNanoHTTPMethod cdecl alias "xmlNanoHTTPMethod" (byval URL as string, byval method as string, byval input as string, byval contentType as byte ptr ptr, byval headers as string, byval ilen as integer) as any ptr
declare function xmlNanoHTTPMethodRedir cdecl alias "xmlNanoHTTPMethodRedir" (byval URL as string, byval method as string, byval input as string, byval contentType as byte ptr ptr, byval redir as byte ptr ptr, byval headers as string, byval ilen as integer) as any ptr
declare function xmlNanoHTTPOpen cdecl alias "xmlNanoHTTPOpen" (byval URL as string, byval contentType as byte ptr ptr) as any ptr
declare function xmlNanoHTTPOpenRedir cdecl alias "xmlNanoHTTPOpenRedir" (byval URL as string, byval contentType as byte ptr ptr, byval redir as byte ptr ptr) as any ptr
declare function xmlNanoHTTPReturnCode cdecl alias "xmlNanoHTTPReturnCode" (byval ctx as any ptr) as integer
declare function xmlNanoHTTPAuthHeader cdecl alias "xmlNanoHTTPAuthHeader" (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPRedir cdecl alias "xmlNanoHTTPRedir" (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPContentLength cdecl alias "xmlNanoHTTPContentLength" (byval ctx as any ptr) as integer
declare function xmlNanoHTTPEncoding cdecl alias "xmlNanoHTTPEncoding" (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPMimeType cdecl alias "xmlNanoHTTPMimeType" (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPRead cdecl alias "xmlNanoHTTPRead" (byval ctx as any ptr, byval dest as any ptr, byval len as integer) as integer
declare function xmlNanoHTTPSave cdecl alias "xmlNanoHTTPSave" (byval ctxt as any ptr, byval filename as string) as integer
declare sub xmlNanoHTTPClose cdecl alias "xmlNanoHTTPClose" (byval ctx as any ptr)

#endif
