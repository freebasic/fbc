''
''
'' bass -- BASS 2.0 Multimedia Library
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bass_bi__
#define __bass_bi__

#inclib "bass"

#ifdef __FB_WIN32__
# include once "win/wtypes.bi"
#else
type BYTE as ubyte
type WORD as ushort
type DWORD as uinteger
type BOOL as integer
# define TRUE 1
# define FALSE 0
#define MAKELONG(a,b) cint( cushort(a) or (cuint(cushort(b)) shl 16) )
#endif '' __FB_WIN32__

type QWORD as ulongint

type HMUSIC as DWORD
type HSAMPLE as DWORD
type HCHANNEL as DWORD
type HSTREAM as DWORD
type HRECORD as DWORD
type HSYNC as DWORD
type HDSP as DWORD
type HFX as DWORD
type HPLUGIN as DWORD

#define BASS_OK 0
#define BASS_ERROR_MEM 1
#define BASS_ERROR_FILEOPEN 2
#define BASS_ERROR_DRIVER 3
#define BASS_ERROR_BUFLOST 4
#define BASS_ERROR_HANDLE 5
#define BASS_ERROR_FORMAT 6
#define BASS_ERROR_POSITION 7
#define BASS_ERROR_INIT 8
#define BASS_ERROR_START 9
#define BASS_ERROR_ALREADY 14
#define BASS_ERROR_NOPAUSE 16
#define BASS_ERROR_NOCHAN 18
#define BASS_ERROR_ILLTYPE 19
#define BASS_ERROR_ILLPARAM 20
#define BASS_ERROR_NO3D 21
#define BASS_ERROR_NOEAX 22
#define BASS_ERROR_DEVICE 23
#define BASS_ERROR_NOPLAY 24
#define BASS_ERROR_FREQ 25
#define BASS_ERROR_NOTFILE 27
#define BASS_ERROR_NOHW 29
#define BASS_ERROR_EMPTY 31
#define BASS_ERROR_NONET 32
#define BASS_ERROR_CREATE 33
#define BASS_ERROR_NOFX 34
#define BASS_ERROR_PLAYING 35
#define BASS_ERROR_NOTAVAIL 37
#define BASS_ERROR_DECODE 38
#define BASS_ERROR_DX 39
#define BASS_ERROR_TIMEOUT 40
#define BASS_ERROR_FILEFORM 41
#define BASS_ERROR_SPEAKER 42
#define BASS_ERROR_UNKNOWN -1
#define BASS_DEVICE_8BITS 1
#define BASS_DEVICE_MONO 2
#define BASS_DEVICE_3D 4
#define BASS_DEVICE_LATENCY 256
#define BASS_DEVICE_SPEAKERS 2048
#define BASS_OBJECT_DS 1
#define BASS_OBJECT_DS3DL 2

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
	driver as zstring ptr
end type

#define DSCAPS_CONTINUOUSRATE &h00000010
#define DSCAPS_EMULDRIVER &h00000020
#define DSCAPS_CERTIFIED &h00000040
#define DSCAPS_SECONDARYMONO &h00000100
#define DSCAPS_SECONDARYSTEREO &h00000200
#define DSCAPS_SECONDARY8BIT &h00000400
#define DSCAPS_SECONDARY16BIT &h00000800

type BASS_RECORDINFO
	flags as DWORD
	formats as DWORD
	inputs as DWORD
	singlein as BOOL
	driver as zstring ptr
end type

#define DSCCAPS_EMULDRIVER &h00000020
#define DSCCAPS_CERTIFIED &h00000040
#define WAVE_FORMAT_1M08 &h00000001
#define WAVE_FORMAT_1S08 &h00000002
#define WAVE_FORMAT_1M16 &h00000004
#define WAVE_FORMAT_1S16 &h00000008
#define WAVE_FORMAT_2M08 &h00000010
#define WAVE_FORMAT_2S08 &h00000020
#define WAVE_FORMAT_2M16 &h00000040
#define WAVE_FORMAT_2S16 &h00000080
#define WAVE_FORMAT_4M08 &h00000100
#define WAVE_FORMAT_4S08 &h00000200
#define WAVE_FORMAT_4M16 &h00000400
#define WAVE_FORMAT_4S16 &h00000800

