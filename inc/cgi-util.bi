''
''
'' cgi-util -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cgi_util_bi__
#define __cgi_util_bi__

#inclib "cgi-util"

#define CGIUTILVER "2.2.0"

type entry_type
	name as zstring ptr
	val as zstring ptr
	content_type as zstring ptr
	content_length as integer
end type

type cgi_entry_type as entry_type

type cookie_type
	name as zstring ptr
	val as zstring ptr
end type

type cgi_cookie_type as cookie_type

enum 
	CGIERR_NONE
	CGIERR_NOT_INTEGER
	CGIERR_NOT_DOUBLE
	CGIERR_NOT_BOOL
	CGIERR_UNKNOWN_METHOD
	CGIERR_INCORRECT_TYPE
	CGIERR_BAD_CONTENT_LENGTH
	CGIERR_CONTENT_LENGTH_DISCREPANCY
	CGIERR_CANT_OPEN
	CGIERR_OUT_OF_MEMORY
	CGIERR_NO_BOUNDARY
	CGIERR_NO_COOKIES
	CGIERR_COOKIE_NOT_FOUND
	CGIERR_N_OUT_OF_BOUNDS
	CGIERR_NUM_ERRS
end enum

enum 
	CGIREQ_NONE
	CGIREQ_GET
	CGIREQ_POST
	CGIREQ_UNKNOWN
end enum

enum 
	CGITYPE_NONE
	CGITYPE_APPLICATION_X_WWW_FORM_URLENCODED
	CGITYPE_MULTIPART_FORM_DATA
	CGITYPE_UNKNOWN
end enum

declare function cgi_init cdecl alias "cgi_init" () as integer
declare sub cgi_quit cdecl alias "cgi_quit" ()
declare function cgi_parse_cookies cdecl alias "cgi_parse_cookies" () as integer
declare function cgi_getcookie cdecl alias "cgi_getcookie" (byval cookie_name as zstring ptr) as zstring ptr
declare function cgi_getnumentries cdecl alias "cgi_getnumentries" (byval field_name as zstring ptr) as integer
declare function cgi_getentrystr cdecl alias "cgi_getentrystr" (byval field_name as zstring ptr) as zstring ptr
declare function cgi_getnentrystr cdecl alias "cgi_getnentrystr" (byval field_name as zstring ptr, byval n as integer) as zstring ptr
declare function cgi_getentrytype cdecl alias "cgi_getentrytype" (byval field_name as zstring ptr) as zstring ptr
declare function cgi_getnentrytype cdecl alias "cgi_getnentrytype" (byval field_name as zstring ptr, byval n as integer) as zstring ptr
declare function cgi_getentryint cdecl alias "cgi_getentryint" (byval field_name as zstring ptr) as integer
declare function cgi_getnentryint cdecl alias "cgi_getnentryint" (byval field_name as zstring ptr, byval n as integer) as integer
declare function cgi_getentrydouble cdecl alias "cgi_getentrydouble" (byval field_name as zstring ptr) as double
declare function cgi_getnentrydouble cdecl alias "cgi_getnentrydouble" (byval field_name as zstring ptr, byval n as integer) as double
declare function cgi_getentrybool cdecl alias "cgi_getentrybool" (byval field_name as zstring ptr, byval def as integer) as integer
declare function cgi_getnentrybool cdecl alias "cgi_getnentrybool" (byval field_name as zstring ptr, byval def as integer, byval n as integer) as integer
declare function cgi_dump_no_abort cdecl alias "cgi_dump_no_abort" (byval filename as zstring ptr) as integer
declare sub cgi_dump cdecl alias "cgi_dump" (byval filename as zstring ptr)
declare function cgi_goodemailaddress cdecl alias "cgi_goodemailaddress" (byval addr as zstring ptr) as integer
declare sub cgi_error cdecl alias "cgi_error" (byval reason as zstring ptr)
declare function cgi_strerror cdecl alias "cgi_strerror" (byval err as integer) as zstring ptr

#endif
