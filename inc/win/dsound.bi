'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) the Wine project
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "dsound"
#inclib "uuid"

#include once "_mingw_unicode.bi"
#include once "objbase.bi"

extern "Windows"

#define __DSOUND_INCLUDED__
const DIRECTSOUND_VERSION = &h0900
type D3DVALUE as single
type LPD3DVALUE as single ptr
type LPD3DVECTOR as D3DVECTOR ptr
#define LPD3DVECTOR_DEFINED
#define DX_SHARED_DEFINES

extern CLSID_DirectSound as const GUID
extern CLSID_DirectSound8 as const GUID
extern CLSID_DirectSoundCapture as const GUID
extern CLSID_DirectSoundCapture8 as const GUID
extern CLSID_DirectSoundFullDuplex as const GUID
extern IID_IDirectSound as const GUID
type LPDIRECTSOUND as IDirectSound ptr
type LPLPDIRECTSOUND as IDirectSound ptr ptr
extern IID_IDirectSound8 as const GUID
type LPDIRECTSOUND8 as IDirectSound8 ptr
type LPLPDIRECTSOUND8 as IDirectSound8 ptr ptr
extern IID_IDirectSoundBuffer as const GUID
type LPDIRECTSOUNDBUFFER as IDirectSoundBuffer ptr
type LPLPDIRECTSOUNDBUFFER as IDirectSoundBuffer ptr ptr
extern IID_IDirectSoundBuffer8 as const GUID
type LPDIRECTSOUNDBUFFER8 as IDirectSoundBuffer8 ptr
type LPLPDIRECTSOUNDBUFFER8 as IDirectSoundBuffer8 ptr ptr
extern IID_IDirectSoundNotify as const GUID
type LPDIRECTSOUNDNOTIFY as IDirectSoundNotify ptr
type LPLPDIRECTSOUNDNOTIFY as IDirectSoundNotify ptr ptr
extern IID_IDirectSoundNotify8 alias "IID_IDirectSoundNotify" as const GUID
extern IID_IDirectSound3DListener as const GUID
type LPDIRECTSOUND3DLISTENER as IDirectSound3DListener ptr
type LPLPDIRECTSOUND3DLISTENER as IDirectSound3DListener ptr ptr
extern IID_IDirectSound3DBuffer as const GUID
type LPDIRECTSOUND3DBUFFER as IDirectSound3DBuffer ptr
type LPLPDIRECTSOUND3DBUFFER as IDirectSound3DBuffer ptr ptr
extern IID_IDirectSoundCapture as const GUID
type LPDIRECTSOUNDCAPTURE as IDirectSoundCapture ptr
type LPLPDIRECTSOUNDCAPTURE as IDirectSoundCapture ptr ptr
extern IID_IDirectSoundCapture8 alias "IID_IDirectSoundCapture" as const GUID

type IDirectSoundCapture8 as IDirectSoundCapture
type LPDIRECTSOUNDCAPTURE8 as IDirectSoundCapture ptr
type LPLPDIRECTSOUNDCAPTURE8 as IDirectSoundCapture ptr ptr
extern IID_IDirectSoundCaptureBuffer as const GUID
type LPDIRECTSOUNDCAPTUREBUFFER as IDirectSoundCaptureBuffer ptr
type LPLPDIRECTSOUNDCAPTUREBUFFER as IDirectSoundCaptureBuffer ptr ptr
extern IID_IDirectSoundCaptureBuffer8 as const GUID
type LPDIRECTSOUNDCAPTUREBUFFER8 as IDirectSoundCaptureBuffer8 ptr
type LPLPDIRECTSOUNDCAPTUREBUFFER8 as IDirectSoundCaptureBuffer8 ptr ptr
extern IID_IDirectSoundFullDuplex as const GUID
type LPDIRECTSOUNDFULLDUPLEX as IDirectSoundFullDuplex ptr
type LPLPDIRECTSOUNDFULLDUPLEX as IDirectSoundFullDuplex ptr ptr

extern IID_IDirectSoundFullDuplex8 alias "IID_IDirectSoundFullDuplex" as const GUID
extern DSDEVID_DefaultPlayback as const GUID
extern DSDEVID_DefaultCapture as const GUID
extern DSDEVID_DefaultVoicePlayback as const GUID
extern DSDEVID_DefaultVoiceCapture as const GUID
extern GUID_DSFX_STANDARD_GARGLE as const GUID
extern GUID_DSFX_STANDARD_CHORUS as const GUID
extern GUID_DSFX_STANDARD_FLANGER as const GUID
extern GUID_DSFX_STANDARD_ECHO as const GUID
extern GUID_DSFX_STANDARD_DISTORTION as const GUID
extern GUID_DSFX_STANDARD_COMPRESSOR as const GUID
extern GUID_DSFX_STANDARD_PARAMEQ as const GUID
extern GUID_DSFX_STANDARD_I3DL2REVERB as const GUID
extern GUID_DSFX_WAVES_REVERB as const GUID
extern GUID_DSCFX_CLASS_AEC as const GUID
extern GUID_DSCFX_MS_AEC as const GUID
extern GUID_DSCFX_SYSTEM_AEC as const GUID
extern GUID_DSCFX_CLASS_NS as const GUID
extern GUID_DSCFX_MS_NS as const GUID
extern GUID_DSCFX_SYSTEM_NS as const GUID

const _FACDS = &h878
#define MAKE_DSHRESULT(code) MAKE_HRESULT(1, _FACDS, code)
const DS_OK = 0
#define DS_NO_VIRTUALIZATION MAKE_HRESULT(0, _FACDS, 10)
#define DS_INCOMPLETE MAKE_HRESULT(0, _FACDS, 20)
#define DSERR_ALLOCATED MAKE_DSHRESULT(10)
#define DSERR_CONTROLUNAVAIL MAKE_DSHRESULT(30)
#define DSERR_INVALIDPARAM E_INVALIDARG
#define DSERR_INVALIDCALL MAKE_DSHRESULT(50)
#define DSERR_GENERIC E_FAIL
#define DSERR_PRIOLEVELNEEDED MAKE_DSHRESULT(70)
#define DSERR_OUTOFMEMORY E_OUTOFMEMORY
#define DSERR_BADFORMAT MAKE_DSHRESULT(100)
#define DSERR_UNSUPPORTED E_NOTIMPL
#define DSERR_NODRIVER MAKE_DSHRESULT(120)
#define DSERR_ALREADYINITIALIZED MAKE_DSHRESULT(130)
#define DSERR_NOAGGREGATION CLASS_E_NOAGGREGATION
#define DSERR_BUFFERLOST MAKE_DSHRESULT(150)
#define DSERR_OTHERAPPHASPRIO MAKE_DSHRESULT(160)
#define DSERR_UNINITIALIZED MAKE_DSHRESULT(170)
#define DSERR_NOINTERFACE E_NOINTERFACE
#define DSERR_ACCESSDENIED E_ACCESSDENIED
#define DSERR_BUFFERTOOSMALL MAKE_DSHRESULT(180)
#define DSERR_DS8_REQUIRED MAKE_DSHRESULT(190)
#define DSERR_SENDLOOP MAKE_DSHRESULT(200)
#define DSERR_BADSENDBUFFERGUID MAKE_DSHRESULT(210)
#define DSERR_FXUNAVAILABLE MAKE_DSHRESULT(220)
#define DSERR_OBJECTNOTFOUND MAKE_DSHRESULT(4449)
const DSCAPS_PRIMARYMONO = &h00000001
const DSCAPS_PRIMARYSTEREO = &h00000002
const DSCAPS_PRIMARY8BIT = &h00000004
const DSCAPS_PRIMARY16BIT = &h00000008
const DSCAPS_CONTINUOUSRATE = &h00000010
const DSCAPS_EMULDRIVER = &h00000020
const DSCAPS_CERTIFIED = &h00000040
const DSCAPS_SECONDARYMONO = &h00000100
const DSCAPS_SECONDARYSTEREO = &h00000200
const DSCAPS_SECONDARY8BIT = &h00000400
const DSCAPS_SECONDARY16BIT = &h00000800
const DSSCL_NORMAL = 1
const DSSCL_PRIORITY = 2
const DSSCL_EXCLUSIVE = 3
const DSSCL_WRITEPRIMARY = 4

