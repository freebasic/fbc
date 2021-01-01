'' FreeBASIC binding for SDL2_mixer-2.0.4
''
'' based on the C header files:
''   SDL_mixer:  An audio mixer library based on the SDL library
''   Copyright (C) 1997-2018 Sam Lantinga <slouken@libsdl.org>
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

#inclib "SDL2_mixer"

#include once "SDL.bi"

extern "C"

#define SDL_MIXER_H_
const SDL_MIXER_MAJOR_VERSION = 2
const SDL_MIXER_MINOR_VERSION = 0
const SDL_MIXER_PATCHLEVEL = 4
#macro SDL_MIXER_VERSION(X)
	scope
		(X)->major = SDL_MIXER_MAJOR_VERSION
		(X)->minor = SDL_MIXER_MINOR_VERSION
		(X)->patch = SDL_MIXER_PATCHLEVEL
	end scope
#endmacro
const MIX_MAJOR_VERSION = SDL_MIXER_MAJOR_VERSION
const MIX_MINOR_VERSION = SDL_MIXER_MINOR_VERSION
const MIX_PATCHLEVEL = SDL_MIXER_PATCHLEVEL
#define MIX_VERSION(X) SDL_MIXER_VERSION(X)
#define SDL_MIXER_COMPILEDVERSION SDL_VERSIONNUM(SDL_MIXER_MAJOR_VERSION, SDL_MIXER_MINOR_VERSION, SDL_MIXER_PATCHLEVEL)
#define SDL_MIXER_VERSION_ATLEAST(X, Y, Z) (SDL_MIXER_COMPILEDVERSION >= SDL_VERSIONNUM(X, Y, Z))
declare function Mix_Linked_Version() as const SDL_version ptr

type MIX_InitFlags as long
enum
	MIX_INIT_FLAC = &h00000001
	MIX_INIT_MOD = &h00000002
	MIX_INIT_MP3 = &h00000008
	MIX_INIT_OGG = &h00000010
	MIX_INIT_MID = &h00000020
	MIX_INIT_OPUS = &h00000040
end enum

declare function Mix_Init(byval flags as long) as long
declare sub Mix_Quit()
const MIX_CHANNELS = 8
const MIX_DEFAULT_FREQUENCY = 22050
const MIX_DEFAULT_FORMAT = AUDIO_S16LSB
const MIX_DEFAULT_CHANNELS = 2
const MIX_MAX_VOLUME = SDL_MIX_MAXVOLUME

type Mix_Chunk
	allocated as long
	abuf as Uint8 ptr
	alen as Uint32
	volume as Uint8
end type

type Mix_Fading as long
enum
	MIX_NO_FADING
	MIX_FADING_OUT
	MIX_FADING_IN
end enum

type Mix_MusicType as long
enum
	MUS_NONE
	MUS_CMD
	MUS_WAV
	MUS_MOD
	MUS_MID
	MUS_OGG
	MUS_MP3
	MUS_MP3_MAD_UNUSED
	MUS_FLAC
	MUS_MODPLUG_UNUSED
	MUS_OPUS
end enum

