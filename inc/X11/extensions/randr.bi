'' FreeBASIC binding for randrproto-1.4.1
''
'' based on the C header files:
''    Copyright © 2000 Compaq Computer Corporation
''    Copyright © 2002 Hewlett Packard Company
''    Copyright © 2006 Intel Corporation
''    Copyright © 2008 Red Hat, Inc.
''
''    Permission to use, copy, modify, distribute, and sell this software and its
''    documentation for any purpose is hereby granted without fee, provided that
''    the above copyright notice appear in all copies and that both that copyright
''    notice and this permission notice appear in supporting documentation, and
''    that the name of the copyright holders not be used in advertising or
''    publicity pertaining to distribution of the software without specific,
''    written prior permission.  The copyright holders make no representations
''    about the suitability of this software for any purpose.  It is provided "as
''    is" without express or implied warranty.
''
''    THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''    INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''    EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''    CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''    DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
''    OF THIS SOFTWARE.
''
''    Author:  Jim Gettys, HP Labs, Hewlett-Packard, Inc.
''   	    Keith Packard, Intel Corporation
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define _RANDR_H_
type Rotation as ushort
type SizeID as ushort
type SubpixelOrder as ushort
type Connection as ushort
type XRandrRotation as ushort
type XRandrSizeID as ushort
type XRandrSubpixelOrder as ushort
type XRandrModeFlags as culong

#define RANDR_NAME "RANDR"
const RANDR_MAJOR = 1
const RANDR_MINOR = 4
const RRNumberErrors = 4
const RRNumberEvents = 2
const RRNumberRequests = 42
const X_RRQueryVersion = 0
const X_RROldGetScreenInfo = 1
const X_RR1_0SetScreenConfig = 2
const X_RRSetScreenConfig = 2
const X_RROldScreenChangeSelectInput = 3
const X_RRSelectInput = 4
const X_RRGetScreenInfo = 5
const X_RRGetScreenSizeRange = 6
const X_RRSetScreenSize = 7
const X_RRGetScreenResources = 8
const X_RRGetOutputInfo = 9
const X_RRListOutputProperties = 10
const X_RRQueryOutputProperty = 11
const X_RRConfigureOutputProperty = 12
const X_RRChangeOutputProperty = 13
const X_RRDeleteOutputProperty = 14
const X_RRGetOutputProperty = 15
const X_RRCreateMode = 16
const X_RRDestroyMode = 17
const X_RRAddOutputMode = 18
const X_RRDeleteOutputMode = 19
const X_RRGetCrtcInfo = 20
const X_RRSetCrtcConfig = 21
const X_RRGetCrtcGammaSize = 22
const X_RRGetCrtcGamma = 23
const X_RRSetCrtcGamma = 24
const X_RRGetScreenResourcesCurrent = 25
const X_RRSetCrtcTransform = 26
const X_RRGetCrtcTransform = 27
const X_RRGetPanning = 28
const X_RRSetPanning = 29
const X_RRSetOutputPrimary = 30
const X_RRGetOutputPrimary = 31
const RRTransformUnit = cast(clong, 1) shl 0
const RRTransformScaleUp = cast(clong, 1) shl 1
const RRTransformScaleDown = cast(clong, 1) shl 2
const RRTransformProjective = cast(clong, 1) shl 3
const X_RRGetProviders = 32
const X_RRGetProviderInfo = 33
const X_RRSetProviderOffloadSink = 34
const X_RRSetProviderOutputSource = 35
const X_RRListProviderProperties = 36
const X_RRQueryProviderProperty = 37
const X_RRConfigureProviderProperty = 38
const X_RRChangeProviderProperty = 39
const X_RRDeleteProviderProperty = 40
const X_RRGetProviderProperty = 41
const RRScreenChangeNotifyMask = cast(clong, 1) shl 0
const RRCrtcChangeNotifyMask = cast(clong, 1) shl 1
const RROutputChangeNotifyMask = cast(clong, 1) shl 2
const RROutputPropertyNotifyMask = cast(clong, 1) shl 3
const RRProviderChangeNotifyMask = cast(clong, 1) shl 4
const RRProviderPropertyNotifyMask = cast(clong, 1) shl 5
const RRResourceChangeNotifyMask = cast(clong, 1) shl 6
const RRScreenChangeNotify = 0
const RRNotify = 1
const RRNotify_CrtcChange = 0
const RRNotify_OutputChange = 1
const RRNotify_OutputProperty = 2
const RRNotify_ProviderChange = 3
const RRNotify_ProviderProperty = 4
const RRNotify_ResourceChange = 5
const RR_Rotate_0 = 1
const RR_Rotate_90 = 2
const RR_Rotate_180 = 4
const RR_Rotate_270 = 8
const RR_Reflect_X = 16
const RR_Reflect_Y = 32
const RRSetConfigSuccess = 0
const RRSetConfigInvalidConfigTime = 1
const RRSetConfigInvalidTime = 2
const RRSetConfigFailed = 3
const RR_HSyncPositive = &h00000001
const RR_HSyncNegative = &h00000002
const RR_VSyncPositive = &h00000004
const RR_VSyncNegative = &h00000008
const RR_Interlace = &h00000010
const RR_DoubleScan = &h00000020
const RR_CSync = &h00000040
const RR_CSyncPositive = &h00000080
const RR_CSyncNegative = &h00000100
const RR_HSkewPresent = &h00000200
const RR_BCast = &h00000400
const RR_PixelMultiplex = &h00000800
const RR_DoubleClock = &h00001000
const RR_ClockDivideBy2 = &h00002000
const RR_Connected = 0
const RR_Disconnected = 1
const RR_UnknownConnection = 2
const BadRROutput = 0
const BadRRCrtc = 1
const BadRRMode = 2
const BadRRProvider = 3
#define RR_PROPERTY_BACKLIGHT "Backlight"
#define RR_PROPERTY_RANDR_EDID "EDID"
#define RR_PROPERTY_SIGNAL_FORMAT "SignalFormat"
#define RR_PROPERTY_SIGNAL_PROPERTIES "SignalProperties"
#define RR_PROPERTY_CONNECTOR_TYPE "ConnectorType"
#define RR_PROPERTY_CONNECTOR_NUMBER "ConnectorNumber"
#define RR_PROPERTY_COMPATIBILITY_LIST "CompatibilityList"
#define RR_PROPERTY_CLONE_LIST "CloneList"
#define RR_PROPERTY_BORDER "Border"
#define RR_PROPERTY_BORDER_DIMENSIONS "BorderDimensions"
#define RR_PROPERTY_GUID "GUID"
const RR_Capability_None = 0
const RR_Capability_SourceOutput = 1
const RR_Capability_SinkOutput = 2
const RR_Capability_SourceOffload = 4
const RR_Capability_SinkOffload = 8
