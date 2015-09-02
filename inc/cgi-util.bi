'' FreeBASIC binding for cgi-util-2.2.1
''
'' based on the C header files:
''   cgi-util.h
''
''   version 2.2.0
''
''   by Bill Kendrick <bill@newbreedsoftware.com>
''   and Mike Simons <msimons@moria.simons-clan.com>
''   and Gary Briggs <chunky@icculus.org>
''
''   Other contributions; see CHANGES.txt
''
''   New Breed Software
''   http://www.newbreedsoftware.com/cgi-util/
''
''   April 6, 1996 - May 16, 2004
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "cgi-util"

extern "C"

#define CGI_UTIL_H
#define CGIUTILVER "2.2.0"

type entry_type
	name as zstring ptr
	val as zstring ptr
	content_type as zstring ptr
	content_length as long
end type

type cgi_entry_type as entry_type
extern cgi_entries as cgi_entry_type ptr

type cookie_type
	name as zstring ptr
	val as zstring ptr
end type

type cgi_cookie_type as cookie_type
extern cgi_cookies as cgi_cookie_type ptr
extern cgi_num_entries as long

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

extern cgi_error_strings(0 to CGIERR_NUM_ERRS - 1) as zstring ptr
extern cgi_errno as long

enum
	CGIREQ_NONE
	CGIREQ_GET
	CGIREQ_POST
	CGIREQ_UNKNOWN
end enum

extern cgi_request_method as long

enum
	CGITYPE_NONE
	CGITYPE_APPLICATION_X_WWW_FORM_URLENCODED
	CGITYPE_MULTIPART_FORM_DATA
	CGITYPE_UNKNOWN
end enum

extern cgi_content_type as long
declare function cgi_init() as long
declare sub cgi_quit()
declare function cgi_parse_cookies() as long
declare function cgi_getcookie(byval cookie_name as const zstring ptr) as const zstring ptr
declare function cgi_getnumentries(byval field_name as const zstring ptr) as long
declare function cgi_getentrystr(byval field_name as const zstring ptr) as const zstring ptr
declare function cgi_getnentrystr(byval field_name as const zstring ptr, byval n as long) as const zstring ptr
declare function cgi_getentrytype(byval field_name as const zstring ptr) as const zstring ptr
declare function cgi_getnentrytype(byval field_name as const zstring ptr, byval n as long) as const zstring ptr
declare function cgi_getentryint(byval field_name as const zstring ptr) as long
declare function cgi_getnentryint(byval field_name as const zstring ptr, byval n as long) as long
declare function cgi_getentrydouble(byval field_name as const zstring ptr) as double
declare function cgi_getnentrydouble(byval field_name as const zstring ptr, byval n as long) as double
declare function cgi_getentrybool(byval field_name as const zstring ptr, byval def as long) as long
declare function cgi_getnentrybool(byval field_name as const zstring ptr, byval def as long, byval n as long) as long
declare function cgi_dump_no_abort(byval filename as const zstring ptr) as long
declare sub cgi_dump(byval filename as const zstring ptr)
declare function cgi_goodemailaddress(byval addr as const zstring ptr) as long
declare sub cgi_error(byval reason as const zstring ptr)
declare function cgi_strerror(byval err as long) as const zstring ptr

end extern