type _DSCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwMinSecondarySampleRate as DWORD
	dwMaxSecondarySampleRate as DWORD
	dwPrimaryBuffers as DWORD
	dwMaxHwMixingAllBuffers as DWORD
	dwMaxHwMixingStaticBuffers as DWORD
	dwMaxHwMixingStreamingBuffers as DWORD
	dwFreeHwMixingAllBuffers as DWORD
	dwFreeHwMixingStaticBuffers as DWORD
	dwFreeHwMixingStreamingBuffers as DWORD
	dwMaxHw3DAllBuffers as DWORD
	dwMaxHw3DStaticBuffers as DWORD
	dwMaxHw3DStreamingBuffers as DWORD
	dwFreeHw3DAllBuffers as DWORD
	dwFreeHw3DStaticBuffers as DWORD
	dwFreeHw3DStreamingBuffers as DWORD
	dwTotalHwMemBytes as DWORD
	dwFreeHwMemBytes as DWORD
	dwMaxContigFreeHwMemBytes as DWORD
	dwUnlockTransferRateHwBuffers as DWORD
	dwPlayCpuOverheadSwBuffers as DWORD
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type DSCAPS as _DSCAPS
type LPDSCAPS as _DSCAPS ptr
type LPCDSCAPS as const DSCAPS ptr

const DSBPLAY_LOOPING = &h00000001
const DSBPLAY_LOCHARDWARE = &h00000002
const DSBPLAY_LOCSOFTWARE = &h00000004
const DSBPLAY_TERMINATEBY_TIME = &h00000008
const DSBPLAY_TERMINATEBY_DISTANCE = &h000000010
const DSBPLAY_TERMINATEBY_PRIORITY = &h000000020
const DSBSTATUS_PLAYING = &h00000001
const DSBSTATUS_BUFFERLOST = &h00000002
const DSBSTATUS_LOOPING = &h00000004
const DSBSTATUS_LOCHARDWARE = &h00000008
const DSBSTATUS_LOCSOFTWARE = &h00000010
const DSBSTATUS_TERMINATED = &h00000020
const DSBLOCK_FROMWRITECURSOR = &h00000001
const DSBLOCK_ENTIREBUFFER = &h00000002
const DSBCAPS_PRIMARYBUFFER = &h00000001
const DSBCAPS_STATIC = &h00000002
const DSBCAPS_LOCHARDWARE = &h00000004
const DSBCAPS_LOCSOFTWARE = &h00000008
const DSBCAPS_CTRL3D = &h00000010
const DSBCAPS_CTRLFREQUENCY = &h00000020
const DSBCAPS_CTRLPAN = &h00000040
const DSBCAPS_CTRLVOLUME = &h00000080
const DSBCAPS_CTRLDEFAULT = &h000000E0
const DSBCAPS_CTRLPOSITIONNOTIFY = &h00000100
const DSBCAPS_CTRLFX = &h00000200
const DSBCAPS_CTRLALL = &h000001F0
const DSBCAPS_STICKYFOCUS = &h00004000
const DSBCAPS_GLOBALFOCUS = &h00008000
const DSBCAPS_GETCURRENTPOSITION2 = &h00010000
const DSBCAPS_MUTE3DATMAXDISTANCE = &h00020000
const DSBCAPS_LOCDEFER = &h00040000
const DSBSIZE_MIN = 4
const DSBSIZE_MAX = &hFFFFFFF
const DSBSIZE_FX_MIN = 150
const DSBPAN_LEFT = -10000
const DSBPAN_CENTER = 0
const DSBPAN_RIGHT = 10000
const DSBVOLUME_MAX = 0
const DSBVOLUME_MIN = -10000
const DSBFREQUENCY_MIN = 100
const DSBFREQUENCY_MAX = 200000
const DSBFREQUENCY_ORIGINAL = 0
const DSBNOTIFICATIONS_MAX = 100000u

type _DSBCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwUnlockTransferRate as DWORD
	dwPlayCpuOverhead as DWORD
end type

type DSBCAPS as _DSBCAPS
type LPDSBCAPS as _DSBCAPS ptr
type LPCDSBCAPS as const DSBCAPS ptr

const DSSCL_NORMAL = 1
const DSSCL_PRIORITY = 2
const DSSCL_EXCLUSIVE = 3
const DSSCL_WRITEPRIMARY = 4

type _DSEFFECTDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidDSFXClass as GUID
	dwReserved1 as DWORD_PTR
	dwReserved2 as DWORD_PTR
end type

type DSEFFECTDESC as _DSEFFECTDESC
type LPDSEFFECTDESC as _DSEFFECTDESC ptr
type LPCDSEFFECTDESC as const DSEFFECTDESC ptr
const DSFX_LOCHARDWARE = &h00000001
const DSFX_LOCSOFTWARE = &h00000002

enum
	DSFXR_PRESENT
	DSFXR_LOCHARDWARE
	DSFXR_LOCSOFTWARE
	DSFXR_UNALLOCATED
	DSFXR_FAILED
	DSFXR_UNKNOWN
	DSFXR_SENDLOOP
end enum

type _DSBUFFERDESC1
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
end type

type DSBUFFERDESC1 as _DSBUFFERDESC1
type LPDSBUFFERDESC1 as _DSBUFFERDESC1 ptr
type LPCDSBUFFERDESC1 as const DSBUFFERDESC1 ptr

type _DSBUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
	guid3DAlgorithm as GUID
end type

type DSBUFFERDESC as _DSBUFFERDESC
type LPDSBUFFERDESC as _DSBUFFERDESC ptr
type LPCDSBUFFERDESC as const DSBUFFERDESC ptr

type _DSBPOSITIONNOTIFY
	dwOffset as DWORD
	hEventNotify as HANDLE
end type

type DSBPOSITIONNOTIFY as _DSBPOSITIONNOTIFY
type LPDSBPOSITIONNOTIFY as _DSBPOSITIONNOTIFY ptr
type LPCDSBPOSITIONNOTIFY as const DSBPOSITIONNOTIFY ptr

const DSSPEAKER_DIRECTOUT = 0
const DSSPEAKER_HEADPHONE = 1
const DSSPEAKER_MONO = 2
const DSSPEAKER_QUAD = 3
const DSSPEAKER_STEREO = 4
const DSSPEAKER_SURROUND = 5
const DSSPEAKER_5POINT1 = 6
const DSSPEAKER_5POINT1_BACK = 6
const DSSPEAKER_7POINT1 = 7
const DSSPEAKER_7POINT1_WIDE = 7
const DSSPEAKER_7POINT1_SURROUND = 8
const DSSPEAKER_5POINT1_SURROUND = 9
const DSSPEAKER_GEOMETRY_MIN = &h00000005
const DSSPEAKER_GEOMETRY_NARROW = &h0000000A
const DSSPEAKER_GEOMETRY_WIDE = &h00000014
const DSSPEAKER_GEOMETRY_MAX = &h000000B4
#define DSSPEAKER_COMBINED(c, g) cast(DWORD, cast(UBYTE, (c)) or (cast(DWORD, cast(UBYTE, (g))) shl 16))
#define DSSPEAKER_CONFIG(a) cast(UBYTE, (a))
#define DSSPEAKER_GEOMETRY(a) cast(UBYTE, (cast(DWORD, (a)) shr 16) and &h00FF)
const DS_CERTIFIED = &h00000000
const DS_UNCERTIFIED = &h00000001
extern DS3DALG_DEFAULT alias "GUID_NULL" as const IID

