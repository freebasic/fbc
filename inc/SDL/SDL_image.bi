'' FreeBASIC binding for SDL_image-1.2.12
''
'' based on the C header files:
''   SDL_image:  An example image loading library for use with SDL
''   Copyright (C) 1997-2012 Sam Lantinga <slouken@libsdl.org>
''
''   This software is provided 'as-is', without any express or implied
''   warranty.  In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''   1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''   2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''   3. This notice may not be removed or altered from any source distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "SDL_image"

#include once "SDL.bi"

extern "C"

#define _SDL_IMAGE_H
const SDL_IMAGE_MAJOR_VERSION = 1
const SDL_IMAGE_MINOR_VERSION = 2
const SDL_IMAGE_PATCHLEVEL = 12
#macro SDL_IMAGE_VERSION(X)
	scope
		(X)->major = SDL_IMAGE_MAJOR_VERSION
		(X)->minor = SDL_IMAGE_MINOR_VERSION
		(X)->patch = SDL_IMAGE_PATCHLEVEL
	end scope
#endmacro
declare function IMG_Linked_Version() as const SDL_version ptr

type IMG_InitFlags as long
enum
	IMG_INIT_JPG = &h00000001
	IMG_INIT_PNG = &h00000002
	IMG_INIT_TIF = &h00000004
	IMG_INIT_WEBP = &h00000008
end enum

declare function IMG_Init(byval flags as long) as long
declare sub IMG_Quit()
declare function IMG_LoadTyped_RW(byval src as SDL_RWops ptr, byval freesrc as long, byval type as zstring ptr) as SDL_Surface ptr
declare function IMG_Load(byval file as const zstring ptr) as SDL_Surface ptr
declare function IMG_Load_RW(byval src as SDL_RWops ptr, byval freesrc as long) as SDL_Surface ptr
declare function IMG_InvertAlpha(byval on as long) as long
declare function IMG_isICO(byval src as SDL_RWops ptr) as long
declare function IMG_isCUR(byval src as SDL_RWops ptr) as long
declare function IMG_isBMP(byval src as SDL_RWops ptr) as long
declare function IMG_isGIF(byval src as SDL_RWops ptr) as long
declare function IMG_isJPG(byval src as SDL_RWops ptr) as long
declare function IMG_isLBM(byval src as SDL_RWops ptr) as long
declare function IMG_isPCX(byval src as SDL_RWops ptr) as long
declare function IMG_isPNG(byval src as SDL_RWops ptr) as long
declare function IMG_isPNM(byval src as SDL_RWops ptr) as long
declare function IMG_isTIF(byval src as SDL_RWops ptr) as long
declare function IMG_isXCF(byval src as SDL_RWops ptr) as long
declare function IMG_isXPM(byval src as SDL_RWops ptr) as long
declare function IMG_isXV(byval src as SDL_RWops ptr) as long
declare function IMG_isWEBP(byval src as SDL_RWops ptr) as long
declare function IMG_LoadICO_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadCUR_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadBMP_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadGIF_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadJPG_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadLBM_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPCX_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNG_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNM_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTGA_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTIF_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXCF_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXPM_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXV_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadWEBP_RW(byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_ReadXPMFromArray(byval xpm as zstring ptr ptr) as SDL_Surface ptr
declare sub IMG_SetError alias "SDL_SetError"(byval fmt as const zstring ptr, ...)
declare function IMG_GetError alias "SDL_GetError"() as zstring ptr

end extern
