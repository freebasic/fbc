'' FreeBASIC binding for xextproto-7.3.0
''
'' based on the C header files:
''   ***************************************************************
''
''   Copyright (c) 1996 Digital Equipment Corporation, Maynard, Massachusetts.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   DIGITAL EQUIPMENT CORPORATION BE LIABLE FOR ANY CLAIM, DAMAGES, INCLUDING,
''   BUT NOT LIMITED TO CONSEQUENTIAL OR INCIDENTAL DAMAGES, OR OTHER LIABILITY,
''   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
''   IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Digital Equipment Corporation
''   shall not be used in advertising or otherwise to promote the sale, use or other
''   dealings in this Software without prior written authorization from Digital
''   Equipment Corporation.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

const _DPMSCONST_H = 1
const DPMSMajorVersion = 1
const DPMSMinorVersion = 1
#define DPMSExtensionName "DPMS"
const DPMSModeOn = 0
const DPMSModeStandby = 1
const DPMSModeSuspend = 2
const DPMSModeOff = 3
