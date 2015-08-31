'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define __QOS_H_
type SERVICETYPE as ULONG
const SERVICETYPE_NOTRAFFIC = &h00000000
const SERVICETYPE_BESTEFFORT = &h00000001
const SERVICETYPE_CONTROLLEDLOAD = &h00000002
const SERVICETYPE_GUARANTEED = &h00000003
const SERVICETYPE_NETWORK_UNAVAILABLE = &h00000004
const SERVICETYPE_GENERAL_INFORMATION = &h00000005
const SERVICETYPE_NOCHANGE = &h00000006
const SERVICETYPE_NONCONFORMING = &h00000009
const SERVICETYPE_NETWORK_CONTROL = &h0000000A
const SERVICETYPE_QUALITATIVE = &h0000000D
const SERVICE_BESTEFFORT = &h80010000
const SERVICE_CONTROLLEDLOAD = &h80020000
const SERVICE_GUARANTEED = &h80040000
const SERVICE_QUALITATIVE = &h80200000
const SERVICE_NO_TRAFFIC_CONTROL = &h81000000
const SERVICE_NO_QOS_SIGNALING = &h40000000

type _flowspec
	TokenRate as ULONG
	TokenBucketSize as ULONG
	PeakBandwidth as ULONG
	Latency as ULONG
	DelayVariation as ULONG
	ServiceType as SERVICETYPE
	MaxSduSize as ULONG
	MinimumPolicedSize as ULONG
end type

type FLOWSPEC as _flowspec
type PFLOWSPEC as _flowspec ptr
type LPFLOWSPEC as _flowspec ptr
const QOS_NOT_SPECIFIED = &hFFFFFFFF
const POSITIVE_INFINITY_RATE = &hFFFFFFFE

type _QOS_OBJECT_HDR
	ObjectType as ULONG
	ObjectLength as ULONG
end type

type QOS_OBJECT_HDR as _QOS_OBJECT_HDR
type LPQOS_OBJECT_HDR as _QOS_OBJECT_HDR ptr
const QOS_GENERAL_ID_BASE = 2000
const QOS_OBJECT_END_OF_LIST = &h00000001 + QOS_GENERAL_ID_BASE
const QOS_OBJECT_SD_MODE = &h00000002 + QOS_GENERAL_ID_BASE
const QOS_OBJECT_SHAPING_RATE = &h00000003 + QOS_GENERAL_ID_BASE
const QOS_OBJECT_DESTADDR = &h00000004 + QOS_GENERAL_ID_BASE

type _QOS_SD_MODE
	ObjectHdr as QOS_OBJECT_HDR
	ShapeDiscardMode as ULONG
end type

type QOS_SD_MODE as _QOS_SD_MODE
type LPQOS_SD_MODE as _QOS_SD_MODE ptr
const TC_NONCONF_BORROW = 0
const TC_NONCONF_SHAPE = 1
const TC_NONCONF_DISCARD = 2
const TC_NONCONF_BORROW_PLUS = 3

type _QOS_SHAPING_RATE
	ObjectHdr as QOS_OBJECT_HDR
	ShapingRate as ULONG
end type

type QOS_SHAPING_RATE as _QOS_SHAPING_RATE
type LPQOS_SHAPING_RATE as _QOS_SHAPING_RATE ptr
