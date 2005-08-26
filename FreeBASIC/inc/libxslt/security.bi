''
''
'' security -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __security_bi__
#define __security_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"

type xsltSecurityPrefs as _xsltSecurityPrefs
type xsltSecurityPrefsPtr as xsltSecurityPrefs ptr

enum xsltSecurityOption
	XSLT_SECPREF_READ_FILE = 1
	XSLT_SECPREF_WRITE_FILE
	XSLT_SECPREF_CREATE_DIRECTORY
	XSLT_SECPREF_READ_NETWORK
	XSLT_SECPREF_WRITE_NETWORK
end enum

type xsltSecurityCheck as function cdecl(byval as xsltSecurityPrefsPtr, byval as xsltTransformContextPtr, byval as zstring ptr) as integer

declare function xsltNewSecurityPrefs cdecl alias "xsltNewSecurityPrefs" () as xsltSecurityPrefsPtr
declare sub xsltFreeSecurityPrefs cdecl alias "xsltFreeSecurityPrefs" (byval sec as xsltSecurityPrefsPtr)
declare function xsltSetSecurityPrefs cdecl alias "xsltSetSecurityPrefs" (byval sec as xsltSecurityPrefsPtr, byval option as xsltSecurityOption, byval func as xsltSecurityCheck) as integer
declare function xsltGetSecurityPrefs cdecl alias "xsltGetSecurityPrefs" (byval sec as xsltSecurityPrefsPtr, byval option as xsltSecurityOption) as xsltSecurityCheck
declare sub xsltSetDefaultSecurityPrefs cdecl alias "xsltSetDefaultSecurityPrefs" (byval sec as xsltSecurityPrefsPtr)
declare function xsltGetDefaultSecurityPrefs cdecl alias "xsltGetDefaultSecurityPrefs" () as xsltSecurityPrefsPtr
declare function xsltSetCtxtSecurityPrefs cdecl alias "xsltSetCtxtSecurityPrefs" (byval sec as xsltSecurityPrefsPtr, byval ctxt as xsltTransformContextPtr) as integer
declare function xsltSecurityAllow cdecl alias "xsltSecurityAllow" (byval sec as xsltSecurityPrefsPtr, byval ctxt as xsltTransformContextPtr, byval value as zstring ptr) as integer
declare function xsltSecurityForbid cdecl alias "xsltSecurityForbid" (byval sec as xsltSecurityPrefsPtr, byval ctxt as xsltTransformContextPtr, byval value as zstring ptr) as integer
declare function xsltCheckWrite cdecl alias "xsltCheckWrite" (byval sec as xsltSecurityPrefsPtr, byval ctxt as xsltTransformContextPtr, byval URL as zstring ptr) as integer
declare function xsltCheckRead cdecl alias "xsltCheckRead" (byval sec as xsltSecurityPrefsPtr, byval ctxt as xsltTransformContextPtr, byval URL as zstring ptr) as integer

#endif
