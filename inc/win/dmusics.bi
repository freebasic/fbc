'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DirectMusic Software Synth Definitions
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

#include once "dmusicc.bi"

extern "Windows"

#define __WINE_DMUSIC_SOFTWARESYNTH_H
#define REGSTR_PATH_SOFTWARESYNTHS !"Software\\Microsoft\\DirectMusic\\SoftwareSynths"
extern IID_IDirectMusicSynth as const GUID
extern IID_IDirectMusicSynth8 as const GUID
extern IID_IDirectMusicSynthSink as const GUID

type LPDIRECTMUSICSYNTH as IDirectMusicSynth ptr
type LPDIRECTMUSICSYNTH8 as IDirectMusicSynth8 ptr
type IDirectMusicSynthSink as IDirectMusicSynthSink_
type LPDIRECTMUSICSYNTHSINK as IDirectMusicSynthSink ptr
extern GUID_DMUS_PROP_SetSynthSink as const GUID
extern GUID_DMUS_PROP_SinkUsesDSound as const GUID
const REFRESH_F_LASTBUFFER = &h1
#define _DMUS_VOICE_STATE_DEFINED
type DMUS_VOICE_STATE as _DMUS_VOICE_STATE
type LPDMUS_VOICE_STATE as _DMUS_VOICE_STATE ptr

type _DMUS_VOICE_STATE
	bExists as WINBOOL
	spPosition as SAMPLE_POSITION
end type

type IDirectMusicSynthVtbl as IDirectMusicSynthVtbl_

type IDirectMusicSynth
	lpVtbl as IDirectMusicSynthVtbl ptr
end type

type IDirectMusicSynthVtbl_
	QueryInterface as function(byval This as IDirectMusicSynth ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSynth ptr) as ULONG
	Release as function(byval This as IDirectMusicSynth ptr) as ULONG
	Open as function(byval This as IDirectMusicSynth ptr, byval pPortParams as LPDMUS_PORTPARAMS) as HRESULT
	Close as function(byval This as IDirectMusicSynth ptr) as HRESULT
	SetNumChannelGroups as function(byval This as IDirectMusicSynth ptr, byval dwGroups as DWORD) as HRESULT
	Download as function(byval This as IDirectMusicSynth ptr, byval phDownload as LPHANDLE, byval pvData as LPVOID, byval pbFree as LPBOOL) as HRESULT
	Unload as function(byval This as IDirectMusicSynth ptr, byval hDownload as HANDLE, byval lpFreeHandle as function(byval as HANDLE, byval as HANDLE) as HRESULT, byval hUserData as HANDLE) as HRESULT
	PlayBuffer as function(byval This as IDirectMusicSynth ptr, byval rt as REFERENCE_TIME, byval pbBuffer as LPBYTE, byval cbBuffer as DWORD) as HRESULT
	GetRunningStats as function(byval This as IDirectMusicSynth ptr, byval pStats as LPDMUS_SYNTHSTATS) as HRESULT
	GetPortCaps as function(byval This as IDirectMusicSynth ptr, byval pCaps as LPDMUS_PORTCAPS) as HRESULT
	SetMasterClock as function(byval This as IDirectMusicSynth ptr, byval pClock as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval This as IDirectMusicSynth ptr, byval ppClock as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval This as IDirectMusicSynth ptr, byval fEnable as WINBOOL) as HRESULT
	SetSynthSink as function(byval This as IDirectMusicSynth ptr, byval pSynthSink as IDirectMusicSynthSink ptr) as HRESULT
	Render as function(byval This as IDirectMusicSynth ptr, byval pBuffer as short ptr, byval dwLength as DWORD, byval llPosition as LONGLONG) as HRESULT
	SetChannelPriority as function(byval This as IDirectMusicSynth ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval dwPriority as DWORD) as HRESULT
	GetChannelPriority as function(byval This as IDirectMusicSynth ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval pdwPriority as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectMusicSynth ptr, byval pWaveFormatEx as LPWAVEFORMATEX, byval pdwWaveFormatExSiz as LPDWORD) as HRESULT
	GetAppend as function(byval This as IDirectMusicSynth ptr, byval pdwAppend as DWORD ptr) as HRESULT
