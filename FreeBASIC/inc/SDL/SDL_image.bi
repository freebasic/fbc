' SDL_image.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

#ifndef SDL_IMAGE_BI_
#define SDL_IMAGE_BI_

#inclib "SDL"
#inclib "SDL_image"

#include once "SDL/SDL.bi"
#include once "SDL/SDL_version.bi"
#include once "SDL/begin_code.bi"

#define SDL_IMAGE_MAJOR_VERSION 1
#define SDL_IMAGE_MINOR_VERSION 2
#define SDL_IMAGE_PATCHLEVEL 4

#define SDL_IMAGE_VERSION(X) X->major = SDL_IMAGE_MAJOR_VERSION : X->minor = SDL_IMAGE_MINOR_VERSION : X->patch = SDL_IMAGE_PATCHLEVEL

declare function IMG_Linked_Version SDLCALL alias "IMG_Linked_Version" _
   () as SDL_version ptr

declare function IMG_LoadTyped_RW SDLCALL alias "IMG_LoadTyped_RW" _
   (byval src as SDL_RWops ptr, byval freesrc as integer, byval typ as string) _
   as SDL_Surface ptr
declare function IMG_Load SDLCALL alias "IMG_Load" _
   (byval file as string) as SDL_Surface ptr
declare function IMG_Load_RW SDLCALL alias "IMG_Load_RW" _
   (byval src as SDL_RWops ptr, freesrc as integer) as SDL_Surface ptr

declare function IMG_InvertAlpha SDLCALL alias "Img_InvertAlpha" _
   (byval on as integer) as integer

declare function IMG_isBMP SDLCALL alias "IMG_isBMP" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isPNM SDLCALL alias "IMG_isPNM" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isXPM SDLCALL alias "IMG_isXPM" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isXCF SDLCALL alias "IMG_isXCF" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isPCX SDLCALL alias "IMG_isPCX" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isGIF SDLCALL alias "IMG_isGIF" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isJPG SDLCALL alias "IMG_isJPG" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isTIF SDLCALL alias "IMG_isTIF" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isPNG SDLCALL alias "IMG_isPNG" _
   (byval src as SDL_RWops ptr) as integer
declare function IMG_isLBM SDLCALL alias "IMG_isLBM" _
   (byval src as SDL_RWops ptr) as integer

declare function IMG_LoadBMP_RW SDLCALL alias "IMG_LoadBMP_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNM_RW SDLCALL alias "IMG_LoadPNM_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXPM_RW SDLCALL alias "IMG_LoadXPM_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadXCF_RW SDLCALL alias "IMG_LoadXCF_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPCX_RW SDLCALL alias "IMG_LoadPCX_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadGIF_RW SDLCALL alias "IMG_LoadGIF_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadJPG_RW SDLCALL alias "IMG_LoadJPG_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTIF_RW SDLCALL alias "IMG_LoadTIF_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadPNG_RW SDLCALL alias "IMG_LoadPNG_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadTGA_RW SDLCALL alias "IMG_LoadTGA_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr
declare function IMG_LoadLBM_RW SDLCALL alias "IMG_LoadLBM_RW" _
   (byval src as SDL_RWops ptr) as SDL_Surface ptr

declare function IMG_ReadXMPFromArray SDLCALL alias "IMG_ReadXMPFromArray" _
   (byval xpm as byte ptr) as SDL_Surface ptr

#define IMG_SetError	SDL_SetError
#define IMG_GetError	SDL_GetError

#include once "SDL/close_code.bi"

#endif