type BASS_SAMPLE
	freq as DWORD
	volume as DWORD
	pan as integer
	flags as DWORD
	length as DWORD
	max_ as DWORD
	origres as DWORD
	chans as DWORD
	mode3d as DWORD
	mindist as single
	maxdist as single
	iangle as DWORD
	oangle as DWORD
	outvol as DWORD
	vam as DWORD
	priority as DWORD
end type

#define BASS_SAMPLE_8BITS 1
#define BASS_SAMPLE_FLOAT 256
#define BASS_SAMPLE_MONO 2
#define BASS_SAMPLE_LOOP 4
#define BASS_SAMPLE_3D 8
#define BASS_SAMPLE_SOFTWARE 16
#define BASS_SAMPLE_MUTEMAX 32
#define BASS_SAMPLE_VAM 64
#define BASS_SAMPLE_FX 128
#define BASS_SAMPLE_OVER_VOL &h10000
#define BASS_SAMPLE_OVER_POS &h20000
#define BASS_SAMPLE_OVER_DIST &h30000
#define BASS_STREAM_PRESCAN &h20000
#define BASS_MP3_SETPOS &h20000
#define BASS_STREAM_AUTOFREE &h40000
#define BASS_STREAM_RESTRATE &h80000
#define BASS_STREAM_BLOCK &h100000
#define BASS_STREAM_DECODE &h200000
#define BASS_STREAM_STATUS &h800000
#define BASS_MUSIC_FLOAT 256
#define BASS_MUSIC_MONO 2
#define BASS_MUSIC_LOOP 4
#define BASS_MUSIC_3D 8
#define BASS_MUSIC_FX 128
#define BASS_MUSIC_AUTOFREE &h40000
#define BASS_MUSIC_DECODE &h200000
#define BASS_MUSIC_PRESCAN &h20000
#define BASS_MUSIC_CALCLEN &h20000
#define BASS_MUSIC_RAMP &h200
#define BASS_MUSIC_RAMPS &h400
#define BASS_MUSIC_SURROUND &h800
#define BASS_MUSIC_SURROUND2 &h1000
#define BASS_MUSIC_FT2MOD &h2000
#define BASS_MUSIC_PT1MOD &h4000
#define BASS_MUSIC_NONINTER &h10000
#define BASS_MUSIC_POSRESET &h8000
#define BASS_MUSIC_POSRESETEX &h400000
#define BASS_MUSIC_STOPBACK &h80000
#define BASS_MUSIC_NOSAMPLE &h100000
#define BASS_SPEAKER_FRONT &h1000000
#define BASS_SPEAKER_REAR &h2000000
#define BASS_SPEAKER_CENLFE &h3000000
#define BASS_SPEAKER_REAR2 &h4000000
#define BASS_SPEAKER_LEFT &h10000000
#define BASS_SPEAKER_RIGHT &h20000000
#define BASS_SPEAKER_FRONTLEFT &h1000000 or &h10000000
#define BASS_SPEAKER_FRONTRIGHT &h1000000 or &h20000000
#define BASS_SPEAKER_REARLEFT &h2000000 or &h10000000
#define BASS_SPEAKER_REARRIGHT &h2000000 or &h20000000
#define BASS_SPEAKER_CENTER &h3000000 or &h10000000
#define BASS_SPEAKER_LFE &h3000000 or &h20000000
#define BASS_SPEAKER_REAR2LEFT &h4000000 or &h10000000
#define BASS_SPEAKER_REAR2RIGHT &h4000000 or &h20000000
#define BASS_UNICODE &h80000000
#define BASS_RECORD_PAUSE &h8000
#define BASS_VAM_HARDWARE 1
#define BASS_VAM_SOFTWARE 2
#define BASS_VAM_TERM_TIME 4
#define BASS_VAM_TERM_DIST 8
#define BASS_VAM_TERM_PRIO 16

type BASS_CHANNELINFO
	freq as DWORD
	chans as DWORD
	flags as DWORD
	ctype as DWORD
	origres as DWORD
end type

