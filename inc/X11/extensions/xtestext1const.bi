'' FreeBASIC binding for xextproto-7.3.0
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

const _XTESTEXT1CONST_H = 1
const XTestMAX_ACTION_LIST_SIZE = 64
const XTestACTIONS_SIZE = 28
const XTestPRESS = 1 shl 0
const XTestRELEASE = 1 shl 1
const XTestSTROKE = 1 shl 2
const XTestSTROKE_DELAY_TIME = 10
const XTestEXCLUSIVE = 1 shl 0
const XTestPACKED_ACTIONS = 1 shl 1
const XTestPACKED_MOTION = 1 shl 2
const XTestFAKE_ACK_NOT_NEEDED = 0
const XTestFAKE_ACK_REQUEST = 1
#define XTestEXTENSION_NAME "XTestExtension1"
const XTestEVENT_COUNT = 2
const XTestACTION_TYPE_MASK = &h03
const XTestKEY_STATE_MASK = &h04
const XTestX_SIGN_BIT_MASK = &h04
const XTestY_SIGN_BIT_MASK = &h08
const XTestDEVICE_ID_MASK = &hf0
const XTestMAX_DEVICE_ID = &h0f
#define XTestPackDeviceID(x) (((x) and XTestMAX_DEVICE_ID) shl 4)
#define XTestUnpackDeviceID(x) (((x) and XTestDEVICE_ID_MASK) shr 4)
const XTestDELAY_ACTION = 0
const XTestKEY_ACTION = 1
const XTestMOTION_ACTION = 2
const XTestJUMP_ACTION = 3
const XTestKEY_UP = &h04
const XTestKEY_DOWN = &h00
const XTestMOTION_MAX = 15
const XTestMOTION_MIN = -15
const XTestX_NEGATIVE = &h04
const XTestY_NEGATIVE = &h08
const XTestX_MOTION_MASK = &h0f
const XTestY_MOTION_MASK = &hf0
#define XTestPackXMotionValue(x) ((x) and XTestX_MOTION_MASK)
#define XTestPackYMotionValue(x) (((x) shl 4) and XTestY_MOTION_MASK)
#define XTestUnpackXMotionValue(x) ((x) and XTestX_MOTION_MASK)
#define XTestUnpackYMotionValue(x) (((x) and XTestY_MOTION_MASK) shr 4)
const XTestSHORT_DELAY_TIME = &hffff
const XTestDELAY_DEVICE_ID = &h0f
