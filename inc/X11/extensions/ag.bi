'' FreeBASIC binding for xextproto-7.3.0

#pragma once

#define _AG_H_
#define XAGNAME "XC-APPGROUP"
const XAG_MAJOR_VERSION = 1
const XAG_MINOR_VERSION = 0
const XagWindowTypeX11 = 0
const XagWindowTypeMacintosh = 1
const XagWindowTypeWin32 = 2
const XagWindowTypeWin16 = 3
const XagBadAppGroup = 0
#define XagNumberErrors (XagBadAppGroup + 1)
const XagNsingleScreen = 7
const XagNdefaultRoot = 1
const XagNrootVisual = 2
const XagNdefaultColormap = 3
const XagNblackPixel = 4
const XagNwhitePixel = 5
const XagNappGroupLeader = 6
