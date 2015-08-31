'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic Core API Stuff
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
#include once "dls1.bi"
#include once "dmerror.bi"
#include once "dmdls.bi"
#include once "dsound.bi"
#include once "dmusbuff.bi"

extern "Windows"

#define __WINE_DMUSIC_CORE_H
extern CLSID_DirectMusic as const GUID
extern CLSID_DirectMusicCollection as const GUID
extern CLSID_DirectMusicSynth as const GUID
extern IID_IDirectMusic as const GUID
extern IID_IDirectMusic2 as const GUID
extern IID_IDirectMusic8 as const GUID
extern IID_IDirectMusicBuffer as const GUID
extern IID_IDirectMusicCollection as const GUID
extern IID_IDirectMusicDownload as const GUID
extern IID_IDirectMusicDownloadedInstrument as const GUID
extern IID_IDirectMusicInstrument as const GUID
extern IID_IDirectMusicPort as const GUID
extern IID_IDirectMusicPortDownload as const GUID
extern IID_IDirectMusicThru as const GUID
extern IID_IDirectMusicCollection8 alias "IID_IDirectMusicCollection" as const GUID
extern IID_IDirectMusicDownload8 alias "IID_IDirectMusicDownload" as const GUID
extern IID_IDirectMusicDownloadedInstrument8 alias "IID_IDirectMusicDownloadedInstrument" as const GUID
extern IID_IDirectMusicInstrument8 alias "IID_IDirectMusicInstrument" as const GUID
extern IID_IDirectMusicPort8 alias "IID_IDirectMusicPort" as const GUID
extern IID_IDirectMusicPortDownload8 alias "IID_IDirectMusicPortDownload" as const GUID
extern IID_IDirectMusicThru8 alias "IID_IDirectMusicThru" as const GUID
extern GUID_DMUS_PROP_GM_Hardware as const GUID
extern GUID_DMUS_PROP_GS_Capable as const GUID
extern GUID_DMUS_PROP_GS_Hardware as const GUID
extern GUID_DMUS_PROP_DLS1 as const GUID
extern GUID_DMUS_PROP_DLS2 as const GUID
extern GUID_DMUS_PROP_Effects as const GUID
extern GUID_DMUS_PROP_INSTRUMENT2 as const GUID
extern GUID_DMUS_PROP_LegacyCaps as const GUID
extern GUID_DMUS_PROP_MemorySize as const GUID
extern GUID_DMUS_PROP_SampleMemorySize as const GUID
extern GUID_DMUS_PROP_SamplePlaybackRate as const GUID
extern GUID_DMUS_PROP_SynthSink_DSOUND as const GUID
extern GUID_DMUS_PROP_SynthSink_WAVE as const GUID
extern GUID_DMUS_PROP_Volume as const GUID
extern GUID_DMUS_PROP_WavesReverb as const GUID
extern GUID_DMUS_PROP_WriteLatency as const GUID
extern GUID_DMUS_PROP_WritePeriod as const GUID
extern GUID_DMUS_PROP_XG_Capable as const GUID
extern GUID_DMUS_PROP_XG_Hardware as const GUID

type LPDIRECTMUSIC as IDirectMusic ptr
type LPDIRECTMUSIC8 as IDirectMusic8 ptr
type LPDIRECTMUSICBUFFER as IDirectMusicBuffer ptr
type IDirectMusicBuffer8 as IDirectMusicBuffer
type LPDIRECTMUSICBUFFER8 as IDirectMusicBuffer ptr
type LPDIRECTMUSICINSTRUMENT as IDirectMusicInstrument ptr
type IDirectMusicInstrument8 as IDirectMusicInstrument
type LPDIRECTMUSICINSTRUMENT8 as IDirectMusicInstrument ptr
type LPDIRECTMUSICDOWNLOADEDINSTRUMENT as IDirectMusicDownloadedInstrument ptr
type IDirectMusicDownloadedInstrument8 as IDirectMusicDownloadedInstrument
type LPDIRECTMUSICDOWNLOADEDINSTRUMENT8 as IDirectMusicDownloadedInstrument ptr
type LPDIRECTMUSICCOLLECTION as IDirectMusicCollection ptr
type IDirectMusicCollection8 as IDirectMusicCollection
type LPDIRECTMUSICCOLLECTION8 as IDirectMusicCollection ptr
type LPDIRECTMUSICDOWNLOAD as IDirectMusicDownload ptr
type IDirectMusicDownload8 as IDirectMusicDownload
type LPDIRECTMUSICDOWNLOAD8 as IDirectMusicDownload ptr
type LPDIRECTMUSICPORTDOWNLOAD as IDirectMusicPortDownload ptr
type IDirectMusicPortDownload8 as IDirectMusicPortDownload
type LPDIRECTMUSICPORTDOWNLOAD8 as IDirectMusicPortDownload ptr
type LPDIRECTMUSICPORT as IDirectMusicPort ptr
type IDirectMusicPort8 as IDirectMusicPort
type LPDIRECTMUSICPORT8 as IDirectMusicPort ptr
type LPDIRECTMUSICTHRU as IDirectMusicThru ptr
type IDirectMusicThru8 as IDirectMusicThru
type LPDIRECTMUSICTHRU8 as IDirectMusicThru ptr
type LPREFERENCECLOCK as IReferenceClock ptr
type SAMPLE_TIME as ULONGLONG
type LPSAMPLE_TIME as ULONGLONG ptr
type SAMPLE_POSITION as ULONGLONG
type LPSAMPLE_POSITION as ULONGLONG ptr