type _DSCEFFECTDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidDSCFXClass as GUID
	guidDSCFXInstance as GUID
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type DSCEFFECTDESC as _DSCEFFECTDESC
type LPDSCEFFECTDESC as _DSCEFFECTDESC ptr
type LPCDSCEFFECTDESC as const DSCEFFECTDESC ptr

const DSCFX_LOCHARDWARE = &h00000001
const DSCFX_LOCSOFTWARE = &h00000002
const DSCFXR_LOCHARDWARE = &h00000010
const DSCFXR_LOCSOFTWARE = &h00000020

type _DSCBUFFERDESC1
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
end type

type DSCBUFFERDESC1 as _DSCBUFFERDESC1
type LPDSCBUFFERDESC1 as _DSCBUFFERDESC1 ptr

type _DSCBUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
	dwFXCount as DWORD
	lpDSCFXDesc as LPDSCEFFECTDESC
end type

type DSCBUFFERDESC as _DSCBUFFERDESC
type LPDSCBUFFERDESC as _DSCBUFFERDESC ptr
type LPCDSCBUFFERDESC as const DSCBUFFERDESC ptr

type _DSCCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwFormats as DWORD
	dwChannels as DWORD
end type

type DSCCAPS as _DSCCAPS
type LPDSCCAPS as _DSCCAPS ptr
type LPCDSCCAPS as const DSCCAPS ptr

type _DSCBCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
end type

type DSCBCAPS as _DSCBCAPS
type LPDSCBCAPS as _DSCBCAPS ptr
type LPCDSCBCAPS as const DSCBCAPS ptr

const DSCCAPS_EMULDRIVER = DSCAPS_EMULDRIVER
const DSCCAPS_CERTIFIED = DSCAPS_CERTIFIED
const DSCCAPS_MULTIPLECAPTURE = &h00000001
const DSCBCAPS_WAVEMAPPED = &h80000000
const DSCBCAPS_CTRLFX = &h00000200
const DSCBLOCK_ENTIREBUFFER = &h00000001
const DSCBSTART_LOOPING = &h00000001
const DSCBPN_OFFSET_STOP = &hffffffff
const DSCBSTATUS_CAPTURING = &h00000001
const DSCBSTATUS_LOOPING = &h00000002
type LPDSENUMCALLBACKW as function(byval as LPGUID, byval as LPCWSTR, byval as LPCWSTR, byval as LPVOID) as WINBOOL
type LPDSENUMCALLBACKA as function(byval as LPGUID, byval as LPCSTR, byval as LPCSTR, byval as LPVOID) as WINBOOL

#ifdef UNICODE
	type LPDSENUMCALLBACK as LPDSENUMCALLBACKW
#else
	type LPDSENUMCALLBACK as LPDSENUMCALLBACKA
#endif

