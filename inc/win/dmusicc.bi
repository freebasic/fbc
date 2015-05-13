''
''
'' dmusicc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dmusicc_bi__
#define __win_dmusicc_bi__

#inclib "dxguid"

#include once "windows.bi"
#include once "win/objbase.bi"
#include once "win/mmsystem.bi"
#include once "win/dls1.bi"
#include once "win/dmerror.bi"
#include once "win/dmdls.bi"
#include once "win/dsound.bi"
#include once "win/dmusbuff.bi"

type SAMPLE_TIME as ULONGLONG
type SAMPLE_POSITION as ULONGLONG
type LPSAMPLE_TIME as SAMPLE_TIME ptr

#define DMUS_MAX_DESCRIPTION 128
#define DMUS_MAX_DRIVER 128

type LPDMUS_BUFFERDESC as DMUS_BUFFERDESC ptr

type DMUS_BUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidBufferFormat as GUID
	cbBuffer as DWORD
end type

#define DMUS_EFFECT_NONE &h00000000
#define DMUS_EFFECT_REVERB &h00000001
#define DMUS_EFFECT_CHORUS &h00000002
#define DMUS_EFFECT_DELAY &h00000004
#define DMUS_PC_INPUTCLASS (0)
#define DMUS_PC_OUTPUTCLASS (1)
#define DMUS_PC_DLS (&h00000001)
#define DMUS_PC_EXTERNAL (&h00000002)
#define DMUS_PC_SOFTWARESYNTH (&h00000004)
#define DMUS_PC_MEMORYSIZEFIXED (&h00000008)
#define DMUS_PC_GMINHARDWARE (&h00000010)
#define DMUS_PC_GSINHARDWARE (&h00000020)
#define DMUS_PC_XGINHARDWARE (&h00000040)
#define DMUS_PC_DIRECTSOUND (&h00000080)
#define DMUS_PC_SHAREABLE (&h00000100)
#define DMUS_PC_DLS2 (&h00000200)
#define DMUS_PC_AUDIOPATH (&h00000400)
#define DMUS_PC_WAVE (&h00000800)
#define DMUS_PC_SYSTEMMEMORY (&h7FFFFFFF)

type DMUS_PORTCAPS
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
	wszDescription(0 to 128-1) as WCHAR
end type

type LPDMUS_PORTCAPS as DMUS_PORTCAPS ptr

#define DMUS_PORT_WINMM_DRIVER (0)
#define DMUS_PORT_USER_MODE_SYNTH (1)
#define DMUS_PORT_KERNEL_MODE (2)
#define DMUS_PORTPARAMS_VOICES &h00000001
#define DMUS_PORTPARAMS_CHANNELGROUPS &h00000002
#define DMUS_PORTPARAMS_AUDIOCHANNELS &h00000004
#define DMUS_PORTPARAMS_SAMPLERATE &h00000008
#define DMUS_PORTPARAMS_EFFECTS &h00000020
#define DMUS_PORTPARAMS_SHARE &h00000040
#define DMUS_PORTPARAMS_FEATURES &h00000080

type DMUS_PORTPARAMS7
	dwSize as DWORD
	dwValidParams as DWORD
	dwVoices as DWORD
	dwChannelGroups as DWORD
	dwAudioChannels as DWORD
	dwSampleRate as DWORD
	dwEffectFlags as DWORD
	fShare as BOOL
end type

type DMUS_PORTPARAMS8
	dwSize as DWORD
	dwValidParams as DWORD
	dwVoices as DWORD
	dwChannelGroups as DWORD
	dwAudioChannels as DWORD
	dwSampleRate as DWORD
	dwEffectFlags as DWORD
	fShare as BOOL
	dwFeatures as DWORD
end type

#define DMUS_PORT_FEATURE_AUDIOPATH &h00000001
#define DMUS_PORT_FEATURE_STREAMING &h00000002

type DMUS_PORTPARAMS as DMUS_PORTPARAMS8
type LPDMUS_PORTPARAMS as DMUS_PORTPARAMS ptr
type LPDMUS_SYNTHSTATS as DMUS_SYNTHSTATS ptr
type LPDMUS_SYNTHSTATS8 as DMUS_SYNTHSTATS8 ptr

