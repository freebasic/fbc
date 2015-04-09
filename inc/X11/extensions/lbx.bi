'' FreeBASIC binding for xextproto-7.3.0

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
#define LbxNumberErrors (BadLbxClient + 1)
const LbxTagTypeModmap = 1
const LbxTagTypeKeymap = 2
const LbxTagTypeProperty = 3
const LbxTagTypeFont = 4
const LbxTagTypeConnInfo = 5
