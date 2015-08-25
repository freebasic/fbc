'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2008 Tony Wasserka
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

#include once "_mingw_unicode.bi"
#include once "d3dx9.bi"

extern "Windows"

#define __WINE_D3DX9TEX_H
const D3DX_FILTER_NONE = &h00000001
const D3DX_FILTER_POINT = &h00000002
const D3DX_FILTER_LINEAR = &h00000003
const D3DX_FILTER_TRIANGLE = &h00000004
const D3DX_FILTER_BOX = &h00000005
const D3DX_FILTER_MIRROR_U = &h00010000
const D3DX_FILTER_MIRROR_V = &h00020000
const D3DX_FILTER_MIRROR_W = &h00040000
const D3DX_FILTER_MIRROR = &h00070000
const D3DX_FILTER_DITHER = &h00080000
const D3DX_FILTER_DITHER_DIFFUSION = &h00100000
const D3DX_FILTER_SRGB_IN = &h00200000
const D3DX_FILTER_SRGB_OUT = &h00400000
const D3DX_FILTER_SRGB = &h00600000
const D3DX_SKIP_DDS_MIP_LEVELS_MASK = &h1f
const D3DX_SKIP_DDS_MIP_LEVELS_SHIFT = 26
#define D3DX_SKIP_DDS_MIP_LEVELS(l, f) ((((l) and D3DX_SKIP_DDS_MIP_LEVELS_MASK) shl D3DX_SKIP_DDS_MIP_LEVELS_SHIFT) or iif((f) = D3DX_DEFAULT, D3DX_FILTER_BOX, (f)))
const D3DX_NORMALMAP_MIRROR_U = &h00010000
const D3DX_NORMALMAP_MIRROR_V = &h00020000
const D3DX_NORMALMAP_MIRROR = &h00030000
const D3DX_NORMALMAP_INVERTSIGN = &h00080000
const D3DX_NORMALMAP_COMPUTE_OCCLUSION = &h00100000
const D3DX_CHANNEL_RED = &h00000001
const D3DX_CHANNEL_BLUE = &h00000002
const D3DX_CHANNEL_GREEN = &h00000004
const D3DX_CHANNEL_ALPHA = &h00000008
const D3DX_CHANNEL_LUMINANCE = &h00000010

type _D3DXIMAGE_FILEFORMAT as long
enum
	D3DXIFF_BMP
	D3DXIFF_JPG
	D3DXIFF_TGA
	D3DXIFF_PNG
	D3DXIFF_DDS
	D3DXIFF_PPM
	D3DXIFF_DIB
	D3DXIFF_HDR
	D3DXIFF_PFM
	D3DXIFF_FORCE_DWORD = &h7fffffff
end enum

type D3DXIMAGE_FILEFORMAT as _D3DXIMAGE_FILEFORMAT

type _D3DXIMAGE_INFO
	Width as UINT
	Height as UINT
	Depth as UINT
	MipLevels as UINT
	Format as D3DFORMAT
	ResourceType as D3DRESOURCETYPE
	ImageFileFormat as D3DXIMAGE_FILEFORMAT
end type

