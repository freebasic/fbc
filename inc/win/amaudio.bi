'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2010 Maarten Lankhorst for CodeWeavers
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

#include once "mmsystem.bi"
#include once "dsound.bi"

extern "Windows"

#define __AMAUDIO__
type IAMDirectSoundVtbl as IAMDirectSoundVtbl_

type IAMDirectSound
	lpVtbl as IAMDirectSoundVtbl ptr
end type

type IAMDirectSoundVtbl_
	QueryInterface as function(byval This as IAMDirectSound ptr, byval riid as const IID const ptr, byval ppvObject as any ptr ptr) as HRESULT
	AddRef as function(byval This as IAMDirectSound ptr) as ULONG
	Release as function(byval This as IAMDirectSound ptr) as ULONG
	GetDirectSoundInterface as function(byval This as IAMDirectSound ptr, byval ds as IDirectSound ptr ptr) as HRESULT
	GetPrimaryBufferInterface as function(byval This as IAMDirectSound ptr, byval buf as IDirectSoundBuffer ptr ptr) as HRESULT
	GetSecondaryBufferInterface as function(byval This as IAMDirectSound ptr, byval buf as IDirectSoundBuffer ptr ptr) as HRESULT
	ReleaseDirectSoundInterface as function(byval This as IAMDirectSound ptr, byval ds as IDirectSound ptr) as HRESULT
	ReleasePrimaryBufferInterface as function(byval This as IAMDirectSound ptr, byval buf as IDirectSoundBuffer ptr) as HRESULT
	ReleaseSecondaryBufferInterface as function(byval This as IAMDirectSound ptr, byval buf as IDirectSoundBuffer ptr) as HRESULT
	SetFocusWindow as function(byval This as IAMDirectSound ptr, byval hwnd as HWND, byval bgaudible as WINBOOL) as HRESULT
	GetFocusWindow as function(byval This as IAMDirectSound ptr, byval hwnd as HWND ptr, byval bgaudible as WINBOOL ptr) as HRESULT
end type

end extern