#define BASS_CTYPE_SAMPLE 1
#define BASS_CTYPE_RECORD 2
#define BASS_CTYPE_STREAM &h10000
#define BASS_CTYPE_STREAM_WAV &h10001
#define BASS_CTYPE_STREAM_OGG &h10002
#define BASS_CTYPE_STREAM_MP1 &h10003
#define BASS_CTYPE_STREAM_MP2 &h10004
#define BASS_CTYPE_STREAM_MP3 &h10005
#define BASS_CTYPE_STREAM_AIFF &h10006
#define BASS_CTYPE_MUSIC_MOD &h20000
#define BASS_CTYPE_MUSIC_MTM &h20001
#define BASS_CTYPE_MUSIC_S3M &h20002
#define BASS_CTYPE_MUSIC_XM &h20003
#define BASS_CTYPE_MUSIC_IT &h20004
#define BASS_CTYPE_MUSIC_MO3 &h00100

type BASS_3DVECTOR
	x as single
	y as single
	z as single
end type

#define BASS_3DMODE_NORMAL 0
#define BASS_3DMODE_RELATIVE 1
#define BASS_3DMODE_OFF 2

#ifdef __FB_WIN32__
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

#define EAX_PRESET_GENERIC         EAX_ENVIRONMENT_GENERIC,0.5,1.493,0.5
#define EAX_PRESET_PADDEDCELL      EAX_ENVIRONMENT_PADDEDCELL,0.25,0.1,0.0
#define EAX_PRESET_ROOM            EAX_ENVIRONMENT_ROOM,0.417,0.4,0.666
#define EAX_PRESET_BATHROOM        EAX_ENVIRONMENT_BATHROOM,0.653,1.499,0.166
#define EAX_PRESET_LIVINGROOM      EAX_ENVIRONMENT_LIVINGROOM,0.208,0.478,0.0
#define EAX_PRESET_STONEROOM       EAX_ENVIRONMENT_STONEROOM,0.5,2.309,0.888
#define EAX_PRESET_AUDITORIUM      EAX_ENVIRONMENT_AUDITORIUM,0.403,4.279,0.5
#define EAX_PRESET_CONCERTHALL     EAX_ENVIRONMENT_CONCERTHALL,0.5,3.961,0.5
#define EAX_PRESET_CAVE            EAX_ENVIRONMENT_CAVE,0.5,2.886,1.304
#define EAX_PRESET_ARENA           EAX_ENVIRONMENT_ARENA,0.361,7.284,0.332
#define EAX_PRESET_HANGAR          EAX_ENVIRONMENT_HANGAR,0.5,10.0,0.3
#define EAX_PRESET_CARPETEDHALLWAY EAX_ENVIRONMENT_CARPETEDHALLWAY,0.153,0.259,2.0
#define EAX_PRESET_HALLWAY         EAX_ENVIRONMENT_HALLWAY,0.361,1.493,0.0
#define EAX_PRESET_STONECORRIDOR   EAX_ENVIRONMENT_STONECORRIDOR,0.444,2.697,0.638
#define EAX_PRESET_ALLEY           EAX_ENVIRONMENT_ALLEY,0.25,1.752,0.776
#define EAX_PRESET_FOREST          EAX_ENVIRONMENT_FOREST,0.111,3.145,0.472
#define EAX_PRESET_CITY            EAX_ENVIRONMENT_CITY,0.111,2.767,0.224
#define EAX_PRESET_MOUNTAINS       EAX_ENVIRONMENT_MOUNTAINS,0.194,7.841,0.472
#define EAX_PRESET_QUARRY          EAX_ENVIRONMENT_QUARRY,1.0,1.499,0.5
#define EAX_PRESET_PLAIN           EAX_ENVIRONMENT_PLAIN,0.097,2.767,0.224
#define EAX_PRESET_PARKINGLOT      EAX_ENVIRONMENT_PARKINGLOT,0.208,1.652,1.5
#define EAX_PRESET_SEWERPIPE       EAX_ENVIRONMENT_SEWERPIPE,0.652,2.886,0.25
#define EAX_PRESET_UNDERWATER      EAX_ENVIRONMENT_UNDERWATER,1.0,1.499,0.0
#define EAX_PRESET_DRUGGED         EAX_ENVIRONMENT_DRUGGED,0.875,8.392,1.388
#define EAX_PRESET_DIZZY           EAX_ENVIRONMENT_DIZZY,0.139,17.234,0.666
#define EAX_PRESET_PSYCHOTIC       EAX_ENVIRONMENT_PSYCHOTIC,0.486,7.563,0.806
#endif '' __FB_WIN32__

