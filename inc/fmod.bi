'' FMOD 3.75
#pragma once
#inclib "fmod"

#ifdef __FB_WIN32__
	extern "Windows"
#else
	extern "C"
#endif

type FSOUND_SAMPLE as FSOUND_SAMPLE_
type FSOUND_STREAM as FSOUND_STREAM_
type FMUSIC_MODULE as FMUSIC_MODULE_
type FSOUND_DSPUNIT as FSOUND_DSPUNIT_
type FSOUND_SYNCPOINT as FSOUND_SYNCPOINT_

#define FMOD_VERSION 3.75f

type FSOUND_OPENCALLBACK as function(byval name_ as const zstring ptr) as any ptr
type FSOUND_CLOSECALLBACK as sub(byval handle as any ptr)
type FSOUND_READCALLBACK as function(byval buffer as any ptr, byval size as long, byval handle as any ptr) as long
type FSOUND_SEEKCALLBACK as function(byval handle as any ptr, byval pos_ as long, byval mode as byte) as long
type FSOUND_TELLCALLBACK as function(byval handle as any ptr) as long
type FSOUND_ALLOCCALLBACK as function(byval size as ulong) as any ptr
type FSOUND_REALLOCCALLBACK as function(byval ptr_ as any ptr, byval size as ulong) as any ptr
type FSOUND_FREECALLBACK as sub(byval ptr_ as any ptr)
type FSOUND_DSPCALLBACK as function(byval originalbuffer as any ptr, byval newbuffer as any ptr, byval length as long, byval userdata as any ptr) as any ptr
type FSOUND_STREAMCALLBACK as function(byval stream as FSOUND_STREAM ptr, byval buff as any ptr, byval len_ as long, byval userdata as any ptr) as byte
type FSOUND_METADATACALLBACK as function(byval name_ as zstring ptr, byval value as zstring ptr, byval userdata as any ptr) as byte
type FMUSIC_CALLBACK as sub(byval mod_ as FMUSIC_MODULE ptr, byval param as ubyte)

type FMOD_ERRORS as long
enum
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

type FSOUND_OUTPUTTYPES as long
enum
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
	FSOUND_OUTPUT_PSP
	FSOUND_OUTPUT_NOSOUND_NONREALTIME
end enum

type FSOUND_MIXERTYPES as long
enum
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

type FMUSIC_TYPES as long
enum
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
#define FSOUND_NORMAL ((FSOUND_16BITS or FSOUND_SIGNED) or FSOUND_MONO)
#define FSOUND_CD_PLAYCONTINUOUS 0
#define FSOUND_CD_PLAYONCE 1
#define FSOUND_CD_PLAYLOOPED 2
#define FSOUND_CD_PLAYRANDOM 3
#define FSOUND_FREE (-1)
#define FSOUND_UNMANAGED (-2)
#define FSOUND_ALL (-3)
#define FSOUND_STEREOPAN (-1)
#define FSOUND_SYSTEMCHANNEL (-1000)
#define FSOUND_SYSTEMSAMPLE (-1000)

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

type _FSOUND_REVERB_PROPERTIES
	Environment as ulong
	EnvSize as single
	EnvDiffusion as single
	Room as long
	RoomHF as long
	RoomLF as long
	DecayTime as single
	DecayHFRatio as single
	DecayLFRatio as single
	Reflections as long
	ReflectionsDelay as single
	ReflectionsPan(0 to 2) as single
	Reverb as long
	ReverbDelay as single
	ReverbPan(0 to 2) as single
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
	Flags as ulong
end type

