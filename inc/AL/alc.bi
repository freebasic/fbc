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

extern "C"

#define AL_ALC_H
const ALC_INVALID = 0
const ALC_VERSION_0_1 = 1

type ALCdevice as ALCdevice_struct
type ALCcontext as ALCcontext_struct
type ALCboolean as byte
type ALCchar as zstring
type ALCbyte as byte
type ALCubyte as ubyte
type ALCshort as short
type ALCushort as ushort
type ALCint as long
type ALCuint as ulong
type ALCsizei as long
type ALCenum as long
type ALCfloat as single
type ALCdouble as double
type ALCvoid as any

const ALC_FALSE = 0
const ALC_TRUE = 1
const ALC_FREQUENCY = &h1007
const ALC_REFRESH = &h1008
const ALC_SYNC = &h1009
const ALC_MONO_SOURCES = &h1010
const ALC_STEREO_SOURCES = &h1011
const ALC_NO_ERROR = 0
const ALC_INVALID_DEVICE = &hA001
const ALC_INVALID_CONTEXT = &hA002
const ALC_INVALID_ENUM = &hA003
const ALC_INVALID_VALUE = &hA004
const ALC_OUT_OF_MEMORY = &hA005
const ALC_MAJOR_VERSION = &h1000
const ALC_MINOR_VERSION = &h1001
const ALC_ATTRIBUTES_SIZE = &h1002
const ALC_ALL_ATTRIBUTES = &h1003
const ALC_DEFAULT_DEVICE_SPECIFIER = &h1004
const ALC_DEVICE_SPECIFIER = &h1005
const ALC_EXTENSIONS = &h1006
const ALC_EXT_CAPTURE = 1
const ALC_CAPTURE_DEVICE_SPECIFIER = &h310
const ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER = &h311
const ALC_CAPTURE_SAMPLES = &h312
const ALC_ENUMERATE_ALL_EXT = 1
const ALC_DEFAULT_ALL_DEVICES_SPECIFIER = &h1012
const ALC_ALL_DEVICES_SPECIFIER = &h1013

declare function alcCreateContext(byval device as ALCdevice ptr, byval attrlist as const ALCint ptr) as ALCcontext ptr
declare function alcMakeContextCurrent(byval context as ALCcontext ptr) as ALCboolean
declare sub alcProcessContext(byval context as ALCcontext ptr)
declare sub alcSuspendContext(byval context as ALCcontext ptr)
declare sub alcDestroyContext(byval context as ALCcontext ptr)
declare function alcGetCurrentContext() as ALCcontext ptr
declare function alcGetContextsDevice(byval context as ALCcontext ptr) as ALCdevice ptr
declare function alcOpenDevice(byval devicename as const ALCchar ptr) as ALCdevice ptr
declare function alcCloseDevice(byval device as ALCdevice ptr) as ALCboolean
declare function alcGetError(byval device as ALCdevice ptr) as ALCenum
declare function alcIsExtensionPresent(byval device as ALCdevice ptr, byval extname as const ALCchar ptr) as ALCboolean
declare function alcGetProcAddress(byval device as ALCdevice ptr, byval funcname as const ALCchar ptr) as any ptr
declare function alcGetEnumValue(byval device as ALCdevice ptr, byval enumname as const ALCchar ptr) as ALCenum
declare function alcGetString(byval device as ALCdevice ptr, byval param as ALCenum) as const ALCchar ptr
declare sub alcGetIntegerv(byval device as ALCdevice ptr, byval param as ALCenum, byval size as ALCsizei, byval values as ALCint ptr)
declare function alcCaptureOpenDevice(byval devicename as const ALCchar ptr, byval frequency as ALCuint, byval format as ALCenum, byval buffersize as ALCsizei) as ALCdevice ptr
declare function alcCaptureCloseDevice(byval device as ALCdevice ptr) as ALCboolean
declare sub alcCaptureStart(byval device as ALCdevice ptr)
declare sub alcCaptureStop(byval device as ALCdevice ptr)
declare sub alcCaptureSamples(byval device as ALCdevice ptr, byval buffer as ALCvoid ptr, byval samples as ALCsizei)

type LPALCCREATECONTEXT as function(byval device as ALCdevice ptr, byval attrlist as const ALCint ptr) as ALCcontext ptr
type LPALCMAKECONTEXTCURRENT as function(byval context as ALCcontext ptr) as ALCboolean
type LPALCPROCESSCONTEXT as sub(byval context as ALCcontext ptr)
type LPALCSUSPENDCONTEXT as sub(byval context as ALCcontext ptr)
type LPALCDESTROYCONTEXT as sub(byval context as ALCcontext ptr)
type LPALCGETCURRENTCONTEXT as function() as ALCcontext ptr
type LPALCGETCONTEXTSDEVICE as function(byval context as ALCcontext ptr) as ALCdevice ptr
type LPALCOPENDEVICE as function(byval devicename as const ALCchar ptr) as ALCdevice ptr
type LPALCCLOSEDEVICE as function(byval device as ALCdevice ptr) as ALCboolean
type LPALCGETERROR as function(byval device as ALCdevice ptr) as ALCenum
type LPALCISEXTENSIONPRESENT as function(byval device as ALCdevice ptr, byval extname as const ALCchar ptr) as ALCboolean
type LPALCGETPROCADDRESS as function(byval device as ALCdevice ptr, byval funcname as const ALCchar ptr) as any ptr
type LPALCGETENUMVALUE as function(byval device as ALCdevice ptr, byval enumname as const ALCchar ptr) as ALCenum
type LPALCGETSTRING as function(byval device as ALCdevice ptr, byval param as ALCenum) as const ALCchar ptr
type LPALCGETINTEGERV as sub(byval device as ALCdevice ptr, byval param as ALCenum, byval size as ALCsizei, byval values as ALCint ptr)
type LPALCCAPTUREOPENDEVICE as function(byval devicename as const ALCchar ptr, byval frequency as ALCuint, byval format as ALCenum, byval buffersize as ALCsizei) as ALCdevice ptr
type LPALCCAPTURECLOSEDEVICE as function(byval device as ALCdevice ptr) as ALCboolean
type LPALCCAPTURESTART as sub(byval device as ALCdevice ptr)
type LPALCCAPTURESTOP as sub(byval device as ALCdevice ptr)
type LPALCCAPTURESAMPLES as sub(byval device as ALCdevice ptr, byval buffer as ALCvoid ptr, byval samples as ALCsizei)

end extern
