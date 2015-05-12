/'
 * This source code is public domain.
 *
 * Authors: Kenton Varda <temporal@gauge3d.org> (C interface wrapper)
 '/

#ifndef MODPLUG_H__INCLUDED
#define MODPLUG_H__INCLUDED

#inclib "modplug"

extern "C" 

type as _ModPlugFile ModPlugFile

type ModPlugNote
	as ubyte Note
	as ubyte Instrument
	as ubyte VolumeEffect
	as ubyte Effect
	as ubyte Volume
	as ubyte Parameter
end type

type as sub(byval as integer ptr, byval as ulong, byval as ulong) ModPlugMixerProc

/' Load a mod file.  [data] should point to a block of memory containing the complete
 * file, and [size] should be the size of that block.
 * Return the loaded mod file on success, or NULL on failure. '/
declare function ModPlug_Load(byval data as const any ptr, byval size as integer) as ModPlugFile ptr
/' Unload a mod file. '/
declare sub ModPlug_Unload(byval file as ModPlugFile ptr)

/' Read sample data into the buffer.  Returns the number of bytes read.  If the end
 * of the mod has been reached, zero is returned. '/
declare function  ModPlug_Read(byval file as ModPlugFile ptr, byval buffer as any ptr, byval size as integer) as integer

/' Get the name of the mod.  The returned buffer is stored within the ModPlugFile
 * structure and will remain valid until you unload the file. '/
declare function ModPlug_GetName(byval file as ModPlugFile ptr) as const byte ptr

/' Get the length of the mod, in milliseconds.  Note that this result is not always
 * accurate, especially in the case of mods with loops. '/
declare function ModPlug_GetLength(byval file as ModPlugFile ptr) as integer

/' Seek to a particular position in the song.  Note that seeking and MODs don't mix very
 * well.  Some mods will be missing instruments for a short time after a seek, as ModPlug
 * does not scan the sequence backwards to find out which instruments were supposed to be
 * playing at that time.  (Doing so would be difficult and not very reliable.)  Also,
 * note that seeking is not very exact in some mods -- especially those for which
 * ModPlug_GetLength() does not report the full length. '/
declare sub ModPlug_Seek(byval file as ModPlugFile ptr, byval millisecond as integer)

enum _ModPlug_Flags
	MODPLUG_ENABLE_OVERSAMPLING     = 1 shl 0  /' Enable oversampling (*highly* recommended) '/
	MODPLUG_ENABLE_NOISE_REDUCTION  = 1 shl 1  /' Enable noise reduction '/
	MODPLUG_ENABLE_REVERB           = 1 shl 2  /' Enable reverb '/
	MODPLUG_ENABLE_MEGABASS         = 1 shl 3  /' Enable megabass '/
	MODPLUG_ENABLE_SURROUND         = 1 shl 4  /' Enable surround sound. '/
end enum

enum _ModPlug_ResamplingMode
	MODPLUG_RESAMPLE_NEAREST = 0  /' No interpolation (very fast, extremely bad sound quality) '/
	MODPLUG_RESAMPLE_LINEAR  = 1  /' Linear interpolation (fast, good quality) '/
	MODPLUG_RESAMPLE_SPLINE  = 2  /' Cubic spline interpolation (high quality) '/
	MODPLUG_RESAMPLE_FIR     = 3  /' 8-tap fir filter (extremely high quality) '/
end enum

type ModPlug_Settings
	as integer mFlags  /' One or more of the MODPLUG_ENABLE_* flags above, bitwise-OR'ed '/
	
	/' Note that ModPlug always decodes sound at 44100kHz, 32 bit, stereo and then
	 * down-mixes to the settings you choose. '/
	as integer mChannels       /' Number of channels - 1 for mono or 2 for stereo '/
	as integer mBits           /' Bits per sample - 8, 16, or 32 '/
	as integer mFrequency      /' Sampling rate - 11025, 22050, or 44100 '/
	as integer mResamplingMode /' One of MODPLUG_RESAMPLE_*, above '/

	as integer mStereoSeparation /' Stereo separation, 1 - 256 '/
	as integer mMaxMixChannels /' Maximum number of mixing channels (polyphony), 32 - 256 '/
	
	as integer mReverbDepth    /' Reverb level 0(quiet)-100(loud)      '/
	as integer mReverbDelay    /' Reverb delay in ms, usually 40-200ms '/
	as integer mBassAmount     /' XBass level 0(quiet)-100(loud)       '/
	as integer mBassRange      /' XBass cutoff in Hz 10-100            '/
	as integer mSurroundDepth  /' Surround level 0(quiet)-100(heavy)   '/
	as integer mSurroundDelay  /' Surround delay in ms, usually 5-40ms '/
	as integer mLoopCount      /' Number of times to loop.  Zero prevents looping.
	                              -1 loops forever. '/
