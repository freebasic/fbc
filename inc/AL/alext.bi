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

#include once "crt/stddef.bi"
#include once "alc.bi"
#include once "al.bi"
#include once "efx.bi"

extern "C"

#define AL_ALEXT_H
const AL_LOKI_IMA_ADPCM_format = 1
const AL_FORMAT_IMA_ADPCM_MONO16_EXT = &h10000
const AL_FORMAT_IMA_ADPCM_STEREO16_EXT = &h10001
const AL_LOKI_WAVE_format = 1
const AL_FORMAT_WAVE_EXT = &h10002
const AL_EXT_vorbis = 1
const AL_FORMAT_VORBIS_EXT = &h10003
const AL_LOKI_quadriphonic = 1
const AL_FORMAT_QUAD8_LOKI = &h10004
const AL_FORMAT_QUAD16_LOKI = &h10005
const AL_EXT_float32 = 1
const AL_FORMAT_MONO_FLOAT32 = &h10010
const AL_FORMAT_STEREO_FLOAT32 = &h10011
const AL_EXT_double = 1
const AL_FORMAT_MONO_DOUBLE_EXT = &h10012
const AL_FORMAT_STEREO_DOUBLE_EXT = &h10013
const AL_EXT_MULAW = 1
const AL_FORMAT_MONO_MULAW_EXT = &h10014
const AL_FORMAT_STEREO_MULAW_EXT = &h10015
const AL_EXT_ALAW = 1
const AL_FORMAT_MONO_ALAW_EXT = &h10016
const AL_FORMAT_STEREO_ALAW_EXT = &h10017
const ALC_LOKI_audio_channel = 1
const ALC_CHAN_MAIN_LOKI = &h500001
const ALC_CHAN_PCM_LOKI = &h500002
const ALC_CHAN_CD_LOKI = &h500003
const AL_EXT_MCFORMATS = 1
const AL_FORMAT_QUAD8 = &h1204
const AL_FORMAT_QUAD16 = &h1205
const AL_FORMAT_QUAD32 = &h1206
const AL_FORMAT_REAR8 = &h1207
const AL_FORMAT_REAR16 = &h1208
const AL_FORMAT_REAR32 = &h1209
const AL_FORMAT_51CHN8 = &h120A
const AL_FORMAT_51CHN16 = &h120B
const AL_FORMAT_51CHN32 = &h120C
const AL_FORMAT_61CHN8 = &h120D
const AL_FORMAT_61CHN16 = &h120E
const AL_FORMAT_61CHN32 = &h120F
const AL_FORMAT_71CHN8 = &h1210
const AL_FORMAT_71CHN16 = &h1211
const AL_FORMAT_71CHN32 = &h1212
const AL_EXT_MULAW_MCFORMATS = 1
const AL_FORMAT_MONO_MULAW = &h10014
const AL_FORMAT_STEREO_MULAW = &h10015
const AL_FORMAT_QUAD_MULAW = &h10021
const AL_FORMAT_REAR_MULAW = &h10022
const AL_FORMAT_51CHN_MULAW = &h10023
const AL_FORMAT_61CHN_MULAW = &h10024
const AL_FORMAT_71CHN_MULAW = &h10025
const AL_EXT_IMA4 = 1
const AL_FORMAT_MONO_IMA4 = &h1300
const AL_FORMAT_STEREO_IMA4 = &h1301
const AL_EXT_STATIC_BUFFER = 1
type PFNALBUFFERDATASTATICPROC as sub(byval as const ALint, byval as ALenum, byval as any ptr, byval as ALsizei, byval as ALsizei)
const ALC_EXT_EFX = 1
const ALC_EXT_disconnect = 1
const ALC_CONNECTED = &h313
const ALC_EXT_thread_local_context = 1
type PFNALCSETTHREADCONTEXTPROC as function(byval context as ALCcontext ptr) as ALCboolean
type PFNALCGETTHREADCONTEXTPROC as function() as ALCcontext ptr
const AL_EXT_source_distance_model = 1
const AL_SOURCE_DISTANCE_MODEL = &h200
const AL_SOFT_buffer_sub_data = 1
const AL_BYTE_RW_OFFSETS_SOFT = &h1031
const AL_SAMPLE_RW_OFFSETS_SOFT = &h1032
type PFNALBUFFERSUBDATASOFTPROC as sub(byval as ALuint, byval as ALenum, byval as const any ptr, byval as ALsizei, byval as ALsizei)
const AL_SOFT_loop_points = 1
const AL_LOOP_POINTS_SOFT = &h2015
const AL_EXT_FOLDBACK = 1
#define AL_EXT_FOLDBACK_NAME "AL_EXT_FOLDBACK"
const AL_FOLDBACK_EVENT_BLOCK = &h4112
const AL_FOLDBACK_EVENT_START = &h4111
const AL_FOLDBACK_EVENT_STOP = &h4113
const AL_FOLDBACK_MODE_MONO = &h4101
const AL_FOLDBACK_MODE_STEREO = &h4102

