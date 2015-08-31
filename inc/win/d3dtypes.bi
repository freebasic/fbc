'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   Copyright (C) 2000 Peter Hunnisett
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

#include once "windows.bi"
#include once "ddraw.bi"

extern "Windows"

#define __WINE_D3DTYPES_H
#define D3DVALP(val, prec) csng(val)
#define D3DVAL(val) csng(val)
#define D3DDivide(a, b) csng(cdbl(a) / cdbl(b))
#define D3DMultiply(a, b) ((a) * (b))
type D3DFIXED as LONG
#define CI_GETALPHA(ci) ((ci) shr 24)
#define CI_GETINDEX(ci) (((ci) shr 8) and &hffff)
#define CI_GETFRACTION(ci) ((ci) and &hff)
#define CI_ROUNDINDEX(ci) CI_GETINDEX((ci) + &h80)
#define CI_MASKALPHA(ci) ((ci) and &hffffff)
#define CI_MAKE(a, i, f) ((((a) shl 24) or ((i) shl 8)) or (f))
#define RGBA_GETALPHA(rgb) ((rgb) shr 24)
#define RGBA_GETRED(rgb) (((rgb) shr 16) and &hff)
#define RGBA_GETGREEN(rgb) (((rgb) shr 8) and &hff)
#define RGBA_GETBLUE(rgb) ((rgb) and &hff)
#define RGBA_MAKE(r, g, b, a) cast(D3DCOLOR, ((((a) shl 24) or ((r) shl 16)) or ((g) shl 8)) or (b))
#define D3DRGB(r, g, b) (((&hff000000 or (cast(LONG, (r) * 255) shl 16)) or (cast(LONG, (g) * 255) shl 8)) or cast(LONG, (b) * 255))
#define D3DRGBA(r, g, b, a) ((((cast(LONG, (a) * 255) shl 24) or (cast(LONG, (r) * 255) shl 16)) or (cast(LONG, (g) * 255) shl 8)) or cast(LONG, (b) * 255))
#define RGB_GETRED(rgb) (((rgb) shr 16) and &hff)
#define RGB_GETGREEN(rgb) (((rgb) shr 8) and &hff)
#define RGB_GETBLUE(rgb) ((rgb) and &hff)
#define RGBA_SETALPHA(rgba, x) (((x) shl 24) or ((rgba) and &h00ffffff))
#define RGB_MAKE(r, g, b) cast(D3DCOLOR, (((r) shl 16) or ((g) shl 8)) or (b))
#define RGBA_TORGB(rgba) cast(D3DCOLOR, (rgba) and &hffffff)
#define RGB_TORGBA(rgb) cast(D3DCOLOR, (rgb) or &hff000000)
const D3DENUMRET_CANCEL = DDENUMRET_CANCEL
const D3DENUMRET_OK = DDENUMRET_OK

type LPD3DVALIDATECALLBACK as function(byval ctx as any ptr, byval offset as DWORD) as HRESULT
type LPD3DENUMTEXTUREFORMATSCALLBACK as function(byval surface_desc as DDSURFACEDESC ptr, byval ctx as any ptr) as HRESULT
type LPD3DENUMPIXELFORMATSCALLBACK as function(byval format as DDPIXELFORMAT ptr, byval ctx as any ptr) as HRESULT
type D3DVALUE as single
type LPD3DVALUE as single ptr
type D3DCOLOR as DWORD
type LPD3DCOLOR as DWORD ptr
#define D3DCOLOR_DEFINED

#ifdef __FB_64BIT__
	type _D3DVECTOR
		union
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union
			z as D3DVALUE
			dvZ as D3DVALUE
		end union
	end type
#else
	type _D3DVECTOR field = 4
		union field = 4
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union field = 4
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union field = 4
			z as D3DVALUE
			dvZ as D3DVALUE
		end union
	end type
#endif

type D3DVECTOR as _D3DVECTOR
type LPD3DVECTOR as _D3DVECTOR ptr
#define D3DVECTOR_DEFINED
#define DX_SHARED_DEFINES
type D3DMATERIALHANDLE as DWORD
type LPD3DMATERIALHANDLE as DWORD ptr
type D3DTEXTUREHANDLE as DWORD
type LPD3DTEXTUREHANDLE as DWORD ptr
type D3DMATRIXHANDLE as DWORD
type LPD3DMATRIXHANDLE as DWORD ptr

#ifdef __FB_64BIT__
	type _D3DCOLORVALUE
		union
			r as D3DVALUE
			dvR as D3DVALUE
		end union

		union
			g as D3DVALUE
			dvG as D3DVALUE
		end union

		union
			b as D3DVALUE
			dvB as D3DVALUE
		end union

		union
			a as D3DVALUE
			dvA as D3DVALUE
		end union
	end type
#else
	type _D3DCOLORVALUE field = 4
		union field = 4
			r as D3DVALUE
			dvR as D3DVALUE
		end union

		union field = 4
			g as D3DVALUE
			dvG as D3DVALUE
		end union

		union field = 4
			b as D3DVALUE
			dvB as D3DVALUE
		end union

		union field = 4
			a as D3DVALUE
			dvA as D3DVALUE
		end union
	end type
#endif

type D3DCOLORVALUE as _D3DCOLORVALUE
type LPD3DCOLORVALUE as _D3DCOLORVALUE ptr

#ifdef __FB_64BIT__
	type _D3DRECT
		union
			x1 as LONG
			lX1 as LONG
		end union

		union
			y1 as LONG
			lY1 as LONG
		end union

		union
			x2 as LONG
			lX2 as LONG
		end union

		union
			y2 as LONG
			lY2 as LONG
		end union
	end type
#else
	type _D3DRECT field = 4
		union field = 4
			x1 as LONG
			lX1 as LONG
		end union

		union field = 4
			y1 as LONG
			lY1 as LONG
		end union

		union field = 4
			x2 as LONG
			lX2 as LONG
		end union

		union field = 4
			y2 as LONG
			lY2 as LONG
		end union
	end type
#endif

type D3DRECT as _D3DRECT
type LPD3DRECT as _D3DRECT ptr

#ifdef __FB_64BIT__
	type _D3DHVERTEX
		dwFlags as DWORD

		union
			hx as D3DVALUE
			dvHX as D3DVALUE
		end union

		union
			hy as D3DVALUE
			dvHY as D3DVALUE
		end union

		union
			hz as D3DVALUE
			dvHZ as D3DVALUE
		end union
	end type
#else
	type _D3DHVERTEX field = 4
		dwFlags as DWORD

		union field = 4
			hx as D3DVALUE
			dvHX as D3DVALUE
		end union

		union field = 4
			hy as D3DVALUE
			dvHY as D3DVALUE
		end union

		union field = 4
			hz as D3DVALUE
			dvHZ as D3DVALUE
		end union
	end type
#endif

type D3DHVERTEX as _D3DHVERTEX
type LPD3DHVERTEX as _D3DHVERTEX ptr

#ifdef __FB_64BIT__
	type _D3DTLVERTEX
		union
			sx as D3DVALUE
			dvSX as D3DVALUE
		end union

		union
			sy as D3DVALUE
			dvSY as D3DVALUE
		end union

		union
			sz as D3DVALUE
			dvSZ as D3DVALUE
		end union

		union
			rhw as D3DVALUE
			dvRHW as D3DVALUE
		end union

		union
			color as D3DCOLOR
			dcColor as D3DCOLOR
		end union

		union
			specular as D3DCOLOR
			dcSpecular as D3DCOLOR
		end union

		union
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#else
	type _D3DTLVERTEX field = 4
		union field = 4
			sx as D3DVALUE
			dvSX as D3DVALUE
		end union

		union field = 4
			sy as D3DVALUE
			dvSY as D3DVALUE
		end union

		union field = 4
			sz as D3DVALUE
			dvSZ as D3DVALUE
		end union

		union field = 4
			rhw as D3DVALUE
			dvRHW as D3DVALUE
		end union

		union field = 4
			color as D3DCOLOR
			dcColor as D3DCOLOR
		end union

		union field = 4
			specular as D3DCOLOR
			dcSpecular as D3DCOLOR
		end union

		union field = 4
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union field = 4
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#endif

type D3DTLVERTEX as _D3DTLVERTEX
type LPD3DTLVERTEX as _D3DTLVERTEX ptr

