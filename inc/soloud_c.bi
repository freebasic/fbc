'' FreeBASIC binding for soloud_20200207
''
'' based on the C header files:
''   SoLoud audio engine
''   Copyright (c) 2013-2020 Jari Komppa
''
''   This software is provided 'as-is', without any express or implied
''   warranty. In no event will the authors be held liable for any damages
''   arising from the use of this software.
''
''   Permission is granted to anyone to use this software for any purpose,
''   including commercial applications, and to alter it and redistribute it
''   freely, subject to the following restrictions:
''
''      1. The origin of this software must not be misrepresented; you must not
''      claim that you wrote the original software. If you use this software
''      in a product, an acknowledgment in the product documentation would be
''      appreciated but is not required.
''
''      2. Altered source versions must be plainly marked as such, and must not be
''      misrepresented as being the original software.
''
''      3. This notice may not be removed or altered from any source
''      distribution.
''
'' translated to FreeBASIC by:
''   Copyright © 2021 FreeBASIC development team

#pragma once

#ifdef SOLOUD_STATIC
	#inclib "soloud_static"
	#inclib "supc++"
#elseif (not defined(SOLOUD_STATIC)) and (defined(__FB_DOS__) or defined(__FB_UNIX__))
	#inclib "soloud"
#elseif defined(__FB_WIN32__) and (not defined(__FB_64BIT__)) and (not defined(SOLOUD_STATIC))
	#inclib "soloud_x86"
#else
	#inclib "soloud_x64"
#endif

'' The following symbols have been renamed:
''     typedef File => SLFile

extern "C"

type SOLOUD_ENUMS as long
enum
	SOLOUD_AUTO = 0
	SOLOUD_SDL1 = 1
	SOLOUD_SDL2 = 2
	SOLOUD_PORTAUDIO = 3
	SOLOUD_WINMM = 4
	SOLOUD_XAUDIO2 = 5
	SOLOUD_WASAPI = 6
	SOLOUD_ALSA = 7
	SOLOUD_JACK = 8
	SOLOUD_OSS = 9
	SOLOUD_OPENAL = 10
	SOLOUD_COREAUDIO = 11
	SOLOUD_OPENSLES = 12
	SOLOUD_VITA_HOMEBREW = 13
	SOLOUD_MINIAUDIO = 14
	SOLOUD_NOSOUND = 15
	SOLOUD_NULLDRIVER = 16
	SOLOUD_BACKEND_MAX = 17
	SOLOUD_CLIP_ROUNDOFF = 1
	SOLOUD_ENABLE_VISUALIZATION = 2
	SOLOUD_LEFT_HANDED_3D = 4
	SOLOUD_NO_FPU_REGISTER_CHANGE = 8
	BASSBOOSTFILTER_WET = 0
	BASSBOOSTFILTER_BOOST = 1
	BIQUADRESONANTFILTER_LOWPASS = 0
	BIQUADRESONANTFILTER_HIGHPASS = 1
	BIQUADRESONANTFILTER_BANDPASS = 2
	BIQUADRESONANTFILTER_WET = 0
	BIQUADRESONANTFILTER_TYPE = 1
	BIQUADRESONANTFILTER_FREQUENCY = 2
	BIQUADRESONANTFILTER_RESONANCE = 3
	ECHOFILTER_WET = 0
	ECHOFILTER_DELAY = 1
	ECHOFILTER_DECAY = 2
	ECHOFILTER_FILTER = 3
	FLANGERFILTER_WET = 0
	FLANGERFILTER_DELAY = 1
	FLANGERFILTER_FREQ = 2
	FREEVERBFILTER_WET = 0
	FREEVERBFILTER_FREEZE = 1
	FREEVERBFILTER_ROOMSIZE = 2
	FREEVERBFILTER_DAMP = 3
	FREEVERBFILTER_WIDTH = 4
	LOFIFILTER_WET = 0
	LOFIFILTER_SAMPLERATE = 1
	LOFIFILTER_BITDEPTH = 2
	NOISE_WHITE = 0
	NOISE_PINK = 1
	NOISE_BROWNISH = 2
	NOISE_BLUEISH = 3
	ROBOTIZEFILTER_WET = 0
	ROBOTIZEFILTER_FREQ = 1
	ROBOTIZEFILTER_WAVE = 2
	SFXR_COIN = 0
	SFXR_LASER = 1
	SFXR_EXPLOSION = 2
	SFXR_POWERUP = 3
	SFXR_HURT = 4
	SFXR_JUMP = 5
	SFXR_BLIP = 6
	SPEECH_KW_SAW = 0
	SPEECH_KW_TRIANGLE = 1
	SPEECH_KW_SIN = 2
	SPEECH_KW_SQUARE = 3
	SPEECH_KW_PULSE = 4
	SPEECH_KW_NOISE = 5
	SPEECH_KW_WARBLE = 6
	VIC_PAL = 0
	VIC_NTSC = 1
	VIC_BASS = 0
	VIC_ALTO = 1
	VIC_SOPRANO = 2
	VIC_NOISE = 3
	VIC_MAX_REGS = 4
	WAVESHAPERFILTER_WET = 0
	WAVESHAPERFILTER_AMOUNT = 1
end enum

type AlignedFloatBuffer as any ptr
type TinyAlignedFloatBuffer as any ptr
type Soloud as any ptr
type AudioCollider as any ptr
type AudioAttenuator as any ptr
type AudioSource as any ptr
type BassboostFilter as any ptr
type BiquadResonantFilter as any ptr
type Bus as any ptr
type DCRemovalFilter as any ptr
type EchoFilter as any ptr
type Fader as any ptr
type FFTFilter as any ptr
type Filter as any ptr
type FlangerFilter as any ptr
type FreeverbFilter as any ptr
type LofiFilter as any ptr
type Monotone as any ptr
type Noise as any ptr
type Openmpt as any ptr
type Queue as any ptr
type RobotizeFilter as any ptr
type Sfxr as any ptr
type Speech as any ptr
type TedSid as any ptr
type Vic as any ptr
type Vizsn as any ptr
type Wav as any ptr
type WaveShaperFilter as any ptr
type WavStream as any ptr
type SLFile as any ptr

