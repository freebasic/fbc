'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''   Copyright 1996, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization
''   from The Open Group.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xauth.bi"
#include once "X11/extensions/secur.bi"

extern "C"

#define _SECURITY_H
#define _XAUTH_STRUCT_ONLY
declare function XSecurityQueryExtension(byval dpy as Display ptr, byval major_version_return as long ptr, byval minor_version_return as long ptr) as long
declare function XSecurityAllocXauth() as Xauth ptr
declare sub XSecurityFreeXauth(byval auth as Xauth ptr)
type XSecurityAuthorization as culong

type XSecurityAuthorizationAttributes
	timeout as ulong
	trust_level as ulong
	group as XID
	event_mask as clong
end type

declare function XSecurityGenerateAuthorization(byval dpy as Display ptr, byval auth_in as Xauth ptr, byval valuemask as culong, byval attributes as XSecurityAuthorizationAttributes ptr, byval auth_id_return as XSecurityAuthorization ptr) as Xauth ptr
declare function XSecurityRevokeAuthorization(byval dpy as Display ptr, byval auth_id as XSecurityAuthorization) as long

type XSecurityAuthorizationRevokedEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	auth_id as XSecurityAuthorization
end type

end extern
