''
''
'' portaudio -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __portaudio_bi__
#define __portaudio_bi__

#inclib "portaudio"

type PaError as integer

enum PaErrorNum
	paNoError = 0
	paHostError = -10000
	paInvalidChannelCount
	paInvalidSampleRate
	paInvalidDeviceId
	paInvalidFlag
	paSampleFormatNotSupported
	paBadIODeviceCombination
	paInsufficientMemory
	paBufferTooBig
	paBufferTooSmall
	paNullCallback
	paBadStreamPtr
	paTimedOut
	paInternalError
	paDeviceUnavailable
end enum


declare function Pa_Initialize cdecl alias "Pa_Initialize" () as PaError
declare function Pa_Terminate cdecl alias "Pa_Terminate" () as PaError
declare function Pa_GetHostError cdecl alias "Pa_GetHostError" () as integer
declare function Pa_GetErrorText cdecl alias "Pa_GetErrorText" (byval errnum as PaError) as zstring ptr

type PaSampleFormat as uinteger
type PaDeviceID as integer

#define paNoDevice -1

declare function Pa_CountDevices cdecl alias "Pa_CountDevices" () as integer

type PaDeviceInfo
	structVersion as integer
	name as zstring ptr
	maxInputChannels as integer
	maxOutputChannels as integer
	numSampleRates as integer
	sampleRates as double ptr
	nativeSampleFormats as PaSampleFormat
end type

declare function Pa_GetDefaultInputDeviceID cdecl alias "Pa_GetDefaultInputDeviceID" () as PaDeviceID
declare function Pa_GetDefaultOutputDeviceID cdecl alias "Pa_GetDefaultOutputDeviceID" () as PaDeviceID
declare function Pa_GetDeviceInfo cdecl alias "Pa_GetDeviceInfo" (byval device as PaDeviceID) as PaDeviceInfo ptr

type PaTimestamp as double
type PortAudioCallback as function( byval inputbuffer as any ptr, outputBuffer as any ptr, framesPerBuffer as uinteger,  outTime as double, userData as any ptr )

#define paNoFlag (0)
#define paClipOff (1 shl 0)
#define paDitherOff (1 shl 1)
#define paPlatformSpecificFlags (&h00010000)

type PaStreamFlags as uinteger
type PortAudioStream as any

declare function Pa_OpenStream cdecl alias "Pa_OpenStream" (byval stream as PortAudioStream ptr ptr, byval inputDevice as PaDeviceID, byval numInputChannels as integer, byval inputSampleFormat as PaSampleFormat, byval inputDriverInfo as any ptr, byval outputDevice as PaDeviceID, byval numOutputChannels as integer, byval outputSampleFormat as PaSampleFormat, byval outputDriverInfo as any ptr, byval sampleRate as double, byval framesPerBuffer as uinteger, byval numberOfBuffers as uinteger, byval streamFlags as PaStreamFlags, byval callback as PortAudioCallback ptr, byval userData as any ptr) as PaError
declare function Pa_OpenDefaultStream cdecl alias "Pa_OpenDefaultStream" (byval stream as PortAudioStream ptr ptr, byval numInputChannels as integer, byval numOutputChannels as integer, byval sampleFormat as PaSampleFormat, byval sampleRate as double, byval framesPerBuffer as uinteger, byval numberOfBuffers as uinteger, byval callback as PortAudioCallback ptr, byval userData as any ptr) as PaError
declare function Pa_CloseStream cdecl alias "Pa_CloseStream" (byval as PortAudioStream ptr) as PaError
declare function Pa_StartStream cdecl alias "Pa_StartStream" (byval stream as PortAudioStream ptr) as PaError
declare function Pa_StopStream cdecl alias "Pa_StopStream" (byval stream as PortAudioStream ptr) as PaError
declare function Pa_AbortStream cdecl alias "Pa_AbortStream" (byval stream as PortAudioStream ptr) as PaError
declare function Pa_StreamActive cdecl alias "Pa_StreamActive" (byval stream as PortAudioStream ptr) as PaError
declare function Pa_StreamTime cdecl alias "Pa_StreamTime" (byval stream as PortAudioStream ptr) as PaTimestamp
declare function Pa_GetCPULoad cdecl alias "Pa_GetCPULoad" (byval stream as PortAudioStream ptr) as double
declare function Pa_GetMinNumBuffers cdecl alias "Pa_GetMinNumBuffers" (byval framesPerBuffer as integer, byval sampleRate as double) as integer
declare sub Pa_Sleep cdecl alias "Pa_Sleep" (byval msec as integer)
declare function Pa_GetSampleSize cdecl alias "Pa_GetSampleSize" (byval format as PaSampleFormat) as PaError

#endif