#ifdef __FB_64BIT__
	type _D3DLVERTEX
		union
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union
			z as D3DVALUE
			dvZ as D3DVALUE
		end union

		dwReserved as DWORD

		union
			color as D3DCOLOR
			dcColor as D3DCOLOR
		end union

		union
			specular as D3DCOLOR
			dcSpecular as D3DCOLOR
		end union

		union
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#else
	type _D3DLVERTEX field = 4
		union field = 4
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union field = 4
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union field = 4
			z as D3DVALUE
			dvZ as D3DVALUE
		end union

		dwReserved as DWORD

		union field = 4
			color as D3DCOLOR
			dcColor as D3DCOLOR
		end union

		union field = 4
			specular as D3DCOLOR
			dcSpecular as D3DCOLOR
		end union

		union field = 4
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union field = 4
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#endif

type D3DLVERTEX as _D3DLVERTEX
type LPD3DLVERTEX as _D3DLVERTEX ptr

#ifdef __FB_64BIT__
	type _D3DVERTEX
		union
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union
			z as D3DVALUE
			dvZ as D3DVALUE
		end union

		union
			nx as D3DVALUE
			dvNX as D3DVALUE
		end union

		union
			ny as D3DVALUE
			dvNY as D3DVALUE
		end union

		union
			nz as D3DVALUE
			dvNZ as D3DVALUE
		end union

		union
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#else
	type _D3DVERTEX field = 4
		union field = 4
			x as D3DVALUE
			dvX as D3DVALUE
		end union

		union field = 4
			y as D3DVALUE
			dvY as D3DVALUE
		end union

		union field = 4
			z as D3DVALUE
			dvZ as D3DVALUE
		end union

		union field = 4
			nx as D3DVALUE
			dvNX as D3DVALUE
		end union

		union field = 4
			ny as D3DVALUE
			dvNY as D3DVALUE
		end union

		union field = 4
			nz as D3DVALUE
			dvNZ as D3DVALUE
		end union

		union field = 4
			tu as D3DVALUE
			dvTU as D3DVALUE
		end union

		union field = 4
			tv as D3DVALUE
			dvTV as D3DVALUE
		end union
	end type
#endif

type D3DVERTEX as _D3DVERTEX
type LPD3DVERTEX as _D3DVERTEX ptr

#ifdef __FB_64BIT__
	type _D3DMATRIX
		_11 as D3DVALUE
		_12 as D3DVALUE
		_13 as D3DVALUE
		_14 as D3DVALUE
		_21 as D3DVALUE
		_22 as D3DVALUE
		_23 as D3DVALUE
		_24 as D3DVALUE
		_31 as D3DVALUE
		_32 as D3DVALUE
		_33 as D3DVALUE
		_34 as D3DVALUE
		_41 as D3DVALUE
		_42 as D3DVALUE
		_43 as D3DVALUE
		_44 as D3DVALUE
	end type
#else
	type _D3DMATRIX field = 4
		_11 as D3DVALUE
		_12 as D3DVALUE
		_13 as D3DVALUE
		_14 as D3DVALUE
		_21 as D3DVALUE
		_22 as D3DVALUE
		_23 as D3DVALUE
		_24 as D3DVALUE
		_31 as D3DVALUE
		_32 as D3DVALUE
		_33 as D3DVALUE
		_34 as D3DVALUE
		_41 as D3DVALUE
		_42 as D3DVALUE
		_43 as D3DVALUE
		_44 as D3DVALUE
	end type
#endif

type D3DMATRIX as _D3DMATRIX
type LPD3DMATRIX as _D3DMATRIX ptr

#ifdef __FB_64BIT__
	type _D3DVIEWPORT
		dwSize as DWORD
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvScaleX as D3DVALUE
		dvScaleY as D3DVALUE
		dvMaxX as D3DVALUE
		dvMaxY as D3DVALUE
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#else
	type _D3DVIEWPORT field = 4
		dwSize as DWORD
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvScaleX as D3DVALUE
		dvScaleY as D3DVALUE
		dvMaxX as D3DVALUE
		dvMaxY as D3DVALUE
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#endif

type D3DVIEWPORT as _D3DVIEWPORT
type LPD3DVIEWPORT as _D3DVIEWPORT ptr

#ifdef __FB_64BIT__
	type _D3DVIEWPORT2
		dwSize as DWORD
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvClipX as D3DVALUE
		dvClipY as D3DVALUE
		dvClipWidth as D3DVALUE
		dvClipHeight as D3DVALUE
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#else
	type _D3DVIEWPORT2 field = 4
		dwSize as DWORD
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvClipX as D3DVALUE
		dvClipY as D3DVALUE
		dvClipWidth as D3DVALUE
		dvClipHeight as D3DVALUE
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#endif

type D3DVIEWPORT2 as _D3DVIEWPORT2
type LPD3DVIEWPORT2 as _D3DVIEWPORT2 ptr

#ifdef __FB_64BIT__
	type _D3DVIEWPORT7
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#else
	type _D3DVIEWPORT7 field = 4
		dwX as DWORD
		dwY as DWORD
		dwWidth as DWORD
		dwHeight as DWORD
		dvMinZ as D3DVALUE
		dvMaxZ as D3DVALUE
	end type
#endif

type D3DVIEWPORT7 as _D3DVIEWPORT7
type LPD3DVIEWPORT7 as _D3DVIEWPORT7 ptr
const D3DMAXUSERCLIPPLANES = 32
const D3DCLIPPLANE0 = 1 shl 0
const D3DCLIPPLANE1 = 1 shl 1
const D3DCLIPPLANE2 = 1 shl 2
const D3DCLIPPLANE3 = 1 shl 3
const D3DCLIPPLANE4 = 1 shl 4
const D3DCLIPPLANE5 = 1 shl 5
const D3DCLIP_LEFT = &h00000001
const D3DCLIP_RIGHT = &h00000002
const D3DCLIP_TOP = &h00000004
const D3DCLIP_BOTTOM = &h00000008
const D3DCLIP_FRONT = &h00000010
const D3DCLIP_BACK = &h00000020
const D3DCLIP_GEN0 = &h00000040
const D3DCLIP_GEN1 = &h00000080
const D3DCLIP_GEN2 = &h00000100
const D3DCLIP_GEN3 = &h00000200
const D3DCLIP_GEN4 = &h00000400
const D3DCLIP_GEN5 = &h00000800
const D3DSTATUS_CLIPUNIONLEFT = D3DCLIP_LEFT
const D3DSTATUS_CLIPUNIONRIGHT = D3DCLIP_RIGHT
const D3DSTATUS_CLIPUNIONTOP = D3DCLIP_TOP
const D3DSTATUS_CLIPUNIONBOTTOM = D3DCLIP_BOTTOM
const D3DSTATUS_CLIPUNIONFRONT = D3DCLIP_FRONT
const D3DSTATUS_CLIPUNIONBACK = D3DCLIP_BACK
const D3DSTATUS_CLIPUNIONGEN0 = D3DCLIP_GEN0
const D3DSTATUS_CLIPUNIONGEN1 = D3DCLIP_GEN1
const D3DSTATUS_CLIPUNIONGEN2 = D3DCLIP_GEN2
const D3DSTATUS_CLIPUNIONGEN3 = D3DCLIP_GEN3
const D3DSTATUS_CLIPUNIONGEN4 = D3DCLIP_GEN4
const D3DSTATUS_CLIPUNIONGEN5 = D3DCLIP_GEN5
const D3DSTATUS_CLIPINTERSECTIONLEFT = &h00001000
const D3DSTATUS_CLIPINTERSECTIONRIGHT = &h00002000
const D3DSTATUS_CLIPINTERSECTIONTOP = &h00004000
const D3DSTATUS_CLIPINTERSECTIONBOTTOM = &h00008000
const D3DSTATUS_CLIPINTERSECTIONFRONT = &h00010000
const D3DSTATUS_CLIPINTERSECTIONBACK = &h00020000
const D3DSTATUS_CLIPINTERSECTIONGEN0 = &h00040000
const D3DSTATUS_CLIPINTERSECTIONGEN1 = &h00080000
const D3DSTATUS_CLIPINTERSECTIONGEN2 = &h00100000
const D3DSTATUS_CLIPINTERSECTIONGEN3 = &h00200000
const D3DSTATUS_CLIPINTERSECTIONGEN4 = &h00400000
const D3DSTATUS_CLIPINTERSECTIONGEN5 = &h00800000
const D3DSTATUS_ZNOTVISIBLE = &h01000000
const D3DSTATUS_CLIPUNIONALL = ((((((((((D3DSTATUS_CLIPUNIONLEFT or D3DSTATUS_CLIPUNIONRIGHT) or D3DSTATUS_CLIPUNIONTOP) or D3DSTATUS_CLIPUNIONBOTTOM) or D3DSTATUS_CLIPUNIONFRONT) or D3DSTATUS_CLIPUNIONBACK) or D3DSTATUS_CLIPUNIONGEN0) or D3DSTATUS_CLIPUNIONGEN1) or D3DSTATUS_CLIPUNIONGEN2) or D3DSTATUS_CLIPUNIONGEN3) or D3DSTATUS_CLIPUNIONGEN4) or D3DSTATUS_CLIPUNIONGEN5
const D3DSTATUS_CLIPINTERSECTIONALL = ((((((((((D3DSTATUS_CLIPINTERSECTIONLEFT or D3DSTATUS_CLIPINTERSECTIONRIGHT) or D3DSTATUS_CLIPINTERSECTIONTOP) or D3DSTATUS_CLIPINTERSECTIONBOTTOM) or D3DSTATUS_CLIPINTERSECTIONFRONT) or D3DSTATUS_CLIPINTERSECTIONBACK) or D3DSTATUS_CLIPINTERSECTIONGEN0) or D3DSTATUS_CLIPINTERSECTIONGEN1) or D3DSTATUS_CLIPINTERSECTIONGEN2) or D3DSTATUS_CLIPINTERSECTIONGEN3) or D3DSTATUS_CLIPINTERSECTIONGEN4) or D3DSTATUS_CLIPINTERSECTIONGEN5
const D3DSTATUS_DEFAULT = D3DSTATUS_CLIPINTERSECTIONALL or D3DSTATUS_ZNOTVISIBLE
const D3DTRANSFORM_CLIPPED = &h00000001
const D3DTRANSFORM_UNCLIPPED = &h00000002

