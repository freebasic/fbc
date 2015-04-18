'' FreeBASIC binding for liblbxutil-1.1.0
''
'' based on the C header files:
''   Copyright 1988, 1989, 1990, 1994 Network Computing Devices, Inc.
''
''   Permission to use, copy, modify, distribute, and sell this software and
''   its documentation for any purpose is hereby granted without fee, provided
''   that the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name Network Computing Devices, Inc. not be
''   used in advertising or publicity pertaining to distribution of this
''   software without specific, written prior permission.
''
''   THIS SOFTWARE IS PROVIDED `AS-IS'.  NETWORK COMPUTING DEVICES, INC.,
''   DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING WITHOUT
''   LIMITATION ALL IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
''   PARTICULAR PURPOSE, OR NONINFRINGEMENT.  IN NO EVENT SHALL NETWORK
''   COMPUTING DEVICES, INC., BE LIABLE FOR ANY DAMAGES WHATSOEVER, INCLUDING
''   SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, INCLUDING LOSS OF USE,
''   DATA, OR PROFITS, EVEN IF ADVISED OF THE POSSIBILITY THEREOF, AND
''   REGARDLESS OF WHETHER IN AN ACTION IN CONTRACT, TORT OR NEGLIGENCE,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/extensions/lbxbuf.bi"

#define _BUFFERSTR_H_

type _zlibbuffer
	bufbase as zstring ptr
	bufend as zstring ptr
	bufptr as zstring ptr
	bufcnt as long
end type

type ZlibBuffer as _zlibbuffer
#define BYTES_AVAIL(inbuf, len) iif((inbuf)->bufcnt >= (len), (inbuf)->bufptr, NULL)
