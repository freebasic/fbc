'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   err/gsl_errno.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/stdio.bi"
#include once "crt/errno.bi"
#include once "gsl/gsl_types.bi"

'' The following symbols have been renamed:
''     #define GSL_ERROR => GSL_ERROR_

extern "C"

#define __GSL_ERRNO_H__

enum
	GSL_SUCCESS = 0
	GSL_FAILURE = -1
	GSL_CONTINUE = -2
	GSL_EDOM = 1
	GSL_ERANGE = 2
	GSL_EFAULT = 3
	GSL_EINVAL = 4
	GSL_EFAILED = 5
	GSL_EFACTOR = 6
	GSL_ESANITY = 7
	GSL_ENOMEM = 8
	GSL_EBADFUNC = 9
	GSL_ERUNAWAY = 10
	GSL_EMAXITER = 11
	GSL_EZERODIV = 12
	GSL_EBADTOL = 13
	GSL_ETOL = 14
	GSL_EUNDRFLW = 15
	GSL_EOVRFLW = 16
	GSL_ELOSS = 17
	GSL_EROUND = 18
	GSL_EBADLEN = 19
	GSL_ENOTSQR = 20
	GSL_ESING = 21
	GSL_EDIVERGE = 22
	GSL_EUNSUP = 23
	GSL_EUNIMPL = 24
	GSL_ECACHE = 25
	GSL_ETABLE = 26
	GSL_ENOPROG = 27
	GSL_ENOPROGJ = 28
	GSL_ETOLF = 29
	GSL_ETOLX = 30
	GSL_ETOLG = 31
	GSL_EOF = 32
end enum

declare sub gsl_error(byval reason as const zstring ptr, byval file as const zstring ptr, byval line as long, byval gsl_errno as long)
declare sub gsl_stream_printf(byval label as const zstring ptr, byval file as const zstring ptr, byval line as long, byval reason as const zstring ptr)
declare function gsl_strerror(byval gsl_errno as const long) as const zstring ptr
declare function gsl_set_error_handler(byval new_handler as sub(byval reason as const zstring ptr, byval file as const zstring ptr, byval line as long, byval gsl_errno as long)) as sub(byval reason as const zstring ptr, byval file as const zstring ptr, byval line as long, byval gsl_errno as long)
declare function gsl_set_error_handler_off() as sub(byval reason as const zstring ptr, byval file as const zstring ptr, byval line as long, byval gsl_errno as long)
declare function gsl_set_stream_handler(byval new_handler as sub(byval label as const zstring ptr, byval file as const zstring ptr, byval line as long, byval reason as const zstring ptr)) as sub(byval label as const zstring ptr, byval file as const zstring ptr, byval line as long, byval reason as const zstring ptr)
declare function gsl_set_stream(byval new_stream as FILE ptr) as FILE ptr

#macro GSL_ERROR_(reason, gsl_errno)
	scope
		gsl_error(reason, __FILE__, __LINE__, gsl_errno)
		return gsl_errno
	end scope
#endmacro
#macro GSL_ERROR_VAL(reason, gsl_errno, value)
	scope
		gsl_error(reason, __FILE__, __LINE__, gsl_errno)
		return value
	end scope
#endmacro
#macro GSL_ERROR_VOID(reason, gsl_errno)
	scope
		gsl_error(reason, __FILE__, __LINE__, gsl_errno)
		return
	end scope
#endmacro
#define GSL_ERROR_NULL(reason, gsl_errno) GSL_ERROR_VAL(reason, gsl_errno, 0)
#define GSL_ERROR_SELECT_2(a, b) iif((a) <> GSL_SUCCESS, (a), iif((b) <> GSL_SUCCESS, (b), GSL_SUCCESS))
#define GSL_ERROR_SELECT_3(a, b, c) iif((a) <> GSL_SUCCESS, (a), GSL_ERROR_SELECT_2(b, c))
#define GSL_ERROR_SELECT_4(a, b, c, d) iif((a) <> GSL_SUCCESS, (a), GSL_ERROR_SELECT_3(b, c, d))
#define GSL_ERROR_SELECT_5(a, b, c, d, e) iif((a) <> GSL_SUCCESS, (a), GSL_ERROR_SELECT_4(b, c, d, e))
#define GSL_STATUS_UPDATE(sp, s) scope : if (s) <> GSL_SUCCESS then : *(sp) = (s) : end if : end scope

end extern
