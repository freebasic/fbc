''
''
'' xmlregexp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlregexp_bi__
#define __xml_xmlregexp_bi__

#include once "xmlversion.bi"

#ifndef FILE
type FILE as any
#endif

type xmlRegexp as _xmlRegexp
type xmlRegexpPtr as xmlRegexp ptr
type xmlRegExecCtxt as _xmlRegExecCtxt
type xmlRegExecCtxtPtr as xmlRegExecCtxt ptr

#include once "tree.bi"

type xmlRegExecCallbacks as any ptr

extern "c"
declare function xmlRegexpCompile (byval regexp as zstring ptr) as xmlRegexpPtr
declare sub xmlRegFreeRegexp (byval regexp as xmlRegexpPtr)
declare function xmlRegexpExec (byval comp as xmlRegexpPtr, byval value as zstring ptr) as integer
declare sub xmlRegexpPrint (byval output as FILE ptr, byval regexp as xmlRegexpPtr)
declare function xmlRegexpIsDeterminist (byval comp as xmlRegexpPtr) as integer
declare function xmlRegNewExecCtxt (byval comp as xmlRegexpPtr, byval callback as xmlRegExecCallbacks, byval data as any ptr) as xmlRegExecCtxtPtr
declare sub xmlRegFreeExecCtxt (byval exec as xmlRegExecCtxtPtr)
declare function xmlRegExecPushString (byval exec as xmlRegExecCtxtPtr, byval value as zstring ptr, byval data as any ptr) as integer
declare function xmlRegExecPushString2 (byval exec as xmlRegExecCtxtPtr, byval value as zstring ptr, byval value2 as zstring ptr, byval data as any ptr) as integer
declare function xmlRegExecNextValues (byval exec as xmlRegExecCtxtPtr, byval nbval as integer ptr, byval nbneg as integer ptr, byval values as zstring ptr ptr, byval terminal as integer ptr) as integer
declare function xmlRegExecErrInfo (byval exec as xmlRegExecCtxtPtr, byval string as zstring ptr ptr, byval nbval as integer ptr, byval nbneg as integer ptr, byval values as zstring ptr ptr, byval terminal as integer ptr) as integer
end extern

#endif