declare function DirectSoundCreate(byval lpGUID as LPCGUID, byval ppDS as LPDIRECTSOUND ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundEnumerateA(byval as LPDSENUMCALLBACKA, byval as LPVOID) as HRESULT
declare function DirectSoundEnumerateW(byval as LPDSENUMCALLBACKW, byval as LPVOID) as HRESULT

#ifdef UNICODE
	declare function DirectSoundEnumerate alias "DirectSoundEnumerateW"(byval as LPDSENUMCALLBACKW, byval as LPVOID) as HRESULT
#else
	declare function DirectSoundEnumerate alias "DirectSoundEnumerateA"(byval as LPDSENUMCALLBACKA, byval as LPVOID) as HRESULT
#endif

declare function DirectSoundCaptureCreate(byval lpGUID as LPCGUID, byval ppDSC as LPDIRECTSOUNDCAPTURE ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundCaptureEnumerateA(byval as LPDSENUMCALLBACKA, byval as LPVOID) as HRESULT
declare function DirectSoundCaptureEnumerateW(byval as LPDSENUMCALLBACKW, byval as LPVOID) as HRESULT

#ifdef UNICODE
	declare function DirectSoundCaptureEnumerate alias "DirectSoundCaptureEnumerateW"(byval as LPDSENUMCALLBACKW, byval as LPVOID) as HRESULT
#else
	declare function DirectSoundCaptureEnumerate alias "DirectSoundCaptureEnumerateA"(byval as LPDSENUMCALLBACKA, byval as LPVOID) as HRESULT
#endif

declare function DirectSoundCreate8(byval lpGUID as LPCGUID, byval ppDS8 as LPDIRECTSOUND8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundCaptureCreate8(byval lpGUID as LPCGUID, byval ppDSC8 as LPDIRECTSOUNDCAPTURE8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundFullDuplexCreate(byval pcGuidCaptureDevice as LPCGUID, byval pcGuidRenderDevice as LPCGUID, byval pcDSCBufferDesc as LPCDSCBUFFERDESC, byval pcDSBufferDesc as LPCDSBUFFERDESC, byval hWnd as HWND, byval dwLevel as DWORD, byval ppDSFD as LPDIRECTSOUNDFULLDUPLEX ptr, byval ppDSCBuffer8 as LPDIRECTSOUNDCAPTUREBUFFER8 ptr, byval ppDSBuffer8 as LPDIRECTSOUNDBUFFER8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundFullDuplexCreate8 alias "DirectSoundFullDuplexCreate"(byval pcGuidCaptureDevice as LPCGUID, byval pcGuidRenderDevice as LPCGUID, byval pcDSCBufferDesc as LPCDSCBUFFERDESC, byval pcDSBufferDesc as LPCDSBUFFERDESC, byval hWnd as HWND, byval dwLevel as DWORD, byval ppDSFD as LPDIRECTSOUNDFULLDUPLEX ptr, byval ppDSCBuffer8 as LPDIRECTSOUNDCAPTUREBUFFER8 ptr, byval ppDSBuffer8 as LPDIRECTSOUNDBUFFER8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function GetDeviceID(byval lpGuidSrc as LPCGUID, byval lpGuidDest as LPGUID) as HRESULT
type IDirectSoundVtbl as IDirectSoundVtbl_

type IDirectSound
	lpVtbl as IDirectSoundVtbl ptr
end type

type IDirectSoundVtbl_
	QueryInterface as function(byval This as IDirectSound ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSound ptr) as ULONG
	Release as function(byval This as IDirectSound ptr) as ULONG
	CreateSoundBuffer as function(byval This as IDirectSound ptr, byval lpcDSBufferDesc as LPCDSBUFFERDESC, byval lplpDirectSoundBuffer as LPLPDIRECTSOUNDBUFFER, byval pUnkOuter as IUnknown ptr) as HRESULT
	GetCaps as function(byval This as IDirectSound ptr, byval lpDSCaps as LPDSCAPS) as HRESULT
	DuplicateSoundBuffer as function(byval This as IDirectSound ptr, byval lpDsbOriginal as LPDIRECTSOUNDBUFFER, byval lplpDsbDuplicate as LPLPDIRECTSOUNDBUFFER) as HRESULT
	SetCooperativeLevel as function(byval This as IDirectSound ptr, byval hwnd as HWND, byval dwLevel as DWORD) as HRESULT
	Compact as function(byval This as IDirectSound ptr) as HRESULT
	GetSpeakerConfig as function(byval This as IDirectSound ptr, byval lpdwSpeakerConfig as LPDWORD) as HRESULT
	SetSpeakerConfig as function(byval This as IDirectSound ptr, byval dwSpeakerConfig as DWORD) as HRESULT
	Initialize as function(byval This as IDirectSound ptr, byval lpcGuid as LPCGUID) as HRESULT
end type

#define IDirectSound_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSound_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSound_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSound_CreateSoundBuffer(p, a, b, c) (p)->lpVtbl->CreateSoundBuffer(p, a, b, c)
#define IDirectSound_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSound_DuplicateSoundBuffer(p, a, b) (p)->lpVtbl->DuplicateSoundBuffer(p, a, b)
#define IDirectSound_SetCooperativeLevel(p, a, b) (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectSound_Compact(p) (p)->lpVtbl->Compact(p)
#define IDirectSound_GetSpeakerConfig(p, a) (p)->lpVtbl->GetSpeakerConfig(p, a)
#define IDirectSound_SetSpeakerConfig(p, a) (p)->lpVtbl->SetSpeakerConfig(p, a)
#define IDirectSound_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
type IDirectSound8Vtbl as IDirectSound8Vtbl_

type IDirectSound8
	lpVtbl as IDirectSound8Vtbl ptr
end type

type IDirectSound8Vtbl_
	QueryInterface as function(byval This as IDirectSound8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSound8 ptr) as ULONG
	Release as function(byval This as IDirectSound8 ptr) as ULONG
	CreateSoundBuffer as function(byval This as IDirectSound8 ptr, byval lpcDSBufferDesc as LPCDSBUFFERDESC, byval lplpDirectSoundBuffer as LPLPDIRECTSOUNDBUFFER, byval pUnkOuter as IUnknown ptr) as HRESULT
	GetCaps as function(byval This as IDirectSound8 ptr, byval lpDSCaps as LPDSCAPS) as HRESULT
	DuplicateSoundBuffer as function(byval This as IDirectSound8 ptr, byval lpDsbOriginal as LPDIRECTSOUNDBUFFER, byval lplpDsbDuplicate as LPLPDIRECTSOUNDBUFFER) as HRESULT
	SetCooperativeLevel as function(byval This as IDirectSound8 ptr, byval hwnd as HWND, byval dwLevel as DWORD) as HRESULT
	Compact as function(byval This as IDirectSound8 ptr) as HRESULT
	GetSpeakerConfig as function(byval This as IDirectSound8 ptr, byval lpdwSpeakerConfig as LPDWORD) as HRESULT
	SetSpeakerConfig as function(byval This as IDirectSound8 ptr, byval dwSpeakerConfig as DWORD) as HRESULT
	Initialize as function(byval This as IDirectSound8 ptr, byval lpcGuid as LPCGUID) as HRESULT
	VerifyCertification as function(byval This as IDirectSound8 ptr, byval pdwCertified as LPDWORD) as HRESULT
end type

#define IDirectSound8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSound8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSound8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSound8_CreateSoundBuffer(p, a, b, c) (p)->lpVtbl->CreateSoundBuffer(p, a, b, c)
#define IDirectSound8_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSound8_DuplicateSoundBuffer(p, a, b) (p)->lpVtbl->DuplicateSoundBuffer(p, a, b)
#define IDirectSound8_SetCooperativeLevel(p, a, b) (p)->lpVtbl->SetCooperativeLevel(p, a, b)
#define IDirectSound8_Compact(p) (p)->lpVtbl->Compact(p)
#define IDirectSound8_GetSpeakerConfig(p, a) (p)->lpVtbl->GetSpeakerConfig(p, a)
#define IDirectSound8_SetSpeakerConfig(p, a) (p)->lpVtbl->SetSpeakerConfig(p, a)
#define IDirectSound8_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
#define IDirectSound8_VerifyCertification(p, a) (p)->lpVtbl->VerifyCertification(p, a)
type IDirectSoundBufferVtbl as IDirectSoundBufferVtbl_

type IDirectSoundBuffer
	lpVtbl as IDirectSoundBufferVtbl ptr
end type

type IDirectSoundBufferVtbl_
	QueryInterface as function(byval This as IDirectSoundBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundBuffer ptr) as ULONG
	Release as function(byval This as IDirectSoundBuffer ptr) as ULONG
	GetCaps as function(byval This as IDirectSoundBuffer ptr, byval lpDSBufferCaps as LPDSBCAPS) as HRESULT
	GetCurrentPosition as function(byval This as IDirectSoundBuffer ptr, byval lpdwCurrentPlayCursor as LPDWORD, byval lpdwCurrentWriteCursor as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectSoundBuffer ptr, byval lpwfxFormat as LPWAVEFORMATEX, byval dwSizeAllocated as DWORD, byval lpdwSizeWritten as LPDWORD) as HRESULT
	GetVolume as function(byval This as IDirectSoundBuffer ptr, byval lplVolume as LPLONG) as HRESULT
	GetPan as function(byval This as IDirectSoundBuffer ptr, byval lplpan as LPLONG) as HRESULT
	GetFrequency as function(byval This as IDirectSoundBuffer ptr, byval lpdwFrequency as LPDWORD) as HRESULT
	GetStatus as function(byval This as IDirectSoundBuffer ptr, byval lpdwStatus as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectSoundBuffer ptr, byval lpDirectSound as LPDIRECTSOUND, byval lpcDSBufferDesc as LPCDSBUFFERDESC) as HRESULT
	Lock as function(byval This as IDirectSoundBuffer ptr, byval dwOffset as DWORD, byval dwBytes as DWORD, byval ppvAudioPtr1 as LPVOID ptr, byval pdwAudioBytes1 as LPDWORD, byval ppvAudioPtr2 as LPVOID ptr, byval pdwAudioBytes2 as LPDWORD, byval dwFlags as DWORD) as HRESULT
	Play as function(byval This as IDirectSoundBuffer ptr, byval dwReserved1 as DWORD, byval dwReserved2 as DWORD, byval dwFlags as DWORD) as HRESULT
	SetCurrentPosition as function(byval This as IDirectSoundBuffer ptr, byval dwNewPosition as DWORD) as HRESULT
	SetFormat as function(byval This as IDirectSoundBuffer ptr, byval lpcfxFormat as LPCWAVEFORMATEX) as HRESULT
	SetVolume as function(byval This as IDirectSoundBuffer ptr, byval lVolume as LONG) as HRESULT
	SetPan as function(byval This as IDirectSoundBuffer ptr, byval lPan as LONG) as HRESULT
	SetFrequency as function(byval This as IDirectSoundBuffer ptr, byval dwFrequency as DWORD) as HRESULT
	Stop as function(byval This as IDirectSoundBuffer ptr) as HRESULT
	Unlock as function(byval This as IDirectSoundBuffer ptr, byval pvAudioPtr1 as LPVOID, byval dwAudioBytes1 as DWORD, byval pvAudioPtr2 as LPVOID, byval dwAudioPtr2 as DWORD) as HRESULT
	Restore as function(byval This as IDirectSoundBuffer ptr) as HRESULT
end type

#define IDirectSoundBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundBuffer_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSoundBuffer_GetCurrentPosition(p, a, b) (p)->lpVtbl->GetCurrentPosition(p, a, b)
#define IDirectSoundBuffer_GetFormat(p, a, b, c) (p)->lpVtbl->GetFormat(p, a, b, c)
#define IDirectSoundBuffer_GetVolume(p, a) (p)->lpVtbl->GetVolume(p, a)
#define IDirectSoundBuffer_GetPan(p, a) (p)->lpVtbl->GetPan(p, a)
#define IDirectSoundBuffer_GetFrequency(p, a) (p)->lpVtbl->GetFrequency(p, a)
#define IDirectSoundBuffer_GetStatus(p, a) (p)->lpVtbl->GetStatus(p, a)
#define IDirectSoundBuffer_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirectSoundBuffer_Lock(p, a, b, c, d, e, f, g) (p)->lpVtbl->Lock(p, a, b, c, d, e, f, g)
#define IDirectSoundBuffer_Play(p, a, b, c) (p)->lpVtbl->Play(p, a, b, c)
#define IDirectSoundBuffer_SetCurrentPosition(p, a) (p)->lpVtbl->SetCurrentPosition(p, a)
#define IDirectSoundBuffer_SetFormat(p, a) (p)->lpVtbl->SetFormat(p, a)
#define IDirectSoundBuffer_SetVolume(p, a) (p)->lpVtbl->SetVolume(p, a)
#define IDirectSoundBuffer_SetPan(p, a) (p)->lpVtbl->SetPan(p, a)
#define IDirectSoundBuffer_SetFrequency(p, a) (p)->lpVtbl->SetFrequency(p, a)
#define IDirectSoundBuffer_Stop(p) (p)->lpVtbl->Stop(p)
#define IDirectSoundBuffer_Unlock(p, a, b, c, d) (p)->lpVtbl->Unlock(p, a, b, c, d)
#define IDirectSoundBuffer_Restore(p) (p)->lpVtbl->Restore(p)
type IDirectSoundBuffer8Vtbl as IDirectSoundBuffer8Vtbl_

type IDirectSoundBuffer8
	lpVtbl as IDirectSoundBuffer8Vtbl ptr
end type

type IDirectSoundBuffer8Vtbl_
	QueryInterface as function(byval This as IDirectSoundBuffer8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundBuffer8 ptr) as ULONG
	Release as function(byval This as IDirectSoundBuffer8 ptr) as ULONG
	GetCaps as function(byval This as IDirectSoundBuffer8 ptr, byval lpDSBufferCaps as LPDSBCAPS) as HRESULT
	GetCurrentPosition as function(byval This as IDirectSoundBuffer8 ptr, byval lpdwCurrentPlayCursor as LPDWORD, byval lpdwCurrentWriteCursor as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectSoundBuffer8 ptr, byval lpwfxFormat as LPWAVEFORMATEX, byval dwSizeAllocated as DWORD, byval lpdwSizeWritten as LPDWORD) as HRESULT
	GetVolume as function(byval This as IDirectSoundBuffer8 ptr, byval lplVolume as LPLONG) as HRESULT
	GetPan as function(byval This as IDirectSoundBuffer8 ptr, byval lplpan as LPLONG) as HRESULT
	GetFrequency as function(byval This as IDirectSoundBuffer8 ptr, byval lpdwFrequency as LPDWORD) as HRESULT
	GetStatus as function(byval This as IDirectSoundBuffer8 ptr, byval lpdwStatus as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectSoundBuffer8 ptr, byval lpDirectSound as LPDIRECTSOUND, byval lpcDSBufferDesc as LPCDSBUFFERDESC) as HRESULT
	Lock as function(byval This as IDirectSoundBuffer8 ptr, byval dwOffset as DWORD, byval dwBytes as DWORD, byval ppvAudioPtr1 as LPVOID ptr, byval pdwAudioBytes1 as LPDWORD, byval ppvAudioPtr2 as LPVOID ptr, byval pdwAudioBytes2 as LPDWORD, byval dwFlags as DWORD) as HRESULT
	Play as function(byval This as IDirectSoundBuffer8 ptr, byval dwReserved1 as DWORD, byval dwReserved2 as DWORD, byval dwFlags as DWORD) as HRESULT
	SetCurrentPosition as function(byval This as IDirectSoundBuffer8 ptr, byval dwNewPosition as DWORD) as HRESULT
	SetFormat as function(byval This as IDirectSoundBuffer8 ptr, byval lpcfxFormat as LPCWAVEFORMATEX) as HRESULT
	SetVolume as function(byval This as IDirectSoundBuffer8 ptr, byval lVolume as LONG) as HRESULT
	SetPan as function(byval This as IDirectSoundBuffer8 ptr, byval lPan as LONG) as HRESULT
	SetFrequency as function(byval This as IDirectSoundBuffer8 ptr, byval dwFrequency as DWORD) as HRESULT
	Stop as function(byval This as IDirectSoundBuffer8 ptr) as HRESULT
	Unlock as function(byval This as IDirectSoundBuffer8 ptr, byval pvAudioPtr1 as LPVOID, byval dwAudioBytes1 as DWORD, byval pvAudioPtr2 as LPVOID, byval dwAudioPtr2 as DWORD) as HRESULT
	Restore as function(byval This as IDirectSoundBuffer8 ptr) as HRESULT
	SetFX as function(byval This as IDirectSoundBuffer8 ptr, byval dwEffectsCount as DWORD, byval pDSFXDesc as LPDSEFFECTDESC, byval pdwResultCodes as LPDWORD) as HRESULT
	AcquireResources as function(byval This as IDirectSoundBuffer8 ptr, byval dwFlags as DWORD, byval dwEffectsCount as DWORD, byval pdwResultCodes as LPDWORD) as HRESULT
	GetObjectInPath as function(byval This as IDirectSoundBuffer8 ptr, byval rguidObject as const GUID const ptr, byval dwIndex as DWORD, byval rguidInterface as const GUID const ptr, byval ppObject as LPVOID ptr) as HRESULT
end type

extern GUID_All_Objects as const GUID
#define IDirectSoundBuffer8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundBuffer8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundBuffer8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundBuffer8_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSoundBuffer8_GetCurrentPosition(p, a, b) (p)->lpVtbl->GetCurrentPosition(p, a, b)
#define IDirectSoundBuffer8_GetFormat(p, a, b, c) (p)->lpVtbl->GetFormat(p, a, b, c)
#define IDirectSoundBuffer8_GetVolume(p, a) (p)->lpVtbl->GetVolume(p, a)
#define IDirectSoundBuffer8_GetPan(p, a) (p)->lpVtbl->GetPan(p, a)
#define IDirectSoundBuffer8_GetFrequency(p, a) (p)->lpVtbl->GetFrequency(p, a)
#define IDirectSoundBuffer8_GetStatus(p, a) (p)->lpVtbl->GetStatus(p, a)
#define IDirectSoundBuffer8_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirectSoundBuffer8_Lock(p, a, b, c, d, e, f, g) (p)->lpVtbl->Lock(p, a, b, c, d, e, f, g)
#define IDirectSoundBuffer8_Play(p, a, b, c) (p)->lpVtbl->Play(p, a, b, c)
#define IDirectSoundBuffer8_SetCurrentPosition(p, a) (p)->lpVtbl->SetCurrentPosition(p, a)
#define IDirectSoundBuffer8_SetFormat(p, a) (p)->lpVtbl->SetFormat(p, a)
#define IDirectSoundBuffer8_SetVolume(p, a) (p)->lpVtbl->SetVolume(p, a)
#define IDirectSoundBuffer8_SetPan(p, a) (p)->lpVtbl->SetPan(p, a)
#define IDirectSoundBuffer8_SetFrequency(p, a) (p)->lpVtbl->SetFrequency(p, a)
#define IDirectSoundBuffer8_Stop(p) (p)->lpVtbl->Stop(p)
#define IDirectSoundBuffer8_Unlock(p, a, b, c, d) (p)->lpVtbl->Unlock(p, a, b, c, d)
#define IDirectSoundBuffer8_Restore(p) (p)->lpVtbl->Restore(p)
#define IDirectSoundBuffer8_SetFX(p, a, b, c) (p)->lpVtbl->SetFX(p, a, b, c)
#define IDirectSoundBuffer8_AcquireResources(p, a, b, c) (p)->lpVtbl->AcquireResources(p, a, b, c)
#define IDirectSoundBuffer8_GetObjectInPath(p, a, b, c, d) (p)->lpVtbl->GetObjectInPath(p, a, b, c, d)
type IDirectSoundCaptureVtbl as IDirectSoundCaptureVtbl_

type IDirectSoundCapture
	lpVtbl as IDirectSoundCaptureVtbl ptr
end type

type IDirectSoundCaptureVtbl_
	QueryInterface as function(byval This as IDirectSoundCapture ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundCapture ptr) as ULONG
	Release as function(byval This as IDirectSoundCapture ptr) as ULONG
	CreateCaptureBuffer as function(byval This as IDirectSoundCapture ptr, byval lpcDSCBufferDesc as LPCDSCBUFFERDESC, byval lplpDSCaptureBuffer as LPDIRECTSOUNDCAPTUREBUFFER ptr, byval pUnk as LPUNKNOWN) as HRESULT
	GetCaps as function(byval This as IDirectSoundCapture ptr, byval lpDSCCaps as LPDSCCAPS) as HRESULT
	Initialize as function(byval This as IDirectSoundCapture ptr, byval lpcGUID as LPCGUID) as HRESULT
end type

#define IDirectSoundCapture_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundCapture_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundCapture_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundCapture_CreateCaptureBuffer(p, a, b, c) (p)->lpVtbl->CreateCaptureBuffer(p, a, b, c)
#define IDirectSoundCapture_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSoundCapture_Initialize(p, a) (p)->lpVtbl->Initialize(p, a)
type IDirectSoundCaptureBufferVtbl as IDirectSoundCaptureBufferVtbl_

type IDirectSoundCaptureBuffer
	lpVtbl as IDirectSoundCaptureBufferVtbl ptr
end type

type IDirectSoundCaptureBufferVtbl_
	QueryInterface as function(byval This as IDirectSoundCaptureBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundCaptureBuffer ptr) as ULONG
	Release as function(byval This as IDirectSoundCaptureBuffer ptr) as ULONG
	GetCaps as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpDSCBCaps as LPDSCBCAPS) as HRESULT
	GetCurrentPosition as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpdwCapturePosition as LPDWORD, byval lpdwReadPosition as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpwfxFormat as LPWAVEFORMATEX, byval dwSizeAllocated as DWORD, byval lpdwSizeWritten as LPDWORD) as HRESULT
	GetStatus as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpdwStatus as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpDSC as LPDIRECTSOUNDCAPTURE, byval lpcDSCBDesc as LPCDSCBUFFERDESC) as HRESULT
	Lock as function(byval This as IDirectSoundCaptureBuffer ptr, byval dwReadCusor as DWORD, byval dwReadBytes as DWORD, byval lplpvAudioPtr1 as LPVOID ptr, byval lpdwAudioBytes1 as LPDWORD, byval lplpvAudioPtr2 as LPVOID ptr, byval lpdwAudioBytes2 as LPDWORD, byval dwFlags as DWORD) as HRESULT
	Start as function(byval This as IDirectSoundCaptureBuffer ptr, byval dwFlags as DWORD) as HRESULT
	Stop as function(byval This as IDirectSoundCaptureBuffer ptr) as HRESULT
	Unlock as function(byval This as IDirectSoundCaptureBuffer ptr, byval lpvAudioPtr1 as LPVOID, byval dwAudioBytes1 as DWORD, byval lpvAudioPtr2 as LPVOID, byval dwAudioBytes2 as DWORD) as HRESULT
end type

#define IDirectSoundCaptureBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundCaptureBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundCaptureBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundCaptureBuffer_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSoundCaptureBuffer_GetCurrentPosition(p, a, b) (p)->lpVtbl->GetCurrentPosition(p, a, b)
#define IDirectSoundCaptureBuffer_GetFormat(p, a, b, c) (p)->lpVtbl->GetFormat(p, a, b, c)
#define IDirectSoundCaptureBuffer_GetStatus(p, a) (p)->lpVtbl->GetStatus(p, a)
#define IDirectSoundCaptureBuffer_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirectSoundCaptureBuffer_Lock(p, a, b, c, d, e, f, g) (p)->lpVtbl->Lock(p, a, b, c, d, e, f, g)
#define IDirectSoundCaptureBuffer_Start(p, a) (p)->lpVtbl->Start(p, a)
#define IDirectSoundCaptureBuffer_Stop(p) (p)->lpVtbl->Stop(p)
#define IDirectSoundCaptureBuffer_Unlock(p, a, b, c, d) (p)->lpVtbl->Unlock(p, a, b, c, d)
type IDirectSoundCaptureBuffer8Vtbl as IDirectSoundCaptureBuffer8Vtbl_

type IDirectSoundCaptureBuffer8
	lpVtbl as IDirectSoundCaptureBuffer8Vtbl ptr
end type

type IDirectSoundCaptureBuffer8Vtbl_
	QueryInterface as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundCaptureBuffer8 ptr) as ULONG
	Release as function(byval This as IDirectSoundCaptureBuffer8 ptr) as ULONG
	GetCaps as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpDSCBCaps as LPDSCBCAPS) as HRESULT
	GetCurrentPosition as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpdwCapturePosition as LPDWORD, byval lpdwReadPosition as LPDWORD) as HRESULT
	GetFormat as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpwfxFormat as LPWAVEFORMATEX, byval dwSizeAllocated as DWORD, byval lpdwSizeWritten as LPDWORD) as HRESULT
	GetStatus as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpdwStatus as LPDWORD) as HRESULT
	Initialize as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpDSC as LPDIRECTSOUNDCAPTURE, byval lpcDSCBDesc as LPCDSCBUFFERDESC) as HRESULT
	Lock as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval dwReadCusor as DWORD, byval dwReadBytes as DWORD, byval lplpvAudioPtr1 as LPVOID ptr, byval lpdwAudioBytes1 as LPDWORD, byval lplpvAudioPtr2 as LPVOID ptr, byval lpdwAudioBytes2 as LPDWORD, byval dwFlags as DWORD) as HRESULT
	Start as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval dwFlags as DWORD) as HRESULT
	Stop as function(byval This as IDirectSoundCaptureBuffer8 ptr) as HRESULT
	Unlock as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval lpvAudioPtr1 as LPVOID, byval dwAudioBytes1 as DWORD, byval lpvAudioPtr2 as LPVOID, byval dwAudioBytes2 as DWORD) as HRESULT
	GetObjectInPath as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval rguidObject as const GUID const ptr, byval dwIndex as DWORD, byval rguidInterface as const GUID const ptr, byval ppObject as LPVOID ptr) as HRESULT
	GetFXStatus as function(byval This as IDirectSoundCaptureBuffer8 ptr, byval dwFXCount as DWORD, byval pdwFXStatus as LPDWORD) as HRESULT