#define _DIRECTAUDIO_PRIORITIES_DEFINED_
const DAUD_CRITICAL_VOICE_PRIORITY = &hF0000000
const DAUD_HIGH_VOICE_PRIORITY = &hC0000000
const DAUD_STANDARD_VOICE_PRIORITY = &h80000000
const DAUD_LOW_VOICE_PRIORITY = &h40000000
const DAUD_PERSIST_VOICE_PRIORITY = &h10000000
const DAUD_CHAN1_VOICE_PRIORITY_OFFSET = &h0000000E
const DAUD_CHAN2_VOICE_PRIORITY_OFFSET = &h0000000D
const DAUD_CHAN3_VOICE_PRIORITY_OFFSET = &h0000000C
const DAUD_CHAN4_VOICE_PRIORITY_OFFSET = &h0000000B
const DAUD_CHAN5_VOICE_PRIORITY_OFFSET = &h0000000A
const DAUD_CHAN6_VOICE_PRIORITY_OFFSET = &h00000009
const DAUD_CHAN7_VOICE_PRIORITY_OFFSET = &h00000008
const DAUD_CHAN8_VOICE_PRIORITY_OFFSET = &h00000007
const DAUD_CHAN9_VOICE_PRIORITY_OFFSET = &h00000006
const DAUD_CHAN10_VOICE_PRIORITY_OFFSET = &h0000000F
const DAUD_CHAN11_VOICE_PRIORITY_OFFSET = &h00000005
const DAUD_CHAN12_VOICE_PRIORITY_OFFSET = &h00000004
const DAUD_CHAN13_VOICE_PRIORITY_OFFSET = &h00000003
const DAUD_CHAN14_VOICE_PRIORITY_OFFSET = &h00000002
const DAUD_CHAN15_VOICE_PRIORITY_OFFSET = &h00000001
const DAUD_CHAN16_VOICE_PRIORITY_OFFSET = &h00000000
const DAUD_CHAN1_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN1_VOICE_PRIORITY_OFFSET
const DAUD_CHAN2_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN2_VOICE_PRIORITY_OFFSET
const DAUD_CHAN3_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN3_VOICE_PRIORITY_OFFSET
const DAUD_CHAN4_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN4_VOICE_PRIORITY_OFFSET
const DAUD_CHAN5_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN5_VOICE_PRIORITY_OFFSET
const DAUD_CHAN6_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN6_VOICE_PRIORITY_OFFSET
const DAUD_CHAN7_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN7_VOICE_PRIORITY_OFFSET
const DAUD_CHAN8_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN8_VOICE_PRIORITY_OFFSET
const DAUD_CHAN9_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN9_VOICE_PRIORITY_OFFSET
const DAUD_CHAN10_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN10_VOICE_PRIORITY_OFFSET
const DAUD_CHAN11_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN11_VOICE_PRIORITY_OFFSET
const DAUD_CHAN12_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN12_VOICE_PRIORITY_OFFSET
const DAUD_CHAN13_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN13_VOICE_PRIORITY_OFFSET
const DAUD_CHAN14_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN14_VOICE_PRIORITY_OFFSET
const DAUD_CHAN15_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN15_VOICE_PRIORITY_OFFSET
const DAUD_CHAN16_DEF_VOICE_PRIORITY = DAUD_STANDARD_VOICE_PRIORITY or DAUD_CHAN16_VOICE_PRIORITY_OFFSET
const DMUS_CLOCKF_GLOBAL = &h1
const DMUS_EFFECT_NONE = &h0
const DMUS_EFFECT_REVERB = &h1
const DMUS_EFFECT_CHORUS = &h2
const DMUS_EFFECT_DELAY = &h4
const DMUS_MAX_DESCRIPTION = &h80
const DMUS_MAX_DRIVER = &h80
const DMUS_PC_INPUTCLASS = &h0
const DMUS_PC_OUTPUTCLASS = &h1
const DMUS_PC_DLS = &h00000001
const DMUS_PC_EXTERNAL = &h00000002
const DMUS_PC_SOFTWARESYNTH = &h00000004
const DMUS_PC_MEMORYSIZEFIXED = &h00000008
const DMUS_PC_GMINHARDWARE = &h00000010
const DMUS_PC_GSINHARDWARE = &h00000020
const DMUS_PC_XGINHARDWARE = &h00000040
const DMUS_PC_DIRECTSOUND = &h00000080
const DMUS_PC_SHAREABLE = &h00000100
const DMUS_PC_DLS2 = &h00000200
const DMUS_PC_AUDIOPATH = &h00000400
const DMUS_PC_WAVE = &h00000800
const DMUS_PC_SYSTEMMEMORY = &h7FFFFFFF
const DMUS_PORT_WINMM_DRIVER = &h0
const DMUS_PORT_USER_MODE_SYNTH = &h1
const DMUS_PORT_KERNEL_MODE = &h2
const DMUS_PORT_FEATURE_AUDIOPATH = &h1
const DMUS_PORT_FEATURE_STREAMING = &h2
const DMUS_PORTPARAMS_VOICES = &h01
const DMUS_PORTPARAMS_CHANNELGROUPS = &h02
const DMUS_PORTPARAMS_AUDIOCHANNELS = &h04
const DMUS_PORTPARAMS_SAMPLERATE = &h08
const DMUS_PORTPARAMS_EFFECTS = &h20
const DMUS_PORTPARAMS_SHARE = &h40
const DMUS_PORTPARAMS_FEATURES = &h80
const DMUS_VOLUME_MAX = 2000
const DMUS_VOLUME_MIN = -20000
const DMUS_SYNTHSTATS_VOICES = &h01
const DMUS_SYNTHSTATS_TOTAL_CPU = &h02
const DMUS_SYNTHSTATS_CPU_PER_VOICE = &h04
const DMUS_SYNTHSTATS_LOST_NOTES = &h08
const DMUS_SYNTHSTATS_PEAK_VOLUME = &h10
const DMUS_SYNTHSTATS_FREE_MEMORY = &h20
const DMUS_SYNTHSTATS_SYSTEMMEMORY = DMUS_PC_SYSTEMMEMORY
const DSBUSID_FIRST_SPKR_LOC = &h00000000
const DSBUSID_FRONT_LEFT = &h00000000
const DSBUSID_LEFT = &h00000000
const DSBUSID_FRONT_RIGHT = &h00000001
const DSBUSID_RIGHT = &h00000001
const DSBUSID_FRONT_CENTER = &h00000002
const DSBUSID_LOW_FREQUENCY = &h00000003
const DSBUSID_BACK_LEFT = &h00000004
const DSBUSID_BACK_RIGHT = &h00000005
const DSBUSID_FRONT_LEFT_OF_CENTER = &h00000006
const DSBUSID_FRONT_RIGHT_OF_CENTER = &h00000007
const DSBUSID_BACK_CENTER = &h00000008
const DSBUSID_SIDE_LEFT = &h00000009
const DSBUSID_SIDE_RIGHT = &h0000000A
const DSBUSID_TOP_CENTER = &h0000000B
const DSBUSID_TOP_FRONT_LEFT = &h0000000C
const DSBUSID_TOP_FRONT_CENTER = &h0000000D
const DSBUSID_TOP_FRONT_RIGHT = &h0000000E
const DSBUSID_TOP_BACK_LEFT = &h0000000F
const DSBUSID_TOP_BACK_CENTER = &h00000010
const DSBUSID_TOP_BACK_RIGHT = &h011
const DSBUSID_LAST_SPKR_LOC = &h00000011
#define DSBUSID_IS_SPKR_LOC(id) (((id) >= DSBUSID_FIRST_SPKR_LOC) andalso ((id) <= DSBUSID_LAST_SPKR_LOC))
const DSBUSID_REVERB_SEND = &h00000040
const DSBUSID_CHORUS_SEND = &h00000041
const DSBUSID_DYNAMIC_0 = &h00000200
const DSBUSID_NULL = &hFFFFFFFF

