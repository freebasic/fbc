''
''
'' nanohttp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_nanohttp_bi__
#define __xml_nanohttp_bi__

#include once "xmlversion.bi"

extern "c"
declare sub xmlNanoHTTPInit ()
declare sub xmlNanoHTTPCleanup ()
declare sub xmlNanoHTTPScanProxy (byval URL as zstring ptr)
declare function xmlNanoHTTPFetch (byval URL as zstring ptr, byval filename as zstring ptr, byval contentType as byte ptr ptr) as integer
declare function xmlNanoHTTPMethod (byval URL as zstring ptr, byval method as zstring ptr, byval input as zstring ptr, byval contentType as byte ptr ptr, byval headers as zstring ptr, byval ilen as integer) as any ptr
declare function xmlNanoHTTPMethodRedir (byval URL as zstring ptr, byval method as zstring ptr, byval input as zstring ptr, byval contentType as byte ptr ptr, byval redir as byte ptr ptr, byval headers as zstring ptr, byval ilen as integer) as any ptr
declare function xmlNanoHTTPOpen (byval URL as zstring ptr, byval contentType as byte ptr ptr) as any ptr
declare function xmlNanoHTTPOpenRedir (byval URL as zstring ptr, byval contentType as byte ptr ptr, byval redir as byte ptr ptr) as any ptr
declare function xmlNanoHTTPReturnCode (byval ctx as any ptr) as integer
declare function xmlNanoHTTPAuthHeader (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPRedir (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPContentLength (byval ctx as any ptr) as integer
declare function xmlNanoHTTPEncoding (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPMimeType (byval ctx as any ptr) as byte ptr
declare function xmlNanoHTTPRead (byval ctx as any ptr, byval dest as any ptr, byval len as integer) as integer
declare function xmlNanoHTTPSave (byval ctxt as any ptr, byval filename as zstring ptr) as integer
declare sub xmlNanoHTTPClose (byval ctx as any ptr)
end extern

#endif