#ifdef __FB_64BIT__
	type _D3DTRANSFORMDATA
		dwSize as DWORD
		lpIn as any ptr
		dwInSize as DWORD
		lpOut as any ptr
		dwOutSize as DWORD
		lpHOut as D3DHVERTEX ptr
		dwClip as DWORD
		dwClipIntersection as DWORD
		dwClipUnion as DWORD
		drExtent as D3DRECT
	end type
#else
	type _D3DTRANSFORMDATA field = 4
		dwSize as DWORD
		lpIn as any ptr
		dwInSize as DWORD
		lpOut as any ptr
		dwOutSize as DWORD
		lpHOut as D3DHVERTEX ptr
		dwClip as DWORD
		dwClipIntersection as DWORD
		dwClipUnion as DWORD
		drExtent as D3DRECT
	end type
#endif

type D3DTRANSFORMDATA as _D3DTRANSFORMDATA
type LPD3DTRANSFORMDATA as _D3DTRANSFORMDATA ptr

#ifdef __FB_64BIT__
	type _D3DLIGHTINGELEMENT
		dvPosition as D3DVECTOR
		dvNormal as D3DVECTOR
	end type
#else
	type _D3DLIGHTINGELEMENT field = 4
		dvPosition as D3DVECTOR
		dvNormal as D3DVECTOR
	end type
#endif

type D3DLIGHTINGELEMENT as _D3DLIGHTINGELEMENT
type LPD3DLIGHTINGELEMENT as _D3DLIGHTINGELEMENT ptr

#ifdef __FB_64BIT__
	type _D3DMATERIAL
		dwSize as DWORD

		union
			diffuse as D3DCOLORVALUE
			dcvDiffuse as D3DCOLORVALUE
		end union

		union
			ambient as D3DCOLORVALUE
			dcvAmbient as D3DCOLORVALUE
		end union

		union
			specular as D3DCOLORVALUE
			dcvSpecular as D3DCOLORVALUE
		end union

		union
			emissive as D3DCOLORVALUE
			dcvEmissive as D3DCOLORVALUE
		end union

		union
			power as D3DVALUE
			dvPower as D3DVALUE
		end union

		hTexture as D3DTEXTUREHANDLE
		dwRampSize as DWORD
	end type
#else
	type _D3DMATERIAL field = 4
		dwSize as DWORD

		union field = 4
			diffuse as D3DCOLORVALUE
			dcvDiffuse as D3DCOLORVALUE
		end union

		union field = 4
			ambient as D3DCOLORVALUE
			dcvAmbient as D3DCOLORVALUE
		end union

		union field = 4
			specular as D3DCOLORVALUE
			dcvSpecular as D3DCOLORVALUE
		end union

		union field = 4
			emissive as D3DCOLORVALUE
			dcvEmissive as D3DCOLORVALUE
		end union

		union field = 4
			power as D3DVALUE
			dvPower as D3DVALUE
		end union

		hTexture as D3DTEXTUREHANDLE
		dwRampSize as DWORD
	end type
#endif

type D3DMATERIAL as _D3DMATERIAL
type LPD3DMATERIAL as _D3DMATERIAL ptr

#ifdef __FB_64BIT__
	type _D3DMATERIAL7
		union
			diffuse as D3DCOLORVALUE
			dcvDiffuse as D3DCOLORVALUE
		end union

		union
			ambient as D3DCOLORVALUE
			dcvAmbient as D3DCOLORVALUE
		end union

		union
			specular as D3DCOLORVALUE
			dcvSpecular as D3DCOLORVALUE
		end union

		union
			emissive as D3DCOLORVALUE
			dcvEmissive as D3DCOLORVALUE
		end union

		union
			power as D3DVALUE
			dvPower as D3DVALUE
		end union
	end type
#else
	type _D3DMATERIAL7 field = 4
		union field = 4
			diffuse as D3DCOLORVALUE
			dcvDiffuse as D3DCOLORVALUE
		end union

		union field = 4
			ambient as D3DCOLORVALUE
			dcvAmbient as D3DCOLORVALUE
		end union

		union field = 4
			specular as D3DCOLORVALUE
			dcvSpecular as D3DCOLORVALUE
		end union

		union field = 4
			emissive as D3DCOLORVALUE
			dcvEmissive as D3DCOLORVALUE
		end union

		union field = 4
			power as D3DVALUE
			dvPower as D3DVALUE
		end union
	end type
#endif

type D3DMATERIAL7 as _D3DMATERIAL7
type LPD3DMATERIAL7 as _D3DMATERIAL7 ptr

type D3DLIGHTTYPE as long
enum
	D3DLIGHT_POINT = 1
	D3DLIGHT_SPOT = 2
	D3DLIGHT_DIRECTIONAL = 3
	D3DLIGHT_PARALLELPOINT = 4
	D3DLIGHT_GLSPOT = 5
	D3DLIGHT_FORCE_DWORD = &h7fffffff
end enum

#ifdef __FB_64BIT__
	type _D3DLIGHT
		dwSize as DWORD
		dltType as D3DLIGHTTYPE
		dcvColor as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
	end type
#else
	type _D3DLIGHT field = 4
		dwSize as DWORD
		dltType as D3DLIGHTTYPE
		dcvColor as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
	end type
#endif

type D3DLIGHT as _D3DLIGHT
type LPD3DLIGHT as _D3DLIGHT ptr

#ifdef __FB_64BIT__
	type _D3DLIGHT7
		dltType as D3DLIGHTTYPE
		dcvDiffuse as D3DCOLORVALUE
		dcvSpecular as D3DCOLORVALUE
		dcvAmbient as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
	end type
#else
	type _D3DLIGHT7 field = 4
		dltType as D3DLIGHTTYPE
		dcvDiffuse as D3DCOLORVALUE
		dcvSpecular as D3DCOLORVALUE
		dcvAmbient as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
	end type
#endif

type D3DLIGHT7 as _D3DLIGHT7
type LPD3DLIGHT7 as _D3DLIGHT7 ptr
const D3DLIGHT_ACTIVE = &h00000001
const D3DLIGHT_NO_SPECULAR = &h00000002
const D3DLIGHT_ALL = D3DLIGHT_ACTIVE or D3DLIGHT_NO_SPECULAR
#define D3DLIGHT_RANGE_MAX csng(sqrt(FLT_MAX))

#ifdef __FB_64BIT__
	type _D3DLIGHT2
		dwSize as DWORD
		dltType as D3DLIGHTTYPE
		dcvColor as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
		dwFlags as DWORD
	end type
#else
	type _D3DLIGHT2 field = 4
		dwSize as DWORD
		dltType as D3DLIGHTTYPE
		dcvColor as D3DCOLORVALUE
		dvPosition as D3DVECTOR
		dvDirection as D3DVECTOR
		dvRange as D3DVALUE
		dvFalloff as D3DVALUE
		dvAttenuation0 as D3DVALUE
		dvAttenuation1 as D3DVALUE
		dvAttenuation2 as D3DVALUE
		dvTheta as D3DVALUE
		dvPhi as D3DVALUE
		dwFlags as DWORD
	end type
#endif

