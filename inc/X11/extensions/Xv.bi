'' FreeBASIC binding for videoproto-2.3.2

#pragma once

#include once "crt/long.bi"
#include once "X11/X.bi"

#define XV_H
#define XvName "XVideo"
const XvVersion = 2
const XvRevision = 2
type XvPortID as XID
type XvEncodingID as XID
const XvNone = 0
const XvInput = 0
const XvOutput = 1
#define XvInputMask (cast(clong, 1) shl XvInput)
#define XvOutputMask (cast(clong, 1) shl XvOutput)
const XvVideoMask = &h00000004
const XvStillMask = &h00000008
const XvImageMask = &h00000010
const XvPixmapMask = &h00010000
const XvWindowMask = &h00020000
const XvGettable = &h01
const XvSettable = &h02
const XvRGB = 0
const XvYUV = 1
const XvPacked = 0
const XvPlanar = 1
const XvTopToBottom = 0
const XvBottomToTop = 1
const XvVideoNotify = 0
const XvPortNotify = 1
const XvNumEvents = 2
const XvStarted = 0
const XvStopped = 1
const XvBusy = 2
const XvPreempted = 3
const XvHardError = 4
const XvLastReason = 4
#define XvNumReasons (XvLastReason + 1)
#define XvStartedMask (cast(clong, 1) shl XvStarted)
#define XvStoppedMask (cast(clong, 1) shl XvStopped)
#define XvBusyMask (cast(clong, 1) shl XvBusy)
#define XvPreemptedMask (cast(clong, 1) shl XvPreempted)
#define XvHardErrorMask (cast(clong, 1) shl XvHardError)
#define XvAnyReasonMask ((cast(clong, 1) shl XvNumReasons) - 1)
const XvNoReasonMask = 0
const XvBadPort = 0
const XvBadEncoding = 1
const XvBadControl = 2
const XvNumErrors = 3
const XvBadExtension = 1
const XvAlreadyGrabbed = 2
const XvInvalidTime = 3
const XvBadReply = 4
const XvBadAlloc = 5
