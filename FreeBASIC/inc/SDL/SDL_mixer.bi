' SDL_mixer.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"
'$inclib: "SDL_mixer"

#ifndef MIXER_BI_
#define MIXER_BI_

'$include: "SDL/SDL_types.bi"
'$include: "SDL/SDL_rwops.bi"
'$include: "SDL/SDL_audio.bi"
'$include: "SDL/SDL_byteorder.bi"
'$include: "SDL/SDL_version.bi"
'$include: "SDL/begin_code.bi"

#define MIX_MAJOR_VERSION 1
#define MIX_MINOR_VERSION 2
#define MIX_PATCHLEVEL 6

private sub MIX_VERSION (byval X as SDL_version ptr)
   X->major = MIX_MAJOR_VERSION
   X->minor = MIX_MINOR_VERSION
   X->patch = MIX_PATCHLEVEL
end sub

declare function Mix_Linked_Version SDLCALL alias "Mix_Linked_Version" _
   () as SDL_version ptr

#ifndef MIX_CHANNELS
#define MIX_CHANNELS 8
#endif

#define MIX_DEFAULT_FREQUENCY 22050
#if SDL_BYTEORDER = SDL_LIL_ENDIAN
#define MIX_DEFAULT_FORMAT	AUDIO_S16LSB
#else
#define MIX_DEFAULT_FORMAT	AUDIO_S16MSB
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

#define Mix_Music any

declare function Mix_OpenAudio SDLCALL alias "Mix_OpenAudio" _
   (byval frequency as integer, byval format as Uint16, _
   byval channels as integer, byval chunksize as integer) as integer

declare function Mix_AllocateChannels SDLCALL alias "Mix_AllocateChannels" _
   (byval numchans as integer) as integer

declare function Mix_QuerySpec SDLCALL alias "Mix_QuerySpec" _
   (byval frequency as integer ptr, format as Uint16 ptr, _
   channels as integer ptr) as integer

declare function Mix_LoadWAV_RW SDLCALL alias "Mix_LoadWAV_RW" _
   (byval src as SDL_RWops ptr, byval freesrc as integer) as Mix_Chunk ptr
private function Mix_LoadWav (byref file as string) as Mix_Chunk ptr
   Mix_LoadWav = Mix_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1)
end function
declare function Mix_LoadMUS SDLCALL alias "Mix_LoadMUS" _
   (byval file as string) as Mix_Music ptr

declare function Mix_QuickLoad_WAV SDLCALL alias "Mix_QuickLoad_WAV" _
   (byval mem as Uint8 ptr) as Mix_Chunk ptr

declare function Mix_QuickLoad_RAW SDLCALL alias "Mix_QuickLoad_RAW" _
   (byval mem as Uint8 ptr, byval len as Uint32) as Mix_Chunk ptr

declare sub Mix_FreeChunk SDLCALL alias "Mix_FreeChunk" _
   (byval chunk as Mix_Chunk ptr)
declare sub Mix_FreeMusic SDLCALL alias "Mix_FreeMusic" _
   (byval music as Mix_Music ptr)

declare function Mix_GetMusicType SDLCALL alias "Mix_GetMusicType" _
   (byval music as Mix_Music ptr) as Mix_MusicType

declare sub Mix_SetPostMix SDLCALL alias "Mix_SetPostMix" _
   (byval mix_func as sub(byval udata as any ptr, byval stream as Uint8 ptr, _
   byval len as integer), byval arg as any ptr)

declare sub Mix_HookMusic SDLCALL alias "Mix_HookMusic" _
   (byval mix_func as sub(byval udata as any ptr, byval stream as Uint8 ptr, _
   byval len as integer), byval arg as any ptr)
   
declare sub Mix_HookMusicFinished SDLCALL alias "Mix_HookMusicFinished" _
   (byval music_finished as sub())

declare function Mix_GetMusicHookData SDLCALL alias "Mix_GetMusicHookData" _
   () as any ptr

declare sub Mix_ChannelFinished SDLCALL alias "Mix_ChannelFinished" _
   (byval channel_finished as sub(byval channel as integer))

#define MIX_CHANNEL_POSE -2

#define Mix_EffectFunc_t sub _
   (byval chan as integer, byval stream as any ptr, byval len as integer, _
   byval udata as any ptr)

#define Mix_EffectDone_t sub _
   (byval chan as integer, byval udata as any ptr)

declare function Mix_RegisterEffect SDLCALL alias "Mix_RegisterEffect" _   
   (byval chan as integer, byval f as Mix_EffectFunc_t, _
   byval d as Mix_EffectDone_t, byval arg as any ptr) as integer

declare function Mix_UnregisterEffect SDLCALL alias "Mix_UnregisterEffect" _
   (byval channel as integer, byval f as Mix_EffectFunc_t) as integer

declare function Mix_UnregisterAllEffects SDLCALL _
   alias "Mix_UnregisterAllEffects" (byval channel as integer) as integer

#define MIX_EFFECTSMAXSPEED "MIX_EFFECTSMAXSPEED"

declare function Mix_SetPanning SDLCALL alias "Mix_SetPanning" _
   (byval channel as integer, byval left as Uint8, byval right as Uint8) _
   as integer

declare function Mix_SetPosition SDLCALL alias "Mix_SetPosition" _
   (byval channel as integer, byval angle as Sint16, byval distance as Uint8) _
   as integer

declare function Mix_SetDistance SDLCALL alias "Mix_SetDistance" _
   (byval channel as integer, byval distance as Uint8) as integer

#if 0
declare function Mix_SetReverb SDLCALL alias "Mix_SetReverb" _
   (byval channel as integer, byval echo as Uint8) as integer
#endif