type LPALFOLDBACKCALLBACK as sub(byval as ALenum, byval as ALsizei)
type LPALREQUESTFOLDBACKSTART as sub(byval as ALenum, byval as ALsizei, byval as ALsizei, byval as ALfloat ptr, byval as LPALFOLDBACKCALLBACK)
type LPALREQUESTFOLDBACKSTOP as sub()

const ALC_EXT_DEDICATED = 1
const AL_DEDICATED_GAIN = &h0001
const AL_EFFECT_DEDICATED_DIALOGUE = &h9001
const AL_EFFECT_DEDICATED_LOW_FREQUENCY_EFFECT = &h9000
const AL_SOFT_buffer_samples = 1
const AL_MONO_SOFT = &h1500
const AL_STEREO_SOFT = &h1501
const AL_REAR_SOFT = &h1502
const AL_QUAD_SOFT = &h1503
const AL_5POINT1_SOFT = &h1504
const AL_6POINT1_SOFT = &h1505
const AL_7POINT1_SOFT = &h1506
const AL_BYTE_SOFT = &h1400
const AL_UNSIGNED_BYTE_SOFT = &h1401
const AL_SHORT_SOFT = &h1402
const AL_UNSIGNED_SHORT_SOFT = &h1403
const AL_INT_SOFT = &h1404
const AL_UNSIGNED_INT_SOFT = &h1405
const AL_FLOAT_SOFT = &h1406
const AL_DOUBLE_SOFT = &h1407
const AL_BYTE3_SOFT = &h1408
const AL_UNSIGNED_BYTE3_SOFT = &h1409
const AL_MONO8_SOFT = &h1100
const AL_MONO16_SOFT = &h1101
const AL_MONO32F_SOFT = &h10010
const AL_STEREO8_SOFT = &h1102
const AL_STEREO16_SOFT = &h1103
const AL_STEREO32F_SOFT = &h10011
const AL_QUAD8_SOFT = &h1204
const AL_QUAD16_SOFT = &h1205
const AL_QUAD32F_SOFT = &h1206
const AL_REAR8_SOFT = &h1207
const AL_REAR16_SOFT = &h1208
const AL_REAR32F_SOFT = &h1209
const AL_5POINT1_8_SOFT = &h120A
const AL_5POINT1_16_SOFT = &h120B
const AL_5POINT1_32F_SOFT = &h120C
const AL_6POINT1_8_SOFT = &h120D
const AL_6POINT1_16_SOFT = &h120E
const AL_6POINT1_32F_SOFT = &h120F
const AL_7POINT1_8_SOFT = &h1210
const AL_7POINT1_16_SOFT = &h1211
const AL_7POINT1_32F_SOFT = &h1212
const AL_INTERNAL_FORMAT_SOFT = &h2008
const AL_BYTE_LENGTH_SOFT = &h2009
const AL_SAMPLE_LENGTH_SOFT = &h200A
const AL_SEC_LENGTH_SOFT = &h200B

type LPALBUFFERSAMPLESSOFT as sub(byval as ALuint, byval as ALuint, byval as ALenum, byval as ALsizei, byval as ALenum, byval as ALenum, byval as const any ptr)
type LPALBUFFERSUBSAMPLESSOFT as sub(byval as ALuint, byval as ALsizei, byval as ALsizei, byval as ALenum, byval as ALenum, byval as const any ptr)
type LPALGETBUFFERSAMPLESSOFT as sub(byval as ALuint, byval as ALsizei, byval as ALsizei, byval as ALenum, byval as ALenum, byval as any ptr)
type LPALISBUFFERFORMATSUPPORTEDSOFT as function(byval as ALenum) as ALboolean