type DMUS_CLOCKTYPE as long
enum
	DMUS_CLOCK_SYSTEM = &h0
	DMUS_CLOCK_WAVE = &h1
end enum

type DMUS_BUFFERDESC as _DMUS_BUFFERDESC
type LPDMUS_BUFFERDESC as _DMUS_BUFFERDESC ptr
type DMUS_PORTCAPS as _DMUS_PORTCAPS
type LPDMUS_PORTCAPS as _DMUS_PORTCAPS ptr
type DMUS_PORTPARAMS7 as _DMUS_PORTPARAMS
type LPDMUS_PORTPARAMS7 as _DMUS_PORTPARAMS ptr
type DMUS_PORTPARAMS8 as _DMUS_PORTPARAMS8
type LPDMUS_PORTPARAMS8 as _DMUS_PORTPARAMS8 ptr
type DMUS_PORTPARAMS as DMUS_PORTPARAMS8
type LPDMUS_PORTPARAMS as DMUS_PORTPARAMS8 ptr
type DMUS_SYNTHSTATS as _DMUS_SYNTHSTATS
type LPDMUS_SYNTHSTATS as _DMUS_SYNTHSTATS ptr
type DMUS_SYNTHSTATS8 as _DMUS_SYNTHSTATS8
type LPDMUS_SYNTHSTATS8 as _DMUS_SYNTHSTATS8 ptr
type DMUS_WAVES_REVERB_PARAMS as _DMUS_WAVES_REVERB_PARAMS
type LPDMUS_WAVES_REVERB_PARAMS as _DMUS_WAVES_REVERB_PARAMS ptr
type DMUS_CLOCKINFO7 as _DMUS_CLOCKINFO7
type LPDMUS_CLOCKINFO7 as _DMUS_CLOCKINFO7 ptr
type DMUS_CLOCKINFO8 as _DMUS_CLOCKINFO8
type LPDMUS_CLOCKINFO8 as _DMUS_CLOCKINFO8 ptr
type DMUS_CLOCKINFO as DMUS_CLOCKINFO8
type LPDMUS_CLOCKINFO as DMUS_CLOCKINFO8 ptr

