''
''
'' dsound -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_dsound_bi__
#define __win_dsound_bi__

#define COM_NO_WINDOWS_H 1
#include once "win/objbase.bi"

#inclib "dsound"
#inclib "uuid"

#ifndef DIRECTSOUND_VERSION
#define DIRECTSOUND_VERSION &h0900
#endif

#ifndef D3DVALUE
type D3DVALUE as single
type LPD3DVALUE as single ptr
#endif

#ifndef D3DVALUE
type D3DCOLOR as DWORD
type LPD3DCOLOR as DWORD ptr
#endif

#ifndef D3DVECTOR
type D3DVECTOR
	x as single
	y as single
	z as single
end type

type LPD3DVECTOR as D3DVECTOR ptr
#endif

#define _FACDS &h878
extern CLSID_DirectSound alias "CLSID_DirectSound" as GUID
extern CLSID_DirectSound8 alias "CLSID_DirectSound8" as GUID
extern CLSID_DirectSoundCapture alias "CLSID_DirectSoundCapture" as GUID
extern CLSID_DirectSoundCapture8 alias "CLSID_DirectSoundCapture8" as GUID
extern CLSID_DirectSoundFullDuplex alias "CLSID_DirectSoundFullDuplex" as GUID
extern DSDEVID_DefaultPlayback alias "DSDEVID_DefaultPlayback" as GUID
extern DSDEVID_DefaultCapture alias "DSDEVID_DefaultCapture" as GUID
extern DSDEVID_DefaultVoicePlayback alias "DSDEVID_DefaultVoicePlayback" as GUID
extern DSDEVID_DefaultVoiceCapture alias "DSDEVID_DefaultVoiceCapture" as GUID

#if DIRECTSOUND_VERSION >= &h0800
#define IDirectSoundCapture8            IDirectSoundCapture
#define IDirectSound3DListener8         IDirectSound3DListener
#define IDirectSound3DBuffer8           IDirectSound3DBuffer
#define IDirectSoundNotify8             IDirectSoundNotify
#define IDirectSoundFXGargle8           IDirectSoundFXGargle
#define IDirectSoundFXChorus8           IDirectSoundFXChorus
#define IDirectSoundFXFlanger8          IDirectSoundFXFlanger
#define IDirectSoundFXEcho8             IDirectSoundFXEcho
#define IDirectSoundFXDistortion8       IDirectSoundFXDistortion
#define IDirectSoundFXCompressor8       IDirectSoundFXCompressor
#define IDirectSoundFXParamEq8          IDirectSoundFXParamEq
#define IDirectSoundFXWavesReverb8      IDirectSoundFXWavesReverb
#define IDirectSoundFXI3DL2Reverb8      IDirectSoundFXI3DL2Reverb
#define IDirectSoundCaptureFXAec8       IDirectSoundCaptureFXAec
#define IDirectSoundCaptureFXNoiseSuppress8 IDirectSoundCaptureFXNoiseSuppress
#define IDirectSoundFullDuplex8         IDirectSoundFullDuplex
#endif

type LPDIRECTSOUND as IDirectSound ptr
type LPDIRECTSOUNDBUFFER as IDirectSoundBuffer ptr
type LPDIRECTSOUND3DLISTENER as IDirectSound3DListener ptr
type LPDIRECTSOUND3DBUFFER as IDirectSound3DBuffer ptr
type LPDIRECTSOUNDCAPTURE as IDirectSoundCapture ptr
type LPDIRECTSOUNDCAPTUREBUFFER as IDirectSoundCaptureBuffer ptr
type LPDIRECTSOUNDNOTIFY as IDirectSoundNotify ptr

#if DIRECTSOUND_VERSION >= &h0800
type LPDIRECTSOUNDFXGARGLE as IDirectSoundFXGargle ptr
type LPDIRECTSOUNDFXCHORUS as IDirectSoundFXChorus ptr
type LPDIRECTSOUNDFXFLANGER as IDirectSoundFXFlanger ptr
type LPDIRECTSOUNDFXECHO as IDirectSoundFXEcho ptr
type LPDIRECTSOUNDFXDISTORTION as IDirectSoundFXDistortion ptr
type LPDIRECTSOUNDFXCOMPRESSOR as IDirectSoundFXCompressor ptr
type LPDIRECTSOUNDFXPARAMEQ as IDirectSoundFXParamEq ptr
type LPDIRECTSOUNDFXWAVESREVERB as IDirectSoundFXWavesReverb ptr
type LPDIRECTSOUNDFXI3DL2REVERB as IDirectSoundFXI3DL2Reverb ptr
type LPDIRECTSOUNDCAPTUREFXAEC as IDirectSoundCaptureFXAec ptr
type LPDIRECTSOUNDCAPTUREFXNOISESUPPRESS as IDirectSoundCaptureFXNoiseSuppress ptr
type LPDIRECTSOUNDFULLDUPLEX as IDirectSoundFullDuplex ptr
type LPDIRECTSOUND8 as IDirectSound8 ptr
type LPDIRECTSOUNDBUFFER8 as IDirectSoundBuffer8 ptr
type LPDIRECTSOUND3DLISTENER8 as IDirectSound3DListener ptr
type LPDIRECTSOUND3DBUFFER8 as IDirectSound3DBuffer ptr
type LPDIRECTSOUNDCAPTURE8 as IDirectSoundCapture ptr
type LPDIRECTSOUNDCAPTUREBUFFER8 as IDirectSoundCaptureBuffer8 ptr
type LPDIRECTSOUNDNOTIFY8 as IDirectSoundNotify ptr
type LPDIRECTSOUNDFXGARGLE8 as IDirectSoundFXGargle ptr
type LPDIRECTSOUNDFXCHORUS8 as IDirectSoundFXChorus ptr
type LPDIRECTSOUNDFXFLANGER8 as IDirectSoundFXFlanger ptr
type LPDIRECTSOUNDFXECHO8 as IDirectSoundFXEcho ptr
type LPDIRECTSOUNDFXDISTORTION8 as IDirectSoundFXDistortion ptr
type LPDIRECTSOUNDFXCOMPRESSOR8 as IDirectSoundFXCompressor ptr
type LPDIRECTSOUNDFXPARAMEQ8 as IDirectSoundFXParamEq ptr
type LPDIRECTSOUNDFXWAVESREVERB8 as IDirectSoundFXWavesReverb ptr
type LPDIRECTSOUNDFXI3DL2REVERB8 as IDirectSoundFXI3DL2Reverb ptr
type LPDIRECTSOUNDCAPTUREFXAEC8 as IDirectSoundCaptureFXAec ptr
type LPDIRECTSOUNDCAPTUREFXNOISESUPPRESS8 as IDirectSoundCaptureFXNoiseSuppress ptr
type LPDIRECTSOUNDFULLDUPLEX8 as IDirectSoundFullDuplex ptr
#endif

#if DIRECTSOUND_VERSION >= &h0800
#define IID_IDirectSoundCapture8            IID_IDirectSoundCapture
#define IID_IDirectSound3DListener8         IID_IDirectSound3DListener
#define IID_IDirectSound3DBuffer8           IID_IDirectSound3DBuffer
#define IID_IDirectSoundNotify8             IID_IDirectSoundNotify
#define IID_IDirectSoundFXGargle8           IID_IDirectSoundFXGargle
#define IID_IDirectSoundFXChorus8           IID_IDirectSoundFXChorus
#define IID_IDirectSoundFXFlanger8          IID_IDirectSoundFXFlanger
#define IID_IDirectSoundFXEcho8             IID_IDirectSoundFXEcho
#define IID_IDirectSoundFXDistortion8       IID_IDirectSoundFXDistortion
#define IID_IDirectSoundFXCompressor8       IID_IDirectSoundFXCompressor
#define IID_IDirectSoundFXParamEq8          IID_IDirectSoundFXParamEq
#define IID_IDirectSoundFXWavesReverb8      IID_IDirectSoundFXWavesReverb
#define IID_IDirectSoundFXI3DL2Reverb8      IID_IDirectSoundFXI3DL2Reverb
#define IID_IDirectSoundCaptureFXAec8       IID_IDirectSoundCaptureFXAec
#define IID_IDirectSoundCaptureFXNoiseSuppress8 IID_IDirectSoundCaptureFXNoiseSuppress
#define IID_IDirectSoundFullDuplex8         IID_IDirectSoundFullDuplex
#endif

#ifndef LPCWAVEFORMATEX
type LPCWAVEFORMATEX as WAVEFORMATEX ptr
#endif
#ifndef LPCGUID
type LPCGUID as GUID ptr
#endif

type LPLPDIRECTSOUND as LPDIRECTSOUND ptr
type LPLPDIRECTSOUNDBUFFER as LPDIRECTSOUNDBUFFER ptr
type LPLPDIRECTSOUND3DLISTENER as LPDIRECTSOUND3DLISTENER ptr
type LPLPDIRECTSOUND3DBUFFER as LPDIRECTSOUND3DBUFFER ptr
type LPLPDIRECTSOUNDCAPTURE as LPDIRECTSOUNDCAPTURE ptr
type LPLPDIRECTSOUNDCAPTUREBUFFER as LPDIRECTSOUNDCAPTUREBUFFER ptr
type LPLPDIRECTSOUNDNOTIFY as LPDIRECTSOUNDNOTIFY ptr

#if DIRECTSOUND_VERSION >= &h0800
type LPLPDIRECTSOUND8 as LPDIRECTSOUND8 ptr
type LPLPDIRECTSOUNDBUFFER8 as LPDIRECTSOUNDBUFFER8 ptr
type LPLPDIRECTSOUNDCAPTURE8 as LPDIRECTSOUNDCAPTURE8 ptr
type LPLPDIRECTSOUNDCAPTUREBUFFER8 as LPDIRECTSOUNDCAPTUREBUFFER8 ptr
#endif

type DSCAPS
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

type LPDSCAPS as DSCAPS ptr
type LPCDSCAPS as DSCAPS ptr

type DSBCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwUnlockTransferRate as DWORD
	dwPlayCpuOverhead as DWORD
end type

type LPDSBCAPS as DSBCAPS ptr
type LPCDSBCAPS as DSBCAPS ptr

#if DIRECTSOUND_VERSION >= &h0800

type DSEFFECTDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidDSFXClass as GUID
	dwReserved1 as DWORD_PTR
	dwReserved2 as DWORD_PTR
end type

type LPDSEFFECTDESC as DSEFFECTDESC ptr
type LPCDSEFFECTDESC as DSEFFECTDESC ptr

#define DSFX_LOCHARDWARE &h00000001
#define DSFX_LOCSOFTWARE &h00000002

enum
	DSFXR_PRESENT
	DSFXR_LOCHARDWARE
	DSFXR_LOCSOFTWARE
	DSFXR_UNALLOCATED
	DSFXR_FAILED
	DSFXR_UNKNOWN
	DSFXR_SENDLOOP
end enum

#endif

type DSCEFFECTDESC
	dwSize as DWORD
	dwFlags as DWORD
	guidDSCFXClass as GUID
	guidDSCFXInstance as GUID
	dwReserved1 as DWORD
	dwReserved2 as DWORD
end type

type LPDSCEFFECTDESC as DSCEFFECTDESC ptr
type LPCDSCEFFECTDESC as DSCEFFECTDESC ptr

#define DSCFX_LOCHARDWARE &h00000001
#define DSCFX_LOCSOFTWARE &h00000002
#define DSCFXR_LOCHARDWARE &h00000010
#define DSCFXR_LOCSOFTWARE &h00000020

type DSBUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
	guid3DAlgorithm as GUID
end type

type LPDSBUFFERDESC as DSBUFFERDESC ptr
type LPCDSBUFFERDESC as DSBUFFERDESC ptr

type DSBUFFERDESC1
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
end type

type LPDSBUFFERDESC1 as DSBUFFERDESC1 ptr
type LPCDSBUFFERDESC1 as DSBUFFERDESC1 ptr

type DS3DBUFFER
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

type LPDS3DBUFFER as DS3DBUFFER ptr
type LPCDS3DBUFFER as DS3DBUFFER ptr

type DS3DLISTENER
	dwSize as DWORD
	vPosition as D3DVECTOR
	vVelocity as D3DVECTOR
	vOrientFront as D3DVECTOR
	vOrientTop as D3DVECTOR
	flDistanceFactor as D3DVALUE
	flRolloffFactor as D3DVALUE
	flDopplerFactor as D3DVALUE
end type

type LPDS3DLISTENER as DS3DLISTENER ptr
type LPCDS3DLISTENER as DS3DLISTENER ptr

type DSCCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwFormats as DWORD
	dwChannels as DWORD
end type

type LPDSCCAPS as DSCCAPS ptr
type LPCDSCCAPS as DSCCAPS ptr