const AL_SOFT_direct_channels = 1
const AL_DIRECT_CHANNELS_SOFT = &h1033
const ALC_SOFT_loopback = 1
const ALC_FORMAT_CHANNELS_SOFT = &h1990
const ALC_FORMAT_TYPE_SOFT = &h1991
const ALC_BYTE_SOFT = &h1400
const ALC_UNSIGNED_BYTE_SOFT = &h1401
const ALC_SHORT_SOFT = &h1402
const ALC_UNSIGNED_SHORT_SOFT = &h1403
const ALC_INT_SOFT = &h1404
const ALC_UNSIGNED_INT_SOFT = &h1405
const ALC_FLOAT_SOFT = &h1406
const ALC_MONO_SOFT = &h1500
const ALC_STEREO_SOFT = &h1501
const ALC_QUAD_SOFT = &h1503
const ALC_5POINT1_SOFT = &h1504
const ALC_6POINT1_SOFT = &h1505
const ALC_7POINT1_SOFT = &h1506

type LPALCLOOPBACKOPENDEVICESOFT as function(byval as const ALCchar ptr) as ALCdevice ptr
type LPALCISRENDERFORMATSUPPORTEDSOFT as function(byval as ALCdevice ptr, byval as ALCsizei, byval as ALCenum, byval as ALCenum) as ALCboolean
type LPALCRENDERSAMPLESSOFT as sub(byval as ALCdevice ptr, byval as ALCvoid ptr, byval as ALCsizei)

const AL_EXT_STEREO_ANGLES = 1
const AL_STEREO_ANGLES = &h1030
const AL_EXT_SOURCE_RADIUS = 1
const AL_SOURCE_RADIUS = &h1031
const AL_SOFT_source_latency = 1
const AL_SAMPLE_OFFSET_LATENCY_SOFT = &h1200
const AL_SEC_OFFSET_LATENCY_SOFT = &h1201

type ALint64SOFT as longint
type ALuint64SOFT as ulongint
type LPALSOURCEDSOFT as sub(byval as ALuint, byval as ALenum, byval as ALdouble)
type LPALSOURCE3DSOFT as sub(byval as ALuint, byval as ALenum, byval as ALdouble, byval as ALdouble, byval as ALdouble)
type LPALSOURCEDVSOFT as sub(byval as ALuint, byval as ALenum, byval as const ALdouble ptr)
type LPALGETSOURCEDSOFT as sub(byval as ALuint, byval as ALenum, byval as ALdouble ptr)
type LPALGETSOURCE3DSOFT as sub(byval as ALuint, byval as ALenum, byval as ALdouble ptr, byval as ALdouble ptr, byval as ALdouble ptr)
type LPALGETSOURCEDVSOFT as sub(byval as ALuint, byval as ALenum, byval as ALdouble ptr)
type LPALSOURCEI64SOFT as sub(byval as ALuint, byval as ALenum, byval as ALint64SOFT)
type LPALSOURCE3I64SOFT as sub(byval as ALuint, byval as ALenum, byval as ALint64SOFT, byval as ALint64SOFT, byval as ALint64SOFT)
type LPALSOURCEI64VSOFT as sub(byval as ALuint, byval as ALenum, byval as const ALint64SOFT ptr)
type LPALGETSOURCEI64SOFT as sub(byval as ALuint, byval as ALenum, byval as ALint64SOFT ptr)
type LPALGETSOURCE3I64SOFT as sub(byval as ALuint, byval as ALenum, byval as ALint64SOFT ptr, byval as ALint64SOFT ptr, byval as ALint64SOFT ptr)
type LPALGETSOURCEI64VSOFT as sub(byval as ALuint, byval as ALenum, byval as ALint64SOFT ptr)

const ALC_EXT_DEFAULT_FILTER_ORDER = 1
const ALC_DEFAULT_FILTER_ORDER = &h1100
const AL_SOFT_deferred_updates = 1
const AL_DEFERRED_UPDATES_SOFT = &hC002
type LPALDEFERUPDATESSOFT as sub()
type LPALPROCESSUPDATESSOFT as sub()
const AL_SOFT_block_alignment = 1
const AL_UNPACK_BLOCK_ALIGNMENT_SOFT = &h200C
const AL_PACK_BLOCK_ALIGNMENT_SOFT = &h200D
const AL_SOFT_MSADPCM = 1
const AL_FORMAT_MONO_MSADPCM_SOFT = &h1302
const AL_FORMAT_STEREO_MSADPCM_SOFT = &h1303
const AL_SOFT_source_length = 1
const ALC_SOFT_pause_device = 1
type LPALCDEVICEPAUSESOFT as sub(byval device as ALCdevice ptr)
type LPALCDEVICERESUMESOFT as sub(byval device as ALCdevice ptr)

end extern