type D3DLIGHT2 as _D3DLIGHT2
type LPD3DLIGHT2 as _D3DLIGHT2 ptr

#ifdef __FB_64BIT__
	type _D3DLIGHTDATA
		dwSize as DWORD
		lpIn as D3DLIGHTINGELEMENT ptr
		dwInSize as DWORD
		lpOut as D3DTLVERTEX ptr
		dwOutSize as DWORD
	end type
#else
	type _D3DLIGHTDATA field = 4
		dwSize as DWORD
		lpIn as D3DLIGHTINGELEMENT ptr
		dwInSize as DWORD
		lpOut as D3DTLVERTEX ptr
		dwOutSize as DWORD
	end type
#endif

type D3DLIGHTDATA as _D3DLIGHTDATA
type LPD3DLIGHTDATA as _D3DLIGHTDATA ptr
const D3DCOLOR_MONO = 1
const D3DCOLOR_RGB = 2
type D3DCOLORMODEL as DWORD
const D3DCLEAR_TARGET = &h00000001
const D3DCLEAR_ZBUFFER = &h00000002
const D3DCLEAR_STENCIL = &h00000004

type _D3DOPCODE as long
enum
	D3DOP_POINT = 1
	D3DOP_LINE = 2
	D3DOP_TRIANGLE = 3
	D3DOP_MATRIXLOAD = 4
	D3DOP_MATRIXMULTIPLY = 5
	D3DOP_STATETRANSFORM = 6
	D3DOP_STATELIGHT = 7
	D3DOP_STATERENDER = 8
	D3DOP_PROCESSVERTICES = 9
	D3DOP_TEXTURELOAD = 10
	D3DOP_EXIT = 11
	D3DOP_BRANCHFORWARD = 12
	D3DOP_SPAN = 13
	D3DOP_SETSTATUS = 14
	D3DOP_FORCE_DWORD = &h7fffffff
end enum

type D3DOPCODE as _D3DOPCODE

#ifdef __FB_64BIT__
	type _D3DINSTRUCTION
		bOpcode as UBYTE
		bSize as UBYTE
		wCount as WORD
	end type
#else
	type _D3DINSTRUCTION field = 4
		bOpcode as UBYTE
		bSize as UBYTE
		wCount as WORD
	end type
#endif

type D3DINSTRUCTION as _D3DINSTRUCTION
type LPD3DINSTRUCTION as _D3DINSTRUCTION ptr

#ifdef __FB_64BIT__
	type _D3DTEXTURELOAD
		hDestTexture as D3DTEXTUREHANDLE
		hSrcTexture as D3DTEXTUREHANDLE
	end type
#else
	type _D3DTEXTURELOAD field = 4
		hDestTexture as D3DTEXTUREHANDLE
		hSrcTexture as D3DTEXTUREHANDLE
	end type
#endif

type D3DTEXTURELOAD as _D3DTEXTURELOAD
type LPD3DTEXTURELOAD as _D3DTEXTURELOAD ptr

#ifdef __FB_64BIT__
	type _D3DPICKRECORD
		bOpcode as UBYTE
		bPad as UBYTE
		dwOffset as DWORD
		dvZ as D3DVALUE
	end type
#else
	type _D3DPICKRECORD field = 4
		bOpcode as UBYTE
		bPad as UBYTE
		dwOffset as DWORD
		dvZ as D3DVALUE
	end type
#endif

type D3DPICKRECORD as _D3DPICKRECORD
type LPD3DPICKRECORD as _D3DPICKRECORD ptr

type D3DSHADEMODE as long
enum
	D3DSHADE_FLAT = 1
	D3DSHADE_GOURAUD = 2
	D3DSHADE_PHONG = 3
	D3DSHADE_FORCE_DWORD = &h7fffffff
end enum

type D3DFILLMODE as long
enum
	D3DFILL_POINT = 1
	D3DFILL_WIREFRAME = 2
	D3DFILL_SOLID = 3
	D3DFILL_FORCE_DWORD = &h7fffffff
end enum

#ifdef __FB_64BIT__
	type _D3DLINEPATTERN
		wRepeatFactor as WORD
		wLinePattern as WORD
	end type
#else
	type _D3DLINEPATTERN field = 4
		wRepeatFactor as WORD
		wLinePattern as WORD
	end type
#endif

type D3DLINEPATTERN as _D3DLINEPATTERN

type D3DTEXTUREFILTER as long
enum
	D3DFILTER_NEAREST = 1
	D3DFILTER_LINEAR = 2
	D3DFILTER_MIPNEAREST = 3
	D3DFILTER_MIPLINEAR = 4
	D3DFILTER_LINEARMIPNEAREST = 5
	D3DFILTER_LINEARMIPLINEAR = 6
	D3DFILTER_FORCE_DWORD = &h7fffffff
end enum

type D3DBLEND as long
enum
	D3DBLEND_ZERO = 1
	D3DBLEND_ONE = 2
	D3DBLEND_SRCCOLOR = 3
	D3DBLEND_INVSRCCOLOR = 4
	D3DBLEND_SRCALPHA = 5
	D3DBLEND_INVSRCALPHA = 6
	D3DBLEND_DESTALPHA = 7
	D3DBLEND_INVDESTALPHA = 8
	D3DBLEND_DESTCOLOR = 9
	D3DBLEND_INVDESTCOLOR = 10
	D3DBLEND_SRCALPHASAT = 11
	D3DBLEND_BOTHSRCALPHA = 12
	D3DBLEND_BOTHINVSRCALPHA = 13
	D3DBLEND_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREBLEND as long
enum
	D3DTBLEND_DECAL = 1
	D3DTBLEND_MODULATE = 2
	D3DTBLEND_DECALALPHA = 3
	D3DTBLEND_MODULATEALPHA = 4
	D3DTBLEND_DECALMASK = 5
	D3DTBLEND_MODULATEMASK = 6
	D3DTBLEND_COPY = 7
	D3DTBLEND_ADD = 8
	D3DTBLEND_FORCE_DWORD = &h7fffffff
end enum

type _D3DTEXTUREADDRESS as long
enum
	D3DTADDRESS_WRAP = 1
	D3DTADDRESS_MIRROR = 2
	D3DTADDRESS_CLAMP = 3
	D3DTADDRESS_BORDER = 4
	D3DTADDRESS_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREADDRESS as _D3DTEXTUREADDRESS

type D3DCULL as long
enum
	D3DCULL_NONE = 1
	D3DCULL_CW = 2
	D3DCULL_CCW = 3
	D3DCULL_FORCE_DWORD = &h7fffffff
end enum

type D3DCMPFUNC as long
enum
	D3DCMP_NEVER = 1
	D3DCMP_LESS = 2
	D3DCMP_EQUAL = 3
	D3DCMP_LESSEQUAL = 4
	D3DCMP_GREATER = 5
	D3DCMP_NOTEQUAL = 6
	D3DCMP_GREATEREQUAL = 7
	D3DCMP_ALWAYS = 8
	D3DCMP_FORCE_DWORD = &h7fffffff
end enum

type _D3DSTENCILOP as long
enum
	D3DSTENCILOP_KEEP = 1
	D3DSTENCILOP_ZERO = 2
	D3DSTENCILOP_REPLACE = 3
	D3DSTENCILOP_INCRSAT = 4
	D3DSTENCILOP_DECRSAT = 5
	D3DSTENCILOP_INVERT = 6
	D3DSTENCILOP_INCR = 7
	D3DSTENCILOP_DECR = 8
	D3DSTENCILOP_FORCE_DWORD = &h7fffffff
end enum

type D3DSTENCILOP as _D3DSTENCILOP

type _D3DFOGMODE as long
enum
	D3DFOG_NONE = 0
	D3DFOG_EXP = 1
	D3DFOG_EXP2 = 2
	D3DFOG_LINEAR = 3
	D3DFOG_FORCE_DWORD = &h7fffffff
end enum

type D3DFOGMODE as _D3DFOGMODE

type _D3DZBUFFERTYPE as long
enum
	D3DZB_FALSE = 0
	D3DZB_TRUE = 1
	D3DZB_USEW = 2
	D3DZB_FORCE_DWORD = &h7fffffff
end enum

type D3DZBUFFERTYPE as _D3DZBUFFERTYPE

type _D3DANTIALIASMODE as long
enum
	D3DANTIALIAS_NONE = 0
	D3DANTIALIAS_SORTDEPENDENT = 1
	D3DANTIALIAS_SORTINDEPENDENT = 2
	D3DANTIALIAS_FORCE_DWORD = &h7fffffff
end enum

type D3DANTIALIASMODE as _D3DANTIALIASMODE

