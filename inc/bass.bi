'' FreeBASIC binding for bass24
''
'' based on the C header files:
''   BASS 2.4 C/C++ header file
''   Copyright (c) 1999-2019 Un4seen Developments Ltd.
''
''   See the BASS.CHM file for more detailed documentation
''
''   BASS is free for non-commercial use. If you are a non-commercial entity
''   (eg. an individual) and you are not making any money from your product
''   (through sales/advertising/etc), then you can use BASS in it for free.
''   If you wish to use BASS in commercial products, then please also see the
''   next section.
''
''   TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, BASS IS PROVIDED
''   "AS IS", WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
''   INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY
''   AND/OR FITNESS FOR A PARTICULAR PURPOSE. THE AUTHORS SHALL NOT BE HELD
''   LIABLE FOR ANY DAMAGE THAT MAY RESULT FROM THE USE OF BASS. YOU USE
''   BASS ENTIRELY AT YOUR OWN RISK.
''
''   Usage of BASS indicates that you agree to the above conditions.
''
''   All trademarks and other registered names contained in the BASS
''   package are the property of their respective owners.
''
'' translated to FreeBASIC by:
''   Copyright © 2020 FreeBASIC development team

#pragma once

#inclib "bass"

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#include once "crt/stdint.bi"
	'' The following symbols have been renamed:
	''     constant TRUE => CTRUE
#elseif defined(__FB_WIN32__)
	#include once "win/wtypes.bi"
#endif

#ifdef __FB_WIN32__
	extern "Windows-MS"
#else
	extern "C"
#endif

#define BASS_H

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	type WORD as ushort
	type DWORD as ulong
#endif

type QWORD as ulongint

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	type BOOL as long
	#ifndef CTRUE
		const CTRUE = 1
	#endif
	#ifndef TRUE
		const TRUE = 1
	#endif
	#ifndef FALSE
		const FALSE = 0
	#endif
	#define MAKEWORD(a, b) cast(WORD, ((a) and &hff) or ((b) shl 8))
	#define MAKELONG(a, b) cast(DWORD, ((a) and &hffff) or ((b) shl 16))
#endif

const BASSVERSION = &h204
#define BASSVERSIONTEXT "2.4"
type HMUSIC as DWORD
type HSAMPLE as DWORD
type HCHANNEL as DWORD
type HSTREAM as DWORD
type HRECORD as DWORD
type HSYNC as DWORD
type HDSP as DWORD
type HFX as DWORD
type HPLUGIN as DWORD

const BASS_OK = 0
const BASS_ERROR_MEM = 1
const BASS_ERROR_FILEOPEN = 2
const BASS_ERROR_DRIVER = 3
const BASS_ERROR_BUFLOST = 4
const BASS_ERROR_HANDLE = 5
const BASS_ERROR_FORMAT = 6
const BASS_ERROR_POSITION = 7
const BASS_ERROR_INIT = 8
const BASS_ERROR_START = 9
const BASS_ERROR_SSL = 10
const BASS_ERROR_ALREADY = 14
const BASS_ERROR_NOTAUDIO = 17
const BASS_ERROR_NOCHAN = 18
const BASS_ERROR_ILLTYPE = 19
const BASS_ERROR_ILLPARAM = 20
const BASS_ERROR_NO3D = 21
const BASS_ERROR_NOEAX = 22
const BASS_ERROR_DEVICE = 23
const BASS_ERROR_NOPLAY = 24
const BASS_ERROR_FREQ = 25
const BASS_ERROR_NOTFILE = 27
const BASS_ERROR_NOHW = 29
const BASS_ERROR_EMPTY = 31
const BASS_ERROR_NONET = 32
const BASS_ERROR_CREATE = 33
const BASS_ERROR_NOFX = 34
const BASS_ERROR_NOTAVAIL = 37
const BASS_ERROR_DECODE = 38
const BASS_ERROR_DX = 39
const BASS_ERROR_TIMEOUT = 40
const BASS_ERROR_FILEFORM = 41
const BASS_ERROR_SPEAKER = 42
const BASS_ERROR_VERSION = 43
const BASS_ERROR_CODEC = 44
const BASS_ERROR_ENDED = 45
const BASS_ERROR_BUSY = 46
const BASS_ERROR_UNSTREAMABLE = 47
const BASS_ERROR_UNKNOWN = -1
const BASS_CONFIG_BUFFER = 0
const BASS_CONFIG_UPDATEPERIOD = 1
const BASS_CONFIG_GVOL_SAMPLE = 4
const BASS_CONFIG_GVOL_STREAM = 5
const BASS_CONFIG_GVOL_MUSIC = 6
const BASS_CONFIG_CURVE_VOL = 7
const BASS_CONFIG_CURVE_PAN = 8
const BASS_CONFIG_FLOATDSP = 9
const BASS_CONFIG_3DALGORITHM = 10
const BASS_CONFIG_NET_TIMEOUT = 11
const BASS_CONFIG_NET_BUFFER = 12
const BASS_CONFIG_PAUSE_NOPLAY = 13
const BASS_CONFIG_NET_PREBUF = 15
const BASS_CONFIG_NET_PASSIVE = 18
const BASS_CONFIG_REC_BUFFER = 19
const BASS_CONFIG_NET_PLAYLIST = 21
const BASS_CONFIG_MUSIC_VIRTUAL = 22
const BASS_CONFIG_VERIFY = 23
const BASS_CONFIG_UPDATETHREADS = 24
const BASS_CONFIG_DEV_BUFFER = 27
const BASS_CONFIG_REC_LOOPBACK = 28
const BASS_CONFIG_VISTA_TRUEPOS = 30
const BASS_CONFIG_IOS_SESSION = 34
const BASS_CONFIG_IOS_MIXAUDIO = 34
const BASS_CONFIG_DEV_DEFAULT = 36
const BASS_CONFIG_NET_READTIMEOUT = 37
const BASS_CONFIG_VISTA_SPEAKERS = 38
const BASS_CONFIG_IOS_SPEAKER = 39
const BASS_CONFIG_MF_DISABLE = 40
const BASS_CONFIG_HANDLES = 41
const BASS_CONFIG_UNICODE = 42
const BASS_CONFIG_SRC = 43
const BASS_CONFIG_SRC_SAMPLE = 44
const BASS_CONFIG_ASYNCFILE_BUFFER = 45
const BASS_CONFIG_OGG_PRESCAN = 47
const BASS_CONFIG_MF_VIDEO = 48
const BASS_CONFIG_AIRPLAY = 49
const BASS_CONFIG_DEV_NONSTOP = 50
const BASS_CONFIG_IOS_NOCATEGORY = 51
const BASS_CONFIG_VERIFY_NET = 52
const BASS_CONFIG_DEV_PERIOD = 53
const BASS_CONFIG_FLOAT = 54
const BASS_CONFIG_NET_SEEK = 56
const BASS_CONFIG_AM_DISABLE = 58
const BASS_CONFIG_NET_PLAYLIST_DEPTH = 59
const BASS_CONFIG_NET_PREBUF_WAIT = 60
const BASS_CONFIG_ANDROID_SESSIONID = 62
const BASS_CONFIG_WASAPI_PERSIST = 65
const BASS_CONFIG_REC_WASAPI = 66
const BASS_CONFIG_ANDROID_AAUDIO = 67
const BASS_CONFIG_NET_AGENT = 16
const BASS_CONFIG_NET_PROXY = 17
const BASS_CONFIG_IOS_NOTIFY = 46
const BASS_CONFIG_LIBSSL = 64
const BASS_IOS_SESSION_MIX = 1
const BASS_IOS_SESSION_DUCK = 2
const BASS_IOS_SESSION_AMBIENT = 4
const BASS_IOS_SESSION_SPEAKER = 8
const BASS_IOS_SESSION_DISABLE = 16
const BASS_DEVICE_8BITS = 1
const BASS_DEVICE_MONO = 2
const BASS_DEVICE_3D = 4
const BASS_DEVICE_16BITS = 8
const BASS_DEVICE_LATENCY = &h100
const BASS_DEVICE_CPSPEAKERS = &h400
const BASS_DEVICE_SPEAKERS = &h800
const BASS_DEVICE_NOSPEAKER = &h1000
const BASS_DEVICE_DMIX = &h2000
const BASS_DEVICE_FREQ = &h4000
const BASS_DEVICE_STEREO = &h8000
const BASS_DEVICE_HOG = &h10000
const BASS_DEVICE_AUDIOTRACK = &h20000
const BASS_DEVICE_DSOUND = &h40000
const BASS_OBJECT_DS = 1
const BASS_OBJECT_DS3DL = 2

