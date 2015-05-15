'' FreeBASIC binding for libXext-1.3.3
''
'' based on the C header files:
''
''
''   Copyright 1986, 1987, 1988, 1998  The Open Group
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
''   Copyright 1986, 1987, 1988 by Hewlett-Packard Corporation
''
''   Permission to use, copy, modify, and distribute this
''   software and its documentation for any purpose and without
''   fee is hereby granted, provided that the above copyright
''   notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting
''   documentation, and that the name of Hewlett-Packard not be used in
''   advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   Hewlett-Packard makes no representations about the
''   suitability of this software for any purpose.  It is provided
''   "as is" without express or implied warranty.
''
''   This software is not subject to any license of the American
''   Telephone and Telegraph Company or of the Regents of the
''   University of California.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/xtestext1const.bi"

extern "C"

#define _XTESTEXT1_H

type XTestInputActionEvent
	as long type
	display as Display ptr
	window as Window
	actions(0 to 27) as CARD8
end type

type XTestFakeAckEvent
	as long type
	display as Display ptr
	window as Window
end type

declare function XTestFakeInput(byval dpy as Display ptr, byval action_list_addr as zstring ptr, byval action_list_size as long, byval ack_flag as long) as long
declare function XTestGetInput(byval dpy as Display ptr, byval action_handling as long) as long
declare function XTestQueryInputSize(byval dpy as Display ptr, byval size_return as culong ptr) as long
declare function XTestPressKey(byval display as Display ptr, byval device_id as long, byval delay as culong, byval keycode as ulong, byval key_action as ulong) as long
declare function XTestPressButton(byval display as Display ptr, byval device_id as long, byval delay as culong, byval button_number as ulong, byval button_action as ulong) as long
declare function XTestMovePointer(byval display as Display ptr, byval device_id as long, byval delay as culong ptr, byval x as long ptr, byval y as long ptr, byval count as ulong) as long
declare function XTestFlush(byval display as Display ptr) as long
declare function XTestStopInput(byval dpy as Display ptr) as long
declare function XTestReset(byval dpy as Display ptr) as long

end extern