#define BASS_3DALG_DEFAULT 0
#define BASS_3DALG_OFF 1
#define BASS_3DALG_FULL 2
#define BASS_3DALG_LIGHT 3

type STREAMPROC as function (byval as HSTREAM, byval as any ptr, byval as DWORD, byval as DWORD) as DWORD

#define BASS_STREAMPROC_END &h80000000
#define BASS_FILEPOS_CURRENT 0
#define BASS_FILEPOS_DECODE 0
#define BASS_FILEPOS_DOWNLOAD 1
#define BASS_FILEPOS_END 2
#define BASS_FILEPOS_START 3
#define BASS_FILE_CLOSE 0
#define BASS_FILE_READ 1
#define BASS_FILE_LEN 3
#define BASS_FILE_SEEK 4

type STREAMFILEPROC as function (byval as DWORD, byval as DWORD, byval as DWORD, byval as DWORD) as DWORD
type DOWNLOADPROC as sub (byval as any ptr, byval as DWORD, byval as DWORD)

#define BASS_SYNC_POS 0
#define BASS_SYNC_END 2
#define BASS_SYNC_META 4
#define BASS_SYNC_SLIDE 5
#define BASS_SYNC_STALL 6
#define BASS_SYNC_DOWNLOAD 7
#define BASS_SYNC_FREE 8
#define BASS_SYNC_MUSICPOS 10
#define BASS_SYNC_MUSICINST 1
#define BASS_SYNC_MUSICFX 3
#define BASS_SYNC_MESSAGE &h20000000
#define BASS_SYNC_MIXTIME &h40000000
#define BASS_SYNC_ONETIME &h80000000

type SYNCPROC as sub (byval as HSYNC, byval as DWORD, byval as DWORD, byval as DWORD)
type DSPPROC as sub (byval as HDSP, byval as DWORD, byval as any ptr, byval as DWORD, byval as DWORD)
type RECORDPROC as function (byval as HRECORD, byval as any ptr, byval as DWORD, byval as DWORD) as BOOL

#define BASS_DATA_AVAILABLE 0
#define BASS_DATA_FLOAT &h40000000
#define BASS_DATA_FFT512 &h80000000
#define BASS_DATA_FFT1024 &h80000001
#define BASS_DATA_FFT2048 &h80000002
#define BASS_DATA_FFT4096 &h80000003
#define BASS_DATA_FFT_INDIVIDUAL &h10
#define BASS_DATA_FFT_NOWINDOW &h20
#define BASS_TAG_ID3 0
#define BASS_TAG_ID3V2 1
#define BASS_TAG_OGG 2
#define BASS_TAG_HTTP 3
#define BASS_TAG_ICY 4
#define BASS_TAG_META 5
#define BASS_MUSIC_ATTRIB_AMPLIFY 0
#define BASS_MUSIC_ATTRIB_PANSEP 1
#define BASS_MUSIC_ATTRIB_PSCALER 2
#define BASS_MUSIC_ATTRIB_BPM 3
#define BASS_MUSIC_ATTRIB_SPEED 4
#define BASS_MUSIC_ATTRIB_VOL_GLOBAL 5
#define BASS_MUSIC_ATTRIB_VOL_CHAN &h100
#define BASS_MUSIC_ATTRIB_VOL_INST &h200

#ifdef __FB_WIN32__
enum 
	BASS_FX_CHORUS
	BASS_FX_COMPRESSOR
	BASS_FX_DISTORTION
	BASS_FX_ECHO
	BASS_FX_FLANGER
	BASS_FX_GARGLE
	BASS_FX_I3DL2REVERB
	BASS_FX_PARAMEQ
	BASS_FX_REVERB
end enum

type BASS_FXCHORUS
	fWetDryMix as single
	fDepth as single
	fFeedback as single
	fFrequency as single
	lWaveform as DWORD
	fDelay as single
	lPhase as DWORD
end type

type BASS_FXCOMPRESSOR
	fGain as single
	fAttack as single
	fRelease as single
	fThreshold as single
	fRatio as single
	fPredelay as single
end type

type BASS_FXDISTORTION
	fGain as single
	fEdge as single
	fPostEQCenterFrequency as single
	fPostEQBandwidth as single
	fPreLowpassCutoff as single
