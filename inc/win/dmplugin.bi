'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic Performance Layer Plugins API
''
''   Copyright (C) 2003-2004 Rok Mandeljc
''
''   This program is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "dxguid"

#include once "windows.bi"
#include once "objbase.bi"
#include once "mmsystem.bi"
#include once "dmusici.bi"

extern "Windows"

#define __WINE_DMUSIC_PLUGIN_H
#define DMUS_REGSTR_PATH_TOOLS !"Software\\Microsoft\\DirectMusic\\Tools"
extern CLSID_DirectMusicBandTrack as const GUID
extern CLSID_DirectMusicChordTrack as const GUID
extern CLSID_DirectMusicChordMapTrack as const GUID
extern CLSID_DirectMusicCommandTrack as const GUID
extern CLSID_DirectMusicLyricsTrack as const GUID
extern CLSID_DirectMusicMarkerTrack as const GUID
extern CLSID_DirectMusicMotifTrack as const GUID
extern CLSID_DirectMusicMuteTrack as const GUID
extern CLSID_DirectMusicParamControlTrack as const GUID
extern CLSID_DirectMusicScriptTrack as const GUID
extern CLSID_DirectMusicSegmentTriggerTrack as const GUID
extern CLSID_DirectMusicSeqTrack as const GUID
extern CLSID_DirectMusicSignPostTrack as const GUID
extern CLSID_DirectMusicStyleTrack as const GUID
extern CLSID_DirectMusicSysExTrack as const GUID
extern CLSID_DirectMusicTempoTrack as const GUID
extern CLSID_DirectMusicTimeSigTrack as const GUID
extern CLSID_DirectMusicWaveTrack as const GUID
extern CLSID_DirectMusicMelodyFormulationTrack as const GUID
extern IID_IDirectMusicTool as const GUID
extern IID_IDirectMusicTool8 as const GUID
extern IID_IDirectMusicTrack as const GUID
extern IID_IDirectMusicTrack8 as const GUID

type LPDIRECTMUSICTRACK as IDirectMusicTrack ptr
type LPDIRECTMUSICTRACK8 as IDirectMusicTrack8 ptr
type LPDIRECTMUSICTOOL as IDirectMusicTool ptr
type LPDIRECTMUSICTOOL8 as IDirectMusicTool8 ptr
type IDirectMusicPerformance as IDirectMusicPerformance_
type LPDIRECTMUSICPERFORMANCE as IDirectMusicPerformance ptr
type LPDIRECTMUSICPERFORMANCE8 as IDirectMusicPerformance8 ptr
type IDirectMusicSegment as IDirectMusicSegment_
type LPDIRECTMUSICSEGMENT as IDirectMusicSegment ptr
type LPDIRECTMUSICSEGMENT8 as IDirectMusicSegment8 ptr
type IDirectMusicSegmentState as IDirectMusicSegmentState_
type LPDIRECTMUSICSEGMENTSTATE as IDirectMusicSegmentState ptr
type LPDIRECTMUSICSEGMENTSTATE8 as IDirectMusicSegmentState8 ptr
type IDirectMusicGraph as IDirectMusicGraph_
type LPDIRECTMUSICGRAPH as IDirectMusicGraph ptr
type IDirectMusicGraph8 as IDirectMusicGraph
type LPDIRECTMUSICGRAPH8 as IDirectMusicGraph ptr
type DMUS_PMSG as _DMUS_PMSG
type MUSIC_TIME as LONG
const DMUS_TRACK_PARAMF_CLOCK = &h1
type DMUS_TRACKF_FLAGS as enumDMUS_TRACKF_FLAGS

type enumDMUS_TRACKF_FLAGS as long
enum
	DMUS_TRACKF_SEEK = &h001
	DMUS_TRACKF_LOOP = &h002
	DMUS_TRACKF_START = &h004
	DMUS_TRACKF_FLUSH = &h008
	DMUS_TRACKF_DIRTY = &h010
	DMUS_TRACKF_NOTIFY_OFF = &h020
	DMUS_TRACKF_PLAY_OFF = &h040
	DMUS_TRACKF_LOOPEND = &h080
	DMUS_TRACKF_STOP = &h100
	DMUS_TRACKF_RECOMPOSE = &h200
	DMUS_TRACKF_CLOCK = &h400
end enum

