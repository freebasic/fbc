'' FreeBASIC binding for pa_stable_v19_20140130
''
'' based on the C header files:
''   $Id: portaudio.h 1859 2012-09-01 00:10:13Z philburk $
''   PortAudio Portable Real-Time Audio Library
''   PortAudio API Header File
''   Latest version available at: http://www.portaudio.com/
''
''   Copyright (c) 1999-2002 Ross Bencina and Phil Burk
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files
''   (the "Software"), to deal in the Software without restriction,
''   including without limitation the rights to use, copy, modify, merge,
''   publish, distribute, sublicense, and/or sell copies of the Software,
''   and to permit persons to whom the Software is furnished to do so,
''   subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be
''   included in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
''   ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
''   CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
''   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   The text above constitutes the entire PortAudio license; however, 
''   the PortAudio community also makes the following non-binding requests:
''
''   Any person wishing to distribute modifications to the Software is
''   requested to send the modifications to the original developer so that
''   they can be incorporated into the canonical version. It is also 
''   requested that these non-binding requests be included along with the 
''   license above.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "portaudio"

#include once "crt/long.bi"

extern "C"

#define PORTAUDIO_H
declare function Pa_GetVersion() as long
declare function Pa_GetVersionText() as const zstring ptr
type PaError as long

type PaErrorCode as long
enum
	paNoError = 0
	paNotInitialized = -10000
	paUnanticipatedHostError
	paInvalidChannelCount
	paInvalidSampleRate
	paInvalidDevice
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
	paIncompatibleHostApiSpecificStreamInfo
	paStreamIsStopped
	paStreamIsNotStopped
	paInputOverflowed
	paOutputUnderflowed
	paHostApiNotFound
	paInvalidHostApi
	paCanNotReadFromACallbackStream
	paCanNotWriteToACallbackStream
	paCanNotReadFromAnOutputOnlyStream
	paCanNotWriteToAnInputOnlyStream
	paIncompatibleStreamHostApi
	paBadBufferPtr
end enum

declare function Pa_GetErrorText(byval errorCode as PaError) as const zstring ptr
declare function Pa_Initialize() as PaError
declare function Pa_Terminate() as PaError
type PaDeviceIndex as long
const paNoDevice = cast(PaDeviceIndex, -1)
const paUseHostApiSpecificDeviceSpecification = cast(PaDeviceIndex, -2)
type PaHostApiIndex as long
declare function Pa_GetHostApiCount() as PaHostApiIndex
declare function Pa_GetDefaultHostApi() as PaHostApiIndex

type PaHostApiTypeId as long
enum
	paInDevelopment = 0
	paDirectSound = 1
	paMME = 2
	paASIO = 3
	paSoundManager = 4
	paCoreAudio = 5
	paOSS = 7
	paALSA = 8
	paAL = 9
	paBeOS = 10
	paWDMKS = 11
	paJACK = 12
	paWASAPI = 13
	paAudioScienceHPI = 14
end enum

type PaHostApiInfo
	structVersion as long
	as PaHostApiTypeId type
	name as const zstring ptr
	deviceCount as long
	defaultInputDevice as PaDeviceIndex
	defaultOutputDevice as PaDeviceIndex
end type

declare function Pa_GetHostApiInfo(byval hostApi as PaHostApiIndex) as const PaHostApiInfo ptr
declare function Pa_HostApiTypeIdToHostApiIndex(byval type as PaHostApiTypeId) as PaHostApiIndex
declare function Pa_HostApiDeviceIndexToDeviceIndex(byval hostApi as PaHostApiIndex, byval hostApiDeviceIndex as long) as PaDeviceIndex

type PaHostErrorInfo
	hostApiType as PaHostApiTypeId
	errorCode as clong
	errorText as const zstring ptr
end type

declare function Pa_GetLastHostErrorInfo() as const PaHostErrorInfo ptr
declare function Pa_GetDeviceCount() as PaDeviceIndex
declare function Pa_GetDefaultInputDevice() as PaDeviceIndex
declare function Pa_GetDefaultOutputDevice() as PaDeviceIndex
type PaTime as double
type PaSampleFormat as culong

const paFloat32 = cast(PaSampleFormat, &h00000001)
const paInt32 = cast(PaSampleFormat, &h00000002)
const paInt24 = cast(PaSampleFormat, &h00000004)
const paInt16 = cast(PaSampleFormat, &h00000008)
const paInt8 = cast(PaSampleFormat, &h00000010)
const paUInt8 = cast(PaSampleFormat, &h00000020)
const paCustomFormat = cast(PaSampleFormat, &h00010000)
const paNonInterleaved = cast(PaSampleFormat, &h80000000)