type DMUS_SYNTHSTATS
	dwSize as DWORD
	dwValidStats as DWORD
	dwVoices as DWORD
	dwTotalCPU as DWORD
	dwCPUPerVoice as DWORD
	dwLostNotes as DWORD
	dwFreeMemory as DWORD
	lPeakVolume as integer
end type

type DMUS_SYNTHSTATS8
	dwSize as DWORD
	dwValidStats as DWORD
	dwVoices as DWORD
	dwTotalCPU as DWORD
	dwCPUPerVoice as DWORD
	dwLostNotes as DWORD
	dwFreeMemory as DWORD
	lPeakVolume as integer
	dwSynthMemUse as DWORD
end type

#define DMUS_SYNTHSTATS_VOICES (1 shl 0)
#define DMUS_SYNTHSTATS_TOTAL_CPU (1 shl 1)
#define DMUS_SYNTHSTATS_CPU_PER_VOICE (1 shl 2)
#define DMUS_SYNTHSTATS_LOST_NOTES (1 shl 3)
#define DMUS_SYNTHSTATS_PEAK_VOLUME (1 shl 4)
#define DMUS_SYNTHSTATS_FREE_MEMORY (1 shl 5)
#define DMUS_SYNTHSTATS_SYSTEMMEMORY (&h7FFFFFFF)

type DMUS_WAVES_REVERB_PARAMS
	fInGain as single
	fReverbMix as single
	fReverbTime as single
	fHighFreqRTRatio as single
end type

enum DMUS_CLOCKTYPE
	DMUS_CLOCK_SYSTEM = 0
	DMUS_CLOCK_WAVE = 1
end enum

#define DMUS_CLOCKF_GLOBAL &h00000001

type DMUS_CLOCKINFO7
	dwSize as DWORD
	ctType as DMUS_CLOCKTYPE
	guidClock as GUID
	wszDescription(0 to 128-1) as WCHAR
end type

type LPDMUS_CLOCKINFO7 as DMUS_CLOCKINFO7 ptr

type DMUS_CLOCKINFO8
	dwSize as DWORD
	ctType as DMUS_CLOCKTYPE
	guidClock as GUID
	wszDescription(0 to 128-1) as WCHAR
	dwFlags as DWORD
end type

type LPDMUS_CLOCKINFO8 as DMUS_CLOCKINFO8 ptr
type DMUS_CLOCKINFO as DMUS_CLOCKINFO8
type LPDMUS_CLOCKINFO as DMUS_CLOCKINFO ptr

#define DSBUSID_IS_SPKR_LOC(id) ( ((id) >= DSBUSID_FIRST_SPKR_LOC) and ((id) <= DSBUSID_LAST_SPKR_LOC) )

#define DSBUSID_FIRST_SPKR_LOC 0
#define DSBUSID_FRONT_LEFT 0
#define DSBUSID_LEFT 0
#define DSBUSID_FRONT_RIGHT 1
#define DSBUSID_RIGHT 1
#define DSBUSID_FRONT_CENTER 2
#define DSBUSID_LOW_FREQUENCY 3
#define DSBUSID_BACK_LEFT 4
#define DSBUSID_BACK_RIGHT 5
#define DSBUSID_FRONT_LEFT_OF_CENTER 6
#define DSBUSID_FRONT_RIGHT_OF_CENTER 7
#define DSBUSID_BACK_CENTER 8
#define DSBUSID_SIDE_LEFT 9
#define DSBUSID_SIDE_RIGHT 10
#define DSBUSID_TOP_CENTER 11
#define DSBUSID_TOP_FRONT_LEFT 12
#define DSBUSID_TOP_FRONT_CENTER 13
#define DSBUSID_TOP_FRONT_RIGHT 14
#define DSBUSID_TOP_BACK_LEFT 15
#define DSBUSID_TOP_BACK_CENTER 16
#define DSBUSID_TOP_BACK_RIGHT 17
#define DSBUSID_LAST_SPKR_LOC 17
#define DSBUSID_REVERB_SEND 64
#define DSBUSID_CHORUS_SEND 65
#define DSBUSID_DYNAMIC_0 512
#define DSBUSID_NULL &hFFFFFFFF

type LPDIRECTMUSIC as IDirectMusic ptr
type LPDIRECTMUSIC8 as IDirectMusic8 ptr
type LPDIRECTMUSICPORT as IDirectMusicPort ptr
type LPDIRECTMUSICBUFFER as IDirectMusicBuffer ptr

