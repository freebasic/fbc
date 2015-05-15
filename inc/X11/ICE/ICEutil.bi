'' FreeBASIC binding for libICE-1.0.9
''
'' based on the C header files:
''   ****************************************************************************
''
''
''   Copyright 1993, 1998  The Open Group
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
''   Author: Ralph Mor, X Consortium
''   *****************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "crt/stdio.bi"

extern "C"

#define _ICEUTIL_H_

type IceAuthFileEntry
	protocol_name as zstring ptr
	protocol_data_length as ushort
	protocol_data as zstring ptr
	network_id as zstring ptr
	auth_name as zstring ptr
	auth_data_length as ushort
	auth_data as zstring ptr
end type

type IceAuthDataEntry
	protocol_name as zstring ptr
	network_id as zstring ptr
	auth_name as zstring ptr
	auth_data_length as ushort
	auth_data as zstring ptr
end type

const IceAuthLockSuccess = 0
const IceAuthLockError = 1
const IceAuthLockTimeout = 2

declare function IceAuthFileName() as zstring ptr
declare function IceLockAuthFile(byval as const zstring ptr, byval as long, byval as long, byval as clong) as long
declare sub IceUnlockAuthFile(byval as const zstring ptr)
declare function IceReadAuthFileEntry(byval as FILE ptr) as IceAuthFileEntry ptr
declare sub IceFreeAuthFileEntry(byval as IceAuthFileEntry ptr)
declare function IceWriteAuthFileEntry(byval as FILE ptr, byval as IceAuthFileEntry ptr) as long
declare function IceGetAuthFileEntry(byval as const zstring ptr, byval as const zstring ptr, byval as const zstring ptr) as IceAuthFileEntry ptr
declare function IceGenerateMagicCookie(byval as long) as zstring ptr
declare sub IceSetPaAuthData(byval as long, byval as IceAuthDataEntry ptr)

end extern
