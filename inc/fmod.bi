''
''
'' fmod -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __fmod_bi__
#define __fmod_bi__

#inclib "fmod"

#define FMOD_VERSION 3.74f

type FSOUND_SAMPLE as any
type FSOUND_STREAM as any
type FSOUND_DSPUNIT as any
type FSOUND_SYNCPOINT as any
type FMUSIC_MODULE as any

type FSOUND_OPENCALLBACK as function (byval as zstring ptr) as any ptr
type FSOUND_CLOSECALLBACK as sub (byval as any ptr)
type FSOUND_READCALLBACK as function (byval as any ptr, byval as integer, byval as any ptr) as integer
type FSOUND_SEEKCALLBACK as function (byval as any ptr, byval as integer, byval as byte) as integer
type FSOUND_TELLCALLBACK as function (byval as any ptr) as integer
type FSOUND_ALLOCCALLBACK as function (byval as uinteger) as any ptr
type FSOUND_REALLOCCALLBACK as function (byval as any ptr, byval as uinteger) as any ptr
type FSOUND_FREECALLBACK as sub (byval as any ptr)
type FSOUND_DSPCALLBACK as function (byval as any ptr, byval as any ptr, byval as integer, byval as any ptr) as any ptr
type FSOUND_STREAMCALLBACK as function (byval as FSOUND_STREAM ptr, byval as any ptr, byval as integer, byval as any ptr) as byte
type FSOUND_METADATACALLBACK as function (byval as zstring ptr, byval as zstring ptr, byval as any ptr) as byte
type FMUSIC_CALLBACK as sub (byval as FMUSIC_MODULE ptr, byval as ubyte)

enum FMOD_ERRORS
	FMOD_ERR_NONE
	FMOD_ERR_BUSY
	FMOD_ERR_UNINITIALIZED
	FMOD_ERR_INIT
	FMOD_ERR_ALLOCATED
	FMOD_ERR_PLAY
	FMOD_ERR_OUTPUT_FORMAT
	FMOD_ERR_COOPERATIVELEVEL
	FMOD_ERR_CREATEBUFFER
	FMOD_ERR_FILE_NOTFOUND
	FMOD_ERR_FILE_FORMAT
	FMOD_ERR_FILE_BAD
	FMOD_ERR_MEMORY
	FMOD_ERR_VERSION
	FMOD_ERR_INVALID_PARAM
	FMOD_ERR_NO_EAX
	FMOD_ERR_CHANNEL_ALLOC
	FMOD_ERR_RECORD
	FMOD_ERR_MEDIAPLAYER
	FMOD_ERR_CDDEVICE
end enum

enum FSOUND_OUTPUTTYPES
	FSOUND_OUTPUT_NOSOUND
	FSOUND_OUTPUT_WINMM
	FSOUND_OUTPUT_DSOUND
	FSOUND_OUTPUT_A3D
	FSOUND_OUTPUT_OSS
	FSOUND_OUTPUT_ESD
	FSOUND_OUTPUT_ALSA
	FSOUND_OUTPUT_ASIO
	FSOUND_OUTPUT_XBOX
	FSOUND_OUTPUT_PS2
	FSOUND_OUTPUT_MAC
	FSOUND_OUTPUT_GC
	FSOUND_OUTPUT_NOSOUND_NONREALTIME
end enum

enum FSOUND_MIXERTYPES
	FSOUND_MIXER_AUTODETECT
	FSOUND_MIXER_BLENDMODE
	FSOUND_MIXER_MMXP5
	FSOUND_MIXER_MMXP6
	FSOUND_MIXER_QUALITY_AUTODETECT
	FSOUND_MIXER_QUALITY_FPU
	FSOUND_MIXER_QUALITY_MMXP5
	FSOUND_MIXER_QUALITY_MMXP6
	FSOUND_MIXER_MONO
	FSOUND_MIXER_QUALITY_MONO
	FSOUND_MIXER_MAX
end enum

enum FMUSIC_TYPES
	FMUSIC_TYPE_NONE
	FMUSIC_TYPE_MOD
	FMUSIC_TYPE_S3M
	FMUSIC_TYPE_XM
	FMUSIC_TYPE_IT
	FMUSIC_TYPE_MIDI
	FMUSIC_TYPE_FSB
end enum

#define FSOUND_DSP_DEFAULTPRIORITY_CLEARUNIT 0
#define FSOUND_DSP_DEFAULTPRIORITY_SFXUNIT 100
#define FSOUND_DSP_DEFAULTPRIORITY_MUSICUNIT 200
#define FSOUND_DSP_DEFAULTPRIORITY_USER 300
#define FSOUND_DSP_DEFAULTPRIORITY_FFTUNIT 900
#define FSOUND_DSP_DEFAULTPRIORITY_CLIPANDCOPYUNIT 1000
#define FSOUND_CAPS_HARDWARE &h1
#define FSOUND_CAPS_EAX2 &h2
#define FSOUND_CAPS_EAX3 &h10
#define FSOUND_LOOP_OFF &h00000001
#define FSOUND_LOOP_NORMAL &h00000002
#define FSOUND_LOOP_BIDI &h00000004
#define FSOUND_8BITS &h00000008
#define FSOUND_16BITS &h00000010
#define FSOUND_MONO &h00000020
#define FSOUND_STEREO &h00000040
#define FSOUND_UNSIGNED &h00000080
#define FSOUND_SIGNED &h00000100
#define FSOUND_DELTA &h00000200
#define FSOUND_IT214 &h00000400
#define FSOUND_IT215 &h00000800
#define FSOUND_HW3D &h00001000
#define FSOUND_2D &h00002000
#define FSOUND_STREAMABLE &h00004000
#define FSOUND_LOADMEMORY &h00008000
#define FSOUND_LOADRAW &h00010000
#define FSOUND_MPEGACCURATE &h00020000
#define FSOUND_FORCEMONO &h00040000
#define FSOUND_HW2D &h00080000
#define FSOUND_ENABLEFX &h00100000
#define FSOUND_MPEGHALFRATE &h00200000
#define FSOUND_IMAADPCM &h00400000
#define FSOUND_VAG &h00800000
#define FSOUND_NONBLOCKING &h01000000
#define FSOUND_GCADPCM &h02000000
#define FSOUND_MULTICHANNEL &h04000000
#define FSOUND_USECORE0 &h08000000
#define FSOUND_USECORE1 &h10000000
#define FSOUND_LOADMEMORYIOP &h20000000
#define FSOUND_IGNORETAGS &h40000000
#define FSOUND_STREAM_NET &h80000000
#define FSOUND_NORMAL (&h00000010 or &h00000100 or &h00000020)

#define FSOUND_CD_PLAYCONTINUOUS 0
#define FSOUND_CD_PLAYONCE 1
#define FSOUND_CD_PLAYLOOPED 2
#define FSOUND_CD_PLAYRANDOM 3
#define FSOUND_FREE -1
#define FSOUND_UNMANAGED -2
#define FSOUND_ALL -3
#define FSOUND_STEREOPAN -1
#define FSOUND_SYSTEMCHANNEL -1000
#define FSOUND_SYSTEMSAMPLE -1000