type DSCBUFFERDESC1
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
end type

type LPDSCBUFFERDESC1 as DSCBUFFERDESC1 ptr

type DSCBUFFERDESC
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
	lpwfxFormat as LPWAVEFORMATEX
	dwFXCount as DWORD
	lpDSCFXDesc as LPDSCEFFECTDESC
end type

type LPDSCBUFFERDESC as DSCBUFFERDESC ptr
type LPCDSCBUFFERDESC as DSCBUFFERDESC ptr

type DSCBCAPS
	dwSize as DWORD
	dwFlags as DWORD
	dwBufferBytes as DWORD
	dwReserved as DWORD
end type

type LPDSCBCAPS as DSCBCAPS ptr
type LPCDSCBCAPS as DSCBCAPS ptr

type DSBPOSITIONNOTIFY
	dwOffset as DWORD
	hEventNotify as HANDLE
end type

type LPDSBPOSITIONNOTIFY as DSBPOSITIONNOTIFY ptr
type LPCDSBPOSITIONNOTIFY as DSBPOSITIONNOTIFY ptr

#ifndef UNICODE
type LPDSENUMCALLBACKA as function (byval as LPGUID, byval as LPCSTR, byval as LPCSTR, byval as LPVOID) as BOOL
declare function DirectSoundEnumerate alias "DirectSoundEnumerateA" (byval pDSEnumCallback as LPDSENUMCALLBACKA, byval pContext as LPVOID) as HRESULT
declare function DirectSoundCaptureEnumerate alias "DirectSoundCaptureEnumerateA" (byval pDSEnumCallback as LPDSENUMCALLBACKA, byval pContext as LPVOID) as HRESULT
#else
type LPDSENUMCALLBACKW as function (byval as LPGUID, byval as LPCWSTR, byval as LPCWSTR, byval as LPVOID) as BOOL
declare function DirectSoundCaptureEnumerate alias "DirectSoundCaptureEnumerateW" (byval pDSEnumCallback as LPDSENUMCALLBACKW, byval pContext as LPVOID) as HRESULT
declare function DirectSoundEnumerate alias "DirectSoundEnumerateW" (byval pDSEnumCallback as LPDSENUMCALLBACKW, byval pContext as LPVOID) as HRESULT
#endif

