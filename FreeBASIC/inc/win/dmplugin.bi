''
''
'' dmplugin -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmplugin_bi__
#define __win_dmplugin_bi__

#inclib "dxguid"

#include once "windows.bi"
#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"
#include once "win/mmsystem.bi"
#include once "win/dmusici.bi"

type MUSIC_TIME as integer

#define DMUS_REGSTR_PATH_TOOLS $"Software\Microsoft\DirectMusic\Tools"

type IDirectMusicToolVtbl_ as IDirectMusicToolVtbl

type IDirectMusicTool
	lpVtbl as IDirectMusicToolVtbl_ ptr
end type

type IDirectMusicToolVtbl
	QueryInterface as function(byval as IDirectMusicTool ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicTool ptr) as ULONG
	Release as function(byval as IDirectMusicTool ptr) as ULONG
	Init as function(byval as IDirectMusicTool ptr, byval as IDirectMusicGraph ptr) as HRESULT
	GetMsgDeliveryType as function(byval as IDirectMusicTool ptr, byval as DWORD ptr) as HRESULT
	GetMediaTypeArraySize as function(byval as IDirectMusicTool ptr, byval as DWORD ptr) as HRESULT
	GetMediaTypes as function(byval as IDirectMusicTool ptr, byval as DWORD ptr ptr, byval as DWORD) as HRESULT
	ProcessPMsg as function(byval as IDirectMusicTool ptr, byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr) as HRESULT
	Flush as function(byval as IDirectMusicTool ptr, byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr, byval as REFERENCE_TIME) as HRESULT
end type

type IDirectMusicTool8Vtbl_ as IDirectMusicTool8Vtbl

type IDirectMusicTool8
	lpVtbl as IDirectMusicTool8Vtbl_ ptr
end type

type IDirectMusicTool8Vtbl
	QueryInterface as function(byval as IDirectMusicTool8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicTool8 ptr) as ULONG
	Release as function(byval as IDirectMusicTool8 ptr) as ULONG
	Init as function(byval as IDirectMusicTool8 ptr, byval as IDirectMusicGraph ptr) as HRESULT
	GetMsgDeliveryType as function(byval as IDirectMusicTool8 ptr, byval as DWORD ptr) as HRESULT
	GetMediaTypeArraySize as function(byval as IDirectMusicTool8 ptr, byval as DWORD ptr) as HRESULT
	GetMediaTypes as function(byval as IDirectMusicTool8 ptr, byval as DWORD ptr ptr, byval as DWORD) as HRESULT
	ProcessPMsg as function(byval as IDirectMusicTool8 ptr, byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr) as HRESULT
	Flush as function(byval as IDirectMusicTool8 ptr, byval as IDirectMusicPerformance ptr, byval as DMUS_PMSG ptr, byval as REFERENCE_TIME) as HRESULT
	Clone as function(byval as IDirectMusicTool8 ptr, byval as IDirectMusicTool ptr ptr) as HRESULT
end type

enum enumDMUS_TRACKF_FLAGS
	DMUS_TRACKF_SEEK = 1
	DMUS_TRACKF_LOOP = 2
	DMUS_TRACKF_START = 4
	DMUS_TRACKF_FLUSH = 8
	DMUS_TRACKF_DIRTY = &h10
	DMUS_TRACKF_NOTIFY_OFF = &h20
	DMUS_TRACKF_PLAY_OFF = &h40
	DMUS_TRACKF_LOOPEND = &h80
	DMUS_TRACKF_STOP = &h100
	DMUS_TRACKF_RECOMPOSE = &h200
	DMUS_TRACKF_CLOCK = &h400
end enum

type DMUS_TRACKF_FLAGS as enumDMUS_TRACKF_FLAGS

#define DMUS_TRACK_PARAMF_CLOCK &h01

type IDirectMusicTrackVtbl_ as IDirectMusicTrackVtbl

type IDirectMusicTrack
	lpVtbl as IDirectMusicTrackVtbl_ ptr
end type