type IDirectMusicToolVtbl as IDirectMusicToolVtbl_

type IDirectMusicTool
	lpVtbl as IDirectMusicToolVtbl ptr
end type

type IDirectMusicToolVtbl_
	QueryInterface as function(byval This as IDirectMusicTool ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicTool ptr) as ULONG
	Release as function(byval This as IDirectMusicTool ptr) as ULONG
	Init as function(byval This as IDirectMusicTool ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	GetMsgDeliveryType as function(byval This as IDirectMusicTool ptr, byval pdwDeliveryType as DWORD ptr) as HRESULT
	GetMediaTypeArraySize as function(byval This as IDirectMusicTool ptr, byval pdwNumElements as DWORD ptr) as HRESULT
	GetMediaTypes as function(byval This as IDirectMusicTool ptr, byval padwMediaTypes as DWORD ptr ptr, byval dwNumElements as DWORD) as HRESULT
	ProcessPMsg as function(byval This as IDirectMusicTool ptr, byval pPerf as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	Flush as function(byval This as IDirectMusicTool ptr, byval pPerf as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr, byval rtTime as REFERENCE_TIME) as HRESULT
end type

#define IDirectMusicTool_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicTool_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicTool_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicTool_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirectMusicTool_GetMsgDeliveryType(p, a) (p)->lpVtbl->GetMsgDeliveryType(p, a)
#define IDirectMusicTool_GetMediaTypeArraySize(p, a) (p)->lpVtbl->GetMediaTypeArraySize(p, a)
#define IDirectMusicTool_GetMediaTypes(p, a, b) (p)->lpVtbl->GetMediaTypes(p, a, b)
#define IDirectMusicTool_ProcessPMsg(p, a, b) (p)->lpVtbl->ProcessPMsg(p, a, b)
#define IDirectMusicTool_Flush(p, a, b, c) (p)->lpVtbl->Flush(p, a, b, c)
type IDirectMusicTool8Vtbl as IDirectMusicTool8Vtbl_

type IDirectMusicTool8
	lpVtbl as IDirectMusicTool8Vtbl ptr
end type

type IDirectMusicTool8Vtbl_
	QueryInterface as function(byval This as IDirectMusicTool8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicTool8 ptr) as ULONG
	Release as function(byval This as IDirectMusicTool8 ptr) as ULONG
	Init as function(byval This as IDirectMusicTool8 ptr, byval pGraph as IDirectMusicGraph ptr) as HRESULT
	GetMsgDeliveryType as function(byval This as IDirectMusicTool8 ptr, byval pdwDeliveryType as DWORD ptr) as HRESULT
	GetMediaTypeArraySize as function(byval This as IDirectMusicTool8 ptr, byval pdwNumElements as DWORD ptr) as HRESULT
	GetMediaTypes as function(byval This as IDirectMusicTool8 ptr, byval padwMediaTypes as DWORD ptr ptr, byval dwNumElements as DWORD) as HRESULT
	ProcessPMsg as function(byval This as IDirectMusicTool8 ptr, byval pPerf as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr) as HRESULT
	Flush as function(byval This as IDirectMusicTool8 ptr, byval pPerf as IDirectMusicPerformance ptr, byval pPMSG as DMUS_PMSG ptr, byval rtTime as REFERENCE_TIME) as HRESULT
	Clone as function(byval This as IDirectMusicTool8 ptr, byval ppTool as IDirectMusicTool ptr ptr) as HRESULT
end type

#define IDirectMusicTool8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicTool8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicTool8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicTool8_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirectMusicTool8_GetMsgDeliveryType(p, a) (p)->lpVtbl->GetMsgDeliveryType(p, a)
#define IDirectMusicTool8_GetMediaTypeArraySize(p, a) (p)->lpVtbl->GetMediaTypeArraySize(p, a)
#define IDirectMusicTool8_GetMediaTypes(p, a, b) (p)->lpVtbl->GetMediaTypes(p, a, b)
#define IDirectMusicTool8_ProcessPMsg(p, a, b) (p)->lpVtbl->ProcessPMsg(p, a, b)
#define IDirectMusicTool8_Flush(p, a, b) (p)->lpVtbl->Flush(p, a, b)
#define IDirectMusicTool8_Clone(p, a) (p)->lpVtbl->Clone(p, a)
type IDirectMusicTrackVtbl as IDirectMusicTrackVtbl_

type IDirectMusicTrack
	lpVtbl as IDirectMusicTrackVtbl ptr
end type

type IDirectMusicTrackVtbl_
	QueryInterface as function(byval This as IDirectMusicTrack ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicTrack ptr) as ULONG
	Release as function(byval This as IDirectMusicTrack ptr) as ULONG
	Init as function(byval This as IDirectMusicTrack ptr, byval pSegment as IDirectMusicSegment ptr) as HRESULT
	InitPlay as function(byval This as IDirectMusicTrack ptr, byval pSegmentState as IDirectMusicSegmentState ptr, byval pPerformance as IDirectMusicPerformance ptr, byval ppStateData as any ptr ptr, byval dwVirtualTrackID as DWORD, byval dwFlags as DWORD) as HRESULT
	EndPlay as function(byval This as IDirectMusicTrack ptr, byval pStateData as any ptr) as HRESULT
	Play as function(byval This as IDirectMusicTrack ptr, byval pStateData as any ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval mtOffset as MUSIC_TIME, byval dwFlags as DWORD, byval pPerf as IDirectMusicPerformance ptr, byval pSegSt as IDirectMusicSegmentState ptr, byval dwVirtualID as DWORD) as HRESULT
	GetParam as function(byval This as IDirectMusicTrack ptr, byval rguidType as const GUID const ptr, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicTrack ptr, byval rguidType as const GUID const ptr, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	IsParamSupported as function(byval This as IDirectMusicTrack ptr, byval rguidType as const GUID const ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicTrack ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicTrack ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	Clone as function(byval This as IDirectMusicTrack ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval ppTrack as IDirectMusicTrack ptr ptr) as HRESULT
end type

#define IDirectMusicTrack_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicTrack_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicTrack_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicTrack_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirectMusicTrack_InitPlay(p, a, b, c, d, e) (p)->lpVtbl->InitPlay(p, a, b, c, d, e)
#define IDirectMusicTrack_EndPlay(p, a) (p)->lpVtbl->EndPlay(p, a)
#define IDirectMusicTrack_Play(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->Play(p, a, b, c, d, e, f, g, h)
#define IDirectMusicTrack_GetParam(p, a, b, c, d) (p)->lpVtbl->GetParam(p, a, b, c, d)
#define IDirectMusicTrack_SetParam(p, a, b, c) (p)->lpVtbl->SetParam(p, a, b, c)
#define IDirectMusicTrack_IsParamSupported(p, a) (p)->lpVtbl->IsParamSupported(p, a)
#define IDirectMusicTrack_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicTrack_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicTrack_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
type IDirectMusicTrack8Vtbl as IDirectMusicTrack8Vtbl_

type IDirectMusicTrack8
	lpVtbl as IDirectMusicTrack8Vtbl ptr
end type

type IDirectMusicTrack8Vtbl_
	QueryInterface as function(byval This as IDirectMusicTrack8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicTrack8 ptr) as ULONG
	Release as function(byval This as IDirectMusicTrack8 ptr) as ULONG
	Init as function(byval This as IDirectMusicTrack8 ptr, byval pSegment as IDirectMusicSegment ptr) as HRESULT
	InitPlay as function(byval This as IDirectMusicTrack8 ptr, byval pSegmentState as IDirectMusicSegmentState ptr, byval pPerformance as IDirectMusicPerformance ptr, byval ppStateData as any ptr ptr, byval dwVirtualTrackID as DWORD, byval dwFlags as DWORD) as HRESULT
	EndPlay as function(byval This as IDirectMusicTrack8 ptr, byval pStateData as any ptr) as HRESULT
	Play as function(byval This as IDirectMusicTrack8 ptr, byval pStateData as any ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval mtOffset as MUSIC_TIME, byval dwFlags as DWORD, byval pPerf as IDirectMusicPerformance ptr, byval pSegSt as IDirectMusicSegmentState ptr, byval dwVirtualID as DWORD) as HRESULT
	GetParam as function(byval This as IDirectMusicTrack8 ptr, byval rguidType as const GUID const ptr, byval mtTime as MUSIC_TIME, byval pmtNext as MUSIC_TIME ptr, byval pParam as any ptr) as HRESULT
	SetParam as function(byval This as IDirectMusicTrack8 ptr, byval rguidType as const GUID const ptr, byval mtTime as MUSIC_TIME, byval pParam as any ptr) as HRESULT
	IsParamSupported as function(byval This as IDirectMusicTrack8 ptr, byval rguidType as const GUID const ptr) as HRESULT
	AddNotificationType as function(byval This as IDirectMusicTrack8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	RemoveNotificationType as function(byval This as IDirectMusicTrack8 ptr, byval rguidNotificationType as const GUID const ptr) as HRESULT
	Clone as function(byval This as IDirectMusicTrack8 ptr, byval mtStart as MUSIC_TIME, byval mtEnd as MUSIC_TIME, byval ppTrack as IDirectMusicTrack ptr ptr) as HRESULT
	PlayEx as function(byval This as IDirectMusicTrack8 ptr, byval pStateData as any ptr, byval rtStart as REFERENCE_TIME, byval rtEnd as REFERENCE_TIME, byval rtOffset as REFERENCE_TIME, byval dwFlags as DWORD, byval pPerf as IDirectMusicPerformance ptr, byval pSegSt as IDirectMusicSegmentState ptr, byval dwVirtualID as DWORD) as HRESULT
	GetParamEx as function(byval This as IDirectMusicTrack8 ptr, byval rguidType as const GUID const ptr, byval rtTime as REFERENCE_TIME, byval prtNext as REFERENCE_TIME ptr, byval pParam as any ptr, byval pStateData as any ptr, byval dwFlags as DWORD) as HRESULT
	SetParamEx as function(byval This as IDirectMusicTrack8 ptr, byval rguidType as const GUID const ptr, byval rtTime as REFERENCE_TIME, byval pParam as any ptr, byval pStateData as any ptr, byval dwFlags as DWORD) as HRESULT
	Compose as function(byval This as IDirectMusicTrack8 ptr, byval pContext as IUnknown ptr, byval dwTrackGroup as DWORD, byval ppResultTrack as IDirectMusicTrack ptr ptr) as HRESULT
	Join as function(byval This as IDirectMusicTrack8 ptr, byval pNewTrack as IDirectMusicTrack ptr, byval mtJoin as MUSIC_TIME, byval pContext as IUnknown ptr, byval dwTrackGroup as DWORD, byval ppResultTrack as IDirectMusicTrack ptr ptr) as HRESULT
end type

#define IDirectMusicTrack8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicTrack8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicTrack8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicTrack8_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirectMusicTrack8_InitPlay(p, a, b, c, d, e) (p)->lpVtbl->InitPlay(p, a, b, c, d, e)
#define IDirectMusicTrack8_EndPlay(p, a) (p)->lpVtbl->EndPlay(p, a)
#define IDirectMusicTrack8_Play(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->Play(p, a, b, c, d, e, f, g, h)
#define IDirectMusicTrack8_GetParam(p, a, b, c, d) (p)->lpVtbl->GetParam(p, a, b, c, d)
#define IDirectMusicTrack8_SetParam(p, a, b, c) (p)->lpVtbl->SetParam(p, a, b, c)
#define IDirectMusicTrack8_IsParamSupported(p, a) (p)->lpVtbl->IsParamSupported(p, a)
#define IDirectMusicTrack8_AddNotificationType(p, a) (p)->lpVtbl->AddNotificationType(p, a)
#define IDirectMusicTrack8_RemoveNotificationType(p, a) (p)->lpVtbl->RemoveNotificationType(p, a)
#define IDirectMusicTrack8_Clone(p, a, b, c) (p)->lpVtbl->Clone(p, a, b, c)
#define IDirectMusicTrack8_PlayEx(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->PlayEx(p, a, b, c, d, e, f, g, h)
#define IDirectMusicTrack8_GetParamEx(p, a, b, c, d, e, f) (p)->lpVtbl->GetParamEx(p, a, b, c, d, e, f)
#define IDirectMusicTrack8_SetParamEx(p, a, b, c, d, e) (p)->lpVtbl->SetParamEx(p, a, b, c, d, e)
#define IDirectMusicTrack8_Compose(p, a, b, c) (p)->lpVtbl->Compose(p, a, b, c)
#define IDirectMusicTrack8_Join(p, a, b, c, d, e) (p)->lpVtbl->Join(p, a, b, c, d, e)

end extern
