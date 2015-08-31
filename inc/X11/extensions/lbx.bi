'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   Copyright 1992 Network Computing Devices
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of NCD. not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  NCD. makes no representations about the
''   suitability of this software for any purpose.  It is provided "as is"
''   without express or implied warranty.
''
''   NCD. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
''   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL NCD.
''   BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
''   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
''   OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''   CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _LBX_H_
#define LBXNAME "LBX"
const LBX_MAJOR_VERSION = 1
const LBX_MINOR_VERSION = 0
const LbxNumberReqs = 44
const LbxEvent = 0
const LbxQuickMotionDeltaEvent = 1
const LbxNumberEvents = 2
const LbxMasterClientIndex = 0
const LbxSwitchEvent = 0
const LbxCloseEvent = 1
const LbxDeltaEvent = 2
const LbxInvalidateTagEvent = 3
const LbxSendTagDataEvent = 4
const LbxListenToOne = 5
const LbxListenToAll = 6
const LbxMotionDeltaEvent = 7
const LbxReleaseCmapEvent = 8
const LbxFreeCellsEvent = 9
const LbxImageCompressNone = 0
const BadLbxClient = 0
const LbxNumberErrors = BadLbxClient + 1
const LbxTagTypeModmap = 1
const LbxTagTypeKeymap = 2
const LbxTagTypeProperty = 3
const LbxTagTypeFont = 4
const LbxTagTypeConnInfo = 5