type IDirectMusicVtbl_ as IDirectMusicVtbl

type IDirectMusic
	lpVtbl as IDirectMusicVtbl_ ptr
end type

type IDirectMusicVtbl
	QueryInterface as function(byval as IDirectMusic ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusic ptr) as ULONG
	Release as function(byval as IDirectMusic ptr) as ULONG
	EnumPort as function(byval as IDirectMusic ptr, byval as DWORD, byval as LPDMUS_PORTCAPS) as HRESULT
	CreateMusicBuffer as function(byval as IDirectMusic ptr, byval as LPDMUS_BUFFERDESC, byval as LPDIRECTMUSICBUFFER ptr, byval as LPUNKNOWN) as HRESULT
	CreatePort as function(byval as IDirectMusic ptr, byval as CLSID ptr, byval as LPDMUS_PORTPARAMS, byval as LPDIRECTMUSICPORT ptr, byval as LPUNKNOWN) as HRESULT
	EnumMasterClock as function(byval as IDirectMusic ptr, byval as DWORD, byval as LPDMUS_CLOCKINFO) as HRESULT
	GetMasterClock as function(byval as IDirectMusic ptr, byval as LPGUID, byval as IReferenceClock ptr ptr) as HRESULT
	SetMasterClock as function(byval as IDirectMusic ptr, byval as GUID ptr) as HRESULT
	Activate as function(byval as IDirectMusic ptr, byval as BOOL) as HRESULT
	GetDefaultPort as function(byval as IDirectMusic ptr, byval as LPGUID) as HRESULT
	SetDirectSound as function(byval as IDirectMusic ptr, byval as LPDIRECTSOUND, byval as HWND) as HRESULT
end type

type IDirectMusic8Vtbl_ as IDirectMusic8Vtbl

type IDirectMusic8
	lpVtbl as IDirectMusic8Vtbl_ ptr
end type

type IDirectMusic8Vtbl
	QueryInterface as function(byval as IDirectMusic8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusic8 ptr) as ULONG
	Release as function(byval as IDirectMusic8 ptr) as ULONG
	EnumPort as function(byval as IDirectMusic8 ptr, byval as DWORD, byval as LPDMUS_PORTCAPS) as HRESULT
	CreateMusicBuffer as function(byval as IDirectMusic8 ptr, byval as LPDMUS_BUFFERDESC, byval as LPDIRECTMUSICBUFFER ptr, byval as LPUNKNOWN) as HRESULT
	CreatePort as function(byval as IDirectMusic8 ptr, byval as CLSID ptr, byval as LPDMUS_PORTPARAMS, byval as LPDIRECTMUSICPORT ptr, byval as LPUNKNOWN) as HRESULT
	EnumMasterClock as function(byval as IDirectMusic8 ptr, byval as DWORD, byval as LPDMUS_CLOCKINFO) as HRESULT
	GetMasterClock as function(byval as IDirectMusic8 ptr, byval as LPGUID, byval as IReferenceClock ptr ptr) as HRESULT
	SetMasterClock as function(byval as IDirectMusic8 ptr, byval as GUID ptr) as HRESULT
	Activate as function(byval as IDirectMusic8 ptr, byval as BOOL) as HRESULT
	GetDefaultPort as function(byval as IDirectMusic8 ptr, byval as LPGUID) as HRESULT
	SetDirectSound as function(byval as IDirectMusic8 ptr, byval as LPDIRECTSOUND, byval as HWND) as HRESULT
	SetExternalMasterClock as function(byval as IDirectMusic8 ptr, byval as IReferenceClock ptr) as HRESULT
end type

type IDirectMusicBufferVtbl_ as IDirectMusicBufferVtbl

type IDirectMusicBuffer
	lpVtbl as IDirectMusicBufferVtbl_ ptr
end type

