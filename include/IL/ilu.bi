''
''
'' ilu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ilu_bi__
#define __ilu_bi__

#inclib "ILU"

#include "IL/il.bi"

#define ILU_VERSION_1_6_7 1
#define ILU_VERSION 167
#define ILU_FILTER &h2600
#define ILU_NEAREST &h2601
#define ILU_LINEAR &h2602
#define ILU_BILINEAR &h2603
#define ILU_SCALE_BOX &h2604
#define ILU_SCALE_TRIANGLE &h2605
#define ILU_SCALE_BELL &h2606
#define ILU_SCALE_BSPLINE &h2607
#define ILU_SCALE_LANCZOS3 &h2608
#define ILU_SCALE_MITCHELL &h2609
#define ILU_INVALID_ENUM &h0501
#define ILU_OUT_OF_MEMORY &h0502
#define ILU_INTERNAL_ERROR &h0504
#define ILU_INVALID_VALUE &h0505
#define ILU_ILLEGAL_OPERATION &h0506
#define ILU_INVALID_PARAM &h0509
#define ILU_PLACEMENT &h0700
#define ILU_LOWER_LEFT &h0701
#define ILU_LOWER_RIGHT &h0702
#define ILU_UPPER_LEFT &h0703
#define ILU_UPPER_RIGHT &h0704
#define ILU_CENTER &h0705
#define ILU_CONVOLUTION_MATRIX &h0710
#define ILU_VERSION_NUM &h0DE2
#define ILU_VENDOR &h1F00

type ILinfo
	Id as ILuint
	Data as ILubyte ptr
	Width as ILuint
	Height as ILuint
	Depth as ILuint
	Bpp as ILubyte
	SizeOfData as ILuint
	Format as ILenum
	Type as ILenum
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

extern "c"
declare function iluAlienify () as ILboolean
declare function iluBlurAvg (byval Iter as ILuint) as ILboolean
declare function iluBlurGaussian (byval Iter as ILuint) as ILboolean
declare function iluBuildMipmaps () as ILboolean
declare function iluColoursUsed () as ILuint
declare function iluCompareImage (byval Comp as ILuint) as ILboolean
declare function iluContrast (byval Contrast as ILfloat) as ILboolean
declare function iluCrop (byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint, byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare sub iluDeleteImage (byval Id as ILuint)
declare function iluEdgeDetectE () as ILboolean
declare function iluEdgeDetectP () as ILboolean
declare function iluEdgeDetectS () as ILboolean
declare function iluEmboss () as ILboolean
declare function iluEnlargeCanvas (byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function iluEnlargeImage (byval XDim as ILfloat, byval YDim as ILfloat, byval ZDim as ILfloat) as ILboolean
declare function iluEqualize () as ILboolean
declare function iluErrorString (byval Error as ILenum) as zstring ptr
declare function iluFlipImage () as ILboolean
declare function iluGammaCorrect (byval Gamma as ILfloat) as ILboolean
declare function iluGenImage () as ILuint
declare sub iluGetImageInfo (byval Info as ILinfo ptr)
declare function iluGetInteger (byval Mode as ILenum) as ILint
declare sub iluGetIntegerv (byval Mode as ILenum, byval Param as ILint ptr)
declare function iluGetString (byval StringName as ILenum) as zstring ptr
declare sub iluImageParameter (byval PName as ILenum, byval Param as ILenum)
declare sub iluInit ()
declare function iluInvertAlpha () as ILboolean
declare function iluLoadImage (byval FileName as ILstring) as ILuint
declare function iluMirror () as ILboolean
declare function iluNegative () as ILboolean
declare function iluNoisify (byval Tolerance as ILclampf) as ILboolean
declare function iluPixelize (byval PixSize as ILuint) as ILboolean
declare sub iluRegionfv (byval Points as ILpointf ptr, byval n as ILuint)
declare sub iluRegioniv (byval Points as ILpointi ptr, byval n as ILuint)
declare function iluReplaceColour (byval Red as ILubyte, byval Green as ILubyte, byval Blue as ILubyte, byval Tolerance as ILfloat) as ILboolean
declare function iluRotate (byval Angle as ILfloat) as ILboolean
declare function iluRotate3D (byval x as ILfloat, byval y as ILfloat, byval z as ILfloat, byval Angle as ILfloat) as ILboolean
declare function iluSaturate1f (byval Saturation as ILfloat) as ILboolean
declare function iluSaturate4f (byval r as ILfloat, byval g as ILfloat, byval b as ILfloat, byval Saturation as ILfloat) as ILboolean
declare function iluScale (byval Width as ILuint, byval Height as ILuint, byval Depth as ILuint) as ILboolean
declare function iluScaleColours (byval r as ILfloat, byval g as ILfloat, byval b as ILfloat) as ILboolean
declare function iluSharpen (byval Factor as ILfloat, byval Iter as ILuint) as ILboolean
declare function iluSwapColours () as ILboolean
declare function iluWave (byval Angle as ILfloat) as ILboolean
end extern

#endif
