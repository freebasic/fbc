' BASS 2.0 Multimedia Library
' ----------------------------
' (c) 1999-2003 Ian Luck.
' Please report bugs/suggestions/etc... to bass@un4seen.com
' See the BASS.CHM file for detailed documentation

' FB header converted from bassmod.bas for VB by Plasma  [11-13-2004]
' Mostly untested, so don't be surprised if something doesn't work :P

#inclib "bass"

#define BASSTRUE  1
#define BASSFALSE  0

'***********************************************
'* Error codes returned by BASS_ErrorGetCode() *
'***********************************************
#define BASS_OK  0               ' all is OK
#define BASS_ERROR_MEM  1        ' memory error
#define BASS_ERROR_FILEOPEN  2   ' can't open the file
#define BASS_ERROR_DRIVER  3     ' can't find a free sound driver
#define BASS_ERROR_BUFLOST  4    ' the sample buffer was lost
#define BASS_ERROR_HANDLE  5     ' invalid handle
#define BASS_ERROR_FORMAT  6     ' unsupported sample format
#define BASS_ERROR_POSITION  7   ' invalid playback position
#define BASS_ERROR_INIT  8       ' BASS_Init has not been successfully called
#define BASS_ERROR_START  9      ' BASS_Start has not been successfully called
#define BASS_ERROR_ALREADY  14   ' already initialized
#define BASS_ERROR_NOPAUSE  16   ' not paused
#define BASS_ERROR_NOTAUDIO  17  ' not an audio track
#define BASS_ERROR_NOCHAN  18    ' can't get a free channel
#define BASS_ERROR_ILLTYPE  19   ' an illegal type was specified
#define BASS_ERROR_ILLPARAM  20  ' an illegal parameter was specified
#define BASS_ERROR_NO3D  21      ' no 3D support
#define BASS_ERROR_NOEAX  22     ' no EAX support
#define BASS_ERROR_DEVICE  23    ' illegal device number
#define BASS_ERROR_NOPLAY  24    ' not playing
#define BASS_ERROR_FREQ  25      ' illegal sample rate
#define BASS_ERROR_NOTFILE  27   ' the stream is not a file stream
#define BASS_ERROR_NOHW  29      ' no hardware voices available
#define BASS_ERROR_EMPTY  31     ' the MOD music has no sequence data
#define BASS_ERROR_NONET  32     ' no internet connection could be opened
#define BASS_ERROR_CREATE  33    ' couldn't create the file
#define BASS_ERROR_NOFX  34      ' effects are not available
#define BASS_ERROR_PLAYING  35   ' the channel is playing
#define BASS_ERROR_NOTAVAIL  37  ' requested data is not available
#define BASS_ERROR_DECODE  38    ' the channel is a "decoding channel"
#define BASS_ERROR_DX  39        ' a sufficient DirectX version is not installed
#define BASS_ERROR_TIMEOUT  40   ' connection timedout
#define BASS_ERROR_FILEFORM  41  ' unsupported file format
#define BASS_ERROR_SPEAKER  42   ' unavailable speaker
#define BASS_ERROR_UNKNOWN  -1   ' some other mystery error

'************************
'* Initialization flags *
'************************
#define BASS_DEVICE_8BITS  1     ' use 8 bit resolution, else 16 bit
#define BASS_DEVICE_MONO  2      ' use mono, else stereo
#define BASS_DEVICE_3D  4        ' enable 3D functionality
' If the BASS_DEVICE_3D flag is not specified when initilizing BASS,
' then the 3D flags (BASS_SAMPLE_3D and BASS_MUSIC_3D) are ignored when
' loading/creating a sample/stream/music.

#define BASS_DEVICE_LATENCY  256    ' calculate device latency (BASS_INFO struct)
#define BASS_DEVICE_SPEAKERS  2048  ' force enabling of speaker assignment

'***********************************
'* BASS_INFO flags (from DSOUND.H) *
'***********************************
#define DSCAPS_CONTINUOUSRATE  16
' supports all sample rates between min/maxrate

#define DSCAPS_EMULDRIVER  32
' device does NOT have hardware DirectSound support

#define DSCAPS_CERTIFIED  64
' device driver has been certified by Microsoft
' The following flags tell what type of samples are supported by HARDWARE
' mixing, all these formats are supported by SOFTWARE mixing

#define DSCAPS_SECONDARYMONO  256    ' mono
#define DSCAPS_SECONDARYSTEREO  512  ' stereo
#define DSCAPS_SECONDARY8BIT  1024   ' 8 bit
#define DSCAPS_SECONDARY16BIT  2048  ' 16 bit

'*****************************************
'* BASS_RECORDINFO flags (from DSOUND.H) *
'*****************************************
#define DSCCAPS_EMULDRIVER  DSCAPS_EMULDRIVER
' device does NOT have hardware DirectSound recording support

#define DSCCAPS_CERTIFIED  DSCAPS_CERTIFIED
' device driver has been certified by Microsoft

