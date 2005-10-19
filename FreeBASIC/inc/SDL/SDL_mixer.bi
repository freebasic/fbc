''
''
'' SDL_mixer -- multi-channel audio mixer library
''				(header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_mixer_bi__
#define __SDL_mixer_bi__

#inclib "SDL_mixer"

#include once "SDL/SDL_types.bi"
#include once "SDL/SDL_rwops.bi"
#include once "SDL/SDL_audio.bi"
#include once "SDL/SDL_byteorder.bi"
#include once "SDL/SDL_version.bi"
#include once "SDL/begin_code.bi"

#define SDL_MIXER_MAJOR_VERSION 1
#define SDL_MIXER_MINOR_VERSION 2
#define SDL_MIXER_PATCHLEVEL 6

#define SDL_MIXER_VERSION(X)						_
	(X)->major = SDL_MIXER_MAJOR_VERSION			:_
	(X)->minor = SDL_MIXER_MINOR_VERSION			:_
	(X)->patch = SDL_MIXER_PATCHLEVEL

#define MIX_MAJOR_VERSION	SDL_MIXER_MAJOR_VERSION
#define MIX_MINOR_VERSION	SDL_MIXER_MINOR_VERSION
#define MIX_PATCHLEVEL		SDL_MIXER_PATCHLEVEL
#define MIX_VERSION(X)		SDL_MIXER_VERSION(X)

declare function Mix_Linked_Version cdecl alias "Mix_Linked_Version" () as SDL_version ptr

#ifndef MIX_CHANNELS
# define MIX_CHANNELS 8
#endif
#define MIX_DEFAULT_FREQUENCY 22050
#if SDL_BYTEORDER = SDL_LIL_ENDIAN
# define MIX_DEFAULT_FORMAT	AUDIO_S16LSB
#else
# define MIX_DEFAULT_FORMAT	AUDIO_S16MSB
#endif
#define MIX_DEFAULT_CHANNELS 2
#define MIX_MAX_VOLUME 128

type Mix_Chunk
	allocated as integer
	abuf as Uint8 ptr
	alen as Uint32
	volume as Uint8
end type

enum Mix_Fading
	MIX_NO_FADING
	MIX_FADING_OUT
	MIX_FADING_IN
end enum


enum Mix_MusicType
	MUS_NONE
	MUS_CMD
	MUS_WAV
	MUS_MOD
	MUS_MID
	MUS_OGG
	MUS_MP3
end enum

type Mix_Music as _Mix_Music

declare function Mix_OpenAudio cdecl alias "Mix_OpenAudio" (byval frequency as integer, byval format as Uint16, byval channels as integer, byval chunksize as integer) as integer
declare function Mix_AllocateChannels cdecl alias "Mix_AllocateChannels" (byval numchans as integer) as integer
declare function Mix_QuerySpec cdecl alias "Mix_QuerySpec" (byval frequency as integer ptr, byval format as Uint16 ptr, byval channels as integer ptr) as integer
declare function Mix_LoadWAV_RW cdecl alias "Mix_LoadWAV_RW" (byval src as SDL_RWops ptr, byval freesrc as integer) as Mix_Chunk ptr
declare function Mix_LoadMUS cdecl alias "Mix_LoadMUS" (byval file as zstring ptr) as Mix_Music ptr
declare function Mix_QuickLoad_WAV cdecl alias "Mix_QuickLoad_WAV" (byval mem as Uint8 ptr) as Mix_Chunk ptr
declare function Mix_QuickLoad_RAW cdecl alias "Mix_QuickLoad_RAW" (byval mem as Uint8 ptr, byval len as Uint32) as Mix_Chunk ptr
declare sub Mix_FreeChunk cdecl alias "Mix_FreeChunk" (byval chunk as Mix_Chunk ptr)
declare sub Mix_FreeMusic cdecl alias "Mix_FreeMusic" (byval music as Mix_Music ptr)
declare function Mix_GetMusicType cdecl alias "Mix_GetMusicType" (byval music as Mix_Music ptr) as Mix_MusicType
declare sub Mix_SetPostMix cdecl alias "Mix_SetPostMix" (byval mix_func as sub cdecl(byval as any ptr, byval as Uint8 ptr, byval as integer), byval arg as any ptr)
declare sub Mix_HookMusic cdecl alias "Mix_HookMusic" (byval mix_func as sub cdecl(byval as any ptr, byval as Uint8 ptr, byval as integer), byval arg as any ptr)
declare sub Mix_HookMusicFinished cdecl alias "Mix_HookMusicFinished" (byval music_finished as sub cdecl())
declare function Mix_GetMusicHookData cdecl alias "Mix_GetMusicHookData" () as any ptr
declare sub Mix_ChannelFinished cdecl alias "Mix_ChannelFinished" (byval channel_finished as sub cdecl(byval as integer))

#define Mix_LoadWav(file) Mix_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1)

#define MIX_CHANNEL_POST -2

type Mix_EffectFunc_t as sub cdecl(byval as integer, byval as any ptr, byval as integer, byval as any ptr)
type Mix_EffectDone_t as sub cdecl(byval as integer, byval as any ptr)

declare function Mix_RegisterEffect cdecl alias "Mix_RegisterEffect" (byval chan as integer, byval f as Mix_EffectFunc_t, byval d as Mix_EffectDone_t, byval arg as any ptr) as integer
declare function Mix_UnregisterEffect cdecl alias "Mix_UnregisterEffect" (byval channel as integer, byval f as Mix_EffectFunc_t) as integer
declare function Mix_UnregisterAllEffects cdecl alias "Mix_UnregisterAllEffects" (byval channel as integer) as integer

#define MIX_EFFECTSMAXSPEED "MIX_EFFECTSMAXSPEED"

declare function Mix_SetPanning cdecl alias "Mix_SetPanning" (byval channel as integer, byval left as Uint8, byval right as Uint8) as integer
declare function Mix_SetPosition cdecl alias "Mix_SetPosition" (byval channel as integer, byval angle as Sint16, byval distance as Uint8) as integer
declare function Mix_SetDistance cdecl alias "Mix_SetDistance" (byval channel as integer, byval distance as Uint8) as integer
declare function Mix_SetReverseStereo cdecl alias "Mix_SetReverseStereo" (byval channel as integer, byval flip as integer) as integer
declare function Mix_ReserveChannels cdecl alias "Mix_ReserveChannels" (byval num as integer) as integer
declare function Mix_GroupChannel cdecl alias "Mix_GroupChannel" (byval which as integer, byval tag as integer) as integer
declare function Mix_GroupChannels cdecl alias "Mix_GroupChannels" (byval from as integer, byval to as integer, byval tag as integer) as integer
declare function Mix_GroupAvailable cdecl alias "Mix_GroupAvailable" (byval tag as integer) as integer
declare function Mix_GroupCount cdecl alias "Mix_GroupCount" (byval tag as integer) as integer
declare function Mix_GroupOldest cdecl alias "Mix_GroupOldest" (byval tag as integer) as integer
declare function Mix_GroupNewer cdecl alias "Mix_GroupNewer" (byval tag as integer) as integer
declare function Mix_PlayChannelTimed cdecl alias "Mix_PlayChannelTimed" (byval channel as integer, byval chunk as Mix_Chunk ptr, byval loops as integer, byval ticks as integer) as integer
declare function Mix_PlayMusic cdecl alias "Mix_PlayMusic" (byval music as Mix_Music ptr, byval loops as integer) as integer
declare function Mix_FadeInMusic cdecl alias "Mix_FadeInMusic" (byval music as Mix_Music ptr, byval loops as integer, byval ms as integer) as integer
declare function Mix_FadeInMusicPos cdecl alias "Mix_FadeInMusicPos" (byval music as Mix_Music ptr, byval loops as integer, byval ms as integer, byval position as double) as integer
declare function Mix_FadeInChannelTimed cdecl alias "Mix_FadeInChannelTimed" (byval channel as integer, byval chunk as Mix_Chunk ptr, byval loops as integer, byval ms as integer, byval ticks as integer) as integer
declare function Mix_Volume cdecl alias "Mix_Volume" (byval channel as integer, byval volume as integer) as integer
declare function Mix_VolumeChunk cdecl alias "Mix_VolumeChunk" (byval chunk as Mix_Chunk ptr, byval volume as integer) as integer
declare function Mix_VolumeMusic cdecl alias "Mix_VolumeMusic" (byval volume as integer) as integer
declare function Mix_HaltChannel cdecl alias "Mix_HaltChannel" (byval channel as integer) as integer
declare function Mix_HaltGroup cdecl alias "Mix_HaltGroup" (byval tag as integer) as integer
declare function Mix_HaltMusic cdecl alias "Mix_HaltMusic" () as integer
declare function Mix_ExpireChannel cdecl alias "Mix_ExpireChannel" (byval channel as integer, byval ticks as integer) as integer
declare function Mix_FadeOutChannel cdecl alias "Mix_FadeOutChannel" (byval which as integer, byval ms as integer) as integer
declare function Mix_FadeOutGroup cdecl alias "Mix_FadeOutGroup" (byval tag as integer, byval ms as integer) as integer
declare function Mix_FadeOutMusic cdecl alias "Mix_FadeOutMusic" (byval ms as integer) as integer
declare function Mix_FadingMusic cdecl alias "Mix_FadingMusic" () as Mix_Fading
declare function Mix_FadingChannel cdecl alias "Mix_FadingChannel" (byval which as integer) as Mix_Fading
declare sub Mix_Pause cdecl alias "Mix_Pause" (byval channel as integer)
declare sub Mix_Resume cdecl alias "Mix_Resume" (byval channel as integer)
declare function Mix_Paused cdecl alias "Mix_Paused" (byval channel as integer) as integer
declare sub Mix_PauseMusic cdecl alias "Mix_PauseMusic" ()
declare sub Mix_ResumeMusic cdecl alias "Mix_ResumeMusic" ()
declare sub Mix_RewindMusic cdecl alias "Mix_RewindMusic" ()
declare function Mix_PausedMusic cdecl alias "Mix_PausedMusic" () as integer
declare function Mix_SetMusicPosition cdecl alias "Mix_SetMusicPosition" (byval position as double) as integer
declare function Mix_Playing cdecl alias "Mix_Playing" (byval channel as integer) as integer
declare function Mix_PlayingMusic cdecl alias "Mix_PlayingMusic" () as integer
declare function Mix_SetMusicCMD cdecl alias "Mix_SetMusicCMD" (byval command as zstring ptr) as integer
declare function Mix_SetSynchroValue cdecl alias "Mix_SetSynchroValue" (byval value as integer) as integer
declare function Mix_GetSynchroValue cdecl alias "Mix_GetSynchroValue" () as integer
declare function Mix_GetChunk cdecl alias "Mix_GetChunk" (byval channel as integer) as Mix_Chunk ptr
declare sub Mix_CloseAudio cdecl alias "Mix_CloseAudio" ()

#define Mix_PlayChannel(channel,chunk,loops) Mix_PlayChannelTimed(channel,chunk,loops,-1)
#define Mix_FadeInChannel(channel,chunk,loops,ms) Mix_FadeInChannelTimed(channel,chunk,loops,ms,-1)

#define Mix_SetError SDL_SetError
#define Mix_GetError SDL_GetError

#include once "SDL/close_code.bi"

#endif
