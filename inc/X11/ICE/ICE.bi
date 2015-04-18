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
''
''   *****************************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _ICE_H_
const IceProtoMajor = 1
const IceProtoMinor = 0
const IceLSBfirst = 0
const IceMSBfirst = 1
const ICE_Error = 0
const ICE_ByteOrder = 1
const ICE_ConnectionSetup = 2
const ICE_AuthRequired = 3
const ICE_AuthReply = 4
const ICE_AuthNextPhase = 5
const ICE_ConnectionReply = 6
const ICE_ProtocolSetup = 7
const ICE_ProtocolReply = 8
const ICE_Ping = 9
const ICE_PingReply = 10
const ICE_WantToClose = 11
const ICE_NoClose = 12
const IceCanContinue = 0
const IceFatalToProtocol = 1
const IceFatalToConnection = 2
const IceBadMinor = &h8000
const IceBadState = &h8001
const IceBadLength = &h8002
const IceBadValue = &h8003
const IceBadMajor = 0
const IceNoAuth = 1
const IceNoVersion = 2
const IceSetupFailed = 3
const IceAuthRejected = 4
const IceAuthFailed = 5
const IceProtocolDuplicate = 6
const IceMajorOpcodeDuplicate = 7
const IceUnknownProtocol = 8