type PaDeviceInfo
	structVersion as long
	name as const zstring ptr
	hostApi as PaHostApiIndex
	maxInputChannels as long
	maxOutputChannels as long
	defaultLowInputLatency as PaTime
	defaultLowOutputLatency as PaTime
	defaultHighInputLatency as PaTime
	defaultHighOutputLatency as PaTime
	defaultSampleRate as double
end type

declare function Pa_GetDeviceInfo(byval device as PaDeviceIndex) as const PaDeviceInfo ptr

type PaStreamParameters
	device as PaDeviceIndex
	channelCount as long
	sampleFormat as PaSampleFormat
	suggestedLatency as PaTime
	hostApiSpecificStreamInfo as any ptr
end type

const paFormatIsSupported = 0
declare function Pa_IsFormatSupported(byval inputParameters as const PaStreamParameters ptr, byval outputParameters as const PaStreamParameters ptr, byval sampleRate as double) as PaError
type PaStream as any
const paFramesPerBufferUnspecified = 0
type PaStreamFlags as culong
const paNoFlag = cast(PaStreamFlags, 0)
const paClipOff = cast(PaStreamFlags, &h00000001)
const paDitherOff = cast(PaStreamFlags, &h00000002)
const paNeverDropInput = cast(PaStreamFlags, &h00000004)
const paPrimeOutputBuffersUsingStreamCallback = cast(PaStreamFlags, &h00000008)
const paPlatformSpecificFlags = cast(PaStreamFlags, &hFFFF0000)

type PaStreamCallbackTimeInfo
	inputBufferAdcTime as PaTime
	currentTime as PaTime
	outputBufferDacTime as PaTime
end type

type PaStreamCallbackFlags as culong
const paInputUnderflow = cast(PaStreamCallbackFlags, &h00000001)
const paInputOverflow = cast(PaStreamCallbackFlags, &h00000002)
const paOutputUnderflow = cast(PaStreamCallbackFlags, &h00000004)
const paOutputOverflow = cast(PaStreamCallbackFlags, &h00000008)
const paPrimingOutput = cast(PaStreamCallbackFlags, &h00000010)

type PaStreamCallbackResult as long
enum
	paContinue = 0
	paComplete = 1
	paAbort = 2
end enum

declare function Pa_OpenStream(byval stream as PaStream ptr ptr, byval inputParameters as const PaStreamParameters ptr, byval outputParameters as const PaStreamParameters ptr, byval sampleRate as double, byval framesPerBuffer as culong, byval streamFlags as PaStreamFlags, byval streamCallback as function(byval input as const any ptr, byval output as any ptr, byval frameCount as culong, byval timeInfo as const PaStreamCallbackTimeInfo ptr, byval statusFlags as PaStreamCallbackFlags, byval userData as any ptr) as long, byval userData as any ptr) as PaError
declare function Pa_OpenDefaultStream(byval stream as PaStream ptr ptr, byval numInputChannels as long, byval numOutputChannels as long, byval sampleFormat as PaSampleFormat, byval sampleRate as double, byval framesPerBuffer as culong, byval streamCallback as function(byval input as const any ptr, byval output as any ptr, byval frameCount as culong, byval timeInfo as const PaStreamCallbackTimeInfo ptr, byval statusFlags as PaStreamCallbackFlags, byval userData as any ptr) as long, byval userData as any ptr) as PaError
declare function Pa_CloseStream(byval stream as PaStream ptr) as PaError
declare function Pa_SetStreamFinishedCallback(byval stream as PaStream ptr, byval streamFinishedCallback as sub(byval userData as any ptr)) as PaError
declare function Pa_StartStream(byval stream as PaStream ptr) as PaError
declare function Pa_StopStream(byval stream as PaStream ptr) as PaError
declare function Pa_AbortStream(byval stream as PaStream ptr) as PaError
declare function Pa_IsStreamStopped(byval stream as PaStream ptr) as PaError
declare function Pa_IsStreamActive(byval stream as PaStream ptr) as PaError

type PaStreamInfo
	structVersion as long
	inputLatency as PaTime
	outputLatency as PaTime
	sampleRate as double
end type

declare function Pa_GetStreamInfo(byval stream as PaStream ptr) as const PaStreamInfo ptr
declare function Pa_GetStreamTime(byval stream as PaStream ptr) as PaTime
declare function Pa_GetStreamCpuLoad(byval stream as PaStream ptr) as double
declare function Pa_ReadStream(byval stream as PaStream ptr, byval buffer as any ptr, byval frames as culong) as PaError
declare function Pa_WriteStream(byval stream as PaStream ptr, byval buffer as const any ptr, byval frames as culong) as PaError
declare function Pa_GetStreamReadAvailable(byval stream as PaStream ptr) as clong
declare function Pa_GetStreamWriteAvailable(byval stream as PaStream ptr) as clong
declare function Pa_GetSampleSize(byval format as PaSampleFormat) as PaError
declare sub Pa_Sleep(byval msec as clong)

end extern