end type

#define IDirectMusicSynth_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSynth_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSynth_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSynth_Open(p, a) (p)->lpVtbl->Open(p, a)
#define IDirectMusicSynth_Close(p) (p)->lpVtbl->Close(p)
#define IDirectMusicSynth_SetNumChannelGroups(p, a) (p)->lpVtbl->SetNumChannelGroups(p, a)
#define IDirectMusicSynth_Download(p, a, b, c) (p)->lpVtbl->Download(p, a, b, c)
#define IDirectMusicSynth_Unload(p, a, b, c) (p)->lpVtbl->Unload(p, a, b, c)
#define IDirectMusicSynth_PlayBuffer(p, a, b, c) (p)->lpVtbl->PlayBuffer(p, a, b, c)
#define IDirectMusicSynth_GetRunningStats(p, a) (p)->lpVtbl->GetRunningStats(p, a)
#define IDirectMusicSynth_GetPortCaps(p, a) (p)->lpVtbl->GetPortCaps(p, a)
#define IDirectMusicSynth_SetMasterClock(p, a) (p)->lpVtbl->SetMasterClock(p, a)
#define IDirectMusicSynth_GetLatencyClock(p, a) (p)->lpVtbl->GetLatencyClock(p, a)
#define IDirectMusicSynth_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusicSynth_SetSynthSink(p, a) (p)->lpVtbl->SetSynthSink(p, a)
#define IDirectMusicSynth_Render(p, a, b, c) (p)->lpVtbl->Render(p, a, b, c)
#define IDirectMusicSynth_SetChannelPriority(p, a, b, c) (p)->lpVtbl->SetChannelPriority(p, a, b, c)
#define IDirectMusicSynth_GetChannelPriority(p, a, b, c) (p)->lpVtbl->GetChannelPriority(p, a, b, c)
#define IDirectMusicSynth_GetFormat(p, a, b) (p)->lpVtbl->GetFormat(p, a, b)
#define IDirectMusicSynth_GetAppend(p, a) (p)->lpVtbl->GetAppend(p, a)
type IDirectMusicSynth8Vtbl as IDirectMusicSynth8Vtbl_

type IDirectMusicSynth8
	lpVtbl as IDirectMusicSynth8Vtbl ptr
end type

