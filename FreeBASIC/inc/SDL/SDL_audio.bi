' SDL_audio.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclinc: "SDL"

#ifndef SDL_audio_bi_
#define SDL_audio_bi_

'$include: 'SDL/SDL_main.bi'
'$include: 'SDL/SDL_types.bi'
'$include: 'SDL/SDL_error.bi'
'$include: 'SDL/SDL_rwops.bi'
'$include: 'SDL/SDL_byteorder.bi'

'$include: 'SDL/begin_code.bi'

type SDL_AudioSpec
   freq as integer
   format as Uint16
   channels as Uint8
   silence as Uint8
   samples as Uint16
   padding as Uint16
   size as Uint32
   callback as sub SDLCALL _
      (byval userdata as any ptr, _
      byval stream as Uint8 ptr, _
      byval leng as integer)
   userdata as any ptr
end type

#define AUDIO_U8 &h0008
#define AUDIO_S8 &h8008
#define AUDIO_U16LSB &h0010
#define AUDIO_S16LSB &h8010
#define AUDIO_U16MSB &h1010
#define AUDIO_S16MSB &h9010
#define AUDIO_U16 AUDIO_U16LSB
#define AUDIO_S16 AUDIO_S16LSB

#if SDL_BYTEORDER = SDL_LIL_ENDIAN
#define AUDIO_U16SYS AUDIO_U16LSB
#define AUDIO_S16SYS AUDIO_S16LSB
#else
#define AUDIO_U16SYS AUDIO_U16MSB
#define AUDIO_S16SYS AUDIO_S16MSB
#endif

type SDL_AudioCVT
   needed as integer
   src_format as Uint16
   dst_format as Uint16
   rate_incr as double
   buf as Uint8 ptr
   len as integer
   len_cvt as integer
   len_mult as integer
   len_ratio as double
   filters(9) as sub SDLCALL _
      (byval cvt as SDL_AudioCVT ptr, byval format as Uint16)
   filter_index as integer
end type

declare function SDL_AudioInit SDLCALL alias "SDL_AudioInit" _
   (byval driver_name as string) as integer
declare sub SDL_AudioQuit SDLCALL alias "SDL_AudioQuit" ()

declare function SDL_AudioDriverName SDLCALL alias "SDL_AudioDriverName" _
   (byval namebuf as byte ptr, byval maxlen as integer) as byte ptr

declare function SDL_OpenAudio SDLCALL alias "SDL_OpenAudio" _
   (byval desired as SDL_AudioSpec ptr, byval obtained as SDL_AudioSpec ptr) _
   as integer

enum SDL_audiostatus
   SDL_AUDIO_STOPPED = 0
   SDL_AUDIO_PLAYING
   SDL_AUDIO_PAUSED
end enum
declare function SDL_GetAudiostatus SDLCALL alias "SDL_GetAudiostatus" _
   () as SDL_audiostatus

declare sub SDL_PauseAudio SDLCALL alias "SDL_PauseAudio" _
   (byval pause_on as integer)

declare function SDL_LoadWAV_RW SDLCALL alias "SDL_LoadWAV_RW" _
   (byval src as SDL_RWops ptr, byval freesrc as integer, _
   byval spec as SDL_AudioSpec ptr, byval audio_buf as Uint8 ptr ptr, _
   byval audio_len as Uint32 ptr) as SDL_AudioSpec ptr

private function SDL_LoadWAV _
   (byref file as string, byval spec as SDL_AudioSpec ptr, _
   byval audio_buf as Uint8 ptr, byval audio_len as Uint32 ptr)
   SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len)
end function

declare sub SDL_FreeWav SDLCALL alias "SDL_FreeWav" _
   (byval audio_buf as Uint8 ptr)

declare function SDL_BuildAudioCVT SDLCALL alias "SDL_BuildAudioCVT" _
   (byval src_format as Uint16, byval src_channels as Uint8, _
   byval src_rate as integer, byval dst_format as Uint16, _
   byval dst_channels as Uint8, byval dst_rate as integer) as integer
  
declare function SDL_ConvertAudio SDLCALL alias "SDL_ConvertAudio" _
   (byval cvt as SDL_AudioCVT ptr) as integer

#define SDL_MIX_MAXVOLUME 128
declare sub SDL_MixAudio SDLCALL alias "SDL_MixAudio" _
   (byval dst as Uint8 ptr, byval src as Uint8 ptr, byval lens as Uint32, _
   byval volume as integer)
  
declare sub SDL_LockAudio SDLCALL alias "SDL_LockAudio" ()
declare sub SDL_UnlockAudio SDLCALL alias "SDL_UnlockAudio" ()

declare sub SDL_CloseAudio SDLCALL alias "SDL_CloseAudio" ()

'$include: 'SDL/close_code.bi'

#endif