end type

type BASS_FXECHO
	fWetDryMix as single
	fFeedback as single
	fLeftDelay as single
	fRightDelay as single
	lPanDelay as BOOL
end type

type BASS_FXFLANGER
	fWetDryMix as single
	fDepth as single
	fFeedback as single
	fFrequency as single
	lWaveform as DWORD
	fDelay as single
	lPhase as DWORD
end type

type BASS_FXGARGLE
	dwRateHz as DWORD
	dwWaveShape as DWORD
end type

type BASS_FXI3DL2REVERB
	lRoom as integer
	lRoomHF as integer
	flRoomRolloffFactor as single
	flDecayTime as single
	flDecayHFRatio as single
	lReflections as integer
	flReflectionsDelay as single
	lReverb as integer
	flReverbDelay as single
	flDiffusion as single
	flDensity as single
	flHFReference as single
end type

type BASS_FXPARAMEQ
	fCenter as single
	fBandwidth as single
	fGain as single
end type

type BASS_FXREVERB
	fInGain as single
	fReverbMix as single
	fReverbTime as single
	fHighFreqRTRatio as single
end type

#define BASS_FX_PHASE_NEG_180 0
#define BASS_FX_PHASE_NEG_90 1
#define BASS_FX_PHASE_ZERO 2
#define BASS_FX_PHASE_90 3
#define BASS_FX_PHASE_180 4
#endif '' __FB_WIN32__

#define BASS_ACTIVE_STOPPED 0
#define BASS_ACTIVE_PLAYING 1
#define BASS_ACTIVE_STALLED 2
#define BASS_ACTIVE_PAUSED 3
#define BASS_SLIDE_FREQ 1
#define BASS_SLIDE_VOL 2
#define BASS_SLIDE_PAN 4
#define BASS_INPUT_OFF &h10000
#define BASS_INPUT_ON &h20000
#define BASS_INPUT_LEVEL &h40000
#define BASS_INPUT_TYPE_MASK &hff000000
#define BASS_INPUT_TYPE_UNDEF &h00000000
#define BASS_INPUT_TYPE_DIGITAL &h01000000
#define BASS_INPUT_TYPE_LINE &h02000000
#define BASS_INPUT_TYPE_MIC &h03000000
#define BASS_INPUT_TYPE_SYNTH &h04000000
#define BASS_INPUT_TYPE_CD &h05000000
#define BASS_INPUT_TYPE_PHONE &h06000000
#define BASS_INPUT_TYPE_SPEAKER &h07000000
#define BASS_INPUT_TYPE_WAVE &h08000000
#define BASS_INPUT_TYPE_AUX &h09000000
#define BASS_INPUT_TYPE_ANALOG &h0a000000
#define BASS_CONFIG_BUFFER 0
#define BASS_CONFIG_UPDATEPERIOD 1
#define BASS_CONFIG_MAXVOL 3
#define BASS_CONFIG_GVOL_SAMPLE 4
#define BASS_CONFIG_GVOL_STREAM 5
#define BASS_CONFIG_GVOL_MUSIC 6
#define BASS_CONFIG_CURVE_VOL 7
#define BASS_CONFIG_CURVE_PAN 8
#define BASS_CONFIG_FLOATDSP 9
#define BASS_CONFIG_3DALGORITHM 10
#define BASS_CONFIG_NET_TIMEOUT 11
#define BASS_CONFIG_NET_BUFFER 12
#define BASS_CONFIG_PAUSE_NOPLAY 13
#define BASS_CONFIG_NET_NOPROXY 14
#define BASS_CONFIG_NET_PREBUF 15
#define BASS_CONFIG_NET_AGENT 16