type D3DVERTEXTYPE as long
enum
	D3DVT_VERTEX = 1
	D3DVT_LVERTEX = 2
	D3DVT_TLVERTEX = 3
	D3DVT_FORCE_DWORD = &h7fffffff
end enum

type D3DPRIMITIVETYPE as long
enum
	D3DPT_POINTLIST = 1
	D3DPT_LINELIST = 2
	D3DPT_LINESTRIP = 3
	D3DPT_TRIANGLELIST = 4
	D3DPT_TRIANGLESTRIP = 5
	D3DPT_TRIANGLEFAN = 6
	D3DPT_FORCE_DWORD = &h7fffffff
end enum

const D3DSTATE_OVERRIDE_BIAS = 256
#define D3DSTATE_OVERRIDE(type) cast(D3DRENDERSTATETYPE, cast(DWORD, (type)) + D3DSTATE_OVERRIDE_BIAS)

type _D3DTRANSFORMSTATETYPE as long
enum
	D3DTRANSFORMSTATE_WORLD = 1
	D3DTRANSFORMSTATE_VIEW = 2
	D3DTRANSFORMSTATE_PROJECTION = 3
	D3DTRANSFORMSTATE_WORLD1 = 4
	D3DTRANSFORMSTATE_WORLD2 = 5
	D3DTRANSFORMSTATE_WORLD3 = 6
	D3DTRANSFORMSTATE_TEXTURE0 = 16
	D3DTRANSFORMSTATE_TEXTURE1 = 17
	D3DTRANSFORMSTATE_TEXTURE2 = 18
	D3DTRANSFORMSTATE_TEXTURE3 = 19
	D3DTRANSFORMSTATE_TEXTURE4 = 20
	D3DTRANSFORMSTATE_TEXTURE5 = 21
	D3DTRANSFORMSTATE_TEXTURE6 = 22
	D3DTRANSFORMSTATE_TEXTURE7 = 23
	D3DTRANSFORMSTATE_FORCE_DWORD = &h7fffffff
end enum

type D3DTRANSFORMSTATETYPE as _D3DTRANSFORMSTATETYPE

type D3DLIGHTSTATETYPE as long
enum
	D3DLIGHTSTATE_MATERIAL = 1
	D3DLIGHTSTATE_AMBIENT = 2
	D3DLIGHTSTATE_COLORMODEL = 3
	D3DLIGHTSTATE_FOGMODE = 4
	D3DLIGHTSTATE_FOGSTART = 5
	D3DLIGHTSTATE_FOGEND = 6
	D3DLIGHTSTATE_FOGDENSITY = 7
	D3DLIGHTSTATE_COLORVERTEX = 8
	D3DLIGHTSTATE_FORCE_DWORD = &h7fffffff
end enum

type D3DRENDERSTATETYPE as long
enum
	D3DRENDERSTATE_TEXTUREHANDLE = 1
	D3DRENDERSTATE_ANTIALIAS = 2
	D3DRENDERSTATE_TEXTUREADDRESS = 3
	D3DRENDERSTATE_TEXTUREPERSPECTIVE = 4
	D3DRENDERSTATE_WRAPU = 5
	D3DRENDERSTATE_WRAPV = 6
	D3DRENDERSTATE_ZENABLE = 7
	D3DRENDERSTATE_FILLMODE = 8
	D3DRENDERSTATE_SHADEMODE = 9
	D3DRENDERSTATE_LINEPATTERN = 10
	D3DRENDERSTATE_MONOENABLE = 11
	D3DRENDERSTATE_ROP2 = 12
	D3DRENDERSTATE_PLANEMASK = 13
	D3DRENDERSTATE_ZWRITEENABLE = 14
	D3DRENDERSTATE_ALPHATESTENABLE = 15
	D3DRENDERSTATE_LASTPIXEL = 16
	D3DRENDERSTATE_TEXTUREMAG = 17
	D3DRENDERSTATE_TEXTUREMIN = 18
	D3DRENDERSTATE_SRCBLEND = 19
	D3DRENDERSTATE_DESTBLEND = 20
	D3DRENDERSTATE_TEXTUREMAPBLEND = 21
	D3DRENDERSTATE_CULLMODE = 22
	D3DRENDERSTATE_ZFUNC = 23
	D3DRENDERSTATE_ALPHAREF = 24
	D3DRENDERSTATE_ALPHAFUNC = 25
	D3DRENDERSTATE_DITHERENABLE = 26
	D3DRENDERSTATE_ALPHABLENDENABLE = 27
	D3DRENDERSTATE_FOGENABLE = 28
	D3DRENDERSTATE_SPECULARENABLE = 29
	D3DRENDERSTATE_ZVISIBLE = 30
	D3DRENDERSTATE_SUBPIXEL = 31
	D3DRENDERSTATE_SUBPIXELX = 32
	D3DRENDERSTATE_STIPPLEDALPHA = 33
	D3DRENDERSTATE_FOGCOLOR = 34
	D3DRENDERSTATE_FOGTABLEMODE = 35
	D3DRENDERSTATE_FOGTABLESTART = 36
	D3DRENDERSTATE_FOGTABLEEND = 37
	D3DRENDERSTATE_FOGTABLEDENSITY = 38
	D3DRENDERSTATE_FOGSTART = 36
	D3DRENDERSTATE_FOGEND = 37
	D3DRENDERSTATE_FOGDENSITY = 38
	D3DRENDERSTATE_STIPPLEENABLE = 39
	D3DRENDERSTATE_EDGEANTIALIAS = 40
	D3DRENDERSTATE_COLORKEYENABLE = 41
	D3DRENDERSTATE_BORDERCOLOR = 43
	D3DRENDERSTATE_TEXTUREADDRESSU = 44
	D3DRENDERSTATE_TEXTUREADDRESSV = 45
	D3DRENDERSTATE_MIPMAPLODBIAS = 46
	D3DRENDERSTATE_ZBIAS = 47
	D3DRENDERSTATE_RANGEFOGENABLE = 48
	D3DRENDERSTATE_ANISOTROPY = 49
	D3DRENDERSTATE_FLUSHBATCH = 50
	D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT = 51
	D3DRENDERSTATE_STENCILENABLE = 52
	D3DRENDERSTATE_STENCILFAIL = 53
	D3DRENDERSTATE_STENCILZFAIL = 54
	D3DRENDERSTATE_STENCILPASS = 55
	D3DRENDERSTATE_STENCILFUNC = 56
	D3DRENDERSTATE_STENCILREF = 57
	D3DRENDERSTATE_STENCILMASK = 58
	D3DRENDERSTATE_STENCILWRITEMASK = 59
	D3DRENDERSTATE_TEXTUREFACTOR = 60
	D3DRENDERSTATE_STIPPLEPATTERN00 = 64
	D3DRENDERSTATE_STIPPLEPATTERN01 = 65
	D3DRENDERSTATE_STIPPLEPATTERN02 = 66
	D3DRENDERSTATE_STIPPLEPATTERN03 = 67
	D3DRENDERSTATE_STIPPLEPATTERN04 = 68
	D3DRENDERSTATE_STIPPLEPATTERN05 = 69
	D3DRENDERSTATE_STIPPLEPATTERN06 = 70
	D3DRENDERSTATE_STIPPLEPATTERN07 = 71
	D3DRENDERSTATE_STIPPLEPATTERN08 = 72
	D3DRENDERSTATE_STIPPLEPATTERN09 = 73
	D3DRENDERSTATE_STIPPLEPATTERN10 = 74
	D3DRENDERSTATE_STIPPLEPATTERN11 = 75
	D3DRENDERSTATE_STIPPLEPATTERN12 = 76
	D3DRENDERSTATE_STIPPLEPATTERN13 = 77
	D3DRENDERSTATE_STIPPLEPATTERN14 = 78
	D3DRENDERSTATE_STIPPLEPATTERN15 = 79
	D3DRENDERSTATE_STIPPLEPATTERN16 = 80
	D3DRENDERSTATE_STIPPLEPATTERN17 = 81
	D3DRENDERSTATE_STIPPLEPATTERN18 = 82
	D3DRENDERSTATE_STIPPLEPATTERN19 = 83
	D3DRENDERSTATE_STIPPLEPATTERN20 = 84
	D3DRENDERSTATE_STIPPLEPATTERN21 = 85
	D3DRENDERSTATE_STIPPLEPATTERN22 = 86
	D3DRENDERSTATE_STIPPLEPATTERN23 = 87
	D3DRENDERSTATE_STIPPLEPATTERN24 = 88
	D3DRENDERSTATE_STIPPLEPATTERN25 = 89
	D3DRENDERSTATE_STIPPLEPATTERN26 = 90
	D3DRENDERSTATE_STIPPLEPATTERN27 = 91
	D3DRENDERSTATE_STIPPLEPATTERN28 = 92
	D3DRENDERSTATE_STIPPLEPATTERN29 = 93
	D3DRENDERSTATE_STIPPLEPATTERN30 = 94
	D3DRENDERSTATE_STIPPLEPATTERN31 = 95
	D3DRENDERSTATE_WRAP0 = 128
	D3DRENDERSTATE_WRAP1 = 129
	D3DRENDERSTATE_WRAP2 = 130
	D3DRENDERSTATE_WRAP3 = 131
	D3DRENDERSTATE_WRAP4 = 132
	D3DRENDERSTATE_WRAP5 = 133
	D3DRENDERSTATE_WRAP6 = 134
	D3DRENDERSTATE_WRAP7 = 135
	D3DRENDERSTATE_CLIPPING = 136
	D3DRENDERSTATE_LIGHTING = 137
	D3DRENDERSTATE_EXTENTS = 138
	D3DRENDERSTATE_AMBIENT = 139
	D3DRENDERSTATE_FOGVERTEXMODE = 140
	D3DRENDERSTATE_COLORVERTEX = 141
	D3DRENDERSTATE_LOCALVIEWER = 142
	D3DRENDERSTATE_NORMALIZENORMALS = 143
	D3DRENDERSTATE_COLORKEYBLENDENABLE = 144
	D3DRENDERSTATE_DIFFUSEMATERIALSOURCE = 145
	D3DRENDERSTATE_SPECULARMATERIALSOURCE = 146
	D3DRENDERSTATE_AMBIENTMATERIALSOURCE = 147
	D3DRENDERSTATE_EMISSIVEMATERIALSOURCE = 148
	D3DRENDERSTATE_VERTEXBLEND = 151
	D3DRENDERSTATE_CLIPPLANEENABLE = 152
	D3DRENDERSTATE_FORCE_DWORD = &h7fffffff