type IDirectMusicBufferVtbl
	QueryInterface as function(byval as IDirectMusicBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicBuffer ptr) as ULONG
	Release as function(byval as IDirectMusicBuffer ptr) as ULONG
	Flush as function(byval as IDirectMusicBuffer ptr) as HRESULT
	TotalTime as function(byval as IDirectMusicBuffer ptr, byval as LPREFERENCE_TIME) as HRESULT
	PackStructured as function(byval as IDirectMusicBuffer ptr, byval as REFERENCE_TIME, byval as DWORD, byval as DWORD) as HRESULT
	PackUnstructured as function(byval as IDirectMusicBuffer ptr, byval as REFERENCE_TIME, byval as DWORD, byval as DWORD, byval as LPBYTE) as HRESULT
	ResetReadPtr as function(byval as IDirectMusicBuffer ptr) as HRESULT
	GetNextEvent as function(byval as IDirectMusicBuffer ptr, byval as LPREFERENCE_TIME, byval as LPDWORD, byval as LPDWORD, byval as LPBYTE ptr) as HRESULT
	GetRawBufferPtr as function(byval as IDirectMusicBuffer ptr, byval as LPBYTE ptr) as HRESULT
	GetStartTime as function(byval as IDirectMusicBuffer ptr, byval as LPREFERENCE_TIME) as HRESULT
	GetUsedBytes as function(byval as IDirectMusicBuffer ptr, byval as LPDWORD) as HRESULT
	GetMaxBytes as function(byval as IDirectMusicBuffer ptr, byval as LPDWORD) as HRESULT
	GetBufferFormat as function(byval as IDirectMusicBuffer ptr, byval as LPGUID) as HRESULT
	SetStartTime as function(byval as IDirectMusicBuffer ptr, byval as REFERENCE_TIME) as HRESULT
	SetUsedBytes as function(byval as IDirectMusicBuffer ptr, byval as DWORD) as HRESULT
end type

type IDirectMusicBuffer8 as IDirectMusicBuffer
type LPDIRECTMUSICBUFFER8 as IDirectMusicBuffer8 ptr

type IDirectMusicInstrumentVtbl_ as IDirectMusicInstrumentVtbl

type IDirectMusicInstrument
	lpVtbl as IDirectMusicInstrumentVtbl_ ptr
end type

type IDirectMusicInstrumentVtbl
	QueryInterface as function(byval as IDirectMusicInstrument ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicInstrument ptr) as ULONG
	Release as function(byval as IDirectMusicInstrument ptr) as ULONG
	GetPatch as function(byval as IDirectMusicInstrument ptr, byval as DWORD ptr) as HRESULT
	SetPatch as function(byval as IDirectMusicInstrument ptr, byval as DWORD) as HRESULT
end type

type IDirectMusicInstrument8 as IDirectMusicInstrument
type LPDIRECTMUSICINSTRUMENT8 as IDirectMusicInstrument8 ptr

type IDirectMusicDownloadedInstrumentVtbl_ as IDirectMusicDownloadedInstrumentVtbl

type IDirectMusicDownloadedInstrument
	lpVtbl as IDirectMusicDownloadedInstrumentVtbl_ ptr
end type

type IDirectMusicDownloadedInstrumentVtbl
	QueryInterface as function(byval as IDirectMusicDownloadedInstrument ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicDownloadedInstrument ptr) as ULONG
	Release as function(byval as IDirectMusicDownloadedInstrument ptr) as ULONG
end type

type IDirectMusicDownloadedInstrument8 as IDirectMusicDownloadedInstrument
type LPDIRECTMUSICDOWNLOADEDINSTRUMENT8 as IDirectMusicDownloadedInstrument8 ptr

type IDirectMusicCollectionVtbl_ as IDirectMusicCollectionVtbl

type IDirectMusicCollection
	lpVtbl as IDirectMusicCollectionVtbl_ ptr
end type

type IDirectMusicCollectionVtbl
	QueryInterface as function(byval as IDirectMusicCollection ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicCollection ptr) as ULONG
	Release as function(byval as IDirectMusicCollection ptr) as ULONG
	GetInstrument as function(byval as IDirectMusicCollection ptr, byval as DWORD, byval as IDirectMusicInstrument ptr ptr) as HRESULT
	EnumInstrument as function(byval as IDirectMusicCollection ptr, byval as DWORD, byval as DWORD ptr, byval as LPWSTR, byval as DWORD) as HRESULT
end type

type IDirectMusicCollection8 as IDirectMusicCollection
type LPDIRECTMUSICCOLLECTION8 as IDirectMusicCollection8 ptr

