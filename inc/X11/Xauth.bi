'' FreeBASIC binding for libXau-1.0.8
''
'' based on the C header files:
''
''   Copyright 1988, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/Xfuncs.bi"
#include once "crt/stdio.bi"

extern "C"

#define _Xauth_h

type Xauth
	family as ushort
	address_length as ushort
	address as zstring ptr
	number_length as ushort
	number as zstring ptr
	name_length as ushort
	name as zstring ptr
	data_length as ushort
	data as zstring ptr
end type

const FamilyLocal = 256
const FamilyWild = 65535
const FamilyNetname = 254
const FamilyKrb5Principal = 253
const FamilyLocalHost = 252

declare function XauFileName() as zstring ptr
declare function XauReadAuth(byval as FILE ptr) as Xauth ptr
declare function XauLockAuth(byval as const zstring ptr, byval as long, byval as long, byval as clong) as long
declare function XauUnlockAuth(byval as const zstring ptr) as long
declare function XauWriteAuth(byval as FILE ptr, byval as Xauth ptr) as long
declare function XauGetAuthByAddr(byval as ushort, byval as ushort, byval as const zstring ptr, byval as ushort, byval as const zstring ptr, byval as ushort, byval as const zstring ptr) as Xauth ptr
declare function XauGetBestAuthByAddr(byval as ushort, byval as ushort, byval as const zstring ptr, byval as ushort, byval as const zstring ptr, byval as long, byval as zstring ptr ptr, byval as const long ptr) as Xauth ptr
declare sub XauDisposeAuth(byval as Xauth ptr)

const LOCK_SUCCESS = 0
const LOCK_ERROR = 1
const LOCK_TIMEOUT = 2

end extern
