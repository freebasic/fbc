''
''
'' xmlregexp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlregexp_bi__
#define __xmlregexp_bi__

#include once "libxml/xmlversion.bi"

#ifndef FILE
type FILE as any
#endif

type xmlRegexp as _xmlRegexp
type xmlRegexpPtr as xmlRegexp ptr
type xmlRegExecCtxt as _xmlRegExecCtxt
type xmlRegExecCtxtPtr as xmlRegExecCtxt ptr

#include once "libxml/tree.bi"

declare function xmlRegexpCompile cdecl alias "xmlRegexpCompile" (byval regexp as string) as xmlRegexpPtr
declare sub xmlRegFreeRegexp cdecl alias "xmlRegFreeRegexp" (byval regexp as xmlRegexpPtr)
declare function xmlRegexpExec cdecl alias "xmlRegexpExec" (byval comp as xmlRegexpPtr, byval value as string) as integer
declare sub xmlRegexpPrint cdecl alias "xmlRegexpPrint" (byval output as FILE ptr, byval regexp as xmlRegexpPtr)
declare function xmlRegexpIsDeterminist cdecl alias "xmlRegexpIsDeterminist" (byval comp as xmlRegexpPtr) as integer

type xmlRegExecCallbacks as any ptr

declare function xmlRegNewExecCtxt cdecl alias "xmlRegNewExecCtxt" (byval comp as xmlRegexpPtr, byval callback as xmlRegExecCallbacks, byval data as any ptr) as xmlRegExecCtxtPtr
declare sub xmlRegFreeExecCtxt cdecl alias "xmlRegFreeExecCtxt" (byval exec as xmlRegExecCtxtPtr)
declare function xmlRegExecPushString cdecl alias "xmlRegExecPushString" (byval exec as xmlRegExecCtxtPtr, byval value as string, byval data as any ptr) as integer
declare function xmlRegExecPushString2 cdecl alias "xmlRegExecPushString2" (byval exec as xmlRegExecCtxtPtr, byval value as string, byval value2 as string, byval data as any ptr) as integer
declare function xmlRegExecNextValues cdecl alias "xmlRegExecNextValues" (byval exec as xmlRegExecCtxtPtr, byval nbval as integer ptr, byval nbneg as integer ptr, byval values as zstring ptr ptr, byval terminal as integer ptr) as integer
declare function xmlRegExecErrInfo cdecl alias "xmlRegExecErrInfo" (byval exec as xmlRegExecCtxtPtr, byval string as zstring ptr ptr, byval nbval as integer ptr, byval nbneg as integer ptr, byval values as zstring ptr ptr, byval terminal as integer ptr) as integer

#endif
