'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   histogram/ntuple.h
''
''   Copyright (C) 2000 Simone Piccardi
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdlib.bi"
#include once "crt/stdio.bi"
#include once "gsl/gsl_errno.bi"
#include once "gsl/gsl_histogram.bi"

extern "C"

#define __GSL_NTUPLE_H__

type gsl_ntuple
	file as FILE ptr
	ntuple_data as any ptr
	size as uinteger
end type

type gsl_ntuple_select_fn
	function as function(byval ntuple_data as any ptr, byval params as any ptr) as long
	params as any ptr
end type

type gsl_ntuple_value_fn
	function as function(byval ntuple_data as any ptr, byval params as any ptr) as double
	params as any ptr
end type

declare function gsl_ntuple_open(byval filename as zstring ptr, byval ntuple_data as any ptr, byval size as uinteger) as gsl_ntuple ptr
declare function gsl_ntuple_create(byval filename as zstring ptr, byval ntuple_data as any ptr, byval size as uinteger) as gsl_ntuple ptr
declare function gsl_ntuple_write(byval ntuple as gsl_ntuple ptr) as long
declare function gsl_ntuple_read(byval ntuple as gsl_ntuple ptr) as long
declare function gsl_ntuple_bookdata(byval ntuple as gsl_ntuple ptr) as long
declare function gsl_ntuple_project(byval h as gsl_histogram ptr, byval ntuple as gsl_ntuple ptr, byval value_func as gsl_ntuple_value_fn ptr, byval select_func as gsl_ntuple_select_fn ptr) as long
declare function gsl_ntuple_close(byval ntuple as gsl_ntuple ptr) as long

end extern
