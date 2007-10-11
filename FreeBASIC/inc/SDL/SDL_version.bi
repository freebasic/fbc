''
''
'' SDL_version -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_version_bi__
#define __SDL_version_bi__

#include once "SDL_types.bi"
#include once "begin_code.bi"

#define SDL_MAJOR_VERSION 1
#define SDL_MINOR_VERSION 2
#define SDL_PATCHLEVEL 9

type SDL_version
	major as Uint8
	minor as Uint8
	patch as Uint8
end type

#define SDL_VERSION_(X) _
	(X)->major = SDL_MAJOR_VERSION :_ 
	(X)->minor = SDL_MINOR_VERSION :_
	(X)->patch = SDL_PATCHLEVEL

#define SDL_VERSIONNUM(X,Y,Z) ((X) * 1000 + (Y) * 100 + (Z))

#define SDL_COMPILEDVERSION SDL_VERSIONNUM(SDL_MAJOR_VERSION, SDL_MINOR_VERSION, SDL_PATCHLEVEL)

#define SDL_VERSION_ATLEAST(X,Y,Z) (SDL_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))

declare function SDL_Linked_Version cdecl alias "SDL_Linked_Version" () as SDL_version ptr

#include once "close_code.bi"

#endif