declare sub Soloud_destroy(byval aSoloud as Soloud ptr)
declare function Soloud_create() as Soloud ptr
declare function Soloud_init(byval aSoloud as Soloud ptr) as long
declare function Soloud_initEx(byval aSoloud as Soloud ptr, byval aFlags as ulong, byval aBackend as ulong, byval aSamplerate as ulong, byval aBufferSize as ulong, byval aChannels as ulong) as long
declare sub Soloud_deinit(byval aSoloud as Soloud ptr)
declare function Soloud_getVersion(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getErrorString(byval aSoloud as Soloud ptr, byval aErrorCode as long) as const zstring ptr
declare function Soloud_getBackendId(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getBackendString(byval aSoloud as Soloud ptr) as const zstring ptr
declare function Soloud_getBackendChannels(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getBackendSamplerate(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getBackendBufferSize(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_setSpeakerPosition(byval aSoloud as Soloud ptr, byval aChannel as ulong, byval aX as single, byval aY as single, byval aZ as single) as long
declare function Soloud_getSpeakerPosition(byval aSoloud as Soloud ptr, byval aChannel as ulong, byval aX as single ptr, byval aY as single ptr, byval aZ as single ptr) as long
declare function Soloud_play(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr) as ulong
declare function Soloud_playEx(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr, byval aVolume as single, byval aPan as single, byval aPaused as long, byval aBus as ulong) as ulong
declare function Soloud_playClocked(byval aSoloud as Soloud ptr, byval aSoundTime as double, byval aSound as AudioSource ptr) as ulong
declare function Soloud_playClockedEx(byval aSoloud as Soloud ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aVolume as single, byval aPan as single, byval aBus as ulong) as ulong
declare function Soloud_play3d(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single) as ulong
declare function Soloud_play3dEx(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aVelX as single, byval aVelY as single, byval aVelZ as single, byval aVolume as single, byval aPaused as long, byval aBus as ulong) as ulong
declare function Soloud_play3dClocked(byval aSoloud as Soloud ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single) as ulong
declare function Soloud_play3dClockedEx(byval aSoloud as Soloud ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aVelX as single, byval aVelY as single, byval aVelZ as single, byval aVolume as single, byval aBus as ulong) as ulong
declare function Soloud_playBackground(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr) as ulong
declare function Soloud_playBackgroundEx(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr, byval aVolume as single, byval aPaused as long, byval aBus as ulong) as ulong
declare function Soloud_seek(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aSeconds as double) as long
declare sub Soloud_stop(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong)
declare sub Soloud_stopAll(byval aSoloud as Soloud ptr)
declare sub Soloud_stopAudioSource(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr)
declare function Soloud_countAudioSource(byval aSoloud as Soloud ptr, byval aSound as AudioSource ptr) as long
declare sub Soloud_setFilterParameter(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFilterId as ulong, byval aAttributeId as ulong, byval aValue as single)
declare function Soloud_getFilterParameter(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFilterId as ulong, byval aAttributeId as ulong) as single
declare sub Soloud_fadeFilterParameter(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFilterId as ulong, byval aAttributeId as ulong, byval aTo as single, byval aTime as double)
declare sub Soloud_oscillateFilterParameter(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFilterId as ulong, byval aAttributeId as ulong, byval aFrom as single, byval aTo as single, byval aTime as double)
declare function Soloud_getStreamTime(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as double
declare function Soloud_getStreamPosition(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as double
declare function Soloud_getPause(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as long
declare function Soloud_getVolume(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as single
declare function Soloud_getOverallVolume(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as single
declare function Soloud_getPan(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as single
declare function Soloud_getSamplerate(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as single
declare function Soloud_getProtectVoice(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as long
declare function Soloud_getActiveVoiceCount(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getVoiceCount(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_isValidVoiceHandle(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as long
declare function Soloud_getRelativePlaySpeed(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as single
declare function Soloud_getPostClipScaler(byval aSoloud as Soloud ptr) as single
declare function Soloud_getGlobalVolume(byval aSoloud as Soloud ptr) as single
declare function Soloud_getMaxActiveVoiceCount(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_getLooping(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as long
declare function Soloud_getLoopPoint(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as double
declare sub Soloud_setLoopPoint(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aLoopPoint as double)
declare sub Soloud_setLooping(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aLooping as long)
declare function Soloud_setMaxActiveVoiceCount(byval aSoloud as Soloud ptr, byval aVoiceCount as ulong) as long
declare sub Soloud_setInaudibleBehavior(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aMustTick as long, byval aKill as long)
declare sub Soloud_setGlobalVolume(byval aSoloud as Soloud ptr, byval aVolume as single)
declare sub Soloud_setPostClipScaler(byval aSoloud as Soloud ptr, byval aScaler as single)
declare sub Soloud_setPause(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aPause as long)
declare sub Soloud_setPauseAll(byval aSoloud as Soloud ptr, byval aPause as long)
declare function Soloud_setRelativePlaySpeed(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aSpeed as single) as long
declare sub Soloud_setProtectVoice(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aProtect as long)
declare sub Soloud_setSamplerate(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aSamplerate as single)
declare sub Soloud_setPan(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aPan as single)
declare sub Soloud_setPanAbsolute(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aLVolume as single, byval aRVolume as single)
declare sub Soloud_setPanAbsoluteEx(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aLVolume as single, byval aRVolume as single, byval aLBVolume as single, byval aRBVolume as single, byval aCVolume as single, byval aSVolume as single)
declare sub Soloud_setVolume(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aVolume as single)
declare sub Soloud_setDelaySamples(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aSamples as ulong)
declare sub Soloud_fadeVolume(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aTo as single, byval aTime as double)
declare sub Soloud_fadePan(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aTo as single, byval aTime as double)
declare sub Soloud_fadeRelativePlaySpeed(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aTo as single, byval aTime as double)
declare sub Soloud_fadeGlobalVolume(byval aSoloud as Soloud ptr, byval aTo as single, byval aTime as double)
declare sub Soloud_schedulePause(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aTime as double)
declare sub Soloud_scheduleStop(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aTime as double)
declare sub Soloud_oscillateVolume(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFrom as single, byval aTo as single, byval aTime as double)
declare sub Soloud_oscillatePan(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFrom as single, byval aTo as single, byval aTime as double)
declare sub Soloud_oscillateRelativePlaySpeed(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aFrom as single, byval aTo as single, byval aTime as double)
declare sub Soloud_oscillateGlobalVolume(byval aSoloud as Soloud ptr, byval aFrom as single, byval aTo as single, byval aTime as double)
declare sub Soloud_setGlobalFilter(byval aSoloud as Soloud ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Soloud_setVisualizationEnable(byval aSoloud as Soloud ptr, byval aEnable as long)
declare function Soloud_calcFFT(byval aSoloud as Soloud ptr) as single ptr
declare function Soloud_getWave(byval aSoloud as Soloud ptr) as single ptr
declare function Soloud_getApproximateVolume(byval aSoloud as Soloud ptr, byval aChannel as ulong) as single
declare function Soloud_getLoopCount(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong) as ulong
declare function Soloud_getInfo(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aInfoKey as ulong) as single
declare function Soloud_createVoiceGroup(byval aSoloud as Soloud ptr) as ulong
declare function Soloud_destroyVoiceGroup(byval aSoloud as Soloud ptr, byval aVoiceGroupHandle as ulong) as long
declare function Soloud_addVoiceToGroup(byval aSoloud as Soloud ptr, byval aVoiceGroupHandle as ulong, byval aVoiceHandle as ulong) as long
declare function Soloud_isVoiceGroup(byval aSoloud as Soloud ptr, byval aVoiceGroupHandle as ulong) as long
declare function Soloud_isVoiceGroupEmpty(byval aSoloud as Soloud ptr, byval aVoiceGroupHandle as ulong) as long
declare sub Soloud_update3dAudio(byval aSoloud as Soloud ptr)
declare function Soloud_set3dSoundSpeed(byval aSoloud as Soloud ptr, byval aSpeed as single) as long
declare function Soloud_get3dSoundSpeed(byval aSoloud as Soloud ptr) as single
declare sub Soloud_set3dListenerParameters(byval aSoloud as Soloud ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aAtX as single, byval aAtY as single, byval aAtZ as single, byval aUpX as single, byval aUpY as single, byval aUpZ as single)
declare sub Soloud_set3dListenerParametersEx(byval aSoloud as Soloud ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aAtX as single, byval aAtY as single, byval aAtZ as single, byval aUpX as single, byval aUpY as single, byval aUpZ as single, byval aVelocityX as single, byval aVelocityY as single, byval aVelocityZ as single)
declare sub Soloud_set3dListenerPosition(byval aSoloud as Soloud ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single)
declare sub Soloud_set3dListenerAt(byval aSoloud as Soloud ptr, byval aAtX as single, byval aAtY as single, byval aAtZ as single)
declare sub Soloud_set3dListenerUp(byval aSoloud as Soloud ptr, byval aUpX as single, byval aUpY as single, byval aUpZ as single)
declare sub Soloud_set3dListenerVelocity(byval aSoloud as Soloud ptr, byval aVelocityX as single, byval aVelocityY as single, byval aVelocityZ as single)
declare sub Soloud_set3dSourceParameters(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aPosX as single, byval aPosY as single, byval aPosZ as single)
declare sub Soloud_set3dSourceParametersEx(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aVelocityX as single, byval aVelocityY as single, byval aVelocityZ as single)
declare sub Soloud_set3dSourcePosition(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aPosX as single, byval aPosY as single, byval aPosZ as single)
declare sub Soloud_set3dSourceVelocity(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aVelocityX as single, byval aVelocityY as single, byval aVelocityZ as single)
declare sub Soloud_set3dSourceMinMaxDistance(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Soloud_set3dSourceAttenuation(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Soloud_set3dSourceDopplerFactor(byval aSoloud as Soloud ptr, byval aVoiceHandle as ulong, byval aDopplerFactor as single)
declare sub Soloud_mix(byval aSoloud as Soloud ptr, byval aBuffer as single ptr, byval aSamples as ulong)
declare sub Soloud_mixSigned16(byval aSoloud as Soloud ptr, byval aBuffer as short ptr, byval aSamples as ulong)
declare sub BassboostFilter_destroy(byval aBassboostFilter as BassboostFilter ptr)
declare function BassboostFilter_getParamCount(byval aBassboostFilter as BassboostFilter ptr) as long
declare function BassboostFilter_getParamName(byval aBassboostFilter as BassboostFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function BassboostFilter_getParamType(byval aBassboostFilter as BassboostFilter ptr, byval aParamIndex as ulong) as ulong
declare function BassboostFilter_getParamMax(byval aBassboostFilter as BassboostFilter ptr, byval aParamIndex as ulong) as single
declare function BassboostFilter_getParamMin(byval aBassboostFilter as BassboostFilter ptr, byval aParamIndex as ulong) as single
declare function BassboostFilter_setParams(byval aBassboostFilter as BassboostFilter ptr, byval aBoost as single) as long
declare function BassboostFilter_create() as BassboostFilter ptr
declare sub BiquadResonantFilter_destroy(byval aBiquadResonantFilter as BiquadResonantFilter ptr)
declare function BiquadResonantFilter_getParamCount(byval aBiquadResonantFilter as BiquadResonantFilter ptr) as long
declare function BiquadResonantFilter_getParamName(byval aBiquadResonantFilter as BiquadResonantFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function BiquadResonantFilter_getParamType(byval aBiquadResonantFilter as BiquadResonantFilter ptr, byval aParamIndex as ulong) as ulong
declare function BiquadResonantFilter_getParamMax(byval aBiquadResonantFilter as BiquadResonantFilter ptr, byval aParamIndex as ulong) as single
declare function BiquadResonantFilter_getParamMin(byval aBiquadResonantFilter as BiquadResonantFilter ptr, byval aParamIndex as ulong) as single
declare function BiquadResonantFilter_create() as BiquadResonantFilter ptr
declare function BiquadResonantFilter_setParams(byval aBiquadResonantFilter as BiquadResonantFilter ptr, byval aType as long, byval aFrequency as single, byval aResonance as single) as long
declare sub Bus_destroy(byval aBus as Bus ptr)
declare function Bus_create() as Bus ptr
declare sub Bus_setFilter(byval aBus as Bus ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare function Bus_play(byval aBus as Bus ptr, byval aSound as AudioSource ptr) as ulong
declare function Bus_playEx(byval aBus as Bus ptr, byval aSound as AudioSource ptr, byval aVolume as single, byval aPan as single, byval aPaused as long) as ulong
declare function Bus_playClocked(byval aBus as Bus ptr, byval aSoundTime as double, byval aSound as AudioSource ptr) as ulong
declare function Bus_playClockedEx(byval aBus as Bus ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aVolume as single, byval aPan as single) as ulong
declare function Bus_play3d(byval aBus as Bus ptr, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single) as ulong
declare function Bus_play3dEx(byval aBus as Bus ptr, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aVelX as single, byval aVelY as single, byval aVelZ as single, byval aVolume as single, byval aPaused as long) as ulong
declare function Bus_play3dClocked(byval aBus as Bus ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single) as ulong
declare function Bus_play3dClockedEx(byval aBus as Bus ptr, byval aSoundTime as double, byval aSound as AudioSource ptr, byval aPosX as single, byval aPosY as single, byval aPosZ as single, byval aVelX as single, byval aVelY as single, byval aVelZ as single, byval aVolume as single) as ulong
declare function Bus_setChannels(byval aBus as Bus ptr, byval aChannels as ulong) as long
declare sub Bus_setVisualizationEnable(byval aBus as Bus ptr, byval aEnable as long)
declare sub Bus_annexSound(byval aBus as Bus ptr, byval aVoiceHandle as ulong)
declare function Bus_calcFFT(byval aBus as Bus ptr) as single ptr
declare function Bus_getWave(byval aBus as Bus ptr) as single ptr
declare function Bus_getApproximateVolume(byval aBus as Bus ptr, byval aChannel as ulong) as single
declare function Bus_getActiveVoiceCount(byval aBus as Bus ptr) as ulong
declare sub Bus_setVolume(byval aBus as Bus ptr, byval aVolume as single)
declare sub Bus_setLooping(byval aBus as Bus ptr, byval aLoop as long)
declare sub Bus_set3dMinMaxDistance(byval aBus as Bus ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Bus_set3dAttenuation(byval aBus as Bus ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Bus_set3dDopplerFactor(byval aBus as Bus ptr, byval aDopplerFactor as single)
declare sub Bus_set3dListenerRelative(byval aBus as Bus ptr, byval aListenerRelative as long)
declare sub Bus_set3dDistanceDelay(byval aBus as Bus ptr, byval aDistanceDelay as long)
declare sub Bus_set3dCollider(byval aBus as Bus ptr, byval aCollider as AudioCollider ptr)
declare sub Bus_set3dColliderEx(byval aBus as Bus ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Bus_set3dAttenuator(byval aBus as Bus ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Bus_setInaudibleBehavior(byval aBus as Bus ptr, byval aMustTick as long, byval aKill as long)
declare sub Bus_setLoopPoint(byval aBus as Bus ptr, byval aLoopPoint as double)
declare function Bus_getLoopPoint(byval aBus as Bus ptr) as double
declare sub Bus_stop(byval aBus as Bus ptr)
declare sub DCRemovalFilter_destroy(byval aDCRemovalFilter as DCRemovalFilter ptr)
declare function DCRemovalFilter_create() as DCRemovalFilter ptr
declare function DCRemovalFilter_setParams(byval aDCRemovalFilter as DCRemovalFilter ptr) as long
declare function DCRemovalFilter_setParamsEx(byval aDCRemovalFilter as DCRemovalFilter ptr, byval aLength as single) as long
declare function DCRemovalFilter_getParamCount(byval aDCRemovalFilter as DCRemovalFilter ptr) as long
declare function DCRemovalFilter_getParamName(byval aDCRemovalFilter as DCRemovalFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function DCRemovalFilter_getParamType(byval aDCRemovalFilter as DCRemovalFilter ptr, byval aParamIndex as ulong) as ulong
declare function DCRemovalFilter_getParamMax(byval aDCRemovalFilter as DCRemovalFilter ptr, byval aParamIndex as ulong) as single
declare function DCRemovalFilter_getParamMin(byval aDCRemovalFilter as DCRemovalFilter ptr, byval aParamIndex as ulong) as single
declare sub EchoFilter_destroy(byval aEchoFilter as EchoFilter ptr)
declare function EchoFilter_getParamCount(byval aEchoFilter as EchoFilter ptr) as long
declare function EchoFilter_getParamName(byval aEchoFilter as EchoFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function EchoFilter_getParamType(byval aEchoFilter as EchoFilter ptr, byval aParamIndex as ulong) as ulong
declare function EchoFilter_getParamMax(byval aEchoFilter as EchoFilter ptr, byval aParamIndex as ulong) as single
declare function EchoFilter_getParamMin(byval aEchoFilter as EchoFilter ptr, byval aParamIndex as ulong) as single
declare function EchoFilter_create() as EchoFilter ptr
declare function EchoFilter_setParams(byval aEchoFilter as EchoFilter ptr, byval aDelay as single) as long
declare function EchoFilter_setParamsEx(byval aEchoFilter as EchoFilter ptr, byval aDelay as single, byval aDecay as single, byval aFilter as single) as long
declare sub FFTFilter_destroy(byval aFFTFilter as FFTFilter ptr)
declare function FFTFilter_create() as FFTFilter ptr
declare function FFTFilter_getParamCount(byval aFFTFilter as FFTFilter ptr) as long
declare function FFTFilter_getParamName(byval aFFTFilter as FFTFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function FFTFilter_getParamType(byval aFFTFilter as FFTFilter ptr, byval aParamIndex as ulong) as ulong
declare function FFTFilter_getParamMax(byval aFFTFilter as FFTFilter ptr, byval aParamIndex as ulong) as single
declare function FFTFilter_getParamMin(byval aFFTFilter as FFTFilter ptr, byval aParamIndex as ulong) as single
declare sub FlangerFilter_destroy(byval aFlangerFilter as FlangerFilter ptr)
declare function FlangerFilter_getParamCount(byval aFlangerFilter as FlangerFilter ptr) as long
declare function FlangerFilter_getParamName(byval aFlangerFilter as FlangerFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function FlangerFilter_getParamType(byval aFlangerFilter as FlangerFilter ptr, byval aParamIndex as ulong) as ulong
declare function FlangerFilter_getParamMax(byval aFlangerFilter as FlangerFilter ptr, byval aParamIndex as ulong) as single
declare function FlangerFilter_getParamMin(byval aFlangerFilter as FlangerFilter ptr, byval aParamIndex as ulong) as single
declare function FlangerFilter_create() as FlangerFilter ptr
declare function FlangerFilter_setParams(byval aFlangerFilter as FlangerFilter ptr, byval aDelay as single, byval aFreq as single) as long
declare sub FreeverbFilter_destroy(byval aFreeverbFilter as FreeverbFilter ptr)
declare function FreeverbFilter_getParamCount(byval aFreeverbFilter as FreeverbFilter ptr) as long
declare function FreeverbFilter_getParamName(byval aFreeverbFilter as FreeverbFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function FreeverbFilter_getParamType(byval aFreeverbFilter as FreeverbFilter ptr, byval aParamIndex as ulong) as ulong
declare function FreeverbFilter_getParamMax(byval aFreeverbFilter as FreeverbFilter ptr, byval aParamIndex as ulong) as single
declare function FreeverbFilter_getParamMin(byval aFreeverbFilter as FreeverbFilter ptr, byval aParamIndex as ulong) as single
declare function FreeverbFilter_create() as FreeverbFilter ptr
declare function FreeverbFilter_setParams(byval aFreeverbFilter as FreeverbFilter ptr, byval aMode as single, byval aRoomSize as single, byval aDamp as single, byval aWidth as single) as long
declare sub LofiFilter_destroy(byval aLofiFilter as LofiFilter ptr)
declare function LofiFilter_getParamCount(byval aLofiFilter as LofiFilter ptr) as long
declare function LofiFilter_getParamName(byval aLofiFilter as LofiFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function LofiFilter_getParamType(byval aLofiFilter as LofiFilter ptr, byval aParamIndex as ulong) as ulong
declare function LofiFilter_getParamMax(byval aLofiFilter as LofiFilter ptr, byval aParamIndex as ulong) as single
declare function LofiFilter_getParamMin(byval aLofiFilter as LofiFilter ptr, byval aParamIndex as ulong) as single
declare function LofiFilter_create() as LofiFilter ptr
declare function LofiFilter_setParams(byval aLofiFilter as LofiFilter ptr, byval aSampleRate as single, byval aBitdepth as single) as long
declare sub Monotone_destroy(byval aMonotone as Monotone ptr)
declare function Monotone_create() as Monotone ptr
declare function Monotone_setParams(byval aMonotone as Monotone ptr, byval aHardwareChannels as long) as long
declare function Monotone_setParamsEx(byval aMonotone as Monotone ptr, byval aHardwareChannels as long, byval aWaveform as long) as long
declare function Monotone_load(byval aMonotone as Monotone ptr, byval aFilename as const zstring ptr) as long
declare function Monotone_loadMem(byval aMonotone as Monotone ptr, byval aMem as const ubyte ptr, byval aLength as ulong) as long
declare function Monotone_loadMemEx(byval aMonotone as Monotone ptr, byval aMem as const ubyte ptr, byval aLength as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function Monotone_loadFile(byval aMonotone as Monotone ptr, byval aFile as SLFile ptr) as long
declare sub Monotone_setVolume(byval aMonotone as Monotone ptr, byval aVolume as single)
declare sub Monotone_setLooping(byval aMonotone as Monotone ptr, byval aLoop as long)
declare sub Monotone_set3dMinMaxDistance(byval aMonotone as Monotone ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Monotone_set3dAttenuation(byval aMonotone as Monotone ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Monotone_set3dDopplerFactor(byval aMonotone as Monotone ptr, byval aDopplerFactor as single)
declare sub Monotone_set3dListenerRelative(byval aMonotone as Monotone ptr, byval aListenerRelative as long)
declare sub Monotone_set3dDistanceDelay(byval aMonotone as Monotone ptr, byval aDistanceDelay as long)
declare sub Monotone_set3dCollider(byval aMonotone as Monotone ptr, byval aCollider as AudioCollider ptr)
declare sub Monotone_set3dColliderEx(byval aMonotone as Monotone ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Monotone_set3dAttenuator(byval aMonotone as Monotone ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Monotone_setInaudibleBehavior(byval aMonotone as Monotone ptr, byval aMustTick as long, byval aKill as long)
declare sub Monotone_setLoopPoint(byval aMonotone as Monotone ptr, byval aLoopPoint as double)
declare function Monotone_getLoopPoint(byval aMonotone as Monotone ptr) as double
declare sub Monotone_setFilter(byval aMonotone as Monotone ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Monotone_stop(byval aMonotone as Monotone ptr)
declare sub Noise_destroy(byval aNoise as Noise ptr)
declare function Noise_create() as Noise ptr
declare sub Noise_setOctaveScale(byval aNoise as Noise ptr, byval aOct0 as single, byval aOct1 as single, byval aOct2 as single, byval aOct3 as single, byval aOct4 as single, byval aOct5 as single, byval aOct6 as single, byval aOct7 as single, byval aOct8 as single, byval aOct9 as single)
declare sub Noise_setType(byval aNoise as Noise ptr, byval aType as long)
declare sub Noise_setVolume(byval aNoise as Noise ptr, byval aVolume as single)
declare sub Noise_setLooping(byval aNoise as Noise ptr, byval aLoop as long)
declare sub Noise_set3dMinMaxDistance(byval aNoise as Noise ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Noise_set3dAttenuation(byval aNoise as Noise ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Noise_set3dDopplerFactor(byval aNoise as Noise ptr, byval aDopplerFactor as single)
declare sub Noise_set3dListenerRelative(byval aNoise as Noise ptr, byval aListenerRelative as long)
declare sub Noise_set3dDistanceDelay(byval aNoise as Noise ptr, byval aDistanceDelay as long)
declare sub Noise_set3dCollider(byval aNoise as Noise ptr, byval aCollider as AudioCollider ptr)
declare sub Noise_set3dColliderEx(byval aNoise as Noise ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Noise_set3dAttenuator(byval aNoise as Noise ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Noise_setInaudibleBehavior(byval aNoise as Noise ptr, byval aMustTick as long, byval aKill as long)
declare sub Noise_setLoopPoint(byval aNoise as Noise ptr, byval aLoopPoint as double)
declare function Noise_getLoopPoint(byval aNoise as Noise ptr) as double
declare sub Noise_setFilter(byval aNoise as Noise ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Noise_stop(byval aNoise as Noise ptr)
declare sub Openmpt_destroy(byval aOpenmpt as Openmpt ptr)
declare function Openmpt_create() as Openmpt ptr
declare function Openmpt_load(byval aOpenmpt as Openmpt ptr, byval aFilename as const zstring ptr) as long
declare function Openmpt_loadMem(byval aOpenmpt as Openmpt ptr, byval aMem as const ubyte ptr, byval aLength as ulong) as long
declare function Openmpt_loadMemEx(byval aOpenmpt as Openmpt ptr, byval aMem as const ubyte ptr, byval aLength as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function Openmpt_loadFile(byval aOpenmpt as Openmpt ptr, byval aFile as SLFile ptr) as long
declare sub Openmpt_setVolume(byval aOpenmpt as Openmpt ptr, byval aVolume as single)
declare sub Openmpt_setLooping(byval aOpenmpt as Openmpt ptr, byval aLoop as long)
declare sub Openmpt_set3dMinMaxDistance(byval aOpenmpt as Openmpt ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Openmpt_set3dAttenuation(byval aOpenmpt as Openmpt ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Openmpt_set3dDopplerFactor(byval aOpenmpt as Openmpt ptr, byval aDopplerFactor as single)
declare sub Openmpt_set3dListenerRelative(byval aOpenmpt as Openmpt ptr, byval aListenerRelative as long)
declare sub Openmpt_set3dDistanceDelay(byval aOpenmpt as Openmpt ptr, byval aDistanceDelay as long)
declare sub Openmpt_set3dCollider(byval aOpenmpt as Openmpt ptr, byval aCollider as AudioCollider ptr)
declare sub Openmpt_set3dColliderEx(byval aOpenmpt as Openmpt ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Openmpt_set3dAttenuator(byval aOpenmpt as Openmpt ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Openmpt_setInaudibleBehavior(byval aOpenmpt as Openmpt ptr, byval aMustTick as long, byval aKill as long)
declare sub Openmpt_setLoopPoint(byval aOpenmpt as Openmpt ptr, byval aLoopPoint as double)
declare function Openmpt_getLoopPoint(byval aOpenmpt as Openmpt ptr) as double
declare sub Openmpt_setFilter(byval aOpenmpt as Openmpt ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Openmpt_stop(byval aOpenmpt as Openmpt ptr)
declare sub Queue_destroy(byval aQueue as Queue ptr)
declare function Queue_create() as Queue ptr
declare function Queue_play(byval aQueue as Queue ptr, byval aSound as AudioSource ptr) as long
declare function Queue_getQueueCount(byval aQueue as Queue ptr) as ulong
declare function Queue_isCurrentlyPlaying(byval aQueue as Queue ptr, byval aSound as AudioSource ptr) as long
declare function Queue_setParamsFromAudioSource(byval aQueue as Queue ptr, byval aSound as AudioSource ptr) as long
declare function Queue_setParams(byval aQueue as Queue ptr, byval aSamplerate as single) as long
declare function Queue_setParamsEx(byval aQueue as Queue ptr, byval aSamplerate as single, byval aChannels as ulong) as long
declare sub Queue_setVolume(byval aQueue as Queue ptr, byval aVolume as single)
declare sub Queue_setLooping(byval aQueue as Queue ptr, byval aLoop as long)
declare sub Queue_set3dMinMaxDistance(byval aQueue as Queue ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Queue_set3dAttenuation(byval aQueue as Queue ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Queue_set3dDopplerFactor(byval aQueue as Queue ptr, byval aDopplerFactor as single)
declare sub Queue_set3dListenerRelative(byval aQueue as Queue ptr, byval aListenerRelative as long)
declare sub Queue_set3dDistanceDelay(byval aQueue as Queue ptr, byval aDistanceDelay as long)
declare sub Queue_set3dCollider(byval aQueue as Queue ptr, byval aCollider as AudioCollider ptr)
declare sub Queue_set3dColliderEx(byval aQueue as Queue ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Queue_set3dAttenuator(byval aQueue as Queue ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Queue_setInaudibleBehavior(byval aQueue as Queue ptr, byval aMustTick as long, byval aKill as long)
declare sub Queue_setLoopPoint(byval aQueue as Queue ptr, byval aLoopPoint as double)
declare function Queue_getLoopPoint(byval aQueue as Queue ptr) as double
declare sub Queue_setFilter(byval aQueue as Queue ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Queue_stop(byval aQueue as Queue ptr)
declare sub RobotizeFilter_destroy(byval aRobotizeFilter as RobotizeFilter ptr)
declare function RobotizeFilter_getParamCount(byval aRobotizeFilter as RobotizeFilter ptr) as long
declare function RobotizeFilter_getParamName(byval aRobotizeFilter as RobotizeFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function RobotizeFilter_getParamType(byval aRobotizeFilter as RobotizeFilter ptr, byval aParamIndex as ulong) as ulong
declare function RobotizeFilter_getParamMax(byval aRobotizeFilter as RobotizeFilter ptr, byval aParamIndex as ulong) as single
declare function RobotizeFilter_getParamMin(byval aRobotizeFilter as RobotizeFilter ptr, byval aParamIndex as ulong) as single
declare sub RobotizeFilter_setParams(byval aRobotizeFilter as RobotizeFilter ptr, byval aFreq as single, byval aWaveform as long)
declare function RobotizeFilter_create() as RobotizeFilter ptr
declare sub Sfxr_destroy(byval aSfxr as Sfxr ptr)
declare function Sfxr_create() as Sfxr ptr
declare sub Sfxr_resetParams(byval aSfxr as Sfxr ptr)
declare function Sfxr_loadParams(byval aSfxr as Sfxr ptr, byval aFilename as const zstring ptr) as long
declare function Sfxr_loadParamsMem(byval aSfxr as Sfxr ptr, byval aMem as ubyte ptr, byval aLength as ulong) as long
declare function Sfxr_loadParamsMemEx(byval aSfxr as Sfxr ptr, byval aMem as ubyte ptr, byval aLength as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function Sfxr_loadParamsFile(byval aSfxr as Sfxr ptr, byval aFile as SLFile ptr) as long
declare function Sfxr_loadPreset(byval aSfxr as Sfxr ptr, byval aPresetNo as long, byval aRandSeed as long) as long
declare sub Sfxr_setVolume(byval aSfxr as Sfxr ptr, byval aVolume as single)
declare sub Sfxr_setLooping(byval aSfxr as Sfxr ptr, byval aLoop as long)
declare sub Sfxr_set3dMinMaxDistance(byval aSfxr as Sfxr ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Sfxr_set3dAttenuation(byval aSfxr as Sfxr ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Sfxr_set3dDopplerFactor(byval aSfxr as Sfxr ptr, byval aDopplerFactor as single)
declare sub Sfxr_set3dListenerRelative(byval aSfxr as Sfxr ptr, byval aListenerRelative as long)
declare sub Sfxr_set3dDistanceDelay(byval aSfxr as Sfxr ptr, byval aDistanceDelay as long)
declare sub Sfxr_set3dCollider(byval aSfxr as Sfxr ptr, byval aCollider as AudioCollider ptr)
declare sub Sfxr_set3dColliderEx(byval aSfxr as Sfxr ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Sfxr_set3dAttenuator(byval aSfxr as Sfxr ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Sfxr_setInaudibleBehavior(byval aSfxr as Sfxr ptr, byval aMustTick as long, byval aKill as long)
declare sub Sfxr_setLoopPoint(byval aSfxr as Sfxr ptr, byval aLoopPoint as double)
declare function Sfxr_getLoopPoint(byval aSfxr as Sfxr ptr) as double
declare sub Sfxr_setFilter(byval aSfxr as Sfxr ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Sfxr_stop(byval aSfxr as Sfxr ptr)
declare sub Speech_destroy(byval aSpeech as Speech ptr)
declare function Speech_create() as Speech ptr
declare function Speech_setText(byval aSpeech as Speech ptr, byval aText as const zstring ptr) as long
declare function Speech_setParams(byval aSpeech as Speech ptr) as long
declare function Speech_setParamsEx(byval aSpeech as Speech ptr, byval aBaseFrequency as ulong, byval aBaseSpeed as single, byval aBaseDeclination as single, byval aBaseWaveform as long) as long
declare sub Speech_setVolume(byval aSpeech as Speech ptr, byval aVolume as single)
declare sub Speech_setLooping(byval aSpeech as Speech ptr, byval aLoop as long)
declare sub Speech_set3dMinMaxDistance(byval aSpeech as Speech ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Speech_set3dAttenuation(byval aSpeech as Speech ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Speech_set3dDopplerFactor(byval aSpeech as Speech ptr, byval aDopplerFactor as single)
declare sub Speech_set3dListenerRelative(byval aSpeech as Speech ptr, byval aListenerRelative as long)
declare sub Speech_set3dDistanceDelay(byval aSpeech as Speech ptr, byval aDistanceDelay as long)
declare sub Speech_set3dCollider(byval aSpeech as Speech ptr, byval aCollider as AudioCollider ptr)
declare sub Speech_set3dColliderEx(byval aSpeech as Speech ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Speech_set3dAttenuator(byval aSpeech as Speech ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Speech_setInaudibleBehavior(byval aSpeech as Speech ptr, byval aMustTick as long, byval aKill as long)
declare sub Speech_setLoopPoint(byval aSpeech as Speech ptr, byval aLoopPoint as double)
declare function Speech_getLoopPoint(byval aSpeech as Speech ptr) as double
declare sub Speech_setFilter(byval aSpeech as Speech ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Speech_stop(byval aSpeech as Speech ptr)
declare sub TedSid_destroy(byval aTedSid as TedSid ptr)
declare function TedSid_create() as TedSid ptr
declare function TedSid_load(byval aTedSid as TedSid ptr, byval aFilename as const zstring ptr) as long
declare function TedSid_loadToMem(byval aTedSid as TedSid ptr, byval aFilename as const zstring ptr) as long
declare function TedSid_loadMem(byval aTedSid as TedSid ptr, byval aMem as const ubyte ptr, byval aLength as ulong) as long
declare function TedSid_loadMemEx(byval aTedSid as TedSid ptr, byval aMem as const ubyte ptr, byval aLength as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function TedSid_loadFileToMem(byval aTedSid as TedSid ptr, byval aFile as SLFile ptr) as long
declare function TedSid_loadFile(byval aTedSid as TedSid ptr, byval aFile as SLFile ptr) as long
declare sub TedSid_setVolume(byval aTedSid as TedSid ptr, byval aVolume as single)
declare sub TedSid_setLooping(byval aTedSid as TedSid ptr, byval aLoop as long)
declare sub TedSid_set3dMinMaxDistance(byval aTedSid as TedSid ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub TedSid_set3dAttenuation(byval aTedSid as TedSid ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub TedSid_set3dDopplerFactor(byval aTedSid as TedSid ptr, byval aDopplerFactor as single)
declare sub TedSid_set3dListenerRelative(byval aTedSid as TedSid ptr, byval aListenerRelative as long)
declare sub TedSid_set3dDistanceDelay(byval aTedSid as TedSid ptr, byval aDistanceDelay as long)
declare sub TedSid_set3dCollider(byval aTedSid as TedSid ptr, byval aCollider as AudioCollider ptr)
declare sub TedSid_set3dColliderEx(byval aTedSid as TedSid ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub TedSid_set3dAttenuator(byval aTedSid as TedSid ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub TedSid_setInaudibleBehavior(byval aTedSid as TedSid ptr, byval aMustTick as long, byval aKill as long)
declare sub TedSid_setLoopPoint(byval aTedSid as TedSid ptr, byval aLoopPoint as double)
declare function TedSid_getLoopPoint(byval aTedSid as TedSid ptr) as double
declare sub TedSid_setFilter(byval aTedSid as TedSid ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub TedSid_stop(byval aTedSid as TedSid ptr)
declare sub Vic_destroy(byval aVic as Vic ptr)
declare function Vic_create() as Vic ptr
declare sub Vic_setModel(byval aVic as Vic ptr, byval model as long)
declare function Vic_getModel(byval aVic as Vic ptr) as long
declare sub Vic_setRegister(byval aVic as Vic ptr, byval reg as long, byval value as ubyte)
declare function Vic_getRegister(byval aVic as Vic ptr, byval reg as long) as ubyte
declare sub Vic_setVolume(byval aVic as Vic ptr, byval aVolume as single)
declare sub Vic_setLooping(byval aVic as Vic ptr, byval aLoop as long)
declare sub Vic_set3dMinMaxDistance(byval aVic as Vic ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Vic_set3dAttenuation(byval aVic as Vic ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Vic_set3dDopplerFactor(byval aVic as Vic ptr, byval aDopplerFactor as single)
declare sub Vic_set3dListenerRelative(byval aVic as Vic ptr, byval aListenerRelative as long)
declare sub Vic_set3dDistanceDelay(byval aVic as Vic ptr, byval aDistanceDelay as long)
declare sub Vic_set3dCollider(byval aVic as Vic ptr, byval aCollider as AudioCollider ptr)
declare sub Vic_set3dColliderEx(byval aVic as Vic ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Vic_set3dAttenuator(byval aVic as Vic ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Vic_setInaudibleBehavior(byval aVic as Vic ptr, byval aMustTick as long, byval aKill as long)
declare sub Vic_setLoopPoint(byval aVic as Vic ptr, byval aLoopPoint as double)
declare function Vic_getLoopPoint(byval aVic as Vic ptr) as double
declare sub Vic_setFilter(byval aVic as Vic ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Vic_stop(byval aVic as Vic ptr)
declare sub Vizsn_destroy(byval aVizsn as Vizsn ptr)
declare function Vizsn_create() as Vizsn ptr
declare sub Vizsn_setText(byval aVizsn as Vizsn ptr, byval aText as zstring ptr)
declare sub Vizsn_setVolume(byval aVizsn as Vizsn ptr, byval aVolume as single)
declare sub Vizsn_setLooping(byval aVizsn as Vizsn ptr, byval aLoop as long)
declare sub Vizsn_set3dMinMaxDistance(byval aVizsn as Vizsn ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Vizsn_set3dAttenuation(byval aVizsn as Vizsn ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Vizsn_set3dDopplerFactor(byval aVizsn as Vizsn ptr, byval aDopplerFactor as single)
declare sub Vizsn_set3dListenerRelative(byval aVizsn as Vizsn ptr, byval aListenerRelative as long)
declare sub Vizsn_set3dDistanceDelay(byval aVizsn as Vizsn ptr, byval aDistanceDelay as long)
declare sub Vizsn_set3dCollider(byval aVizsn as Vizsn ptr, byval aCollider as AudioCollider ptr)
declare sub Vizsn_set3dColliderEx(byval aVizsn as Vizsn ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Vizsn_set3dAttenuator(byval aVizsn as Vizsn ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Vizsn_setInaudibleBehavior(byval aVizsn as Vizsn ptr, byval aMustTick as long, byval aKill as long)
declare sub Vizsn_setLoopPoint(byval aVizsn as Vizsn ptr, byval aLoopPoint as double)
declare function Vizsn_getLoopPoint(byval aVizsn as Vizsn ptr) as double
declare sub Vizsn_setFilter(byval aVizsn as Vizsn ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Vizsn_stop(byval aVizsn as Vizsn ptr)
declare sub Wav_destroy(byval aWav as Wav ptr)
declare function Wav_create() as Wav ptr
declare function Wav_load(byval aWav as Wav ptr, byval aFilename as const zstring ptr) as long
declare function Wav_loadMem(byval aWav as Wav ptr, byval aMem as const ubyte ptr, byval aLength as ulong) as long
declare function Wav_loadMemEx(byval aWav as Wav ptr, byval aMem as const ubyte ptr, byval aLength as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function Wav_loadFile(byval aWav as Wav ptr, byval aFile as SLFile ptr) as long
declare function Wav_loadRawWave8(byval aWav as Wav ptr, byval aMem as ubyte ptr, byval aLength as ulong) as long
declare function Wav_loadRawWave8Ex(byval aWav as Wav ptr, byval aMem as ubyte ptr, byval aLength as ulong, byval aSamplerate as single, byval aChannels as ulong) as long
declare function Wav_loadRawWave16(byval aWav as Wav ptr, byval aMem as short ptr, byval aLength as ulong) as long
declare function Wav_loadRawWave16Ex(byval aWav as Wav ptr, byval aMem as short ptr, byval aLength as ulong, byval aSamplerate as single, byval aChannels as ulong) as long
declare function Wav_loadRawWave(byval aWav as Wav ptr, byval aMem as single ptr, byval aLength as ulong) as long
declare function Wav_loadRawWaveEx(byval aWav as Wav ptr, byval aMem as single ptr, byval aLength as ulong, byval aSamplerate as single, byval aChannels as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function Wav_getLength(byval aWav as Wav ptr) as double
declare sub Wav_setVolume(byval aWav as Wav ptr, byval aVolume as single)
declare sub Wav_setLooping(byval aWav as Wav ptr, byval aLoop as long)
declare sub Wav_set3dMinMaxDistance(byval aWav as Wav ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub Wav_set3dAttenuation(byval aWav as Wav ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub Wav_set3dDopplerFactor(byval aWav as Wav ptr, byval aDopplerFactor as single)
declare sub Wav_set3dListenerRelative(byval aWav as Wav ptr, byval aListenerRelative as long)
declare sub Wav_set3dDistanceDelay(byval aWav as Wav ptr, byval aDistanceDelay as long)
declare sub Wav_set3dCollider(byval aWav as Wav ptr, byval aCollider as AudioCollider ptr)
declare sub Wav_set3dColliderEx(byval aWav as Wav ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub Wav_set3dAttenuator(byval aWav as Wav ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub Wav_setInaudibleBehavior(byval aWav as Wav ptr, byval aMustTick as long, byval aKill as long)
declare sub Wav_setLoopPoint(byval aWav as Wav ptr, byval aLoopPoint as double)
declare function Wav_getLoopPoint(byval aWav as Wav ptr) as double
declare sub Wav_setFilter(byval aWav as Wav ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub Wav_stop(byval aWav as Wav ptr)
declare sub WaveShaperFilter_destroy(byval aWaveShaperFilter as WaveShaperFilter ptr)
declare function WaveShaperFilter_setParams(byval aWaveShaperFilter as WaveShaperFilter ptr, byval aAmount as single) as long
declare function WaveShaperFilter_create() as WaveShaperFilter ptr
declare function WaveShaperFilter_getParamCount(byval aWaveShaperFilter as WaveShaperFilter ptr) as long
declare function WaveShaperFilter_getParamName(byval aWaveShaperFilter as WaveShaperFilter ptr, byval aParamIndex as ulong) as const zstring ptr
declare function WaveShaperFilter_getParamType(byval aWaveShaperFilter as WaveShaperFilter ptr, byval aParamIndex as ulong) as ulong
declare function WaveShaperFilter_getParamMax(byval aWaveShaperFilter as WaveShaperFilter ptr, byval aParamIndex as ulong) as single
declare function WaveShaperFilter_getParamMin(byval aWaveShaperFilter as WaveShaperFilter ptr, byval aParamIndex as ulong) as single
declare sub WavStream_destroy(byval aWavStream as WavStream ptr)
declare function WavStream_create() as WavStream ptr
declare function WavStream_load(byval aWavStream as WavStream ptr, byval aFilename as const zstring ptr) as long
declare function WavStream_loadMem(byval aWavStream as WavStream ptr, byval aData as const ubyte ptr, byval aDataLen as ulong) as long
declare function WavStream_loadMemEx(byval aWavStream as WavStream ptr, byval aData as const ubyte ptr, byval aDataLen as ulong, byval aCopy as long, byval aTakeOwnership as long) as long
declare function WavStream_loadToMem(byval aWavStream as WavStream ptr, byval aFilename as const zstring ptr) as long
declare function WavStream_loadFile(byval aWavStream as WavStream ptr, byval aFile as SLFile ptr) as long
declare function WavStream_loadFileToMem(byval aWavStream as WavStream ptr, byval aFile as SLFile ptr) as long
declare function WavStream_getLength(byval aWavStream as WavStream ptr) as double
declare sub WavStream_setVolume(byval aWavStream as WavStream ptr, byval aVolume as single)
declare sub WavStream_setLooping(byval aWavStream as WavStream ptr, byval aLoop as long)
declare sub WavStream_set3dMinMaxDistance(byval aWavStream as WavStream ptr, byval aMinDistance as single, byval aMaxDistance as single)
declare sub WavStream_set3dAttenuation(byval aWavStream as WavStream ptr, byval aAttenuationModel as ulong, byval aAttenuationRolloffFactor as single)
declare sub WavStream_set3dDopplerFactor(byval aWavStream as WavStream ptr, byval aDopplerFactor as single)
declare sub WavStream_set3dListenerRelative(byval aWavStream as WavStream ptr, byval aListenerRelative as long)
declare sub WavStream_set3dDistanceDelay(byval aWavStream as WavStream ptr, byval aDistanceDelay as long)
declare sub WavStream_set3dCollider(byval aWavStream as WavStream ptr, byval aCollider as AudioCollider ptr)
declare sub WavStream_set3dColliderEx(byval aWavStream as WavStream ptr, byval aCollider as AudioCollider ptr, byval aUserData as long)
declare sub WavStream_set3dAttenuator(byval aWavStream as WavStream ptr, byval aAttenuator as AudioAttenuator ptr)
declare sub WavStream_setInaudibleBehavior(byval aWavStream as WavStream ptr, byval aMustTick as long, byval aKill as long)
declare sub WavStream_setLoopPoint(byval aWavStream as WavStream ptr, byval aLoopPoint as double)
declare function WavStream_getLoopPoint(byval aWavStream as WavStream ptr) as double
declare sub WavStream_setFilter(byval aWavStream as WavStream ptr, byval aFilterId as ulong, byval aFilter as Filter ptr)
declare sub WavStream_stop(byval aWavStream as WavStream ptr)

end extern