type IDirectMusicDownloadVtbl_ as IDirectMusicDownloadVtbl

type IDirectMusicDownload
	lpVtbl as IDirectMusicDownloadVtbl_ ptr
end type

type IDirectMusicDownloadVtbl
	QueryInterface as function(byval as IDirectMusicDownload ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicDownload ptr) as ULONG
	Release as function(byval as IDirectMusicDownload ptr) as ULONG
	GetBuffer as function(byval as IDirectMusicDownload ptr, byval as any ptr ptr, byval as DWORD ptr) as HRESULT
end type

type IDirectMusicDownload8 as IDirectMusicDownload
type LPDIRECTMUSICDOWNLOAD8 as IDirectMusicDownload8 ptr

type IDirectMusicPortDownloadVtbl_ as IDirectMusicPortDownloadVtbl

type IDirectMusicPortDownload
	lpVtbl as IDirectMusicPortDownloadVtbl_ ptr
end type

type IDirectMusicPortDownloadVtbl
	QueryInterface as function(byval as IDirectMusicPortDownload ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicPortDownload ptr) as ULONG
	Release as function(byval as IDirectMusicPortDownload ptr) as ULONG
	GetBuffer as function(byval as IDirectMusicPortDownload ptr, byval as DWORD, byval as IDirectMusicDownload ptr ptr) as HRESULT
	AllocateBuffer as function(byval as IDirectMusicPortDownload ptr, byval as DWORD, byval as IDirectMusicDownload ptr ptr) as HRESULT
	GetDLId as function(byval as IDirectMusicPortDownload ptr, byval as DWORD ptr, byval as DWORD) as HRESULT
	GetAppend as function(byval as IDirectMusicPortDownload ptr, byval as DWORD ptr) as HRESULT
	Download as function(byval as IDirectMusicPortDownload ptr, byval as IDirectMusicDownload ptr) as HRESULT
	Unload as function(byval as IDirectMusicPortDownload ptr, byval as IDirectMusicDownload ptr) as HRESULT
end type

type IDirectMusicPortDownload8 as IDirectMusicPortDownload
type LPDIRECTMUSICPORTDOWNLOAD8 as IDirectMusicPortDownload8 ptr

#define DAUD_CRITICAL_VOICE_PRIORITY (&hF0000000)
#define DAUD_HIGH_VOICE_PRIORITY (&hC0000000)
#define DAUD_STANDARD_VOICE_PRIORITY (&h80000000)
#define DAUD_LOW_VOICE_PRIORITY (&h40000000)
#define DAUD_PERSIST_VOICE_PRIORITY (&h10000000)
#define DAUD_CHAN1_VOICE_PRIORITY_OFFSET (&h0000000E)
#define DAUD_CHAN2_VOICE_PRIORITY_OFFSET (&h0000000D)
#define DAUD_CHAN3_VOICE_PRIORITY_OFFSET (&h0000000C)
#define DAUD_CHAN4_VOICE_PRIORITY_OFFSET (&h0000000B)
#define DAUD_CHAN5_VOICE_PRIORITY_OFFSET (&h0000000A)
#define DAUD_CHAN6_VOICE_PRIORITY_OFFSET (&h00000009)
#define DAUD_CHAN7_VOICE_PRIORITY_OFFSET (&h00000008)
#define DAUD_CHAN8_VOICE_PRIORITY_OFFSET (&h00000007)
#define DAUD_CHAN9_VOICE_PRIORITY_OFFSET (&h00000006)
#define DAUD_CHAN10_VOICE_PRIORITY_OFFSET (&h0000000F)
#define DAUD_CHAN11_VOICE_PRIORITY_OFFSET (&h00000005)
#define DAUD_CHAN12_VOICE_PRIORITY_OFFSET (&h00000004)
#define DAUD_CHAN13_VOICE_PRIORITY_OFFSET (&h00000003)
#define DAUD_CHAN14_VOICE_PRIORITY_OFFSET (&h00000002)
#define DAUD_CHAN15_VOICE_PRIORITY_OFFSET (&h00000001)
#define DAUD_CHAN16_VOICE_PRIORITY_OFFSET (&h00000000)
#define DAUD_CHAN1_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000E))
#define DAUD_CHAN2_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000D))
#define DAUD_CHAN3_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000C))
#define DAUD_CHAN4_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000B))
#define DAUD_CHAN5_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000A))
#define DAUD_CHAN6_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000009))
#define DAUD_CHAN7_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000008))
#define DAUD_CHAN8_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000007))
#define DAUD_CHAN9_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000006))
#define DAUD_CHAN10_DEF_VOICE_PRIORITY ((&h80000000) or (&h0000000F))
#define DAUD_CHAN11_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000005))
#define DAUD_CHAN12_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000004))
#define DAUD_CHAN13_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000003))
#define DAUD_CHAN14_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000002))
#define DAUD_CHAN15_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000001))
#define DAUD_CHAN16_DEF_VOICE_PRIORITY ((&h80000000) or (&h00000000))

