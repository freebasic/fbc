#pragma once

#include once "_mingw_unicode.bi"
#include once "d3dx9.bi"

extern "Windows"

#define __WINE_D3DX9TEX_H
#define D3DX_FILTER_NONE &h00000001
#define D3DX_FILTER_POINT &h00000002
#define D3DX_FILTER_LINEAR &h00000003
#define D3DX_FILTER_TRIANGLE &h00000004
#define D3DX_FILTER_BOX &h00000005
#define D3DX_FILTER_MIRROR_U &h00010000
#define D3DX_FILTER_MIRROR_V &h00020000
#define D3DX_FILTER_MIRROR_W &h00040000
#define D3DX_FILTER_MIRROR &h00070000
#define D3DX_FILTER_DITHER &h00080000
#define D3DX_FILTER_DITHER_DIFFUSION &h00100000
#define D3DX_FILTER_SRGB_IN &h00200000
#define D3DX_FILTER_SRGB_OUT &h00400000
#define D3DX_FILTER_SRGB &h00600000
#define D3DX_NORMALMAP_MIRROR_U &h00010000
#define D3DX_NORMALMAP_MIRROR_V &h00020000
#define D3DX_NORMALMAP_MIRROR &h00030000
#define D3DX_NORMALMAP_INVERTSIGN &h00080000
#define D3DX_NORMALMAP_COMPUTE_OCCLUSION &h00100000
#define D3DX_CHANNEL_RED &h00000001
#define D3DX_CHANNEL_BLUE &h00000002
#define D3DX_CHANNEL_GREEN &h00000004
#define D3DX_CHANNEL_ALPHA &h00000008
#define D3DX_CHANNEL_LUMINANCE &h00000010

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
type LPD3DXFILL2D as sub(byval out_ as D3DXVECTOR4 ptr, byval texcoord as const D3DXVECTOR2 ptr, byval texelsize as const D3DXVECTOR2 ptr, byval data_ as any ptr)
type LPD3DXFILL3D as sub(byval out_ as D3DXVECTOR4 ptr, byval texcoord as const D3DXVECTOR3 ptr, byval texelsize as const D3DXVECTOR3 ptr, byval data_ as any ptr)

