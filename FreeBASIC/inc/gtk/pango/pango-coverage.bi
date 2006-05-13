''
''
'' pango-coverage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pango_coverage_bi__
#define __pango_coverage_bi__

#include once "gtk/glib.bi"

type PangoCoverage as _PangoCoverage

enum PangoCoverageLevel
	PANGO_COVERAGE_NONE
	PANGO_COVERAGE_FALLBACK
	PANGO_COVERAGE_APPROXIMATE
	PANGO_COVERAGE_EXACT
end enum


declare function pango_coverage_new () as PangoCoverage ptr
declare function pango_coverage_ref (byval coverage as PangoCoverage ptr) as PangoCoverage ptr
declare sub pango_coverage_unref (byval coverage as PangoCoverage ptr)
declare function pango_coverage_copy (byval coverage as PangoCoverage ptr) as PangoCoverage ptr
declare function pango_coverage_get (byval coverage as PangoCoverage ptr, byval index_ as integer) as PangoCoverageLevel
declare sub pango_coverage_set (byval coverage as PangoCoverage ptr, byval index_ as integer, byval level as PangoCoverageLevel)
declare sub pango_coverage_max (byval coverage as PangoCoverage ptr, byval other as PangoCoverage ptr)
declare sub pango_coverage_to_bytes (byval coverage as PangoCoverage ptr, byval bytes as guchar ptr ptr, byval n_bytes as integer ptr)
declare function pango_coverage_from_bytes (byval bytes as guchar ptr, byval n_bytes as integer) as PangoCoverage ptr

#endif
