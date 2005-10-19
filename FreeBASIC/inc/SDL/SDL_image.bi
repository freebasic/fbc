''
''
'' SDL_image -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_image_bi__
#define __SDL_image_bi__

#inclib "SDL_image"

#include once "SDL/SDL.bi"
#include once "SDL/SDL_version.bi"
#include once "SDL/begin_code.bi"

#define SDL_IMAGE_MAJOR_VERSION 1
#define SDL_IMAGE_MINOR_VERSION 2
#define SDL_IMAGE_PATCHLEVEL 4

#define SDL_IMAGE_VERSION(X)					_
	(X)->major = SDL_IMAGE_MAJOR_VERSION		:_
	(X)->minor = SDL_IMAGE_MINOR_VERSION		:_
	(X)->patch = SDL_IMAGE_PATCHLEVEL

declare function IMG_Linked_Version cdecl alias "IMG_Linked_Version" () as SDL_version ptr
declare function IMG_LoadTyped_RW cdecl alias "IMG_LoadTyped_RW" (byval src as SDL_RWops ptr, byval freesrc as integer, byval type as zstring ptr) as SDL_Surface ptr
declare function IMG_Load cdecl alias "IMG_Load" (byval file as zstring ptr) as SDL_Surface ptr
declare function IMG_Load_RW cdecl alias "IMG_Load_RW" (byval src as SDL_RWops ptr, byval freesrc as integer) as SDL_Surface ptr
declare function IMG_InvertAlpha cdecl alias "IMG_InvertAlpha" (byval on as integer) as integer
declare function IMG_isBMP cdecl alias "IMG_isBMP" (byval src as SDL_RWops ptr) as integer
declare function IMG_isPNM cdecl alias "IMG_isPNM" (byval src as SDL_RWops ptr) as integer
declare function IMG_isXPM cdecl alias "IMG_isXPM" (byval src as SDL_RWops ptr) as integer
declare function IMG_isXCF cdecl alias "IMG_isXCF" (byval src as SDL_RWops ptr) as integer
declare function IMG_isPCX cdecl alias "IMG_isPCX" (byval src as SDL_RWops ptr) as integer
declare function IMG_isGIF cdecl alias "IMG_isGIF" (byval src as SDL_RWops ptr) as integer
declare function IMG_isJPG cdecl alias "IMG_isJPG" (byval src as SDL_RWops ptr) as integer
declare function IMG_isTIF cdecl alias "IMG_isTIF" (byval src as SDL_RWops ptr) as integer
declare function IMG_isPNG cdecl alias "IMG_isPNG" (byval src as SDL_RWops ptr) as integer
declare function IMG_isLBM cdecl alias "IMG_isLBM" (byval src as SDL_RWops ptr) as integer
declare function IMG_LoadBMP_RW cdecl alias "IMG_LoadBMP_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNM_RW cdecl alias "IMG_LoadPNM_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXPM_RW cdecl alias "IMG_LoadXPM_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXCF_RW cdecl alias "IMG_LoadXCF_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPCX_RW cdecl alias "IMG_LoadPCX_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadGIF_RW cdecl alias "IMG_LoadGIF_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadJPG_RW cdecl alias "IMG_LoadJPG_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTIF_RW cdecl alias "IMG_LoadTIF_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNG_RW cdecl alias "IMG_LoadPNG_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTGA_RW cdecl alias "IMG_LoadTGA_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadLBM_RW cdecl alias "IMG_LoadLBM_RW" (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_ReadXPMFromArray cdecl alias "IMG_ReadXPMFromArray" (byval xpm as byte ptr ptr) as SDL_Surface ptr

#define IMG_SetError	SDL_SetError
#define IMG_GetError	SDL_GetError

#include once "SDL/close_code.bi"

#endif
