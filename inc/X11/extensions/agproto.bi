'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1996, 1998, 2001  The Open Group
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

#include once "X11/extensions/ag.bi"
#include once "X11/Xmd.bi"

#define _AGPROTO_H_
const X_XagQueryVersion = 0
const X_XagCreate = 1
const X_XagDestroy = 2
const X_XagGetAttr = 3
const X_XagQuery = 4
const X_XagCreateAssoc = 5
const X_XagDestroyAssoc = 6

type _XagQueryVersion
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	client_major_version as CARD16
	client_minor_version as CARD16
end type

type xXagQueryVersionReq as _XagQueryVersion
const sz_xXagQueryVersionReq = 8

type xXagQueryVersionReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	server_major_version as CARD16
	server_minor_version as CARD16
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXagQueryVersionReply = 32
const XagSingleScreenMask = 1 shl 0
const XagDefaultRootMask = 1 shl XagNdefaultRoot
const XagRootVisualMask = 1 shl XagNrootVisual
const XagDefaultColormapMask = 1 shl XagNdefaultColormap
const XagBlackPixelMask = 1 shl XagNblackPixel
const XagWhitePixelMask = 1 shl XagNwhitePixel
const XagAppGroupLeaderMask = 1 shl XagNappGroupLeader

type _XagCreate
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	app_group as CARD32
	attrib_mask as CARD32
end type

type xXagCreateReq as _XagCreate
const sz_xXagCreateReq = 12

type _XagDestroy
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	app_group as CARD32
end type

type xXagDestroyReq as _XagDestroy
const sz_xXagDestroyReq = 8

type _XagGetAttr
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	app_group as CARD32
end type

type xXagGetAttrReq as _XagGetAttr
const sz_xXagGetAttrReq = 8

type xXagGetAttrReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	default_root as CARD32
	root_visual as CARD32
	default_colormap as CARD32
	black_pixel as CARD32
	white_pixel as CARD32
	single_screen as XBOOL
	app_group_leader as XBOOL
	pad2 as CARD16
end type

const sz_xXagGetAttrReply = 32

type _XagQuery
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	resource as CARD32
end type

type xXagQueryReq as _XagQuery
const sz_xXagQueryReq = 8

type xXagQueryReply
	as UBYTE type
	pad1 as XBOOL
	sequence_number as CARD16
	length as CARD32
	app_group as CARD32
	pad2 as CARD32
	pad3 as CARD32
	pad4 as CARD32
	pad5 as CARD32
	pad6 as CARD32
end type

const sz_xXagQueryReply = 32

type _XagCreateAssoc
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	window as CARD32
	window_type as CARD16
	system_window_len as CARD16
end type

type xXagCreateAssocReq as _XagCreateAssoc
const sz_xXagCreateAssocReq = 12

type _XagDestroyAssoc
	reqType as CARD8
	xagReqType as CARD8
	length as CARD16
	window as CARD32
end type

type xXagDestroyAssocReq as _XagDestroyAssoc
const sz_xXagDestroyAssocReq = 8