end type

#define IDirectSoundCaptureBuffer8_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundCaptureBuffer8_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundCaptureBuffer8_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundCaptureBuffer8_GetCaps(p, a) (p)->lpVtbl->GetCaps(p, a)
#define IDirectSoundCaptureBuffer8_GetCurrentPosition(p, a, b) (p)->lpVtbl->GetCurrentPosition(p, a, b)
#define IDirectSoundCaptureBuffer8_GetFormat(p, a, b, c) (p)->lpVtbl->GetFormat(p, a, b, c)
#define IDirectSoundCaptureBuffer8_GetStatus(p, a) (p)->lpVtbl->GetStatus(p, a)
#define IDirectSoundCaptureBuffer8_Initialize(p, a, b) (p)->lpVtbl->Initialize(p, a, b)
#define IDirectSoundCaptureBuffer8_Lock(p, a, b, c, d, e, f, g) (p)->lpVtbl->Lock(p, a, b, c, d, e, f, g)
#define IDirectSoundCaptureBuffer8_Start(p, a) (p)->lpVtbl->Start(p, a)
#define IDirectSoundCaptureBuffer8_Stop(p) (p)->lpVtbl->Stop(p)
#define IDirectSoundCaptureBuffer8_Unlock(p, a, b, c, d) (p)->lpVtbl->Unlock(p, a, b, c, d)
#define IDirectSoundCaptureBuffer8_GetObjectInPath(p, a, b, c, d) (p)->lpVtbl->GetObjectInPath(p, a, b, c, d)
#define IDirectSoundCaptureBuffer8_GetFXStatus(p, a, b) (p)->lpVtbl->GetFXStatus(p, a, b)
const WINE_NOBUFFER = &h80000000
const DSBPN_OFFSETSTOP = -1
type IDirectSoundNotifyVtbl as IDirectSoundNotifyVtbl_