#define FSOUND_PRESET_OFF              (0,	7.5f,	1.00f, -10000, -10000, 0,   1.00f,  1.00f, 1.0f,  -2602, 0.007f, { 0.0f,0.0f,0.0f },   200, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,   0.0f,   0.0f, &h33f )
#define FSOUND_PRESET_GENERIC          (0,	7.5f,	1.00f, -1000,  -100,   0,   1.49f,  0.83f, 1.0f,  -2602, 0.007f, { 0.0f,0.0f,0.0f },   200, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_PADDEDCELL       (1,	1.4f,	1.00f, -1000,  -6000,  0,   0.17f,  0.10f, 1.0f,  -1204, 0.001f, { 0.0f,0.0f,0.0f },   207, 0.002f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_ROOM 	           (2,	1.9f,	1.00f, -1000,  -454,   0,   0.40f,  0.83f, 1.0f,  -1646, 0.002f, { 0.0f,0.0f,0.0f },    53, 0.003f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_BATHROOM 	       (3,	1.4f,	1.00f, -1000,  -1200,  0,   1.49f,  0.54f, 1.0f,   -370, 0.007f, { 0.0f,0.0f,0.0f },  1030, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f,  60.0f, &h3f )
#define FSOUND_PRESET_LIVINGROOM       (4,	2.5f,	1.00f, -1000,  -6000,  0,   0.50f,  0.10f, 1.0f,  -1376, 0.003f, { 0.0f,0.0f,0.0f }, -1104, 0.004f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_STONEROOM        (5,	11.6f,	1.00f, -1000,  -300,   0,   2.31f,  0.64f, 1.0f,   -711, 0.012f, { 0.0f,0.0f,0.0f },    83, 0.017f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_AUDITORIUM       (6,	21.6f,	1.00f, -1000,  -476,   0,   4.32f,  0.59f, 1.0f,   -789, 0.020f, { 0.0f,0.0f,0.0f },  -289, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_CONCERTHALL      (7,	19.6f,	1.00f, -1000,  -500,   0,   3.92f,  0.70f, 1.0f,  -1230, 0.020f, { 0.0f,0.0f,0.0f },    -2, 0.029f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_CAVE             (8,	14.6f,	1.00f, -1000,  0,      0,   2.91f,  1.30f, 1.0f,   -602, 0.015f, { 0.0f,0.0f,0.0f },  -302, 0.022f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h1f )
#define FSOUND_PRESET_ARENA            (9,	36.2f,	1.00f, -1000,  -698,   0,   7.24f,  0.33f, 1.0f,  -1166, 0.020f, { 0.0f,0.0f,0.0f },    16, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_HANGAR           (10,	50.3f,	1.00f, -1000,  -1000,  0,   10.05f, 0.23f, 1.0f,   -602, 0.020f, { 0.0f,0.0f,0.0f },   198, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_CARPETTEDHALLWAY (11,	1.9f,	1.00f, -1000,  -4000,  0,   0.30f,  0.10f, 1.0f,  -1831, 0.002f, { 0.0f,0.0f,0.0f }, -1630, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_HALLWAY          (12,	1.8f,	1.00f, -1000,  -300,   0,   1.49f,  0.59f, 1.0f,  -1219, 0.007f, { 0.0f,0.0f,0.0f },   441, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_STONECORRIDOR    (13,	13.5f,	1.00f, -1000,  -237,   0,   2.70f,  0.79f, 1.0f,  -1214, 0.013f, { 0.0f,0.0f,0.0f },   395, 0.020f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_ALLEY 	       (14,	7.5f,	0.30f, -1000,  -270,   0,   1.49f,  0.86f, 1.0f,  -1204, 0.007f, { 0.0f,0.0f,0.0f },    -4, 0.011f, { 0.0f,0.0f,0.0f }, 0.125f, 0.95f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_FOREST 	       (15,	38.0f,	0.30f, -1000,  -3300,  0,   1.49f,  0.54f, 1.0f,  -2560, 0.162f, { 0.0f,0.0f,0.0f },  -229, 0.088f, { 0.0f,0.0f,0.0f }, 0.125f, 1.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,  79.0f, 100.0f, &h3f )
#define FSOUND_PRESET_CITY             (16,	7.5f,	0.50f, -1000,  -800,   0,   1.49f,  0.67f, 1.0f,  -2273, 0.007f, { 0.0f,0.0f,0.0f }, -1691, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,  50.0f, 100.0f, &h3f )
#define FSOUND_PRESET_MOUNTAINS        (17,	100.0f, 0.27f, -1000,  -2500,  0,   1.49f,  0.21f, 1.0f,  -2780, 0.300f, { 0.0f,0.0f,0.0f }, -1434, 0.100f, { 0.0f,0.0f,0.0f }, 0.250f, 1.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,  27.0f, 100.0f, &h1f )
#define FSOUND_PRESET_QUARRY           (18,	17.5f,	1.00f, -1000,  -1000,  0,   1.49f,  0.83f, 1.0f, -10000, 0.061f, { 0.0f,0.0f,0.0f },   500, 0.025f, { 0.0f,0.0f,0.0f }, 0.125f, 0.70f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_PLAIN            (19,	42.5f,	0.21f, -1000,  -2000,  0,   1.49f,  0.50f, 1.0f,  -2466, 0.179f, { 0.0f,0.0f,0.0f }, -1926, 0.100f, { 0.0f,0.0f,0.0f }, 0.250f, 1.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,  21.0f, 100.0f, &h3f )
#define FSOUND_PRESET_PARKINGLOT       (20,	8.3f,	1.00f, -1000,  0,      0,   1.65f,  1.50f, 1.0f,  -1363, 0.008f, { 0.0f,0.0f,0.0f }, -1153, 0.012f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h1f )
#define FSOUND_PRESET_SEWERPIPE        (21,	1.7f,	0.80f, -1000,  -1000,  0,   2.81f,  0.14f, 1.0f,    429, 0.014f, { 0.0f,0.0f,0.0f },  1023, 0.021f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 0.000f, -5.0f, 5000.0f, 250.0f, 0.0f,  80.0f,  60.0f, &h3f )
#define FSOUND_PRESET_UNDERWATER       (22,	1.8f,	1.00f, -1000,  -4000,  0,   1.49f,  0.10f, 1.0f,   -449, 0.007f, { 0.0f,0.0f,0.0f },  1700, 0.011f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 1.18f, 0.348f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h3f )
#define FSOUND_PRESET_DRUGGED          (23,	1.9f,	0.50f, -1000,  0,      0,   8.39f,  1.39f, 1.0f,  -115,  0.002f, { 0.0f,0.0f,0.0f },   985, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 0.25f, 1.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h1f )
#define FSOUND_PRESET_DIZZY            (24,	1.8f,	0.60f, -1000,  -400,   0,   17.23f, 0.56f, 1.0f,  -1713, 0.020f, { 0.0f,0.0f,0.0f },  -613, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 1.00f, 0.81f, 0.310f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h1f )
#define FSOUND_PRESET_PSYCHOTIC        (25,	1.0f,	0.50f, -1000,  -151,   0,   7.56f,  0.91f, 1.0f,  -626,  0.020f, { 0.0f,0.0f,0.0f },   774, 0.030f, { 0.0f,0.0f,0.0f }, 0.250f, 0.00f, 4.00f, 1.000f, -5.0f, 5000.0f, 250.0f, 0.0f, 100.0f, 100.0f, &h1f )
#define FSOUND_PRESET_PS2_ROOM         (1,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_STUDIO_A     (2,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_STUDIO_B     (3,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_STUDIO_C     (4,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_HALL         (5,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_SPACE        (6,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_ECHO         (7,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_DELAY        (8,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )
#define FSOUND_PRESET_PS2_PIPE         (9,	0,	    0,         0,  0,      0,   0.0f,   0.0f,  0.0f,     0,  0.000f, { 0.0f,0.0f,0.0f },     0, 0.000f, { 0.0f,0.0f,0.0f }, 0.000f, 0.00f, 0.00f, 0.000f,  0.0f, 0000.0f,   0.0f, 0.0f,   0.0f,   0.0f, &h31f )