'******************************************************************
'* defines for formats field of BASS_RECORDINFO (from MMSYSTEM.H) *
'******************************************************************
#define WAVE_FORMAT_1M08  &H1          ' 11.025 kHz, Mono,   8-bit
#define WAVE_FORMAT_1S08  &H2          ' 11.025 kHz, Stereo, 8-bit
#define WAVE_FORMAT_1M16  &H4          ' 11.025 kHz, Mono,   16-bit
#define WAVE_FORMAT_1S16  &H8          ' 11.025 kHz, Stereo, 16-bit
#define WAVE_FORMAT_2M08  &H10         ' 22.05  kHz, Mono,   8-bit
#define WAVE_FORMAT_2S08  &H20         ' 22.05  kHz, Stereo, 8-bit
#define WAVE_FORMAT_2M16  &H40         ' 22.05  kHz, Mono,   16-bit
#define WAVE_FORMAT_2S16  &H80         ' 22.05  kHz, Stereo, 16-bit
#define WAVE_FORMAT_4M08  &H100        ' 44.1   kHz, Mono,   8-bit
#define WAVE_FORMAT_4S08  &H200        ' 44.1   kHz, Stereo, 8-bit
#define WAVE_FORMAT_4M16  &H400        ' 44.1   kHz, Mono,   16-bit
#define WAVE_FORMAT_4S16  &H800        ' 44.1   kHz, Stereo, 16-bit

'*********************
'* Sample info flags *
'*********************
#define BASS_SAMPLE_8BITS  1           ' 8 bit
#define BASS_SAMPLE_FLOAT  256         ' 32-bit floating-point
#define BASS_SAMPLE_MONO  2            ' mono, else stereo
#define BASS_SAMPLE_LOOP  4            ' looped
#define BASS_SAMPLE_3D  8              ' 3D functionality enabled
#define BASS_SAMPLE_SOFTWARE  16       ' it's NOT using hardware mixing
#define BASS_SAMPLE_MUTEMAX  32        ' muted at max distance (3D only)
#define BASS_SAMPLE_VAM  64            ' uses the DX7 voice allocation & management
#define BASS_SAMPLE_FX  128            ' old implementation of DX8 effects are enabled
#define BASS_SAMPLE_OVER_VOL  65536    ' override lowest volume
#define BASS_SAMPLE_OVER_POS  131072   ' override longest playing
#define BASS_SAMPLE_OVER_DIST  196608  ' override furthest from listener (3D only)

#define BASS_MP3_SETPOS  131072        ' enable pin-point seeking on the MP3/MP2/MP1

#define BASS_STREAM_AUTOFREE  262144   ' automatically free the stream when it stop/ends
#define BASS_STREAM_RESTRATE  524288   ' restrict the download rate of internet file streams
#define BASS_STREAM_BLOCK  1048576     ' download/play internet file stream (MPx/OGG) in small blocks
#define BASS_STREAM_DECODE  &H200000   ' don't play the stream, only decode (BASS_ChannelGetData)
#define BASS_STREAM_META  &H400000     ' request metadata from a Shoutcast stream
#define BASS_STREAM_FILEPROC  &H800000 ' use a STREAMFILEPROC callback

#define BASS_MUSIC_FLOAT  BASS_SAMPLE_FLOAT ' 32-bit floating-point
#define BASS_MUSIC_MONO  BASS_SAMPLE_MONO   ' force mono mixing (less CPU usage)
#define BASS_MUSIC_LOOP  BASS_SAMPLE_LOOP   ' loop music
#define BASS_MUSIC_3D  BASS_SAMPLE_3D       ' enable 3D functionality
#define BASS_MUSIC_FX  BASS_SAMPLE_FX             ' enable old implementation of DX8 effects
#define BASS_MUSIC_AUTOFREE  BASS_STREAM_AUTOFREE ' automatically free the music when it stop/ends
#define BASS_MUSIC_DECODE  BASS_STREAM_DECODE     ' don't play the music, only decode (BASS_ChannelGetData)
#define BASS_MUSIC_RAMP  &H200                    ' normal ramping
#define BASS_MUSIC_RAMPS  &H400        ' sensitive ramping
#define BASS_MUSIC_SURROUND  &H800     ' surround sound
#define BASS_MUSIC_SURROUND2  &H1000   ' surround sound (mode 2)
#define BASS_MUSIC_FT2MOD  &H2000      ' play .MOD as FastTracker 2 does
#define BASS_MUSIC_PT1MOD  &H4000      ' play .MOD as ProTracker 1 does
#define BASS_MUSIC_CALCLEN  32768      ' calculate playback length
#define BASS_MUSIC_NONINTER  &H10000   ' non-interpolated mixing
#define BASS_MUSIC_POSRESET  &H20000   ' stop all notes when moving position
#define BASS_MUSIC_STOPBACK  &H80000   ' stop the music on a backwards jump effect
#define BASS_MUSIC_NOSAMPLE  &H100000  ' don't load the samples

' Speaker assignment flags
#define BASS_SPEAKER_FRONT  &H1000000  ' front speakers
#define BASS_SPEAKER_REAR  &H2000000   ' rear/side speakers
#define BASS_SPEAKER_CENLFE  &H3000000 ' center & LFE speakers (5.1)
#define BASS_SPEAKER_REAR2  &H4000000  ' rear center speakers (7.1)
#define BASS_SPEAKER_LEFT  &H10000000  ' modifier: left
#define BASS_SPEAKER_RIGHT  &H20000000 ' modifier: right
#define BASS_SPEAKER_FRONTLEFT  BASS_SPEAKER_FRONT Or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_FRONTRIGHT  BASS_SPEAKER_FRONT Or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_REARLEFT  BASS_SPEAKER_REAR Or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_REARRIGHT  BASS_SPEAKER_REAR Or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_CENTER  BASS_SPEAKER_CENLFE Or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_LFE  BASS_SPEAKER_CENLFE Or BASS_SPEAKER_RIGHT
#define BASS_SPEAKER_REAR2LEFT  BASS_SPEAKER_REAR2 Or BASS_SPEAKER_LEFT
#define BASS_SPEAKER_REAR2RIGHT  BASS_SPEAKER_REAR2 Or BASS_SPEAKER_RIGHT

