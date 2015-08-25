'' FreeBASIC binding for freealut-freealut_1_1_0
''
'' based on the C header files:
''   Steve Baker <sjbaker1@airmail.net>
''     Initial version of the sources and the specification
''
''   Sven Panne <sven.panne@aedion.de>
''     Build system
''     General hacking
''     Specification maintenance
''
''   Erik Hofman <erik@ehofman.com>
''     Fixes and additions to the sound file loaders
''     playfile demo
''
''   Prakash Punnoor <prakash@punnoor.de>
''     CMake build system
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "alut"

#include once "AL/al.bi"
#include once "AL/alc.bi"

extern "C"

#define AL_ALUT_H
const ALUT_API_MAJOR_VERSION = 1
const ALUT_API_MINOR_VERSION = 1
const ALUT_ERROR_NO_ERROR = 0
const ALUT_ERROR_OUT_OF_MEMORY = &h200
const ALUT_ERROR_INVALID_ENUM = &h201
const ALUT_ERROR_INVALID_VALUE = &h202
const ALUT_ERROR_INVALID_OPERATION = &h203
const ALUT_ERROR_NO_CURRENT_CONTEXT = &h204
const ALUT_ERROR_AL_ERROR_ON_ENTRY = &h205
const ALUT_ERROR_ALC_ERROR_ON_ENTRY = &h206
const ALUT_ERROR_OPEN_DEVICE = &h207
const ALUT_ERROR_CLOSE_DEVICE = &h208
const ALUT_ERROR_CREATE_CONTEXT = &h209
const ALUT_ERROR_MAKE_CONTEXT_CURRENT = &h20A
const ALUT_ERROR_DESTROY_CONTEXT = &h20B
const ALUT_ERROR_GEN_BUFFERS = &h20C
const ALUT_ERROR_BUFFER_DATA = &h20D
const ALUT_ERROR_IO_ERROR = &h20E
const ALUT_ERROR_UNSUPPORTED_FILE_TYPE = &h20F
const ALUT_ERROR_UNSUPPORTED_FILE_SUBTYPE = &h210
const ALUT_ERROR_CORRUPT_OR_TRUNCATED_DATA = &h211
const ALUT_WAVEFORM_SINE = &h100
const ALUT_WAVEFORM_SQUARE = &h101
const ALUT_WAVEFORM_SAWTOOTH = &h102
const ALUT_WAVEFORM_WHITENOISE = &h103
const ALUT_WAVEFORM_IMPULSE = &h104
const ALUT_LOADER_BUFFER = &h300
const ALUT_LOADER_MEMORY = &h301

declare function alutInit(byval argcp as long ptr, byval argv as zstring ptr ptr) as ALboolean
declare function alutInitWithoutContext(byval argcp as long ptr, byval argv as zstring ptr ptr) as ALboolean
declare function alutExit() as ALboolean
declare function alutGetError() as ALenum
declare function alutGetErrorString(byval error as ALenum) as const zstring ptr
declare function alutCreateBufferFromFile(byval fileName as const zstring ptr) as ALuint
declare function alutCreateBufferFromFileImage(byval data as const any ptr, byval length as ALsizei) as ALuint
declare function alutCreateBufferHelloWorld() as ALuint
declare function alutCreateBufferWaveform(byval waveshape as ALenum, byval frequency as ALfloat, byval phase as ALfloat, byval duration as ALfloat) as ALuint
declare function alutLoadMemoryFromFile(byval fileName as const zstring ptr, byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as any ptr
declare function alutLoadMemoryFromFileImage(byval data as const any ptr, byval length as ALsizei, byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as any ptr
declare function alutLoadMemoryHelloWorld(byval format as ALenum ptr, byval size as ALsizei ptr, byval frequency as ALfloat ptr) as any ptr
declare function alutLoadMemoryWaveform(byval waveshape as ALenum, byval frequency as ALfloat, byval phase as ALfloat, byval duration as ALfloat, byval format as ALenum ptr, byval size as ALsizei ptr, byval freq as ALfloat ptr) as any ptr
declare function alutGetMIMETypes(byval loader as ALenum) as const zstring ptr
declare function alutGetMajorVersion() as ALint
declare function alutGetMinorVersion() as ALint
declare function alutSleep(byval duration as ALfloat) as ALboolean

#ifdef __FB_DARWIN__
	declare sub alutLoadWAVFile(byval fileName as ALbyte ptr, byval format as ALenum ptr, byval data as any ptr ptr, byval size as ALsizei ptr, byval frequency as ALsizei ptr)
	declare sub alutLoadWAVMemory(byval buffer as ALbyte ptr, byval format as ALenum ptr, byval data as any ptr ptr, byval size as ALsizei ptr, byval frequency as ALsizei ptr)
#else
	declare sub alutLoadWAVFile(byval fileName as ALbyte ptr, byval format as ALenum ptr, byval data as any ptr ptr, byval size as ALsizei ptr, byval frequency as ALsizei ptr, byval loop as ALboolean ptr)
	declare sub alutLoadWAVMemory(byval buffer as ALbyte ptr, byval format as ALenum ptr, byval data as any ptr ptr, byval size as ALsizei ptr, byval frequency as ALsizei ptr, byval loop as ALboolean ptr)
#endif

declare sub alutUnloadWAV(byval format as ALenum, byval data as any ptr, byval size as ALsizei, byval frequency as ALsizei)

end extern
