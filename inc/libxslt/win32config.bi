'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/math.bi"
#include once "libxml/xmlversion.bi"

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	extern "C"
#endif

#define __LIBXSLT_WIN32_CONFIG__
const HAVE_CTYPE_H = 1
const HAVE_STDLIB_H = 1
const HAVE_STDARG_H = 1
const HAVE_MALLOC_H = 1
const HAVE_TIME_H = 1
const HAVE_LOCALTIME = 1
const HAVE_GMTIME = 1
const HAVE_TIME = 1
const HAVE_MATH_H = 1
const HAVE_FCNTL_H = 1
#define HAVE_ISINF
#define HAVE_ISNAN

#ifdef __FB_WIN32__
	#define isinf(d) iif(_fpclass(d) = _FPCLASS_PINF, 1, iif(_fpclass(d) = _FPCLASS_NINF, -1, 0))
	#define isnan(d) _isnan(d)
#else
	private function isinf(byval d as double) as long
		dim expon as long = 0
		dim val_ as double = frexp(d, @expon)
		if expon = 1025 then
			if val_ = 0.5 then
				return 1
			elseif val_ = (-0.5) then
				return -1
			else
				return 0
			end if
		else
			return 0
		end if
	end function

	private function isnan(byval d as double) as long
		dim expon as long = 0
		dim val_ as double = frexp(d, @expon)
		if expon = 1025 then
			if val_ = 0.5 then
				return 0
			elseif val_ = (-0.5) then
				return 0
			else
				return 1
			end if
		else
			return 0
		end if
	end function
#endif

#define HAVE_SYS_STAT_H
#define HAVE__STAT
#define HAVE_STRING_H
#define _WINSOCKAPI_

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	end extern
#endif