declare function Mix_SetReverseStereo SDLCALL alias "Mix_SetReverseStereo" _
   (byval channel as integer, byval flip as integer) as integer

declare function Mix_ReserveChannels SDLCALL alias "Mix_ReserveChannels" _
   (byval num as integer) as integer

declare function Mix_GroupChannel SDLCALL alias "Mix_GroupChannel" _
   (byval which as integer, byval tag as integer) as integer

declare function Mix_GroupChannels SDLCALL alias "Mix_GroupChannels" _
   (byval from as integer, byval to as integer, byval tag as integer) as integer

declare function Mix_GroupAvailable SDLCALL alias "Mix_GroupAvailable" _
   (byval tag as integer) as integer

declare function Mix_GroupCount SDLCALL alias "Mix_GroupCount" _
   (byval tag as integer) as integer

declare function Mix_GroupOldest SDLCALL alias "Mix_GroupOldest" _
   (byval tag as integer) as integer

declare function Mix_GroupNewer SDLCALL alias "Mix_GroupNewer" _
   (byval tag as integer) as integer

declare function Mix_PlayChannelTimed SDLCALL alias "Mix_PlayChannelTimed" _
   (byval channel as integer, byval chunk as Mix_Chunk ptr, _
   byval loops as integer, byval ticks as integer) as integer
private function Mix_PlayChannel _
   (byval channel as integer, byval chunk as Mix_Chunk ptr, _
   byval loops as integer) as integer
   Mix_PlayChannel = Mix_PlayChannelTimed(channel, chunk, loops, -1)
end function
declare function Mix_PlayMusic SDLCALL alias "Mix_PlayMusic" _
   (byval music as Mix_Music ptr, byval loops as integer) as integer

declare function Mix_FadeInMusic SDLCALL alias "Mix_FadeInMusic" _
   (byval music as Mix_Music ptr, byval loops as integer, byval ms as integer) _
   as integer
declare function Mix_FadeInMusicPos SDLCALL alias "Mix_FadeInMusicPos" _
   (byval music as Mix_Music ptr, byval loops as integer, byval ms as integer, _
   byval position as integer) as integer
declare function Mix_FadeInChannelTimed SDLCALL alias "Mix_FadeInChannelTimed" _
   (byval channel as integer, byval chunk as Mix_Chunk ptr, _
   byval loops as integer, byval ms as integer, byval ticks as integer) _
   as integer

declare function Mix_Volume SDLCALL alias "Mix_Volume" _
   (byval channel as integer, byval volume as integer) as integer
declare function Mix_VolumeChunk SDLCALL alias "Mix_VolumeChunk" _
   (byval chunk as Mix_Chunk ptr, byval volume as integer) as integer
declare function Mix_VolumeMusic SDLCALL alias "Mix_VolumeMusic" _
   (byval volume as integer) as integer

declare function Mix_HaltChannel SDLCALL alias "Mix_HaltChannel" _
   (byval channel as integer) as integer
declare function Mix_HaltGroup SDLCALL alias "Mix_HaltGroup" _
   (byval tag as integer) as integer
declare function Mix_HaltMusic SDLCALL alias "Mix_HaltMusic" () as integer

declare function Mix_ExpireChannel SDLCALL alias "Mix_ExpireChannel" _
   (byval channel as integer, byval ticks as integer) as integer

declare function Mix_FadeOutChannel SDLCALL alias "Mix_FadeOutChannel" _
   (byval which as integer, byval ms as integer) as integer
declare function Mix_FadeOutGroup SDLCALL alias "Mix_FadeOutGroup" _
   (byval tag as integer, byval ms as integer) as integer
declare function Mix_FadeOutMusic SDLCALL alias "Mix_FadeOutMusic" _
   (byval ms as integer) as integer

declare function Mix_FadingMusic SDLCALL alias "Mix_FadingMusic" _
   () as Mix_Fading
declare function Mix_FadingChannel SDLCALL alias "Mix_FadingChannel" _
   (byval which as integer) as Mix_Fading

declare sub Mix_Pause SDLCALL alias "Mix_Pause" (byval channel as integer)
declare sub Mix_Resume SDLCALL alias "Mix_Resume" (byval channel as integer)
declare function Mix_Paused SDLCALL alias "Mix_Paused" _
   (byval channel as integer) as integer

declare sub Mix_PauseMusic SDLCALL alias "Mix_PauseMusic" ()
declare sub Mix_ResumeMusic SDLCALL alias "Mix_ResumeMusic" ()
declare sub Mix_RewindMusic SDLCALL alias "Mix_RewindMusic" ()
declare function Mix_PausedMusic SDLCALL alias "Mix_PausedMusic" () as integer

declare function Mix_SetMusicPosition SDLCALL alias "Mix_SetMusicPosition" _
   (byval position as integer) as integer

declare function Mix_Playing SDLCALL alias "Mix_Playing" _
   (byval channel as integer) as integer
declare function Mix_PlayingMusic SDLCALL alias "Mix_PlayingMusic" _
   () as integer

declare function Mix_SetMusicCMD SDLCALL alias "Mix_SetMusicCMD" _
   (byval command as string) as integer

declare function Mix_SetSynchroValue SDLCALL alias "Mix_SetSynchroValue" _
   (byval value as integer) as integer
declare function Mix_GetSynchroValue SDLCALL alias "Mix_GetSynchroValue" _
   () as integer

declare function Mix_GetChunk SDLCALL alias "Mix_GetChunk" _
   (byval channel as integer) as Mix_Chunk ptr

declare sub Mix_CloseAudio SDLCALL alias "Mix_CloseAudio" ()

#define Mix_SetError SDL_SetError
#define Mix_GetError SDL_GetError

'$include: "SDL/close_code.bi"

#endif