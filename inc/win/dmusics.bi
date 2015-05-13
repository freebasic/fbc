''
''
'' dmusics -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmusics_bi__
#define __win_dmusics_bi__

#include once "win/dmusicc.bi"

#define REGSTR_PATH_SOFTWARESYNTHS $"Software\Microsoft\DirectMusic\SoftwareSynths"

type DMUS_VOICE_STATE
	bExists as BOOL
	spPosition as SAMPLE_POSITION
end type

#define REFRESH_F_LASTBUFFER &h00000001

type IDirectMusicSynthVtbl_ as IDirectMusicSynthVtbl

type IDirectMusicSynth
	lpVtbl as IDirectMusicSynthVtbl_ ptr
end type

type IDirectMusicSynthSink_ as IDirectMusicSynthSink

type IDirectMusicSynthVtbl
	QueryInterface as function(byval as IDirectMusicSynth ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSynth ptr) as ULONG
	Release as function(byval as IDirectMusicSynth ptr) as ULONG
	Open as function(byval as IDirectMusicSynth ptr, byval as LPDMUS_PORTPARAMS) as HRESULT
	Close as function(byval as IDirectMusicSynth ptr) as HRESULT
	SetNumChannelGroups as function(byval as IDirectMusicSynth ptr, byval as DWORD) as HRESULT
	Download as function(byval as IDirectMusicSynth ptr, byval as LPHANDLE, byval as LPVOID, byval as LPBOOL) as HRESULT
	Unload as function(byval as IDirectMusicSynth ptr, byval as HANDLE, byval as function(byval as HANDLE, byval as HANDLE) as HRESULT, byval as HANDLE) as HRESULT
	PlayBuffer as function(byval as IDirectMusicSynth ptr, byval as REFERENCE_TIME, byval as LPBYTE, byval as DWORD) as HRESULT
	GetRunningStats as function(byval as IDirectMusicSynth ptr, byval as LPDMUS_SYNTHSTATS) as HRESULT
	GetPortCaps as function(byval as IDirectMusicSynth ptr, byval as LPDMUS_PORTCAPS) as HRESULT
	SetMasterClock as function(byval as IDirectMusicSynth ptr, byval as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval as IDirectMusicSynth ptr, byval as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval as IDirectMusicSynth ptr, byval as BOOL) as HRESULT
	SetSynthSink as function(byval as IDirectMusicSynth ptr, byval as IDirectMusicSynthSink_ ptr) as HRESULT
	Render as function(byval as IDirectMusicSynth ptr, byval as short ptr, byval as DWORD, byval as LONGLONG) as HRESULT
	SetChannelPriority as function(byval as IDirectMusicSynth ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	GetChannelPriority as function(byval as IDirectMusicSynth ptr, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	GetFormat as function(byval as IDirectMusicSynth ptr, byval as LPWAVEFORMATEX, byval as LPDWORD) as HRESULT
	GetAppend as function(byval as IDirectMusicSynth ptr, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicSynth8Vtbl_ as IDirectMusicSynth8Vtbl

type IDirectMusicSynth8
	lpVtbl as IDirectMusicSynth8Vtbl_ ptr
end type

type IDirectMusicSynth8Vtbl
	QueryInterface as function(byval as IDirectMusicSynth8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSynth8 ptr) as ULONG
	Release as function(byval as IDirectMusicSynth8 ptr) as ULONG
	Open as function(byval as IDirectMusicSynth8 ptr, byval as LPDMUS_PORTPARAMS) as HRESULT
	Close as function(byval as IDirectMusicSynth8 ptr) as HRESULT
	SetNumChannelGroups as function(byval as IDirectMusicSynth8 ptr, byval as DWORD) as HRESULT
	Download as function(byval as IDirectMusicSynth8 ptr, byval as LPHANDLE, byval as LPVOID, byval as LPBOOL) as HRESULT
	Unload as function(byval as IDirectMusicSynth8 ptr, byval as HANDLE, byval as function(byval as HANDLE, byval as HANDLE) as HRESULT, byval as HANDLE) as HRESULT
	PlayBuffer as function(byval as IDirectMusicSynth8 ptr, byval as REFERENCE_TIME, byval as LPBYTE, byval as DWORD) as HRESULT
	GetRunningStats as function(byval as IDirectMusicSynth8 ptr, byval as LPDMUS_SYNTHSTATS) as HRESULT
	GetPortCaps as function(byval as IDirectMusicSynth8 ptr, byval as LPDMUS_PORTCAPS) as HRESULT
	SetMasterClock as function(byval as IDirectMusicSynth8 ptr, byval as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval as IDirectMusicSynth8 ptr, byval as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval as IDirectMusicSynth8 ptr, byval as BOOL) as HRESULT
	SetSynthSink as function(byval as IDirectMusicSynth8 ptr, byval as IDirectMusicSynthSink_ ptr) as HRESULT
	Render as function(byval as IDirectMusicSynth8 ptr, byval as short ptr, byval as DWORD, byval as LONGLONG) as HRESULT
	SetChannelPriority as function(byval as IDirectMusicSynth8 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	GetChannelPriority as function(byval as IDirectMusicSynth8 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	GetFormat as function(byval as IDirectMusicSynth8 ptr, byval as LPWAVEFORMATEX, byval as LPDWORD) as HRESULT
	GetAppend as function(byval as IDirectMusicSynth8 ptr, byval as DWORD ptr) as HRESULT
	PlayVoice as function(byval as IDirectMusicSynth8 ptr, byval as REFERENCE_TIME, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as integer, byval as integer, byval as SAMPLE_TIME, byval as SAMPLE_TIME, byval as SAMPLE_TIME) as HRESULT
	StopVoice as function(byval as IDirectMusicSynth8 ptr, byval as REFERENCE_TIME, byval as DWORD) as HRESULT
	GetVoiceState as function(byval as IDirectMusicSynth8 ptr, byval as DWORD ptr, byval as DWORD, byval as DMUS_VOICE_STATE ptr) as HRESULT
	Refresh as function(byval as IDirectMusicSynth8 ptr, byval as DWORD, byval as DWORD) as HRESULT
	AssignChannelToBuses as function(byval as IDirectMusicSynth8 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD, byval as DWORD) as HRESULT
end type

type IDirectMusicSynthSinkVtbl_ as IDirectMusicSynthSinkVtbl

type IDirectMusicSynthSink
	lpVtbl as IDirectMusicSynthSinkVtbl_ ptr
end type

type IDirectMusicSynthSinkVtbl
	QueryInterface as function(byval as IDirectMusicSynthSink ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicSynthSink ptr) as ULONG
	Release as function(byval as IDirectMusicSynthSink ptr) as ULONG
	Init as function(byval as IDirectMusicSynthSink ptr, byval as IDirectMusicSynth ptr) as HRESULT
	SetMasterClock as function(byval as IDirectMusicSynthSink ptr, byval as IReferenceClock ptr) as HRESULT
	GetLatencyClock as function(byval as IDirectMusicSynthSink ptr, byval as IReferenceClock ptr ptr) as HRESULT
	Activate as function(byval as IDirectMusicSynthSink ptr, byval as BOOL) as HRESULT
	SampleToRefTime as function(byval as IDirectMusicSynthSink ptr, byval as LONGLONG, byval as REFERENCE_TIME ptr) as HRESULT
	RefTimeToSample as function(byval as IDirectMusicSynthSink ptr, byval as REFERENCE_TIME, byval as LONGLONG ptr) as HRESULT
	SetDirectSound as function(byval as IDirectMusicSynthSink ptr, byval as LPDIRECTSOUND, byval as LPDIRECTSOUNDBUFFER) as HRESULT
	GetDesiredBufferSize as function(byval as IDirectMusicSynthSink ptr, byval as LPDWORD) as HRESULT
end type

extern IID_IDirectMusicSynth alias "IID_IDirectMusicSynth" as GUID
extern IID_IDirectMusicSynth8 alias "IID_IDirectMusicSynth8" as GUID
extern IID_IDirectMusicSynthSink alias "IID_IDirectMusicSynthSink" as GUID
extern GUID_DMUS_PROP_SetSynthSink alias "GUID_DMUS_PROP_SetSynthSink" as GUID
extern GUID_DMUS_PROP_SinkUsesDSound alias "GUID_DMUS_PROP_SinkUsesDSound" as GUID

#endif