declare function DirectSoundCreate alias "DirectSoundCreate" (byval pcGuidDevice as LPCGUID, byval ppDS as LPDIRECTSOUND ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundCaptureCreate alias "DirectSoundCaptureCreate" (byval pcGuidDevice as LPCGUID, byval ppDSC as LPDIRECTSOUNDCAPTURE ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT

#if DIRECTSOUND_VERSION >= &h0800
declare function DirectSoundCreate8 alias "DirectSoundCreate8" (byval pcGuidDevice as LPCGUID, byval ppDS8 as LPDIRECTSOUND8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundCaptureCreate8 alias "DirectSoundCaptureCreate8" (byval pcGuidDevice as LPCGUID, byval ppDSC8 as LPDIRECTSOUNDCAPTURE8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function DirectSoundFullDuplexCreate alias "DirectSoundFullDuplexCreate" (byval pcGuidCaptureDevice as LPCGUID, byval pcGuidRenderDevice as LPCGUID, byval pcDSCBufferDesc as LPCDSCBUFFERDESC, byval pcDSBufferDesc as LPCDSBUFFERDESC, byval hWnd as HWND, byval dwLevel as DWORD, byval ppDSFD as LPDIRECTSOUNDFULLDUPLEX ptr, byval ppDSCBuffer8 as LPDIRECTSOUNDCAPTUREBUFFER8 ptr, byval ppDSBuffer8 as LPDIRECTSOUNDBUFFER8 ptr, byval pUnkOuter as LPUNKNOWN) as HRESULT
declare function GetDeviceID alias "GetDeviceID" (byval pGuidSrc as LPCGUID, byval pGuidDest as LPGUID) as HRESULT
#endif

#ifndef IUnknown_QueryInterface
#define IUnknown_QueryInterface(p,a,b)  (p)->lpVtbl->QueryInterface(p,a,b)
#define IUnknown_AddRef(p)              (p)->lpVtbl->AddRef(p)
#define IUnknown_Release(p)             (p)->lpVtbl->Release(p)
#endif

type REFERENCE_TIME as LONGLONG
type LPREFERENCE_TIME as REFERENCE_TIME ptr

#ifndef IReferenceClock
extern IID_IReferenceClock alias "IID_IReferenceClock" as GUID

type IReferenceClockVtbl_ as IReferenceClockVtbl

type IReferenceClock
	lpVtbl as IReferenceClockVtbl_ ptr
end type

type IReferenceClockVtbl
	QueryInterface as function (byval as IReferenceClock ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IReferenceClock ptr) as ULONG
	Release as function (byval as IReferenceClock ptr) as ULONG
	GetTime as function (byval as IReferenceClock ptr, byval as REFERENCE_TIME ptr) as HRESULT
	AdviseTime as function (byval as IReferenceClock ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HANDLE, byval as LPDWORD) as HRESULT
	AdvisePeriodic as function (byval as IReferenceClock ptr, byval as REFERENCE_TIME, byval as REFERENCE_TIME, byval as HANDLE, byval as LPDWORD) as HRESULT
	Unadvise as function (byval as IReferenceClock ptr, byval as DWORD) as HRESULT
end type

#ifndef IReferenceClock_QueryInterface
#define IReferenceClock_QueryInterface(p,a,b)      IUnknown_QueryInterface(p,a,b)
#define IReferenceClock_AddRef(p)                  IUnknown_AddRef(p)
#define IReferenceClock_Release(p)                 IUnknown_Release(p)
#define IReferenceClock_GetTime(p,a)               (p)->lpVtbl->GetTime(p,a)
#define IReferenceClock_AdviseTime(p,a,b,c,d)      (p)->lpVtbl->AdviseTime(p,a,b,c,d)
#define IReferenceClock_AdvisePeriodic(p,a,b,c,d)  (p)->lpVtbl->AdvisePeriodic(p,a,b,c,d)
#define IReferenceClock_Unadvise(p,a)              (p)->lpVtbl->Unadvise(p,a)
#endif
#endif

extern IID_IDirectSound alias "IID_IDirectSound" as GUID

type IDirectSoundVtbl_ as IDirectSoundVtbl

type IDirectSound
	lpVtbl as IDirectSoundVtbl_ ptr
end type

type IDirectSoundVtbl
	QueryInterface as function (byval as IDirectSound ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSound ptr) as ULONG
	Release as function (byval as IDirectSound ptr) as ULONG
	CreateSoundBuffer as function (byval as IDirectSound ptr, byval as LPCDSBUFFERDESC, byval as LPDIRECTSOUNDBUFFER ptr, byval as LPUNKNOWN) as HRESULT
	GetCaps as function (byval as IDirectSound ptr, byval as LPDSCAPS) as HRESULT
	DuplicateSoundBuffer as function (byval as IDirectSound ptr, byval as LPDIRECTSOUNDBUFFER, byval as LPDIRECTSOUNDBUFFER ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectSound ptr, byval as HWND, byval as DWORD) as HRESULT
	Compact as function (byval as IDirectSound ptr) as HRESULT
	GetSpeakerConfig as function (byval as IDirectSound ptr, byval as LPDWORD) as HRESULT
	SetSpeakerConfig as function (byval as IDirectSound ptr, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectSound ptr, byval as LPCGUID) as HRESULT
end type

#define IDirectSound_QueryInterface(p,a,b)       IUnknown_QueryInterface(p,a,b)
#define IDirectSound_AddRef(p)                   IUnknown_AddRef(p)
#define IDirectSound_Release(p)                  IUnknown_Release(p)
#define IDirectSound_CreateSoundBuffer(p,a,b,c)  (p)->lpVtbl->CreateSoundBuffer(p,a,b,c)
#define IDirectSound_GetCaps(p,a)                (p)->lpVtbl->GetCaps(p,a)
#define IDirectSound_DuplicateSoundBuffer(p,a,b) (p)->lpVtbl->DuplicateSoundBuffer(p,a,b)
#define IDirectSound_SetCooperativeLevel(p,a,b)  (p)->lpVtbl->SetCooperativeLevel(p,a,b)
#define IDirectSound_Compact(p)                  (p)->lpVtbl->Compact(p)
#define IDirectSound_GetSpeakerConfig(p,a)       (p)->lpVtbl->GetSpeakerConfig(p,a)
#define IDirectSound_SetSpeakerConfig(p,b)       (p)->lpVtbl->SetSpeakerConfig(p,b)
#define IDirectSound_Initialize(p,a)             (p)->lpVtbl->Initialize(p,a)

#if DIRECTSOUND_VERSION >= &h0800
extern IID_IDirectSound8 alias "IID_IDirectSound8" as GUID

type IDirectSound8Vtbl_ as IDirectSound8Vtbl

type IDirectSound8
	lpVtbl as IDirectSound8Vtbl_ ptr
end type

type IDirectSound8Vtbl
	QueryInterface as function (byval as IDirectSound8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSound8 ptr) as ULONG
	Release as function (byval as IDirectSound8 ptr) as ULONG
	CreateSoundBuffer as function (byval as IDirectSound8 ptr, byval as LPCDSBUFFERDESC, byval as LPDIRECTSOUNDBUFFER ptr, byval as LPUNKNOWN) as HRESULT
	GetCaps as function (byval as IDirectSound8 ptr, byval as LPDSCAPS) as HRESULT
	DuplicateSoundBuffer as function (byval as IDirectSound8 ptr, byval as LPDIRECTSOUNDBUFFER, byval as LPDIRECTSOUNDBUFFER ptr) as HRESULT
	SetCooperativeLevel as function (byval as IDirectSound8 ptr, byval as HWND, byval as DWORD) as HRESULT
	Compact as function (byval as IDirectSound8 ptr) as HRESULT
	GetSpeakerConfig as function (byval as IDirectSound8 ptr, byval as LPDWORD) as HRESULT
	SetSpeakerConfig as function (byval as IDirectSound8 ptr, byval as DWORD) as HRESULT
	Initialize as function (byval as IDirectSound8 ptr, byval as LPCGUID) as HRESULT
	VerifyCertification as function (byval as IDirectSound8 ptr, byval as LPDWORD) as HRESULT
end type

#define IDirectSound8_QueryInterface(p,a,b)       IDirectSound_QueryInterface(p,a,b)
#define IDirectSound8_AddRef(p)                   IDirectSound_AddRef(p)
#define IDirectSound8_Release(p)                  IDirectSound_Release(p)
#define IDirectSound8_CreateSoundBuffer(p,a,b,c)  IDirectSound_CreateSoundBuffer(p,a,b,c)
#define IDirectSound8_GetCaps(p,a)                IDirectSound_GetCaps(p,a)
#define IDirectSound8_DuplicateSoundBuffer(p,a,b) IDirectSound_DuplicateSoundBuffer(p,a,b)
#define IDirectSound8_SetCooperativeLevel(p,a,b)  IDirectSound_SetCooperativeLevel(p,a,b)
#define IDirectSound8_Compact(p)                  IDirectSound_Compact(p)
#define IDirectSound8_GetSpeakerConfig(p,a)       IDirectSound_GetSpeakerConfig(p,a)
#define IDirectSound8_SetSpeakerConfig(p,a)       IDirectSound_SetSpeakerConfig(p,a)
#define IDirectSound8_Initialize(p,a)             IDirectSound_Initialize(p,a)
#define IDirectSound8_VerifyCertification(p,a)           (p)->lpVtbl->VerifyCertification(p,a)
#endif

extern IID_IDirectSoundBuffer alias "IID_IDirectSoundBuffer" as GUID

type IDirectSoundBufferVtbl_ as IDirectSoundBufferVtbl

type IDirectSoundBuffer
	lpVtbl as IDirectSoundBufferVtbl_ ptr
end type

type IDirectSoundBufferVtbl
	QueryInterface as function (byval as IDirectSoundBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundBuffer ptr) as ULONG
	Release as function (byval as IDirectSoundBuffer ptr) as ULONG
	GetCaps as function (byval as IDirectSoundBuffer ptr, byval as LPDSBCAPS) as HRESULT
	GetCurrentPosition as function (byval as IDirectSoundBuffer ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetFormat as function (byval as IDirectSoundBuffer ptr, byval as LPWAVEFORMATEX, byval as DWORD, byval as LPDWORD) as HRESULT
	GetVolume as function (byval as IDirectSoundBuffer ptr, byval as LPLONG) as HRESULT
	GetPan as function (byval as IDirectSoundBuffer ptr, byval as LPLONG) as HRESULT
	GetFrequency as function (byval as IDirectSoundBuffer ptr, byval as LPDWORD) as HRESULT
	GetStatus as function (byval as IDirectSoundBuffer ptr, byval as LPDWORD) as HRESULT
	Initialize as function (byval as IDirectSoundBuffer ptr, byval as LPDIRECTSOUND, byval as LPCDSBUFFERDESC) as HRESULT
	Lock as function (byval as IDirectSoundBuffer ptr, byval as DWORD, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD, byval as LPVOID ptr, byval as LPDWORD, byval as DWORD) as HRESULT
	Play as function (byval as IDirectSoundBuffer ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetCurrentPosition as function (byval as IDirectSoundBuffer ptr, byval as DWORD) as HRESULT
	SetFormat as function (byval as IDirectSoundBuffer ptr, byval as LPCWAVEFORMATEX) as HRESULT
	SetVolume as function (byval as IDirectSoundBuffer ptr, byval as LONG) as HRESULT
	SetPan as function (byval as IDirectSoundBuffer ptr, byval as LONG) as HRESULT
	SetFrequency as function (byval as IDirectSoundBuffer ptr, byval as DWORD) as HRESULT
	Stop as function (byval as IDirectSoundBuffer ptr) as HRESULT
	Unlock as function (byval as IDirectSoundBuffer ptr, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	Restore as function (byval as IDirectSoundBuffer ptr) as HRESULT
end type

#define IDirectSoundBuffer_QueryInterface(p,a,b)        IUnknown_QueryInterface(p,a,b)
#define IDirectSoundBuffer_AddRef(p)                    IUnknown_AddRef(p)
#define IDirectSoundBuffer_Release(p)                   IUnknown_Release(p)
#define IDirectSoundBuffer_GetCaps(p,a)                 (p)->lpVtbl->GetCaps(p,a)
#define IDirectSoundBuffer_GetCurrentPosition(p,a,b)    (p)->lpVtbl->GetCurrentPosition(p,a,b)
#define IDirectSoundBuffer_GetFormat(p,a,b,c)           (p)->lpVtbl->GetFormat(p,a,b,c)
#define IDirectSoundBuffer_GetVolume(p,a)               (p)->lpVtbl->GetVolume(p,a)
#define IDirectSoundBuffer_GetPan(p,a)                  (p)->lpVtbl->GetPan(p,a)
#define IDirectSoundBuffer_GetFrequency(p,a)            (p)->lpVtbl->GetFrequency(p,a)
#define IDirectSoundBuffer_GetStatus(p,a)               (p)->lpVtbl->GetStatus(p,a)
#define IDirectSoundBuffer_Initialize(p,a,b)            (p)->lpVtbl->Initialize(p,a,b)
#define IDirectSoundBuffer_Lock(p,a,b,c,d,e,f,g)        (p)->lpVtbl->Lock(p,a,b,c,d,e,f,g)
#define IDirectSoundBuffer_Play(p,a,b,c)                (p)->lpVtbl->Play(p,a,b,c)
#define IDirectSoundBuffer_SetCurrentPosition(p,a)      (p)->lpVtbl->SetCurrentPosition(p,a)
#define IDirectSoundBuffer_SetFormat(p,a)               (p)->lpVtbl->SetFormat(p,a)
#define IDirectSoundBuffer_SetVolume(p,a)               (p)->lpVtbl->SetVolume(p,a)
#define IDirectSoundBuffer_SetPan(p,a)                  (p)->lpVtbl->SetPan(p,a)
#define IDirectSoundBuffer_SetFrequency(p,a)            (p)->lpVtbl->SetFrequency(p,a)
#define IDirectSoundBuffer_Stop(p)                      (p)->lpVtbl->Stop(p)
#define IDirectSoundBuffer_Unlock(p,a,b,c,d)            (p)->lpVtbl->Unlock(p,a,b,c,d)
#define IDirectSoundBuffer_Restore(p)                   (p)->lpVtbl->Restore(p)

#if DIRECTSOUND_VERSION >= &h0800
extern IID_IDirectSoundBuffer8 alias "IID_IDirectSoundBuffer8" as GUID

type IDirectSoundBuffer8Vtbl_ as IDirectSoundBuffer8Vtbl

type IDirectSoundBuffer8
	lpVtbl as IDirectSoundBuffer8Vtbl_ ptr
end type

type IDirectSoundBuffer8Vtbl
	QueryInterface as function (byval as IDirectSoundBuffer8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundBuffer8 ptr) as ULONG
	Release as function (byval as IDirectSoundBuffer8 ptr) as ULONG
	GetCaps as function (byval as IDirectSoundBuffer8 ptr, byval as LPDSBCAPS) as HRESULT
	GetCurrentPosition as function (byval as IDirectSoundBuffer8 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetFormat as function (byval as IDirectSoundBuffer8 ptr, byval as LPWAVEFORMATEX, byval as DWORD, byval as LPDWORD) as HRESULT
	GetVolume as function (byval as IDirectSoundBuffer8 ptr, byval as LPLONG) as HRESULT
	GetPan as function (byval as IDirectSoundBuffer8 ptr, byval as LPLONG) as HRESULT
	GetFrequency as function (byval as IDirectSoundBuffer8 ptr, byval as LPDWORD) as HRESULT
	GetStatus as function (byval as IDirectSoundBuffer8 ptr, byval as LPDWORD) as HRESULT
	Initialize as function (byval as IDirectSoundBuffer8 ptr, byval as LPDIRECTSOUND, byval as LPCDSBUFFERDESC) as HRESULT
	Lock as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD, byval as LPVOID ptr, byval as LPDWORD, byval as DWORD) as HRESULT
	Play as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetCurrentPosition as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD) as HRESULT
	SetFormat as function (byval as IDirectSoundBuffer8 ptr, byval as LPCWAVEFORMATEX) as HRESULT
	SetVolume as function (byval as IDirectSoundBuffer8 ptr, byval as LONG) as HRESULT
	SetPan as function (byval as IDirectSoundBuffer8 ptr, byval as LONG) as HRESULT
	SetFrequency as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD) as HRESULT
	Stop as function (byval as IDirectSoundBuffer8 ptr) as HRESULT
	Unlock as function (byval as IDirectSoundBuffer8 ptr, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	Restore as function (byval as IDirectSoundBuffer8 ptr) as HRESULT
	SetFX as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD, byval as LPDSEFFECTDESC, byval as LPDWORD) as HRESULT
	AcquireResources as function (byval as IDirectSoundBuffer8 ptr, byval as DWORD, byval as DWORD, byval as LPDWORD) as HRESULT
	GetObjectInPath as function (byval as IDirectSoundBuffer8 ptr, byval as GUID ptr, byval as DWORD, byval as GUID ptr, byval as LPVOID ptr) as HRESULT
end type

extern GUID_All_Objects alias "GUID_All_Objects" as GUID

#define IDirectSoundBuffer8_QueryInterface(p,a,b)           IUnknown_QueryInterface(p,a,b)
#define IDirectSoundBuffer8_AddRef(p)                       IUnknown_AddRef(p)
#define IDirectSoundBuffer8_Release(p)                      IUnknown_Release(p)
#define IDirectSoundBuffer8_GetCaps(p,a)                    IDirectSoundBuffer_GetCaps(p,a)
#define IDirectSoundBuffer8_GetCurrentPosition(p,a,b)       IDirectSoundBuffer_GetCurrentPosition(p,a,b)
#define IDirectSoundBuffer8_GetFormat(p,a,b,c)              IDirectSoundBuffer_GetFormat(p,a,b,c)
#define IDirectSoundBuffer8_GetVolume(p,a)                  IDirectSoundBuffer_GetVolume(p,a)
#define IDirectSoundBuffer8_GetPan(p,a)                     IDirectSoundBuffer_GetPan(p,a)
#define IDirectSoundBuffer8_GetFrequency(p,a)               IDirectSoundBuffer_GetFrequency(p,a)
#define IDirectSoundBuffer8_GetStatus(p,a)                  IDirectSoundBuffer_GetStatus(p,a)
#define IDirectSoundBuffer8_Initialize(p,a,b)               IDirectSoundBuffer_Initialize(p,a,b)
#define IDirectSoundBuffer8_Lock(p,a,b,c,d,e,f,g)           IDirectSoundBuffer_Lock(p,a,b,c,d,e,f,g)
#define IDirectSoundBuffer8_Play(p,a,b,c)                   IDirectSoundBuffer_Play(p,a,b,c)
#define IDirectSoundBuffer8_SetCurrentPosition(p,a)         IDirectSoundBuffer_SetCurrentPosition(p,a)
#define IDirectSoundBuffer8_SetFormat(p,a)                  IDirectSoundBuffer_SetFormat(p,a)
#define IDirectSoundBuffer8_SetVolume(p,a)                  IDirectSoundBuffer_SetVolume(p,a)
#define IDirectSoundBuffer8_SetPan(p,a)                     IDirectSoundBuffer_SetPan(p,a)
#define IDirectSoundBuffer8_SetFrequency(p,a)               IDirectSoundBuffer_SetFrequency(p,a)
#define IDirectSoundBuffer8_Stop(p)                         IDirectSoundBuffer_Stop(p)
#define IDirectSoundBuffer8_Unlock(p,a,b,c,d)               IDirectSoundBuffer_Unlock(p,a,b,c,d)
#define IDirectSoundBuffer8_Restore(p)                      IDirectSoundBuffer_Restore(p)
#define IDirectSoundBuffer8_SetFX(p,a,b,c)                  (p)->lpVtbl->SetFX(p,a,b,c)
#define IDirectSoundBuffer8_AcquireResources(p,a,b,c)       (p)->lpVtbl->AcquireResources(p,a,b,c)
#define IDirectSoundBuffer8_GetObjectInPath(p,a,b,c,d)      (p)->lpVtbl->GetObjectInPath(p,a,b,c,d)
#endif

extern IID_IDirectSound3DListener alias "IID_IDirectSound3DListener" as GUID

type IDirectSound3DListenerVtbl_ as IDirectSound3DListenerVtbl

type IDirectSound3DListener
	lpVtbl as IDirectSound3DListenerVtbl_ ptr
end type

type IDirectSound3DListenerVtbl
	QueryInterface as function (byval as IDirectSound3DListener ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSound3DListener ptr) as ULONG
	Release as function (byval as IDirectSound3DListener ptr) as ULONG
	GetAllParameters as function (byval as IDirectSound3DListener ptr, byval as LPDS3DLISTENER) as HRESULT
	GetDistanceFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE ptr) as HRESULT
	GetDopplerFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE ptr) as HRESULT
	GetOrientation as function (byval as IDirectSound3DListener ptr, byval as D3DVECTOR ptr, byval as D3DVECTOR ptr) as HRESULT
	GetPosition as function (byval as IDirectSound3DListener ptr, byval as D3DVECTOR ptr) as HRESULT
	GetRolloffFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE ptr) as HRESULT
	GetVelocity as function (byval as IDirectSound3DListener ptr, byval as D3DVECTOR ptr) as HRESULT
	SetAllParameters as function (byval as IDirectSound3DListener ptr, byval as LPCDS3DLISTENER, byval as DWORD) as HRESULT
	SetDistanceFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetDopplerFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetOrientation as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetPosition as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetRolloffFactor as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetVelocity as function (byval as IDirectSound3DListener ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	CommitDeferredSettings as function (byval as IDirectSound3DListener ptr) as HRESULT
end type

#define IDirectSound3DListener_QueryInterface(p,a,b)            IUnknown_QueryInterface(p,a,b)
#define IDirectSound3DListener_AddRef(p)                        IUnknown_AddRef(p)
#define IDirectSound3DListener_Release(p)                       IUnknown_Release(p)
#define IDirectSound3DListener_GetAllParameters(p,a)            (p)->lpVtbl->GetAllParameters(p,a)
#define IDirectSound3DListener_GetDistanceFactor(p,a)           (p)->lpVtbl->GetDistanceFactor(p,a)
#define IDirectSound3DListener_GetDopplerFactor(p,a)            (p)->lpVtbl->GetDopplerFactor(p,a)
#define IDirectSound3DListener_GetOrientation(p,a,b)            (p)->lpVtbl->GetOrientation(p,a,b)
#define IDirectSound3DListener_GetPosition(p,a)                 (p)->lpVtbl->GetPosition(p,a)
#define IDirectSound3DListener_GetRolloffFactor(p,a)            (p)->lpVtbl->GetRolloffFactor(p,a)
#define IDirectSound3DListener_GetVelocity(p,a)                 (p)->lpVtbl->GetVelocity(p,a)
#define IDirectSound3DListener_SetAllParameters(p,a,b)          (p)->lpVtbl->SetAllParameters(p,a,b)
#define IDirectSound3DListener_SetDistanceFactor(p,a,b)         (p)->lpVtbl->SetDistanceFactor(p,a,b)
#define IDirectSound3DListener_SetDopplerFactor(p,a,b)          (p)->lpVtbl->SetDopplerFactor(p,a,b)
#define IDirectSound3DListener_SetOrientation(p,a,b,c,d,e,f,g)  (p)->lpVtbl->SetOrientation(p,a,b,c,d,e,f,g)
#define IDirectSound3DListener_SetPosition(p,a,b,c,d)           (p)->lpVtbl->SetPosition(p,a,b,c,d)
#define IDirectSound3DListener_SetRolloffFactor(p,a,b)          (p)->lpVtbl->SetRolloffFactor(p,a,b)
#define IDirectSound3DListener_SetVelocity(p,a,b,c,d)           (p)->lpVtbl->SetVelocity(p,a,b,c,d)
#define IDirectSound3DListener_CommitDeferredSettings(p)        (p)->lpVtbl->CommitDeferredSettings(p)

extern IID_IDirectSound3DBuffer alias "IID_IDirectSound3DBuffer" as GUID

type IDirectSound3DBufferVtbl_ as IDirectSound3DBufferVtbl

type IDirectSound3DBuffer
	lpVtbl as IDirectSound3DBufferVtbl_ ptr
end type

type IDirectSound3DBufferVtbl
	QueryInterface as function (byval as IDirectSound3DBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSound3DBuffer ptr) as ULONG
	Release as function (byval as IDirectSound3DBuffer ptr) as ULONG
	GetAllParameters as function (byval as IDirectSound3DBuffer ptr, byval as LPDS3DBUFFER) as HRESULT
	GetConeAngles as function (byval as IDirectSound3DBuffer ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetConeOrientation as function (byval as IDirectSound3DBuffer ptr, byval as D3DVECTOR ptr) as HRESULT
	GetConeOutsideVolume as function (byval as IDirectSound3DBuffer ptr, byval as LPLONG) as HRESULT
	GetMaxDistance as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE ptr) as HRESULT
	GetMinDistance as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE ptr) as HRESULT
	GetMode as function (byval as IDirectSound3DBuffer ptr, byval as LPDWORD) as HRESULT
	GetPosition as function (byval as IDirectSound3DBuffer ptr, byval as D3DVECTOR ptr) as HRESULT
	GetVelocity as function (byval as IDirectSound3DBuffer ptr, byval as D3DVECTOR ptr) as HRESULT
	SetAllParameters as function (byval as IDirectSound3DBuffer ptr, byval as LPCDS3DBUFFER, byval as DWORD) as HRESULT
	SetConeAngles as function (byval as IDirectSound3DBuffer ptr, byval as DWORD, byval as DWORD, byval as DWORD) as HRESULT
	SetConeOrientation as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetConeOutsideVolume as function (byval as IDirectSound3DBuffer ptr, byval as LONG, byval as DWORD) as HRESULT
	SetMaxDistance as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetMinDistance as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetMode as function (byval as IDirectSound3DBuffer ptr, byval as DWORD, byval as DWORD) as HRESULT
	SetPosition as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
	SetVelocity as function (byval as IDirectSound3DBuffer ptr, byval as D3DVALUE, byval as D3DVALUE, byval as D3DVALUE, byval as DWORD) as HRESULT
end type

#define IDirectSound3DBuffer_QueryInterface(p,a,b)          IUnknown_QueryInterface(p,a,b)
#define IDirectSound3DBuffer_AddRef(p)                      IUnknown_AddRef(p)
#define IDirectSound3DBuffer_Release(p)                     IUnknown_Release(p)
#define IDirectSound3DBuffer_GetAllParameters(p,a)          (p)->lpVtbl->GetAllParameters(p,a)
#define IDirectSound3DBuffer_GetConeAngles(p,a,b)           (p)->lpVtbl->GetConeAngles(p,a,b)
#define IDirectSound3DBuffer_GetConeOrientation(p,a)        (p)->lpVtbl->GetConeOrientation(p,a)
#define IDirectSound3DBuffer_GetConeOutsideVolume(p,a)      (p)->lpVtbl->GetConeOutsideVolume(p,a)
#define IDirectSound3DBuffer_GetPosition(p,a)               (p)->lpVtbl->GetPosition(p,a)
#define IDirectSound3DBuffer_GetMinDistance(p,a)            (p)->lpVtbl->GetMinDistance(p,a)
#define IDirectSound3DBuffer_GetMaxDistance(p,a)            (p)->lpVtbl->GetMaxDistance(p,a)
#define IDirectSound3DBuffer_GetMode(p,a)                   (p)->lpVtbl->GetMode(p,a)
#define IDirectSound3DBuffer_GetVelocity(p,a)               (p)->lpVtbl->GetVelocity(p,a)
#define IDirectSound3DBuffer_SetAllParameters(p,a,b)        (p)->lpVtbl->SetAllParameters(p,a,b)
#define IDirectSound3DBuffer_SetConeAngles(p,a,b,c)         (p)->lpVtbl->SetConeAngles(p,a,b,c)
#define IDirectSound3DBuffer_SetConeOrientation(p,a,b,c,d)  (p)->lpVtbl->SetConeOrientation(p,a,b,c,d)
#define IDirectSound3DBuffer_SetConeOutsideVolume(p,a,b)    (p)->lpVtbl->SetConeOutsideVolume(p,a,b)
#define IDirectSound3DBuffer_SetPosition(p,a,b,c,d)         (p)->lpVtbl->SetPosition(p,a,b,c,d)
#define IDirectSound3DBuffer_SetMinDistance(p,a,b)          (p)->lpVtbl->SetMinDistance(p,a,b)
#define IDirectSound3DBuffer_SetMaxDistance(p,a,b)          (p)->lpVtbl->SetMaxDistance(p,a,b)
#define IDirectSound3DBuffer_SetMode(p,a,b)                 (p)->lpVtbl->SetMode(p,a,b)
#define IDirectSound3DBuffer_SetVelocity(p,a,b,c,d)         (p)->lpVtbl->SetVelocity(p,a,b,c,d)

extern IID_IDirectSoundCapture alias "IID_IDirectSoundCapture" as GUID

type IDirectSoundCaptureVtbl_ as IDirectSoundCaptureVtbl

type IDirectSoundCapture
	lpVtbl as IDirectSoundCaptureVtbl_ ptr
end type

type IDirectSoundCaptureVtbl
	QueryInterface as function (byval as IDirectSoundCapture ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundCapture ptr) as ULONG
	Release as function (byval as IDirectSoundCapture ptr) as ULONG
	CreateCaptureBuffer as function (byval as IDirectSoundCapture ptr, byval as LPCDSCBUFFERDESC, byval as LPDIRECTSOUNDCAPTUREBUFFER ptr, byval as LPUNKNOWN) as HRESULT
	GetCaps as function (byval as IDirectSoundCapture ptr, byval as LPDSCCAPS) as HRESULT
	Initialize as function (byval as IDirectSoundCapture ptr, byval as LPCGUID) as HRESULT
end type

#define IDirectSoundCapture_QueryInterface(p,a,b)           IUnknown_QueryInterface(p,a,b)
#define IDirectSoundCapture_AddRef(p)                       IUnknown_AddRef(p)
#define IDirectSoundCapture_Release(p)                      IUnknown_Release(p)
#define IDirectSoundCapture_CreateCaptureBuffer(p,a,b,c)    (p)->lpVtbl->CreateCaptureBuffer(p,a,b,c)
#define IDirectSoundCapture_GetCaps(p,a)                    (p)->lpVtbl->GetCaps(p,a)
#define IDirectSoundCapture_Initialize(p,a)                 (p)->lpVtbl->Initialize(p,a)

extern IID_IDirectSoundCaptureBuffer alias "IID_IDirectSoundCaptureBuffer" as GUID

type IDirectSoundCaptureBufferVtbl_ as IDirectSoundCaptureBufferVtbl

type IDirectSoundCaptureBuffer
	lpVtbl as IDirectSoundCaptureBufferVtbl_ ptr
end type

type IDirectSoundCaptureBufferVtbl
	QueryInterface as function (byval as IDirectSoundCaptureBuffer ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundCaptureBuffer ptr) as ULONG
	Release as function (byval as IDirectSoundCaptureBuffer ptr) as ULONG
	GetCaps as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPDSCBCAPS) as HRESULT
	GetCurrentPosition as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetFormat as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPWAVEFORMATEX, byval as DWORD, byval as LPDWORD) as HRESULT
	GetStatus as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPDWORD) as HRESULT
	Initialize as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPDIRECTSOUNDCAPTURE, byval as LPCDSCBUFFERDESC) as HRESULT
	Lock as function (byval as IDirectSoundCaptureBuffer ptr, byval as DWORD, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD, byval as LPVOID ptr, byval as LPDWORD, byval as DWORD) as HRESULT
	Start as function (byval as IDirectSoundCaptureBuffer ptr, byval as DWORD) as HRESULT
	Stop as function (byval as IDirectSoundCaptureBuffer ptr) as HRESULT
	Unlock as function (byval as IDirectSoundCaptureBuffer ptr, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
end type

#define IDirectSoundCaptureBuffer_QueryInterface(p,a,b)         IUnknown_QueryInterface(p,a,b)
#define IDirectSoundCaptureBuffer_AddRef(p)                     IUnknown_AddRef(p)
#define IDirectSoundCaptureBuffer_Release(p)                    IUnknown_Release(p)
#define IDirectSoundCaptureBuffer_GetCaps(p,a)                  (p)->lpVtbl->GetCaps(p,a)
#define IDirectSoundCaptureBuffer_GetCurrentPosition(p,a,b)     (p)->lpVtbl->GetCurrentPosition(p,a,b)
#define IDirectSoundCaptureBuffer_GetFormat(p,a,b,c)            (p)->lpVtbl->GetFormat(p,a,b,c)
#define IDirectSoundCaptureBuffer_GetStatus(p,a)                (p)->lpVtbl->GetStatus(p,a)
#define IDirectSoundCaptureBuffer_Initialize(p,a,b)             (p)->lpVtbl->Initialize(p,a,b)
#define IDirectSoundCaptureBuffer_Lock(p,a,b,c,d,e,f,g)         (p)->lpVtbl->Lock(p,a,b,c,d,e,f,g)
#define IDirectSoundCaptureBuffer_Start(p,a)                    (p)->lpVtbl->Start(p,a)
#define IDirectSoundCaptureBuffer_Stop(p)                       (p)->lpVtbl->Stop(p)
#define IDirectSoundCaptureBuffer_Unlock(p,a,b,c,d)             (p)->lpVtbl->Unlock(p,a,b,c,d)

#if DIRECTSOUND_VERSION >= &h0800
extern IID_IDirectSoundCaptureBuffer8 alias "IID_IDirectSoundCaptureBuffer8" as GUID

type IDirectSoundCaptureBuffer8Vtbl_ as IDirectSoundCaptureBuffer8Vtbl

type IDirectSoundCaptureBuffer8
	lpVtbl as IDirectSoundCaptureBuffer8Vtbl_ ptr
end type

type IDirectSoundCaptureBuffer8Vtbl
	QueryInterface as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundCaptureBuffer8 ptr) as ULONG
	Release as function (byval as IDirectSoundCaptureBuffer8 ptr) as ULONG
	GetCaps as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPDSCBCAPS) as HRESULT
	GetCurrentPosition as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPDWORD, byval as LPDWORD) as HRESULT
	GetFormat as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPWAVEFORMATEX, byval as DWORD, byval as LPDWORD) as HRESULT
	GetStatus as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPDWORD) as HRESULT
	Initialize as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPDIRECTSOUNDCAPTURE, byval as LPCDSCBUFFERDESC) as HRESULT
	Lock as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as DWORD, byval as DWORD, byval as LPVOID ptr, byval as LPDWORD, byval as LPVOID ptr, byval as LPDWORD, byval as DWORD) as HRESULT
	Start as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as DWORD) as HRESULT
	Stop as function (byval as IDirectSoundCaptureBuffer8 ptr) as HRESULT
	Unlock as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as LPVOID, byval as DWORD, byval as LPVOID, byval as DWORD) as HRESULT
	GetObjectInPath as function (byval as IDirectSoundCaptureBuffer8 ptr, byval as GUID ptr, byval as DWORD, byval as GUID ptr, byval as LPVOID ptr) as HRESULT
	GetFXStatus as function (byval as DWORD, byval as LPDWORD) as HRESULT
