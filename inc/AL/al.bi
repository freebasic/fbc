'' FreeBASIC binding for openal-soft-1.16.0
''
'' based on the C header files:
''
''   OpenAL cross platform audio library
''   Copyright (C) 2008 by authors.
''   This library is free software; you can redistribute it and/or
''    modify it under the terms of the GNU Library General Public
''    License as published by the Free Software Foundation; either
''    version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''    but WITHOUT ANY WARRANTY; without even the implied warranty of
''    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''    Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''    License along with this library; if not, write to the
''    Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
''    Boston, MA  02111-1301, USA.
''   Or go to http://www.gnu.org/copyleft/lgpl.html
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_WIN32__
	#inclib "OpenAL32"
#else
	#inclib "openal"
#endif

extern "C"

#define AL_AL_H
#define OPENAL
const AL_INVALID = -1
#define AL_VERSION_1_0
#define AL_VERSION_1_1

type ALboolean as byte
type ALchar as zstring
type ALbyte as byte
type ALubyte as ubyte
type ALshort as short
type ALushort as ushort
type ALint as long
type ALuint as ulong
type ALsizei as long
type ALenum as long
type ALfloat as single
type ALdouble as double
type ALvoid as any

const AL_NONE = 0
const AL_FALSE = 0
const AL_TRUE = 1
const AL_SOURCE_RELATIVE = &h202
const AL_CONE_INNER_ANGLE = &h1001
const AL_CONE_OUTER_ANGLE = &h1002
const AL_PITCH = &h1003
const AL_POSITION = &h1004
const AL_DIRECTION = &h1005
const AL_VELOCITY = &h1006
const AL_LOOPING = &h1007
const AL_BUFFER = &h1009
const AL_GAIN = &h100A
const AL_MIN_GAIN = &h100D
const AL_MAX_GAIN = &h100E
const AL_ORIENTATION = &h100F
const AL_SOURCE_STATE = &h1010
const AL_INITIAL = &h1011
const AL_PLAYING = &h1012
const AL_PAUSED = &h1013
const AL_STOPPED = &h1014
const AL_BUFFERS_QUEUED = &h1015
const AL_BUFFERS_PROCESSED = &h1016
const AL_REFERENCE_DISTANCE = &h1020
const AL_ROLLOFF_FACTOR = &h1021
const AL_CONE_OUTER_GAIN = &h1022
const AL_MAX_DISTANCE = &h1023
const AL_SEC_OFFSET = &h1024
const AL_SAMPLE_OFFSET = &h1025
const AL_BYTE_OFFSET = &h1026
const AL_SOURCE_TYPE = &h1027
const AL_STATIC = &h1028
const AL_STREAMING = &h1029
const AL_UNDETERMINED = &h1030
const AL_FORMAT_MONO8 = &h1100
const AL_FORMAT_MONO16 = &h1101
const AL_FORMAT_STEREO8 = &h1102
const AL_FORMAT_STEREO16 = &h1103
const AL_FREQUENCY = &h2001
const AL_BITS = &h2002
const AL_CHANNELS = &h2003
const AL_SIZE = &h2004
const AL_UNUSED = &h2010
const AL_PENDING = &h2011
const AL_PROCESSED = &h2012
const AL_NO_ERROR = 0
const AL_INVALID_NAME = &hA001
const AL_INVALID_ENUM = &hA002
const AL_ILLEGAL_ENUM = AL_INVALID_ENUM
const AL_INVALID_VALUE = &hA003
const AL_INVALID_OPERATION = &hA004
const AL_ILLEGAL_COMMAND = AL_INVALID_OPERATION
const AL_OUT_OF_MEMORY = &hA005
const AL_VENDOR = &hB001
const AL_VERSION = &hB002
const AL_RENDERER = &hB003
const AL_EXTENSIONS = &hB004
const AL_DOPPLER_FACTOR = &hC000
declare sub alDopplerFactor(byval value as ALfloat)
const AL_DOPPLER_VELOCITY = &hC001
declare sub alDopplerVelocity(byval value as ALfloat)
const AL_SPEED_OF_SOUND = &hC003
declare sub alSpeedOfSound(byval value as ALfloat)
const AL_DISTANCE_MODEL = &hD000
declare sub alDistanceModel(byval distanceModel as ALenum)
const AL_INVERSE_DISTANCE = &hD001
const AL_INVERSE_DISTANCE_CLAMPED = &hD002
const AL_LINEAR_DISTANCE = &hD003
const AL_LINEAR_DISTANCE_CLAMPED = &hD004
const AL_EXPONENT_DISTANCE = &hD005
const AL_EXPONENT_DISTANCE_CLAMPED = &hD006

