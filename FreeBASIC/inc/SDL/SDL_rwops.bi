' SDL_rwops.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_RWops_bi_
#define SDL_RWops_bi_

'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/begin_code.bi'

#ifndef FILE_DEFINED_
type FILE
   ptr_ as byte ptr
   cnt_ as integer
   base_ as byte ptr
   flag_ as integer
   file_ as integer
   charbuf_ as integer
   bufsiz_ as integer
   tmpfname_ as byte ptr
end type
#define FILE_DEFINED_
#endif

#define SEEK_CUR 1
#define SEEK_END 2
#define SEEK_SET 0

type stdio
   autoclose as integer
   fp as FILE ptr
end type

type mem
   base as Uint8 ptr
   here as Uint8 ptr
   stop as Uint8 ptr
end type

type unknown
   data1 as any ptr
end type

union hidden
   stdio as stdio
   mem as mem
   unknown as unknown
end union

type SDL_RWops
   seek as function SDLCALL _
      (byval context as SDL_RWops ptr, byval offset as integer, _
      byval whence as integer) as integer
   read as function SDLCALL _
      (byval context as SDL_RWops ptr, byval pntr as any ptr, _
      byval size as integer, byval maxnum as integer) as integer
   write as function SDLCALL _
      (byval context as SDL_RWops ptr, byref pntr as any ptr, size as integer, _
      num as integer) as integer
   close as function SDLCALL _
      (byval context as SDL_RWops ptr) as integer
   
   type as Uint32   
   hidden as hidden
end type

declare function SDL_RWFromFile SDLCALL alias "SDL_RWFromFile" _
   (byval file as string, byval mode as string) as SDL_RWops ptr
  
declare function SDL_RWFromFP SDLCALL alias "SDL_RWFromFP" _
   (byval fp as FILE ptr, byval autoclose as integer) as SDL_RWops ptr

declare function SDL_RWFromMem SDLCALL alias "SDL_RWFromMem" _
   (byval mem as any ptr, size as integer) as SDL_RWops ptr

declare function SDL_AllocRW SDLCALL alias "SDL_AllocRW" () as SDL_RWops ptr
declare function SDL_FreeRW SDLCALL alias "SDL_FreeRW" _
   (area as SDL_RWops ptr) as SDL_RWops ptr

private function SDL_RWseek _
   (byval ctx as SDL_RWops ptr, byval offset as integer, _
   byval whence as integer)
   ctx->seek(ctx, offset, whence)
end function

private function SDL_RWtell (byval ctx as SDL_RWops ptr)
   ctx->seek(ctx, 0, SEEK_CUR)
end function

private function SDL_RWread _
   (byval ctx as SDL_RWops ptr, byval pntr as any ptr, _
   byval size as integer, byval n as integer)
   ctx->read(ctx, pntr, size, n)
end function

private function SDL_RWwrite _
   (byval ctx as SDL_RWops ptr, byval pntr as any ptr, _
   byval size as integer, byval n as integer)
   ctx->write(ctx, pntr, size, n)
end function

private function SDL_RWclose (byval ctx as SDL_RWops ptr)
   ctx->close(ctx)
end function

'$include: 'SDL/close_code.bi'

#endif