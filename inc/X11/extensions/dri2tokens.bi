'' FreeBASIC binding for dri2proto-2.8

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
