''
''
'' d3dx9tex -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_d3dx9tex_bi__
#define __win_d3dx9tex_bi__

#include once "win/d3dx9.bi"

#define D3DX_FILTER_NONE (1 shl 0)
#define D3DX_FILTER_POINT (2 shl 0)
#define D3DX_FILTER_LINEAR (3 shl 0)
#define D3DX_FILTER_TRIANGLE (4 shl 0)
#define D3DX_FILTER_BOX (5 shl 0)
#define D3DX_FILTER_MIRROR_U (1 shl 16)
#define D3DX_FILTER_MIRROR_V (2 shl 16)
#define D3DX_FILTER_MIRROR_W (4 shl 16)
#define D3DX_FILTER_MIRROR (7 shl 16)
#define D3DX_FILTER_DITHER (1 shl 19)
#define D3DX_FILTER_DITHER_DIFFUSION (2 shl 19)
#define D3DX_FILTER_SRGB_IN (1 shl 21)
#define D3DX_FILTER_SRGB_OUT (2 shl 21)
#define D3DX_FILTER_SRGB (3 shl 21)
#define D3DX_NORMALMAP_MIRROR_U (1 shl 16)
#define D3DX_NORMALMAP_MIRROR_V (2 shl 16)
#define D3DX_NORMALMAP_MIRROR (3 shl 16)
#define D3DX_NORMALMAP_INVERTSIGN (8 shl 16)
#define D3DX_NORMALMAP_COMPUTE_OCCLUSION (16 shl 16)
#define D3DX_CHANNEL_RED (1 shl 0)
#define D3DX_CHANNEL_BLUE (1 shl 1)
#define D3DX_CHANNEL_GREEN (1 shl 2)
#define D3DX_CHANNEL_ALPHA (1 shl 3)
#define D3DX_CHANNEL_LUMINANCE (1 shl 4)

enum D3DXIMAGE_FILEFORMAT
	D3DXIFF_BMP = 0
	D3DXIFF_JPG = 1
	D3DXIFF_TGA = 2
	D3DXIFF_PNG = 3
	D3DXIFF_DDS = 4
	D3DXIFF_PPM = 5
	D3DXIFF_DIB = 6
	D3DXIFF_HDR = 7
	D3DXIFF_PFM = 8
	D3DXIFF_FORCE_DWORD = &h7fffffff
end enum

type LPD3DXFILL2D as sub(byval as D3DXVECTOR4 ptr, byval as D3DXVECTOR2 ptr, byval as D3DXVECTOR2 ptr, byval as LPVOID)
type LPD3DXFILL3D as sub(byval as D3DXVECTOR4 ptr, byval as D3DXVECTOR3 ptr, byval as D3DXVECTOR3 ptr, byval as LPVOID)

type D3DXIMAGE_INFO
	Width as UINT
	Height as UINT
	Depth as UINT
	MipLevels as UINT
	Format as D3DFORMAT
	ResourceType as D3DRESOURCETYPE
	ImageFileFormat as D3DXIMAGE_FILEFORMAT
end type