type D3DXIMAGE_INFO as _D3DXIMAGE_INFO
type LPD3DXFILL2D as sub(byval out as D3DXVECTOR4 ptr, byval texcoord as const D3DXVECTOR2 ptr, byval texelsize as const D3DXVECTOR2 ptr, byval data as any ptr)
type LPD3DXFILL3D as sub(byval out as D3DXVECTOR4 ptr, byval texcoord as const D3DXVECTOR3 ptr, byval texelsize as const D3DXVECTOR3 ptr, byval data as any ptr)
declare function D3DXGetImageInfoFromFileA(byval file as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromFileW(byval file as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXGetImageInfoFromFile alias "D3DXGetImageInfoFromFileW"(byval file as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXGetImageInfoFromFile alias "D3DXGetImageInfoFromFileA"(byval file as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXGetImageInfoFromResourceA(byval module as HMODULE, byval resource as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromResourceW(byval module as HMODULE, byval resource as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXGetImageInfoFromResource alias "D3DXGetImageInfoFromResourceW"(byval module as HMODULE, byval resource as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXGetImageInfoFromResource alias "D3DXGetImageInfoFromResourceA"(byval module as HMODULE, byval resource as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXGetImageInfoFromFileInMemory(byval data as const any ptr, byval data_size as UINT, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFileA(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFileW(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadSurfaceFromFile alias "D3DXLoadSurfaceFromFileW"(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXLoadSurfaceFromFile alias "D3DXLoadSurfaceFromFileA"(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXLoadSurfaceFromResourceA(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromResourceW(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadSurfaceFromResource alias "D3DXLoadSurfaceFromResourceW"(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXLoadSurfaceFromResource alias "D3DXLoadSurfaceFromResourceA"(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXLoadSurfaceFromFileInMemory(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromSurface(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXLoadSurfaceFromMemory(byval dst_surface as IDirect3DSurface9 ptr, byval dst_palette as const PALETTEENTRY ptr, byval dst_rect as const RECT ptr, byval src_memory as const any ptr, byval src_format as D3DFORMAT, byval src_pitch as UINT, byval src_palette as const PALETTEENTRY ptr, byval src_rect as const RECT ptr, byval filter as DWORD, byval color_key as D3DCOLOR) as HRESULT
declare function D3DXSaveSurfaceToFileInMemory(byval destbuffer as ID3DXBuffer ptr ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
declare function D3DXSaveSurfaceToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
declare function D3DXSaveSurfaceToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSaveSurfaceToFile alias "D3DXSaveSurfaceToFileW"(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
#else
	declare function D3DXSaveSurfaceToFile alias "D3DXSaveSurfaceToFileA"(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
#endif

declare function D3DXLoadVolumeFromFileA(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromFileW(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadVolumeFromFile alias "D3DXLoadVolumeFromFileW"(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXLoadVolumeFromFile alias "D3DXLoadVolumeFromFileA"(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXLoadVolumeFromResourceA(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromResourceW(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXLoadVolumeFromResource alias "D3DXLoadVolumeFromResourceW"(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#else
	declare function D3DXLoadVolumeFromResource alias "D3DXLoadVolumeFromResourceA"(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
#endif

declare function D3DXLoadVolumeFromFileInMemory(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromVolume(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXLoadVolumeFromMemory(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmemory as const any ptr, byval srcformat as D3DFORMAT, byval srcrowpitch as UINT, byval srcslicepitch as UINT, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXSaveVolumeToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT
declare function D3DXSaveVolumeToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSaveVolumeToFile alias "D3DXSaveVolumeToFileW"(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT
#else
	declare function D3DXSaveVolumeToFile alias "D3DXSaveVolumeToFileA"(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT
#endif

declare function D3DXCheckTextureRequirements(byval device as IDirect3DDevice9 ptr, byval width as UINT ptr, byval height as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCheckCubeTextureRequirements(byval device as IDirect3DDevice9 ptr, byval size as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCheckVolumeTextureRequirements(byval device as IDirect3DDevice9 ptr, byval width as UINT ptr, byval height as UINT ptr, byval depth as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCreateTexture(byval device as IDirect3DDevice9 ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTexture(byval device as IDirect3DDevice9 ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTexture(byval device as IDirect3DDevice9 ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateTextureFromFile alias "D3DXCreateTextureFromFileW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateTextureFromFile alias "D3DXCreateTextureFromFileA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateCubeTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateCubeTextureFromFile alias "D3DXCreateCubeTextureFromFileW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateCubeTextureFromFile alias "D3DXCreateCubeTextureFromFileA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateVolumeTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateVolumeTextureFromFile alias "D3DXCreateVolumeTextureFromFileW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateVolumeTextureFromFile alias "D3DXCreateVolumeTextureFromFileA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateTextureFromResource alias "D3DXCreateTextureFromResourceW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateTextureFromResource alias "D3DXCreateTextureFromResourceA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateCubeTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateCubeTextureFromResource alias "D3DXCreateCubeTextureFromResourceW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateCubeTextureFromResource alias "D3DXCreateCubeTextureFromResourceA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateVolumeTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateVolumeTextureFromResource alias "D3DXCreateVolumeTextureFromResourceW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateVolumeTextureFromResource alias "D3DXCreateVolumeTextureFromResourceA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateTextureFromFileEx alias "D3DXCreateTextureFromFileExW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateTextureFromFileEx alias "D3DXCreateTextureFromFileExA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateCubeTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateCubeTextureFromFileEx alias "D3DXCreateCubeTextureFromFileExW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateCubeTextureFromFileEx alias "D3DXCreateCubeTextureFromFileExA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateVolumeTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateVolumeTextureFromFileEx alias "D3DXCreateVolumeTextureFromFileExW"(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateVolumeTextureFromFileEx alias "D3DXCreateVolumeTextureFromFileExA"(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateTextureFromResourceEx alias "D3DXCreateTextureFromResourceExW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateTextureFromResourceEx alias "D3DXCreateTextureFromResourceExA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateCubeTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateCubeTextureFromResourceEx alias "D3DXCreateCubeTextureFromResourceExW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateCubeTextureFromResourceEx alias "D3DXCreateCubeTextureFromResourceExA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateVolumeTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXCreateVolumeTextureFromResourceEx alias "D3DXCreateVolumeTextureFromResourceExW"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#else
	declare function D3DXCreateVolumeTextureFromResourceEx alias "D3DXCreateVolumeTextureFromResourceExA"(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
#endif

declare function D3DXCreateTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval width as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval width as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXSaveTextureToFileInMemory(byval destbuffer as ID3DXBuffer ptr ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
declare function D3DXSaveTextureToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
declare function D3DXSaveTextureToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT

#ifdef UNICODE
	declare function D3DXSaveTextureToFile alias "D3DXSaveTextureToFileW"(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
#else
	declare function D3DXSaveTextureToFile alias "D3DXSaveTextureToFileA"(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
#endif

declare function D3DXFilterTexture(byval texture as IDirect3DBaseTexture9 ptr, byval palette as const PALETTEENTRY ptr, byval srclevel as UINT, byval filter as DWORD) as HRESULT
declare function D3DXFilterCubeTexture alias "D3DXFilterTexture"(byval texture as IDirect3DBaseTexture9 ptr, byval palette as const PALETTEENTRY ptr, byval srclevel as UINT, byval filter as DWORD) as HRESULT
declare function D3DXFilterVolumeTexture alias "D3DXFilterTexture"(byval texture as IDirect3DBaseTexture9 ptr, byval palette as const PALETTEENTRY ptr, byval srclevel as UINT, byval filter as DWORD) as HRESULT
declare function D3DXFillTexture(byval texture as IDirect3DTexture9 ptr, byval function as LPD3DXFILL2D, byval data as any ptr) as HRESULT
declare function D3DXFillCubeTexture(byval cube as IDirect3DCubeTexture9 ptr, byval function as LPD3DXFILL3D, byval data as any ptr) as HRESULT
declare function D3DXFillVolumeTexture(byval volume as IDirect3DVolumeTexture9 ptr, byval function as LPD3DXFILL3D, byval data as any ptr) as HRESULT
declare function D3DXFillTextureTX(byval texture as IDirect3DTexture9 ptr, byval function as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXFillCubeTextureTX(byval cube as IDirect3DCubeTexture9 ptr, byval function as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXFillVolumeTextureTX(byval volume as IDirect3DVolumeTexture9 ptr, byval function as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXComputeNormalMap(byval texture as IDirect3DTexture9 ptr, byval srctexture as IDirect3DTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval flags as DWORD, byval channel as DWORD, byval amplitude as single) as HRESULT

end extern