end type

#define IDirectSoundCaptureBuffer8_QueryInterface(p,a,b)            IUnknown_QueryInterface(p,a,b)
#define IDirectSoundCaptureBuffer8_AddRef(p)                        IUnknown_AddRef(p)
#define IDirectSoundCaptureBuffer8_Release(p)                       IUnknown_Release(p)
#define IDirectSoundCaptureBuffer8_GetCaps(p,a)                     IDirectSoundCaptureBuffer_GetCaps(p,a)
#define IDirectSoundCaptureBuffer8_GetCurrentPosition(p,a,b)        IDirectSoundCaptureBuffer_GetCurrentPosition(p,a,b)
#define IDirectSoundCaptureBuffer8_GetFormat(p,a,b,c)               IDirectSoundCaptureBuffer_GetFormat(p,a,b,c)
#define IDirectSoundCaptureBuffer8_GetStatus(p,a)                   IDirectSoundCaptureBuffer_GetStatus(p,a)
#define IDirectSoundCaptureBuffer8_Initialize(p,a,b)                IDirectSoundCaptureBuffer_Initialize(p,a,b)
#define IDirectSoundCaptureBuffer8_Lock(p,a,b,c,d,e,f,g)            IDirectSoundCaptureBuffer_Lock(p,a,b,c,d,e,f,g)
#define IDirectSoundCaptureBuffer8_Start(p,a)                       IDirectSoundCaptureBuffer_Start(p,a)
#define IDirectSoundCaptureBuffer8_Stop(p)                          IDirectSoundCaptureBuffer_Stop(p)
#define IDirectSoundCaptureBuffer8_Unlock(p,a,b,c,d)                IDirectSoundCaptureBuffer_Unlock(p,a,b,c,d)
#define IDirectSoundCaptureBuffer8_GetObjectInPath(p,a,b,c,d)       (p)->lpVtbl->GetObjectInPath(p,a,b,c,d)
#define IDirectSoundCaptureBuffer8_GetFXStatus(p,a,b)               (p)->lpVtbl->GetFXStatus(p,a,b)
#endif