type BASS_DEVICEINFO
	name as const zstring ptr
	driver as const zstring ptr
	flags as DWORD
end type

const BASS_DEVICE_ENABLED = 1
const BASS_DEVICE_DEFAULT = 2
const BASS_DEVICE_INIT = 4
const BASS_DEVICE_LOOPBACK = 8
const BASS_DEVICE_TYPE_MASK = &hff000000
const BASS_DEVICE_TYPE_NETWORK = &h01000000
const BASS_DEVICE_TYPE_SPEAKERS = &h02000000
const BASS_DEVICE_TYPE_LINE = &h03000000
const BASS_DEVICE_TYPE_HEADPHONES = &h04000000
const BASS_DEVICE_TYPE_MICROPHONE = &h05000000
const BASS_DEVICE_TYPE_HEADSET = &h06000000
const BASS_DEVICE_TYPE_HANDSET = &h07000000
const BASS_DEVICE_TYPE_DIGITAL = &h08000000
const BASS_DEVICE_TYPE_SPDIF = &h09000000
const BASS_DEVICE_TYPE_HDMI = &h0a000000
const BASS_DEVICE_TYPE_DISPLAYPORT = &h40000000
const BASS_DEVICES_AIRPLAY = &h1000000

type BASS_INFO
	flags as DWORD
	hwsize as DWORD
	hwfree as DWORD
	freesam as DWORD
	free3d as DWORD
	minrate as DWORD
	maxrate as DWORD
	eax as BOOL
	minbuf as DWORD
	dsver as DWORD
	latency as DWORD
	initflags as DWORD
	speakers as DWORD
	freq as DWORD
end type

const DSCAPS_CONTINUOUSRATE = &h00000010
const DSCAPS_EMULDRIVER = &h00000020
const DSCAPS_CERTIFIED = &h00000040
const DSCAPS_SECONDARYMONO = &h00000100
const DSCAPS_SECONDARYSTEREO = &h00000200
const DSCAPS_SECONDARY8BIT = &h00000400
const DSCAPS_SECONDARY16BIT = &h00000800

type BASS_RECORDINFO
	flags as DWORD
	formats as DWORD
	inputs as DWORD
	singlein as BOOL
	freq as DWORD
end type

const DSCCAPS_EMULDRIVER = DSCAPS_EMULDRIVER
const DSCCAPS_CERTIFIED = DSCAPS_CERTIFIED

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	const WAVE_FORMAT_1M08 = &h00000001
	const WAVE_FORMAT_1S08 = &h00000002
	const WAVE_FORMAT_1M16 = &h00000004
	const WAVE_FORMAT_1S16 = &h00000008
	const WAVE_FORMAT_2M08 = &h00000010
	const WAVE_FORMAT_2S08 = &h00000020
	const WAVE_FORMAT_2M16 = &h00000040
	const WAVE_FORMAT_2S16 = &h00000080
	const WAVE_FORMAT_4M08 = &h00000100
	const WAVE_FORMAT_4S08 = &h00000200
	const WAVE_FORMAT_4M16 = &h00000400
	const WAVE_FORMAT_4S16 = &h00000800
#endif

type BASS_SAMPLE
	freq as DWORD
	volume as single
	pan as single
	flags as DWORD
	length as DWORD
	max as DWORD
	origres as DWORD
	chans as DWORD
	mingap as DWORD
	mode3d as DWORD
	mindist as single
	maxdist as single
	iangle as DWORD
	oangle as DWORD
	outvol as single
	vam as DWORD
	priority as DWORD
end type