type IDirectMusicPortVtbl_ as IDirectMusicPortVtbl

type IDirectMusicPort
	lpVtbl as IDirectMusicPortVtbl_ ptr
end type

type IDirectMusicPortVtbl
	QueryInterface as function(byval as IDirectMusicPort ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicPort ptr) as ULONG
	Release as function(byval as IDirectMusicPort ptr) as ULONG
	PlayBuffer as function(byval as IDirectMusicPort ptr, byval as LPDIRECTMUSICBUFFER) as HRESULT
	SetReadNotificationHandle as function(byval as IDirectMusicPort ptr, byval as HANDLE) as HRESULT
	Read as function(byval as IDirectMusicPort ptr, byval as LPDIRECTMUSICBUFFER) as HRESULT
	DownloadInstrument as function(byval as IDirectMusicPort ptr, byval as IDirectMusicInstrument ptr, byval as IDirectMusicDownloadedInstrument ptr ptr, byval as DMUS_NOTERANGE ptr, byval as DWORD) as HRESULT
	UnloadInstrument as function(byval as IDirectMusicPort ptr, byval as IDirectMusicDownloadedInstrument ptr) as HRESULT
	GetLatencyClock as function(byval as IDirectMusicPort ptr, byval as IReferenceClock ptr ptr) as HRESULT
	GetRunningStats as function(byval as IDirectMusicPort ptr, byval as LPDMUS_SYNTHSTATS) as HRESULT
	Compact as function(byval as IDirectMusicPort ptr) as HRESULT
	GetCaps as function(byval as IDirectMusicPort ptr, byval as LPDMUS_PORTCAPS) as HRESULT
	DeviceIoControl as function(byval as IDirectMusicPort ptr, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD, byval as LPDWORD, byval as LPOVERLAPPED) as HRESULT
	SetNumChannelGroups as function(byval as IDirectMusicPort ptr, byval as DWORD) as HRESULT
	GetNumChannelGroups as function(byval as IDirectMusicPort ptr, byval as LPDWORD) as HRESULT
	Activate as function(byval as IDirectMusicPort ptr, byval as BOOL) as HRESULT
	SetChannelPriority as function(byval as IDirectMusicPort ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	GetChannelPriority as function(byval as IDirectMusicPort ptr, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	SetDirectSound as function(byval as IDirectMusicPort ptr, byval as LPDIRECTSOUND, byval as LPDIRECTSOUNDBUFFER) as HRESULT
	GetFormat as function(byval as IDirectMusicPort ptr, byval as LPWAVEFORMATEX, byval as LPDWORD, byval as LPDWORD) as HRESULT
end type

type IDirectMusicPort8 as IDirectMusicPort
type LPDIRECTMUSICPORT8 as IDirectMusicPort8 ptr

type IDirectMusicThruVtbl_ as IDirectMusicThruVtbl

type IDirectMusicThru
	lpVtbl as IDirectMusicThruVtbl_ ptr
end type

type IDirectMusicThruVtbl
	QueryInterface as function(byval as IDirectMusicThru ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IDirectMusicThru ptr) as ULONG
	Release as function(byval as IDirectMusicThru ptr) as ULONG
	ThruChannel as function(byval as IDirectMusicThru ptr, byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD, byval as LPDIRECTMUSICPORT) as HRESULT
end type

type IDirectMusicThru8 as IDirectMusicThru
type LPDIRECTMUSICTHRU8 as IDirectMusicThru8 ptr

extern CLSID_DirectMusic alias "CLSID_DirectMusic" as GUID
extern CLSID_DirectMusicCollection alias "CLSID_DirectMusicCollection" as GUID
extern CLSID_DirectMusicSynth alias "CLSID_DirectMusicSynth" as GUID
extern IID_IDirectMusic alias "IID_IDirectMusic" as GUID
extern IID_IDirectMusicBuffer alias "IID_IDirectMusicBuffer" as GUID
extern IID_IDirectMusicPort alias "IID_IDirectMusicPort" as GUID
extern IID_IDirectMusicThru alias "IID_IDirectMusicThru" as GUID
extern IID_IDirectMusicPortDownload alias "IID_IDirectMusicPortDownload" as GUID
extern IID_IDirectMusicDownload alias "IID_IDirectMusicDownload" as GUID
extern IID_IDirectMusicCollection alias "IID_IDirectMusicCollection" as GUID
extern IID_IDirectMusicInstrument alias "IID_IDirectMusicInstrument" as GUID
extern IID_IDirectMusicDownloadedInstrument alias "IID_IDirectMusicDownloadedInstrument" as GUID
extern IID_IDirectMusic2 alias "IID_IDirectMusic2" as GUID
extern IID_IDirectMusic8 alias "IID_IDirectMusic8" as GUID
extern GUID_DMUS_PROP_GM_Hardware alias "GUID_DMUS_PROP_GM_Hardware" as GUID
extern GUID_DMUS_PROP_GS_Hardware alias "GUID_DMUS_PROP_GS_Hardware" as GUID
extern GUID_DMUS_PROP_XG_Hardware alias "GUID_DMUS_PROP_XG_Hardware" as GUID
extern GUID_DMUS_PROP_XG_Capable alias "GUID_DMUS_PROP_XG_Capable" as GUID
extern GUID_DMUS_PROP_GS_Capable alias "GUID_DMUS_PROP_GS_Capable" as GUID
extern GUID_DMUS_PROP_DLS1 alias "GUID_DMUS_PROP_DLS1" as GUID
extern GUID_DMUS_PROP_DLS2 alias "GUID_DMUS_PROP_DLS2" as GUID
extern GUID_DMUS_PROP_INSTRUMENT2 alias "GUID_DMUS_PROP_INSTRUMENT2" as GUID
extern GUID_DMUS_PROP_SynthSink_DSOUND alias "GUID_DMUS_PROP_SynthSink_DSOUND" as GUID
extern GUID_DMUS_PROP_SynthSink_WAVE alias "GUID_DMUS_PROP_SynthSink_WAVE" as GUID
extern GUID_DMUS_PROP_SampleMemorySize alias "GUID_DMUS_PROP_SampleMemorySize" as GUID
extern GUID_DMUS_PROP_SamplePlaybackRate alias "GUID_DMUS_PROP_SamplePlaybackRate" as GUID
extern GUID_DMUS_PROP_WriteLatency alias "GUID_DMUS_PROP_WriteLatency" as GUID
extern GUID_DMUS_PROP_WritePeriod alias "GUID_DMUS_PROP_WritePeriod" as GUID
extern GUID_DMUS_PROP_MemorySize alias "GUID_DMUS_PROP_MemorySize" as GUID
extern GUID_DMUS_PROP_WavesReverb alias "GUID_DMUS_PROP_WavesReverb" as GUID
extern GUID_DMUS_PROP_Effects alias "GUID_DMUS_PROP_Effects" as GUID
extern GUID_DMUS_PROP_LegacyCaps alias "GUID_DMUS_PROP_LegacyCaps" as GUID
extern GUID_DMUS_PROP_Volume alias "GUID_DMUS_PROP_Volume" as GUID

#define IID_IDirectMusicThru8 IID_IDirectMusicThru
#define IID_IDirectMusicPortDownload8 IID_IDirectMusicPortDownload
#define IID_IDirectMusicDownload8 IID_IDirectMusicDownload
#define IID_IDirectMusicCollection8 IID_IDirectMusicCollection
#define IID_IDirectMusicInstrument8 IID_IDirectMusicInstrument
#define IID_IDirectMusicDownloadedInstrument8 IID_IDirectMusicDownloadedInstrument
#define IID_IDirectMusicPort8 IID_IDirectMusicPort

#define DMUS_VOLUME_MAX 2000
#define DMUS_VOLUME_MIN -20000

#endif
