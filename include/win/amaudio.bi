''
''
'' amaudio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_amaudio_bi__
#define __win_amaudio_bi__

#include once "win/mmsystem.bi"
#include once "win/dsound.bi"

type IAMDirectSoundVtbl_ as IAMDirectSoundVtbl

type IAMDirectSound
	lpVtbl as IAMDirectSoundVtbl_ ptr
end type

type IAMDirectSoundVtbl
	QueryInterface as function(byval as IAMDirectSound ptr, byval as IID ptr, byval as LPVOID ptr) as HRESULT
	AddRef as function(byval as IAMDirectSound ptr) as ULONG
	Release as function(byval as IAMDirectSound ptr) as ULONG
	GetDirectSoundInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUND ptr) as HRESULT
	GetPrimaryBufferInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUNDBUFFER ptr) as HRESULT
	GetSecondaryBufferInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUNDBUFFER ptr) as HRESULT
	ReleaseDirectSoundInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUND) as HRESULT
	ReleasePrimaryBufferInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUNDBUFFER) as HRESULT
	ReleaseSecondaryBufferInterface as function(byval as IAMDirectSound ptr, byval as LPDIRECTSOUNDBUFFER) as HRESULT
	SetFocusWindow as function(byval as IAMDirectSound ptr, byval as HWND, byval as BOOL) as HRESULT
	GetFocusWindow as function(byval as IAMDirectSound ptr, byval as HWND ptr, byval as BOOL ptr) as HRESULT
end type

#endif