declare sub alEnable(byval capability as ALenum)
declare sub alDisable(byval capability as ALenum)
declare function alIsEnabled(byval capability as ALenum) as ALboolean
declare function alGetString(byval param as ALenum) as const ALchar ptr
declare sub alGetBooleanv(byval param as ALenum, byval values as ALboolean ptr)
declare sub alGetIntegerv(byval param as ALenum, byval values as ALint ptr)
declare sub alGetFloatv(byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetDoublev(byval param as ALenum, byval values as ALdouble ptr)
declare function alGetBoolean(byval param as ALenum) as ALboolean
declare function alGetInteger(byval param as ALenum) as ALint
declare function alGetFloat(byval param as ALenum) as ALfloat
declare function alGetDouble(byval param as ALenum) as ALdouble
declare function alGetError() as ALenum
declare function alIsExtensionPresent(byval extname as const ALchar ptr) as ALboolean
declare function alGetProcAddress(byval fname as const ALchar ptr) as any ptr
declare function alGetEnumValue(byval ename as const ALchar ptr) as ALenum
declare sub alListenerf(byval param as ALenum, byval value as ALfloat)
declare sub alListener3f(byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alListenerfv(byval param as ALenum, byval values as const ALfloat ptr)
declare sub alListeneri(byval param as ALenum, byval value as ALint)
declare sub alListener3i(byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alListeneriv(byval param as ALenum, byval values as const ALint ptr)
declare sub alGetListenerf(byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetListener3f(byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetListenerfv(byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetListeneri(byval param as ALenum, byval value as ALint ptr)
declare sub alGetListener3i(byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetListeneriv(byval param as ALenum, byval values as ALint ptr)
declare sub alGenSources(byval n as ALsizei, byval sources as ALuint ptr)
declare sub alDeleteSources(byval n as ALsizei, byval sources as const ALuint ptr)
declare function alIsSource(byval source as ALuint) as ALboolean
declare sub alSourcef(byval source as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alSource3f(byval source as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alSourcefv(byval source as ALuint, byval param as ALenum, byval values as const ALfloat ptr)
declare sub alSourcei(byval source as ALuint, byval param as ALenum, byval value as ALint)
declare sub alSource3i(byval source as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alSourceiv(byval source as ALuint, byval param as ALenum, byval values as const ALint ptr)
declare sub alGetSourcef(byval source as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetSource3f(byval source as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetSourcefv(byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetSourcei(byval source as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetSource3i(byval source as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetSourceiv(byval source as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alSourcePlayv(byval n as ALsizei, byval sources as const ALuint ptr)
declare sub alSourceStopv(byval n as ALsizei, byval sources as const ALuint ptr)
declare sub alSourceRewindv(byval n as ALsizei, byval sources as const ALuint ptr)
declare sub alSourcePausev(byval n as ALsizei, byval sources as const ALuint ptr)
declare sub alSourcePlay(byval source as ALuint)
declare sub alSourceStop(byval source as ALuint)
declare sub alSourceRewind(byval source as ALuint)
declare sub alSourcePause(byval source as ALuint)
declare sub alSourceQueueBuffers(byval source as ALuint, byval nb as ALsizei, byval buffers as const ALuint ptr)
declare sub alSourceUnqueueBuffers(byval source as ALuint, byval nb as ALsizei, byval buffers as ALuint ptr)
declare sub alGenBuffers(byval n as ALsizei, byval buffers as ALuint ptr)
declare sub alDeleteBuffers(byval n as ALsizei, byval buffers as const ALuint ptr)
declare function alIsBuffer(byval buffer as ALuint) as ALboolean
declare sub alBufferData(byval buffer as ALuint, byval format as ALenum, byval data as const any ptr, byval size as ALsizei, byval freq as ALsizei)
declare sub alBufferf(byval buffer as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alBuffer3f(byval buffer as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alBufferfv(byval buffer as ALuint, byval param as ALenum, byval values as const ALfloat ptr)
declare sub alBufferi(byval buffer as ALuint, byval param as ALenum, byval value as ALint)
declare sub alBuffer3i(byval buffer as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alBufferiv(byval buffer as ALuint, byval param as ALenum, byval values as const ALint ptr)
declare sub alGetBufferf(byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetBuffer3f(byval buffer as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetBufferfv(byval buffer as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetBufferi(byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetBuffer3i(byval buffer as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetBufferiv(byval buffer as ALuint, byval param as ALenum, byval values as ALint ptr)

type LPALENABLE as sub(byval capability as ALenum)
type LPALDISABLE as sub(byval capability as ALenum)
type LPALISENABLED as function(byval capability as ALenum) as ALboolean
type LPALGETSTRING as function(byval param as ALenum) as const ALchar ptr
type LPALGETBOOLEANV as sub(byval param as ALenum, byval values as ALboolean ptr)
type LPALGETINTEGERV as sub(byval param as ALenum, byval values as ALint ptr)
type LPALGETFLOATV as sub(byval param as ALenum, byval values as ALfloat ptr)
type LPALGETDOUBLEV as sub(byval param as ALenum, byval values as ALdouble ptr)
type LPALGETBOOLEAN as function(byval param as ALenum) as ALboolean
type LPALGETINTEGER as function(byval param as ALenum) as ALint
type LPALGETFLOAT as function(byval param as ALenum) as ALfloat
type LPALGETDOUBLE as function(byval param as ALenum) as ALdouble
type LPALGETERROR as function() as ALenum
type LPALISEXTENSIONPRESENT as function(byval extname as const ALchar ptr) as ALboolean
type LPALGETPROCADDRESS as function(byval fname as const ALchar ptr) as any ptr
type LPALGETENUMVALUE as function(byval ename as const ALchar ptr) as ALenum
type LPALLISTENERF as sub(byval param as ALenum, byval value as ALfloat)
type LPALLISTENER3F as sub(byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
type LPALLISTENERFV as sub(byval param as ALenum, byval values as const ALfloat ptr)
type LPALLISTENERI as sub(byval param as ALenum, byval value as ALint)
type LPALLISTENER3I as sub(byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
type LPALLISTENERIV as sub(byval param as ALenum, byval values as const ALint ptr)
type LPALGETLISTENERF as sub(byval param as ALenum, byval value as ALfloat ptr)
type LPALGETLISTENER3F as sub(byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
type LPALGETLISTENERFV as sub(byval param as ALenum, byval values as ALfloat ptr)
type LPALGETLISTENERI as sub(byval param as ALenum, byval value as ALint ptr)
type LPALGETLISTENER3I as sub(byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
type LPALGETLISTENERIV as sub(byval param as ALenum, byval values as ALint ptr)
type LPALGENSOURCES as sub(byval n as ALsizei, byval sources as ALuint ptr)
type LPALDELETESOURCES as sub(byval n as ALsizei, byval sources as const ALuint ptr)
type LPALISSOURCE as function(byval source as ALuint) as ALboolean
type LPALSOURCEF as sub(byval source as ALuint, byval param as ALenum, byval value as ALfloat)
type LPALSOURCE3F as sub(byval source as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
type LPALSOURCEFV as sub(byval source as ALuint, byval param as ALenum, byval values as const ALfloat ptr)
type LPALSOURCEI as sub(byval source as ALuint, byval param as ALenum, byval value as ALint)
type LPALSOURCE3I as sub(byval source as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
type LPALSOURCEIV as sub(byval source as ALuint, byval param as ALenum, byval values as const ALint ptr)
type LPALGETSOURCEF as sub(byval source as ALuint, byval param as ALenum, byval value as ALfloat ptr)
type LPALGETSOURCE3F as sub(byval source as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
type LPALGETSOURCEFV as sub(byval source as ALuint, byval param as ALenum, byval values as ALfloat ptr)
type LPALGETSOURCEI as sub(byval source as ALuint, byval param as ALenum, byval value as ALint ptr)
type LPALGETSOURCE3I as sub(byval source as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
type LPALGETSOURCEIV as sub(byval source as ALuint, byval param as ALenum, byval values as ALint ptr)
type LPALSOURCEPLAYV as sub(byval n as ALsizei, byval sources as const ALuint ptr)
type LPALSOURCESTOPV as sub(byval n as ALsizei, byval sources as const ALuint ptr)
type LPALSOURCEREWINDV as sub(byval n as ALsizei, byval sources as const ALuint ptr)
type LPALSOURCEPAUSEV as sub(byval n as ALsizei, byval sources as const ALuint ptr)
type LPALSOURCEPLAY as sub(byval source as ALuint)
type LPALSOURCESTOP as sub(byval source as ALuint)
type LPALSOURCEREWIND as sub(byval source as ALuint)
type LPALSOURCEPAUSE as sub(byval source as ALuint)
type LPALSOURCEQUEUEBUFFERS as sub(byval source as ALuint, byval nb as ALsizei, byval buffers as const ALuint ptr)
type LPALSOURCEUNQUEUEBUFFERS as sub(byval source as ALuint, byval nb as ALsizei, byval buffers as ALuint ptr)
type LPALGENBUFFERS as sub(byval n as ALsizei, byval buffers as ALuint ptr)
type LPALDELETEBUFFERS as sub(byval n as ALsizei, byval buffers as const ALuint ptr)
type LPALISBUFFER as function(byval buffer as ALuint) as ALboolean
type LPALBUFFERDATA as sub(byval buffer as ALuint, byval format as ALenum, byval data as const any ptr, byval size as ALsizei, byval freq as ALsizei)
type LPALBUFFERF as sub(byval buffer as ALuint, byval param as ALenum, byval value as ALfloat)
type LPALBUFFER3F as sub(byval buffer as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
type LPALBUFFERFV as sub(byval buffer as ALuint, byval param as ALenum, byval values as const ALfloat ptr)
type LPALBUFFERI as sub(byval buffer as ALuint, byval param as ALenum, byval value as ALint)
type LPALBUFFER3I as sub(byval buffer as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
type LPALBUFFERIV as sub(byval buffer as ALuint, byval param as ALenum, byval values as const ALint ptr)
type LPALGETBUFFERF as sub(byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
type LPALGETBUFFER3F as sub(byval buffer as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
type LPALGETBUFFERFV as sub(byval buffer as ALuint, byval param as ALenum, byval values as ALfloat ptr)
type LPALGETBUFFERI as sub(byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
type LPALGETBUFFER3I as sub(byval buffer as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
type LPALGETBUFFERIV as sub(byval buffer as ALuint, byval param as ALenum, byval values as ALint ptr)
type LPALDOPPLERFACTOR as sub(byval value as ALfloat)
type LPALDOPPLERVELOCITY as sub(byval value as ALfloat)
type LPALSPEEDOFSOUND as sub(byval value as ALfloat)
type LPALDISTANCEMODEL as sub(byval distanceModel as ALenum)

end extern