extern IID_IDirectSoundNotify alias "IID_IDirectSoundNotify" as GUID

type IDirectSoundNotifyVtbl_ as IDirectSoundNotifyVtbl

type IDirectSoundNotify
	lpVtbl as IDirectSoundNotifyVtbl_ ptr
end type

type IDirectSoundNotifyVtbl
	QueryInterface as function (byval as IDirectSoundNotify ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundNotify ptr) as ULONG
	Release as function (byval as IDirectSoundNotify ptr) as ULONG
	SetNotificationPositions as function (byval as IDirectSoundNotify ptr, byval as DWORD, byval as LPCDSBPOSITIONNOTIFY) as HRESULT
end type

#define IDirectSoundNotify_QueryInterface(p,a,b)            IUnknown_QueryInterface(p,a,b)
#define IDirectSoundNotify_AddRef(p)                        IUnknown_AddRef(p)
#define IDirectSoundNotify_Release(p)                       IUnknown_Release(p)
#define IDirectSoundNotify_SetNotificationPositions(p,a,b)  (p)->lpVtbl->SetNotificationPositions(p,a,b)

#ifndef IKsPropertySet
type LPKSPROPERTYSET as IKsPropertySet ptr

#define KSPROPERTY_SUPPORT_GET &h00000001
#define KSPROPERTY_SUPPORT_SET &h00000002
extern IID_IKsPropertySet alias "IID_IKsPropertySet" as GUID

type IKsPropertySetVtbl_ as IKsPropertySetVtbl

type IKsPropertySet
	lpVtbl as IKsPropertySetVtbl_ ptr
end type

type IKsPropertySetVtbl
	QueryInterface as function (byval as IKsPropertySet ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IKsPropertySet ptr) as ULONG
	Release as function (byval as IKsPropertySet ptr) as ULONG
	Get as function (byval as IKsPropertySet ptr, byval as GUID ptr, byval as ULONG, byval as LPVOID, byval as ULONG, byval as LPVOID, byval as ULONG, byval as PULONG) as HRESULT
	Set as function (byval as IKsPropertySet ptr, byval as GUID ptr, byval as ULONG, byval as LPVOID, byval as ULONG, byval as LPVOID, byval as ULONG) as HRESULT
	QuerySupport as function (byval as IKsPropertySet ptr, byval as GUID ptr, byval as ULONG, byval as PULONG) as HRESULT
end type

#define IKsPropertySet_QueryInterface(p,a,b)       IUnknown_QueryInterface(p,a,b)
#define IKsPropertySet_AddRef(p)                   IUnknown_AddRef(p)
#define IKsPropertySet_Release(p)                  IUnknown_Release(p)
#define IKsPropertySet_Get(p,a,b,c,d,e,f,g)        (p)->lpVtbl->Get(p,a,b,c,d,e,f,g)
#define IKsPropertySet_Set(p,a,b,c,d,e,f)          (p)->lpVtbl->Set(p,a,b,c,d,e,f)
#define IKsPropertySet_QuerySupport(p,a,b,c)       (p)->lpVtbl->QuerySupport(p,a,b,c)

#endif

#if DIRECTSOUND_VERSION >= &h0800
extern IID_IDirectSoundFXGargle alias "IID_IDirectSoundFXGargle" as GUID

type DSFXGargle
	dwRateHz as DWORD
	dwWaveShape as DWORD
end type

type LPDSFXGargle as DSFXGargle ptr

#define DSFXGARGLE_WAVE_TRIANGLE 0
#define DSFXGARGLE_WAVE_SQUARE 1

type LPCDSFXGargle as DSFXGargle ptr

#define DSFXGARGLE_RATEHZ_MIN 1
#define DSFXGARGLE_RATEHZ_MAX 1000

type IDirectSoundFXGargleVtbl_ as IDirectSoundFXGargleVtbl

type IDirectSoundFXGargle
	lpVtbl as IDirectSoundFXGargleVtbl_ ptr
end type

type IDirectSoundFXGargleVtbl
	QueryInterface as function (byval as IDirectSoundFXGargle ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXGargle ptr) as ULONG
	Release as function (byval as IDirectSoundFXGargle ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXGargle ptr, byval as LPCDSFXGargle) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXGargle ptr, byval as LPDSFXGargle) as HRESULT
end type

#define IDirectSoundFXGargle_QueryInterface(p,a,b)          IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXGargle_AddRef(p)                      IUnknown_AddRef(p)
#define IDirectSoundFXGargle_Release(p)                     IUnknown_Release(p)
#define IDirectSoundFXGargle_SetAllParameters(p,a)          (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXGargle_GetAllParameters(p,a)          (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXChorus alias "IID_IDirectSoundFXChorus" as GUID

type DSFXChorus
	fWetDryMix as FLOAT
	fDepth as FLOAT
	fFeedback as FLOAT
	fFrequency as FLOAT
	lWaveform as LONG
	fDelay as FLOAT
	lPhase as LONG
end type

type LPDSFXChorus as DSFXChorus ptr
type LPCDSFXChorus as DSFXChorus ptr

#define DSFXCHORUS_WAVE_TRIANGLE 0
#define DSFXCHORUS_WAVE_SIN 1
#define DSFXCHORUS_WETDRYMIX_MIN 0.0f
#define DSFXCHORUS_WETDRYMIX_MAX 100.0f
#define DSFXCHORUS_DEPTH_MIN 0.0f
#define DSFXCHORUS_DEPTH_MAX 100.0f
#define DSFXCHORUS_FEEDBACK_MIN -99.0f
#define DSFXCHORUS_FEEDBACK_MAX 99.0f
#define DSFXCHORUS_FREQUENCY_MIN 0.0f
#define DSFXCHORUS_FREQUENCY_MAX 10.0f
#define DSFXCHORUS_DELAY_MIN 0.0f
#define DSFXCHORUS_DELAY_MAX 20.0f
#define DSFXCHORUS_PHASE_MIN 0
#define DSFXCHORUS_PHASE_MAX 4
#define DSFXCHORUS_PHASE_NEG_180 0
#define DSFXCHORUS_PHASE_NEG_90 1
#define DSFXCHORUS_PHASE_ZERO 2
#define DSFXCHORUS_PHASE_90 3
#define DSFXCHORUS_PHASE_180 4

type IDirectSoundFXChorusVtbl_ as IDirectSoundFXChorusVtbl

type IDirectSoundFXChorus
	lpVtbl as IDirectSoundFXChorusVtbl_ ptr
end type

type IDirectSoundFXChorusVtbl
	QueryInterface as function (byval as IDirectSoundFXChorus ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXChorus ptr) as ULONG
	Release as function (byval as IDirectSoundFXChorus ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXChorus ptr, byval as LPCDSFXChorus) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXChorus ptr, byval as LPDSFXChorus) as HRESULT
end type

#define IDirectSoundFXChorus_QueryInterface(p,a,b)          IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXChorus_AddRef(p)                      IUnknown_AddRef(p)
#define IDirectSoundFXChorus_Release(p)                     IUnknown_Release(p)
#define IDirectSoundFXChorus_SetAllParameters(p,a)          (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXChorus_GetAllParameters(p,a)          (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXFlanger alias "IID_IDirectSoundFXFlanger" as GUID

type DSFXFlanger
	fWetDryMix as FLOAT
	fDepth as FLOAT
	fFeedback as FLOAT
	fFrequency as FLOAT
	lWaveform as LONG
	fDelay as FLOAT
	lPhase as LONG
end type

type LPDSFXFlanger as DSFXFlanger ptr
type LPCDSFXFlanger as DSFXFlanger ptr

#define DSFXFLANGER_WAVE_TRIANGLE 0
#define DSFXFLANGER_WAVE_SIN 1
#define DSFXFLANGER_WETDRYMIX_MIN 0.0f
#define DSFXFLANGER_WETDRYMIX_MAX 100.0f
#define DSFXFLANGER_FREQUENCY_MIN 0.0f
#define DSFXFLANGER_FREQUENCY_MAX 10.0f
#define DSFXFLANGER_DEPTH_MIN 0.0f
#define DSFXFLANGER_DEPTH_MAX 100.0f
#define DSFXFLANGER_PHASE_MIN 0
#define DSFXFLANGER_PHASE_MAX 4
#define DSFXFLANGER_FEEDBACK_MIN -99.0f
#define DSFXFLANGER_FEEDBACK_MAX 99.0f
#define DSFXFLANGER_DELAY_MIN 0.0f
#define DSFXFLANGER_DELAY_MAX 4.0f
#define DSFXFLANGER_PHASE_NEG_180 0
#define DSFXFLANGER_PHASE_NEG_90 1
#define DSFXFLANGER_PHASE_ZERO 2
#define DSFXFLANGER_PHASE_90 3
#define DSFXFLANGER_PHASE_180 4

type IDirectSoundFXFlangerVtbl_ as IDirectSoundFXFlangerVtbl

type IDirectSoundFXFlanger
	lpVtbl as IDirectSoundFXFlangerVtbl_ ptr
end type

type IDirectSoundFXFlangerVtbl
	QueryInterface as function (byval as IDirectSoundFXFlanger ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXFlanger ptr) as ULONG
	Release as function (byval as IDirectSoundFXFlanger ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXFlanger ptr, byval as LPCDSFXFlanger) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXFlanger ptr, byval as LPDSFXFlanger) as HRESULT
end type

#define IDirectSoundFXFlanger_QueryInterface(p,a,b)         IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXFlanger_AddRef(p)                     IUnknown_AddRef(p)
#define IDirectSoundFXFlanger_Release(p)                    IUnknown_Release(p)
#define IDirectSoundFXFlanger_SetAllParameters(p,a)         (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXFlanger_GetAllParameters(p,a)         (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXEcho alias "IID_IDirectSoundFXEcho" as GUID

type DSFXEcho
	fWetDryMix as FLOAT
	fFeedback as FLOAT
	fLeftDelay as FLOAT
	fRightDelay as FLOAT
	lPanDelay as LONG
end type

type LPDSFXEcho as DSFXEcho ptr
type LPCDSFXEcho as DSFXEcho ptr

#define DSFXECHO_WETDRYMIX_MIN 0.0f
#define DSFXECHO_WETDRYMIX_MAX 100.0f
#define DSFXECHO_FEEDBACK_MIN 0.0f
#define DSFXECHO_FEEDBACK_MAX 100.0f
#define DSFXECHO_LEFTDELAY_MIN 1.0f
#define DSFXECHO_LEFTDELAY_MAX 2000.0f
#define DSFXECHO_RIGHTDELAY_MIN 1.0f
#define DSFXECHO_RIGHTDELAY_MAX 2000.0f
#define DSFXECHO_PANDELAY_MIN 0
#define DSFXECHO_PANDELAY_MAX 1

type IDirectSoundFXEchoVtbl_ as IDirectSoundFXEchoVtbl

type IDirectSoundFXEcho
	lpVtbl as IDirectSoundFXEchoVtbl_ ptr
end type