type FSOUND_REVERB_PROPERTIES as _FSOUND_REVERB_PROPERTIES

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
#define FSOUND_REVERB_FLAGS_DEFAULT (((((((FSOUND_REVERB_FLAGS_DECAYTIMESCALE or FSOUND_REVERB_FLAGS_REFLECTIONSSCALE) or FSOUND_REVERB_FLAGS_REFLECTIONSDELAYSCALE) or FSOUND_REVERB_FLAGS_REVERBSCALE) or FSOUND_REVERB_FLAGS_REVERBDELAYSCALE) or FSOUND_REVERB_FLAGS_DECAYHFLIMIT) or FSOUND_REVERB_FLAGS_CORE0) or FSOUND_REVERB_FLAGS_CORE1)

type _FSOUND_REVERB_CHANNELPROPERTIES
	Direct as long
	DirectHF as long
	Room as long
	RoomHF as long
	Obstruction as long
	ObstructionLFRatio as single
	Occlusion as long
	OcclusionLFRatio as single
	OcclusionRoomRatio as single
	OcclusionDirectRatio as single
	Exclusion as long
	ExclusionLFRatio as single
	OutsideVolumeHF as long
	DopplerFactor as single
	RolloffFactor as single
	RoomRolloffFactor as single
	AirAbsorptionFactor as single
	Flags as long
end type

type FSOUND_REVERB_CHANNELPROPERTIES as _FSOUND_REVERB_CHANNELPROPERTIES

#define FSOUND_REVERB_CHANNELFLAGS_DIRECTHFAUTO &h00000001
#define FSOUND_REVERB_CHANNELFLAGS_ROOMAUTO &h00000002
#define FSOUND_REVERB_CHANNELFLAGS_ROOMHFAUTO &h00000004
#define FSOUND_REVERB_CHANNELFLAGS_DEFAULT ((FSOUND_REVERB_CHANNELFLAGS_DIRECTHFAUTO or FSOUND_REVERB_CHANNELFLAGS_ROOMAUTO) or FSOUND_REVERB_CHANNELFLAGS_ROOMHFAUTO)

type FSOUND_FX_MODES as long
enum
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

type FSOUND_SPEAKERMODES as long
enum
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
#define FSOUND_INIT_XBOX_REMOVEHEADROOM &h4000
#define FSOUND_INIT_PSP_SILENCEONUNDERRUN &h8000

type FSOUND_STREAM_NET_STATUS as long
enum
	FSOUND_STREAM_NET_NOTCONNECTED = 0
	FSOUND_STREAM_NET_CONNECTING
	FSOUND_STREAM_NET_BUFFERING
	FSOUND_STREAM_NET_READY
	FSOUND_STREAM_NET_ERROR
end enum

type FSOUND_TAGFIELD_TYPE as long
enum
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

type _FSOUND_TOC_TAG
	name as zstring * 4
	numtracks as long
	min(0 to 99) as long
	sec(0 to 99) as long
	frame(0 to 99) as long
end type

type FSOUND_TOC_TAG as _FSOUND_TOC_TAG