type FSOUND_REVERB_PROPERTIES
	Environment as uinteger
	EnvSize as single
	EnvDiffusion as single
	Room as integer
	RoomHF as integer
	RoomLF as integer
	DecayTime as single
	DecayHFRatio as single
	DecayLFRatio as single
	Reflections as integer
	ReflectionsDelay as single
	ReflectionsPan(0 to 3-1) as single
	Reverb as integer
	ReverbDelay as single
	ReverbPan(0 to 3-1) as single
	EchoTime as single
	EchoDepth as single
	ModulationTime as single
	ModulationDepth as single
	AirAbsorptionHF as single
	HFReference as single
	LFReference as single
	RoomRolloffFactor as single
	Diffusion as single
	Density as single
	Flags as uinteger
end type

#define FSOUND_REVERB_FLAGS_DECAYTIMESCALE &h00000001
#define FSOUND_REVERB_FLAGS_REFLECTIONSSCALE &h00000002
#define FSOUND_REVERB_FLAGS_REFLECTIONSDELAYSCALE &h00000004
#define FSOUND_REVERB_FLAGS_REVERBSCALE &h00000008
#define FSOUND_REVERB_FLAGS_REVERBDELAYSCALE &h00000010
#define FSOUND_REVERB_FLAGS_DECAYHFLIMIT &h00000020
#define FSOUND_REVERB_FLAGS_ECHOTIMESCALE &h00000040
#define FSOUND_REVERB_FLAGS_MODULATIONTIMESCALE &h00000080
#define FSOUND_REVERB_FLAGS_CORE0 &h00000100
#define FSOUND_REVERB_FLAGS_CORE1 &h00000200
#define FSOUND_REVERB_FLAGS_DEFAULT (&h00000001 or &h00000002 or &h00000004 or &h00000008 or &h00000010 or &h00000020 or &h00000100 or &h00000200)


type FSOUND_REVERB_CHANNELPROPERTIES
	Direct as integer
	DirectHF as integer
	Room as integer
	RoomHF as integer
	Obstruction as integer
	ObstructionLFRatio as single
	Occlusion as integer
	OcclusionLFRatio as single
	OcclusionRoomRatio as single
	OcclusionDirectRatio as single
	Exclusion as integer
	ExclusionLFRatio as single
	OutsideVolumeHF as integer
	DopplerFactor as single
	RolloffFactor as single
	RoomRolloffFactor as single
	AirAbsorptionFactor as single
	Flags as integer
end type

#define FSOUND_REVERB_CHANNELFLAGS_DIRECTHFAUTO &h00000001
#define FSOUND_REVERB_CHANNELFLAGS_ROOMAUTO &h00000002
#define FSOUND_REVERB_CHANNELFLAGS_ROOMHFAUTO &h00000004
#define FSOUND_REVERB_CHANNELFLAGS_DEFAULT (&h00000001 or &h00000002 or &h00000004)

enum FSOUND_FX_MODES
	FSOUND_FX_CHORUS
	FSOUND_FX_COMPRESSOR
	FSOUND_FX_DISTORTION
	FSOUND_FX_ECHO
	FSOUND_FX_FLANGER
	FSOUND_FX_GARGLE
	FSOUND_FX_I3DL2REVERB
	FSOUND_FX_PARAMEQ
	FSOUND_FX_WAVES_REVERB
	FSOUND_FX_MAX
end enum

enum FSOUND_SPEAKERMODES
	FSOUND_SPEAKERMODE_DOLBYDIGITAL
	FSOUND_SPEAKERMODE_HEADPHONES
	FSOUND_SPEAKERMODE_MONO
	FSOUND_SPEAKERMODE_QUAD
	FSOUND_SPEAKERMODE_STEREO
	FSOUND_SPEAKERMODE_SURROUND
	FSOUND_SPEAKERMODE_DTS
	FSOUND_SPEAKERMODE_PROLOGIC2
	FSOUND_SPEAKERMODE_PROLOGIC2_INTERIOR
end enum

#define FSOUND_INIT_USEDEFAULTMIDISYNTH &h0001
#define FSOUND_INIT_GLOBALFOCUS &h0002
#define FSOUND_INIT_ENABLESYSTEMCHANNELFX &h0004
#define FSOUND_INIT_ACCURATEVULEVELS &h0008
#define FSOUND_INIT_PS2_DISABLECORE0REVERB &h0010
#define FSOUND_INIT_PS2_DISABLECORE1REVERB &h0020
#define FSOUND_INIT_PS2_SWAPDMACORES &h0040
#define FSOUND_INIT_DONTLATENCYADJUST &h0080
#define FSOUND_INIT_GC_INITLIBS &h0100
#define FSOUND_INIT_STREAM_FROM_MAIN_THREAD &h0200
#define FSOUND_INIT_PS2_USEVOLUMERAMPING &h0400
#define FSOUND_INIT_DSOUND_DEFERRED &h0800
#define FSOUND_INIT_DSOUND_HRTF_LIGHT &h1000
#define FSOUND_INIT_DSOUND_HRTF_FULL &h2000

enum FSOUND_STREAM_NET_STATUS
	FSOUND_STREAM_NET_NOTCONNECTED = 0
	FSOUND_STREAM_NET_CONNECTING
	FSOUND_STREAM_NET_BUFFERING
	FSOUND_STREAM_NET_READY
	FSOUND_STREAM_NET_ERROR
end enum

enum FSOUND_TAGFIELD_TYPE
	FSOUND_TAGFIELD_VORBISCOMMENT = 0
	FSOUND_TAGFIELD_ID3V1
	FSOUND_TAGFIELD_ID3V2
	FSOUND_TAGFIELD_SHOUTCAST
	FSOUND_TAGFIELD_ICECAST
	FSOUND_TAGFIELD_ASF
end enum

#define FSOUND_PROTOCOL_SHOUTCAST &h00000001
#define FSOUND_PROTOCOL_ICECAST &h00000002
#define FSOUND_PROTOCOL_HTTP &h00000004
#define FSOUND_FORMAT_MPEG &h00010000
#define FSOUND_FORMAT_OGGVORBIS &h00020000

type FSOUND_TOC_TAG
	name(0 to 4-1) as byte
	numtracks as integer
	min(0 to 100-1) as integer
	sec(0 to 100-1) as integer
	frame(0 to 100-1) as integer
end type