end enum

type _D3DMATERIALCOLORSOURCE as long
enum
	D3DMCS_MATERIAL = 0
	D3DMCS_COLOR1 = 1
	D3DMCS_COLOR2 = 2
	D3DMCS_FORCE_DWORD = &h7fffffff
end enum

type D3DMATERIALCOLORSOURCE as _D3DMATERIALCOLORSOURCE
const D3DRENDERSTATE_BLENDENABLE = D3DRENDERSTATE_ALPHABLENDENABLE
const D3DRENDERSTATE_WRAPBIAS = 128u
const D3DWRAP_U = &h00000001
const D3DWRAP_V = &h00000002
const D3DWRAPCOORD_0 = &h00000001
const D3DWRAPCOORD_1 = &h00000002
const D3DWRAPCOORD_2 = &h00000004
const D3DWRAPCOORD_3 = &h00000008
#define D3DRENDERSTATE_STIPPLEPATTERN(y) (D3DRENDERSTATE_STIPPLEPATTERN00 + (y))

#ifdef __FB_64BIT__
	type _D3DSTATE
		union
			dtstTransformStateType as D3DTRANSFORMSTATETYPE
			dlstLightStateType as D3DLIGHTSTATETYPE
			drstRenderStateType as D3DRENDERSTATETYPE
		end union

		union
			dwArg(0 to 0) as DWORD
			dvArg(0 to 0) as D3DVALUE
		end union
	end type
#else
	type _D3DSTATE field = 4
		union field = 4
			dtstTransformStateType as D3DTRANSFORMSTATETYPE
			dlstLightStateType as D3DLIGHTSTATETYPE
			drstRenderStateType as D3DRENDERSTATETYPE
		end union

		union field = 4
			dwArg(0 to 0) as DWORD
			dvArg(0 to 0) as D3DVALUE
		end union
	end type
#endif

type D3DSTATE as _D3DSTATE
type LPD3DSTATE as _D3DSTATE ptr

#ifdef __FB_64BIT__
	type _D3DMATRIXLOAD
		hDestMatrix as D3DMATRIXHANDLE
		hSrcMatrix as D3DMATRIXHANDLE
	end type
#else
	type _D3DMATRIXLOAD field = 4
		hDestMatrix as D3DMATRIXHANDLE
		hSrcMatrix as D3DMATRIXHANDLE
	end type
#endif

type D3DMATRIXLOAD as _D3DMATRIXLOAD
type LPD3DMATRIXLOAD as _D3DMATRIXLOAD ptr

#ifdef __FB_64BIT__
	type _D3DMATRIXMULTIPLY
		hDestMatrix as D3DMATRIXHANDLE
		hSrcMatrix1 as D3DMATRIXHANDLE
		hSrcMatrix2 as D3DMATRIXHANDLE
	end type
#else
	type _D3DMATRIXMULTIPLY field = 4
		hDestMatrix as D3DMATRIXHANDLE
		hSrcMatrix1 as D3DMATRIXHANDLE
		hSrcMatrix2 as D3DMATRIXHANDLE
	end type
#endif

type D3DMATRIXMULTIPLY as _D3DMATRIXMULTIPLY
type LPD3DMATRIXMULTIPLY as _D3DMATRIXMULTIPLY ptr

#ifdef __FB_64BIT__
	type _D3DPROCESSVERTICES
		dwFlags as DWORD
		wStart as WORD
		wDest as WORD
		dwCount as DWORD
		dwReserved as DWORD
	end type
#else
	type _D3DPROCESSVERTICES field = 4
		dwFlags as DWORD
		wStart as WORD
		wDest as WORD
		dwCount as DWORD
		dwReserved as DWORD
	end type
#endif

type D3DPROCESSVERTICES as _D3DPROCESSVERTICES
type LPD3DPROCESSVERTICES as _D3DPROCESSVERTICES ptr
const D3DPROCESSVERTICES_TRANSFORMLIGHT = &h00000000
const D3DPROCESSVERTICES_TRANSFORM = &h00000001
const D3DPROCESSVERTICES_COPY = &h00000002
const D3DPROCESSVERTICES_OPMASK = &h00000007
const D3DPROCESSVERTICES_UPDATEEXTENTS = &h00000008
const D3DPROCESSVERTICES_NOCOLOR = &h00000010

type _D3DTEXTURESTAGESTATETYPE as long
enum
	D3DTSS_COLOROP = 1
	D3DTSS_COLORARG1 = 2
	D3DTSS_COLORARG2 = 3
	D3DTSS_ALPHAOP = 4
	D3DTSS_ALPHAARG1 = 5
	D3DTSS_ALPHAARG2 = 6
	D3DTSS_BUMPENVMAT00 = 7
	D3DTSS_BUMPENVMAT01 = 8
	D3DTSS_BUMPENVMAT10 = 9
	D3DTSS_BUMPENVMAT11 = 10
	D3DTSS_TEXCOORDINDEX = 11
	D3DTSS_ADDRESS = 12
	D3DTSS_ADDRESSU = 13
	D3DTSS_ADDRESSV = 14
	D3DTSS_BORDERCOLOR = 15
	D3DTSS_MAGFILTER = 16
	D3DTSS_MINFILTER = 17
	D3DTSS_MIPFILTER = 18
	D3DTSS_MIPMAPLODBIAS = 19
	D3DTSS_MAXMIPLEVEL = 20
	D3DTSS_MAXANISOTROPY = 21
	D3DTSS_BUMPENVLSCALE = 22
	D3DTSS_BUMPENVLOFFSET = 23
	D3DTSS_TEXTURETRANSFORMFLAGS = 24
	D3DTSS_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTURESTAGESTATETYPE as _D3DTEXTURESTAGESTATETYPE
const D3DTSS_TCI_PASSTHRU = &h00000000
const D3DTSS_TCI_CAMERASPACENORMAL = &h00010000
const D3DTSS_TCI_CAMERASPACEPOSITION = &h00020000
const D3DTSS_TCI_CAMERASPACEREFLECTIONVECTOR = &h00030000