#define BASS_UNICODE  &H80000000

#define BASS_RECORD_PAUSE  32768 ' start recording paused

'**********************************************
'* BASS_StreamGetTags flags : what's returned *
'**********************************************
#define BASS_TAG_ID3  0   ' ID3v1 tags : 128 byte block
#define BASS_TAG_ID3V2  1 ' ID3v2 tags : variable length block
#define BASS_TAG_OGG  2   ' OGG comments : array of null-terminated strings
#define BASS_TAG_HTTP  3  ' HTTP headers : array of null-terminated strings
#define BASS_TAG_ICY  4   ' ICY headers  : array of null-terminated strings
#define BASS_TAG_META  5  ' ICY metadata : null-terminated string

'********************
'* 3D channel modes *
'********************
#define BASS_3DMODE_NORMAL  0
' normal 3D processing

#define BASS_3DMODE_RELATIVE  1
' The channel's 3D position (position/velocity/orientation) are relative to
' the listener. When the listener's position/velocity/orientation is changed
' with BASS_Set3DPosition, the channel's position relative to the listener does
' not change.

#define BASS_3DMODE_OFF  2
' Turn off 3D processing on the channel, the sound will be played
' in the center.

'****************************************************
'* EAX environments, use with BASS_SetEAXParameters *
'****************************************************
enum EAX_ENVIRONMENT_ENUM
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

	' total number of environments
	EAX_ENVIRONMENT_COUNT
end enum

'' EAX presets, usage: BASS_SetEAXParameters(EAX_PRESET_xxx)
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


'**********************************************************************
'* Sync types (with BASS_ChannelSetSync() "param" and SYNCPROC "data" *
'* definitions) & flags.                                              *
'**********************************************************************
' Sync when a music or stream reaches a position.
' if HMUSIC...
' param: LOWORD=order (0=first, -1=all) HIWORD=row (0=first, -1=all)
' data : LOWORD=order HIWORD=row
' if HSTREAM...
' param: position in bytes
' data : not used
#define BASS_SYNC_POS  0
#define BASS_SYNC_MUSICPOS  0

' Sync when an instrument (sample for the non-instrument based formats)
' is played in a music (not including retrigs).
' param: LOWORD=instrument (1=first) HIWORD=note (0=c0...119=b9, -1=all)
' data : LOWORD=note HIWORD=volume (0-64)
#define BASS_SYNC_MUSICINST  1

' Sync when a music or file stream reaches the end.
' param: not used
' data : not used
#define BASS_SYNC_END  2

' Sync when the "sync" effect (XM/MTM/MOD: E8x/Wxx, IT/S3M: S2x) is used.
' param: 0:data=pos, 1:data="x" value
' data : param=0: LOWORD=order HIWORD=row, param=1: "x" value
#define BASS_SYNC_MUSICFX  3

' FLAG: post a Windows message (instead of callback)
' When using a window message "callback", the message to post is given in the "proc"
' parameter of BASS_ChannelSetSync, and is posted to the window specified in the BASS_Init
' call. The message parameters are: WPARAM = data, LPARAM = user.
#define BASS_SYNC_META  4

' Sync when metadata is received in a Shoutcast stream.
' param: not used
' data : pointer to the metadata
#define BASS_SYNC_SLIDE  5

' Sync when an attribute slide is completed.
' param: not used
' data : the type of slide completed (one of the BASS_SLIDE_xxx values)
#define BASS_SYNC_STALL  6

' Sync when playback has stalled.
' param: not used
' data : 0=stalled, 1=resumed
#define BASS_SYNC_DOWNLOAD  7

' Sync when downloading of an internet (or "buffered" user file) stream has ended.
' param: not used
' data : not used
#define BASS_SYNC_MESSAGE  &H20000000

'FLAG: sync at mixtime, else at playtime
#define BASS_SYNC_MIXTIME  &H40000000

' FLAG: sync only once, else continuously
#define BASS_SYNC_ONETIME  &H80000000

' BASS_ChannelIsActive return values
#define BASS_ACTIVE_STOPPED  0
#define BASS_ACTIVE_PLAYING  1
#define BASS_ACTIVE_STALLED  2
#define BASS_ACTIVE_PAUSED  3

' BASS_ChannelIsSliding return flags
#define BASS_SLIDE_FREQ  1
#define BASS_SLIDE_VOL  2
#define BASS_SLIDE_PAN  4

' BASS_ChannelGetData flags
#define BASS_DATA_AVAILABLE  0         ' query how much data is buffered
#define BASS_DATA_FFT512  &H80000000   ' 512 sample FFT
#define BASS_DATA_FFT1024  &H80000001  ' 1024 FFT
#define BASS_DATA_FFT2048  &H80000002  ' 2048 FFT
#define BASS_DATA_FFT4096  &H80000003  ' 4096 FFT
#define BASS_DATA_FFT_INDIVIDUAL  &H10 ' FFT flag: FFT for each channel, else all combined
#define BASS_DATA_FFT_NOWINDOW  &H20   ' FFT flag: no Hanning window

' BASS_RecordSetInput flags
#define BASS_INPUT_OFF  &H10000
#define BASS_INPUT_ON  &H20000
#define BASS_INPUT_LEVEL  &H40000