declare function FSOUND_SetOutput alias "FSOUND_SetOutput" (byval outputtype as integer) as byte
declare function FSOUND_SetDriver alias "FSOUND_SetDriver" (byval driver as integer) as byte
declare function FSOUND_SetMixer alias "FSOUND_SetMixer" (byval mixer as integer) as byte
declare function FSOUND_SetBufferSize alias "FSOUND_SetBufferSize" (byval len_ms as integer) as byte
declare function FSOUND_SetHWND alias "FSOUND_SetHWND" (byval hwnd as any ptr) as byte
declare function FSOUND_SetMinHardwareChannels alias "FSOUND_SetMinHardwareChannels" (byval min as integer) as byte
declare function FSOUND_SetMaxHardwareChannels alias "FSOUND_SetMaxHardwareChannels" (byval max as integer) as byte
declare function FSOUND_SetMemorySystem alias "FSOUND_SetMemorySystem" (byval pool as any ptr, byval poollen as integer, byval useralloc as FSOUND_ALLOCCALLBACK, byval userrealloc as FSOUND_REALLOCCALLBACK, byval userfree as FSOUND_FREECALLBACK) as byte
declare function FSOUND_Init alias "FSOUND_Init" (byval mixrate as integer, byval maxsoftwarechannels as integer, byval flags as uinteger) as byte
declare sub FSOUND_Close alias "FSOUND_Close" ()
declare sub FSOUND_Update alias "FSOUND_Update" ()
declare sub FSOUND_SetSpeakerMode alias "FSOUND_SetSpeakerMode" (byval speakermode as uinteger)
declare sub FSOUND_SetSFXMasterVolume alias "FSOUND_SetSFXMasterVolume" (byval volume as integer)
declare sub FSOUND_SetPanSeperation alias "FSOUND_SetPanSeperation" (byval pansep as single)
declare sub FSOUND_File_SetCallbacks alias "FSOUND_File_SetCallbacks" (byval useropen as FSOUND_OPENCALLBACK, byval userclose as FSOUND_CLOSECALLBACK, byval userread as FSOUND_READCALLBACK, byval userseek as FSOUND_SEEKCALLBACK, byval usertell as FSOUND_TELLCALLBACK)
declare function FSOUND_GetError alias "FSOUND_GetError" () as integer
declare function FSOUND_GetVersion alias "FSOUND_GetVersion" () as single
declare function FSOUND_GetOutput alias "FSOUND_GetOutput" () as integer
declare function FSOUND_GetOutputHandle alias "FSOUND_GetOutputHandle" () as any ptr
declare function FSOUND_GetDriver alias "FSOUND_GetDriver" () as integer
declare function FSOUND_GetMixer alias "FSOUND_GetMixer" () as integer
declare function FSOUND_GetNumDrivers alias "FSOUND_GetNumDrivers" () as integer
declare function FSOUND_GetDriverName alias "FSOUND_GetDriverName" (byval id as integer) as zstring ptr
declare function FSOUND_GetDriverCaps alias "FSOUND_GetDriverCaps" (byval id as integer, byval caps as uinteger ptr) as byte
declare function FSOUND_GetOutputRate alias "FSOUND_GetOutputRate" () as integer
declare function FSOUND_GetMaxChannels alias "FSOUND_GetMaxChannels" () as integer
declare function FSOUND_GetMaxSamples alias "FSOUND_GetMaxSamples" () as integer
declare function FSOUND_GetSFXMasterVolume alias "FSOUND_GetSFXMasterVolume" () as integer
declare function FSOUND_GetNumHWChannels alias "FSOUND_GetNumHWChannels" (byval num2d as integer ptr, byval num3d as integer ptr, byval total as integer ptr) as byte
declare function FSOUND_GetChannelsPlaying alias "FSOUND_GetChannelsPlaying" () as integer
declare function FSOUND_GetCPUUsage alias "FSOUND_GetCPUUsage" () as single
declare sub FSOUND_GetMemoryStats alias "FSOUND_GetMemoryStats" (byval currentalloced as uinteger ptr, byval maxalloced as uinteger ptr)
declare function FSOUND_Sample_Load alias "FSOUND_Sample_Load" (byval index as integer, byval name_or_data as zstring ptr, byval mode as uinteger, byval offset as integer, byval length as integer) as FSOUND_SAMPLE ptr
declare function FSOUND_Sample_Alloc alias "FSOUND_Sample_Alloc" (byval index as integer, byval length as integer, byval mode as uinteger, byval deffreq as integer, byval defvol as integer, byval defpan as integer, byval defpri as integer) as FSOUND_SAMPLE ptr
declare sub FSOUND_Sample_Free alias "FSOUND_Sample_Free" (byval sptr as FSOUND_SAMPLE ptr)
declare function FSOUND_Sample_Upload alias "FSOUND_Sample_Upload" (byval sptr as FSOUND_SAMPLE ptr, byval srcdata as any ptr, byval mode as uinteger) as byte
declare function FSOUND_Sample_Lock alias "FSOUND_Sample_Lock" (byval sptr as FSOUND_SAMPLE ptr, byval offset as integer, byval length as integer, byval ptr1 as any ptr ptr, byval ptr2 as any ptr ptr, byval len1 as uinteger ptr, byval len2 as uinteger ptr) as byte
declare function FSOUND_Sample_Unlock alias "FSOUND_Sample_Unlock" (byval sptr as FSOUND_SAMPLE ptr, byval ptr1 as any ptr, byval ptr2 as any ptr, byval len1 as uinteger, byval len2 as uinteger) as byte
declare function FSOUND_Sample_SetMode alias "FSOUND_Sample_SetMode" (byval sptr as FSOUND_SAMPLE ptr, byval mode as uinteger) as byte
declare function FSOUND_Sample_SetLoopPoints alias "FSOUND_Sample_SetLoopPoints" (byval sptr as FSOUND_SAMPLE ptr, byval loopstart as integer, byval loopend as integer) as byte
declare function FSOUND_Sample_SetDefaults alias "FSOUND_Sample_SetDefaults" (byval sptr as FSOUND_SAMPLE ptr, byval deffreq as integer, byval defvol as integer, byval defpan as integer, byval defpri as integer) as byte
declare function FSOUND_Sample_SetDefaultsEx alias "FSOUND_Sample_SetDefaultsEx" (byval sptr as FSOUND_SAMPLE ptr, byval deffreq as integer, byval defvol as integer, byval defpan as integer, byval defpri as integer, byval varfreq as integer, byval varvol as integer, byval varpan as integer) as byte
declare function FSOUND_Sample_SetMinMaxDistance alias "FSOUND_Sample_SetMinMaxDistance" (byval sptr as FSOUND_SAMPLE ptr, byval min as single, byval max as single) as byte
declare function FSOUND_Sample_SetMaxPlaybacks alias "FSOUND_Sample_SetMaxPlaybacks" (byval sptr as FSOUND_SAMPLE ptr, byval max as integer) as byte
declare function FSOUND_Sample_Get alias "FSOUND_Sample_Get" (byval sampno as integer) as FSOUND_SAMPLE ptr
declare function FSOUND_Sample_GetName alias "FSOUND_Sample_GetName" (byval sptr as FSOUND_SAMPLE ptr) as zstring ptr
declare function FSOUND_Sample_GetLength alias "FSOUND_Sample_GetLength" (byval sptr as FSOUND_SAMPLE ptr) as uinteger
declare function FSOUND_Sample_GetLoopPoints alias "FSOUND_Sample_GetLoopPoints" (byval sptr as FSOUND_SAMPLE ptr, byval loopstart as integer ptr, byval loopend as integer ptr) as byte
declare function FSOUND_Sample_GetDefaults alias "FSOUND_Sample_GetDefaults" (byval sptr as FSOUND_SAMPLE ptr, byval deffreq as integer ptr, byval defvol as integer ptr, byval defpan as integer ptr, byval defpri as integer ptr) as byte
declare function FSOUND_Sample_GetDefaultsEx alias "FSOUND_Sample_GetDefaultsEx" (byval sptr as FSOUND_SAMPLE ptr, byval deffreq as integer ptr, byval defvol as integer ptr, byval defpan as integer ptr, byval defpri as integer ptr, byval varfreq as integer ptr, byval varvol as integer ptr, byval varpan as integer ptr) as byte
declare function FSOUND_Sample_GetMode alias "FSOUND_Sample_GetMode" (byval sptr as FSOUND_SAMPLE ptr) as uinteger
declare function FSOUND_Sample_GetMinMaxDistance alias "FSOUND_Sample_GetMinMaxDistance" (byval sptr as FSOUND_SAMPLE ptr, byval min as single ptr, byval max as single ptr) as byte
declare function FSOUND_PlaySound alias "FSOUND_PlaySound" (byval channel as integer, byval sptr as FSOUND_SAMPLE ptr) as integer
declare function FSOUND_PlaySoundEx alias "FSOUND_PlaySoundEx" (byval channel as integer, byval sptr as FSOUND_SAMPLE ptr, byval dsp as FSOUND_DSPUNIT ptr, byval startpaused as byte) as integer
declare function FSOUND_StopSound alias "FSOUND_StopSound" (byval channel as integer) as byte
declare function FSOUND_SetFrequency alias "FSOUND_SetFrequency" (byval channel as integer, byval freq as integer) as byte
declare function FSOUND_SetVolume alias "FSOUND_SetVolume" (byval channel as integer, byval vol as integer) as byte
declare function FSOUND_SetVolumeAbsolute alias "FSOUND_SetVolumeAbsolute" (byval channel as integer, byval vol as integer) as byte
declare function FSOUND_SetPan alias "FSOUND_SetPan" (byval channel as integer, byval pan as integer) as byte
declare function FSOUND_SetSurround alias "FSOUND_SetSurround" (byval channel as integer, byval surround as byte) as byte
declare function FSOUND_SetMute alias "FSOUND_SetMute" (byval channel as integer, byval mute as byte) as byte
declare function FSOUND_SetPriority alias "FSOUND_SetPriority" (byval channel as integer, byval priority as integer) as byte
declare function FSOUND_SetReserved alias "FSOUND_SetReserved" (byval channel as integer, byval reserved as byte) as byte
declare function FSOUND_SetPaused alias "FSOUND_SetPaused" (byval channel as integer, byval paused as byte) as byte
declare function FSOUND_SetLoopMode alias "FSOUND_SetLoopMode" (byval channel as integer, byval loopmode as uinteger) as byte
declare function FSOUND_SetCurrentPosition alias "FSOUND_SetCurrentPosition" (byval channel as integer, byval offset as uinteger) as byte
declare function FSOUND_3D_SetAttributes alias "FSOUND_3D_SetAttributes" (byval channel as integer, byval pos as single ptr, byval vel as single ptr) as byte
declare function FSOUND_3D_SetMinMaxDistance alias "FSOUND_3D_SetMinMaxDistance" (byval channel as integer, byval min as single, byval max as single) as byte
declare function FSOUND_IsPlaying alias "FSOUND_IsPlaying" (byval channel as integer) as byte
declare function FSOUND_GetFrequency alias "FSOUND_GetFrequency" (byval channel as integer) as integer
declare function FSOUND_GetVolume alias "FSOUND_GetVolume" (byval channel as integer) as integer
declare function FSOUND_GetAmplitude alias "FSOUND_GetAmplitude" (byval channel as integer) as integer
declare function FSOUND_GetPan alias "FSOUND_GetPan" (byval channel as integer) as integer
declare function FSOUND_GetSurround alias "FSOUND_GetSurround" (byval channel as integer) as byte
declare function FSOUND_GetMute alias "FSOUND_GetMute" (byval channel as integer) as byte
declare function FSOUND_GetPriority alias "FSOUND_GetPriority" (byval channel as integer) as integer
declare function FSOUND_GetReserved alias "FSOUND_GetReserved" (byval channel as integer) as byte
declare function FSOUND_GetPaused alias "FSOUND_GetPaused" (byval channel as integer) as byte
declare function FSOUND_GetLoopMode alias "FSOUND_GetLoopMode" (byval channel as integer) as uinteger
declare function FSOUND_GetCurrentPosition alias "FSOUND_GetCurrentPosition" (byval channel as integer) as uinteger
declare function FSOUND_GetCurrentSample alias "FSOUND_GetCurrentSample" (byval channel as integer) as FSOUND_SAMPLE ptr
declare function FSOUND_GetCurrentLevels alias "FSOUND_GetCurrentLevels" (byval channel as integer, byval l as single ptr, byval r as single ptr) as byte
declare function FSOUND_GetNumSubChannels alias "FSOUND_GetNumSubChannels" (byval channel as integer) as integer
declare function FSOUND_GetSubChannel alias "FSOUND_GetSubChannel" (byval channel as integer, byval subchannel as integer) as integer
declare function FSOUND_3D_GetAttributes alias "FSOUND_3D_GetAttributes" (byval channel as integer, byval pos as single ptr, byval vel as single ptr) as byte
declare function FSOUND_3D_GetMinMaxDistance alias "FSOUND_3D_GetMinMaxDistance" (byval channel as integer, byval min as single ptr, byval max as single ptr) as byte
declare sub FSOUND_3D_Listener_SetAttributes alias "FSOUND_3D_Listener_SetAttributes" (byval pos as single ptr, byval vel as single ptr, byval fx as single, byval fy as single, byval fz as single, byval tx as single, byval ty as single, byval tz as single)
declare sub FSOUND_3D_Listener_GetAttributes alias "FSOUND_3D_Listener_GetAttributes" (byval pos as single ptr, byval vel as single ptr, byval fx as single ptr, byval fy as single ptr, byval fz as single ptr, byval tx as single ptr, byval ty as single ptr, byval tz as single ptr)
declare sub FSOUND_3D_Listener_SetCurrent alias "FSOUND_3D_Listener_SetCurrent" (byval current as integer, byval numlisteners as integer)
declare sub FSOUND_3D_SetDopplerFactor alias "FSOUND_3D_SetDopplerFactor" (byval scale as single)
declare sub FSOUND_3D_SetDistanceFactor alias "FSOUND_3D_SetDistanceFactor" (byval scale as single)
declare sub FSOUND_3D_SetRolloffFactor alias "FSOUND_3D_SetRolloffFactor" (byval scale as single)
declare function FSOUND_FX_Enable alias "FSOUND_FX_Enable" (byval channel as integer, byval fxtype as uinteger) as integer
declare function FSOUND_FX_Disable alias "FSOUND_FX_Disable" (byval channel as integer) as byte
declare function FSOUND_FX_SetChorus alias "FSOUND_FX_SetChorus" (byval fxid as integer, byval WetDryMix as single, byval Depth as single, byval Feedback as single, byval Frequency as single, byval Waveform as integer, byval Delay as single, byval Phase as integer) as byte
declare function FSOUND_FX_SetCompressor alias "FSOUND_FX_SetCompressor" (byval fxid as integer, byval Gain as single, byval Attack as single, byval Release as single, byval Threshold as single, byval Ratio as single, byval Predelay as single) as byte
declare function FSOUND_FX_SetDistortion alias "FSOUND_FX_SetDistortion" (byval fxid as integer, byval Gain as single, byval Edge as single, byval PostEQCenterFrequency as single, byval PostEQBandwidth as single, byval PreLowpassCutoff as single) as byte
declare function FSOUND_FX_SetEcho alias "FSOUND_FX_SetEcho" (byval fxid as integer, byval WetDryMix as single, byval Feedback as single, byval LeftDelay as single, byval RightDelay as single, byval PanDelay as integer) as byte
declare function FSOUND_FX_SetFlanger alias "FSOUND_FX_SetFlanger" (byval fxid as integer, byval WetDryMix as single, byval Depth as single, byval Feedback as single, byval Frequency as single, byval Waveform as integer, byval Delay as single, byval Phase as integer) as byte
declare function FSOUND_FX_SetGargle alias "FSOUND_FX_SetGargle" (byval fxid as integer, byval RateHz as integer, byval WaveShape as integer) as byte
declare function FSOUND_FX_SetI3DL2Reverb alias "FSOUND_FX_SetI3DL2Reverb" (byval fxid as integer, byval Room as integer, byval RoomHF as integer, byval RoomRolloffFactor as single, byval DecayTime as single, byval DecayHFRatio as single, byval Reflections as integer, byval ReflectionsDelay as single, byval Reverb as integer, byval ReverbDelay as single, byval Diffusion as single, byval Density as single, byval HFReference as single) as byte
declare function FSOUND_FX_SetParamEQ alias "FSOUND_FX_SetParamEQ" (byval fxid as integer, byval Center as single, byval Bandwidth as single, byval Gain as single) as byte
declare function FSOUND_FX_SetWavesReverb alias "FSOUND_FX_SetWavesReverb" (byval fxid as integer, byval InGain as single, byval ReverbMix as single, byval ReverbTime as single, byval HighFreqRTRatio as single) as byte
declare function FSOUND_Stream_SetBufferSize alias "FSOUND_Stream_SetBufferSize" (byval ms as integer) as byte
declare function FSOUND_Stream_Open alias "FSOUND_Stream_Open" (byval name_or_data as zstring ptr, byval mode as uinteger, byval offset as integer, byval length as integer) as FSOUND_STREAM ptr
declare function FSOUND_Stream_Create alias "FSOUND_Stream_Create" (byval callback as FSOUND_STREAMCALLBACK, byval length as integer, byval mode as uinteger, byval samplerate as integer, byval userdata as any ptr) as FSOUND_STREAM ptr
declare function FSOUND_Stream_Close alias "FSOUND_Stream_Close" (byval stream as FSOUND_STREAM ptr) as byte
declare function FSOUND_Stream_Play alias "FSOUND_Stream_Play" (byval channel as integer, byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_PlayEx alias "FSOUND_Stream_PlayEx" (byval channel as integer, byval stream as FSOUND_STREAM ptr, byval dsp as FSOUND_DSPUNIT ptr, byval startpaused as byte) as integer
declare function FSOUND_Stream_Stop alias "FSOUND_Stream_Stop" (byval stream as FSOUND_STREAM ptr) as byte
declare function FSOUND_Stream_SetPosition alias "FSOUND_Stream_SetPosition" (byval stream as FSOUND_STREAM ptr, byval position as uinteger) as byte
declare function FSOUND_Stream_GetPosition alias "FSOUND_Stream_GetPosition" (byval stream as FSOUND_STREAM ptr) as uinteger
declare function FSOUND_Stream_SetTime alias "FSOUND_Stream_SetTime" (byval stream as FSOUND_STREAM ptr, byval ms as integer) as byte
declare function FSOUND_Stream_GetTime alias "FSOUND_Stream_GetTime" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_GetLength alias "FSOUND_Stream_GetLength" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_GetLengthMs alias "FSOUND_Stream_GetLengthMs" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_SetMode alias "FSOUND_Stream_SetMode" (byval stream as FSOUND_STREAM ptr, byval mode as uinteger) as byte
declare function FSOUND_Stream_GetMode alias "FSOUND_Stream_GetMode" (byval stream as FSOUND_STREAM ptr) as uinteger
declare function FSOUND_Stream_SetLoopPoints alias "FSOUND_Stream_SetLoopPoints" (byval stream as FSOUND_STREAM ptr, byval loopstartpcm as uinteger, byval loopendpcm as uinteger) as byte
declare function FSOUND_Stream_SetLoopCount alias "FSOUND_Stream_SetLoopCount" (byval stream as FSOUND_STREAM ptr, byval count as integer) as byte
declare function FSOUND_Stream_GetOpenState alias "FSOUND_Stream_GetOpenState" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_GetSample alias "FSOUND_Stream_GetSample" (byval stream as FSOUND_STREAM ptr) as FSOUND_SAMPLE ptr
declare function FSOUND_Stream_CreateDSP alias "FSOUND_Stream_CreateDSP" (byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_DSPCALLBACK, byval priority as integer, byval userdata as any ptr) as FSOUND_DSPUNIT ptr
declare function FSOUND_Stream_SetEndCallback alias "FSOUND_Stream_SetEndCallback" (byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_STREAMCALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_SetSyncCallback alias "FSOUND_Stream_SetSyncCallback" (byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_STREAMCALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_AddSyncPoint alias "FSOUND_Stream_AddSyncPoint" (byval stream as FSOUND_STREAM ptr, byval pcmoffset as uinteger, byval name as zstring ptr) as FSOUND_SYNCPOINT ptr
declare function FSOUND_Stream_DeleteSyncPoint alias "FSOUND_Stream_DeleteSyncPoint" (byval point as FSOUND_SYNCPOINT ptr) as byte
declare function FSOUND_Stream_GetNumSyncPoints alias "FSOUND_Stream_GetNumSyncPoints" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_GetSyncPoint alias "FSOUND_Stream_GetSyncPoint" (byval stream as FSOUND_STREAM ptr, byval index as integer) as FSOUND_SYNCPOINT ptr
declare function FSOUND_Stream_GetSyncPointInfo alias "FSOUND_Stream_GetSyncPointInfo" (byval point as FSOUND_SYNCPOINT ptr, byval pcmoffset as uinteger ptr) as zstring ptr
declare function FSOUND_Stream_SetSubStream alias "FSOUND_Stream_SetSubStream" (byval stream as FSOUND_STREAM ptr, byval index as integer) as byte
declare function FSOUND_Stream_GetNumSubStreams alias "FSOUND_Stream_GetNumSubStreams" (byval stream as FSOUND_STREAM ptr) as integer
declare function FSOUND_Stream_SetSubStreamSentence alias "FSOUND_Stream_SetSubStreamSentence" (byval stream as FSOUND_STREAM ptr, byval sentencelist as integer ptr, byval numitems as integer) as byte
declare function FSOUND_Stream_GetNumTagFields alias "FSOUND_Stream_GetNumTagFields" (byval stream as FSOUND_STREAM ptr, byval num as integer ptr) as byte
declare function FSOUND_Stream_GetTagField alias "FSOUND_Stream_GetTagField" (byval stream as FSOUND_STREAM ptr, byval num as integer, byval type as integer ptr, byval name as byte ptr ptr, byval value as any ptr ptr, byval length as integer ptr) as byte
declare function FSOUND_Stream_FindTagField alias "FSOUND_Stream_FindTagField" (byval stream as FSOUND_STREAM ptr, byval type as integer, byval name as zstring ptr, byval value as any ptr ptr, byval length as integer ptr) as byte
declare function FSOUND_Stream_Net_SetProxy alias "FSOUND_Stream_Net_SetProxy" (byval proxy as zstring ptr) as byte
declare function FSOUND_Stream_Net_GetLastServerStatus alias "FSOUND_Stream_Net_GetLastServerStatus" () as zstring ptr
declare function FSOUND_Stream_Net_SetBufferProperties alias "FSOUND_Stream_Net_SetBufferProperties" (byval buffersize as integer, byval prebuffer_percent as integer, byval rebuffer_percent as integer) as byte
declare function FSOUND_Stream_Net_GetBufferProperties alias "FSOUND_Stream_Net_GetBufferProperties" (byval buffersize as integer ptr, byval prebuffer_percent as integer ptr, byval rebuffer_percent as integer ptr) as byte
declare function FSOUND_Stream_Net_SetMetadataCallback alias "FSOUND_Stream_Net_SetMetadataCallback" (byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_METADATACALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_Net_GetStatus alias "FSOUND_Stream_Net_GetStatus" (byval stream as FSOUND_STREAM ptr, byval status as integer ptr, byval bufferpercentused as integer ptr, byval bitrate as integer ptr, byval flags as uinteger ptr) as byte
declare function FSOUND_CD_Play alias "FSOUND_CD_Play" (byval drive as byte, byval track as integer) as byte
declare sub FSOUND_CD_SetPlayMode alias "FSOUND_CD_SetPlayMode" (byval drive as byte, byval mode as byte)
declare function FSOUND_CD_Stop alias "FSOUND_CD_Stop" (byval drive as byte) as byte
declare function FSOUND_CD_SetPaused alias "FSOUND_CD_SetPaused" (byval drive as byte, byval paused as byte) as byte
declare function FSOUND_CD_SetVolume alias "FSOUND_CD_SetVolume" (byval drive as byte, byval volume as integer) as byte
declare function FSOUND_CD_SetTrackTime alias "FSOUND_CD_SetTrackTime" (byval drive as byte, byval ms as uinteger) as byte
declare function FSOUND_CD_OpenTray alias "FSOUND_CD_OpenTray" (byval drive as byte, byval open as byte) as byte
declare function FSOUND_CD_GetPaused alias "FSOUND_CD_GetPaused" (byval drive as byte) as byte
declare function FSOUND_CD_GetTrack alias "FSOUND_CD_GetTrack" (byval drive as byte) as integer
declare function FSOUND_CD_GetNumTracks alias "FSOUND_CD_GetNumTracks" (byval drive as byte) as integer
declare function FSOUND_CD_GetVolume alias "FSOUND_CD_GetVolume" (byval drive as byte) as integer
declare function FSOUND_CD_GetTrackLength alias "FSOUND_CD_GetTrackLength" (byval drive as byte, byval track as integer) as integer
declare function FSOUND_CD_GetTrackTime alias "FSOUND_CD_GetTrackTime" (byval drive as byte) as integer
declare function FSOUND_DSP_Create alias "FSOUND_DSP_Create" (byval callback as FSOUND_DSPCALLBACK, byval priority as integer, byval userdata as any ptr) as FSOUND_DSPUNIT ptr
declare sub FSOUND_DSP_Free alias "FSOUND_DSP_Free" (byval unit as FSOUND_DSPUNIT ptr)
declare sub FSOUND_DSP_SetPriority alias "FSOUND_DSP_SetPriority" (byval unit as FSOUND_DSPUNIT ptr, byval priority as integer)
declare function FSOUND_DSP_GetPriority alias "FSOUND_DSP_GetPriority" (byval unit as FSOUND_DSPUNIT ptr) as integer
declare sub FSOUND_DSP_SetActive alias "FSOUND_DSP_SetActive" (byval unit as FSOUND_DSPUNIT ptr, byval active as byte)
declare function FSOUND_DSP_GetActive alias "FSOUND_DSP_GetActive" (byval unit as FSOUND_DSPUNIT ptr) as byte
declare function FSOUND_DSP_GetClearUnit alias "FSOUND_DSP_GetClearUnit" () as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetSFXUnit alias "FSOUND_DSP_GetSFXUnit" () as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetMusicUnit alias "FSOUND_DSP_GetMusicUnit" () as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetFFTUnit alias "FSOUND_DSP_GetFFTUnit" () as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetClipAndCopyUnit alias "FSOUND_DSP_GetClipAndCopyUnit" () as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_MixBuffers alias "FSOUND_DSP_MixBuffers" (byval destbuffer as any ptr, byval srcbuffer as any ptr, byval len as integer, byval freq as integer, byval vol as integer, byval pan as integer, byval mode as uinteger) as byte
declare sub FSOUND_DSP_ClearMixBuffer alias "FSOUND_DSP_ClearMixBuffer" ()
declare function FSOUND_DSP_GetBufferLength alias "FSOUND_DSP_GetBufferLength" () as integer
declare function FSOUND_DSP_GetBufferLengthTotal alias "FSOUND_DSP_GetBufferLengthTotal" () as integer
declare function FSOUND_DSP_GetSpectrum alias "FSOUND_DSP_GetSpectrum" () as single ptr
declare function FSOUND_Reverb_SetProperties alias "FSOUND_Reverb_SetProperties" (byval prop as FSOUND_REVERB_PROPERTIES ptr) as byte
declare function FSOUND_Reverb_GetProperties alias "FSOUND_Reverb_GetProperties" (byval prop as FSOUND_REVERB_PROPERTIES ptr) as byte
declare function FSOUND_Reverb_SetChannelProperties alias "FSOUND_Reverb_SetChannelProperties" (byval channel as integer, byval prop as FSOUND_REVERB_CHANNELPROPERTIES ptr) as byte
declare function FSOUND_Reverb_GetChannelProperties alias "FSOUND_Reverb_GetChannelProperties" (byval channel as integer, byval prop as FSOUND_REVERB_CHANNELPROPERTIES ptr) as byte
declare function FSOUND_Record_SetDriver alias "FSOUND_Record_SetDriver" (byval outputtype as integer) as byte
declare function FSOUND_Record_GetNumDrivers alias "FSOUND_Record_GetNumDrivers" () as integer
declare function FSOUND_Record_GetDriverName alias "FSOUND_Record_GetDriverName" (byval id as integer) as zstring ptr
declare function FSOUND_Record_GetDriver alias "FSOUND_Record_GetDriver" () as integer
declare function FSOUND_Record_StartSample alias "FSOUND_Record_StartSample" (byval sptr as FSOUND_SAMPLE ptr, byval loop as byte) as byte
declare function FSOUND_Record_Stop alias "FSOUND_Record_Stop" () as byte
declare function FSOUND_Record_GetPosition alias "FSOUND_Record_GetPosition" () as integer
declare function FMUSIC_LoadSong alias "FMUSIC_LoadSong" (byval name as zstring ptr) as FMUSIC_MODULE ptr
declare function FMUSIC_LoadSongEx alias "FMUSIC_LoadSongEx" (byval name_or_data as zstring ptr, byval offset as integer, byval length as integer, byval mode as uinteger, byval samplelist as integer ptr, byval samplelistnum as integer) as FMUSIC_MODULE ptr
declare function FMUSIC_GetOpenState alias "FMUSIC_GetOpenState" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_FreeSong alias "FMUSIC_FreeSong" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_PlaySong alias "FMUSIC_PlaySong" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_StopSong alias "FMUSIC_StopSong" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare sub FMUSIC_StopAllSongs alias "FMUSIC_StopAllSongs" ()
declare function FMUSIC_SetZxxCallback alias "FMUSIC_SetZxxCallback" (byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK) as byte
declare function FMUSIC_SetRowCallback alias "FMUSIC_SetRowCallback" (byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval rowstep as integer) as byte
declare function FMUSIC_SetOrderCallback alias "FMUSIC_SetOrderCallback" (byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval orderstep as integer) as byte
declare function FMUSIC_SetInstCallback alias "FMUSIC_SetInstCallback" (byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval instrument as integer) as byte
declare function FMUSIC_SetSample alias "FMUSIC_SetSample" (byval mod_ as FMUSIC_MODULE ptr, byval sampno as integer, byval sptr as FSOUND_SAMPLE ptr) as byte
declare function FMUSIC_SetUserData alias "FMUSIC_SetUserData" (byval mod_ as FMUSIC_MODULE ptr, byval userdata as any ptr) as byte
declare function FMUSIC_OptimizeChannels alias "FMUSIC_OptimizeChannels" (byval mod_ as FMUSIC_MODULE ptr, byval maxchannels as integer, byval minvolume as integer) as byte
declare function FMUSIC_SetReverb alias "FMUSIC_SetReverb" (byval reverb as byte) as byte
declare function FMUSIC_SetLooping alias "FMUSIC_SetLooping" (byval mod_ as FMUSIC_MODULE ptr, byval looping as byte) as byte
declare function FMUSIC_SetOrder alias "FMUSIC_SetOrder" (byval mod_ as FMUSIC_MODULE ptr, byval order as integer) as byte
declare function FMUSIC_SetPaused alias "FMUSIC_SetPaused" (byval mod_ as FMUSIC_MODULE ptr, byval pause as byte) as byte
declare function FMUSIC_SetMasterVolume alias "FMUSIC_SetMasterVolume" (byval mod_ as FMUSIC_MODULE ptr, byval volume as integer) as byte
declare function FMUSIC_SetMasterSpeed alias "FMUSIC_SetMasterSpeed" (byval mode as FMUSIC_MODULE ptr, byval speed as single) as byte
declare function FMUSIC_SetPanSeperation alias "FMUSIC_SetPanSeperation" (byval mod_ as FMUSIC_MODULE ptr, byval pansep as single) as byte
declare function FMUSIC_GetName alias "FMUSIC_GetName" (byval mod_ as FMUSIC_MODULE ptr) as zstring ptr
declare function FMUSIC_GetType alias "FMUSIC_GetType" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetNumOrders alias "FMUSIC_GetNumOrders" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetNumPatterns alias "FMUSIC_GetNumPatterns" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetNumInstruments alias "FMUSIC_GetNumInstruments" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetNumSamples alias "FMUSIC_GetNumSamples" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetNumChannels alias "FMUSIC_GetNumChannels" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetSample alias "FMUSIC_GetSample" (byval mod_ as FMUSIC_MODULE ptr, byval sampno as integer) as FSOUND_SAMPLE ptr
declare function FMUSIC_GetPatternLength alias "FMUSIC_GetPatternLength" (byval mod_ as FMUSIC_MODULE ptr, byval orderno as integer) as integer
declare function FMUSIC_IsFinished alias "FMUSIC_IsFinished" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_IsPlaying alias "FMUSIC_IsPlaying" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_GetMasterVolume alias "FMUSIC_GetMasterVolume" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetGlobalVolume alias "FMUSIC_GetGlobalVolume" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetOrder alias "FMUSIC_GetOrder" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetPattern alias "FMUSIC_GetPattern" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetSpeed alias "FMUSIC_GetSpeed" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetBPM alias "FMUSIC_GetBPM" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetRow alias "FMUSIC_GetRow" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetPaused alias "FMUSIC_GetPaused" (byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_GetTime alias "FMUSIC_GetTime" (byval mod_ as FMUSIC_MODULE ptr) as integer
declare function FMUSIC_GetRealChannel alias "FMUSIC_GetRealChannel" (byval mod_ as FMUSIC_MODULE ptr, byval modchannel as integer) as integer
declare function FMUSIC_GetUserData alias "FMUSIC_GetUserData" (byval mod_ as FMUSIC_MODULE ptr) as any ptr

private function FSOUND_GetErrorString (byval errcode as integer) as string
    select case errcode
    case FMOD_ERR_NONE:             function = "No errors"
    case FMOD_ERR_BUSY:             function = "Cannot call this command after FSOUND_Init.  Call FSOUND_Close first."
    case FMOD_ERR_UNINITIALIZED:    function = "This command failed because FSOUND_Init was not called"
    case FMOD_ERR_PLAY:             function = "Playing the sound failed."
    case FMOD_ERR_INIT:             function = "Error initializing output device."
    case FMOD_ERR_ALLOCATED:        function = "The output device is already in use and cannot be reused."
    case FMOD_ERR_OUTPUT_FORMAT:    function = "Soundcard does not support the features needed for this soundsystem (16bit stereo output)"
    case FMOD_ERR_COOPERATIVELEVEL: function = "Error setting cooperative level for hardware."
    case FMOD_ERR_CREATEBUFFER:     function = "Error creating hardware sound buffer."
    case FMOD_ERR_FILE_NOTFOUND:    function = "File not found"
    case FMOD_ERR_FILE_FORMAT:      function = "Unknown file format"
    case FMOD_ERR_FILE_BAD:         function = "Error loading file"
    case FMOD_ERR_MEMORY:           function = "Not enough memory "
    case FMOD_ERR_VERSION:          function = "The version number of this file format is not supported"
    case FMOD_ERR_INVALID_PARAM:    function = "An invalid parameter was passed to this function"
    case FMOD_ERR_NO_EAX:           function = "Tried to use an EAX command on a non EAX enabled channel or output."
    case FMOD_ERR_CHANNEL_ALLOC:    function = "Failed to allocate a new channel"
    case FMOD_ERR_RECORD:           function = "Recording is not supported on this machine"
    case FMOD_ERR_MEDIAPLAYER:      function = "Required Mediaplayer codec is not installed"
    case FMOD_ERR_CDDEVICE:         function = "An error occured trying to open the specified CD device"
    case else:                      function = "Unknown error"
    end select
end function

#endif