type _D3DTEXTUREOP as long
enum
	D3DTOP_DISABLE = 1
	D3DTOP_SELECTARG1 = 2
	D3DTOP_SELECTARG2 = 3
	D3DTOP_MODULATE = 4
	D3DTOP_MODULATE2X = 5
	D3DTOP_MODULATE4X = 6
	D3DTOP_ADD = 7
	D3DTOP_ADDSIGNED = 8
	D3DTOP_ADDSIGNED2X = 9
	D3DTOP_SUBTRACT = 10
	D3DTOP_ADDSMOOTH = 11
	D3DTOP_BLENDDIFFUSEALPHA = 12
	D3DTOP_BLENDTEXTUREALPHA = 13
	D3DTOP_BLENDFACTORALPHA = 14
	D3DTOP_BLENDTEXTUREALPHAPM = 15
	D3DTOP_BLENDCURRENTALPHA = 16
	D3DTOP_PREMODULATE = 17
	D3DTOP_MODULATEALPHA_ADDCOLOR = 18
	D3DTOP_MODULATECOLOR_ADDALPHA = 19
	D3DTOP_MODULATEINVALPHA_ADDCOLOR = 20
	D3DTOP_MODULATEINVCOLOR_ADDALPHA = 21
	D3DTOP_BUMPENVMAP = 22
	D3DTOP_BUMPENVMAPLUMINANCE = 23
	D3DTOP_DOTPRODUCT3 = 24
	D3DTOP_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREOP as _D3DTEXTUREOP
const D3DTA_SELECTMASK = &h0000000f
const D3DTA_DIFFUSE = &h00000000
const D3DTA_CURRENT = &h00000001
const D3DTA_TEXTURE = &h00000002
const D3DTA_TFACTOR = &h00000003
const D3DTA_SPECULAR = &h00000004
const D3DTA_COMPLEMENT = &h00000010
const D3DTA_ALPHAREPLICATE = &h00000020

type _D3DTEXTUREMAGFILTER as long
enum
	D3DTFG_POINT = 1
	D3DTFG_LINEAR = 2
	D3DTFG_FLATCUBIC = 3
	D3DTFG_GAUSSIANCUBIC = 4
	D3DTFG_ANISOTROPIC = 5
	D3DTFG_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREMAGFILTER as _D3DTEXTUREMAGFILTER

type _D3DTEXTUREMINFILTER as long
enum
	D3DTFN_POINT = 1
	D3DTFN_LINEAR = 2
	D3DTFN_ANISOTROPIC = 3
	D3DTFN_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREMINFILTER as _D3DTEXTUREMINFILTER

type _D3DTEXTUREMIPFILTER as long
enum
	D3DTFP_NONE = 1
	D3DTFP_POINT = 2
	D3DTFP_LINEAR = 3
	D3DTFP_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTUREMIPFILTER as _D3DTEXTUREMIPFILTER
const D3DTRIFLAG_START = &h00000000
#define D3DTRIFLAG_STARTFLAT(len) (len)
const D3DTRIFLAG_ODD = &h0000001e
const D3DTRIFLAG_EVEN = &h0000001f
const D3DTRIFLAG_EDGEENABLE1 = &h00000100
const D3DTRIFLAG_EDGEENABLE2 = &h00000200
const D3DTRIFLAG_EDGEENABLE3 = &h00000400
const D3DTRIFLAG_EDGEENABLETRIANGLE = (D3DTRIFLAG_EDGEENABLE1 or D3DTRIFLAG_EDGEENABLE2) or D3DTRIFLAG_EDGEENABLE3

#ifdef __FB_64BIT__
	type _D3DTRIANGLE
		union
			v1 as WORD
			wV1 as WORD
		end union

		union
			v2 as WORD
			wV2 as WORD
		end union

		union
			v3 as WORD
			wV3 as WORD
		end union

		wFlags as WORD
	end type
#else
	type _D3DTRIANGLE field = 4
		union field = 4
			v1 as WORD
			wV1 as WORD
		end union

		union field = 4
			v2 as WORD
			wV2 as WORD
		end union

		union field = 4
			v3 as WORD
			wV3 as WORD
		end union

		wFlags as WORD
	end type
#endif

type D3DTRIANGLE as _D3DTRIANGLE
type LPD3DTRIANGLE as _D3DTRIANGLE ptr

#ifdef __FB_64BIT__
	type _D3DLINE
		union
			v1 as WORD
			wV1 as WORD
		end union

		union
			v2 as WORD
			wV2 as WORD
		end union
	end type
#else
	type _D3DLINE field = 4
		union field = 4
			v1 as WORD
			wV1 as WORD
		end union

		union field = 4
			v2 as WORD
			wV2 as WORD
		end union
	end type
#endif

type D3DLINE as _D3DLINE
type LPD3DLINE as _D3DLINE ptr

#ifdef __FB_64BIT__
	type _D3DSPAN
		wCount as WORD
		wFirst as WORD
	end type
#else
	type _D3DSPAN field = 4
		wCount as WORD
		wFirst as WORD
	end type
#endif

type D3DSPAN as _D3DSPAN
type LPD3DSPAN as _D3DSPAN ptr

#ifdef __FB_64BIT__
	type _D3DPOINT
		wCount as WORD
		wFirst as WORD
	end type
#else
	type _D3DPOINT field = 4
		wCount as WORD
		wFirst as WORD
	end type
#endif

type D3DPOINT as _D3DPOINT
type LPD3DPOINT as _D3DPOINT ptr

#ifdef __FB_64BIT__
	type _D3DBRANCH
		dwMask as DWORD
		dwValue as DWORD
		bNegate as WINBOOL
		dwOffset as DWORD
	end type
#else
	type _D3DBRANCH field = 4
		dwMask as DWORD
		dwValue as DWORD
		bNegate as WINBOOL
		dwOffset as DWORD
	end type
#endif

type D3DBRANCH as _D3DBRANCH
type LPD3DBRANCH as _D3DBRANCH ptr

#ifdef __FB_64BIT__
	type _D3DSTATUS
		dwFlags as DWORD
		dwStatus as DWORD
		drExtent as D3DRECT
	end type
#else
	type _D3DSTATUS field = 4
		dwFlags as DWORD
		dwStatus as DWORD
		drExtent as D3DRECT
	end type
#endif

type D3DSTATUS as _D3DSTATUS
type LPD3DSTATUS as _D3DSTATUS ptr
const D3DSETSTATUS_STATUS = &h00000001
const D3DSETSTATUS_EXTENTS = &h00000002
const D3DSETSTATUS_ALL = D3DSETSTATUS_STATUS or D3DSETSTATUS_EXTENTS

#ifdef __FB_64BIT__
	type _D3DCLIPSTATUS
		dwFlags as DWORD
		dwStatus as DWORD
		minx as single
		maxx as single
		miny as single
		maxy as single
		minz as single
		maxz as single
	end type
#else
	type _D3DCLIPSTATUS field = 4
		dwFlags as DWORD
		dwStatus as DWORD
		minx as single
		maxx as single
		miny as single
		maxy as single
		minz as single
		maxz as single
	end type
#endif

type D3DCLIPSTATUS as _D3DCLIPSTATUS
type LPD3DCLIPSTATUS as _D3DCLIPSTATUS ptr
const D3DCLIPSTATUS_STATUS = &h00000001
const D3DCLIPSTATUS_EXTENTS2 = &h00000002
const D3DCLIPSTATUS_EXTENTS3 = &h00000004

#ifdef __FB_64BIT__
	type D3DSTATS
		dwSize as DWORD
		dwTrianglesDrawn as DWORD
		dwLinesDrawn as DWORD
		dwPointsDrawn as DWORD
		dwSpansDrawn as DWORD
		dwVerticesProcessed as DWORD
	end type
#else
	type D3DSTATS field = 4
		dwSize as DWORD
		dwTrianglesDrawn as DWORD
		dwLinesDrawn as DWORD
		dwPointsDrawn as DWORD
		dwSpansDrawn as DWORD
		dwVerticesProcessed as DWORD
	end type
#endif

type LPD3DSTATS as D3DSTATS ptr
const D3DEXECUTE_CLIPPED = &h00000001
const D3DEXECUTE_UNCLIPPED = &h00000002

#ifdef __FB_64BIT__
	type _D3DEXECUTEDATA
		dwSize as DWORD
		dwVertexOffset as DWORD
		dwVertexCount as DWORD
		dwInstructionOffset as DWORD
		dwInstructionLength as DWORD
		dwHVertexOffset as DWORD
		dsStatus as D3DSTATUS
	end type
#else
	type _D3DEXECUTEDATA field = 4
		dwSize as DWORD
		dwVertexOffset as DWORD
		dwVertexCount as DWORD
		dwInstructionOffset as DWORD
		dwInstructionLength as DWORD
		dwHVertexOffset as DWORD
		dsStatus as D3DSTATUS
	end type
#endif

type D3DEXECUTEDATA as _D3DEXECUTEDATA
type LPD3DEXECUTEDATA as _D3DEXECUTEDATA ptr
const D3DPAL_FREE = &h00
const D3DPAL_READONLY = &h40
const D3DPAL_RESERVED = &h80

