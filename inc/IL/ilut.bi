'' FreeBASIC binding for DevIL-1.8.0
''
'' based on the C header files:
''    ImageLib Utility Toolkit Sources
''    Copyright (C) 2000-2017 by Denton Woods
''    Last modified: 03/07/2009
''
''    Filename: IL/ilut.h
''
''    Description: The main include file for ILUT
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

#inclib "ILUT"

#include once "IL/il.bi"
#include once "IL/ilu.bi"

#ifdef __FB_WIN32__
	#include once "windows.bi"
	#include once "GL/gl.bi"
	#include once "GL/glu.bi"

	extern "Windows"
#else
	extern "C"
#endif

#define __ilut_h_
#define __ILUT_H__
const ILUT_VERSION_1_8_0 = 1
const ILUT_VERSION = 180
const ILUT_OPENGL_BIT = &h00000001
const ILUT_D3D_BIT = &h00000002
const ILUT_ALL_ATTRIB_BITS = &h000FFFFF
const ILUT_INVALID_ENUM = &h0501
const ILUT_OUT_OF_MEMORY = &h0502
const ILUT_INVALID_VALUE = &h0505
const ILUT_ILLEGAL_OPERATION = &h0506
const ILUT_INVALID_PARAM = &h0509
const ILUT_COULD_NOT_OPEN_FILE = &h050A
const ILUT_STACK_OVERFLOW = &h050E
const ILUT_STACK_UNDERFLOW = &h050F
const ILUT_BAD_DIMENSIONS = &h0511
const ILUT_NOT_SUPPORTED = &h0550
const ILUT_PALETTE_MODE = &h0600
const ILUT_OPENGL_CONV = &h0610
const ILUT_D3D_MIPLEVELS = &h0620
const ILUT_MAXTEX_WIDTH = &h0630
const ILUT_MAXTEX_HEIGHT = &h0631
const ILUT_MAXTEX_DEPTH = &h0632
const ILUT_GL_USE_S3TC = &h0634
const ILUT_D3D_USE_DXTC = &h0634
const ILUT_GL_GEN_S3TC = &h0635
const ILUT_D3D_GEN_DXTC = &h0635
const ILUT_S3TC_FORMAT = &h0705
const ILUT_DXTC_FORMAT = &h0705
const ILUT_D3D_POOL = &h0706
const ILUT_D3D_ALPHA_KEY_COLOR = &h0707
const ILUT_D3D_ALPHA_KEY_COLOUR = &h0707
const ILUT_FORCE_INTEGER_FORMAT = &h0636
const ILUT_GL_AUTODETECT_TEXTURE_TARGET = &h0807
const ILUT_VERSION_NUM = IL_VERSION_NUM
const ILUT_VENDOR = IL_VENDOR
const ILUT_OPENGL = 0
const ILUT_ALLEGRO = 1
const ILUT_WIN32 = 2
const ILUT_DIRECT3D8 = 3
const ILUT_DIRECT3D9 = 4
const ILUT_X11 = 5
const ILUT_DIRECT3D10 = 6

#ifdef __FB_WIN32__
	#define __ILUT_CONFIG_H__
	#undef ILUT_USE_ALLEGRO
	#undef ILUT_USE_DIRECTX8
	#define ILUT_USE_OPENGL
	#define ILUT_USE_WIN32
#endif

declare function ilutDisable(byval Mode as ILenum) as ILboolean
declare function ilutEnable(byval Mode as ILenum) as ILboolean
declare function ilutGetBoolean(byval Mode as ILenum) as ILboolean
declare sub ilutGetBooleanv(byval Mode as ILenum, byval Param as ILboolean ptr)
declare function ilutGetInteger(byval Mode as ILenum) as ILint
declare sub ilutGetIntegerv(byval Mode as ILenum, byval Param as ILint ptr)
declare function ilutGetString(byval StringName as ILenum) as zstring ptr
declare sub ilutInit()
declare function ilutIsDisabled(byval Mode as ILenum) as ILboolean
declare function ilutIsEnabled(byval Mode as ILenum) as ILboolean
declare sub ilutPopAttrib()
declare sub ilutPushAttrib(byval Bits as ILuint)
declare sub ilutSetInteger(byval Mode as ILenum, byval Param as ILint)
declare function ilutRenderer(byval Renderer as ILenum) as ILboolean

#ifdef __FB_WIN32__
	declare function ilutGLBindTexImage() as GLuint
	declare function ilutGLBindMipmaps() as GLuint
	declare function ilutGLBuildMipmaps() as ILboolean
	declare function ilutGLLoadImage(byval FileName as zstring ptr) as GLuint
	declare function ilutGLScreen() as ILboolean
	declare function ilutGLScreenie() as ILboolean
	declare function ilutGLSaveImage(byval FileName as zstring ptr, byval TexID as GLuint) as ILboolean
	declare function ilutGLSubTex2D(byval TexID as GLuint, byval XOff as ILuint, byval YOff as ILuint) as ILboolean
	declare function ilutGLSubTex3D(byval TexID as GLuint, byval XOff as ILuint, byval YOff as ILuint, byval ZOff as ILuint) as ILboolean
	declare function ilutGLSetTex2D(byval TexID as GLuint) as ILboolean
	declare function ilutGLSetTex3D(byval TexID as GLuint) as ILboolean
	declare function ilutGLTexImage(byval Level as GLuint) as ILboolean
	declare function ilutGLSubTex(byval TexID as GLuint, byval XOff as ILuint, byval YOff as ILuint) as ILboolean
	declare function ilutGLSetTex(byval TexID as GLuint) as ILboolean
	declare function ilutConvertToHBitmap(byval hDC as HDC) as HBITMAP
	declare function ilutConvertSliceToHBitmap(byval hDC as HDC, byval slice as ILuint) as HBITMAP
	declare sub ilutFreePaddedData(byval Data as ILubyte ptr)
	declare sub ilutGetBmpInfo(byval Info as BITMAPINFO ptr)
	declare function ilutGetHPal() as HPALETTE
	declare function ilutGetPaddedData() as ILubyte ptr
	declare function ilutGetWinClipboard() as ILboolean
	declare function ilutLoadResource(byval hInst as HINSTANCE, byval ID as ILint, byval ResourceType as zstring ptr, byval Type as ILenum) as ILboolean
	declare function ilutSetHBitmap(byval Bitmap as HBITMAP) as ILboolean
	declare function ilutSetHPal(byval Pal as HPALETTE) as ILboolean
	declare function ilutSetWinClipboard() as ILboolean
	declare function ilutWinLoadImage(byval FileName as zstring ptr, byval hDC as HDC) as HBITMAP
	declare function ilutWinLoadUrl(byval Url as zstring ptr) as ILboolean
	declare function ilutWinPrint(byval XPos as ILuint, byval YPos as ILuint, byval Width as ILuint, byval Height as ILuint, byval hDC as HDC) as ILboolean
	declare function ilutWinSaveImage(byval FileName as zstring ptr, byval Bitmap as HBITMAP) as ILboolean
#endif

end extern