#define BASS_INPUT_TYPE_MASK  &HFF000000
#define BASS_INPUT_TYPE_UNDEF  &H0
#define BASS_INPUT_TYPE_DIGITAL  &H1000000
#define BASS_INPUT_TYPE_LINE  &H2000000
#define BASS_INPUT_TYPE_MIC  &H3000000
#define BASS_INPUT_TYPE_SYNTH  &H4000000
#define BASS_INPUT_TYPE_CD  &H5000000
#define BASS_INPUT_TYPE_PHONE  &H6000000
#define BASS_INPUT_TYPE_SPEAKER  &H7000000
#define BASS_INPUT_TYPE_WAVE  &H8000000
#define BASS_INPUT_TYPE_AUX  &H9000000
#define BASS_INPUT_TYPE_ANALOG  &HA000000

' BASS_Set/GetConfig options
#define BASS_CONFIG_BUFFER  0
#define BASS_CONFIG_UPDATEPERIOD  1
#define BASS_CONFIG_MAXVOL  3
#define BASS_CONFIG_GVOL_SAMPLE  4
#define BASS_CONFIG_GVOL_STREAM  5
#define BASS_CONFIG_GVOL_MUSIC  6
#define BASS_CONFIG_CURVE_VOL  7
#define BASS_CONFIG_CURVE_PAN  8
#define BASS_CONFIG_FLOATDSP  9
#define BASS_CONFIG_3DALGORITHM  10
#define BASS_CONFIG_NET_TIMEOUT  11
#define BASS_CONFIG_NET_BUFFER  12

' BASS_StreamGetFilePosition modes
#define BASS_FILEPOS_DECODE  0
#define BASS_FILEPOS_DOWNLOAD  1
#define BASS_FILEPOS_END  2

' STREAMFILEPROC actions
#define BASS_FILE_CLOSE  0
#define BASS_FILE_READ  1
#define BASS_FILE_QUERY  2
#define BASS_FILE_LEN  3

#define BASS_STREAMPROC_END  &H80000000 ' end of user stream flag

'**************************************************************
'* DirectSound interfaces (for use with BASS_GetDSoundObject) *
'**************************************************************
#define BASS_OBJECT_DS  1     ' DirectSound
#define BASS_OBJECT_DS3DL  2  ' IDirectSound3DListener

'******************************
'* DX7 voice allocation flags *
'******************************
' Play the sample in hardware. If no hardware voices are available then
' the "play" call will fail
#define BASS_VAM_HARDWARE  1

' Play the sample in software (ie. non-accelerated). No other VAM flags
' may be used together with this flag.
#define BASS_VAM_SOFTWARE  2

'******************************
'* DX7 voice management flags *
'******************************
' These flags enable hardware resource stealing... if the hardware has no
' available voices, a currently playing buffer will be stopped to make room for
' the new buffer. NOTE: only samples loaded/created with the BASS_SAMPLE_VAM
' flag are considered for termination by the DX7 voice management.

' If there are no free hardware voices, the buffer to be terminated will be
' the one with the least time left to play.
#define BASS_VAM_TERM_TIME  4

' If there are no free hardware voices, the buffer to be terminated will be
' one that was loaded/created with the BASS_SAMPLE_MUTEMAX flag and is beyond
' it 's max distance. If there are no buffers that match this criteria, then the
' "play" call will fail.
#define BASS_VAM_TERM_DIST  8

' If there are no free hardware voices, the buffer to be terminated will be
' the one with the lowest priority.
#define BASS_VAM_TERM_PRIO  16

'**********************************************************************
'* software 3D mixing algorithm modes (used with BASS_Set3DAlgorithm) *
'**********************************************************************
' default algorithm (currently translates to BASS_3DALG_OFF)
#define BASS_3DALG_DEFAULT  0

' Uses normal left and right panning. The vertical axis is ignored except for
' scaling of volume due to distance. Doppler shift and volume scaling are still
' applied, but the 3D filtering is not performed. This is the most CPU efficient
' software implementation, but provides no virtual 3D audio effect. Head Related
' Transfer Function processing will not be done. Since only normal stereo panning
' is used, a channel using this algorithm may be accelerated by a 2D hardware
' voice if no free 3D hardware voices are available.
#define BASS_3DALG_OFF  1

' This algorithm gives the highest quality 3D audio effect, but uses more CPU.
' Requires Windows 98 2nd Edition or Windows 2000 that uses WDM drivers, if this
' mode is not available then BASS_3DALG_OFF will be used instead.
#define BASS_3DALG_FULL  2

' This algorithm gives a good 3D audio effect, and uses less CPU than the FULL
' mode. Requires Windows 98 2nd Edition or Windows 2000 that uses WDM drivers, if
' this mode is not available then BASS_3DALG_OFF will be used instead.
#define BASS_3DALG_LIGHT  3

Type BASS_INFO
    size As Integer          ' size of this struct (set this before calling the function)
    flags As Integer         ' device capabilities (DSCAPS_xxx flags)
    hwsize As Integer        ' size of total device hardware memory
    hwfree As Integer        ' size of free device hardware memory
    freesam As Integer       ' number of free sample slots in the hardware
    free3d As Integer        ' number of free 3D sample slots in the hardware
    minrate As Integer       ' min sample rate supported by the hardware
    maxrate As Integer       ' max sample rate supported by the hardware
    eax As Integer           ' device supports EAX? (always BASSFALSE if BASS_DEVICE_3D was not used)
    minbuf As Integer        ' recommended minimum buffer length in ms (requires BASS_DEVICE_LATENCY)
    dsver As Integer         ' DirectSound version
    latency As Integer       ' delay (in ms) before start of playback (requires BASS_DEVICE_LATENCY)
    initflags As Integer     ' "flags" parameter of BASS_Init call
    speakers As Integer      ' number of speakers available
    driver As byte ptr        ' driver