const BASS_SAMPLE_8BITS = 1
const BASS_SAMPLE_FLOAT = 256
const BASS_SAMPLE_MONO = 2
const BASS_SAMPLE_LOOP = 4
const BASS_SAMPLE_3D = 8
const BASS_SAMPLE_SOFTWARE = 16
const BASS_SAMPLE_MUTEMAX = 32
const BASS_SAMPLE_VAM = 64
const BASS_SAMPLE_FX = 128
const BASS_SAMPLE_OVER_VOL = &h10000
const BASS_SAMPLE_OVER_POS = &h20000
const BASS_SAMPLE_OVER_DIST = &h30000
const BASS_STREAM_PRESCAN = &h20000
const BASS_STREAM_AUTOFREE = &h40000
const BASS_STREAM_RESTRATE = &h80000
const BASS_STREAM_BLOCK = &h100000
const BASS_STREAM_DECODE = &h200000
const BASS_STREAM_STATUS = &h800000
const BASS_MP3_IGNOREDELAY = &h200
const BASS_MP3_SETPOS = BASS_STREAM_PRESCAN
const BASS_MUSIC_FLOAT = BASS_SAMPLE_FLOAT
const BASS_MUSIC_MONO = BASS_SAMPLE_MONO
const BASS_MUSIC_LOOP = BASS_SAMPLE_LOOP
const BASS_MUSIC_3D = BASS_SAMPLE_3D
const BASS_MUSIC_FX = BASS_SAMPLE_FX
const BASS_MUSIC_AUTOFREE = BASS_STREAM_AUTOFREE
const BASS_MUSIC_DECODE = BASS_STREAM_DECODE
const BASS_MUSIC_PRESCAN = BASS_STREAM_PRESCAN
const BASS_MUSIC_CALCLEN = BASS_MUSIC_PRESCAN
const BASS_MUSIC_RAMP = &h200
const BASS_MUSIC_RAMPS = &h400
const BASS_MUSIC_SURROUND = &h800
const BASS_MUSIC_SURROUND2 = &h1000
const BASS_MUSIC_FT2PAN = &h2000
const BASS_MUSIC_FT2MOD = &h2000
const BASS_MUSIC_PT1MOD = &h4000
const BASS_MUSIC_NONINTER = &h10000
const BASS_MUSIC_SINCINTER = &h800000
const BASS_MUSIC_POSRESET = &h8000
const BASS_MUSIC_POSRESETEX = &h400000
const BASS_MUSIC_STOPBACK = &h80000
const BASS_MUSIC_NOSAMPLE = &h100000
const BASS_SPEAKER_FRONT = &h1000000
const BASS_SPEAKER_REAR = &h2000000
const BASS_SPEAKER_CENLFE = &h3000000
const BASS_SPEAKER_REAR2 = &h4000000
#define BASS_SPEAKER_N(n) ((n) shl 24)
const BASS_SPEAKER_LEFT = &h10000000
const BASS_SPEAKER_RIGHT = &h20000000
const BASS_SPEAKER_FRONTLEFT = BASS_SPEAKER_FRONT or BASS_SPEAKER_LEFT
const BASS_SPEAKER_FRONTRIGHT = BASS_SPEAKER_FRONT or BASS_SPEAKER_RIGHT
const BASS_SPEAKER_REARLEFT = BASS_SPEAKER_REAR or BASS_SPEAKER_LEFT
const BASS_SPEAKER_REARRIGHT = BASS_SPEAKER_REAR or BASS_SPEAKER_RIGHT
const BASS_SPEAKER_CENTER = BASS_SPEAKER_CENLFE or BASS_SPEAKER_LEFT
const BASS_SPEAKER_LFE = BASS_SPEAKER_CENLFE or BASS_SPEAKER_RIGHT
const BASS_SPEAKER_REAR2LEFT = BASS_SPEAKER_REAR2 or BASS_SPEAKER_LEFT
const BASS_SPEAKER_REAR2RIGHT = BASS_SPEAKER_REAR2 or BASS_SPEAKER_RIGHT
const BASS_ASYNCFILE = &h40000000
const BASS_UNICODE = &h80000000
const BASS_RECORD_PAUSE = &h8000
const BASS_RECORD_ECHOCANCEL = &h2000
const BASS_RECORD_AGC = &h4000
const BASS_VAM_HARDWARE = 1
const BASS_VAM_SOFTWARE = 2
const BASS_VAM_TERM_TIME = 4
const BASS_VAM_TERM_DIST = 8
const BASS_VAM_TERM_PRIO = 16

type BASS_CHANNELINFO
	freq as DWORD
	chans as DWORD
	flags as DWORD
	ctype as DWORD
	origres as DWORD
	plugin as HPLUGIN
	sample as HSAMPLE
	filename as const zstring ptr
end type

const BASS_ORIGRES_FLOAT = &h10000
const BASS_CTYPE_SAMPLE = 1
const BASS_CTYPE_RECORD = 2
const BASS_CTYPE_STREAM = &h10000
const BASS_CTYPE_STREAM_VORBIS = &h10002
const BASS_CTYPE_STREAM_OGG = &h10002
const BASS_CTYPE_STREAM_MP1 = &h10003
const BASS_CTYPE_STREAM_MP2 = &h10004
const BASS_CTYPE_STREAM_MP3 = &h10005
const BASS_CTYPE_STREAM_AIFF = &h10006
const BASS_CTYPE_STREAM_CA = &h10007
const BASS_CTYPE_STREAM_MF = &h10008
const BASS_CTYPE_STREAM_AM = &h10009
const BASS_CTYPE_STREAM_DUMMY = &h18000
const BASS_CTYPE_STREAM_DEVICE = &h18001
const BASS_CTYPE_STREAM_WAV = &h40000
const BASS_CTYPE_STREAM_WAV_PCM = &h50001
const BASS_CTYPE_STREAM_WAV_FLOAT = &h50003
const BASS_CTYPE_MUSIC_MOD = &h20000
const BASS_CTYPE_MUSIC_MTM = &h20001
const BASS_CTYPE_MUSIC_S3M = &h20002
const BASS_CTYPE_MUSIC_XM = &h20003
const BASS_CTYPE_MUSIC_IT = &h20004
const BASS_CTYPE_MUSIC_MO3 = &h00100

type BASS_PLUGINFORM
	ctype as DWORD
	name as const zstring ptr
	exts as const zstring ptr