declare function BASS_SetConfig alias "BASS_SetConfig" (byval option as DWORD, byval value as DWORD) as DWORD
declare function BASS_GetConfig alias "BASS_GetConfig" (byval option as DWORD) as DWORD
declare function BASS_GetVersion alias "BASS_GetVersion" () as DWORD
declare function BASS_GetDeviceDescription alias "BASS_GetDeviceDescription" (byval device as DWORD) as zstring ptr
declare function BASS_ErrorGetCode alias "BASS_ErrorGetCode" () as integer
#ifdef __FB_WIN32__
declare function BASS_Init alias "BASS_Init" (byval device as integer, byval freq as DWORD, byval flags as DWORD, byval win as HWND, byval dsguid as GUID ptr) as BOOL
#else
declare function BASS_Init alias "BASS_Init" (byval device as integer, byval freq as DWORD, byval flags as DWORD, byval win as any ptr, byval dsguid as any ptr) as BOOL
#endif
declare function BASS_SetDevice alias "BASS_SetDevice" (byval device as DWORD) as BOOL
declare function BASS_GetDevice alias "BASS_GetDevice" () as DWORD
declare function BASS_Free alias "BASS_Free" () as BOOL
#ifdef __FB_WIN32__
declare function BASS_GetDSoundObject alias "BASS_GetDSoundObject" (byval object as DWORD) as any ptr
#endif
declare function BASS_GetInfo alias "BASS_GetInfo" (byval info as BASS_INFO ptr) as BOOL
declare function BASS_Update alias "BASS_Update" () as BOOL
declare function BASS_GetCPU alias "BASS_GetCPU" () as single
declare function BASS_Start alias "BASS_Start" () as BOOL
declare function BASS_Stop alias "BASS_Stop" () as BOOL
declare function BASS_Pause alias "BASS_Pause" () as BOOL
declare function BASS_SetVolume alias "BASS_SetVolume" (byval volume as DWORD) as BOOL
declare function BASS_GetVolume alias "BASS_GetVolume" () as DWORD
declare function BASS_PluginLoad alias "BASS_PluginLoad" (byval file as zstring ptr) as HPLUGIN
declare function BASS_PluginFree alias "BASS_PluginFree" (byval handle as HPLUGIN) as BOOL
declare function BASS_Set3DFactors alias "BASS_Set3DFactors" (byval distf as single, byval rollf as single, byval doppf as single) as BOOL
declare function BASS_Get3DFactors alias "BASS_Get3DFactors" (byval distf as single ptr, byval rollf as single ptr, byval doppf as single ptr) as BOOL
declare function BASS_Set3DPosition alias "BASS_Set3DPosition" (byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
declare function BASS_Get3DPosition alias "BASS_Get3DPosition" (byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
declare sub BASS_Apply3D alias "BASS_Apply3D" ()
#ifdef __FB_WIN32__
declare function BASS_SetEAXParameters alias "BASS_SetEAXParameters" (byval env as integer, byval vol as single, byval decay as single, byval damp as single) as BOOL
declare function BASS_GetEAXParameters alias "BASS_GetEAXParameters" (byval env as DWORD ptr, byval vol as single ptr, byval decay as single ptr, byval damp as single ptr) as BOOL
#endif
declare function BASS_MusicLoad alias "BASS_MusicLoad" (byval mem as BOOL, byval file as zstring ptr, byval offset as DWORD, byval length as DWORD, byval flags as DWORD, byval freq as DWORD) as HMUSIC
declare function BASS_MusicFree alias "BASS_MusicFree" (byval handle as HMUSIC) as BOOL
declare function BASS_MusicSetAttribute alias "BASS_MusicSetAttribute" (byval handle as HMUSIC, byval attrib as DWORD, byval value as DWORD) as DWORD
declare function BASS_MusicGetAttribute alias "BASS_MusicGetAttribute" (byval handle as HMUSIC, byval attrib as DWORD) as DWORD
declare function BASS_MusicGetName alias "BASS_MusicGetName" (byval handle as HMUSIC) as zstring ptr
declare function BASS_MusicGetOrders alias "BASS_MusicGetOrders" (byval handle as HMUSIC) as DWORD
declare function BASS_MusicGetOrderPosition alias "BASS_MusicGetOrderPosition" (byval handle as HMUSIC) as DWORD
declare function BASS_SampleLoad alias "BASS_SampleLoad" (byval mem as BOOL, byval file as zstring ptr, byval offset as DWORD, byval length as DWORD, byval max_ as DWORD, byval flags as DWORD) as HSAMPLE
declare function BASS_SampleCreate alias "BASS_SampleCreate" (byval length as DWORD, byval freq as DWORD, byval chans as DWORD, byval max_ as DWORD, byval flags as DWORD) as any ptr
declare function BASS_SampleCreateDone alias "BASS_SampleCreateDone" () as HSAMPLE
declare function BASS_SampleFree alias "BASS_SampleFree" (byval handle as HSAMPLE) as BOOL
declare function BASS_SampleGetInfo alias "BASS_SampleGetInfo" (byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleSetInfo alias "BASS_SampleSetInfo" (byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleGetChannel alias "BASS_SampleGetChannel" (byval handle as HSAMPLE, byval onlynew as BOOL) as HCHANNEL
declare function BASS_SampleStop alias "BASS_SampleStop" (byval handle as HSAMPLE) as BOOL
declare function BASS_StreamCreate alias "BASS_StreamCreate" (byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as STREAMPROC ptr, byval user as DWORD) as HSTREAM
declare function BASS_StreamCreateFile alias "BASS_StreamCreateFile" (byval mem as BOOL, byval file as zstring ptr, byval offset as DWORD, byval length as DWORD, byval flags as DWORD) as HSTREAM
declare function BASS_StreamCreateURL alias "BASS_StreamCreateURL" (byval url as zstring ptr, byval offset as DWORD, byval flags as DWORD, byval proc as DOWNLOADPROC ptr, byval user as DWORD) as HSTREAM
declare function BASS_StreamCreateFileUser alias "BASS_StreamCreateFileUser" (byval buffered as BOOL, byval flags as DWORD, byval proc as STREAMFILEPROC ptr, byval user as DWORD) as HSTREAM
declare function BASS_StreamFree alias "BASS_StreamFree" (byval handle as HSTREAM) as BOOL
declare function BASS_StreamGetTags alias "BASS_StreamGetTags" (byval handle as HSTREAM, byval tags as DWORD) as zstring ptr
declare function BASS_StreamGetFilePosition alias "BASS_StreamGetFilePosition" (byval handle as HSTREAM, byval mode as DWORD) as DWORD
declare function BASS_RecordGetDeviceDescription alias "BASS_RecordGetDeviceDescription" (byval device as DWORD) as zstring ptr
declare function BASS_RecordInit alias "BASS_RecordInit" (byval device as integer) as BOOL
declare function BASS_RecordSetDevice alias "BASS_RecordSetDevice" (byval device as DWORD) as BOOL
declare function BASS_RecordGetDevice alias "BASS_RecordGetDevice" () as DWORD
declare function BASS_RecordFree alias "BASS_RecordFree" () as BOOL
declare function BASS_RecordGetInfo alias "BASS_RecordGetInfo" (byval info as BASS_RECORDINFO ptr) as BOOL
declare function BASS_RecordGetInputName alias "BASS_RecordGetInputName" (byval input as integer) as zstring ptr
declare function BASS_RecordSetInput alias "BASS_RecordSetInput" (byval input as integer, byval setting as DWORD) as BOOL
declare function BASS_RecordGetInput alias "BASS_RecordGetInput" (byval input as integer) as DWORD
declare function BASS_RecordStart alias "BASS_RecordStart" (byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as RECORDPROC ptr, byval user as DWORD) as HRECORD
declare function BASS_ChannelBytes2Seconds alias "BASS_ChannelBytes2Seconds" (byval handle as DWORD, byval pos as QWORD) as single
declare function BASS_ChannelSeconds2Bytes alias "BASS_ChannelSeconds2Bytes" (byval handle as DWORD, byval pos as single) as QWORD
declare function BASS_ChannelGetDevice alias "BASS_ChannelGetDevice" (byval handle as DWORD) as DWORD
declare function BASS_ChannelIsActive alias "BASS_ChannelIsActive" (byval handle as DWORD) as DWORD
declare function BASS_ChannelGetInfo alias "BASS_ChannelGetInfo" (byval handle as DWORD, byval info as BASS_CHANNELINFO ptr) as BOOL
declare function BASS_ChannelSetFlags alias "BASS_ChannelSetFlags" (byval handle as DWORD, byval flags as DWORD) as BOOL
declare function BASS_ChannelPreBuf alias "BASS_ChannelPreBuf" (byval handle as DWORD, byval length as DWORD) as BOOL
declare function BASS_ChannelPlay alias "BASS_ChannelPlay" (byval handle as DWORD, byval restart as BOOL) as BOOL
declare function BASS_ChannelStop alias "BASS_ChannelStop" (byval handle as DWORD) as BOOL
declare function BASS_ChannelPause alias "BASS_ChannelPause" (byval handle as DWORD) as BOOL
declare function BASS_ChannelSetAttributes alias "BASS_ChannelSetAttributes" (byval handle as DWORD, byval freq as integer, byval volume as integer, byval pan as integer) as BOOL
declare function BASS_ChannelGetAttributes alias "BASS_ChannelGetAttributes" (byval handle as DWORD, byval freq as DWORD ptr, byval volume as DWORD ptr, byval pan as integer ptr) as BOOL
declare function BASS_ChannelSlideAttributes alias "BASS_ChannelSlideAttributes" (byval handle as DWORD, byval freq as integer, byval volume as integer, byval pan as integer, byval time as DWORD) as BOOL
declare function BASS_ChannelIsSliding alias "BASS_ChannelIsSliding" (byval handle as DWORD) as DWORD
declare function BASS_ChannelSet3DAttributes alias "BASS_ChannelSet3DAttributes" (byval handle as DWORD, byval mode as integer, byval min_ as single, byval max_ as single, byval iangle as integer, byval oangle as integer, byval outvol as integer) as BOOL
declare function BASS_ChannelGet3DAttributes alias "BASS_ChannelGet3DAttributes" (byval handle as DWORD, byval mode as DWORD ptr, byval min_ as single ptr, byval max_ as single ptr, byval iangle as DWORD ptr, byval oangle as DWORD ptr, byval outvol as DWORD ptr) as BOOL
declare function BASS_ChannelSet3DPosition alias "BASS_ChannelSet3DPosition" (byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGet3DPosition alias "BASS_ChannelGet3DPosition" (byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGetLength alias "BASS_ChannelGetLength" (byval handle as DWORD) as QWORD
declare function BASS_ChannelSetPosition alias "BASS_ChannelSetPosition" (byval handle as DWORD, byval pos as QWORD) as BOOL
declare function BASS_ChannelGetPosition alias "BASS_ChannelGetPosition" (byval handle as DWORD) as QWORD
declare function BASS_ChannelGetLevel alias "BASS_ChannelGetLevel" (byval handle as DWORD) as DWORD
declare function BASS_ChannelGetData alias "BASS_ChannelGetData" (byval handle as DWORD, byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASS_ChannelSetSync alias "BASS_ChannelSetSync" (byval handle as DWORD, byval type as DWORD, byval param as QWORD, byval proc as SYNCPROC ptr, byval user as DWORD) as HSYNC
declare function BASS_ChannelRemoveSync alias "BASS_ChannelRemoveSync" (byval handle as DWORD, byval sync as HSYNC) as BOOL
declare function BASS_ChannelSetDSP alias "BASS_ChannelSetDSP" (byval handle as DWORD, byval proc as DSPPROC ptr, byval user as DWORD, byval priority as integer) as HDSP
declare function BASS_ChannelRemoveDSP alias "BASS_ChannelRemoveDSP" (byval handle as DWORD, byval dsp as HDSP) as BOOL
declare function BASS_ChannelSetLink alias "BASS_ChannelSetLink" (byval handle as DWORD, byval chan as DWORD) as BOOL
declare function BASS_ChannelRemoveLink alias "BASS_ChannelRemoveLink" (byval handle as DWORD, byval chan as DWORD) as BOOL
#ifdef __FB_WIN32__
declare function BASS_ChannelSetEAXMix alias "BASS_ChannelSetEAXMix" (byval handle as DWORD, byval mix as single) as BOOL
declare function BASS_ChannelGetEAXMix alias "BASS_ChannelGetEAXMix" (byval handle as DWORD, byval mix as single ptr) as BOOL
declare function BASS_ChannelSetFX alias "BASS_ChannelSetFX" (byval handle as DWORD, byval type as DWORD, byval priority as DWORD) as HFX
declare function BASS_ChannelRemoveFX alias "BASS_ChannelRemoveFX" (byval handle as DWORD, byval fx as HFX) as BOOL
declare function BASS_FXSetParameters alias "BASS_FXSetParameters" (byval handle as HFX, byval par as any ptr) as BOOL
declare function BASS_FXGetParameters alias "BASS_FXGetParameters" (byval handle as HFX, byval par as any ptr) as BOOL
#endif

#endif
