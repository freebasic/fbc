''
''
'' randr -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __randr_bi__
#define __randr_bi__

type Rotation as ushort
type SizeID as ushort
type SubpixelOrder as ushort
type Connection as ushort
type XRandrRotation as ushort
type XRandrSizeID as ushort
type XRandrSubpixelOrder as ushort
type XRandrModeFlags as uinteger

#define RANDR_NAME "RANDR"
#define RANDR_MAJOR 1
#define RANDR_MINOR 3
#define RRNumberErrors 3
#define RRNumberEvents 2
#define RRNumberRequests 32
#define X_RRQueryVersion 0
#define X_RROldGetScreenInfo 1
#define X_RR1_0SetScreenConfig 2
#define X_RRSetScreenConfig 2
#define X_RROldScreenChangeSelectInput 3
#define X_RRSelectInput 4
#define X_RRGetScreenInfo 5
#define X_RRGetScreenSizeRange 6
#define X_RRSetScreenSize 7
#define X_RRGetScreenResources 8
#define X_RRGetOutputInfo 9
#define X_RRListOutputProperties 10
#define X_RRQueryOutputProperty 11
#define X_RRConfigureOutputProperty 12
#define X_RRChangeOutputProperty 13
#define X_RRDeleteOutputProperty 14
#define X_RRGetOutputProperty 15
#define X_RRCreateMode 16
#define X_RRDestroyMode 17
#define X_RRAddOutputMode 18
#define X_RRDeleteOutputMode 19
#define X_RRGetCrtcInfo 20
#define X_RRSetCrtcConfig 21
#define X_RRGetCrtcGammaSize 22
#define X_RRGetCrtcGamma 23
#define X_RRSetCrtcGamma 24
#define X_RRGetScreenResourcesCurrent 25
#define X_RRSetCrtcTransform 26
#define X_RRGetCrtcTransform 27
#define X_RRGetPanning 28
#define X_RRSetPanning 29
#define X_RRSetOutputPrimary 30
#define X_RRGetOutputPrimary 31
#define RRTransformUnit (1L shl 0)
#define RRTransformScaleUp (1L shl 1)
#define RRTransformScaleDown (1L shl 2)
#define RRTransformProjective (1L shl 3)
#define RRScreenChangeNotifyMask (1L shl 0)
#define RRCrtcChangeNotifyMask (1L shl 1)
#define RROutputChangeNotifyMask (1L shl 2)
#define RROutputPropertyNotifyMask (1L shl 3)
#define RRScreenChangeNotify 0
#define RRNotify 1
#define RRNotify_CrtcChange 0
#define RRNotify_OutputChange 1
#define RRNotify_OutputProperty 2
#define RR_Rotate_0 1
#define RR_Rotate_90 2
#define RR_Rotate_180 4
#define RR_Rotate_270 8
#define RR_Reflect_X 16
#define RR_Reflect_Y 32
#define RRSetConfigSuccess 0
#define RRSetConfigInvalidConfigTime 1
#define RRSetConfigInvalidTime 2
#define RRSetConfigFailed 3
#define RR_HSyncPositive &h00000001
#define RR_HSyncNegative &h00000002
#define RR_VSyncPositive &h00000004
#define RR_VSyncNegative &h00000008
#define RR_Interlace &h00000010
#define RR_DoubleScan &h00000020
#define RR_CSync &h00000040
#define RR_CSyncPositive &h00000080
#define RR_CSyncNegative &h00000100
#define RR_HSkewPresent &h00000200
#define RR_BCast &h00000400
#define RR_PixelMultiplex &h00000800
#define RR_DoubleClock &h00001000
#define RR_ClockDivideBy2 &h00002000
#define RR_Connected 0
#define RR_Disconnected 1
#define RR_UnknownConnection 2
#define BadRROutput 0
#define BadRRCrtc 1
#define BadRRMode 2
#define RR_PROPERTY_RANDR_EDID "EDID"
#define RR_PROPERTY_SIGNAL_FORMAT "SignalFormat"
#define RR_PROPERTY_SIGNAL_PROPERTIES "SignalProperties"
#define RR_PROPERTY_CONNECTOR_TYPE "ConnectorType"
#define RR_PROPERTY_CONNECTOR_NUMBER "ConnectorNumber"
#define RR_PROPERTY_COMPATIBILITY_LIST "CompatibilityList"
#define RR_PROPERTY_CLONE_LIST "CloneList"

#endif