declare function D3DXGetImageInfoFromFileInMemory alias "D3DXGetImageInfoFromFileInMemory" (byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFileInMemory alias "D3DXLoadSurfaceFromFileInMemory" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromSurface alias "D3DXLoadSurfaceFromSurface" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval pSrcSurface as LPDIRECT3DSURFACE9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR) as HRESULT
declare function D3DXLoadSurfaceFromMemory alias "D3DXLoadSurfaceFromMemory" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval pSrcMemory as LPCVOID, byval SrcFormat as D3DFORMAT, byval SrcPitch as UINT, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR) as HRESULT
declare function D3DXSaveSurfaceToFileInMemory alias "D3DXSaveSurfaceToFileInMemory" (byval ppDestBuf as LPD3DXBUFFER ptr, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcSurface as LPDIRECT3DSURFACE9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcRect as RECT ptr) as HRESULT
declare function D3DXLoadVolumeFromFileInMemory alias "D3DXLoadVolumeFromFileInMemory" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromVolume alias "D3DXLoadVolumeFromVolume" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval pSrcVolume as LPDIRECT3DVOLUME9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR) as HRESULT
declare function D3DXLoadVolumeFromMemory alias "D3DXLoadVolumeFromMemory" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval pSrcMemory as LPCVOID, byval SrcFormat as D3DFORMAT, byval SrcRowPitch as UINT, byval SrcSlicePitch as UINT, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR) as HRESULT
declare function D3DXSaveVolumeToFileInMemory alias "D3DXSaveVolumeToFileInMemory" (byval ppDestBuf as LPD3DXBUFFER ptr, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcVolume as LPDIRECT3DVOLUME9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcBox as D3DBOX ptr) as HRESULT
declare function D3DXCheckTextureRequirements alias "D3DXCheckTextureRequirements" (byval pDevice as LPDIRECT3DDEVICE9, byval pWidth as UINT ptr, byval pHeight as UINT ptr, byval pNumMipLevels as UINT ptr, byval Usage as DWORD, byval pFormat as D3DFORMAT ptr, byval Pool as D3DPOOL) as HRESULT
declare function D3DXCheckCubeTextureRequirements alias "D3DXCheckCubeTextureRequirements" (byval pDevice as LPDIRECT3DDEVICE9, byval pSize as UINT ptr, byval pNumMipLevels as UINT ptr, byval Usage as DWORD, byval pFormat as D3DFORMAT ptr, byval Pool as D3DPOOL) as HRESULT
declare function D3DXCheckVolumeTextureRequirements alias "D3DXCheckVolumeTextureRequirements" (byval pDevice as LPDIRECT3DDEVICE9, byval pWidth as UINT ptr, byval pHeight as UINT ptr, byval pDepth as UINT ptr, byval pNumMipLevels as UINT ptr, byval Usage as DWORD, byval pFormat as D3DFORMAT ptr, byval Pool as D3DPOOL) as HRESULT
declare function D3DXCreateTexture alias "D3DXCreateTexture" (byval pDevice as LPDIRECT3DDEVICE9, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTexture alias "D3DXCreateCubeTexture" (byval pDevice as LPDIRECT3DDEVICE9, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTexture alias "D3DXCreateVolumeTexture" (byval pDevice as LPDIRECT3DDEVICE9, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromFileInMemory alias "D3DXCreateTextureFromFileInMemory" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemory alias "D3DXCreateCubeTextureFromFileInMemory" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemory alias "D3DXCreateVolumeTextureFromFileInMemory" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromFileInMemoryEx alias "D3DXCreateTextureFromFileInMemoryEx" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileInMemoryEx alias "D3DXCreateCubeTextureFromFileInMemoryEx" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileInMemoryEx alias "D3DXCreateVolumeTextureFromFileInMemoryEx" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcData as LPCVOID, byval SrcDataSize as UINT, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXSaveTextureToFileInMemory alias "D3DXSaveTextureToFileInMemory" (byval ppDestBuf as LPD3DXBUFFER ptr, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcTexture as LPDIRECT3DBASETEXTURE9, byval pSrcPalette as PALETTEENTRY ptr) as HRESULT
declare function D3DXFilterTexture alias "D3DXFilterTexture" (byval pBaseTexture as LPDIRECT3DBASETEXTURE9, byval pPalette as PALETTEENTRY ptr, byval SrcLevel as UINT, byval Filter as DWORD) as HRESULT
declare function D3DXFillTexture alias "D3DXFillTexture" (byval pTexture as LPDIRECT3DTEXTURE9, byval pFunction as LPD3DXFILL2D, byval pData as LPVOID) as HRESULT
declare function D3DXFillCubeTexture alias "D3DXFillCubeTexture" (byval pCubeTexture as LPDIRECT3DCUBETEXTURE9, byval pFunction as LPD3DXFILL3D, byval pData as LPVOID) as HRESULT
declare function D3DXFillVolumeTexture alias "D3DXFillVolumeTexture" (byval pVolumeTexture as LPDIRECT3DVOLUMETEXTURE9, byval pFunction as LPD3DXFILL3D, byval pData as LPVOID) as HRESULT
declare function D3DXFillTextureTX alias "D3DXFillTextureTX" (byval pTexture as LPDIRECT3DTEXTURE9, byval pTextureShader as LPD3DXTEXTURESHADER) as HRESULT
declare function D3DXFillCubeTextureTX alias "D3DXFillCubeTextureTX" (byval pCubeTexture as LPDIRECT3DCUBETEXTURE9, byval pTextureShader as LPD3DXTEXTURESHADER) as HRESULT
declare function D3DXFillVolumeTextureTX alias "D3DXFillVolumeTextureTX" (byval pVolumeTexture as LPDIRECT3DVOLUMETEXTURE9, byval pTextureShader as LPD3DXTEXTURESHADER) as HRESULT
declare function D3DXComputeNormalMap alias "D3DXComputeNormalMap" (byval pTexture as LPDIRECT3DTEXTURE9, byval pSrcTexture as LPDIRECT3DTEXTURE9, byval pSrcPalette as PALETTEENTRY ptr, byval Flags as DWORD, byval Channel as DWORD, byval Amplitude as FLOAT) as HRESULT

#ifdef UNICODE
declare function D3DXGetImageInfoFromFile alias "D3DXGetImageInfoFromFileW" (byval pSrcFile as LPCWSTR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromResource alias "D3DXGetImageInfoFromResourceW" (byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFile alias "D3DXLoadSurfaceFromFileW" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval pSrcFile as LPCWSTR, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromResource alias "D3DXLoadSurfaceFromResourceW" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXSaveSurfaceToFile alias "D3DXSaveSurfaceToFileW" (byval pDestFile as LPCWSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcSurface as LPDIRECT3DSURFACE9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcRect as RECT ptr) as HRESULT
declare function D3DXLoadVolumeFromFile alias "D3DXLoadVolumeFromFileW" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval pSrcFile as LPCWSTR, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromResource alias "D3DXLoadVolumeFromResourceW" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXSaveVolumeToFile alias "D3DXSaveVolumeToFileW" (byval pDestFile as LPCWSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcVolume as LPDIRECT3DVOLUME9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcBox as D3DBOX ptr) as HRESULT
declare function D3DXCreateTextureFromFile alias "D3DXCreateTextureFromFileW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFile alias "D3DXCreateCubeTextureFromFileW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFile alias "D3DXCreateVolumeTextureFromFileW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromResource alias "D3DXCreateTextureFromResourceW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResource alias "D3DXCreateCubeTextureFromResourceW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResource alias "D3DXCreateVolumeTextureFromResourceW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromFileEx alias "D3DXCreateTextureFromFileExW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileEx alias "D3DXCreateCubeTextureFromFileExW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileEx alias "D3DXCreateVolumeTextureFromFileExW" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCWSTR, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromResourceEx alias "D3DXCreateTextureFromResourceExW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceEx alias "D3DXCreateCubeTextureFromResourceExW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceEx alias "D3DXCreateVolumeTextureFromResourceExW" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCWSTR, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXSaveTextureToFile alias "D3DXSaveTextureToFileW" (byval pDestFile as LPCWSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcTexture as LPDIRECT3DBASETEXTURE9, byval pSrcPalette as PALETTEENTRY ptr) as HRESULT

#else
declare function D3DXGetImageInfoFromFile alias "D3DXGetImageInfoFromFileA" (byval pSrcFile as LPCSTR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXGetImageInfoFromResource alias "D3DXGetImageInfoFromResourceA" (byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromFile alias "D3DXLoadSurfaceFromFileA" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval pSrcFile as LPCSTR, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadSurfaceFromResource alias "D3DXLoadSurfaceFromResourceA" (byval pDestSurface as LPDIRECT3DSURFACE9, byval pDestPalette as PALETTEENTRY ptr, byval pDestRect as RECT ptr, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pSrcRect as RECT ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXSaveSurfaceToFile alias "D3DXSaveSurfaceToFileA" (byval pDestFile as LPCSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcSurface as LPDIRECT3DSURFACE9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcRect as RECT ptr) as HRESULT
declare function D3DXLoadVolumeFromFile alias "D3DXLoadVolumeFromFileA" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval pSrcFile as LPCSTR, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXLoadVolumeFromResource alias "D3DXLoadVolumeFromResourceA" (byval pDestVolume as LPDIRECT3DVOLUME9, byval pDestPalette as PALETTEENTRY ptr, byval pDestBox as D3DBOX ptr, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval pSrcBox as D3DBOX ptr, byval Filter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr) as HRESULT
declare function D3DXSaveVolumeToFile alias "D3DXSaveVolumeToFileA" (byval pDestFile as LPCSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcVolume as LPDIRECT3DVOLUME9, byval pSrcPalette as PALETTEENTRY ptr, byval pSrcBox as D3DBOX ptr) as HRESULT
declare function D3DXCreateTextureFromFile alias "D3DXCreateTextureFromFileA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFile alias "D3DXCreateCubeTextureFromFileA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFile alias "D3DXCreateVolumeTextureFromFileA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromResource alias "D3DXCreateTextureFromResourceA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResource alias "D3DXCreateCubeTextureFromResourceA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResource alias "D3DXCreateVolumeTextureFromResourceA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromFileEx alias "D3DXCreateTextureFromFileExA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromFileEx alias "D3DXCreateCubeTextureFromFileExA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromFileEx alias "D3DXCreateVolumeTextureFromFileExA" (byval pDevice as LPDIRECT3DDEVICE9, byval pSrcFile as LPCSTR, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXCreateTextureFromResourceEx alias "D3DXCreateTextureFromResourceExA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval Width as UINT, byval Height as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppTexture as LPDIRECT3DTEXTURE9 ptr) as HRESULT
declare function D3DXCreateCubeTextureFromResourceEx alias "D3DXCreateCubeTextureFromResourceExA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval Size as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppCubeTexture as LPDIRECT3DCUBETEXTURE9 ptr) as HRESULT
declare function D3DXCreateVolumeTextureFromResourceEx alias "D3DXCreateVolumeTextureFromResourceExA" (byval pDevice as LPDIRECT3DDEVICE9, byval hSrcModule as HMODULE, byval pSrcResource as LPCSTR, byval Width as UINT, byval Height as UINT, byval Depth as UINT, byval MipLevels as UINT, byval Usage as DWORD, byval Format as D3DFORMAT, byval Pool as D3DPOOL, byval Filter as DWORD, byval MipFilter as DWORD, byval ColorKey as D3DCOLOR, byval pSrcInfo as D3DXIMAGE_INFO ptr, byval pPalette as PALETTEENTRY ptr, byval ppVolumeTexture as LPDIRECT3DVOLUMETEXTURE9 ptr) as HRESULT
declare function D3DXSaveTextureToFile alias "D3DXSaveTextureToFileA" (byval pDestFile as LPCSTR, byval DestFormat as D3DXIMAGE_FILEFORMAT, byval pSrcTexture as LPDIRECT3DBASETEXTURE9, byval pSrcPalette as PALETTEENTRY ptr) as HRESULT
#endif

#endif