type IDirectSoundNotify
	lpVtbl as IDirectSoundNotifyVtbl ptr
end type

type IDirectSoundNotifyVtbl_
	QueryInterface as function(byval This as IDirectSoundNotify ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundNotify ptr) as ULONG
	Release as function(byval This as IDirectSoundNotify ptr) as ULONG
	SetNotificationPositions as function(byval This as IDirectSoundNotify ptr, byval cPositionNotifies as DWORD, byval lpcPositionNotifies as LPCDSBPOSITIONNOTIFY) as HRESULT
end type

#define IDirectSoundNotify_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundNotify_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundNotify_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundNotify_SetNotificationPositions(p, a, b) (p)->lpVtbl->SetNotificationPositions(p, a, b)
const DS3DMODE_NORMAL = &h00000000
const DS3DMODE_HEADRELATIVE = &h00000001
const DS3DMODE_DISABLE = &h00000002
const DS3D_IMMEDIATE = &h00000000
const DS3D_DEFERRED = &h00000001
#define DS3D_MINDISTANCEFACTOR FLT_MIN
#define DS3D_MAXDISTANCEFACTOR FLT_MAX
const DS3D_DEFAULTDISTANCEFACTOR = 1.0f
const DS3D_MINROLLOFFFACTOR = 0.0f
const DS3D_MAXROLLOFFFACTOR = 10.0f
const DS3D_DEFAULTROLLOFFFACTOR = 1.0f
const DS3D_MINDOPPLERFACTOR = 0.0f
const DS3D_MAXDOPPLERFACTOR = 10.0f
const DS3D_DEFAULTDOPPLERFACTOR = 1.0f
const DS3D_DEFAULTMINDISTANCE = 1.0f
const DS3D_DEFAULTMAXDISTANCE = 1000000000.0f
const DS3D_MINCONEANGLE = 0
const DS3D_MAXCONEANGLE = 360
const DS3D_DEFAULTCONEANGLE = 360
const DS3D_DEFAULTCONEOUTSIDEVOLUME = DSBVOLUME_MAX