type IDirectMusicSynth8Vtbl_
	QueryInterface as function(byval This as IDirectMusicSynth8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSynth8 ptr) as ULONG
	Release as function(byval This as IDirectMusicSynth8 ptr) as ULONG
	Open as function(byval This as IDirectMusicSynth8 ptr, byval pPortParams as LPDMUS_PORTPARAMS) as HRESULT
	Close as function(byval This as IDirectMusicSynth8 ptr) as HRESULT
	SetNumChannelGroups as function(byval This as IDirectMusicSynth8 ptr, byval dwGroups as DWORD) as HRESULT
	Download as function(byval This as IDirectMusicSynth8 ptr, byval phDownload as LPHANDLE, byval pvData as LPVOID, byval pbFree as LPBOOL) as HRESULT
	Unload as function(byval This as IDirectMusicSynth8 ptr, byval hDownload as HANDLE, byval lpFreeHandle as function(byval as HANDLE, byval as HANDLE) as HRESULT, byval hUserData as HANDLE) as HRESULT
	PlayBuffer as function(byval This as IDirectMusicSynth8 ptr, byval rt as REFERENCE_TIME, byval pbBuffer as LPBYTE, byval cbBuffer as DWORD) as HRESULT
	GetRunningStats as function(byval This as IDirectMusicSynth8 ptr, byval pStats as LPDMUS_SYNTHSTATS) as HRESULT
	GetPortCaps as function(byval This as IDirectMusicSynth8 ptr, byval pCaps as LPDMUS_PORTCAPS) as HRESULT
	SetMasterClock as function(byval This as IDirectMusicSynth8 ptr, byval pClock as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval This as IDirectMusicSynth8 ptr, byval ppClock as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval This as IDirectMusicSynth8 ptr, byval fEnable as WINBOOL) as HRESULT
	SetSynthSink as function(byval This as IDirectMusicSynth8 ptr, byval pSynthSink as IDirectMusicSynthSink ptr) as HRESULT
	Render as function(byval This as IDirectMusicSynth8 ptr, byval pBuffer as short ptr, byval dwLength as DWORD, byval llPosition as LONGLONG) as HRESULT
	SetChannelPriority as function(byval This as IDirectMusicSynth8 ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval dwPriority as DWORD) as HRESULT
	GetChannelPriority as function(byval This as IDirectMusicSynth8 ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval pdwPriority as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectMusicSynth8 ptr, byval pWaveFormatEx as LPWAVEFORMATEX, byval pdwWaveFormatExSiz as LPDWORD) as HRESULT
	GetAppend as function(byval This as IDirectMusicSynth8 ptr, byval pdwAppend as DWORD ptr) as HRESULT
	PlayVoice as function(byval This as IDirectMusicSynth8 ptr, byval rt as REFERENCE_TIME, byval dwVoiceId as DWORD, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval dwDLId as DWORD, byval prPitch as LONG, byval vrVolume as LONG, byval stVoiceStart as SAMPLE_TIME, byval stLoopStart as SAMPLE_TIME, byval stLoopEnd as SAMPLE_TIME) as HRESULT
	StopVoice as function(byval This as IDirectMusicSynth8 ptr, byval rt as REFERENCE_TIME, byval dwVoiceId as DWORD) as HRESULT
	GetVoiceState as function(byval This as IDirectMusicSynth8 ptr, byval dwVoice as DWORD ptr, byval cbVoice as DWORD, byval dwVoiceState as DMUS_VOICE_STATE ptr) as HRESULT
	Refresh as function(byval This as IDirectMusicSynth8 ptr, byval dwDownloadID as DWORD, byval dwFlags as DWORD) as HRESULT
	AssignChannelToBuses as function(byval This as IDirectMusicSynth8 ptr, byval dwChannelGroup as DWORD, byval dwChannel as DWORD, byval pdwBuses as LPDWORD, byval cBuses as DWORD) as HRESULT
end type

#define IDirectMusicSynth8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSynth8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSynth8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSynth8_Open(p, a) (p)->lpVtbl->Open(p, a)
#define IDirectMusicSynth8_Close(p) (p)->lpVtbl->Close(p)
#define IDirectMusicSynth8_SetNumChannelGroups(p, a) (p)->lpVtbl->SetNumChannelGroups(p, a)
#define IDirectMusicSynth8_Download(p, a, b, c) (p)->lpVtbl->Download(p, a, b, c)
#define IDirectMusicSynth8_Unload(p, a, b, c) (p)->lpVtbl->Unload(p, a, b, c)
#define IDirectMusicSynth8_PlayBuffer(p, a, b, c) (p)->lpVtbl->PlayBuffer(p, a, b, c)
#define IDirectMusicSynth8_GetRunningStats(p, a) (p)->lpVtbl->GetRunningStats(p, a)
#define IDirectMusicSynth8_GetPortCaps(p, a) (p)->lpVtbl->GetPortCaps(p, a)
#define IDirectMusicSynth8_SetMasterClock(p, a) (p)->lpVtbl->SetMasterClock(p, a)
#define IDirectMusicSynth8_GetLatencyClock(p, a) (p)->lpVtbl->GetLatencyClock(p, a)
#define IDirectMusicSynth8_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusicSynth8_SetSynthSink(p, a) (p)->lpVtbl->SetSynthSink(p, a)
#define IDirectMusicSynth8_Render(p, a, b, c) (p)->lpVtbl->Render(p, a, b, c)
#define IDirectMusicSynth8_SetChannelPriority(p, a, b, c) (p)->lpVtbl->SetChannelPriority(p, a, b, c)
#define IDirectMusicSynth8_GetChannelPriority(p, a, b, c) (p)->lpVtbl->GetChannelPriority(p, a, b, c)
#define IDirectMusicSynth8_GetFormat(p, a, b) (p)->lpVtbl->GetFormat(p, a, b)
#define IDirectMusicSynth8_GetAppend(p, a) (p)->lpVtbl->GetAppend(p, a)
#define IDirectMusicSynth8_PlayVoice(p, a, b, c, d, e, f, g, h, i, j) (p)->lpVtbl->PlayVoice(p, a, b, c, d, e, f, g, h, i, j)
#define IDirectMusicSynth8_StopVoice(p, a, b) (p)->lpVtbl->StopVoice(p, a, b)
#define IDirectMusicSynth8_GetVoiceState(p, a, b, c) (p)->lpVtbl->GetVoiceState(p, a, b, c)
#define IDirectMusicSynth8_Refresh(p, a, b) (p)->lpVtbl->Refresh(p, a, b)
#define IDirectMusicSynth8_AssignChannelToBuses(p, a, b, c, d) (p)->lpVtbl->AssignChannelToBuses(p, a, b, c, d)
type IDirectMusicSynthSinkVtbl as IDirectMusicSynthSinkVtbl_

