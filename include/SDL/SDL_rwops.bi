''
''
'' SDL_rwops -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_rwops_bi__
#define __SDL_rwops_bi__

#include once "crt/stdio.bi"
#include once "SDL_types.bi"
#include once "begin_code.bi"

type SDL_RWops_unknown
	data1 as any ptr
end type

type SDL_RWops_mem
	base as Uint8 ptr
	here as Uint8 ptr
	stop as Uint8 ptr
end type

type SDL_RWops_stdio
	autoclose as integer
	fp as FILE ptr
end type

union SDL_RWops_hidden
	stdio as SDL_RWops_stdio
	mem as SDL_RWops_mem
	unknown as SDL_RWops_unknown
end union

type SDL_RWops
	seek as function cdecl(byval as SDL_RWops ptr, byval as integer, byval as integer) as integer
	read as function cdecl(byval as SDL_RWops ptr, byval as any ptr, byval as integer, byval as integer) as integer
	write as function cdecl(byval as SDL_RWops ptr, byval as any ptr, byval as integer, byval as integer) as integer
	close as function cdecl(byval as SDL_RWops ptr) as integer
	type as Uint32
	hidden as SDL_RWops_hidden
end type


declare function SDL_RWFromFile cdecl alias "SDL_RWFromFile" (byval file as zstring ptr, byval mode as zstring ptr) as SDL_RWops ptr
declare function SDL_RWFromFP cdecl alias "SDL_RWFromFP" (byval fp as FILE ptr, byval autoclose as integer) as SDL_RWops ptr
declare function SDL_RWFromMem cdecl alias "SDL_RWFromMem" (byval mem as any ptr, byval size as integer) as SDL_RWops ptr
declare function SDL_RWFromConstMem cdecl alias "SDL_RWFromConstMem" (byval mem as any ptr, byval size as integer) as SDL_RWops ptr
declare function SDL_AllocRW cdecl alias "SDL_AllocRW" () as SDL_RWops ptr
declare sub SDL_FreeRW cdecl alias "SDL_FreeRW" (byval area as SDL_RWops ptr)

#define SDL_RWseek(ctx,offset,whence)	(ctx)->seek(ctx, offset, whence)
#define SDL_RWtell(ctx)	(ctx)->seek(ctx, 0, SEEK_CUR)
#define SDL_RWread(ctx,ptr_,size,n) (ctx)->read(ctx, ptr_, size, n)
#define SDL_RWwrite(ctx,ptr_,size,n) (ctx)->write(ctx, ptr_, size, n)
#define SDL_RWclose(ctx) (ctx)->close(ctx)


#include once "close_code.bi"

#endif