type _DMUS_BUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidBufferFormat as GUID
	cbBuffer as DWORD
end type

type _DMUS_PORTCAPS
	dwSize as DWORD
	dwFlags as DWORD
	guidPort as GUID
	dwClass as DWORD
	dwType as DWORD
	dwMemorySize as DWORD
	dwMaxChannelGroups as DWORD
	dwMaxVoices as DWORD
	dwMaxAudioChannels as DWORD
	dwEffectFlags as DWORD
	wszDescription as wstring * &h80
end type

type _DMUS_PORTPARAMS
	dwSize as DWORD
	dwValidParams as DWORD
	dwVoices as DWORD
	dwChannelGroups as DWORD
	dwAudioChannels as DWORD
	dwSampleRate as DWORD
	dwEffectFlags as DWORD
	fShare as WINBOOL
end type

type _DMUS_PORTPARAMS8
	dwSize as DWORD
	dwValidParams as DWORD
	dwVoices as DWORD
	dwChannelGroups as DWORD
	dwAudioChannels as DWORD
	dwSampleRate as DWORD
	dwEffectFlags as DWORD
	fShare as WINBOOL
	dwFeatures as DWORD
end type

type _DMUS_SYNTHSTATS
	dwSize as DWORD
	dwValidStats as DWORD
	dwVoices as DWORD
	dwTotalCPU as DWORD
	dwCPUPerVoice as DWORD
	dwLostNotes as DWORD
	dwFreeMemory as DWORD
	lPeakVolume as LONG
end type

type _DMUS_SYNTHSTATS8
	dwSize as DWORD
	dwValidStats as DWORD
	dwVoices as DWORD
	dwTotalCPU as DWORD
	dwCPUPerVoice as DWORD
	dwLostNotes as DWORD
	dwFreeMemory as DWORD
	lPeakVolume as LONG
	dwSynthMemUse as DWORD
end type

type _DMUS_WAVES_REVERB_PARAMS
	fInGain as single
	fReverbMix as single
	fReverbTime as single
	fHighFreqRTRatio as single
end type

type _DMUS_CLOCKINFO7
	dwSize as DWORD
	ctType as DMUS_CLOCKTYPE
	guidClock as GUID
	wszDescription as wstring * &h80
end type

type _DMUS_CLOCKINFO8
	dwSize as DWORD
	ctType as DMUS_CLOCKTYPE
	guidClock as GUID
	wszDescription as wstring * &h80
	dwFlags as DWORD
end type

type IDirectMusicVtbl as IDirectMusicVtbl_

type IDirectMusic
	lpVtbl as IDirectMusicVtbl ptr
end type