end type

type BASS_PLUGININFO
	version as DWORD
	formatc as DWORD
	formats as const BASS_PLUGINFORM ptr
end type

type BASS_3DVECTOR
	x as single
	y as single
	z as single
end type

const BASS_3DMODE_NORMAL = 0
const BASS_3DMODE_RELATIVE = 1
const BASS_3DMODE_OFF = 2
const BASS_3DALG_DEFAULT = 0
const BASS_3DALG_OFF = 1
const BASS_3DALG_FULL = 2
const BASS_3DALG_LIGHT = 3

enum
	EAX_ENVIRONMENT_GENERIC
	EAX_ENVIRONMENT_PADDEDCELL
	EAX_ENVIRONMENT_ROOM
	EAX_ENVIRONMENT_BATHROOM
	EAX_ENVIRONMENT_LIVINGROOM
	EAX_ENVIRONMENT_STONEROOM
	EAX_ENVIRONMENT_AUDITORIUM
	EAX_ENVIRONMENT_CONCERTHALL
	EAX_ENVIRONMENT_CAVE
	EAX_ENVIRONMENT_ARENA
	EAX_ENVIRONMENT_HANGAR
	EAX_ENVIRONMENT_CARPETEDHALLWAY
	EAX_ENVIRONMENT_HALLWAY
	EAX_ENVIRONMENT_STONECORRIDOR
	EAX_ENVIRONMENT_ALLEY
	EAX_ENVIRONMENT_FOREST
	EAX_ENVIRONMENT_CITY
	EAX_ENVIRONMENT_MOUNTAINS
	EAX_ENVIRONMENT_QUARRY
	EAX_ENVIRONMENT_PLAIN
	EAX_ENVIRONMENT_PARKINGLOT
	EAX_ENVIRONMENT_SEWERPIPE
	EAX_ENVIRONMENT_UNDERWATER
	EAX_ENVIRONMENT_DRUGGED
	EAX_ENVIRONMENT_DIZZY
	EAX_ENVIRONMENT_PSYCHOTIC
	EAX_ENVIRONMENT_COUNT
end enum