#ifdef __FB_64BIT__
	type _D3DVERTEXBUFFERDESC
		dwSize as DWORD
		dwCaps as DWORD
		dwFVF as DWORD
		dwNumVertices as DWORD
	end type
#else
	type _D3DVERTEXBUFFERDESC field = 4
		dwSize as DWORD
		dwCaps as DWORD
		dwFVF as DWORD
		dwNumVertices as DWORD
	end type
#endif

type D3DVERTEXBUFFERDESC as _D3DVERTEXBUFFERDESC
type LPD3DVERTEXBUFFERDESC as _D3DVERTEXBUFFERDESC ptr
const D3DVBCAPS_SYSTEMMEMORY = &h00000800
const D3DVBCAPS_WRITEONLY = &h00010000
const D3DVBCAPS_OPTIMIZED = &h80000000
const D3DVBCAPS_DONOTCLIP = &h00000001
const D3DVOP_LIGHT = 1 shl 10
const D3DVOP_TRANSFORM = 1 shl 0
const D3DVOP_CLIP = 1 shl 2
const D3DVOP_EXTENTS = 1 shl 3
const D3DMAXNUMVERTICES = (1 shl 16) - 1
const D3DMAXNUMPRIMITIVES = (1 shl 16) - 1
const D3DPV_DONOTCOPYDATA = 1 shl 0
const D3DFVF_RESERVED0 = &h001
const D3DFVF_POSITION_MASK = &h00E
const D3DFVF_XYZ = &h002
const D3DFVF_XYZRHW = &h004
const D3DFVF_XYZB1 = &h006
const D3DFVF_XYZB2 = &h008
const D3DFVF_XYZB3 = &h00a
const D3DFVF_XYZB4 = &h00c
const D3DFVF_XYZB5 = &h00e
const D3DFVF_NORMAL = &h010
const D3DFVF_RESERVED1 = &h020
const D3DFVF_DIFFUSE = &h040
const D3DFVF_SPECULAR = &h080
const D3DFVF_TEXCOUNT_MASK = &hf00
const D3DFVF_TEXCOUNT_SHIFT = 8
const D3DFVF_TEX0 = &h000
const D3DFVF_TEX1 = &h100
const D3DFVF_TEX2 = &h200
const D3DFVF_TEX3 = &h300
const D3DFVF_TEX4 = &h400
const D3DFVF_TEX5 = &h500
const D3DFVF_TEX6 = &h600
const D3DFVF_TEX7 = &h700
const D3DFVF_TEX8 = &h800
const D3DFVF_RESERVED2 = &hf000
const D3DFVF_VERTEX = (D3DFVF_XYZ or D3DFVF_NORMAL) or D3DFVF_TEX1
const D3DFVF_LVERTEX = (((D3DFVF_XYZ or D3DFVF_RESERVED1) or D3DFVF_DIFFUSE) or D3DFVF_SPECULAR) or D3DFVF_TEX1
const D3DFVF_TLVERTEX = ((D3DFVF_XYZRHW or D3DFVF_DIFFUSE) or D3DFVF_SPECULAR) or D3DFVF_TEX1

#ifdef __FB_64BIT__
	type _D3DDP_PTRSTRIDE
		lpvData as any ptr
		dwStride as DWORD
	end type
#else
	type _D3DDP_PTRSTRIDE field = 4
		lpvData as any ptr
		dwStride as DWORD
	end type
#endif

type D3DDP_PTRSTRIDE as _D3DDP_PTRSTRIDE
const D3DDP_MAXTEXCOORD = 8

#ifdef __FB_64BIT__
	type _D3DDRAWPRIMITIVESTRIDEDDATA
		position as D3DDP_PTRSTRIDE
		normal as D3DDP_PTRSTRIDE
		diffuse as D3DDP_PTRSTRIDE
		specular as D3DDP_PTRSTRIDE
		textureCoords(0 to 7) as D3DDP_PTRSTRIDE
	end type
#else
	type _D3DDRAWPRIMITIVESTRIDEDDATA field = 4
		position as D3DDP_PTRSTRIDE
		normal as D3DDP_PTRSTRIDE
		diffuse as D3DDP_PTRSTRIDE
		specular as D3DDP_PTRSTRIDE
		textureCoords(0 to 7) as D3DDP_PTRSTRIDE
	end type
#endif

type D3DDRAWPRIMITIVESTRIDEDDATA as _D3DDRAWPRIMITIVESTRIDEDDATA
type LPD3DDRAWPRIMITIVESTRIDEDDATA as _D3DDRAWPRIMITIVESTRIDEDDATA ptr
const D3DVIS_INSIDE_FRUSTUM = 0
const D3DVIS_INTERSECT_FRUSTUM = 1
const D3DVIS_OUTSIDE_FRUSTUM = 2
const D3DVIS_INSIDE_LEFT = 0
const D3DVIS_INTERSECT_LEFT = 1 shl 2
const D3DVIS_OUTSIDE_LEFT = 2 shl 2
const D3DVIS_INSIDE_RIGHT = 0
const D3DVIS_INTERSECT_RIGHT = 1 shl 4
const D3DVIS_OUTSIDE_RIGHT = 2 shl 4
const D3DVIS_INSIDE_TOP = 0
const D3DVIS_INTERSECT_TOP = 1 shl 6
const D3DVIS_OUTSIDE_TOP = 2 shl 6
const D3DVIS_INSIDE_BOTTOM = 0
const D3DVIS_INTERSECT_BOTTOM = 1 shl 8
const D3DVIS_OUTSIDE_BOTTOM = 2 shl 8
const D3DVIS_INSIDE_NEAR = 0
const D3DVIS_INTERSECT_NEAR = 1 shl 10
const D3DVIS_OUTSIDE_NEAR = 2 shl 10
const D3DVIS_INSIDE_FAR = 0
const D3DVIS_INTERSECT_FAR = 1 shl 12
const D3DVIS_OUTSIDE_FAR = 2 shl 12
const D3DVIS_MASK_FRUSTUM = 3 shl 0
const D3DVIS_MASK_LEFT = 3 shl 2
const D3DVIS_MASK_RIGHT = 3 shl 4
const D3DVIS_MASK_TOP = 3 shl 6
const D3DVIS_MASK_BOTTOM = 3 shl 8
const D3DVIS_MASK_NEAR = 3 shl 10
const D3DVIS_MASK_FAR = 3 shl 12
const D3DDEVINFOID_TEXTUREMANAGER = 1
const D3DDEVINFOID_D3DTEXTUREMANAGER = 2
const D3DDEVINFOID_TEXTURING = 3

type _D3DSTATEBLOCKTYPE as long
enum
	D3DSBT_ALL = 1
	D3DSBT_PIXELSTATE = 2
	D3DSBT_VERTEXSTATE = 3
	D3DSBT_FORCE_DWORD = &hffffffff
end enum

type D3DSTATEBLOCKTYPE as _D3DSTATEBLOCKTYPE

type _D3DVERTEXBLENDFLAGS as long
enum
	D3DVBLEND_DISABLE = 0
	D3DVBLEND_1WEIGHT = 1
	D3DVBLEND_2WEIGHTS = 2
	D3DVBLEND_3WEIGHTS = 3
end enum

type D3DVERTEXBLENDFLAGS as _D3DVERTEXBLENDFLAGS

type _D3DTEXTURETRANSFORMFLAGS as long
enum
	D3DTTFF_DISABLE = 0
	D3DTTFF_COUNT1 = 1
	D3DTTFF_COUNT2 = 2
	D3DTTFF_COUNT3 = 3
	D3DTTFF_COUNT4 = 4
	D3DTTFF_PROJECTED = 256
	D3DTTFF_FORCE_DWORD = &h7fffffff
end enum

type D3DTEXTURETRANSFORMFLAGS as _D3DTEXTURETRANSFORMFLAGS
const D3DFVF_TEXTUREFORMAT2 = 0
const D3DFVF_TEXTUREFORMAT1 = 3
const D3DFVF_TEXTUREFORMAT3 = 1
const D3DFVF_TEXTUREFORMAT4 = 2
#define D3DFVF_TEXCOORDSIZE3(CoordIndex) (D3DFVF_TEXTUREFORMAT3 shl ((CoordIndex * 2) + 16))
#define D3DFVF_TEXCOORDSIZE2(CoordIndex) D3DFVF_TEXTUREFORMAT2
#define D3DFVF_TEXCOORDSIZE4(CoordIndex) (D3DFVF_TEXTUREFORMAT4 shl ((CoordIndex * 2) + 16))
#define D3DFVF_TEXCOORDSIZE1(CoordIndex) (D3DFVF_TEXTUREFORMAT1 shl ((CoordIndex * 2) + 16))

end extern