type _DS3DLISTENER
	dwSize as DWORD
	vPosition as D3DVECTOR
	vVelocity as D3DVECTOR
	vOrientFront as D3DVECTOR
	vOrientTop as D3DVECTOR
	flDistanceFactor as D3DVALUE
	flRolloffFactor as D3DVALUE
	flDopplerFactor as D3DVALUE
end type

type DS3DLISTENER as _DS3DLISTENER
type LPDS3DLISTENER as _DS3DLISTENER ptr
type LPCDS3DLISTENER as const DS3DLISTENER ptr
type IDirectSound3DListenerVtbl as IDirectSound3DListenerVtbl_

type IDirectSound3DListener
	lpVtbl as IDirectSound3DListenerVtbl ptr
end type

type IDirectSound3DListenerVtbl_
	QueryInterface as function(byval This as IDirectSound3DListener ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSound3DListener ptr) as ULONG
	Release as function(byval This as IDirectSound3DListener ptr) as ULONG
	GetAllParameters as function(byval This as IDirectSound3DListener ptr, byval lpListener as LPDS3DLISTENER) as HRESULT
	GetDistanceFactor as function(byval This as IDirectSound3DListener ptr, byval lpflDistanceFactor as LPD3DVALUE) as HRESULT
	GetDopplerFactor as function(byval This as IDirectSound3DListener ptr, byval lpflDopplerFactor as LPD3DVALUE) as HRESULT
	GetOrientation as function(byval This as IDirectSound3DListener ptr, byval lpvOrientFront as LPD3DVECTOR, byval lpvOrientTop as LPD3DVECTOR) as HRESULT
	GetPosition as function(byval This as IDirectSound3DListener ptr, byval lpvPosition as LPD3DVECTOR) as HRESULT
	GetRolloffFactor as function(byval This as IDirectSound3DListener ptr, byval lpflRolloffFactor as LPD3DVALUE) as HRESULT
	GetVelocity as function(byval This as IDirectSound3DListener ptr, byval lpvVelocity as LPD3DVECTOR) as HRESULT
	SetAllParameters as function(byval This as IDirectSound3DListener ptr, byval lpcListener as LPCDS3DLISTENER, byval dwApply as DWORD) as HRESULT
	SetDistanceFactor as function(byval This as IDirectSound3DListener ptr, byval flDistanceFactor as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetDopplerFactor as function(byval This as IDirectSound3DListener ptr, byval flDopplerFactor as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetOrientation as function(byval This as IDirectSound3DListener ptr, byval xFront as D3DVALUE, byval yFront as D3DVALUE, byval zFront as D3DVALUE, byval xTop as D3DVALUE, byval yTop as D3DVALUE, byval zTop as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetPosition as function(byval This as IDirectSound3DListener ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetRolloffFactor as function(byval This as IDirectSound3DListener ptr, byval flRolloffFactor as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetVelocity as function(byval This as IDirectSound3DListener ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval dwApply as DWORD) as HRESULT
	CommitDeferredSettings as function(byval This as IDirectSound3DListener ptr) as HRESULT
end type

#define IDirectSound3DListener_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSound3DListener_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSound3DListener_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSound3DListener_GetAllParameters(p, a) (p)->lpVtbl->GetAllParameters(p, a)
#define IDirectSound3DListener_GetDistanceFactor(p, a) (p)->lpVtbl->GetDistanceFactor(p, a)
#define IDirectSound3DListener_GetDopplerFactor(p, a) (p)->lpVtbl->GetDopplerFactor(p, a)
#define IDirectSound3DListener_GetOrientation(p, a, b) (p)->lpVtbl->GetOrientation(p, a, b)
#define IDirectSound3DListener_GetPosition(p, a) (p)->lpVtbl->GetPosition(p, a)
#define IDirectSound3DListener_GetRolloffFactor(p, a) (p)->lpVtbl->GetRolloffFactor(p, a)
#define IDirectSound3DListener_GetVelocity(p, a) (p)->lpVtbl->GetVelocity(p, a)
#define IDirectSound3DListener_SetAllParameters(p, a, b) (p)->lpVtbl->SetAllParameters(p, a, b)
#define IDirectSound3DListener_SetDistanceFactor(p, a, b) (p)->lpVtbl->SetDistanceFactor(p, a, b)
#define IDirectSound3DListener_SetDopplerFactor(p, a, b) (p)->lpVtbl->SetDopplerFactor(p, a, b)
#define IDirectSound3DListener_SetOrientation(p, a, b, c, d, e, f, g) (p)->lpVtbl->SetOrientation(p, a, b, c, d, e, f, g)
#define IDirectSound3DListener_SetPosition(p, a, b, c, d) (p)->lpVtbl->SetPosition(p, a, b, c, d)
#define IDirectSound3DListener_SetRolloffFactor(p, a, b) (p)->lpVtbl->SetRolloffFactor(p, a, b)
#define IDirectSound3DListener_SetVelocity(p, a, b, c, d) (p)->lpVtbl->SetVelocity(p, a, b, c, d)
#define IDirectSound3DListener_CommitDeferredSettings(p) (p)->lpVtbl->CommitDeferredSettings(p)
type IDirectSound3DListener8 as IDirectSound3DListener

type _DS3DBUFFER
	dwSize as DWORD
	vPosition as D3DVECTOR
	vVelocity as D3DVECTOR
	dwInsideConeAngle as DWORD
	dwOutsideConeAngle as DWORD
	vConeOrientation as D3DVECTOR
	lConeOutsideVolume as LONG
	flMinDistance as D3DVALUE
	flMaxDistance as D3DVALUE
	dwMode as DWORD
end type

type DS3DBUFFER as _DS3DBUFFER
type LPDS3DBUFFER as _DS3DBUFFER ptr
type LPCDS3DBUFFER as const DS3DBUFFER ptr
type IDirectSound3DBufferVtbl as IDirectSound3DBufferVtbl_

type IDirectSound3DBuffer
	lpVtbl as IDirectSound3DBufferVtbl ptr
end type

type IDirectSound3DBufferVtbl_
	QueryInterface as function(byval This as IDirectSound3DBuffer ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSound3DBuffer ptr) as ULONG
	Release as function(byval This as IDirectSound3DBuffer ptr) as ULONG
	GetAllParameters as function(byval This as IDirectSound3DBuffer ptr, byval lpDs3dBuffer as LPDS3DBUFFER) as HRESULT
	GetConeAngles as function(byval This as IDirectSound3DBuffer ptr, byval lpdwInsideConeAngle as LPDWORD, byval lpdwOutsideConeAngle as LPDWORD) as HRESULT
	GetConeOrientation as function(byval This as IDirectSound3DBuffer ptr, byval lpvOrientation as LPD3DVECTOR) as HRESULT
	GetConeOutsideVolume as function(byval This as IDirectSound3DBuffer ptr, byval lplConeOutsideVolume as LPLONG) as HRESULT
	GetMaxDistance as function(byval This as IDirectSound3DBuffer ptr, byval lpflMaxDistance as LPD3DVALUE) as HRESULT
	GetMinDistance as function(byval This as IDirectSound3DBuffer ptr, byval lpflMinDistance as LPD3DVALUE) as HRESULT
	GetMode as function(byval This as IDirectSound3DBuffer ptr, byval lpwdMode as LPDWORD) as HRESULT
	GetPosition as function(byval This as IDirectSound3DBuffer ptr, byval lpvPosition as LPD3DVECTOR) as HRESULT
	GetVelocity as function(byval This as IDirectSound3DBuffer ptr, byval lpvVelocity as LPD3DVECTOR) as HRESULT
	SetAllParameters as function(byval This as IDirectSound3DBuffer ptr, byval lpcDs3dBuffer as LPCDS3DBUFFER, byval dwApply as DWORD) as HRESULT
	SetConeAngles as function(byval This as IDirectSound3DBuffer ptr, byval dwInsideConeAngle as DWORD, byval dwOutsideConeAngle as DWORD, byval dwApply as DWORD) as HRESULT
	SetConeOrientation as function(byval This as IDirectSound3DBuffer ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetConeOutsideVolume as function(byval This as IDirectSound3DBuffer ptr, byval lConeOutsideVolume as LONG, byval dwApply as DWORD) as HRESULT
	SetMaxDistance as function(byval This as IDirectSound3DBuffer ptr, byval flMaxDistance as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetMinDistance as function(byval This as IDirectSound3DBuffer ptr, byval flMinDistance as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetMode as function(byval This as IDirectSound3DBuffer ptr, byval dwMode as DWORD, byval dwApply as DWORD) as HRESULT
	SetPosition as function(byval This as IDirectSound3DBuffer ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval dwApply as DWORD) as HRESULT
	SetVelocity as function(byval This as IDirectSound3DBuffer ptr, byval x as D3DVALUE, byval y as D3DVALUE, byval z as D3DVALUE, byval dwApply as DWORD) as HRESULT
end type

#define IDirectSound3DBuffer_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSound3DBuffer_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSound3DBuffer_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSound3DBuffer_GetAllParameters(p, a) (p)->lpVtbl->GetAllParameters(p, a)
#define IDirectSound3DBuffer_GetConeAngles(p, a, b) (p)->lpVtbl->GetConeAngles(p, a, b)
#define IDirectSound3DBuffer_GetConeOrientation(p, a) (p)->lpVtbl->GetConeOrientation(p, a)
#define IDirectSound3DBuffer_GetConeOutsideVolume(p, a) (p)->lpVtbl->GetConeOutsideVolume(p, a)
#define IDirectSound3DBuffer_GetMaxDistance(p, a) (p)->lpVtbl->GetMaxDistance(p, a)
#define IDirectSound3DBuffer_GetMinDistance(p, a) (p)->lpVtbl->GetMinDistance(p, a)
#define IDirectSound3DBuffer_GetMode(p, a) (p)->lpVtbl->GetMode(p, a)
#define IDirectSound3DBuffer_GetPosition(p, a) (p)->lpVtbl->GetPosition(p, a)
#define IDirectSound3DBuffer_GetVelocity(p, a) (p)->lpVtbl->GetVelocity(p, a)
#define IDirectSound3DBuffer_SetAllParameters(p, a, b) (p)->lpVtbl->SetAllParameters(p, a, b)
#define IDirectSound3DBuffer_SetConeAngles(p, a, b, c) (p)->lpVtbl->SetConeAngles(p, a, b, c)
#define IDirectSound3DBuffer_SetConeOrientation(p, a, b, c, d) (p)->lpVtbl->SetConeOrientation(p, a, b, c, d)
#define IDirectSound3DBuffer_SetConeOutsideVolume(p, a, b) (p)->lpVtbl->SetConeOutsideVolume(p, a, b)
#define IDirectSound3DBuffer_SetMaxDistance(p, a, b) (p)->lpVtbl->SetMaxDistance(p, a, b)
#define IDirectSound3DBuffer_SetMinDistance(p, a, b) (p)->lpVtbl->SetMinDistance(p, a, b)
#define IDirectSound3DBuffer_SetMode(p, a, b) (p)->lpVtbl->SetMode(p, a, b)
#define IDirectSound3DBuffer_SetPosition(p, a, b, c, d) (p)->lpVtbl->SetPosition(p, a, b, c, d)
#define IDirectSound3DBuffer_SetVelocity(p, a, b, c, d) (p)->lpVtbl->SetVelocity(p, a, b, c, d)
type IDirectSound3DBuffer8 as IDirectSound3DBuffer
type IDirectSoundFullDuplexVtbl as IDirectSoundFullDuplexVtbl_

type IDirectSoundFullDuplex
	lpVtbl as IDirectSoundFullDuplexVtbl ptr
end type

type IDirectSoundFullDuplexVtbl_
	QueryInterface as function(byval This as IDirectSoundFullDuplex ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IDirectSoundFullDuplex ptr) as ULONG
	Release as function(byval This as IDirectSoundFullDuplex ptr) as ULONG
	Initialize as function(byval This as IDirectSoundFullDuplex ptr, byval pCaptureGuid as LPCGUID, byval pRendererGuid as LPCGUID, byval lpDscBufferDesc as LPCDSCBUFFERDESC, byval lpDsBufferDesc as LPCDSBUFFERDESC, byval hWnd as HWND, byval dwLevel as DWORD, byval lplpDirectSoundCaptureBuffer8 as LPLPDIRECTSOUNDCAPTUREBUFFER8, byval lplpDirectSoundBuffer8 as LPLPDIRECTSOUNDBUFFER8) as HRESULT
end type

#define IDirectSoundFullDuplex_QueryInterface(p, a, b) (p)->lpVtbl->QueryInterface(p, a, b)
#define IDirectSoundFullDuplex_AddRef(p) (p)->lpVtbl->AddRef(p)
#define IDirectSoundFullDuplex_Release(p) (p)->lpVtbl->Release(p)
#define IDirectSoundFullDuplex_Initialize(p, a, b, c, d, e, f, g, h) (p)->lpVtbl->Initialize(p, a, b, c, d, e, f, g, h)

end extern