end type

/' Get and set the mod decoder settings.  All options, except for channels, bits-per-sample,
 * sampling rate, and loop count, will take effect immediately.  Those options which don't
 * take effect immediately will take effect the next time you load a mod. '/
declare sub ModPlug_GetSettings(byval settings as ModPlug_Settings ptr)
declare sub ModPlug_SetSettings(byval settings as const ModPlug_Settings ptr)

/' New ModPlug API Functions '/
/' NOTE: Master Volume (1-512) '/
declare function ModPlug_GetMasterVolume(byval file as ModPlugFile ptr) as uinteger 
declare sub ModPlug_SetMasterVolume(byval file as ModPlugFile ptr,byval cvol as uinteger) 

declare function ModPlug_GetCurrentSpeed(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetCurrentTempo(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetCurrentOrder(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetCurrentPattern(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetCurrentRow(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetPlayingChannels(byval file as ModPlugFile ptr) as integer

declare sub ModPlug_SeekOrder(byval file as ModPlugFile ptr,byval order as integer)
declare function ModPlug_GetModuleType(byval file as ModPlugFile ptr) as integer
declare function ModPlug_GetMessage(byval file as ModPlugFile ptr) as byte ptr


#ifndef MODPLUG_NO_FILESAVE
/'
 * EXPERIMENTAL Export Functions
 '/
/'Export to a Scream Tracker 3 S3M module. EXPERIMENTAL (only works on Little-Endian platforms)'/
declare function ModPlug_ExportS3M(byval file as ModPlugFile ptr, byval filepath as const byte ptr) as byte

/'Export to a Extended Module (XM). EXPERIMENTAL (only works on Little-Endian platforms)'/
declare function ModPlug_ExportXM(byval file as ModPlugFile ptr, byval filepath as const byte ptr) as byte

/'Export to a Amiga MOD file. EXPERIMENTAL.'/
declare function ModPlug_ExportMOD(byval file as ModPlugFile ptr, byval filepath as const byte ptr) as byte

/'Export to a Impulse Tracker IT file. Should work OK in Little-Endian & Big-Endian platforms :-) '/
declare function ModPlug_ExportIT(byval file as ModPlugFile ptr, byval filepath as const byte ptr) as byte
#endif '' MODPLUG_NO_FILESAVE

declare function ModPlug_NumInstruments(byval file as ModPlugFile ptr) as uinteger
declare function ModPlug_NumSamples(byval file as ModPlugFile ptr) as uinteger
declare function ModPlug_NumPatterns(byval file as ModPlugFile ptr) as uinteger
declare function ModPlug_NumChannels(byval file as ModPlugFile ptr) as uinteger
declare function ModPlug_SampleName(byval file as ModPlugFile ptr, byval qual as uinteger, byval buff as byte ptr) as uinteger
declare function ModPlug_InstrumentName(byval file as ModPlugFile ptr, byval qual as uinteger, byval buff as byte ptr) as uinteger

/'
 * Retrieve pattern note-data
 '/
declare function ModPlug_GetPattern(byval file as ModPlugFile ptr, byval pattern as integer, byval numrows as uinteger ptr) as ModPlugNote ptr

/'
 * =================
 * Mixer callback
 * =================
 *
 * Use this callback if you want to 'modify' the mixed data of LibModPlug.
 * 
 * void proc(int* buffer,unsigned long channels,unsigned long nsamples) ;
 *
 * 'buffer': A buffer of mixed samples
 * 'channels': N. of channels in the buffer
 * 'nsamples': N. of samples in the buffeer (without taking care of n.channels)
 *
 * (Samples are signed 32-bit integers)
 '/
declare sub ModPlug_InitMixerCallback(byval file as ModPlugFile ptr,byval proc as ModPlugMixerProc) 
declare sub ModPlug_UnloadMixerCallback(byval file as ModPlugFile ptr) 

end extern /' extern "C" '/

#endif
