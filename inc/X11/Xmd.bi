'' FreeBASIC binding for xproto-7.0.27
''
'' based on the C header files:
''   *********************************************************
''
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
''
''
''   Copyright 1987 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     #define _SIZEOF => _XSIZEOF
''     #define SIZEOF => XSIZEOF
''     typedef BYTE => UBYTE
''     typedef BOOL => XBOOL

const XMD_H = 1
#define _XSIZEOF(x) sz_##x
#define XSIZEOF(x) _XSIZEOF(x)

#ifdef __FB_64BIT__
	type INT32 as long
#else
	type INT32 as clong
#endif

type INT16 as short
type INT8 as byte

#ifdef __FB_64BIT__
	type CARD64 as culong
	type CARD32 as ulong
#else
	type CARD64 as ulongint
	type CARD32 as culong
#endif

type CARD16 as ushort
type CARD8 as ubyte
type BITS32 as CARD32
type BITS16 as CARD16
type XBOOL as CARD8

#define cvtINT8toInt(val) (val)
#define cvtINT16toInt(val) (val)
#define cvtINT32toInt(val) (val)
#define cvtINT8toShort(val) (val)
#define cvtINT16toShort(val) (val)
#define cvtINT32toShort(val) (val)
#define cvtINT8toLong(val) (val)
#define cvtINT16toLong(val) (val)
#define cvtINT32toLong(val) (val)
#define NEXTPTR(p, t) (cptr(t ptr, (p)) + 1)