type IDirectMusicSynthSink_
	lpVtbl as IDirectMusicSynthSinkVtbl ptr
end type

type IDirectMusicSynthSinkVtbl_
	QueryInterface as function(byval This as IDirectMusicSynthSink ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectMusicSynthSink ptr) as ULONG
	Release as function(byval This as IDirectMusicSynthSink ptr) as ULONG
	Init as function(byval This as IDirectMusicSynthSink ptr, byval pSynth as IDirectMusicSynth ptr) as HRESULT
	SetMasterClock as function(byval This as IDirectMusicSynthSink ptr, byval pClock as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval This as IDirectMusicSynthSink ptr, byval ppClock as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval This as IDirectMusicSynthSink ptr, byval fEnable as WINBOOL) as HRESULT
	SampleToRefTime as function(byval This as IDirectMusicSynthSink ptr, byval llSampleTime as LONGLONG, byval prfTime as REFERENCE_TIME ptr) as HRESULT
	RefTimeToSample as function(byval This as IDirectMusicSynthSink ptr, byval rfTime as REFERENCE_TIME, byval pllSampleTime as LONGLONG ptr) as HRESULT
	SetDirectSound as function(byval This as IDirectMusicSynthSink ptr, byval pDirectSound as LPDIRECTSOUND, byval pDirectSoundBuffer as LPDIRECTSOUNDBUFFER) as HRESULT
	GetDesiredBufferSize as function(byval This as IDirectMusicSynthSink ptr, byval pdwBufferSizeInSamples as LPDWORD) as HRESULT
end type

#define IDirectMusicSynthSink_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectMusicSynthSink_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectMusicSynthSink_Release(p) (p)->lpVtbl->Release(p)
#define IDirectMusicSynthSink_Init(p, a) (p)->lpVtbl->Init(p, a)
#define IDirectMusicSynthSink_SetMasterClock(p, a) (p)->lpVtbl->SetMasterClock(p, a)
#define IDirectMusicSynthSink_GetLatencyClock(p, a) (p)->lpVtbl->GetLatencyClock(p, a)
#define IDirectMusicSynthSink_Activate(p, a) (p)->lpVtbl->Activate(p, a)
#define IDirectMusicSynthSink_SampleToRefTime(p, a, b) (p)->lpVtbl->SampleToRefTime(p, a, b)
#define IDirectMusicSynthSink_RefTimeToSample(p, a, b) (p)->lpVtbl->RefTimeToSample(p, a, b)
#define IDirectMusicSynthSink_SetDirectSound(p, a, b) (p)->lpVtbl->SetDirectSound(p, a, b)
#define IDirectMusicSynthSink_GetDesiredBufferSize(p, a) (p)->lpVtbl->GetDesiredBufferSize(p, a)

end extern