type IDirectSoundFXEchoVtbl
	QueryInterface as function (byval as IDirectSoundFXEcho ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXEcho ptr) as ULONG
	Release as function (byval as IDirectSoundFXEcho ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXEcho ptr, byval as LPCDSFXEcho) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXEcho ptr, byval as LPDSFXEcho) as HRESULT
end type

#define IDirectSoundFXEcho_QueryInterface(p,a,b)            IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXEcho_AddRef(p)                        IUnknown_AddRef(p)
#define IDirectSoundFXEcho_Release(p)                       IUnknown_Release(p)
#define IDirectSoundFXEcho_SetAllParameters(p,a)            (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXEcho_GetAllParameters(p,a)            (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXDistortion alias "IID_IDirectSoundFXDistortion" as GUID

type DSFXDistortion
	fGain as FLOAT
	fEdge as FLOAT
	fPostEQCenterFrequency as FLOAT
	fPostEQBandwidth as FLOAT
	fPreLowpassCutoff as FLOAT
end type

type LPDSFXDistortion as DSFXDistortion ptr
type LPCDSFXDistortion as DSFXDistortion ptr

#define DSFXDISTORTION_GAIN_MIN -60.0f
#define DSFXDISTORTION_GAIN_MAX 0.0f
#define DSFXDISTORTION_EDGE_MIN 0.0f
#define DSFXDISTORTION_EDGE_MAX 100.0f
#define DSFXDISTORTION_POSTEQCENTERFREQUENCY_MIN 100.0f
#define DSFXDISTORTION_POSTEQCENTERFREQUENCY_MAX 8000.0f
#define DSFXDISTORTION_POSTEQBANDWIDTH_MIN 100.0f
#define DSFXDISTORTION_POSTEQBANDWIDTH_MAX 8000.0f
#define DSFXDISTORTION_PRELOWPASSCUTOFF_MIN 100.0f
#define DSFXDISTORTION_PRELOWPASSCUTOFF_MAX 8000.0f

type IDirectSoundFXDistortionVtbl_ as IDirectSoundFXDistortionVtbl

type IDirectSoundFXDistortion
	lpVtbl as IDirectSoundFXDistortionVtbl_ ptr
end type

type IDirectSoundFXDistortionVtbl
	QueryInterface as function (byval as IDirectSoundFXDistortion ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXDistortion ptr) as ULONG
	Release as function (byval as IDirectSoundFXDistortion ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXDistortion ptr, byval as LPCDSFXDistortion) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXDistortion ptr, byval as LPDSFXDistortion) as HRESULT
end type

#define IDirectSoundFXDistortion_QueryInterface(p,a,b)      IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXDistortion_AddRef(p)                  IUnknown_AddRef(p)
#define IDirectSoundFXDistortion_Release(p)                 IUnknown_Release(p)
#define IDirectSoundFXDistortion_SetAllParameters(p,a)      (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXDistortion_GetAllParameters(p,a)      (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXCompressor alias "IID_IDirectSoundFXCompressor" as GUID

type DSFXCompressor
	fGain as FLOAT
	fAttack as FLOAT
	fRelease as FLOAT
	fThreshold as FLOAT
	fRatio as FLOAT
	fPredelay as FLOAT
end type

type LPDSFXCompressor as DSFXCompressor ptr
type LPCDSFXCompressor as DSFXCompressor ptr

#define DSFXCOMPRESSOR_GAIN_MIN -60.0f
#define DSFXCOMPRESSOR_GAIN_MAX 60.0f
#define DSFXCOMPRESSOR_ATTACK_MIN 0.01f
#define DSFXCOMPRESSOR_ATTACK_MAX 500.0f
#define DSFXCOMPRESSOR_RELEASE_MIN 50.0f
#define DSFXCOMPRESSOR_RELEASE_MAX 3000.0f
#define DSFXCOMPRESSOR_THRESHOLD_MIN -60.0f
#define DSFXCOMPRESSOR_THRESHOLD_MAX 0.0f
#define DSFXCOMPRESSOR_RATIO_MIN 1.0f
#define DSFXCOMPRESSOR_RATIO_MAX 100.0f
#define DSFXCOMPRESSOR_PREDELAY_MIN 0.0f
#define DSFXCOMPRESSOR_PREDELAY_MAX 4.0f

type IDirectSoundFXCompressorVtbl_ as IDirectSoundFXCompressorVtbl

type IDirectSoundFXCompressor
	lpVtbl as IDirectSoundFXCompressorVtbl_ ptr
end type

type IDirectSoundFXCompressorVtbl
	QueryInterface as function (byval as IDirectSoundFXCompressor ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXCompressor ptr) as ULONG
	Release as function (byval as IDirectSoundFXCompressor ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXCompressor ptr, byval as LPCDSFXCompressor) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXCompressor ptr, byval as LPDSFXCompressor) as HRESULT
end type

#define IDirectSoundFXCompressor_QueryInterface(p,a,b)      IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXCompressor_AddRef(p)                  IUnknown_AddRef(p)
#define IDirectSoundFXCompressor_Release(p)                 IUnknown_Release(p)
#define IDirectSoundFXCompressor_SetAllParameters(p,a)      (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXCompressor_GetAllParameters(p,a)      (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXParamEq alias "IID_IDirectSoundFXParamEq" as GUID

type DSFXParamEq
	fCenter as FLOAT
	fBandwidth as FLOAT
	fGain as FLOAT
end type

type LPDSFXParamEq as DSFXParamEq ptr
type LPCDSFXParamEq as DSFXParamEq ptr

#define DSFXPARAMEQ_CENTER_MIN 80.0f
#define DSFXPARAMEQ_CENTER_MAX 16000.0f
#define DSFXPARAMEQ_BANDWIDTH_MIN 1.0f
#define DSFXPARAMEQ_BANDWIDTH_MAX 36.0f
#define DSFXPARAMEQ_GAIN_MIN -15.0f
#define DSFXPARAMEQ_GAIN_MAX 15.0f

type IDirectSoundFXParamEqVtbl_ as IDirectSoundFXParamEqVtbl

type IDirectSoundFXParamEq
	lpVtbl as IDirectSoundFXParamEqVtbl_ ptr
end type

type IDirectSoundFXParamEqVtbl
	QueryInterface as function (byval as IDirectSoundFXParamEq ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXParamEq ptr) as ULONG
	Release as function (byval as IDirectSoundFXParamEq ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXParamEq ptr, byval as LPCDSFXParamEq) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXParamEq ptr, byval as LPDSFXParamEq) as HRESULT
end type

#define IDirectSoundFXParamEq_QueryInterface(p,a,b)      IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXParamEq_AddRef(p)                  IUnknown_AddRef(p)
#define IDirectSoundFXParamEq_Release(p)                 IUnknown_Release(p)
#define IDirectSoundFXParamEq_SetAllParameters(p,a)      (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXParamEq_GetAllParameters(p,a)      (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFXI3DL2Reverb alias "IID_IDirectSoundFXI3DL2Reverb" as GUID

type DSFXI3DL2Reverb
	lRoom as LONG
	lRoomHF as LONG
	flRoomRolloffFactor as FLOAT
	flDecayTime as FLOAT
	flDecayHFRatio as FLOAT
	lReflections as LONG
	flReflectionsDelay as FLOAT
	lReverb as LONG
	flReverbDelay as FLOAT
	flDiffusion as FLOAT
	flDensity as FLOAT
	flHFReference as FLOAT
end type

type LPDSFXI3DL2Reverb as DSFXI3DL2Reverb ptr
type LPCDSFXI3DL2Reverb as DSFXI3DL2Reverb ptr

#define DSFX_I3DL2REVERB_ROOM_MIN (-10000)
#define DSFX_I3DL2REVERB_ROOM_MAX 0
#define DSFX_I3DL2REVERB_ROOM_DEFAULT (-1000)
#define DSFX_I3DL2REVERB_ROOMHF_MIN (-10000)
#define DSFX_I3DL2REVERB_ROOMHF_MAX 0
#define DSFX_I3DL2REVERB_ROOMHF_DEFAULT (-100)
#define DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MIN 0.0f
#define DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_MAX 10.0f
#define DSFX_I3DL2REVERB_ROOMROLLOFFFACTOR_DEFAULT 0.0f
#define DSFX_I3DL2REVERB_DECAYTIME_MIN 0.1f
#define DSFX_I3DL2REVERB_DECAYTIME_MAX 20.0f
#define DSFX_I3DL2REVERB_DECAYTIME_DEFAULT 1.49f
#define DSFX_I3DL2REVERB_DECAYHFRATIO_MIN 0.1f
#define DSFX_I3DL2REVERB_DECAYHFRATIO_MAX 2.0f
#define DSFX_I3DL2REVERB_DECAYHFRATIO_DEFAULT 0.83f
#define DSFX_I3DL2REVERB_REFLECTIONS_MIN (-10000)
#define DSFX_I3DL2REVERB_REFLECTIONS_MAX 1000
#define DSFX_I3DL2REVERB_REFLECTIONS_DEFAULT (-2602)
#define DSFX_I3DL2REVERB_REFLECTIONSDELAY_MIN 0.0f
#define DSFX_I3DL2REVERB_REFLECTIONSDELAY_MAX 0.3f
#define DSFX_I3DL2REVERB_REFLECTIONSDELAY_DEFAULT 0.007f
#define DSFX_I3DL2REVERB_REVERB_MIN (-10000)
#define DSFX_I3DL2REVERB_REVERB_MAX 2000
#define DSFX_I3DL2REVERB_REVERB_DEFAULT (200)
#define DSFX_I3DL2REVERB_REVERBDELAY_MIN 0.0f
#define DSFX_I3DL2REVERB_REVERBDELAY_MAX 0.1f
#define DSFX_I3DL2REVERB_REVERBDELAY_DEFAULT 0.011f
#define DSFX_I3DL2REVERB_DIFFUSION_MIN 0.0f
#define DSFX_I3DL2REVERB_DIFFUSION_MAX 100.0f
#define DSFX_I3DL2REVERB_DIFFUSION_DEFAULT 100.0f
#define DSFX_I3DL2REVERB_DENSITY_MIN 0.0f
#define DSFX_I3DL2REVERB_DENSITY_MAX 100.0f
#define DSFX_I3DL2REVERB_DENSITY_DEFAULT 100.0f
#define DSFX_I3DL2REVERB_HFREFERENCE_MIN 20.0f
#define DSFX_I3DL2REVERB_HFREFERENCE_MAX 20000.0f
#define DSFX_I3DL2REVERB_HFREFERENCE_DEFAULT 5000.0f
#define DSFX_I3DL2REVERB_QUALITY_MIN 0
#define DSFX_I3DL2REVERB_QUALITY_MAX 3
#define DSFX_I3DL2REVERB_QUALITY_DEFAULT 2

type IDirectSoundFXI3DL2ReverbVtbl_ as IDirectSoundFXI3DL2ReverbVtbl

type IDirectSoundFXI3DL2Reverb
	lpVtbl as IDirectSoundFXI3DL2ReverbVtbl_ ptr
end type

type IDirectSoundFXI3DL2ReverbVtbl
	QueryInterface as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXI3DL2Reverb ptr) as ULONG
	Release as function (byval as IDirectSoundFXI3DL2Reverb ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as LPCDSFXI3DL2Reverb) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as LPDSFXI3DL2Reverb) as HRESULT
	SetPreset as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as DWORD) as HRESULT
	GetPreset as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as LPDWORD) as HRESULT
	SetQuality as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as LONG) as HRESULT
	GetQuality as function (byval as IDirectSoundFXI3DL2Reverb ptr, byval as LONG ptr) as HRESULT
end type

#define IDirectSoundFXI3DL2Reverb_QueryInterface(p,a,b)     IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXI3DL2Reverb_AddRef(p)                 IUnknown_AddRef(p)
#define IDirectSoundFXI3DL2Reverb_Release(p)                IUnknown_Release(p)
#define IDirectSoundFXI3DL2Reverb_SetAllParameters(p,a)     (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXI3DL2Reverb_GetAllParameters(p,a)     (p)->lpVtbl->GetAllParameters(p,a)
#define IDirectSoundFXI3DL2Reverb_SetPreset(p,a)            (p)->lpVtbl->SetPreset(p,a)
#define IDirectSoundFXI3DL2Reverb_GetPreset(p,a)            (p)->lpVtbl->GetPreset(p,a)

extern IID_IDirectSoundFXWavesReverb alias "IID_IDirectSoundFXWavesReverb" as GUID

type DSFXWavesReverb
	fInGain as FLOAT
	fReverbMix as FLOAT
	fReverbTime as FLOAT
	fHighFreqRTRatio as FLOAT
end type

