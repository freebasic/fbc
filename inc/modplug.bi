'' FreeBASIC binding for libmodplug-0.8.8.5
''
'' based on the C header files:
''   This source code is public domain.
''
''   Authors: Kenton Varda <temporal@gauge3d.org> (C interface wrapper)
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "modplug"

#include once "crt/long.bi"

extern "C"

#define MODPLUG_H__INCLUDED
type ModPlugFile as _ModPlugFile

type _ModPlugNote
	Note as ubyte
	Instrument as ubyte
	VolumeEffect as ubyte
	Effect as ubyte
	Volume as ubyte
	Parameter as ubyte
end type

type ModPlugNote as _ModPlugNote
type ModPlugMixerProc as sub(byval as long ptr, byval as culong, byval as culong)
declare function ModPlug_Load(byval data as const any ptr, byval size as long) as ModPlugFile ptr
declare sub ModPlug_Unload(byval file as ModPlugFile ptr)
declare function ModPlug_Read(byval file as ModPlugFile ptr, byval buffer as any ptr, byval size as long) as long
declare function ModPlug_GetName(byval file as ModPlugFile ptr) as const zstring ptr
declare function ModPlug_GetLength(byval file as ModPlugFile ptr) as long
declare sub ModPlug_Seek(byval file as ModPlugFile ptr, byval millisecond as long)

type _ModPlug_Flags as long
enum
	MODPLUG_ENABLE_OVERSAMPLING = 1 shl 0
	MODPLUG_ENABLE_NOISE_REDUCTION = 1 shl 1
	MODPLUG_ENABLE_REVERB = 1 shl 2
	MODPLUG_ENABLE_MEGABASS = 1 shl 3
	MODPLUG_ENABLE_SURROUND = 1 shl 4
end enum

type _ModPlug_ResamplingMode as long
enum
	MODPLUG_RESAMPLE_NEAREST = 0
	MODPLUG_RESAMPLE_LINEAR = 1
	MODPLUG_RESAMPLE_SPLINE = 2
	MODPLUG_RESAMPLE_FIR = 3
end enum

type _ModPlug_Settings
	mFlags as long
	mChannels as long
	mBits as long
	mFrequency as long
	mResamplingMode as long
	mStereoSeparation as long
	mMaxMixChannels as long
	mReverbDepth as long
	mReverbDelay as long
	mBassAmount as long
	mBassRange as long
	mSurroundDepth as long
	mSurroundDelay as long
	mLoopCount as long
end type

type ModPlug_Settings as _ModPlug_Settings
declare sub ModPlug_GetSettings(byval settings as ModPlug_Settings ptr)
declare sub ModPlug_SetSettings(byval settings as const ModPlug_Settings ptr)
declare function ModPlug_GetMasterVolume(byval file as ModPlugFile ptr) as ulong
declare sub ModPlug_SetMasterVolume(byval file as ModPlugFile ptr, byval cvol as ulong)
declare function ModPlug_GetCurrentSpeed(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetCurrentTempo(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetCurrentOrder(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetCurrentPattern(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetCurrentRow(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetPlayingChannels(byval file as ModPlugFile ptr) as long
declare sub ModPlug_SeekOrder(byval file as ModPlugFile ptr, byval order as long)
declare function ModPlug_GetModuleType(byval file as ModPlugFile ptr) as long
declare function ModPlug_GetMessage(byval file as ModPlugFile ptr) as zstring ptr
declare function ModPlug_ExportS3M(byval file as ModPlugFile ptr, byval filepath as const zstring ptr) as byte
declare function ModPlug_ExportXM(byval file as ModPlugFile ptr, byval filepath as const zstring ptr) as byte
declare function ModPlug_ExportMOD(byval file as ModPlugFile ptr, byval filepath as const zstring ptr) as byte
declare function ModPlug_ExportIT(byval file as ModPlugFile ptr, byval filepath as const zstring ptr) as byte
declare function ModPlug_NumInstruments(byval file as ModPlugFile ptr) as ulong
declare function ModPlug_NumSamples(byval file as ModPlugFile ptr) as ulong
declare function ModPlug_NumPatterns(byval file as ModPlugFile ptr) as ulong
declare function ModPlug_NumChannels(byval file as ModPlugFile ptr) as ulong
declare function ModPlug_SampleName(byval file as ModPlugFile ptr, byval qual as ulong, byval buff as zstring ptr) as ulong
declare function ModPlug_InstrumentName(byval file as ModPlugFile ptr, byval qual as ulong, byval buff as zstring ptr) as ulong
declare function ModPlug_GetPattern(byval file as ModPlugFile ptr, byval pattern as long, byval numrows as ulong ptr) as ModPlugNote ptr
declare sub ModPlug_InitMixerCallback(byval file as ModPlugFile ptr, byval proc as ModPlugMixerProc)
declare sub ModPlug_UnloadMixerCallback(byval file as ModPlugFile ptr)

end extern