type Mix_Music as _Mix_Music
declare function Mix_OpenAudio(byval frequency as long, byval format as Uint16, byval channels as long, byval chunksize as long) as long
declare function Mix_OpenAudioDevice(byval frequency as long, byval format as Uint16, byval channels as long, byval chunksize as long, byval device as const zstring ptr, byval allowed_changes as long) as long
declare function Mix_AllocateChannels(byval numchans as long) as long
declare function Mix_QuerySpec(byval frequency as long ptr, byval format as Uint16 ptr, byval channels as long ptr) as long
declare function Mix_LoadWAV_RW(byval src as SDL_RWops ptr, byval freesrc as long) as Mix_Chunk ptr
#define Mix_LoadWAV(file) Mix_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1)
declare function Mix_LoadMUS(byval file as const zstring ptr) as Mix_Music ptr
declare function Mix_LoadMUS_RW(byval src as SDL_RWops ptr, byval freesrc as long) as Mix_Music ptr
declare function Mix_LoadMUSType_RW(byval src as SDL_RWops ptr, byval type as Mix_MusicType, byval freesrc as long) as Mix_Music ptr
declare function Mix_QuickLoad_WAV(byval mem as Uint8 ptr) as Mix_Chunk ptr
declare function Mix_QuickLoad_RAW(byval mem as Uint8 ptr, byval len as Uint32) as Mix_Chunk ptr
declare sub Mix_FreeChunk(byval chunk as Mix_Chunk ptr)
declare sub Mix_FreeMusic(byval music as Mix_Music ptr)
declare function Mix_GetNumChunkDecoders() as long
declare function Mix_GetChunkDecoder(byval index as long) as const zstring ptr
declare function Mix_HasChunkDecoder(byval name as const zstring ptr) as SDL_bool
declare function Mix_GetNumMusicDecoders() as long
declare function Mix_GetMusicDecoder(byval index as long) as const zstring ptr
declare function Mix_HasMusicDecoder(byval name as const zstring ptr) as SDL_bool
declare function Mix_GetMusicType(byval music as const Mix_Music ptr) as Mix_MusicType
declare sub Mix_SetPostMix(byval mix_func as sub(byval udata as any ptr, byval stream as Uint8 ptr, byval len as long), byval arg as any ptr)
declare sub Mix_HookMusic(byval mix_func as sub(byval udata as any ptr, byval stream as Uint8 ptr, byval len as long), byval arg as any ptr)
declare sub Mix_HookMusicFinished(byval music_finished as sub())
declare function Mix_GetMusicHookData() as any ptr
declare sub Mix_ChannelFinished(byval channel_finished as sub(byval channel as long))
const MIX_CHANNEL_POST = -2
type Mix_EffectFunc_t as sub(byval chan as long, byval stream as any ptr, byval len as long, byval udata as any ptr)
type Mix_EffectDone_t as sub(byval chan as long, byval udata as any ptr)
declare function Mix_RegisterEffect(byval chan as long, byval f as Mix_EffectFunc_t, byval d as Mix_EffectDone_t, byval arg as any ptr) as long
declare function Mix_UnregisterEffect(byval channel as long, byval f as Mix_EffectFunc_t) as long
declare function Mix_UnregisterAllEffects(byval channel as long) as long
#define MIX_EFFECTSMAXSPEED "MIX_EFFECTSMAXSPEED"
declare function Mix_SetPanning(byval channel as long, byval left as Uint8, byval right as Uint8) as long
declare function Mix_SetPosition(byval channel as long, byval angle as Sint16, byval distance as Uint8) as long
declare function Mix_SetDistance(byval channel as long, byval distance as Uint8) as long
declare function Mix_SetReverseStereo(byval channel as long, byval flip as long) as long
declare function Mix_ReserveChannels(byval num as long) as long
declare function Mix_GroupChannel(byval which as long, byval tag as long) as long
declare function Mix_GroupChannels(byval from as long, byval to as long, byval tag as long) as long
declare function Mix_GroupAvailable(byval tag as long) as long
declare function Mix_GroupCount(byval tag as long) as long
declare function Mix_GroupOldest(byval tag as long) as long
declare function Mix_GroupNewer(byval tag as long) as long
#define Mix_PlayChannel(channel, chunk, loops) Mix_PlayChannelTimed(channel, chunk, loops, -1)
declare function Mix_PlayChannelTimed(byval channel as long, byval chunk as Mix_Chunk ptr, byval loops as long, byval ticks as long) as long
declare function Mix_PlayMusic(byval music as Mix_Music ptr, byval loops as long) as long
declare function Mix_FadeInMusic(byval music as Mix_Music ptr, byval loops as long, byval ms as long) as long
declare function Mix_FadeInMusicPos(byval music as Mix_Music ptr, byval loops as long, byval ms as long, byval position as double) as long
#define Mix_FadeInChannel(channel, chunk, loops, ms) Mix_FadeInChannelTimed(channel, chunk, loops, ms, -1)
declare function Mix_FadeInChannelTimed(byval channel as long, byval chunk as Mix_Chunk ptr, byval loops as long, byval ms as long, byval ticks as long) as long
declare function Mix_Volume(byval channel as long, byval volume as long) as long
declare function Mix_VolumeChunk(byval chunk as Mix_Chunk ptr, byval volume as long) as long
declare function Mix_VolumeMusic(byval volume as long) as long
declare function Mix_HaltChannel(byval channel as long) as long
declare function Mix_HaltGroup(byval tag as long) as long
declare function Mix_HaltMusic() as long
declare function Mix_ExpireChannel(byval channel as long, byval ticks as long) as long
declare function Mix_FadeOutChannel(byval which as long, byval ms as long) as long
declare function Mix_FadeOutGroup(byval tag as long, byval ms as long) as long
declare function Mix_FadeOutMusic(byval ms as long) as long
declare function Mix_FadingMusic() as Mix_Fading
declare function Mix_FadingChannel(byval which as long) as Mix_Fading
declare sub Mix_Pause(byval channel as long)
declare sub Mix_Resume(byval channel as long)
declare function Mix_Paused(byval channel as long) as long
declare sub Mix_PauseMusic()
declare sub Mix_ResumeMusic()
declare sub Mix_RewindMusic()
declare function Mix_PausedMusic() as long
declare function Mix_SetMusicPosition(byval position as double) as long
declare function Mix_Playing(byval channel as long) as long
declare function Mix_PlayingMusic() as long
declare function Mix_SetMusicCMD(byval command as const zstring ptr) as long
declare function Mix_SetSynchroValue(byval value as long) as long
declare function Mix_GetSynchroValue() as long
declare function Mix_SetSoundFonts(byval paths as const zstring ptr) as long
declare function Mix_GetSoundFonts() as const zstring ptr
declare function Mix_EachSoundFont(byval function as function(byval as const zstring ptr, byval as any ptr) as long, byval data as any ptr) as long
declare function Mix_GetChunk(byval channel as long) as Mix_Chunk ptr
declare sub Mix_CloseAudio()
declare function Mix_SetError alias "SDL_SetError"(byval fmt as const zstring ptr, ...) as long
declare function Mix_GetError alias "SDL_GetError"() as const zstring ptr
declare sub Mix_ClearError alias "SDL_ClearError"()

end extern
