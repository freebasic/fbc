''
''
'' SDL_audio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_audio_bi__
#define __SDL_audio_bi__

#include once "crt/stdio.bi"
#include once "SDL_main.bi"
#include once "SDL_types.bi"
#include once "SDL_error.bi"
#include once "SDL_rwops.bi"
#include once "SDL_byteorder.bi"
#include once "begin_code.bi"

type SDL_AudioSpec
	freq as integer
	format as Uint16
	channels as Uint8
	silence as Uint8
	samples as Uint16
	padding as Uint16
	size as Uint32
	callback as sub cdecl(byval as any ptr, byval as Uint8 ptr, byval as integer)
	userdata as any ptr
end type

#define AUDIO_U8 &h0008
#define AUDIO_S8 &h8008
#define AUDIO_U16LSB &h0010
#define AUDIO_S16LSB &h8010
#define AUDIO_U16MSB &h1010
#define AUDIO_S16MSB &h9010
#define AUDIO_U16 &h0010
#define AUDIO_S16 &h8010
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
	filters(0 to 10-1) as sub cdecl(byval as SDL_AudioCVT ptr, byval as Uint16)
	filter_index as integer
end type

enum SDL_audiostatus
	SDL_AUDIO_STOPPED = 0
	SDL_AUDIO_PLAYING
	SDL_AUDIO_PAUSED
end enum

extern "c"
declare function SDL_AudioInit (byval driver_name as zstring ptr) as integer
declare sub SDL_AudioQuit ()
declare function SDL_AudioDriverName (byval namebuf as zstring ptr, byval maxlen as integer) as zstring ptr
declare function SDL_OpenAudio (byval desired as SDL_AudioSpec ptr, byval obtained as SDL_AudioSpec ptr) as integer
declare function SDL_GetAudioStatus () as SDL_audiostatus
declare sub SDL_PauseAudio (byval pause_on as integer)
declare function SDL_LoadWAV_RW (byval src as SDL_RWops ptr, byval freesrc as integer, byval spec as SDL_AudioSpec ptr, byval audio_buf as Uint8 ptr ptr, byval audio_len as Uint32 ptr) as SDL_AudioSpec ptr
#define SDL_LoadWAV(file,spec,audio_buf,audio_len) SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len)
declare sub SDL_FreeWAV (byval audio_buf as Uint8 ptr)
declare function SDL_BuildAudioCVT (byval cvt as SDL_AudioCVT ptr, byval src_format as Uint16, byval src_channels as Uint8, byval src_rate as integer, byval dst_format as Uint16, byval dst_channels as Uint8, byval dst_rate as integer) as integer
declare function SDL_ConvertAudio (byval cvt as SDL_AudioCVT ptr) as integer
declare sub SDL_MixAudio (byval dst as Uint8 ptr, byval src as Uint8 ptr, byval len as Uint32, byval volume as integer)
declare sub SDL_LockAudio ()
declare sub SDL_UnlockAudio ()
declare sub SDL_CloseAudio ()
end extern

#define SDL_MIX_MAXVOLUME 128

#include once "close_code.bi"

#endif