type IDirectMusicVtbl_
	QueryInterface as function(byval This as IDirectMusic ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusic ptr) as ULONG
	Release as function(byval This as IDirectMusic ptr) as ULONG
	EnumPort as function(byval This as IDirectMusic ptr, byval dwIndex as DWORD, byval pPortCaps as LPDMUS_PORTCAPS) as HRESULT
	CreateMusicBuffer as function(byval This as IDirectMusic ptr, byval pBufferDesc as LPDMUS_BUFFERDESC, byval ppBuffer as LPDIRECTMUSICBUFFER ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
	CreatePort as function(byval This as IDirectMusic ptr, byval rclsidPort as const IID const ptr, byval pPortParams as LPDMUS_PORTPARAMS, byval ppPort as LPDIRECTMUSICPORT ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
	EnumMasterClock as function(byval This as IDirectMusic ptr, byval dwIndex as DWORD, byval lpClockInfo as LPDMUS_CLOCKINFO) as HRESULT
	GetMasterClock as function(byval This as IDirectMusic ptr, byval pguidClock as LPGUID, byval ppReferenceClock as IReferenceClock ptr ptr) as HRESULT
	SetMasterClock as function(byval This as IDirectMusic ptr, byval rguidClock as const GUID const ptr) as HRESULT
	Activate as function(byval This as IDirectMusic ptr, byval fEnable as WINBOOL) as HRESULT
	GetDefaultPort as function(byval This as IDirectMusic ptr, byval pguidPort as LPGUID) as HRESULT
	SetDirectSound as function(byval This as IDirectMusic ptr, byval pDirectSound as LPDIRECTSOUND, byval hWnd as HWND) as HRESULT
end type

#define IDirectMusic_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusic_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusic_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusic_EnumPort(p, a, b) (p)->lpVtbl->EnumPort(p, a, b)
#define IDirectMusic_CreateMusicBuffer(p, a, b, c) (p)->lpVtbl->CreateMusicBuffer(p, a, b, c)
#define IDirectMusic_CreatePort(p, a, b, c, d) (p)->lpVtbl->CreatePort(p, a, b, c, d)
#define IDirectMusic_EnumMasterClock(p, a, b) (p)->lpVtbl->EnumMasterClock(p, a, b)
#define IDirectMusic_GetMasterClock(p, a, b) (p)->lpVtbl->GetMasterClock(p, a, b)
#define IDirectMusic_SetMasterClock(p, a) (p)->lpVtbl->SetMasterClock(p, a)
#define IDirectMusic_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusic_GetDefaultPort(p, a) (p)->lpVtbl->GetDefaultPort(p, a)
#define IDirectMusic_SetDirectSound(p, a, b) (p)->lpVtbl->SetDirectSound(p, a, b)
type IDirectMusic8Vtbl as IDirectMusic8Vtbl_

type IDirectMusic8
	lpVtbl as IDirectMusic8Vtbl ptr
end type

type IDirectMusic8Vtbl_
	QueryInterface as function(byval This as IDirectMusic8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusic8 ptr) as ULONG
	Release as function(byval This as IDirectMusic8 ptr) as ULONG
	EnumPort as function(byval This as IDirectMusic8 ptr, byval dwIndex as DWORD, byval pPortCaps as LPDMUS_PORTCAPS) as HRESULT
	CreateMusicBuffer as function(byval This as IDirectMusic8 ptr, byval pBufferDesc as LPDMUS_BUFFERDESC, byval ppBuffer as LPDIRECTMUSICBUFFER ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
	CreatePort as function(byval This as IDirectMusic8 ptr, byval rclsidPort as const IID const ptr, byval pPortParams as LPDMUS_PORTPARAMS, byval ppPort as LPDIRECTMUSICPORT ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
	EnumMasterClock as function(byval This as IDirectMusic8 ptr, byval dwIndex as DWORD, byval lpClockInfo as LPDMUS_CLOCKINFO) as HRESULT
	GetMasterClock as function(byval This as IDirectMusic8 ptr, byval pguidClock as LPGUID, byval ppReferenceClock as IReferenceClock ptr ptr) as HRESULT
	SetMasterClock as function(byval This as IDirectMusic8 ptr, byval rguidClock as const GUID const ptr) as HRESULT
	Activate as function(byval This as IDirectMusic8 ptr, byval fEnable as WINBOOL) as HRESULT
	GetDefaultPort as function(byval This as IDirectMusic8 ptr, byval pguidPort as LPGUID) as HRESULT
	SetDirectSound as function(byval This as IDirectMusic8 ptr, byval pDirectSound as LPDIRECTSOUND, byval hWnd as HWND) as HRESULT
	SetExternalMasterClock as function(byval This as IDirectMusic8 ptr, byval pClock as IReferenceClock ptr) as HRESULT
end type

#define IDirectMusic8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusic8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusic8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusic8_EnumPort(p, a, b) (p)->lpVtbl->EnumPort(p, a, b)
#define IDirectMusic8_CreateMusicBuffer(p, a, b, c) (p)->lpVtbl->CreateMusicBuffer(p, a, b, c)
#define IDirectMusic8_CreatePort(p, a, b, c, d) (p)->lpVtbl->CreatePort(p, a, b, c, d)
#define IDirectMusic8_EnumMasterClock(p, a, b) (p)->lpVtbl->EnumMasterClock(p, a, b)
#define IDirectMusic8_GetMasterClock(p, a, b) (p)->lpVtbl->GetMasterClock(p, a, b)
#define IDirectMusic8_SetMasterClock(p, a) (p)->lpVtbl->SetMasterClock(p, a)
#define IDirectMusic8_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusic8_GetDefaultPort(p, a) (p)->lpVtbl->GetDefaultPort(p, a)
#define IDirectMusic8_SetDirectSound(p, a, b) (p)->lpVtbl->SetDirectSound(p, a, b)
#define IDirectMusic8_SetExternalMasterClock(p, a) (p)->lpVtbl->SetExternalMasterClock(p, a)
type IDirectMusicBufferVtbl as IDirectMusicBufferVtbl_

type IDirectMusicBuffer
	lpVtbl as IDirectMusicBufferVtbl ptr
end type

type IDirectMusicBufferVtbl_
	QueryInterface as function(byval This as IDirectMusicBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicBuffer ptr) as ULONG
	Release as function(byval This as IDirectMusicBuffer ptr) as ULONG
	Flush as function(byval This as IDirectMusicBuffer ptr) as HRESULT
	TotalTime as function(byval This as IDirectMusicBuffer ptr, byval prtTime as LPREFERENCE_TIME) as HRESULT
	PackStructured as function(byval This as IDirectMusicBuffer ptr, byval rt as REFERENCE_TIME, byval dwChannelGroup as DWORD, byval dwChannelMessage as DWORD) as HRESULT
	PackUnstructured as function(byval This as IDirectMusicBuffer ptr, byval rt as REFERENCE_TIME, byval dwChannelGroup as DWORD, byval cb as DWORD, byval lpb as LPBYTE) as HRESULT
	ResetReadPtr as function(byval This as IDirectMusicBuffer ptr) as HRESULT
	GetNextEvent as function(byval This as IDirectMusicBuffer ptr, byval prt as LPREFERENCE_TIME, byval pdwChannelGroup as LPDWORD, byval pdwLength as LPDWORD, byval ppData as LPBYTE ptr) as HRESULT
	GetRawBufferPtr as function(byval This as IDirectMusicBuffer ptr, byval ppData as LPBYTE ptr) as HRESULT
	GetStartTime as function(byval This as IDirectMusicBuffer ptr, byval prt as LPREFERENCE_TIME) as HRESULT
	GetUsedBytes as function(byval This as IDirectMusicBuffer ptr, byval pcb as LPDWORD) as HRESULT
	GetMaxBytes as function(byval This as IDirectMusicBuffer ptr, byval pcb as LPDWORD) as HRESULT
	GetBufferFormat as function(byval This as IDirectMusicBuffer ptr, byval pGuidFormat as LPGUID) as HRESULT
	SetStartTime as function(byval This as IDirectMusicBuffer ptr, byval rt as REFERENCE_TIME) as HRESULT
	SetUsedBytes as function(byval This as IDirectMusicBuffer ptr, byval cb as DWORD) as HRESULT
end type

#define IDirectMusicBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicBuffer_Flush(p) (p)->lpVtbl->Flush(p)
#define IDirectMusicBuffer_TotalTime(p, a) (p)->lpVtbl->TotalTime(p, a)
#define IDirectMusicBuffer_PackStructured(p, a, b, c) (p)->lpVtbl->PackStructured(p, a, b, c)
#define IDirectMusicBuffer_PackUnstructured(p, a, b, c, d) (p)->lpVtbl->PackUnstructured(p, a, b, c, d)
#define IDirectMusicBuffer_ResetReadPtr(p) (p)->lpVtbl->ResetReadPtr(p)
#define IDirectMusicBuffer_GetNextEvent(p, a, b, c, d) (p)->lpVtbl->GetNextEvent(p, a, b, c, d)
#define IDirectMusicBuffer_GetRawBufferPtr(p, a) (p)->lpVtbl->GetRawBufferPtr(p, a)
#define IDirectMusicBuffer_GetStartTime(p, a) (p)->lpVtbl->GetStartTime(p, a)
#define IDirectMusicBuffer_GetUsedBytes(p, a) (p)->lpVtbl->GetUsedBytes(p, a)
#define IDirectMusicBuffer_GetMaxBytes(p, a) (p)->lpVtbl->GetMaxBytes(p, a)
#define IDirectMusicBuffer_GetBufferFormat(p, a) (p)->lpVtbl->GetBufferFormat(p, a)
#define IDirectMusicBuffer_SetStartTime(p, a) (p)->lpVtbl->SetStartTime(p, a)
#define IDirectMusicBuffer_SetUsedBytes(p, a) (p)->lpVtbl->SetUsedBytes(p, a)
type IDirectMusicInstrumentVtbl as IDirectMusicInstrumentVtbl_

type IDirectMusicInstrument
	lpVtbl as IDirectMusicInstrumentVtbl ptr
end type

type IDirectMusicInstrumentVtbl_
	QueryInterface as function(byval This as IDirectMusicInstrument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicInstrument ptr) as ULONG
	Release as function(byval This as IDirectMusicInstrument ptr) as ULONG
	GetPatch as function(byval This as IDirectMusicInstrument ptr, byval pdwPatch as DWORD ptr) as HRESULT
	SetPatch as function(byval This as IDirectMusicInstrument ptr, byval dwPatch as DWORD) as HRESULT
end type

#define IDirectMusicInstrument_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicInstrument_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicInstrument_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicInstrument_GetPatch(p, a) (p)->lpVtbl->GetPatch(p, a)
#define IDirectMusicInstrument_SetPatch(p, a) (p)->lpVtbl->SetPatch(p, a)
type IDirectMusicDownloadedInstrumentVtbl as IDirectMusicDownloadedInstrumentVtbl_

type IDirectMusicDownloadedInstrument
	lpVtbl as IDirectMusicDownloadedInstrumentVtbl ptr
end type

type IDirectMusicDownloadedInstrumentVtbl_
	QueryInterface as function(byval This as IDirectMusicDownloadedInstrument ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicDownloadedInstrument ptr) as ULONG
	Release as function(byval This as IDirectMusicDownloadedInstrument ptr) as ULONG
end type

#define IDirectMusicDownloadedInstrument_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicDownloadedInstrument_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicDownloadedInstrument_Release(p) (p)->lpVtbl->Release(p)
type IDirectMusicCollectionVtbl as IDirectMusicCollectionVtbl_

type IDirectMusicCollection
	lpVtbl as IDirectMusicCollectionVtbl ptr
end type

type IDirectMusicCollectionVtbl_
	QueryInterface as function(byval This as IDirectMusicCollection ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicCollection ptr) as ULONG
	Release as function(byval This as IDirectMusicCollection ptr) as ULONG
	GetInstrument as function(byval This as IDirectMusicCollection ptr, byval dwPatch as DWORD, byval ppInstrument as IDirectMusicInstrument ptr ptr) as HRESULT
	EnumInstrument as function(byval This as IDirectMusicCollection ptr, byval dwIndex as DWORD, byval pdwPatch as DWORD ptr, byval pwszName as LPWSTR, byval dwNameLen as DWORD) as HRESULT
end type

#define IDirectMusicCollection_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicCollection_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicCollection_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicCollection_GetInstrument(p, a, b) (p)->lpVtbl->GetInstrument(p, a, b)
#define IDirectMusicCollection_EnumInstrument(p, a, b, c, d) (p)->lpVtbl->EnumInstrument(p, a, b, c, d)
type IDirectMusicDownloadVtbl as IDirectMusicDownloadVtbl_

type IDirectMusicDownload
	lpVtbl as IDirectMusicDownloadVtbl ptr
end type

type IDirectMusicDownloadVtbl_
	QueryInterface as function(byval This as IDirectMusicDownload ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicDownload ptr) as ULONG
	Release as function(byval This as IDirectMusicDownload ptr) as ULONG
	GetBuffer as function(byval This as IDirectMusicDownload ptr, byval ppvBuffer as any ptr ptr, byval pdwSize as DWORD ptr) as HRESULT
end type

#define IDirectMusicDownload_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicDownload_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicDownload_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicDownload_GetBuffer(p, a, b) (p)->lpVtbl->GetBuffer(p, a, b)
type IDirectMusicPortDownloadVtbl as IDirectMusicPortDownloadVtbl_

type IDirectMusicPortDownload
	lpVtbl as IDirectMusicPortDownloadVtbl ptr
end type

type IDirectMusicPortDownloadVtbl_
	QueryInterface as function(byval This as IDirectMusicPortDownload ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicPortDownload ptr) as ULONG
	Release as function(byval This as IDirectMusicPortDownload ptr) as ULONG
	GetBuffer as function(byval This as IDirectMusicPortDownload ptr, byval dwDLId as DWORD, byval ppIDMDownload as IDirectMusicDownload ptr ptr) as HRESULT
	AllocateBuffer as function(byval This as IDirectMusicPortDownload ptr, byval dwSize as DWORD, byval ppIDMDownload as IDirectMusicDownload ptr ptr) as HRESULT
	GetDLId as function(byval This as IDirectMusicPortDownload ptr, byval pdwStartDLId as DWORD ptr, byval dwCount as DWORD) as HRESULT
	GetAppend as function(byval This as IDirectMusicPortDownload ptr, byval pdwAppend as DWORD ptr) as HRESULT
	Download as function(byval This as IDirectMusicPortDownload ptr, byval pIDMDownload as IDirectMusicDownload ptr) as HRESULT
	Unload as function(byval This as IDirectMusicPortDownload ptr, byval pIDMDownload as IDirectMusicDownload ptr) as HRESULT
end type

#define IDirectMusicPortDownload_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicPortDownload_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicPortDownload_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPortDownload_GetBuffer(p, a, b) (p)->lpVtbl->GetBuffer(p, a, b)
#define IDirectMusicPortDownload_AllocateBuffer(p, a, b) (p)->lpVtbl->AllocateBuffer(p, a, b)
#define IDirectMusicPortDownload_GetDLId(p, a, b) (p)->lpVtbl->GetDLId(p, a, b)
#define IDirectMusicPortDownload_GetAppend(p, a) (p)->lpVtbl->GetAppend(p, a)
#define IDirectMusicPortDownload_Download(p, a) (p)->lpVtbl->Download(p, a)
#define IDirectMusicPortDownload_Unload(p, a) (p)->lpVtbl->GetBuffer(p, a)
type IDirectMusicPortVtbl as IDirectMusicPortVtbl_

type IDirectMusicPort
	lpVtbl as IDirectMusicPortVtbl ptr
end type

type IDirectMusicPortVtbl_
	QueryInterface as function(byval This as IDirectMusicPort ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicPort ptr) as ULONG
	Release as function(byval This as IDirectMusicPort ptr) as ULONG
	PlayBuffer as function(byval This as IDirectMusicPort ptr, byval pBuffer as LPDIRECTMUSICBUFFER) as HRESULT
	SetReadNotificationHandle as function(byval This as IDirectMusicPort ptr, byval hEvent as HANDLE) as HRESULT
	Read as function(byval This as IDirectMusicPort ptr, byval pBuffer as LPDIRECTMUSICBUFFER) as HRESULT
	DownloadInstrument as function(byval This as IDirectMusicPort ptr, byval pInstrument as IDirectMusicInstrument ptr, byval ppDownloadedInstrument as IDirectMusicDownloadedInstrument ptr ptr, byval pNoteRanges as DMUS_NOTERANGE ptr, byval dwNumNoteRanges as DWORD) as HRESULT
	UnloadInstrument as function(byval This as IDirectMusicPort ptr, byval pDownloadedInstrument as IDirectMusicDownloadedInstrument ptr) as HRESULT
	GetLatencyClock as function(byval This as IDirectMusicPort ptr, byval ppClock as IReferenceClock ptr ptr) as HRESULT
	GetRunningStats as function(byval This as IDirectMusicPort ptr, byval pStats as LPDMUS_SYNTHSTATS) as HRESULT
	Compact as function(byval This as IDirectMusicPort ptr) as HRESULT
	GetCaps as function(byval This as IDirectMusicPort ptr, byval pPortCaps as LPDMUS_PORTCAPS) as HRESULT
	DeviceIoControl as function(byval This as IDirectMusicPort ptr, byval dwIoControlCode as DWORD, byval lpInBuffer as LPVOID, byval nInBufferSize as DWORD, byval lpOutBuffer as LPVOID, byval nOutBufferSize as DWORD, byval lpBytesReturned as LPDWORD, byval lpOverlapped as LPOVERLAPPED) as HRESULT
	SetNumChannelGroups as function(byval This as IDirectMusicPort ptr, byval dwChannelGroups as DWORD) as HRESULT
	GetNumChannelGroups as function(byval This as IDirectMusicPort ptr, byval pdwChannelGroups as LPDWORD) as HRESULT
	Activate as function(byval This as IDirectMusicPort ptr, byval fActive as WINBOOL) as HRESULT
	SetChannelPriority as function(byval This as IDirectMusicPort ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval dwPriority as DWORD) as HRESULT
	GetChannelPriority as function(byval This as IDirectMusicPort ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval pdwPriority as LPDWORD) as HRESULT
	SetDirectSound as function(byval This as IDirectMusicPort ptr, byval pDirectSound as LPDIRECTSOUND, byval pDirectSoundBuffer as LPDIRECTSOUNDBUFFER) as HRESULT
	GetFormat as function(byval This as IDirectMusicPort ptr, byval pWaveFormatEx as LPWAVEFORMATEX, byval pdwWaveFormatExSize as LPDWORD, byval pdwBufferSize as LPDWORD) as HRESULT
end type

#define IDirectMusicPort_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicPort_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicPort_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicPort_PlayBuffer(p, a) (p)->lpVtbl->PlayBuffer(p, a)
#define IDirectMusicPort_SetReadNotificationHandle(p, a) (p)->lpVtbl->SetReadNotificationHandle(p, a)
#define IDirectMusicPort_Read(p, a) (p)->lpVtbl->Read(p, a)
#define IDirectMusicPort_DownloadInstrument(p, a, b, c, d) (p)->lpVtbl->DownloadInstrument(p, a, b, c, d)
#define IDirectMusicPort_UnloadInstrument(p, a) (p)->lpVtbl->UnloadInstrument(p, a)
#define IDirectMusicPort_GetLatencyClock(p, a) (p)->lpVtbl->GetLatencyClock(p, a)
#define IDirectMusicPort_GetRunningStats(p, a) (p)->lpVtbl->GetRunningStats(p, a)
#define IDirectMusicPort_Compact(p) (p)->lpVtbl->Compact(p)
#define IDirectMusicPort_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectMusicPort_DeviceIoControl(p, a, b, c, d, e, f, g) (p)->lpVtbl->DeviceIoControl(p, a, b, c, d, e, f, g)
#define IDirectMusicPort_SetNumChannelGroups(p, a) (p)->lpVtbl->SetNumChannelGroups(p, a)
#define IDirectMusicPort_GetNumChannelGroups(p, a) (p)->lpVtbl->GetNumChannelGroups(p, a)
#define IDirectMusicPort_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusicPort_SetChannelPriority(p, a, b, c) (p)->lpVtbl->SetChannelPriority(p, a, b, c)
#define IDirectMusicPort_GetChannelPriority(p, a, b, c) (p)->lpVtbl->GetChannelPriority(p, a, b, c)
#define IDirectMusicPort_SetDirectSound(p, a, b) (p)->lpVtbl->SetDirectSound(p, a, b)
#define IDirectMusicPort_GetFormat(p, a, b, c) (p)->lpVtbl->GetFormat(p, a, b, c)
type IDirectMusicThruVtbl as IDirectMusicThruVtbl_

type IDirectMusicThru
	lpVtbl as IDirectMusicThruVtbl ptr
end type

type IDirectMusicThruVtbl_
	QueryInterface as function(byval This as IDirectMusicThru ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicThru ptr) as ULONG
	Release as function(byval This as IDirectMusicThru ptr) as ULONG
	ThruChannel as function(byval This as IDirectMusicThru ptr, byval dwSourceChannelGroup as DWORD, byval dwSourceChannel as DWORD, byval dwDestinationChannelGroup as DWORD, byval dwDestinationChannel as DWORD, byval pDestinationPort as LPDIRECTMUSICPORT) as HRESULT
end type

#define IDirectMusicThru_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicThru_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicThru_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicThru_ThruChannel(p, a, b, c, d, e) (p)->lpVtbl->ThruChannel(p, a, b, c, d, e)

end extern