#define EAX_PRESET_GENERIC EAX_ENVIRONMENT_GENERIC, 0.5f, 1.493f, 0.5f
#define EAX_PRESET_PADDEDCELL EAX_ENVIRONMENT_PADDEDCELL, 0.25f, 0.1f, 0.0f
#define EAX_PRESET_ROOM EAX_ENVIRONMENT_ROOM, 0.417f, 0.4f, 0.666f
#define EAX_PRESET_BATHROOM EAX_ENVIRONMENT_BATHROOM, 0.653f, 1.499f, 0.166f
#define EAX_PRESET_LIVINGROOM EAX_ENVIRONMENT_LIVINGROOM, 0.208f, 0.478f, 0.0f
#define EAX_PRESET_STONEROOM EAX_ENVIRONMENT_STONEROOM, 0.5f, 2.309f, 0.888f
#define EAX_PRESET_AUDITORIUM EAX_ENVIRONMENT_AUDITORIUM, 0.403f, 4.279f, 0.5f
#define EAX_PRESET_CONCERTHALL EAX_ENVIRONMENT_CONCERTHALL, 0.5f, 3.961f, 0.5f
#define EAX_PRESET_CAVE EAX_ENVIRONMENT_CAVE, 0.5f, 2.886f, 1.304f
#define EAX_PRESET_ARENA EAX_ENVIRONMENT_ARENA, 0.361f, 7.284f, 0.332f
#define EAX_PRESET_HANGAR EAX_ENVIRONMENT_HANGAR, 0.5f, 10.0f, 0.3f
#define EAX_PRESET_CARPETEDHALLWAY EAX_ENVIRONMENT_CARPETEDHALLWAY, 0.153f, 0.259f, 2.0f
#define EAX_PRESET_HALLWAY EAX_ENVIRONMENT_HALLWAY, 0.361f, 1.493f, 0.0f
#define EAX_PRESET_STONECORRIDOR EAX_ENVIRONMENT_STONECORRIDOR, 0.444f, 2.697f, 0.638f
#define EAX_PRESET_ALLEY EAX_ENVIRONMENT_ALLEY, 0.25f, 1.752f, 0.776f
#define EAX_PRESET_FOREST EAX_ENVIRONMENT_FOREST, 0.111f, 3.145f, 0.472f
#define EAX_PRESET_CITY EAX_ENVIRONMENT_CITY, 0.111f, 2.767f, 0.224f
#define EAX_PRESET_MOUNTAINS EAX_ENVIRONMENT_MOUNTAINS, 0.194f, 7.841f, 0.472f
#define EAX_PRESET_QUARRY EAX_ENVIRONMENT_QUARRY, 1.0f, 1.499f, 0.5f
#define EAX_PRESET_PLAIN EAX_ENVIRONMENT_PLAIN, 0.097f, 2.767f, 0.224f
#define EAX_PRESET_PARKINGLOT EAX_ENVIRONMENT_PARKINGLOT, 0.208f, 1.652f, 1.5f
#define EAX_PRESET_SEWERPIPE EAX_ENVIRONMENT_SEWERPIPE, 0.652f, 2.886f, 0.25f
#define EAX_PRESET_UNDERWATER EAX_ENVIRONMENT_UNDERWATER, 1.0f, 1.499f, 0.0f
#define EAX_PRESET_DRUGGED EAX_ENVIRONMENT_DRUGGED, 0.875f, 8.392f, 1.388f
#define EAX_PRESET_DIZZY EAX_ENVIRONMENT_DIZZY, 0.139f, 17.234f, 0.666f
#define EAX_PRESET_PSYCHOTIC EAX_ENVIRONMENT_PSYCHOTIC, 0.486f, 7.563f, 0.806f
const BASS_STREAMPROC_END = &h80000000
const STREAMPROC_DUMMY = cptr(function(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD, 0)
const STREAMPROC_PUSH = cptr(function(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD, -1)
const STREAMPROC_DEVICE = cptr(function(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD, -2)
const STREAMPROC_DEVICE_3D = cptr(function(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD, -3)
const STREAMFILE_NOBUFFER = 0
const STREAMFILE_BUFFER = 1
const STREAMFILE_BUFFERPUSH = 2

type BASS_FILEPROCS
	close as sub(byval user as any ptr)
	length as function(byval user as any ptr) as QWORD
	read as function(byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD
	seek as function(byval offset as QWORD, byval user as any ptr) as BOOL
end type

const BASS_FILEDATA_END = 0
const BASS_FILEPOS_CURRENT = 0
const BASS_FILEPOS_DECODE = BASS_FILEPOS_CURRENT
const BASS_FILEPOS_DOWNLOAD = 1
const BASS_FILEPOS_END = 2
const BASS_FILEPOS_START = 3
const BASS_FILEPOS_CONNECTED = 4
const BASS_FILEPOS_BUFFER = 5
const BASS_FILEPOS_SOCKET = 6
const BASS_FILEPOS_ASYNCBUF = 7
const BASS_FILEPOS_SIZE = 8
const BASS_FILEPOS_BUFFERING = 9
const BASS_SYNC_POS = 0
const BASS_SYNC_END = 2
const BASS_SYNC_META = 4
const BASS_SYNC_SLIDE = 5
const BASS_SYNC_STALL = 6
const BASS_SYNC_DOWNLOAD = 7
const BASS_SYNC_FREE = 8
const BASS_SYNC_SETPOS = 11
const BASS_SYNC_MUSICPOS = 10
const BASS_SYNC_MUSICINST = 1
const BASS_SYNC_MUSICFX = 3
const BASS_SYNC_OGG_CHANGE = 12
const BASS_SYNC_DEV_FAIL = 14
const BASS_SYNC_DEV_FORMAT = 15
const BASS_SYNC_THREAD = &h20000000
const BASS_SYNC_MIXTIME = &h40000000
const BASS_SYNC_ONETIME = &h80000000
const BASS_ACTIVE_STOPPED = 0
const BASS_ACTIVE_PLAYING = 1
const BASS_ACTIVE_STALLED = 2
const BASS_ACTIVE_PAUSED = 3
const BASS_ACTIVE_PAUSED_DEVICE = 4
const BASS_ATTRIB_FREQ = 1
const BASS_ATTRIB_VOL = 2
const BASS_ATTRIB_PAN = 3
const BASS_ATTRIB_EAXMIX = 4
const BASS_ATTRIB_NOBUFFER = 5
const BASS_ATTRIB_VBR = 6
const BASS_ATTRIB_CPU = 7
const BASS_ATTRIB_SRC = 8
const BASS_ATTRIB_NET_RESUME = 9
const BASS_ATTRIB_SCANINFO = 10
const BASS_ATTRIB_NORAMP = 11
const BASS_ATTRIB_BITRATE = 12
const BASS_ATTRIB_BUFFER = 13
const BASS_ATTRIB_GRANULE = 14
const BASS_ATTRIB_MUSIC_AMPLIFY = &h100
const BASS_ATTRIB_MUSIC_PANSEP = &h101
const BASS_ATTRIB_MUSIC_PSCALER = &h102
const BASS_ATTRIB_MUSIC_BPM = &h103
const BASS_ATTRIB_MUSIC_SPEED = &h104
const BASS_ATTRIB_MUSIC_VOL_GLOBAL = &h105
const BASS_ATTRIB_MUSIC_ACTIVE = &h106
const BASS_ATTRIB_MUSIC_VOL_CHAN = &h200
const BASS_ATTRIB_MUSIC_VOL_INST = &h300
const BASS_SLIDE_LOG = &h1000000
const BASS_DATA_AVAILABLE = 0
const BASS_DATA_FIXED = &h20000000
const BASS_DATA_FLOAT = &h40000000
const BASS_DATA_FFT256 = &h80000000
const BASS_DATA_FFT512 = &h80000001
const BASS_DATA_FFT1024 = &h80000002
const BASS_DATA_FFT2048 = &h80000003
const BASS_DATA_FFT4096 = &h80000004
const BASS_DATA_FFT8192 = &h80000005
const BASS_DATA_FFT16384 = &h80000006
const BASS_DATA_FFT32768 = &h80000007
const BASS_DATA_FFT_INDIVIDUAL = &h10
const BASS_DATA_FFT_NOWINDOW = &h20
const BASS_DATA_FFT_REMOVEDC = &h40
const BASS_DATA_FFT_COMPLEX = &h80
const BASS_DATA_FFT_NYQUIST = &h100
const BASS_LEVEL_MONO = 1
const BASS_LEVEL_STEREO = 2
const BASS_LEVEL_RMS = 4
const BASS_LEVEL_VOLPAN = 8
const BASS_TAG_ID3 = 0
const BASS_TAG_ID3V2 = 1
const BASS_TAG_OGG = 2
const BASS_TAG_HTTP = 3
const BASS_TAG_ICY = 4
const BASS_TAG_META = 5
const BASS_TAG_APE = 6
const BASS_TAG_MP4 = 7
const BASS_TAG_WMA = 8
const BASS_TAG_VENDOR = 9
const BASS_TAG_LYRICS3 = 10
const BASS_TAG_CA_CODEC = 11
const BASS_TAG_MF = 13
const BASS_TAG_WAVEFORMAT = 14
const BASS_TAG_AM_MIME = 15
const BASS_TAG_AM_NAME = 16
const BASS_TAG_RIFF_INFO = &h100
const BASS_TAG_RIFF_BEXT = &h101
const BASS_TAG_RIFF_CART = &h102
const BASS_TAG_RIFF_DISP = &h103
const BASS_TAG_RIFF_CUE = &h104
const BASS_TAG_RIFF_SMPL = &h105
const BASS_TAG_APE_BINARY = &h1000
const BASS_TAG_MUSIC_NAME = &h10000
const BASS_TAG_MUSIC_MESSAGE = &h10001
const BASS_TAG_MUSIC_ORDERS = &h10002
const BASS_TAG_MUSIC_AUTH = &h10003
const BASS_TAG_MUSIC_INST = &h10100
const BASS_TAG_MUSIC_SAMPLE = &h10300

type TAG_ID3
	id as zstring * 3
	title as zstring * 30
	artist as zstring * 30
	album as zstring * 30
	year as zstring * 4
	comment as zstring * 30
	genre as UBYTE
end type

type TAG_APE_BINARY
	key as const zstring ptr
	data as const any ptr
	length as DWORD
end type

type TAG_BEXT field = 1
	Description as zstring * 256
	Originator as zstring * 32
	OriginatorReference as zstring * 32
	OriginationDate as zstring * 10
	OriginationTime as zstring * 8
	TimeReference as QWORD
	Version as WORD
	UMID(0 to 63) as UBYTE
	Reserved(0 to 189) as UBYTE
	CodingHistory as zstring * 1
end type

type TAG_CART_TIMER
	dwUsage as DWORD
	dwValue as DWORD
end type

type TAG_CART
	Version as zstring * 4
	Title as zstring * 64
	Artist as zstring * 64
	CutID as zstring * 64
	ClientID as zstring * 64
	Category as zstring * 64
	Classification as zstring * 64
	OutCue as zstring * 64
	StartDate as zstring * 10
	StartTime as zstring * 8
	EndDate as zstring * 10
	EndTime as zstring * 8
	ProducerAppID as zstring * 64
	ProducerAppVersion as zstring * 64
	UserDef as zstring * 64
	dwLevelReference as DWORD
	PostTimer(0 to 7) as TAG_CART_TIMER
	Reserved as zstring * 276
	URL as zstring * 1024
	TagText as zstring * 1
end type

type TAG_CUE_POINT
	dwName as DWORD
	dwPosition as DWORD
	fccChunk as DWORD
	dwChunkStart as DWORD
	dwBlockStart as DWORD
	dwSampleOffset as DWORD
end type

type TAG_CUE
	dwCuePoints as DWORD
	CuePoints(0 to 1 - 1) as TAG_CUE_POINT
end type

type TAG_SMPL_LOOP
	dwIdentifier as DWORD
	dwType as DWORD
	dwStart as DWORD
	dwEnd as DWORD
	dwFraction as DWORD
	dwPlayCount as DWORD
end type

type TAG_SMPL
	dwManufacturer as DWORD
	dwProduct as DWORD
	dwSamplePeriod as DWORD
	dwMIDIUnityNote as DWORD
	dwMIDIPitchFraction as DWORD
	dwSMPTEFormat as DWORD
	dwSMPTEOffset as DWORD
	cSampleLoops as DWORD
	cbSamplerData as DWORD
	SampleLoops(0 to 1 - 1) as TAG_SMPL_LOOP
end type

type TAG_CA_CODEC
	ftype as DWORD
	atype as DWORD
	name as const zstring ptr
end type

#if defined(__FB_DOS__) or defined(__FB_UNIX__)
	#define _WAVEFORMATEX_

	type tWAVEFORMATEX field = 1
		wFormatTag as WORD
		nChannels as WORD
		nSamplesPerSec as DWORD
		nAvgBytesPerSec as DWORD
		nBlockAlign as WORD
		wBitsPerSample as WORD
		cbSize as WORD
	end type

	type WAVEFORMATEX as tWAVEFORMATEX
	type PWAVEFORMATEX as tWAVEFORMATEX ptr
	type LPWAVEFORMATEX as tWAVEFORMATEX ptr
	type LPCWAVEFORMATEX as const WAVEFORMATEX ptr
#endif

const BASS_POS_BYTE = 0
const BASS_POS_MUSIC_ORDER = 1
const BASS_POS_OGG = 3
const BASS_POS_RESET = &h2000000
const BASS_POS_RELATIVE = &h4000000
const BASS_POS_INEXACT = &h8000000
const BASS_POS_DECODE = &h10000000
const BASS_POS_DECODETO = &h20000000
const BASS_POS_SCAN = &h40000000
const BASS_NODEVICE = &h20000
const BASS_INPUT_OFF = &h10000
const BASS_INPUT_ON = &h20000
const BASS_INPUT_TYPE_MASK = &hff000000
const BASS_INPUT_TYPE_UNDEF = &h00000000
const BASS_INPUT_TYPE_DIGITAL = &h01000000
const BASS_INPUT_TYPE_LINE = &h02000000
const BASS_INPUT_TYPE_MIC = &h03000000
const BASS_INPUT_TYPE_SYNTH = &h04000000
const BASS_INPUT_TYPE_CD = &h05000000
const BASS_INPUT_TYPE_PHONE = &h06000000
const BASS_INPUT_TYPE_SPEAKER = &h07000000
const BASS_INPUT_TYPE_WAVE = &h08000000
const BASS_INPUT_TYPE_AUX = &h09000000
const BASS_INPUT_TYPE_ANALOG = &h0a000000
const BASS_FX_DX8_CHORUS = 0
const BASS_FX_DX8_COMPRESSOR = 1
const BASS_FX_DX8_DISTORTION = 2
const BASS_FX_DX8_ECHO = 3
const BASS_FX_DX8_FLANGER = 4
const BASS_FX_DX8_GARGLE = 5
const BASS_FX_DX8_I3DL2REVERB = 6
const BASS_FX_DX8_PARAMEQ = 7
const BASS_FX_DX8_REVERB = 8
const BASS_FX_VOLUME = 9

type BASS_DX8_CHORUS
	fWetDryMix as single
	fDepth as single
	fFeedback as single
	fFrequency as single
	lWaveform as DWORD
	fDelay as single
	lPhase as DWORD
end type

type BASS_DX8_COMPRESSOR
	fGain as single
	fAttack as single
	fRelease as single
	fThreshold as single
	fRatio as single
	fPredelay as single
end type

type BASS_DX8_DISTORTION
	fGain as single
	fEdge as single
	fPostEQCenterFrequency as single
	fPostEQBandwidth as single
	fPreLowpassCutoff as single
end type

type BASS_DX8_ECHO
	fWetDryMix as single
	fFeedback as single
	fLeftDelay as single
	fRightDelay as single
	lPanDelay as BOOL
end type

type BASS_DX8_FLANGER
	fWetDryMix as single
	fDepth as single
	fFeedback as single
	fFrequency as single
	lWaveform as DWORD
	fDelay as single
	lPhase as DWORD
end type

type BASS_DX8_GARGLE
	dwRateHz as DWORD
	dwWaveShape as DWORD
end type

type BASS_DX8_I3DL2REVERB
	lRoom as long
	lRoomHF as long
	flRoomRolloffFactor as single
	flDecayTime as single
	flDecayHFRatio as single
	lReflections as long
	flReflectionsDelay as single
	lReverb as long
	flReverbDelay as single
	flDiffusion as single
	flDensity as single
	flHFReference as single
end type

type BASS_DX8_PARAMEQ
	fCenter as single
	fBandwidth as single
	fGain as single
end type

type BASS_DX8_REVERB
	fInGain as single
	fReverbMix as single
	fReverbTime as single
	fHighFreqRTRatio as single
end type

const BASS_DX8_PHASE_NEG_180 = 0
const BASS_DX8_PHASE_NEG_90 = 1
const BASS_DX8_PHASE_ZERO = 2
const BASS_DX8_PHASE_90 = 3
const BASS_DX8_PHASE_180 = 4

type BASS_FX_VOLUME_PARAM
	fTarget as single
	fCurrent as single
	fTime as single
	lCurve as DWORD
end type

const BASS_IOSNOTIFY_INTERRUPT = 1
const BASS_IOSNOTIFY_INTERRUPT_END = 2
declare function BASS_SetConfig(byval option as DWORD, byval value as DWORD) as BOOL
declare function BASS_GetConfig(byval option as DWORD) as DWORD
declare function BASS_SetConfigPtr(byval option as DWORD, byval value as const any ptr) as BOOL
declare function BASS_GetConfigPtr(byval option as DWORD) as any ptr
declare function BASS_GetVersion() as DWORD
declare function BASS_ErrorGetCode() as long
declare function BASS_GetDeviceInfo(byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL

#ifdef __FB_WIN32__
	declare function BASS_Init(byval device as long, byval freq as DWORD, byval flags as DWORD, byval win as HWND, byval dsguid as const GUID ptr) as BOOL
#else
	declare function BASS_Init(byval device as long, byval freq as DWORD, byval flags as DWORD, byval win as any ptr, byval dsguid as any ptr) as BOOL
#endif

declare function BASS_SetDevice(byval device as DWORD) as BOOL
declare function BASS_GetDevice() as DWORD
declare function BASS_Free() as BOOL

#ifdef __FB_WIN32__
	declare function BASS_GetDSoundObject(byval object as DWORD) as any ptr
#endif

declare function BASS_GetInfo(byval info as BASS_INFO ptr) as BOOL
declare function BASS_Update(byval length as DWORD) as BOOL
declare function BASS_GetCPU() as single
declare function BASS_Start() as BOOL
declare function BASS_Stop() as BOOL
declare function BASS_Pause() as BOOL
declare function BASS_IsStarted() as BOOL
declare function BASS_SetVolume(byval volume as single) as BOOL
declare function BASS_GetVolume() as single
declare function BASS_PluginLoad(byval file as const zstring ptr, byval flags as DWORD) as HPLUGIN
declare function BASS_PluginFree(byval handle as HPLUGIN) as BOOL
declare function BASS_PluginGetInfo(byval handle as HPLUGIN) as const BASS_PLUGININFO ptr
declare function BASS_Set3DFactors(byval distf as single, byval rollf as single, byval doppf as single) as BOOL
declare function BASS_Get3DFactors(byval distf as single ptr, byval rollf as single ptr, byval doppf as single ptr) as BOOL
declare function BASS_Set3DPosition(byval pos as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr, byval front as const BASS_3DVECTOR ptr, byval top as const BASS_3DVECTOR ptr) as BOOL
declare function BASS_Get3DPosition(byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
declare sub BASS_Apply3D()

#ifdef __FB_WIN32__
	declare function BASS_SetEAXParameters(byval env as long, byval vol as single, byval decay as single, byval damp as single) as BOOL
	declare function BASS_GetEAXParameters(byval env as DWORD ptr, byval vol as single ptr, byval decay as single ptr, byval damp as single ptr) as BOOL
#endif

declare function BASS_MusicLoad(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval flags as DWORD, byval freq as DWORD) as HMUSIC
declare function BASS_MusicFree(byval handle as HMUSIC) as BOOL
declare function BASS_SampleLoad(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as DWORD, byval max as DWORD, byval flags as DWORD) as HSAMPLE
declare function BASS_SampleCreate(byval length as DWORD, byval freq as DWORD, byval chans as DWORD, byval max as DWORD, byval flags as DWORD) as HSAMPLE
declare function BASS_SampleFree(byval handle as HSAMPLE) as BOOL
declare function BASS_SampleSetData(byval handle as HSAMPLE, byval buffer as const any ptr) as BOOL
declare function BASS_SampleGetData(byval handle as HSAMPLE, byval buffer as any ptr) as BOOL
declare function BASS_SampleGetInfo(byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleSetInfo(byval handle as HSAMPLE, byval info as const BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleGetChannel(byval handle as HSAMPLE, byval onlynew as BOOL) as HCHANNEL
declare function BASS_SampleGetChannels(byval handle as HSAMPLE, byval channels as HCHANNEL ptr) as DWORD
declare function BASS_SampleStop(byval handle as HSAMPLE) as BOOL
declare function BASS_StreamCreate(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as function(byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD, byval user as any ptr) as DWORD, byval user as any ptr) as HSTREAM
declare function BASS_StreamCreateFile(byval mem as BOOL, byval file as const any ptr, byval offset as QWORD, byval length as QWORD, byval flags as DWORD) as HSTREAM
declare function BASS_StreamCreateURL(byval url as const zstring ptr, byval offset as DWORD, byval flags as DWORD, byval proc as sub(byval buffer as const any ptr, byval length as DWORD, byval user as any ptr), byval user as any ptr) as HSTREAM
declare function BASS_StreamCreateFileUser(byval system as DWORD, byval flags as DWORD, byval proc as const BASS_FILEPROCS ptr, byval user as any ptr) as HSTREAM
declare function BASS_StreamFree(byval handle as HSTREAM) as BOOL
declare function BASS_StreamGetFilePosition(byval handle as HSTREAM, byval mode as DWORD) as QWORD
declare function BASS_StreamPutData(byval handle as HSTREAM, byval buffer as const any ptr, byval length as DWORD) as DWORD
declare function BASS_StreamPutFileData(byval handle as HSTREAM, byval buffer as const any ptr, byval length as DWORD) as DWORD
declare function BASS_RecordGetDeviceInfo(byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL
declare function BASS_RecordInit(byval device as long) as BOOL
declare function BASS_RecordSetDevice(byval device as DWORD) as BOOL
declare function BASS_RecordGetDevice() as DWORD
declare function BASS_RecordFree() as BOOL
declare function BASS_RecordGetInfo(byval info as BASS_RECORDINFO ptr) as BOOL
declare function BASS_RecordGetInputName(byval input as long) as const zstring ptr
declare function BASS_RecordSetInput(byval input as long, byval flags as DWORD, byval volume as single) as BOOL
declare function BASS_RecordGetInput(byval input as long, byval volume as single ptr) as DWORD
declare function BASS_RecordStart(byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as function(byval handle as HRECORD, byval buffer as const any ptr, byval length as DWORD, byval user as any ptr) as BOOL, byval user as any ptr) as HRECORD
declare function BASS_ChannelBytes2Seconds(byval handle as DWORD, byval pos as QWORD) as double
declare function BASS_ChannelSeconds2Bytes(byval handle as DWORD, byval pos as double) as QWORD
declare function BASS_ChannelGetDevice(byval handle as DWORD) as DWORD
declare function BASS_ChannelSetDevice(byval handle as DWORD, byval device as DWORD) as BOOL
declare function BASS_ChannelIsActive(byval handle as DWORD) as DWORD
declare function BASS_ChannelGetInfo(byval handle as DWORD, byval info as BASS_CHANNELINFO ptr) as BOOL
declare function BASS_ChannelGetTags(byval handle as DWORD, byval tags as DWORD) as const zstring ptr
declare function BASS_ChannelFlags(byval handle as DWORD, byval flags as DWORD, byval mask as DWORD) as DWORD
declare function BASS_ChannelUpdate(byval handle as DWORD, byval length as DWORD) as BOOL
declare function BASS_ChannelLock(byval handle as DWORD, byval lock as BOOL) as BOOL
declare function BASS_ChannelPlay(byval handle as DWORD, byval restart as BOOL) as BOOL
declare function BASS_ChannelStop(byval handle as DWORD) as BOOL
declare function BASS_ChannelPause(byval handle as DWORD) as BOOL
declare function BASS_ChannelSetAttribute(byval handle as DWORD, byval attrib as DWORD, byval value as single) as BOOL
declare function BASS_ChannelGetAttribute(byval handle as DWORD, byval attrib as DWORD, byval value as single ptr) as BOOL
declare function BASS_ChannelSlideAttribute(byval handle as DWORD, byval attrib as DWORD, byval value as single, byval time as DWORD) as BOOL
declare function BASS_ChannelIsSliding(byval handle as DWORD, byval attrib as DWORD) as BOOL
declare function BASS_ChannelSetAttributeEx(byval handle as DWORD, byval attrib as DWORD, byval value as any ptr, byval size as DWORD) as BOOL
declare function BASS_ChannelGetAttributeEx(byval handle as DWORD, byval attrib as DWORD, byval value as any ptr, byval size as DWORD) as DWORD
declare function BASS_ChannelSet3DAttributes(byval handle as DWORD, byval mode as long, byval min as single, byval max as single, byval iangle as long, byval oangle as long, byval outvol as single) as BOOL
declare function BASS_ChannelGet3DAttributes(byval handle as DWORD, byval mode as DWORD ptr, byval min as single ptr, byval max as single ptr, byval iangle as DWORD ptr, byval oangle as DWORD ptr, byval outvol as single ptr) as BOOL
declare function BASS_ChannelSet3DPosition(byval handle as DWORD, byval pos as const BASS_3DVECTOR ptr, byval orient as const BASS_3DVECTOR ptr, byval vel as const BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGet3DPosition(byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGetLength(byval handle as DWORD, byval mode as DWORD) as QWORD
declare function BASS_ChannelSetPosition(byval handle as DWORD, byval pos as QWORD, byval mode as DWORD) as BOOL
declare function BASS_ChannelGetPosition(byval handle as DWORD, byval mode as DWORD) as QWORD
declare function BASS_ChannelGetLevel(byval handle as DWORD) as DWORD
declare function BASS_ChannelGetLevelEx(byval handle as DWORD, byval levels as single ptr, byval length as single, byval flags as DWORD) as BOOL
declare function BASS_ChannelGetData(byval handle as DWORD, byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASS_ChannelSetSync(byval handle as DWORD, byval type as DWORD, byval param as QWORD, byval proc as sub(byval handle as HSYNC, byval channel as DWORD, byval data as DWORD, byval user as any ptr), byval user as any ptr) as HSYNC
declare function BASS_ChannelRemoveSync(byval handle as DWORD, byval sync as HSYNC) as BOOL
declare function BASS_ChannelSetDSP(byval handle as DWORD, byval proc as sub(byval handle as HDSP, byval channel as DWORD, byval buffer as any ptr, byval length as DWORD, byval user as any ptr), byval user as any ptr, byval priority as long) as HDSP
declare function BASS_ChannelRemoveDSP(byval handle as DWORD, byval dsp as HDSP) as BOOL
declare function BASS_ChannelSetLink(byval handle as DWORD, byval chan as DWORD) as BOOL
declare function BASS_ChannelRemoveLink(byval handle as DWORD, byval chan as DWORD) as BOOL
declare function BASS_ChannelSetFX(byval handle as DWORD, byval type as DWORD, byval priority as long) as HFX
declare function BASS_ChannelRemoveFX(byval handle as DWORD, byval fx as HFX) as BOOL
declare function BASS_FXSetParameters(byval handle as HFX, byval params as const any ptr) as BOOL
declare function BASS_FXGetParameters(byval handle as HFX, byval params as any ptr) as BOOL
declare function BASS_FXReset(byval handle as HFX) as BOOL
declare function BASS_FXSetPriority(byval handle as HFX, byval priority as long) as BOOL

end extern
