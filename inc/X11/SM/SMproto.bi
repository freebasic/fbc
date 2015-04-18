'' FreeBASIC binding for libSM-1.2.2
''
'' based on the C header files:
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
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xmd.bi"

#define _SMPROTO_H_

type smRegisterClientMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smRegisterClientReplyMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smSaveYourselfMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused1(0 to 1) as CARD8
	length as CARD32
	saveType as CARD8
	shutdown as CARD8
	interactStyle as CARD8
	fast as CARD8
	unused2(0 to 3) as CARD8
end type

type smSaveYourselfRequestMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused1(0 to 1) as CARD8
	length as CARD32
	saveType as CARD8
	shutdown as CARD8
	interactStyle as CARD8
	fast as CARD8
	global as CARD8
	unused2(0 to 2) as CARD8
end type

type smInteractRequestMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	dialogType as CARD8
	unused as CARD8
	length as CARD32
end type

type smInteractMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smInteractDoneMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	cancelShutdown as CARD8
	unused as CARD8
	length as CARD32
end type

type smSaveYourselfDoneMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	success as CARD8
	unused as CARD8
	length as CARD32
end type

type smDieMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smShutdownCancelledMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smCloseConnectionMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smSetPropertiesMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smDeletePropertiesMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smGetPropertiesMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smPropertiesReplyMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smSaveYourselfPhase2RequestMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smSaveYourselfPhase2Msg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

type smSaveCompleteMsg
	majorOpcode as CARD8
	minorOpcode as CARD8
	unused(0 to 1) as CARD8
	length as CARD32
end type

const sz_smRegisterClientMsg = 8
const sz_smRegisterClientReplyMsg = 8
const sz_smSaveYourselfMsg = 16
const sz_smSaveYourselfRequestMsg = 16
const sz_smInteractRequestMsg = 8
const sz_smInteractMsg = 8
const sz_smInteractDoneMsg = 8
const sz_smSaveYourselfDoneMsg = 8
const sz_smDieMsg = 8
const sz_smShutdownCancelledMsg = 8
const sz_smCloseConnectionMsg = 8
const sz_smSetPropertiesMsg = 8
const sz_smDeletePropertiesMsg = 8
const sz_smGetPropertiesMsg = 8
const sz_smPropertiesReplyMsg = 8
const sz_smSaveYourselfPhase2RequestMsg = 8
const sz_smSaveYourselfPhase2Msg = 8
const sz_smSaveCompleteMsg = 8