type LPDSFXWavesReverb as DSFXWavesReverb ptr
type LPCDSFXWavesReverb as DSFXWavesReverb ptr

#define DSFX_WAVESREVERB_INGAIN_MIN -96.0f
#define DSFX_WAVESREVERB_INGAIN_MAX 0.0f
#define DSFX_WAVESREVERB_INGAIN_DEFAULT 0.0f
#define DSFX_WAVESREVERB_REVERBMIX_MIN -96.0f
#define DSFX_WAVESREVERB_REVERBMIX_MAX 0.0f
#define DSFX_WAVESREVERB_REVERBMIX_DEFAULT 0.0f
#define DSFX_WAVESREVERB_REVERBTIME_MIN 0.001f
#define DSFX_WAVESREVERB_REVERBTIME_MAX 3000.0f
#define DSFX_WAVESREVERB_REVERBTIME_DEFAULT 1000.0f
#define DSFX_WAVESREVERB_HIGHFREQRTRATIO_MIN 0.001f
#define DSFX_WAVESREVERB_HIGHFREQRTRATIO_MAX 0.999f
#define DSFX_WAVESREVERB_HIGHFREQRTRATIO_DEFAULT 0.001f

type IDirectSoundFXWavesReverbVtbl_ as IDirectSoundFXWavesReverbVtbl

type IDirectSoundFXWavesReverb
	lpVtbl as IDirectSoundFXWavesReverbVtbl_ ptr
end type

type IDirectSoundFXWavesReverbVtbl
	QueryInterface as function (byval as IDirectSoundFXWavesReverb ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFXWavesReverb ptr) as ULONG
	Release as function (byval as IDirectSoundFXWavesReverb ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundFXWavesReverb ptr, byval as LPCDSFXWavesReverb) as HRESULT
	GetAllParameters as function (byval as IDirectSoundFXWavesReverb ptr, byval as LPDSFXWavesReverb) as HRESULT
end type

#define IDirectSoundFXWavesReverb_QueryInterface(p,a,b)     IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFXWavesReverb_AddRef(p)                 IUnknown_AddRef(p)
#define IDirectSoundFXWavesReverb_Release(p)                IUnknown_Release(p)
#define IDirectSoundFXWavesReverb_SetAllParameters(p,a)     (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundFXWavesReverb_GetAllParameters(p,a)     (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundCaptureFXAec alias "IID_IDirectSoundCaptureFXAec" as GUID

type DSCFXAec
	fEnable as BOOL
	fNoiseFill as BOOL
	dwMode as DWORD
end type

type LPDSCFXAec as DSCFXAec ptr
type LPCDSCFXAec as DSCFXAec ptr

#define DSCFX_AEC_MODE_PASS_THROUGH &h0
#define DSCFX_AEC_MODE_HALF_DUPLEX &h1
#define DSCFX_AEC_MODE_FULL_DUPLEX &h2
#define DSCFX_AEC_STATUS_HISTORY_UNINITIALIZED &h0
#define DSCFX_AEC_STATUS_HISTORY_CONTINUOUSLY_CONVERGED &h1
#define DSCFX_AEC_STATUS_HISTORY_PREVIOUSLY_DIVERGED &h2
#define DSCFX_AEC_STATUS_CURRENTLY_CONVERGED &h8

type IDirectSoundCaptureFXAecVtbl_ as IDirectSoundCaptureFXAecVtbl

type IDirectSoundCaptureFXAec
	lpVtbl as IDirectSoundCaptureFXAecVtbl_ ptr
end type

type IDirectSoundCaptureFXAecVtbl
	QueryInterface as function (byval as IDirectSoundCaptureFXAec ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundCaptureFXAec ptr) as ULONG
	Release as function (byval as IDirectSoundCaptureFXAec ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundCaptureFXAec ptr, byval as LPCDSCFXAec) as HRESULT
	GetAllParameters as function (byval as IDirectSoundCaptureFXAec ptr, byval as LPDSCFXAec) as HRESULT
	GetStatus as function (byval as IDirectSoundCaptureFXAec ptr, byval as PDWORD) as HRESULT
	Reset as function (byval as IDirectSoundCaptureFXAec ptr) as HRESULT
end type

#define IDirectSoundCaptureFXAec_QueryInterface(p,a,b)     IUnknown_QueryInterface(p,a,b)
#define IDirectSoundCaptureFXAec_AddRef(p)                 IUnknown_AddRef(p)
#define IDirectSoundCaptureFXAec_Release(p)                IUnknown_Release(p)
#define IDirectSoundCaptureFXAec_SetAllParameters(p,a)     (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundCaptureFXAec_GetAllParameters(p,a)     (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundCaptureFXNoiseSuppress alias "IID_IDirectSoundCaptureFXNoiseSuppress" as GUID

type DSCFXNoiseSuppress
	fEnable as BOOL
end type

type LPDSCFXNoiseSuppress as DSCFXNoiseSuppress ptr
type LPCDSCFXNoiseSuppress as DSCFXNoiseSuppress ptr

type IDirectSoundCaptureFXNoiseSuppressVtbl_ as IDirectSoundCaptureFXNoiseSuppressVtbl

type IDirectSoundCaptureFXNoiseSuppress
	lpVtbl as IDirectSoundCaptureFXNoiseSuppressVtbl_ ptr
end type

type IDirectSoundCaptureFXNoiseSuppressVtbl
	QueryInterface as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr) as ULONG
	Release as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr) as ULONG
	SetAllParameters as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr, byval as LPCDSCFXNoiseSuppress) as HRESULT
	GetAllParameters as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr, byval as LPDSCFXNoiseSuppress) as HRESULT
	Reset as function (byval as IDirectSoundCaptureFXNoiseSuppress ptr) as HRESULT
end type

#define IDirectSoundCaptureFXNoiseSuppress_QueryInterface(p,a,b)     IUnknown_QueryInterface(p,a,b)
#define IDirectSoundCaptureFXNoiseSuppress_AddRef(p)                 IUnknown_AddRef(p)
#define IDirectSoundCaptureFXNoiseSuppress_Release(p)                IUnknown_Release(p)
#define IDirectSoundCaptureFXNoiseSuppress_SetAllParameters(p,a)     (p)->lpVtbl->SetAllParameters(p,a)
#define IDirectSoundCaptureFXNoiseSuppress_GetAllParameters(p,a)     (p)->lpVtbl->GetAllParameters(p,a)

extern IID_IDirectSoundFullDuplex alias "IID_IDirectSoundFullDuplex" as GUID

type IDirectSoundFullDuplexVtbl_ as IDirectSoundFullDuplexVtbl

type IDirectSoundFullDuplex
	lpVtbl as IDirectSoundFullDuplexVtbl_ ptr
end type