declare function D3DXGetImageInfoFromFileA(byval file as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromFileW(byval file as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXGetImageInfoFromFile D3DXGetImageInfoFromFileW
#else
	#define D3DXGetImageInfoFromFile D3DXGetImageInfoFromFileA
#endif

declare function D3DXGetImageInfoFromResourceA(byval module as HMODULE, byval resource as const zstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromResourceW(byval module as HMODULE, byval resource as const wstring ptr, byval info as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXGetImageInfoFromResource D3DXGetImageInfoFromResourceW
#else
	#define D3DXGetImageInfoFromResource D3DXGetImageInfoFromResourceA
#endif

declare function D3DXGetImageInfoFromFileInMemory(byval data_ as const any ptr, byval data_size as UINT, byval info as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFileA(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFileW(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcfile as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXLoadSurfaceFromFile D3DXLoadSurfaceFromFileW
#else
	#define D3DXLoadSurfaceFromFile D3DXLoadSurfaceFromFileA
#endif

declare function D3DXLoadSurfaceFromResourceA(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromResourceW(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXLoadSurfaceFromResource D3DXLoadSurfaceFromResourceW
#else
	#define D3DXLoadSurfaceFromResource D3DXLoadSurfaceFromResourceA
#endif

declare function D3DXLoadSurfaceFromFileInMemory(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromSurface(byval destsurface as IDirect3DSurface9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destrect as const RECT ptr, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXLoadSurfaceFromMemory(byval dst_surface as IDirect3DSurface9 ptr, byval dst_palette as const PALETTEENTRY ptr, byval dst_rect as const RECT ptr, byval src_memory as const any ptr, byval src_format as D3DFORMAT, byval src_pitch as UINT, byval src_palette as const PALETTEENTRY ptr, byval src_rect as const RECT ptr, byval filter as DWORD, byval color_key as D3DCOLOR) as HRESULT
declare function D3DXSaveSurfaceToFileInMemory(byval destbuffer as ID3DXBuffer ptr ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
declare function D3DXSaveSurfaceToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT
declare function D3DXSaveSurfaceToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcsurface as IDirect3DSurface9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcrect as const RECT ptr) as HRESULT

#ifdef UNICODE
	#define D3DXSaveSurfaceToFile D3DXSaveSurfaceToFileW
#else
	#define D3DXSaveSurfaceToFile D3DXSaveSurfaceToFileA
#endif

declare function D3DXLoadVolumeFromFileA(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromFileW(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcfile as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXLoadVolumeFromFile D3DXLoadVolumeFromFileW
#else
	#define D3DXLoadVolumeFromFile D3DXLoadVolumeFromFileA
#endif

declare function D3DXLoadVolumeFromResourceA(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromResourceW(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT

#ifdef UNICODE
	#define D3DXLoadVolumeFromResource D3DXLoadVolumeFromResourceW
#else
	#define D3DXLoadVolumeFromResource D3DXLoadVolumeFromResourceA
#endif

declare function D3DXLoadVolumeFromFileInMemory(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromVolume(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXLoadVolumeFromMemory(byval destvolume as IDirect3DVolume9 ptr, byval destpalette as const PALETTEENTRY ptr, byval destbox as const D3DBOX ptr, byval srcmemory as const any ptr, byval srcformat as D3DFORMAT, byval srcrowpitch as UINT, byval srcslicepitch as UINT, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr, byval filter as DWORD, byval colorkey as D3DCOLOR) as HRESULT
declare function D3DXSaveVolumeToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT
declare function D3DXSaveVolumeToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srcvolume as IDirect3DVolume9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval srcbox as const D3DBOX ptr) as HRESULT

#ifdef UNICODE
	#define D3DXSaveVolumeToFile D3DXSaveVolumeToFileW
#else
	#define D3DXSaveVolumeToFile D3DXSaveVolumeToFileA
#endif

declare function D3DXCheckTextureRequirements(byval device as IDirect3DDevice9 ptr, byval width_ as UINT ptr, byval height as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCheckCubeTextureRequirements(byval device as IDirect3DDevice9 ptr, byval size as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCheckVolumeTextureRequirements(byval device as IDirect3DDevice9 ptr, byval width_ as UINT ptr, byval height as UINT ptr, byval depth as UINT ptr, byval miplevels as UINT ptr, byval usage as DWORD, byval format as D3DFORMAT ptr, byval pool as D3DPOOL) as HRESULT
declare function D3DXCreateTexture(byval device as IDirect3DDevice9 ptr, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTexture(byval device as IDirect3DDevice9 ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTexture(byval device as IDirect3DDevice9 ptr, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateTextureFromFile D3DXCreateTextureFromFileW
#else
	#define D3DXCreateTextureFromFile D3DXCreateTextureFromFileA
#endif

declare function D3DXCreateCubeTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateCubeTextureFromFile D3DXCreateCubeTextureFromFileW
#else
	#define D3DXCreateCubeTextureFromFile D3DXCreateCubeTextureFromFileA
#endif

declare function D3DXCreateVolumeTextureFromFileA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateVolumeTextureFromFile D3DXCreateVolumeTextureFromFileW
#else
	#define D3DXCreateVolumeTextureFromFile D3DXCreateVolumeTextureFromFileA
#endif

declare function D3DXCreateTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateTextureFromResource D3DXCreateTextureFromResourceW
#else
	#define D3DXCreateTextureFromResource D3DXCreateTextureFromResourceA
#endif

declare function D3DXCreateCubeTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateCubeTextureFromResource D3DXCreateCubeTextureFromResourceW
#else
	#define D3DXCreateCubeTextureFromResource D3DXCreateCubeTextureFromResourceA
#endif

declare function D3DXCreateVolumeTextureFromResourceA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateVolumeTextureFromResource D3DXCreateVolumeTextureFromResourceW
#else
	#define D3DXCreateVolumeTextureFromResource D3DXCreateVolumeTextureFromResourceA
#endif

declare function D3DXCreateTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateTextureFromFileEx D3DXCreateTextureFromFileExW
#else
	#define D3DXCreateTextureFromFileEx D3DXCreateTextureFromFileExA
#endif

declare function D3DXCreateCubeTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateCubeTextureFromFileEx D3DXCreateCubeTextureFromFileExW
#else
	#define D3DXCreateCubeTextureFromFileEx D3DXCreateCubeTextureFromFileExA
#endif

declare function D3DXCreateVolumeTextureFromFileExA(byval device as IDirect3DDevice9 ptr, byval srcfile as const zstring ptr, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileExW(byval device as IDirect3DDevice9 ptr, byval srcfile as const wstring ptr, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateVolumeTextureFromFileEx D3DXCreateVolumeTextureFromFileExW
#else
	#define D3DXCreateVolumeTextureFromFileEx D3DXCreateVolumeTextureFromFileExA
#endif

declare function D3DXCreateTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateTextureFromResourceEx D3DXCreateTextureFromResourceExW
#else
	#define D3DXCreateTextureFromResourceEx D3DXCreateTextureFromResourceExA
#endif

declare function D3DXCreateCubeTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateCubeTextureFromResourceEx D3DXCreateCubeTextureFromResourceExW
#else
	#define D3DXCreateCubeTextureFromResourceEx D3DXCreateCubeTextureFromResourceExA
#endif

declare function D3DXCreateVolumeTextureFromResourceExA(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const zstring ptr, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceExW(byval device as IDirect3DDevice9 ptr, byval srcmodule as HMODULE, byval resource as const wstring ptr, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT

#ifdef UNICODE
	#define D3DXCreateVolumeTextureFromResourceEx D3DXCreateVolumeTextureFromResourceExW
#else
	#define D3DXCreateVolumeTextureFromResourceEx D3DXCreateVolumeTextureFromResourceExA
#endif

declare function D3DXCreateTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemory(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval width_ as UINT, byval height as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval texture as IDirect3DTexture9 ptr ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval size as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval cube as IDirect3DCubeTexture9 ptr ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemoryEx(byval device as IDirect3DDevice9 ptr, byval srcdata as const any ptr, byval srcdatasize as UINT, byval width_ as UINT, byval height as UINT, byval depth as UINT, byval miplevels as UINT, byval usage as DWORD, byval format as D3DFORMAT, byval pool as D3DPOOL, byval filter as DWORD, byval mipfilter as DWORD, byval colorkey as D3DCOLOR, byval srcinfo as D3DXIMAGE_INFO ptr, byval palette_ as PALETTEENTRY ptr, byval volume as IDirect3DVolumeTexture9 ptr ptr) as HRESULT
declare function D3DXSaveTextureToFileInMemory(byval destbuffer as ID3DXBuffer ptr ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
declare function D3DXSaveTextureToFileA(byval destfile as const zstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT
declare function D3DXSaveTextureToFileW(byval destfile as const wstring ptr, byval destformat as D3DXIMAGE_FILEFORMAT, byval srctexture as IDirect3DBaseTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr) as HRESULT

#ifdef UNICODE
	#define D3DXSaveTextureToFile D3DXSaveTextureToFileW
#else
	#define D3DXSaveTextureToFile D3DXSaveTextureToFileA
#endif

declare function D3DXFilterTexture(byval texture as IDirect3DBaseTexture9 ptr, byval palette_ as const PALETTEENTRY ptr, byval srclevel as UINT, byval filter as DWORD) as HRESULT

#define D3DXFilterCubeTexture D3DXFilterTexture
#define D3DXFilterVolumeTexture D3DXFilterTexture

declare function D3DXFillTexture(byval texture as IDirect3DTexture9 ptr, byval function_ as LPD3DXFILL2D, byval data_ as any ptr) as HRESULT
declare function D3DXFillCubeTexture(byval cube as IDirect3DCubeTexture9 ptr, byval function_ as LPD3DXFILL3D, byval data_ as any ptr) as HRESULT
declare function D3DXFillVolumeTexture(byval volume as IDirect3DVolumeTexture9 ptr, byval function_ as LPD3DXFILL3D, byval data_ as any ptr) as HRESULT
declare function D3DXFillTextureTX(byval texture as IDirect3DTexture9 ptr, byval function_ as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXFillCubeTextureTX(byval cube as IDirect3DCubeTexture9 ptr, byval function_ as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXFillVolumeTextureTX(byval volume as IDirect3DVolumeTexture9 ptr, byval function_ as const DWORD ptr, byval constants as const D3DXVECTOR4 ptr, byval numconstants as UINT) as HRESULT
declare function D3DXComputeNormalMap(byval texture as IDirect3DTexture9 ptr, byval srctexture as IDirect3DTexture9 ptr, byval srcpalette as const PALETTEENTRY ptr, byval flags as DWORD, byval channel as DWORD, byval amplitude as single) as HRESULT

end extern
