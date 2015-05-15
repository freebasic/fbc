'' FreeBASIC binding for dri2proto-2.8
''
'' based on the C header files:
''   Copyright © 2008 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Soft-
''   ware"), to deal in the Software without restriction, including without
''   limitation the rights to use, copy, modify, merge, publish, distribute,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, provided that the above copyright
''   notice(s) and this permission notice appear in all copies of the Soft-
''   ware and that both the above copyright notice(s) and this permission
''   notice appear in supporting documentation.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL-
''   ITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY
''   RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN
''   THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSE-
''   QUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFOR-
''   MANCE OF THIS SOFTWARE.
''
''   Except as contained in this notice, the name of a copyright holder shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization of
''   the copyright holder.
''
''   Authors:
''     Kristian Høgsberg (krh@redhat.com)
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _DRI2_TOKENS_H_
const DRI2BufferFrontLeft = 0
const DRI2BufferBackLeft = 1
const DRI2BufferFrontRight = 2
const DRI2BufferBackRight = 3
const DRI2BufferDepth = 4
const DRI2BufferStencil = 5
const DRI2BufferAccum = 6
const DRI2BufferFakeFrontLeft = 7
const DRI2BufferFakeFrontRight = 8
const DRI2BufferDepthStencil = 9
const DRI2BufferHiz = 10
const DRI2DriverPrimeMask = 7
const DRI2DriverPrimeShift = 16
#define DRI2DriverPrimeId(x) (((x) shr DRI2DriverPrimeShift) and DRI2DriverPrimeMask)
const DRI2DriverDRI = 0
const DRI2DriverVDPAU = 1
const DRI2_EXCHANGE_COMPLETE = &h1
const DRI2_BLIT_COMPLETE = &h2
const DRI2_FLIP_COMPLETE = &h3