type IDirectSoundFullDuplexVtbl
	QueryInterface as function (byval as IDirectSoundFullDuplex ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function (byval as IDirectSoundFullDuplex ptr) as ULONG
	Release as function (byval as IDirectSoundFullDuplex ptr) as ULONG
	Initialize as function (byval as IDirectSoundFullDuplex ptr, byval as LPCGUID, byval as LPCGUID, byval as LPCDSCBUFFERDESC, byval as LPCDSBUFFERDESC, byval as HWND, byval as DWORD, byval as LPLPDIRECTSOUNDCAPTUREBUFFER8, byval as LPLPDIRECTSOUNDBUFFER8) as HRESULT
end type

#define IDirectSoundFullDuplex_QueryInterface(p,a,b)    IUnknown_QueryInterface(p,a,b)
#define IDirectSoundFullDuplex_AddRef(p)                IUnknown_AddRef(p)
#define IDirectSoundFullDuplex_Release(p)               IUnknown_Release(p)
#define IDirectSoundFullDuplex_Initialize(p,a,b,c,d,e,f,g,h)     (p)->lpVtbl->Initialize(p,a,b,c,d,e,f,g,h)

#endif '' DIRECTSOUND_VERSION >= &h0800

#define DS_OK                           S_OK

#define DS_NO_VIRTUALIZATION            MAKE_HRESULT(0, _FACDS, 10)
#define DSERR_ALLOCATED                 MAKE_DSHRESULT(10)
#define DSERR_CONTROLUNAVAIL            MAKE_DSHRESULT(30)
#define DSERR_INVALIDPARAM              E_INVALIDARG
#define DSERR_INVALIDCALL               MAKE_DSHRESULT(50)
#define DSERR_GENERIC                   E_FAIL
#define DSERR_PRIOLEVELNEEDED           MAKE_DSHRESULT(70)
#define DSERR_OUTOFMEMORY               E_OUTOFMEMORY
#define DSERR_BADFORMAT                 MAKE_DSHRESULT(100)
#define DSERR_UNSUPPORTED               E_NOTIMPL
#define DSERR_NODRIVER                  MAKE_DSHRESULT(120)
#define DSERR_ALREADYINITIALIZED        MAKE_DSHRESULT(130)
#define DSERR_NOAGGREGATION             CLASS_E_NOAGGREGATION
#define DSERR_BUFFERLOST                MAKE_DSHRESULT(150)
#define DSERR_OTHERAPPHASPRIO           MAKE_DSHRESULT(160)
#define DSERR_UNINITIALIZED             MAKE_DSHRESULT(170)
#define DSERR_NOINTERFACE               E_NOINTERFACE
#define DSERR_ACCESSDENIED              E_ACCESSDENIED
#define DSERR_BUFFERTOOSMALL            MAKE_DSHRESULT(180)
#define DSERR_DS8_REQUIRED              MAKE_DSHRESULT(190)
#define DSERR_SENDLOOP                  MAKE_DSHRESULT(200)
#define DSERR_BADSENDBUFFERGUID         MAKE_DSHRESULT(210)
#define DSERR_OBJECTNOTFOUND            MAKE_DSHRESULT(4449)
#define DSERR_FXUNAVAILABLE             MAKE_DSHRESULT(220)

#define DSCAPS_PRIMARYMONO &h00000001
#define DSCAPS_PRIMARYSTEREO &h00000002
#define DSCAPS_PRIMARY8BIT &h00000004
#define DSCAPS_PRIMARY16BIT &h00000008
#define DSCAPS_CONTINUOUSRATE &h00000010
#define DSCAPS_EMULDRIVER &h00000020
#define DSCAPS_CERTIFIED &h00000040
#define DSCAPS_SECONDARYMONO &h00000100
#define DSCAPS_SECONDARYSTEREO &h00000200
#define DSCAPS_SECONDARY8BIT &h00000400
#define DSCAPS_SECONDARY16BIT &h00000800
#define DSSCL_NORMAL &h00000001
#define DSSCL_PRIORITY &h00000002
#define DSSCL_EXCLUSIVE &h00000003
#define DSSCL_WRITEPRIMARY &h00000004
#define DSSPEAKER_DIRECTOUT &h00000000
#define DSSPEAKER_HEADPHONE &h00000001
#define DSSPEAKER_MONO &h00000002
#define DSSPEAKER_QUAD &h00000003
#define DSSPEAKER_STEREO &h00000004
#define DSSPEAKER_SURROUND &h00000005
#define DSSPEAKER_5POINT1 &h00000006
#define DSSPEAKER_7POINT1 &h00000007
#define DSSPEAKER_GEOMETRY_MIN &h00000005
#define DSSPEAKER_GEOMETRY_NARROW &h0000000A
#define DSSPEAKER_GEOMETRY_WIDE &h00000014
#define DSSPEAKER_GEOMETRY_MAX &h000000B4

#define DSSPEAKER_COMBINED(c, g)    (cuint(cubyte(c)) or (cuint(cubyte(g)) shl 16))
#define DSSPEAKER_CONFIG(a)         cubyte(a)
#define DSSPEAKER_GEOMETRY(a)       cubyte((cuint(a) shr 16) and &h00FF)

#define DSBCAPS_PRIMARYBUFFER &h00000001
#define DSBCAPS_STATIC &h00000002
#define DSBCAPS_LOCHARDWARE &h00000004
#define DSBCAPS_LOCSOFTWARE &h00000008
#define DSBCAPS_CTRL3D &h00000010
#define DSBCAPS_CTRLFREQUENCY &h00000020
#define DSBCAPS_CTRLPAN &h00000040
#define DSBCAPS_CTRLVOLUME &h00000080
#define DSBCAPS_CTRLPOSITIONNOTIFY &h00000100
#define DSBCAPS_CTRLFX &h00000200
#define DSBCAPS_STICKYFOCUS &h00004000
#define DSBCAPS_GLOBALFOCUS &h00008000
#define DSBCAPS_GETCURRENTPOSITION2 &h00010000
#define DSBCAPS_MUTE3DATMAXDISTANCE &h00020000
#define DSBCAPS_LOCDEFER &h00040000
#define DSBPLAY_LOOPING &h00000001
#define DSBPLAY_LOCHARDWARE &h00000002
#define DSBPLAY_LOCSOFTWARE &h00000004
#define DSBPLAY_TERMINATEBY_TIME &h00000008
#define DSBPLAY_TERMINATEBY_DISTANCE &h000000010
#define DSBPLAY_TERMINATEBY_PRIORITY &h000000020
#define DSBSTATUS_PLAYING &h00000001
#define DSBSTATUS_BUFFERLOST &h00000002
#define DSBSTATUS_LOOPING &h00000004
#define DSBSTATUS_LOCHARDWARE &h00000008
#define DSBSTATUS_LOCSOFTWARE &h00000010
#define DSBSTATUS_TERMINATED &h00000020
#define DSBLOCK_FROMWRITECURSOR &h00000001
#define DSBLOCK_ENTIREBUFFER &h00000002
#define DSBFREQUENCY_ORIGINAL 0
#define DSBFREQUENCY_MIN 100
#if DIRECTSOUND_VERSION >= &h0900
#define DSBFREQUENCY_MAX 200000
#else
#define DSBFREQUENCY_MAX 100000
#endif
#define DSBPAN_LEFT -10000
#define DSBPAN_CENTER 0
#define DSBPAN_RIGHT 10000
#define DSBVOLUME_MIN -10000
#define DSBVOLUME_MAX 0
#define DSBSIZE_MIN 4
#define DSBSIZE_MAX &h0FFFFFFF
#define DSBSIZE_FX_MIN 150
#define DS3DMODE_NORMAL &h00000000
#define DS3DMODE_HEADRELATIVE &h00000001
#define DS3DMODE_DISABLE &h00000002
#define DS3D_IMMEDIATE &h00000000
#define DS3D_DEFERRED &h00000001
#define DS3D_MINDISTANCEFACTOR      FLT_MIN
#define DS3D_MAXDISTANCEFACTOR      FLT_MAX
#define DS3D_DEFAULTDISTANCEFACTOR 1.0f
#define DS3D_MINROLLOFFFACTOR 0.0f
#define DS3D_MAXROLLOFFFACTOR 10.0f
#define DS3D_DEFAULTROLLOFFFACTOR 1.0f
#define DS3D_MINDOPPLERFACTOR 0.0f
#define DS3D_MAXDOPPLERFACTOR 10.0f
#define DS3D_DEFAULTDOPPLERFACTOR 1.0f
#define DS3D_DEFAULTMINDISTANCE 1.0f
#define DS3D_DEFAULTMAXDISTANCE 1000000000.0f
#define DS3D_MINCONEANGLE 0
#define DS3D_MAXCONEANGLE 360
#define DS3D_DEFAULTCONEANGLE 360
#define DS3D_DEFAULTCONEOUTSIDEVOLUME 0
#define DSCCAPS_EMULDRIVER &h00000020
#define DSCCAPS_CERTIFIED &h00000040
#define DSCCAPS_MULTIPLECAPTURE &h00000001
#define DSCBCAPS_WAVEMAPPED &h80000000
#define DSCBCAPS_CTRLFX &h00000200
#define DSCBLOCK_ENTIREBUFFER &h00000001
#define DSCBSTATUS_CAPTURING &h00000001
#define DSCBSTATUS_LOOPING &h00000002
#define DSCBSTART_LOOPING &h00000001
#define DSBPN_OFFSETSTOP &hFFFFFFFF
#define DS_CERTIFIED &h00000000
#define DS_UNCERTIFIED &h00000001

enum
	DSFX_I3DL2_MATERIAL_PRESET_SINGLEWINDOW
	DSFX_I3DL2_MATERIAL_PRESET_DOUBLEWINDOW
	DSFX_I3DL2_MATERIAL_PRESET_THINDOOR
	DSFX_I3DL2_MATERIAL_PRESET_THICKDOOR
	DSFX_I3DL2_MATERIAL_PRESET_WOODWALL
	DSFX_I3DL2_MATERIAL_PRESET_BRICKWALL
	DSFX_I3DL2_MATERIAL_PRESET_STONEWALL
	DSFX_I3DL2_MATERIAL_PRESET_CURTAIN
end enum

#define I3DL2_MATERIAL_PRESET_SINGLEWINDOW    -2800,0.71f
#define I3DL2_MATERIAL_PRESET_DOUBLEWINDOW    -5000,0.40f
#define I3DL2_MATERIAL_PRESET_THINDOOR        -1800,0.66f
#define I3DL2_MATERIAL_PRESET_THICKDOOR       -4400,0.64f
#define I3DL2_MATERIAL_PRESET_WOODWALL        -4000,0.50f
#define I3DL2_MATERIAL_PRESET_BRICKWALL       -5000,0.60f
#define I3DL2_MATERIAL_PRESET_STONEWALL       -6000,0.68f
#define I3DL2_MATERIAL_PRESET_CURTAIN         -1200,0.15f

enum
	DSFX_I3DL2_ENVIRONMENT_PRESET_DEFAULT
	DSFX_I3DL2_ENVIRONMENT_PRESET_GENERIC
	DSFX_I3DL2_ENVIRONMENT_PRESET_PADDEDCELL
	DSFX_I3DL2_ENVIRONMENT_PRESET_ROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_BATHROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_LIVINGROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_STONEROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_AUDITORIUM
	DSFX_I3DL2_ENVIRONMENT_PRESET_CONCERTHALL
	DSFX_I3DL2_ENVIRONMENT_PRESET_CAVE
	DSFX_I3DL2_ENVIRONMENT_PRESET_ARENA
	DSFX_I3DL2_ENVIRONMENT_PRESET_HANGAR
	DSFX_I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY
	DSFX_I3DL2_ENVIRONMENT_PRESET_HALLWAY
	DSFX_I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR
	DSFX_I3DL2_ENVIRONMENT_PRESET_ALLEY
	DSFX_I3DL2_ENVIRONMENT_PRESET_FOREST
	DSFX_I3DL2_ENVIRONMENT_PRESET_CITY
	DSFX_I3DL2_ENVIRONMENT_PRESET_MOUNTAINS
	DSFX_I3DL2_ENVIRONMENT_PRESET_QUARRY
	DSFX_I3DL2_ENVIRONMENT_PRESET_PLAIN
	DSFX_I3DL2_ENVIRONMENT_PRESET_PARKINGLOT
	DSFX_I3DL2_ENVIRONMENT_PRESET_SEWERPIPE
	DSFX_I3DL2_ENVIRONMENT_PRESET_UNDERWATER
	DSFX_I3DL2_ENVIRONMENT_PRESET_SMALLROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEROOM
	DSFX_I3DL2_ENVIRONMENT_PRESET_MEDIUMHALL
	DSFX_I3DL2_ENVIRONMENT_PRESET_LARGEHALL
	DSFX_I3DL2_ENVIRONMENT_PRESET_PLATE
end enum

#define I3DL2_ENVIRONMENT_PRESET_DEFAULT         -1000, -100, 0.0f, 1.49f, 0.83f, -2602, 0.007f,   200, 0.011f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_GENERIC         -1000, -100, 0.0f, 1.49f, 0.83f, -2602, 0.007f,   200, 0.011f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_PADDEDCELL      -1000,-6000, 0.0f, 0.17f, 0.10f, -1204, 0.001f,   207, 0.002f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_ROOM            -1000, -454, 0.0f, 0.40f, 0.83f, -1646, 0.002f,    53, 0.003f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_BATHROOM        -1000,-1200, 0.0f, 1.49f, 0.54f,  -370, 0.007f,  1030, 0.011f, 100.0f,  60.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_LIVINGROOM      -1000,-6000, 0.0f, 0.50f, 0.10f, -1376, 0.003f, -1104, 0.004f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_STONEROOM       -1000, -300, 0.0f, 2.31f, 0.64f,  -711, 0.012f,    83, 0.017f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_AUDITORIUM      -1000, -476, 0.0f, 4.32f, 0.59f,  -789, 0.020f,  -289, 0.030f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_CONCERTHALL     -1000, -500, 0.0f, 3.92f, 0.70f, -1230, 0.020f,    -2, 0.029f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_CAVE            -1000,    0, 0.0f, 2.91f, 1.30f,  -602, 0.015f,  -302, 0.022f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_ARENA           -1000, -698, 0.0f, 7.24f, 0.33f, -1166, 0.020f,    16, 0.030f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_HANGAR          -1000,-1000, 0.0f,10.05f, 0.23f,  -602, 0.020f,   198, 0.030f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_CARPETEDHALLWAY -1000,-4000, 0.0f, 0.30f, 0.10f, -1831, 0.002f, -1630, 0.030f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_HALLWAY         -1000, -300, 0.0f, 1.49f, 0.59f, -1219, 0.007f,   441, 0.011f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_STONECORRIDOR   -1000, -237, 0.0f, 2.70f, 0.79f, -1214, 0.013f,   395, 0.020f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_ALLEY           -1000, -270, 0.0f, 1.49f, 0.86f, -1204, 0.007f,    -4, 0.011f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_FOREST          -1000,-3300, 0.0f, 1.49f, 0.54f, -2560, 0.162f,  -613, 0.088f,  79.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_CITY            -1000, -800, 0.0f, 1.49f, 0.67f, -2273, 0.007f, -2217, 0.011f,  50.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_MOUNTAINS       -1000,-2500, 0.0f, 1.49f, 0.21f, -2780, 0.300f, -2014, 0.100f,  27.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_QUARRY          -1000,-1000, 0.0f, 1.49f, 0.83f,-10000, 0.061f,   500, 0.025f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_PLAIN           -1000,-2000, 0.0f, 1.49f, 0.50f, -2466, 0.179f, -2514, 0.100f,  21.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_PARKINGLOT      -1000,    0, 0.0f, 1.65f, 1.50f, -1363, 0.008f, -1153, 0.012f, 100.0f, 100.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_SEWERPIPE       -1000,-1000, 0.0f, 2.81f, 0.14f,   429, 0.014f,   648, 0.021f,  80.0f,  60.0f, 5000.0f
#define I3DL2_ENVIRONMENT_PRESET_UNDERWATER      -1000,-4000, 0.0f, 1.49f, 0.10f,  -449, 0.007f,  1700, 0.011f, 100.0f, 100.0f, 5000.0f

#define DS3DALG_DEFAULT GUID_NULL

extern DS3DALG_NO_VIRTUALIZATION alias "DS3DALG_NO_VIRTUALIZATION" as GUID
extern DS3DALG_HRTF_FULL alias "DS3DALG_HRTF_FULL" as GUID
extern DS3DALG_HRTF_LIGHT alias "DS3DALG_HRTF_LIGHT" as GUID

#if DIRECTSOUND_VERSION >= &h0800
extern GUID_DSFX_STANDARD_GARGLE alias "GUID_DSFX_STANDARD_GARGLE" as GUID
extern GUID_DSFX_STANDARD_CHORUS alias "GUID_DSFX_STANDARD_CHORUS" as GUID
extern GUID_DSFX_STANDARD_FLANGER alias "GUID_DSFX_STANDARD_FLANGER" as GUID
extern GUID_DSFX_STANDARD_ECHO alias "GUID_DSFX_STANDARD_ECHO" as GUID
extern GUID_DSFX_STANDARD_DISTORTION alias "GUID_DSFX_STANDARD_DISTORTION" as GUID
extern GUID_DSFX_STANDARD_COMPRESSOR alias "GUID_DSFX_STANDARD_COMPRESSOR" as GUID
extern GUID_DSFX_STANDARD_PARAMEQ alias "GUID_DSFX_STANDARD_PARAMEQ" as GUID
extern GUID_DSFX_STANDARD_I3DL2REVERB alias "GUID_DSFX_STANDARD_I3DL2REVERB" as GUID
extern GUID_DSFX_WAVES_REVERB alias "GUID_DSFX_WAVES_REVERB" as GUID
extern GUID_DSCFX_CLASS_AEC alias "GUID_DSCFX_CLASS_AEC" as GUID
extern GUID_DSCFX_MS_AEC alias "GUID_DSCFX_MS_AEC" as GUID
extern GUID_DSCFX_SYSTEM_AEC alias "GUID_DSCFX_SYSTEM_AEC" as GUID
extern GUID_DSCFX_CLASS_NS alias "GUID_DSCFX_CLASS_NS" as GUID
extern GUID_DSCFX_MS_NS alias "GUID_DSCFX_MS_NS" as GUID
extern GUID_DSCFX_SYSTEM_NS alias "GUID_DSCFX_SYSTEM_NS" as GUID
#endif '' DIRECTSOUND_VERSION >= &h0800

#define _FACDS &h878
#define MAKE_DSHRESULT(code) MAKE_HRESULT(1, _FACDS, code)

#endif
