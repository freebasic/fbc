'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1989, 1998  The Open Group
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
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define _MULTIBUFCONST_H_
#define MULTIBUFFER_PROTOCOL_NAME "Multi-Buffering"
const MULTIBUFFER_MAJOR_VERSION = 1
const MULTIBUFFER_MINOR_VERSION = 1
const MultibufferUpdateActionUndefined = 0
const MultibufferUpdateActionBackground = 1
const MultibufferUpdateActionUntouched = 2
const MultibufferUpdateActionCopied = 3
const MultibufferUpdateHintFrequent = 0
const MultibufferUpdateHintIntermittent = 1
const MultibufferUpdateHintStatic = 2
const MultibufferWindowUpdateHint = cast(clong, 1) shl 0
const MultibufferBufferEventMask = cast(clong, 1) shl 0
const MultibufferModeMono = 0
const MultibufferModeStereo = 1
const MultibufferSideMono = 0
const MultibufferSideLeft = 1
const MultibufferSideRight = 2
const MultibufferUnclobbered = 0
const MultibufferPartiallyClobbered = 1
const MultibufferFullyClobbered = 2
const MultibufferClobberNotifyMask = &h02000000
const MultibufferUpdateNotifyMask = &h04000000
const MultibufferClobberNotify = 0
const MultibufferUpdateNotify = 1
const MultibufferNumberEvents = MultibufferUpdateNotify + 1
const MultibufferBadBuffer = 0
const MultibufferNumberErrors = MultibufferBadBuffer + 1