type IDirectMusicTrackVtbl
	QueryInterface as function(byval as IDirectMusicTrack ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicTrack ptr) as ULONG
	Release as function(byval as IDirectMusicTrack ptr) as ULONG
	Init as function(byval as IDirectMusicTrack ptr, byval as IDirectMusicSegment ptr) as HRESULT
	InitPlay as function(byval as IDirectMusicTrack ptr, byval as IDirectMusicSegmentState ptr, byval as IDirectMusicPerformance ptr, byval as any ptr ptr, byval as DWORD, byval as DWORD) as HRESULT
	EndPlay as function(byval as IDirectMusicTrack ptr, byval as any ptr) as HRESULT
	Play as function(byval as IDirectMusicTrack ptr, byval as any ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as DWORD, byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegmentState ptr, byval as DWORD) as HRESULT
	GetParam as function(byval as IDirectMusicTrack ptr, byval as GUID ptr, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicTrack ptr, byval as GUID ptr, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	IsParamSupported as function(byval as IDirectMusicTrack ptr, byval as GUID ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicTrack ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicTrack ptr, byval as GUID ptr) as HRESULT
	Clone as function(byval as IDirectMusicTrack ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as IDirectMusicTrack ptr ptr) as HRESULT
end type

type IDirectMusicTrack8Vtbl_ as IDirectMusicTrack8Vtbl

type IDirectMusicTrack8
	lpVtbl as IDirectMusicTrack8Vtbl_ ptr
end type

type IDirectMusicTrack8Vtbl
	QueryInterface as function(byval as IDirectMusicTrack8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicTrack8 ptr) as ULONG
	Release as function(byval as IDirectMusicTrack8 ptr) as ULONG
	Init as function(byval as IDirectMusicTrack8 ptr, byval as IDirectMusicSegment ptr) as HRESULT
	InitPlay as function(byval as IDirectMusicTrack8 ptr, byval as IDirectMusicSegmentState ptr, byval as IDirectMusicPerformance ptr, byval as any ptr ptr, byval as DWORD, byval as DWORD) as HRESULT
	EndPlay as function(byval as IDirectMusicTrack8 ptr, byval as any ptr) as HRESULT
	Play as function(byval as IDirectMusicTrack8 ptr, byval as any ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as DWORD, byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegmentState ptr, byval as DWORD) as HRESULT
	GetParam as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr, byval as MUSIC_TIME, byval as MUSIC_TIME ptr, byval as any ptr) as HRESULT
	SetParam as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr, byval as MUSIC_TIME, byval as any ptr) as HRESULT
	IsParamSupported as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr) as HRESULT
	AddNotificationType as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr) as HRESULT
	RemoveNotificationType as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr) as HRESULT
	Clone as function(byval as IDirectMusicTrack8 ptr, byval as MUSIC_TIME, byval as MUSIC_TIME, byval as IDirectMusicTrack ptr ptr) as HRESULT
	PlayEx as function(byval as IDirectMusicTrack8 ptr, byval as any ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as DWORD, byval as IDirectMusicPerformance ptr, byval as IDirectMusicSegmentState ptr, byval as DWORD) as HRESULT
	GetParamEx as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME ptr, byval as any ptr, byval as any ptr, byval as DWORD) as HRESULT
	SetParamEx as function(byval as IDirectMusicTrack8 ptr, byval as GUID ptr, byval as REFERENCE_TIME, byval as any ptr, byval as any ptr, byval as DWORD) as HRESULT
	Compose as function(byval as IDirectMusicTrack8 ptr, byval as IUnknown ptr, byval as DWORD, byval as IDirectMusicTrack ptr ptr) as HRESULT
	Join as function(byval as IDirectMusicTrack8 ptr, byval as IDirectMusicTrack ptr, byval as MUSIC_TIME, byval as IUnknown ptr, byval as DWORD, byval as IDirectMusicTrack ptr ptr) as HRESULT
end type

extern CLSID_DirectMusicTempoTrack alias "CLSID_DirectMusicTempoTrack" as GUID
extern CLSID_DirectMusicSeqTrack alias "CLSID_DirectMusicSeqTrack" as GUID
extern CLSID_DirectMusicSysExTrack alias "CLSID_DirectMusicSysExTrack" as GUID
extern CLSID_DirectMusicTimeSigTrack alias "CLSID_DirectMusicTimeSigTrack" as GUID
extern CLSID_DirectMusicChordTrack alias "CLSID_DirectMusicChordTrack" as GUID
extern CLSID_DirectMusicCommandTrack alias "CLSID_DirectMusicCommandTrack" as GUID
extern CLSID_DirectMusicStyleTrack alias "CLSID_DirectMusicStyleTrack" as GUID
extern CLSID_DirectMusicMotifTrack alias "CLSID_DirectMusicMotifTrack" as GUID
extern CLSID_DirectMusicSignPostTrack alias "CLSID_DirectMusicSignPostTrack" as GUID
extern CLSID_DirectMusicBandTrack alias "CLSID_DirectMusicBandTrack" as GUID
extern CLSID_DirectMusicChordMapTrack alias "CLSID_DirectMusicChordMapTrack" as GUID
extern CLSID_DirectMusicMuteTrack alias "CLSID_DirectMusicMuteTrack" as GUID
extern CLSID_DirectMusicScriptTrack alias "CLSID_DirectMusicScriptTrack" as GUID
extern CLSID_DirectMusicMarkerTrack alias "CLSID_DirectMusicMarkerTrack" as GUID
extern CLSID_DirectMusicSegmentTriggerTrack alias "CLSID_DirectMusicSegmentTriggerTrack" as GUID
extern CLSID_DirectMusicLyricsTrack alias "CLSID_DirectMusicLyricsTrack" as GUID
extern CLSID_DirectMusicParamControlTrack alias "CLSID_DirectMusicParamControlTrack" as GUID
extern CLSID_DirectMusicWaveTrack alias "CLSID_DirectMusicWaveTrack" as GUID
extern IID_IDirectMusicTrack alias "IID_IDirectMusicTrack" as GUID
extern IID_IDirectMusicTool alias "IID_IDirectMusicTool" as GUID
extern IID_IDirectMusicTool8 alias "IID_IDirectMusicTool8" as GUID
extern IID_IDirectMusicTrack8 alias "IID_IDirectMusicTrack8" as GUID

#endif
