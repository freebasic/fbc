'' FreeBASIC binding for DevIL-1.8.0
''
'' based on the C header files:
''    ImageLib Utility Sources
''    Copyright (C) 2000-2017 by Denton Woods
''    Last modified: 03/07/2009
''
''    Filename: IL/ilu.h
''
''    Description: The main include file for ILU
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
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
''   USA
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "ILU"

#include once "IL/il.bi"

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

#define __ilu_h_
#define __ILU_H__
const ILU_VERSION_1_8_0 = 1
const ILU_VERSION = 180
const ILU_FILTER = &h2600
const ILU_NEAREST = &h2601
const ILU_LINEAR = &h2602
const ILU_BILINEAR = &h2603
const ILU_SCALE_BOX = &h2604
const ILU_SCALE_TRIANGLE = &h2605
const ILU_SCALE_BELL = &h2606
const ILU_SCALE_BSPLINE = &h2607
const ILU_SCALE_LANCZOS3 = &h2608
const ILU_SCALE_MITCHELL = &h2609
const ILU_INVALID_ENUM = &h0501
const ILU_OUT_OF_MEMORY = &h0502
const ILU_INTERNAL_ERROR = &h0504
const ILU_INVALID_VALUE = &h0505
const ILU_ILLEGAL_OPERATION = &h0506
const ILU_INVALID_PARAM = &h0509
const ILU_PLACEMENT = &h0700
const ILU_LOWER_LEFT = &h0701
const ILU_LOWER_RIGHT = &h0702
const ILU_UPPER_LEFT = &h0703
const ILU_UPPER_RIGHT = &h0704
const ILU_CENTER = &h0705
const ILU_CONVOLUTION_MATRIX = &h0710
const ILU_VERSION_NUM = IL_VERSION_NUM
const ILU_VENDOR = IL_VENDOR
const ILU_ENGLISH = &h0800
const ILU_ARABIC = &h0801
const ILU_DUTCH = &h0802
const ILU_JAPANESE = &h0803
const ILU_SPANISH = &h0804
const ILU_GERMAN = &h0805
const ILU_FRENCH = &h0806
const ILU_ITALIAN = &h0807

type ILinfo
	Id as ILuint
	Data as ILubyte ptr
	Width as ILuint
	Height as ILuint
	Depth as ILuint
	Bpp as ILubyte
	SizeOfData as ILuint
	Format as ILenum
	as ILenum Type
	Origin as ILenum
	Palette as ILubyte ptr
	PalType as ILenum
	PalSize as ILuint
	CubeFlags as ILenum
	NumNext as ILuint
	NumMips as ILuint
	NumLayers as ILuint
end type

type ILpointf
	x as ILfloat
	y as ILfloat
end type

type ILpointi
	x as ILint
	y as ILint
end type

declare function iluAlienify() as ILboolean
declare function iluBlurAvg(byval Iter as ILuint) as ILboolean
declare function iluBlurGaussian(byval Iter as ILuint) as ILboolean
declare function iluBuildMipmaps() as ILboolean
declare function iluColoursUsed() as ILuint
declare function iluCompareImage(byval Comp as ILuint) as ILboolean
declare function iluContrast(byval Contrast as ILfloat) as ILboolean
declare function iluCrop(byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare sub iluDeleteImage(byval Id as ILuint)
declare function iluEdgeDetectE() as ILboolean
declare function iluEdgeDetectP() as ILboolean
declare function iluEdgeDetectS() as ILboolean
declare function iluEmboss() as ILboolean
declare function iluEnlargeCanvas(byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function iluEnlargeImage(byval XDim as ILfloat, byval YDim as ILfloat, byval ZDim as ILfloat) as ILboolean
declare function iluEqualize() as ILboolean
declare function iluEqualize2() as ILboolean
declare function iluErrorString(byval Error as ILenum) as const zstring ptr
declare function iluConvolution(byval matrix as ILint ptr, byval scale as ILint, byval bias as ILint) as ILboolean
declare function iluFlipImage() as ILboolean
declare function iluGammaCorrect(byval Gamma as ILfloat) as ILboolean
declare function iluGenImage() as ILuint
declare sub iluGetImageInfo(byval Info as ILinfo ptr)
declare function iluGetInteger(byval Mode as ILenum) as ILint
declare sub iluGetIntegerv(byval Mode as ILenum, byval Param as ILint ptr)
declare function iluGetString(byval StringName as ILenum) as zstring ptr
declare sub iluImageParameter(byval PName as ILenum, byval Param as ILenum)
declare sub iluInit()
declare function iluInvertAlpha() as ILboolean
declare function iluLoadImage(byval FileName as const zstring ptr) as ILuint
declare function iluMirror() as ILboolean
declare function iluNegative() as ILboolean
declare function iluNoisify(byval Tolerance as ILclampf) as ILboolean
declare function iluPixelize(byval PixSize as ILuint) as ILboolean
declare sub iluRegionfv(byval Points as ILpointf ptr, byval n as ILuint)
declare sub iluRegioniv(byval Points as ILpointi ptr, byval n as ILuint)
declare function iluReplaceColour(byval Red as ILubyte, byval Green as ILubyte, byval Blue as ILubyte, byval Tolerance as ILfloat) as ILboolean
declare function iluRotate(byval Angle as ILfloat) as ILboolean
declare function iluRotate3D(byval x as ILfloat, byval y as ILfloat, byval z as ILfloat, byval Angle as ILfloat) as ILboolean
declare function iluSaturate1f(byval Saturation as ILfloat) as ILboolean
declare function iluSaturate4f(byval r as ILfloat, byval g as ILfloat, byval b as ILfloat, byval Saturation as ILfloat) as ILboolean
declare function iluScale(byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function iluScaleAlpha(byval scale as ILfloat) as ILboolean
declare function iluScaleColours(byval r as ILfloat, byval g as ILfloat, byval b as ILfloat) as ILboolean
declare function iluSepia() as ILboolean
declare function iluSetLanguage(byval Language as ILenum) as ILboolean
declare function iluSharpen(byval Factor as ILfloat, byval Iter as ILuint) as ILboolean
declare function iluSwapColours() as ILboolean
declare function iluWave(byval Angle as ILfloat) as ILboolean
declare function iluColorsUsed alias "iluColoursUsed"() as ILuint
declare function iluSwapColors alias "iluSwapColours"() as ILboolean
declare function iluReplaceColor alias "iluReplaceColour"(byval Red as ILubyte, byval Green as ILubyte, byval Blue as ILubyte, byval Tolerance as ILfloat) as ILboolean
#define iluScaleColor iluScaleColour

end extern
