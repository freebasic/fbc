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

#include once "X11/Xmd.bi"

#define _ICEPROTO_H_

type iceMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	data(0 to 1) as CARD8
	length as CARD32
end type

type iceErrorMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	errorClass as CARD16
	length as CARD32
	offendingMinorOpcode as CARD8
	severity as CARD8
	unused as CARD16
	offendingSequenceNum as CARD32
end type

type iceByteOrderMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	byteOrder as CARD8
	unused as CARD8
	length as CARD32
end type

type iceConnectionSetupMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	versionCount as CARD8
	authCount as CARD8
	length as CARD32
	mustAuthenticate as CARD8
	unused(0 to 6) as CARD8
end type

type iceAuthRequiredMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	authIndex as CARD8
	unused1 as CARD8
	length as CARD32
	authDataLength as CARD16
	unused2(0 to 5) as CARD8
end type

type iceAuthReplyMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused1(0 to 1) as CARD8
	length as CARD32
	authDataLength as CARD16
	unused2(0 to 5) as CARD8
end type

type iceAuthNextPhaseMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused1(0 to 1) as CARD8
	length as CARD32
	authDataLength as CARD16
	unused2(0 to 5) as CARD8
end type

type iceConnectionReplyMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	versionIndex as CARD8
	unused as CARD8
	length as CARD32
end type

type iceProtocolSetupMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	protocolOpcode as CARD8
	mustAuthenticate as CARD8
	length as CARD32
	versionCount as CARD8
	authCount as CARD8
	unused(0 to 5) as CARD8
end type

type iceProtocolReplyMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	versionIndex as CARD8
	protocolOpcode as CARD8
	length as CARD32
end type

type icePingMsg as iceMsg
type icePingReplyMsg as iceMsg
type iceWantToCloseMsg as iceMsg
type iceNoCloseMsg as iceMsg

const sz_iceMsg = 8
const sz_iceErrorMsg = 16
const sz_iceByteOrderMsg = 8
const sz_iceConnectionSetupMsg = 16
const sz_iceAuthRequiredMsg = 16
const sz_iceAuthReplyMsg = 16
const sz_iceAuthNextPhaseMsg = 16
const sz_iceConnectionReplyMsg = 8
const sz_iceProtocolSetupMsg = 16
const sz_iceProtocolReplyMsg = 8
const sz_icePingMsg = 8
const sz_icePingReplyMsg = 8
const sz_iceWantToCloseMsg = 8
const sz_iceNoCloseMsg = 8