declare function FSOUND_SetOutput(byval outputtype as long) as byte
declare function FSOUND_SetDriver(byval driver as long) as byte
declare function FSOUND_SetMixer(byval mixer as long) as byte
declare function FSOUND_SetBufferSize(byval len_ms as long) as byte
declare function FSOUND_SetHWND(byval hwnd as any ptr) as byte
declare function FSOUND_SetMinHardwareChannels(byval min as long) as byte
declare function FSOUND_SetMaxHardwareChannels(byval max as long) as byte
declare function FSOUND_SetMemorySystem(byval pool as any ptr, byval poollen as long, byval useralloc as FSOUND_ALLOCCALLBACK, byval userrealloc as FSOUND_REALLOCCALLBACK, byval userfree as FSOUND_FREECALLBACK) as byte
declare function FSOUND_Init(byval mixrate as long, byval maxsoftwarechannels as long, byval flags as ulong) as byte
declare sub FSOUND_Close()
declare sub FSOUND_Update()
declare sub FSOUND_SetSpeakerMode(byval speakermode as ulong)
declare sub FSOUND_SetSFXMasterVolume(byval volume as long)
declare sub FSOUND_SetPanSeperation(byval pansep as single)
declare sub FSOUND_File_SetCallbacks(byval useropen as FSOUND_OPENCALLBACK, byval userclose as FSOUND_CLOSECALLBACK, byval userread as FSOUND_READCALLBACK, byval userseek as FSOUND_SEEKCALLBACK, byval usertell as FSOUND_TELLCALLBACK)
declare function FSOUND_GetError() as long
declare function FSOUND_GetVersion() as single
declare function FSOUND_GetOutput() as long
declare function FSOUND_GetOutputHandle() as any ptr
declare function FSOUND_GetDriver() as long
declare function FSOUND_GetMixer() as long
declare function FSOUND_GetNumDrivers() as long
declare function FSOUND_GetDriverName(byval id as long) as const zstring ptr
declare function FSOUND_GetDriverCaps(byval id as long, byval caps as ulong ptr) as byte
declare function FSOUND_GetOutputRate() as long
declare function FSOUND_GetMaxChannels() as long
declare function FSOUND_GetMaxSamples() as long
declare function FSOUND_GetSpeakerMode() as ulong
declare function FSOUND_GetSFXMasterVolume() as long
declare function FSOUND_GetNumHWChannels(byval num2d as long ptr, byval num3d as long ptr, byval total as long ptr) as byte
declare function FSOUND_GetChannelsPlaying() as long
declare function FSOUND_GetCPUUsage() as single
declare sub FSOUND_GetMemoryStats(byval currentalloced as ulong ptr, byval maxalloced as ulong ptr)
declare function FSOUND_Sample_Load(byval index as long, byval name_or_data as const zstring ptr, byval mode as ulong, byval offset as long, byval length as long) as FSOUND_SAMPLE ptr
declare function FSOUND_Sample_Alloc(byval index as long, byval length as long, byval mode as ulong, byval deffreq as long, byval defvol as long, byval defpan as long, byval defpri as long) as FSOUND_SAMPLE ptr
declare sub FSOUND_Sample_Free(byval sptr as FSOUND_SAMPLE ptr)
declare function FSOUND_Sample_Upload(byval sptr as FSOUND_SAMPLE ptr, byval srcdata as any ptr, byval mode as ulong) as byte
declare function FSOUND_Sample_Lock(byval sptr as FSOUND_SAMPLE ptr, byval offset as long, byval length as long, byval ptr1 as any ptr ptr, byval ptr2 as any ptr ptr, byval len1 as ulong ptr, byval len2 as ulong ptr) as byte
declare function FSOUND_Sample_Unlock(byval sptr as FSOUND_SAMPLE ptr, byval ptr1 as any ptr, byval ptr2 as any ptr, byval len1 as ulong, byval len2 as ulong) as byte
declare function FSOUND_Sample_SetMode(byval sptr as FSOUND_SAMPLE ptr, byval mode as ulong) as byte
declare function FSOUND_Sample_SetLoopPoints(byval sptr as FSOUND_SAMPLE ptr, byval loopstart as long, byval loopend as long) as byte
declare function FSOUND_Sample_SetDefaults(byval sptr as FSOUND_SAMPLE ptr, byval deffreq as long, byval defvol as long, byval defpan as long, byval defpri as long) as byte
declare function FSOUND_Sample_SetDefaultsEx(byval sptr as FSOUND_SAMPLE ptr, byval deffreq as long, byval defvol as long, byval defpan as long, byval defpri as long, byval varfreq as long, byval varvol as long, byval varpan as long) as byte
declare function FSOUND_Sample_SetMinMaxDistance(byval sptr as FSOUND_SAMPLE ptr, byval min as single, byval max as single) as byte
declare function FSOUND_Sample_SetMaxPlaybacks(byval sptr as FSOUND_SAMPLE ptr, byval max as long) as byte
declare function FSOUND_Sample_Get(byval sampno as long) as FSOUND_SAMPLE ptr
declare function FSOUND_Sample_GetName(byval sptr as FSOUND_SAMPLE ptr) as const zstring ptr
declare function FSOUND_Sample_GetLength(byval sptr as FSOUND_SAMPLE ptr) as ulong
declare function FSOUND_Sample_GetLoopPoints(byval sptr as FSOUND_SAMPLE ptr, byval loopstart as long ptr, byval loopend as long ptr) as byte
declare function FSOUND_Sample_GetDefaults(byval sptr as FSOUND_SAMPLE ptr, byval deffreq as long ptr, byval defvol as long ptr, byval defpan as long ptr, byval defpri as long ptr) as byte
declare function FSOUND_Sample_GetDefaultsEx(byval sptr as FSOUND_SAMPLE ptr, byval deffreq as long ptr, byval defvol as long ptr, byval defpan as long ptr, byval defpri as long ptr, byval varfreq as long ptr, byval varvol as long ptr, byval varpan as long ptr) as byte
declare function FSOUND_Sample_GetMode(byval sptr as FSOUND_SAMPLE ptr) as ulong
declare function FSOUND_Sample_GetMinMaxDistance(byval sptr as FSOUND_SAMPLE ptr, byval min as single ptr, byval max as single ptr) as byte
declare function FSOUND_PlaySound(byval channel as long, byval sptr as FSOUND_SAMPLE ptr) as long
declare function FSOUND_PlaySoundEx(byval channel as long, byval sptr as FSOUND_SAMPLE ptr, byval dsp as FSOUND_DSPUNIT ptr, byval startpaused as byte) as long
declare function FSOUND_StopSound(byval channel as long) as byte
declare function FSOUND_SetFrequency(byval channel as long, byval freq as long) as byte
declare function FSOUND_SetVolume(byval channel as long, byval vol as long) as byte
declare function FSOUND_SetVolumeAbsolute(byval channel as long, byval vol as long) as byte
declare function FSOUND_SetPan(byval channel as long, byval pan as long) as byte
declare function FSOUND_SetSurround(byval channel as long, byval surround as byte) as byte
declare function FSOUND_SetMute(byval channel as long, byval mute as byte) as byte
declare function FSOUND_SetPriority(byval channel as long, byval priority as long) as byte
declare function FSOUND_SetReserved(byval channel as long, byval reserved as byte) as byte
declare function FSOUND_SetPaused(byval channel as long, byval paused as byte) as byte
declare function FSOUND_SetLoopMode(byval channel as long, byval loopmode as ulong) as byte
declare function FSOUND_SetCurrentPosition(byval channel as long, byval offset as ulong) as byte
declare function FSOUND_3D_SetAttributes(byval channel as long, byval pos_ as const single ptr, byval vel as const single ptr) as byte
declare function FSOUND_3D_SetMinMaxDistance(byval channel as long, byval min as single, byval max as single) as byte
declare function FSOUND_IsPlaying(byval channel as long) as byte
declare function FSOUND_GetFrequency(byval channel as long) as long
declare function FSOUND_GetVolume(byval channel as long) as long
declare function FSOUND_GetAmplitude(byval channel as long) as long
declare function FSOUND_GetPan(byval channel as long) as long
declare function FSOUND_GetSurround(byval channel as long) as byte
declare function FSOUND_GetMute(byval channel as long) as byte
declare function FSOUND_GetPriority(byval channel as long) as long
declare function FSOUND_GetReserved(byval channel as long) as byte
declare function FSOUND_GetPaused(byval channel as long) as byte
declare function FSOUND_GetLoopMode(byval channel as long) as ulong
declare function FSOUND_GetCurrentPosition(byval channel as long) as ulong
declare function FSOUND_GetCurrentSample(byval channel as long) as FSOUND_SAMPLE ptr
declare function FSOUND_GetCurrentLevels(byval channel as long, byval l as single ptr, byval r as single ptr) as byte
declare function FSOUND_GetNumSubChannels(byval channel as long) as long
declare function FSOUND_GetSubChannel(byval channel as long, byval subchannel as long) as long
declare function FSOUND_3D_GetAttributes(byval channel as long, byval pos_ as single ptr, byval vel as single ptr) as byte
declare function FSOUND_3D_GetMinMaxDistance(byval channel as long, byval min as single ptr, byval max as single ptr) as byte
declare sub FSOUND_3D_Listener_SetAttributes(byval pos_ as const single ptr, byval vel as const single ptr, byval fx as single, byval fy as single, byval fz as single, byval tx as single, byval ty as single, byval tz as single)
declare sub FSOUND_3D_Listener_GetAttributes(byval pos_ as single ptr, byval vel as single ptr, byval fx as single ptr, byval fy as single ptr, byval fz as single ptr, byval tx as single ptr, byval ty as single ptr, byval tz as single ptr)
declare sub FSOUND_3D_Listener_SetCurrent(byval current as long, byval numlisteners as long)
declare sub FSOUND_3D_SetDopplerFactor(byval scale as single)
declare sub FSOUND_3D_SetDistanceFactor(byval scale as single)
declare sub FSOUND_3D_SetRolloffFactor(byval scale as single)
declare function FSOUND_FX_Enable(byval channel as long, byval fxtype as ulong) as long
declare function FSOUND_FX_Disable(byval channel as long) as byte
declare function FSOUND_FX_SetChorus(byval fxid as long, byval WetDryMix as single, byval Depth as single, byval Feedback as single, byval Frequency as single, byval Waveform as long, byval Delay as single, byval Phase as long) as byte
declare function FSOUND_FX_SetCompressor(byval fxid as long, byval Gain as single, byval Attack as single, byval Release as single, byval Threshold as single, byval Ratio as single, byval Predelay as single) as byte
declare function FSOUND_FX_SetDistortion(byval fxid as long, byval Gain as single, byval Edge as single, byval PostEQCenterFrequency as single, byval PostEQBandwidth as single, byval PreLowpassCutoff as single) as byte
declare function FSOUND_FX_SetEcho(byval fxid as long, byval WetDryMix as single, byval Feedback as single, byval LeftDelay as single, byval RightDelay as single, byval PanDelay as long) as byte
declare function FSOUND_FX_SetFlanger(byval fxid as long, byval WetDryMix as single, byval Depth as single, byval Feedback as single, byval Frequency as single, byval Waveform as long, byval Delay as single, byval Phase as long) as byte
declare function FSOUND_FX_SetGargle(byval fxid as long, byval RateHz as long, byval WaveShape as long) as byte
declare function FSOUND_FX_SetI3DL2Reverb(byval fxid as long, byval Room as long, byval RoomHF as long, byval RoomRolloffFactor as single, byval DecayTime as single, byval DecayHFRatio as single, byval Reflections as long, byval ReflectionsDelay as single, byval Reverb as long, byval ReverbDelay as single, byval Diffusion as single, byval Density as single, byval HFReference as single) as byte
declare function FSOUND_FX_SetParamEQ(byval fxid as long, byval Center as single, byval Bandwidth as single, byval Gain as single) as byte
declare function FSOUND_FX_SetWavesReverb(byval fxid as long, byval InGain as single, byval ReverbMix as single, byval ReverbTime as single, byval HighFreqRTRatio as single) as byte
declare function FSOUND_Stream_SetBufferSize(byval ms as long) as byte
declare function FSOUND_Stream_Open(byval name_or_data as const zstring ptr, byval mode as ulong, byval offset as long, byval length as long) as FSOUND_STREAM ptr
declare function FSOUND_Stream_Create(byval callback as FSOUND_STREAMCALLBACK, byval length as long, byval mode as ulong, byval samplerate as long, byval userdata as any ptr) as FSOUND_STREAM ptr
declare function FSOUND_Stream_Close(byval stream as FSOUND_STREAM ptr) as byte
declare function FSOUND_Stream_Play(byval channel as long, byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_PlayEx(byval channel as long, byval stream as FSOUND_STREAM ptr, byval dsp as FSOUND_DSPUNIT ptr, byval startpaused as byte) as long
declare function FSOUND_Stream_Stop(byval stream as FSOUND_STREAM ptr) as byte
declare function FSOUND_Stream_SetPosition(byval stream as FSOUND_STREAM ptr, byval position as ulong) as byte
declare function FSOUND_Stream_GetPosition(byval stream as FSOUND_STREAM ptr) as ulong
declare function FSOUND_Stream_SetTime(byval stream as FSOUND_STREAM ptr, byval ms as long) as byte
declare function FSOUND_Stream_GetTime(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_GetLength(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_GetLengthMs(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_SetMode(byval stream as FSOUND_STREAM ptr, byval mode as ulong) as byte
declare function FSOUND_Stream_GetMode(byval stream as FSOUND_STREAM ptr) as ulong
declare function FSOUND_Stream_SetLoopPoints(byval stream as FSOUND_STREAM ptr, byval loopstartpcm as ulong, byval loopendpcm as ulong) as byte
declare function FSOUND_Stream_SetLoopCount(byval stream as FSOUND_STREAM ptr, byval count as long) as byte
declare function FSOUND_Stream_GetOpenState(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_GetSample(byval stream as FSOUND_STREAM ptr) as FSOUND_SAMPLE ptr
declare function FSOUND_Stream_CreateDSP(byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_DSPCALLBACK, byval priority as long, byval userdata as any ptr) as FSOUND_DSPUNIT ptr
declare function FSOUND_Stream_SetEndCallback(byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_STREAMCALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_SetSyncCallback(byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_STREAMCALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_AddSyncPoint(byval stream as FSOUND_STREAM ptr, byval pcmoffset as ulong, byval name_ as const zstring ptr) as FSOUND_SYNCPOINT ptr
declare function FSOUND_Stream_DeleteSyncPoint(byval point_ as FSOUND_SYNCPOINT ptr) as byte
declare function FSOUND_Stream_GetNumSyncPoints(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_GetSyncPoint(byval stream as FSOUND_STREAM ptr, byval index as long) as FSOUND_SYNCPOINT ptr
declare function FSOUND_Stream_GetSyncPointInfo(byval point_ as FSOUND_SYNCPOINT ptr, byval pcmoffset as ulong ptr) as zstring ptr
declare function FSOUND_Stream_SetSubStream(byval stream as FSOUND_STREAM ptr, byval index as long) as byte
declare function FSOUND_Stream_GetNumSubStreams(byval stream as FSOUND_STREAM ptr) as long
declare function FSOUND_Stream_SetSubStreamSentence(byval stream as FSOUND_STREAM ptr, byval sentencelist as const long ptr, byval numitems as long) as byte
declare function FSOUND_Stream_GetNumTagFields(byval stream as FSOUND_STREAM ptr, byval num as long ptr) as byte
declare function FSOUND_Stream_GetTagField(byval stream as FSOUND_STREAM ptr, byval num as long, byval type_ as long ptr, byval name_ as zstring ptr ptr, byval value as any ptr ptr, byval length as long ptr) as byte
declare function FSOUND_Stream_FindTagField(byval stream as FSOUND_STREAM ptr, byval type_ as long, byval name_ as const zstring ptr, byval value as any ptr ptr, byval length as long ptr) as byte
declare function FSOUND_Stream_Net_SetProxy(byval proxy as const zstring ptr) as byte
declare function FSOUND_Stream_Net_SetTimeout(byval timeout as long) as byte
declare function FSOUND_Stream_Net_GetLastServerStatus() as zstring ptr
declare function FSOUND_Stream_Net_SetBufferProperties(byval buffersize as long, byval prebuffer_percent as long, byval rebuffer_percent as long) as byte
declare function FSOUND_Stream_Net_GetBufferProperties(byval buffersize as long ptr, byval prebuffer_percent as long ptr, byval rebuffer_percent as long ptr) as byte
declare function FSOUND_Stream_Net_SetMetadataCallback(byval stream as FSOUND_STREAM ptr, byval callback as FSOUND_METADATACALLBACK, byval userdata as any ptr) as byte
declare function FSOUND_Stream_Net_GetStatus(byval stream as FSOUND_STREAM ptr, byval status as long ptr, byval bufferpercentused as long ptr, byval bitrate as long ptr, byval flags as ulong ptr) as byte
declare function FSOUND_CD_Play(byval drive as byte, byval track as long) as byte
declare sub FSOUND_CD_SetPlayMode(byval drive as byte, byval mode as byte)
declare function FSOUND_CD_Stop(byval drive as byte) as byte
declare function FSOUND_CD_SetPaused(byval drive as byte, byval paused as byte) as byte
declare function FSOUND_CD_SetVolume(byval drive as byte, byval volume as long) as byte
declare function FSOUND_CD_SetTrackTime(byval drive as byte, byval ms as ulong) as byte
declare function FSOUND_CD_OpenTray(byval drive as byte, byval open_ as byte) as byte
declare function FSOUND_CD_GetPaused(byval drive as byte) as byte
declare function FSOUND_CD_GetTrack(byval drive as byte) as long
declare function FSOUND_CD_GetNumTracks(byval drive as byte) as long
declare function FSOUND_CD_GetVolume(byval drive as byte) as long
declare function FSOUND_CD_GetTrackLength(byval drive as byte, byval track as long) as long
declare function FSOUND_CD_GetTrackTime(byval drive as byte) as long
declare function FSOUND_DSP_Create(byval callback as FSOUND_DSPCALLBACK, byval priority as long, byval userdata as any ptr) as FSOUND_DSPUNIT ptr
declare sub FSOUND_DSP_Free(byval unit as FSOUND_DSPUNIT ptr)
declare sub FSOUND_DSP_SetPriority(byval unit as FSOUND_DSPUNIT ptr, byval priority as long)
declare function FSOUND_DSP_GetPriority(byval unit as FSOUND_DSPUNIT ptr) as long
declare sub FSOUND_DSP_SetActive(byval unit as FSOUND_DSPUNIT ptr, byval active as byte)
declare function FSOUND_DSP_GetActive(byval unit as FSOUND_DSPUNIT ptr) as byte
declare function FSOUND_DSP_GetClearUnit() as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetSFXUnit() as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetMusicUnit() as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetFFTUnit() as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_GetClipAndCopyUnit() as FSOUND_DSPUNIT ptr
declare function FSOUND_DSP_MixBuffers(byval destbuffer as any ptr, byval srcbuffer as any ptr, byval len_ as long, byval freq as long, byval vol as long, byval pan as long, byval mode as ulong) as byte
declare sub FSOUND_DSP_ClearMixBuffer()
declare function FSOUND_DSP_GetBufferLength() as long
declare function FSOUND_DSP_GetBufferLengthTotal() as long
declare function FSOUND_DSP_GetSpectrum() as single ptr
declare function FSOUND_Reverb_SetProperties(byval prop as const FSOUND_REVERB_PROPERTIES ptr) as byte
declare function FSOUND_Reverb_GetProperties(byval prop as FSOUND_REVERB_PROPERTIES ptr) as byte
declare function FSOUND_Reverb_SetChannelProperties(byval channel as long, byval prop as const FSOUND_REVERB_CHANNELPROPERTIES ptr) as byte
declare function FSOUND_Reverb_GetChannelProperties(byval channel as long, byval prop as FSOUND_REVERB_CHANNELPROPERTIES ptr) as byte
declare function FSOUND_Record_SetDriver(byval outputtype as long) as byte
declare function FSOUND_Record_GetNumDrivers() as long
declare function FSOUND_Record_GetDriverName(byval id as long) as const zstring ptr
declare function FSOUND_Record_GetDriver() as long
declare function FSOUND_Record_StartSample(byval sptr as FSOUND_SAMPLE ptr, byval loop_ as byte) as byte
declare function FSOUND_Record_Stop() as byte
declare function FSOUND_Record_GetPosition() as long
declare function FMUSIC_LoadSong(byval name_ as const zstring ptr) as FMUSIC_MODULE ptr
declare function FMUSIC_LoadSongEx(byval name_or_data as const zstring ptr, byval offset as long, byval length as long, byval mode as ulong, byval samplelist as const long ptr, byval samplelistnum as long) as FMUSIC_MODULE ptr
declare function FMUSIC_GetOpenState(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_FreeSong(byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_PlaySong(byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_StopSong(byval mod_ as FMUSIC_MODULE ptr) as byte
declare sub FMUSIC_StopAllSongs()
declare function FMUSIC_SetZxxCallback(byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK) as byte
declare function FMUSIC_SetRowCallback(byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval rowstep as long) as byte
declare function FMUSIC_SetOrderCallback(byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval orderstep as long) as byte
declare function FMUSIC_SetInstCallback(byval mod_ as FMUSIC_MODULE ptr, byval callback as FMUSIC_CALLBACK, byval instrument as long) as byte
declare function FMUSIC_SetSample(byval mod_ as FMUSIC_MODULE ptr, byval sampno as long, byval sptr as FSOUND_SAMPLE ptr) as byte
declare function FMUSIC_SetUserData(byval mod_ as FMUSIC_MODULE ptr, byval userdata as any ptr) as byte
declare function FMUSIC_OptimizeChannels(byval mod_ as FMUSIC_MODULE ptr, byval maxchannels as long, byval minvolume as long) as byte
declare function FMUSIC_SetReverb(byval reverb as byte) as byte
declare function FMUSIC_SetLooping(byval mod_ as FMUSIC_MODULE ptr, byval looping as byte) as byte
declare function FMUSIC_SetOrder(byval mod_ as FMUSIC_MODULE ptr, byval order as long) as byte
declare function FMUSIC_SetPaused(byval mod_ as FMUSIC_MODULE ptr, byval pause as byte) as byte
declare function FMUSIC_SetMasterVolume(byval mod_ as FMUSIC_MODULE ptr, byval volume as long) as byte
declare function FMUSIC_SetMasterSpeed(byval mode as FMUSIC_MODULE ptr, byval speed as single) as byte
declare function FMUSIC_SetPanSeperation(byval mod_ as FMUSIC_MODULE ptr, byval pansep as single) as byte
declare function FMUSIC_GetName(byval mod_ as FMUSIC_MODULE ptr) as const zstring ptr
declare function FMUSIC_GetType(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetNumOrders(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetNumPatterns(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetNumInstruments(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetNumSamples(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetNumChannels(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetSample(byval mod_ as FMUSIC_MODULE ptr, byval sampno as long) as FSOUND_SAMPLE ptr
declare function FMUSIC_GetPatternLength(byval mod_ as FMUSIC_MODULE ptr, byval orderno as long) as long
declare function FMUSIC_IsFinished(byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_IsPlaying(byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_GetMasterVolume(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetGlobalVolume(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetOrder(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetPattern(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetSpeed(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetBPM(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetRow(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetPaused(byval mod_ as FMUSIC_MODULE ptr) as byte
declare function FMUSIC_GetTime(byval mod_ as FMUSIC_MODULE ptr) as long
declare function FMUSIC_GetRealChannel(byval mod_ as FMUSIC_MODULE ptr, byval modchannel as long) as long
declare function FMUSIC_GetUserData(byval mod_ as FMUSIC_MODULE ptr) as any ptr

end extern

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
