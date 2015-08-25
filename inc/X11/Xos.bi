'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''    *
''   Copyright 1987, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''    *
''    * The X Window System is a Trademark of The Open Group.
''    *
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/sys/types.bi"
#include once "crt/string.bi"
#include once "crt/time.bi"
#include once "X11/Xosdefs.bi"
#include once "X11/Xarch.bi"
#ifdef __FB_WIN32__
	#include once "crt/long.bi"
	#include once "X11/Xw32defs.bi"
#endif

#define _XOS_H_

#if defined(__FB_DARWIN__) or defined(__FB_WIN32__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	#define index(s, c) strchr((s), (c))
	#define rindex(s, c) strrchr((s), (c))
#endif

#ifdef __FB_UNIX__
	#define X_GETTIMEOFDAY(t) gettimeofday(t, cptr(timezone ptr, 0))
#else
	type timeval
		tv_sec as clong
		tv_usec as clong
	end type

	#define _TIMEVAL_DEFINED
	#macro gettimeofday(t)
		scope
			dim _gtodtmp as _timeb
			_ftime(@_gtodtmp)
			(t)->tv_sec = _gtodtmp.time
			(t)->tv_usec = _gtodtmp.millitm * 1000
		end scope
	#endmacro
	#define X_GETTIMEOFDAY(t) gettimeofday(t)
#endif