End Type

Type BASS_RECORDINFO
    size As Integer          ' size of this struct (set this before calling the function)
    flags As Integer         ' device capabilities (DSCCAPS_xxx flags)
    formats As Integer       ' supported standard formats (WAVE_FORMAT_xxx flags)
    inputs As Integer        ' number of inputs
    singlein As Integer      ' BASSTRUE = only 1 input can be set at a time
    driver As byte ptr       ' driver
End Type

Type BASS_SAMPLE
    freq As Integer          ' default playback rate
    volume As Integer        ' default volume (0-100)
    pan As Integer           ' default pan (-100=left, 0=middle, 100=right)
    flags As Integer         ' BASS_SAMPLE_xxx flags
    length As Integer        ' length (in samples, not bytes)
    max As Integer           ' maximum simultaneous playbacks

    ' The following are the sample's default 3D attributes (if the sample
    ' is 3D, BASS_SAMPLE_3D is in flags) see BASS_ChannelSet3DAttributes
    mode3d As Integer        ' BASS_3DMODE_xxx mode
    mindist As Single     ' minimum distance
    MAXDIST As Single     ' maximum distance
    iangle As Integer        ' angle of inside projection cone
    oangle As Integer        ' angle of outside projection cone
    outvol As Integer        ' delta-volume outside the projection cone

    ' The following are the defaults used if the sample uses the DirectX 7
    ' voice allocation/management features.
    vam As Integer           ' voice allocation/management flags (BASS_VAM_xxx)
    priority As Integer      ' priority (0=lowest, &Hffffffff=highest)
End Type

Type BASS_CHANNELINFO
    freq As Integer          ' default playback rate
    chans As Integer         ' channels
    flags As Integer         ' BASS_SAMPLE/STREAM/MUSIC/SPEAKER flags
    ctype As Integer         ' type of channel
End Type

' BASS_CHANNELINFO types
#define BASS_CTYPE_SAMPLE  1
#define BASS_CTYPE_RECORD  2
#define BASS_CTYPE_STREAM  &H10000
#define BASS_CTYPE_STREAM_WAV  &H10001
#define BASS_CTYPE_STREAM_OGG  &H10002
#define BASS_CTYPE_STREAM_MP1  &H10003
#define BASS_CTYPE_STREAM_MP2  &H10004
#define BASS_CTYPE_STREAM_MP3  &H10005
#define BASS_CTYPE_MUSIC_MOD  &H20000
#define BASS_CTYPE_MUSIC_MTM  &H20001
#define BASS_CTYPE_MUSIC_S3M  &H20002
#define BASS_CTYPE_MUSIC_XM  &H20003
#define BASS_CTYPE_MUSIC_IT  &H20004
#define BASS_CTYPE_MUSIC_MO3  &H00100  ' mo3 flag

'********************************************************
'* 3D vector (for 3D positions/velocities/orientations) *
'********************************************************
Type BASS_3DVECTOR
    X As Single      ' +=right, -=left
    Y As Single      ' +=up, -=down
    z As Single      ' +=front, -=behind
End Type

' DX8 effect types, use with BASS_ChannelSetFX
#define BASS_FX_CHORUS  0       ' GUID_DSFX_STANDARD_CHORUS
#define BASS_FX_COMPRESSOR  1   ' GUID_DSFX_STANDARD_COMPRESSOR
#define BASS_FX_DISTORTION  2   ' GUID_DSFX_STANDARD_DISTORTION
#define BASS_FX_ECHO  3         ' GUID_DSFX_STANDARD_ECHO
#define BASS_FX_FLANGER  4      ' GUID_DSFX_STANDARD_FLANGER
#define BASS_FX_GARGLE  5       ' GUID_DSFX_STANDARD_GARGLE
#define BASS_FX_I3DL2REVERB  6  ' GUID_DSFX_STANDARD_I3DL2REVERB
#define BASS_FX_PARAMEQ  7      ' GUID_DSFX_STANDARD_PARAMEQ
#define BASS_FX_REVERB  8       ' GUID_DSFX_WAVES_REVERB

Type BASS_FXCHORUS       ' DSFXChorus
    fWetDryMix As Single
    fDepth As Single
    fFeedback As Single
    fFrequency As Single
    lWaveform As Integer    ' 0=triangle, 1=sine
    fDelay As Single
    lPhase As Integer       ' BASS_FX_PHASE_xxx
End Type

Type BASS_FXCOMPRESSOR   ' DSFXCompressor
    fGain As Single
    fAttack As Single
    fRelease As Single
    fThreshold As Single
    fRatio As Single
    fPredelay As Single
End Type

Type BASS_FXDISTORTION   ' DSFXDistortion
    fGain As Single
    fEdge As Single
    fPostEQCenterFrequency As Single
    fPostEQBandwidth As Single
    fPreLowpassCutoff As Single
End Type

Type BASS_FXECHO         ' DSFXEcho
    fWetDryMix As Single
    fFeedback As Single
    fLeftDelay As Single
    fRightDelay As Single
    lPanDelay As Integer
End Type

Type BASS_FXFLANGER      ' DSFXFlanger
    fWetDryMix As Single
    fDepth As Single
    fFeedback As Single
    fFrequency As Single
    lWaveform As Integer    ' 0=triangle, 1=sine
    fDelay As Single
    lPhase As Integer       ' BASS_FX_PHASE_xxx
End Type

Type BASS_FXGARGLE       ' DSFXGargle
    dwRateHz As Integer     ' Rate of modulation in hz
    dwWaveShape As Integer  ' 0=triangle, 1=square
End Type

Type BASS_FXI3DL2REVERB            ' DSFXI3DL2Reverb
    lRoom As Integer                  ' [-10000, 0]      default: -1000 mB
    lRoomHF As Integer                ' [-10000, 0]      default: 0 mB
    flRoomRolloffFactor As Single  ' [0.0, 10.0]      default: 0.0
    flDecayTime As Single          ' [0.1, 20.0]      default: 1.49s
    flDecayHFRatio As Single       ' [0.1, 2.0]       default: 0.83
    lReflections As Integer           ' [-10000, 1000]   default: -2602 mB
    flReflectionsDelay As Single   ' [0.0, 0.3]       default: 0.007 s
    lReverb As Integer                ' [-10000, 2000]   default: 200 mB
    flReverbDelay As Single        ' [0.0, 0.1]       default: 0.011 s
    flDiffusion As Single          ' [0.0, 100.0]     default: 100.0 %
    flDensity As Single            ' [0.0, 100.0]     default: 100.0 %
    flHFReference As Single        ' [20.0, 20000.0]  default: 5000.0 Hz
End Type

Type BASS_FXPARAMEQ                ' DSFXParamEq
    fCenter As Single
    fBandwidth As Single
    fGain As Single
End Type

Type BASS_FXREVERB                 ' DSFXWavesReverb
    fInGain As Single              ' [-96.0,0.0]      default: 0.0 dB
    fReverbMix As Single           ' [-96.0,0.0]      default: 0.0 db
    fReverbTime As Single          ' [0.001,3000.0]   default: 1000.0 ms
    fHighFreqRTRatio As Single     ' [0.001,0.999]    default: 0.001
End Type

#define BASS_FX_PHASE_NEG_180  0
#define BASS_FX_PHASE_NEG_90  1
#define BASS_FX_PHASE_ZERO  2
#define BASS_FX_PHASE_90  3
#define BASS_FX_PHASE_180  4

Type GUID             ' used with BASS_Init - use VarPtr(guid) in clsid parameter
    Data1 As Integer
    Data2 As short
    Data3 As short
    Data4(7) As Byte
End Type


Declare Function BASS_SetConfig alias "BASS_SetConfig" (ByVal opt As Integer, ByVal value As Integer) As Integer
Declare Function BASS_GetConfig alias "BASS_GetConfig" (ByVal opt As Integer) As Integer
Declare Function BASS_GetVersion alias "BASS_GetVersion" () As Integer
Declare Function BASS_GetDeviceDescription alias "BASS_GetDeviceDescription" (ByVal device As Integer) as zstring ptr
Declare Function BASS_ErrorGetCode alias "BASS_ErrorGetCode" () As Integer
Declare Function BASS_Init alias "BASS_Init" (ByVal device As Integer, ByVal freq As Integer, ByVal flags As Integer, ByVal win As Integer, ByVal clsid As Integer) As Integer
Declare Function BASS_SetDevice alias "BASS_SetDevice" (ByVal device As Integer) As Integer
Declare Function BASS_GetDevice alias "BASS_GetDevice" () As Integer
Declare Function BASS_Free alias "BASS_Free" () As Integer
Declare Function BASS_GetDSoundObject alias "BASS_GetDSoundObject" (ByVal object As Integer) As Integer
Declare Function BASS_GetInfo alias "BASS_GetInfo" (byval info As BASS_INFO ptr) As Integer
Declare Function BASS_Update alias "BASS_Update" () As Integer
Declare Function BASS_GetCPU alias "BASS_GetCPU" () As Single
Declare Function BASS_Start alias "BASS_Start" () As Integer
Declare Function BASS_Stop alias "BASS_Stop" () As Integer
Declare Function BASS_Pause alias "BASS_Pause" () As Integer
Declare Function BASS_SetVolume alias "BASS_SetVolume" (ByVal volume As Integer) As Integer
Declare Function BASS_GetVolume alias "BASS_GetVolume" () As Integer

Declare Function BASS_Set3DFactors alias "BASS_Set3DFactors" (ByVal distf As Single, ByVal rollf As Single, ByVal doppf As Single) As Integer
Declare Function BASS_Get3DFactors alias "BASS_Get3DFactors" (Byval distf As Single ptr, Byval rollf As Single ptr, Byval doppf As Single ptr) As Integer
Declare Function BASS_Set3DPosition alias "BASS_Set3DPosition" (Byval pos As Any ptr, Byval vel As Any ptr, Byval front As Any ptr, Byval top As Any ptr) As Integer
Declare Function BASS_Get3DPosition alias "BASS_Get3DPosition" (Byval pos As Any ptr, Byval vel As Any ptr, Byval front As Any ptr, Byval top As Any ptr) As Integer
Declare Function BASS_Apply3D alias "BASS_Apply3D" () As Integer
Declare Function BASS_SetEAXParameters alias "BASS_SetEAXParameters" (ByVal env As Integer, ByVal vol As Single, ByVal decay As Single, ByVal damp As Single) As Integer
Declare Function BASS_GetEAXParameters alias "BASS_GetEAXParameters" (Byval env As Integer ptr, Byval vol As Single ptr, Byval decay As Single ptr, Byval damp As Single ptr) As Integer

Declare Function BASS_MusicLoad alias "BASS_MusicLoad" (ByVal mem As Integer, byval f as zstring ptr, ByVal offset As Integer, ByVal length As Integer, ByVal flags As Integer, ByVal freq As Integer) As Integer
Declare Sub BASS_MusicFree alias "BASS_MusicFree" (ByVal handle As Integer)
Declare Function BASS_MusicGetName alias "BASS_MusicGetName" (ByVal handle As Integer) as zstring ptr
Declare Function BASS_MusicGetLength alias "BASS_MusicGetLength" (ByVal handle As Integer, ByVal playlen As Integer) As Integer
Declare Function BASS_MusicPreBuf alias "BASS_MusicPreBuf" (ByVal handle As Integer) As Integer
Declare Function BASS_MusicPlay alias "BASS_MusicPlay" (ByVal handle As Integer) As Integer
Declare Function BASS_MusicPlayEx alias "BASS_MusicPlayEx" (ByVal handle As Integer, ByVal pos As Integer, ByVal flags As Integer, ByVal reset As Integer) As Integer
Declare Function BASS_MusicSetAmplify alias "BASS_MusicSetAmplify" (ByVal handle As Integer, amp As Integer) As Integer
Declare Function BASS_MusicSetPanSep alias "BASS_MusicSetPanSep" (ByVal handle As Integer, pan As Integer) As Integer
Declare Function BASS_MusicSetPositionScaler alias "BASS_MusicSetPositionScaler" (ByVal handle As Integer, ByVal pscale As Integer) As Integer
Declare Function BASS_MusicSetVolume alias "BASS_MusicSetVolume" (ByVal handle As Integer, ByVal chanins As Integer, ByVal volume As Integer) As Integer
Declare Function BASS_MusicGetVolume alias "BASS_MusicGetVolume" (ByVal handle As Integer, ByVal chanins As Integer) As Integer

Declare Function BASS_SampleLoad alias "BASS_SampleLoad" (ByVal mem As Integer, byval f as zstring ptr, ByVal offset As Integer, ByVal length As Integer, ByVal max As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_SampleCreate alias "BASS_SampleCreate" (ByVal length As Integer, ByVal freq As Integer, ByVal max As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_SampleCreateDone alias "BASS_SampleCreateDone" () As Integer
Declare Sub BASS_SampleFree alias "BASS_SampleFree" (ByVal handle As Integer)
Declare Function BASS_SampleGetInfo alias "BASS_SampleGetInfo" (ByVal handle As Integer, Byval info As BASS_SAMPLE ptr) As Integer
Declare Function BASS_SampleSetInfo alias "BASS_SampleSetInfo" (ByVal handle As Integer, Byval info As BASS_SAMPLE ptr) As Integer
Declare Function BASS_SamplePlay alias "BASS_SamplePlay" (ByVal handle As Integer) As Integer
Declare Function BASS_SamplePlayEx alias "BASS_SamplePlayEx" (ByVal handle As Integer, ByVal start As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer, ByVal pLoop As Integer) As Integer
Declare Function BASS_SamplePlay3D alias "BASS_SamplePlay3D" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_SamplePlay3DEx alias "BASS_SamplePlay3DEx" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr, ByVal start As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pLoop As Integer) As Integer
Declare Function BASS_SampleStop alias "BASS_SampleStop" (ByVal handle As Integer) As Integer

Declare Function BASS_StreamCreate alias "BASS_StreamCreate" (ByVal freq As Integer, ByVal chans As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_StreamCreateFile alias "BASS_StreamCreateFile" (ByVal mem As Integer, byval f as zstring ptr, ByVal offset As Integer, ByVal length As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_StreamCreateURL alias "BASS_StreamCreateURL" (byval url as zstring ptr, ByVal offset As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_StreamCreateFileUser alias "BASS_StreamCreateFileUser" (ByVal buffered As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Sub BASS_StreamFree alias "BASS_StreamFree" (ByVal handle As Integer)
Declare Function BASS_StreamGetLength alias "BASS_StreamGetLength" (ByVal handle As Integer) As Integer
Declare Function BASS_StreamGetTags alias "BASS_StreamGetTags" (ByVal handle As Integer, ByVal tags As Integer) as zstring ptr
Declare Function BASS_StreamPreBuf alias "BASS_StreamPreBuf" (ByVal handle As Integer) As Integer
Declare Function BASS_StreamPlay alias "BASS_StreamPlay" (ByVal handle As Integer, ByVal flush As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_StreamGetFilePosition alias "BASS_StreamGetFilePosition" (ByVal handle As Integer, ByVal mode As Integer) As Integer

Declare Function BASS_RecordGetDeviceDescription alias "BASS_RecordGetDeviceDescription" (ByVal device As Integer) as zstring ptr
Declare Function BASS_RecordInit alias "BASS_RecordInit" (ByVal device As Integer) As Integer
Declare Function BASS_RecordSetDevice alias "BASS_RecordSetDevice" (ByVal device As Integer) As Integer
Declare Function BASS_RecordGetDevice alias "BASS_RecordGetDevice" () As Integer
Declare Function BASS_RecordFree alias "BASS_RecordFree" () As Integer
Declare Function BASS_RecordGetInfo alias "BASS_RecordGetInfo" (Byval info As BASS_RECORDINFO ptr) As Integer
Declare Function BASS_RecordGetInputName alias "BASS_RecordGetInputName" (ByVal inputn As Integer) as zstring ptr
Declare Function BASS_RecordSetInput alias "BASS_RecordSetInput" (ByVal inputn As Integer, ByVal setting As Integer) As Integer
Declare Function BASS_RecordGetInput alias "BASS_RecordGetInput" (ByVal inputn As Integer) As Integer
Declare Function BASS_RecordStart alias "BASS_RecordStart" (ByVal freq As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer

Declare Function BASS_ChannelBytes2Seconds64 alias "BASS_ChannelBytes2Seconds64" Alias "BASS_ChannelBytes2Seconds" (ByVal handle As Integer, ByVal pos As Integer, ByVal poshigh As Integer) As Single
Declare Function BASS_ChannelSeconds2Bytes alias "BASS_ChannelSeconds2Bytes" (ByVal handle As Integer, ByVal pos As Single) As Integer
Declare Function BASS_ChannelGetDevice alias "BASS_ChannelGetDevice" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelIsActive alias "BASS_ChannelIsActive" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetInfo alias "BASS_ChannelGetInfo" (ByVal handle As Integer, Byval info As BASS_CHANNELINFO ptr) As Integer
Declare Function BASS_ChannelStop alias "BASS_ChannelStop" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelPause alias "BASS_ChannelPause" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelResume alias "BASS_ChannelResume" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelSetAttributes alias "BASS_ChannelSetAttributes" (ByVal handle As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer) As Integer
Declare Function BASS_ChannelGetAttributes alias "BASS_ChannelGetAttributes" (ByVal handle As Integer, Byval freq As Integer ptr, Byval volume As Integer ptr, Byval pan As Integer ptr) As Integer
Declare Function BASS_ChannelSlideAttributes alias "BASS_ChannelSlideAttributes" (ByVal handle As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer, ByVal time As Integer) As Integer
Declare Function BASS_ChannelIsSliding alias "BASS_ChannelIsSliding" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelSet3DAttributes alias "BASS_ChannelSet3DAttributes" (ByVal handle As Integer, ByVal mode As Integer, ByVal min As Single, ByVal max As Single, ByVal iangle As Integer, ByVal oangle As Integer, ByVal outvol As Integer) As Integer
Declare Function BASS_ChannelGet3DAttributes alias "BASS_ChannelGet3DAttributes" (ByVal handle As Integer, Byval mode As Integer ptr, Byval min As Single ptr, Byval max As Single ptr, Byval iangle As Integer ptr, Byval oangle As Integer ptr, Byval outvol As Integer ptr) As Integer
Declare Function BASS_ChannelSet3DPosition alias "BASS_ChannelSet3DPosition" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_ChannelGet3DPosition alias "BASS_ChannelGet3DPosition" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_ChannelSetPosition64 alias "BASS_ChannelSetPosition64" Alias "BASS_ChannelSetPosition" (ByVal handle As Integer, ByVal pos As Integer, ByVal poshigh As Integer) As Integer
Declare Function BASS_ChannelGetPosition alias "BASS_ChannelGetPosition" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetLevel alias "BASS_ChannelGetLevel" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetData alias "BASS_ChannelGetData" (ByVal handle As Integer, Byval buffer As Any ptr, ByVal length As Integer) As Integer
Declare Function BASS_ChannelSetSync64 alias "BASS_ChannelSetSync64" Alias "BASS_ChannelSetSync" (ByVal handle As Integer, ByVal atype As Integer, ByVal param As Integer, ByVal paramhigh As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_ChannelRemoveSync alias "BASS_ChannelRemoveSync" (ByVal handle As Integer, ByVal sync As Integer) As Integer
Declare Function BASS_ChannelSetDSP alias "BASS_ChannelSetDSP" (ByVal handle As Integer, ByVal proc As Integer, ByVal user As Integer, ByVal priority As Integer) As Integer
Declare Function BASS_ChannelRemoveDSP alias "BASS_ChannelRemoveDSP" (ByVal handle As Integer, ByVal dsp As Integer) As Integer
Declare Function BASS_ChannelSetEAXMix alias "BASS_ChannelSetEAXMix" (ByVal handle As Integer, ByVal mix As Single) As Integer
Declare Function BASS_ChannelGetEAXMix alias "BASS_ChannelGetEAXMix" (ByVal handle As Integer, Byval mix As Single ptr) As Integer
Declare Function BASS_ChannelSetLink alias "BASS_ChannelSetLink" (ByVal handle As Integer, ByVal chan As Integer) As Integer
Declare Function BASS_ChannelRemoveLink alias "BASS_ChannelRemoveLink" (ByVal handle As Integer, ByVal chan As Integer) As Integer
Declare Function BASS_ChannelSetFX alias "BASS_ChannelSetFX" (ByVal handle As Integer, ByVal atype As Integer) As Integer
Declare Function BASS_ChannelRemoveFX alias "BASS_ChannelRemoveFX" (ByVal handle As Integer, ByVal fx As Integer) As Integer
Declare Function BASS_FXSetParameters alias "BASS_FXSetParameters" (ByVal handle As Integer, Byval par As Any ptr) As Integer
Declare Function BASS_FXGetParameters alias "BASS_FXGetParameters" (ByVal handle As Integer, Byval par As Any ptr) As Integer



'*******************************************
' 32-bit wrappers for 64-bit BASS functions
'*******************************************

#define BASS_ChannelBytes2Seconds(handle,bpos) BASS_ChannelBytes2Seconds64(handle, bpos, 0)

#define BASS_ChannelSetPosition(handle,bpos) BASS_ChannelSetPosition64(handle, bpos, 0)

#define BASS_ChannelSetSync(handle,atype,param,proc,user) BASS_ChannelSetSync64(handle, atype, param, 0, proc, user)