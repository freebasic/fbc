' BASS 2.0 Multimedia Library
' ----------------------------
' (c) 1999-2003 Ian Luck.
' Please report bugs/suggestions/etc... to bass@un4seen.com
' See the BASS.CHM file for detailed documentation

' FB header converted from bassmod.bas for VB by Plasma  [11-13-2004]
' Mostly untested, so don't be surprised if something doesn't work :P

Const BASSTRUE = 1
Const BASSFALSE = 0

'***********************************************
'* Error codes returned by BASS_ErrorGetCode() *
'***********************************************
Const BASS_OK = 0               ' all is OK
Const BASS_ERROR_MEM = 1        ' memory error
Const BASS_ERROR_FILEOPEN = 2   ' can't open the file
Const BASS_ERROR_DRIVER = 3     ' can't find a free sound driver
Const BASS_ERROR_BUFLOST = 4    ' the sample buffer was lost
Const BASS_ERROR_HANDLE = 5     ' invalid handle
Const BASS_ERROR_FORMAT = 6     ' unsupported sample format
Const BASS_ERROR_POSITION = 7   ' invalid playback position
Const BASS_ERROR_INIT = 8       ' BASS_Init has not been successfully called
Const BASS_ERROR_START = 9      ' BASS_Start has not been successfully called
Const BASS_ERROR_ALREADY = 14   ' already initialized
Const BASS_ERROR_NOPAUSE = 16   ' not paused
Const BASS_ERROR_NOTAUDIO = 17  ' not an audio track
Const BASS_ERROR_NOCHAN = 18    ' can't get a free channel
Const BASS_ERROR_ILLTYPE = 19   ' an illegal type was specified
Const BASS_ERROR_ILLPARAM = 20  ' an illegal parameter was specified
Const BASS_ERROR_NO3D = 21      ' no 3D support
Const BASS_ERROR_NOEAX = 22     ' no EAX support
Const BASS_ERROR_DEVICE = 23    ' illegal device number
Const BASS_ERROR_NOPLAY = 24    ' not playing
Const BASS_ERROR_FREQ = 25      ' illegal sample rate
Const BASS_ERROR_NOTFILE = 27   ' the stream is not a file stream
Const BASS_ERROR_NOHW = 29      ' no hardware voices available
Const BASS_ERROR_EMPTY = 31     ' the MOD music has no sequence data
Const BASS_ERROR_NONET = 32     ' no internet connection could be opened
Const BASS_ERROR_CREATE = 33    ' couldn't create the file
Const BASS_ERROR_NOFX = 34      ' effects are not available
Const BASS_ERROR_PLAYING = 35   ' the channel is playing
Const BASS_ERROR_NOTAVAIL = 37  ' requested data is not available
Const BASS_ERROR_DECODE = 38    ' the channel is a "decoding channel"
Const BASS_ERROR_DX = 39        ' a sufficient DirectX version is not installed
Const BASS_ERROR_TIMEOUT = 40   ' connection timedout
Const BASS_ERROR_FILEFORM = 41  ' unsupported file format
Const BASS_ERROR_SPEAKER = 42   ' unavailable speaker
Const BASS_ERROR_UNKNOWN = -1   ' some other mystery error

'************************
'* Initialization flags *
'************************
Const BASS_DEVICE_8BITS = 1     ' use 8 bit resolution, else 16 bit
Const BASS_DEVICE_MONO = 2      ' use mono, else stereo
Const BASS_DEVICE_3D = 4        ' enable 3D functionality
' If the BASS_DEVICE_3D flag is not specified when initilizing BASS,
' then the 3D flags (BASS_SAMPLE_3D and BASS_MUSIC_3D) are ignored when
' loading/creating a sample/stream/music.

Const BASS_DEVICE_LATENCY = 256    ' calculate device latency (BASS_INFO struct)
Const BASS_DEVICE_SPEAKERS = 2048  ' force enabling of speaker assignment

'***********************************
'* BASS_INFO flags (from DSOUND.H) *
'***********************************
Const DSCAPS_CONTINUOUSRATE = 16
' supports all sample rates between min/maxrate

Const DSCAPS_EMULDRIVER = 32
' device does NOT have hardware DirectSound support

Const DSCAPS_CERTIFIED = 64
' device driver has been certified by Microsoft
' The following flags tell what type of samples are supported by HARDWARE
' mixing, all these formats are supported by SOFTWARE mixing

Const DSCAPS_SECONDARYMONO = 256    ' mono
Const DSCAPS_SECONDARYSTEREO = 512  ' stereo
Const DSCAPS_SECONDARY8BIT = 1024   ' 8 bit
Const DSCAPS_SECONDARY16BIT = 2048  ' 16 bit

'*****************************************
'* BASS_RECORDINFO flags (from DSOUND.H) *
'*****************************************
Const DSCCAPS_EMULDRIVER = DSCAPS_EMULDRIVER
' device does NOT have hardware DirectSound recording support

Const DSCCAPS_CERTIFIED = DSCAPS_CERTIFIED
' device driver has been certified by Microsoft

'******************************************************************
'* defines for formats field of BASS_RECORDINFO (from MMSYSTEM.H) *
'******************************************************************
Const WAVE_FORMAT_1M08 = &H1          ' 11.025 kHz, Mono,   8-bit
Const WAVE_FORMAT_1S08 = &H2          ' 11.025 kHz, Stereo, 8-bit
Const WAVE_FORMAT_1M16 = &H4          ' 11.025 kHz, Mono,   16-bit
Const WAVE_FORMAT_1S16 = &H8          ' 11.025 kHz, Stereo, 16-bit
Const WAVE_FORMAT_2M08 = &H10         ' 22.05  kHz, Mono,   8-bit
Const WAVE_FORMAT_2S08 = &H20         ' 22.05  kHz, Stereo, 8-bit
Const WAVE_FORMAT_2M16 = &H40         ' 22.05  kHz, Mono,   16-bit
Const WAVE_FORMAT_2S16 = &H80         ' 22.05  kHz, Stereo, 16-bit
Const WAVE_FORMAT_4M08 = &H100        ' 44.1   kHz, Mono,   8-bit
Const WAVE_FORMAT_4S08 = &H200        ' 44.1   kHz, Stereo, 8-bit
Const WAVE_FORMAT_4M16 = &H400        ' 44.1   kHz, Mono,   16-bit
Const WAVE_FORMAT_4S16 = &H800        ' 44.1   kHz, Stereo, 16-bit

'*********************
'* Sample info flags *
'*********************
Const BASS_SAMPLE_8BITS = 1           ' 8 bit
Const BASS_SAMPLE_FLOAT = 256         ' 32-bit floating-point
Const BASS_SAMPLE_MONO = 2            ' mono, else stereo
Const BASS_SAMPLE_LOOP = 4            ' looped
Const BASS_SAMPLE_3D = 8              ' 3D functionality enabled
Const BASS_SAMPLE_SOFTWARE = 16       ' it's NOT using hardware mixing
Const BASS_SAMPLE_MUTEMAX = 32        ' muted at max distance (3D only)
Const BASS_SAMPLE_VAM = 64            ' uses the DX7 voice allocation & management
Const BASS_SAMPLE_FX = 128            ' old implementation of DX8 effects are enabled
Const BASS_SAMPLE_OVER_VOL = 65536    ' override lowest volume
Const BASS_SAMPLE_OVER_POS = 131072   ' override longest playing
Const BASS_SAMPLE_OVER_DIST = 196608  ' override furthest from listener (3D only)

Const BASS_MP3_SETPOS = 131072        ' enable pin-point seeking on the MP3/MP2/MP1

Const BASS_STREAM_AUTOFREE = 262144   ' automatically free the stream when it stop/ends
Const BASS_STREAM_RESTRATE = 524288   ' restrict the download rate of internet file streams
Const BASS_STREAM_BLOCK = 1048576     ' download/play internet file stream (MPx/OGG) in small blocks
Const BASS_STREAM_DECODE = &H200000   ' don't play the stream, only decode (BASS_ChannelGetData)
Const BASS_STREAM_META = &H400000     ' request metadata from a Shoutcast stream
Const BASS_STREAM_FILEPROC = &H800000 ' use a STREAMFILEPROC callback

Const BASS_MUSIC_FLOAT = BASS_SAMPLE_FLOAT ' 32-bit floating-point
Const BASS_MUSIC_MONO = BASS_SAMPLE_MONO   ' force mono mixing (less CPU usage)
Const BASS_MUSIC_LOOP = BASS_SAMPLE_LOOP   ' loop music
Const BASS_MUSIC_3D = BASS_SAMPLE_3D       ' enable 3D functionality
Const BASS_MUSIC_FX = BASS_SAMPLE_FX             ' enable old implementation of DX8 effects
Const BASS_MUSIC_AUTOFREE = BASS_STREAM_AUTOFREE ' automatically free the music when it stop/ends
Const BASS_MUSIC_DECODE = BASS_STREAM_DECODE     ' don't play the music, only decode (BASS_ChannelGetData)
Const BASS_MUSIC_RAMP = &H200                    ' normal ramping
Const BASS_MUSIC_RAMPS = &H400        ' sensitive ramping
Const BASS_MUSIC_SURROUND = &H800     ' surround sound
Const BASS_MUSIC_SURROUND2 = &H1000   ' surround sound (mode 2)
Const BASS_MUSIC_FT2MOD = &H2000      ' play .MOD as FastTracker 2 does
Const BASS_MUSIC_PT1MOD = &H4000      ' play .MOD as ProTracker 1 does
Const BASS_MUSIC_CALCLEN = 32768      ' calculate playback length
Const BASS_MUSIC_NONINTER = &H10000   ' non-interpolated mixing
Const BASS_MUSIC_POSRESET = &H20000   ' stop all notes when moving position
Const BASS_MUSIC_STOPBACK = &H80000   ' stop the music on a backwards jump effect
Const BASS_MUSIC_NOSAMPLE = &H100000  ' don't load the samples

' Speaker assignment flags
Const BASS_SPEAKER_FRONT = &H1000000  ' front speakers
Const BASS_SPEAKER_REAR = &H2000000   ' rear/side speakers
Const BASS_SPEAKER_CENLFE = &H3000000 ' center & LFE speakers (5.1)
Const BASS_SPEAKER_REAR2 = &H4000000  ' rear center speakers (7.1)
Const BASS_SPEAKER_LEFT = &H10000000  ' modifier: left
Const BASS_SPEAKER_RIGHT = &H20000000 ' modifier: right
Const BASS_SPEAKER_FRONTLEFT = BASS_SPEAKER_FRONT Or BASS_SPEAKER_LEFT
Const BASS_SPEAKER_FRONTRIGHT = BASS_SPEAKER_FRONT Or BASS_SPEAKER_RIGHT
Const BASS_SPEAKER_REARLEFT = BASS_SPEAKER_REAR Or BASS_SPEAKER_LEFT
Const BASS_SPEAKER_REARRIGHT = BASS_SPEAKER_REAR Or BASS_SPEAKER_RIGHT
Const BASS_SPEAKER_CENTER = BASS_SPEAKER_CENLFE Or BASS_SPEAKER_LEFT
Const BASS_SPEAKER_LFE = BASS_SPEAKER_CENLFE Or BASS_SPEAKER_RIGHT
Const BASS_SPEAKER_REAR2LEFT = BASS_SPEAKER_REAR2 Or BASS_SPEAKER_LEFT
Const BASS_SPEAKER_REAR2RIGHT = BASS_SPEAKER_REAR2 Or BASS_SPEAKER_RIGHT

Const BASS_UNICODE = &H80000000

Const BASS_RECORD_PAUSE = 32768 ' start recording paused

'**********************************************
'* BASS_StreamGetTags flags : what's returned *
'**********************************************
Const BASS_TAG_ID3 = 0   ' ID3v1 tags : 128 byte block
Const BASS_TAG_ID3V2 = 1 ' ID3v2 tags : variable length block
Const BASS_TAG_OGG = 2   ' OGG comments : array of null-terminated strings
Const BASS_TAG_HTTP = 3  ' HTTP headers : array of null-terminated strings
Const BASS_TAG_ICY = 4   ' ICY headers  : array of null-terminated strings
Const BASS_TAG_META = 5  ' ICY metadata : null-terminated string

'********************
'* 3D channel modes *
'********************
Const BASS_3DMODE_NORMAL = 0
' normal 3D processing

Const BASS_3DMODE_RELATIVE = 1
' The channel's 3D position (position/velocity/orientation) are relative to
' the listener. When the listener's position/velocity/orientation is changed
' with BASS_Set3DPosition, the channel's position relative to the listener does
' not change.

Const BASS_3DMODE_OFF = 2
' Turn off 3D processing on the channel, the sound will be played
' in the center.

'****************************************************
'* EAX environments, use with BASS_SetEAXParameters *
'****************************************************
Const EAX_ENVIRONMENT_GENERIC = 0
Const EAX_ENVIRONMENT_PADDEDCELL = 1
Const EAX_ENVIRONMENT_ROOM = 2
Const EAX_ENVIRONMENT_BATHROOM = 3
Const EAX_ENVIRONMENT_LIVINGROOM = 4
Const EAX_ENVIRONMENT_STONEROOM = 5
Const EAX_ENVIRONMENT_AUDITORIUM = 6
Const EAX_ENVIRONMENT_CONCERTHALL = 7
Const EAX_ENVIRONMENT_CAVE = 8
Const EAX_ENVIRONMENT_ARENA = 9
Const EAX_ENVIRONMENT_HANGAR = 10
Const EAX_ENVIRONMENT_CARPETEDHALLWAY = 11
Const EAX_ENVIRONMENT_HALLWAY = 12
Const EAX_ENVIRONMENT_STONECORRIDOR = 13
Const EAX_ENVIRONMENT_ALLEY = 14
Const EAX_ENVIRONMENT_FOREST = 15
Const EAX_ENVIRONMENT_CITY = 16
Const EAX_ENVIRONMENT_MOUNTAINS = 17
Const EAX_ENVIRONMENT_QUARRY = 18
Const EAX_ENVIRONMENT_PLAIN = 19
Const EAX_ENVIRONMENT_PARKINGLOT = 20
Const EAX_ENVIRONMENT_SEWERPIPE = 21
Const EAX_ENVIRONMENT_UNDERWATER = 22
Const EAX_ENVIRONMENT_DRUGGED = 23
Const EAX_ENVIRONMENT_DIZZY = 24
Const EAX_ENVIRONMENT_PSYCHOTIC = 25

' total number of environments
Const EAX_ENVIRONMENT_COUNT = 26

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
Const BASS_SYNC_POS = 0
Const BASS_SYNC_MUSICPOS = 0

' Sync when an instrument (sample for the non-instrument based formats)
' is played in a music (not including retrigs).
' param: LOWORD=instrument (1=first) HIWORD=note (0=c0...119=b9, -1=all)
' data : LOWORD=note HIWORD=volume (0-64)
Const BASS_SYNC_MUSICINST = 1

' Sync when a music or file stream reaches the end.
' param: not used
' data : not used
Const BASS_SYNC_END = 2

' Sync when the "sync" effect (XM/MTM/MOD: E8x/Wxx, IT/S3M: S2x) is used.
' param: 0:data=pos, 1:data="x" value
' data : param=0: LOWORD=order HIWORD=row, param=1: "x" value
Const BASS_SYNC_MUSICFX = 3

' FLAG: post a Windows message (instead of callback)
' When using a window message "callback", the message to post is given in the "proc"
' parameter of BASS_ChannelSetSync, and is posted to the window specified in the BASS_Init
' call. The message parameters are: WPARAM = data, LPARAM = user.
Const BASS_SYNC_META = 4

' Sync when metadata is received in a Shoutcast stream.
' param: not used
' data : pointer to the metadata
Const BASS_SYNC_SLIDE = 5

' Sync when an attribute slide is completed.
' param: not used
' data : the type of slide completed (one of the BASS_SLIDE_xxx values)
Const BASS_SYNC_STALL = 6

' Sync when playback has stalled.
' param: not used
' data : 0=stalled, 1=resumed
Const BASS_SYNC_DOWNLOAD = 7

' Sync when downloading of an internet (or "buffered" user file) stream has ended.
' param: not used
' data : not used
Const BASS_SYNC_MESSAGE = &H20000000

'FLAG: sync at mixtime, else at playtime
Const BASS_SYNC_MIXTIME = &H40000000

' FLAG: sync only once, else continuously
Const BASS_SYNC_ONETIME = &H80000000

' BASS_ChannelIsActive return values
Const BASS_ACTIVE_STOPPED = 0
Const BASS_ACTIVE_PLAYING = 1
Const BASS_ACTIVE_STALLED = 2
Const BASS_ACTIVE_PAUSED = 3

' BASS_ChannelIsSliding return flags
Const BASS_SLIDE_FREQ = 1
Const BASS_SLIDE_VOL = 2
Const BASS_SLIDE_PAN = 4

' BASS_ChannelGetData flags
Const BASS_DATA_AVAILABLE = 0         ' query how much data is buffered
Const BASS_DATA_FFT512 = &H80000000   ' 512 sample FFT
Const BASS_DATA_FFT1024 = &H80000001  ' 1024 FFT
Const BASS_DATA_FFT2048 = &H80000002  ' 2048 FFT
Const BASS_DATA_FFT4096 = &H80000003  ' 4096 FFT
Const BASS_DATA_FFT_INDIVIDUAL = &H10 ' FFT flag: FFT for each channel, else all combined
Const BASS_DATA_FFT_NOWINDOW = &H20   ' FFT flag: no Hanning window

' BASS_RecordSetInput flags
Const BASS_INPUT_OFF = &H10000
Const BASS_INPUT_ON = &H20000
Const BASS_INPUT_LEVEL = &H40000

Const BASS_INPUT_TYPE_MASK = &HFF000000
Const BASS_INPUT_TYPE_UNDEF = &H0
Const BASS_INPUT_TYPE_DIGITAL = &H1000000
Const BASS_INPUT_TYPE_LINE = &H2000000
Const BASS_INPUT_TYPE_MIC = &H3000000
Const BASS_INPUT_TYPE_SYNTH = &H4000000
Const BASS_INPUT_TYPE_CD = &H5000000
Const BASS_INPUT_TYPE_PHONE = &H6000000
Const BASS_INPUT_TYPE_SPEAKER = &H7000000
Const BASS_INPUT_TYPE_WAVE = &H8000000
Const BASS_INPUT_TYPE_AUX = &H9000000
Const BASS_INPUT_TYPE_ANALOG = &HA000000

' BASS_Set/GetConfig options
Const BASS_CONFIG_BUFFER = 0
Const BASS_CONFIG_UPDATEPERIOD = 1
Const BASS_CONFIG_MAXVOL = 3
Const BASS_CONFIG_GVOL_SAMPLE = 4
Const BASS_CONFIG_GVOL_STREAM = 5
Const BASS_CONFIG_GVOL_MUSIC = 6
Const BASS_CONFIG_CURVE_VOL = 7
Const BASS_CONFIG_CURVE_PAN = 8
Const BASS_CONFIG_FLOATDSP = 9
Const BASS_CONFIG_3DALGORITHM = 10
Const BASS_CONFIG_NET_TIMEOUT = 11
Const BASS_CONFIG_NET_BUFFER = 12

' BASS_StreamGetFilePosition modes
Const BASS_FILEPOS_DECODE = 0
Const BASS_FILEPOS_DOWNLOAD = 1
Const BASS_FILEPOS_END = 2

' STREAMFILEPROC actions
Const BASS_FILE_CLOSE = 0
Const BASS_FILE_READ = 1
Const BASS_FILE_QUERY = 2
Const BASS_FILE_LEN = 3

Const BASS_STREAMPROC_END = &H80000000 ' end of user stream flag

'**************************************************************
'* DirectSound interfaces (for use with BASS_GetDSoundObject) *
'**************************************************************
Const BASS_OBJECT_DS = 1     ' DirectSound
Const BASS_OBJECT_DS3DL = 2  ' IDirectSound3DListener

'******************************
'* DX7 voice allocation flags *
'******************************
' Play the sample in hardware. If no hardware voices are available then
' the "play" call will fail
Const BASS_VAM_HARDWARE = 1

' Play the sample in software (ie. non-accelerated). No other VAM flags
' may be used together with this flag.
Const BASS_VAM_SOFTWARE = 2

'******************************
'* DX7 voice management flags *
'******************************
' These flags enable hardware resource stealing... if the hardware has no
' available voices, a currently playing buffer will be stopped to make room for
' the new buffer. NOTE: only samples loaded/created with the BASS_SAMPLE_VAM
' flag are considered for termination by the DX7 voice management.

' If there are no free hardware voices, the buffer to be terminated will be
' the one with the least time left to play.
Const BASS_VAM_TERM_TIME = 4

' If there are no free hardware voices, the buffer to be terminated will be
' one that was loaded/created with the BASS_SAMPLE_MUTEMAX flag and is beyond
' it 's max distance. If there are no buffers that match this criteria, then the
' "play" call will fail.
Const BASS_VAM_TERM_DIST = 8

' If there are no free hardware voices, the buffer to be terminated will be
' the one with the lowest priority.
Const BASS_VAM_TERM_PRIO = 16

'**********************************************************************
'* software 3D mixing algorithm modes (used with BASS_Set3DAlgorithm) *
'**********************************************************************
' default algorithm (currently translates to BASS_3DALG_OFF)
Const BASS_3DALG_DEFAULT = 0

' Uses normal left and right panning. The vertical axis is ignored except for
' scaling of volume due to distance. Doppler shift and volume scaling are still
' applied, but the 3D filtering is not performed. This is the most CPU efficient
' software implementation, but provides no virtual 3D audio effect. Head Related
' Transfer Function processing will not be done. Since only normal stereo panning
' is used, a channel using this algorithm may be accelerated by a 2D hardware
' voice if no free 3D hardware voices are available.
Const BASS_3DALG_OFF = 1

' This algorithm gives the highest quality 3D audio effect, but uses more CPU.
' Requires Windows 98 2nd Edition or Windows 2000 that uses WDM drivers, if this
' mode is not available then BASS_3DALG_OFF will be used instead.
Const BASS_3DALG_FULL = 2

' This algorithm gives a good 3D audio effect, and uses less CPU than the FULL
' mode. Requires Windows 98 2nd Edition or Windows 2000 that uses WDM drivers, if
' this mode is not available then BASS_3DALG_OFF will be used instead.
Const BASS_3DALG_LIGHT = 3

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
Const BASS_CTYPE_SAMPLE = 1
Const BASS_CTYPE_RECORD = 2
Const BASS_CTYPE_STREAM = &H10000
Const BASS_CTYPE_STREAM_WAV = &H10001
Const BASS_CTYPE_STREAM_OGG = &H10002
Const BASS_CTYPE_STREAM_MP1 = &H10003
Const BASS_CTYPE_STREAM_MP2 = &H10004
Const BASS_CTYPE_STREAM_MP3 = &H10005
Const BASS_CTYPE_MUSIC_MOD = &H20000
Const BASS_CTYPE_MUSIC_MTM = &H20001
Const BASS_CTYPE_MUSIC_S3M = &H20002
Const BASS_CTYPE_MUSIC_XM = &H20003
Const BASS_CTYPE_MUSIC_IT = &H20004
Const BASS_CTYPE_MUSIC_MO3 = &H00100  ' mo3 flag

'********************************************************
'* 3D vector (for 3D positions/velocities/orientations) *
'********************************************************
Type BASS_3DVECTOR
    X As Single      ' +=right, -=left
    Y As Single      ' +=up, -=down
    z As Single      ' +=front, -=behind
End Type

' DX8 effect types, use with BASS_ChannelSetFX
Const BASS_FX_CHORUS = 0       ' GUID_DSFX_STANDARD_CHORUS
Const BASS_FX_COMPRESSOR = 1   ' GUID_DSFX_STANDARD_COMPRESSOR
Const BASS_FX_DISTORTION = 2   ' GUID_DSFX_STANDARD_DISTORTION
Const BASS_FX_ECHO = 3         ' GUID_DSFX_STANDARD_ECHO
Const BASS_FX_FLANGER = 4      ' GUID_DSFX_STANDARD_FLANGER
Const BASS_FX_GARGLE = 5       ' GUID_DSFX_STANDARD_GARGLE
Const BASS_FX_I3DL2REVERB = 6  ' GUID_DSFX_STANDARD_I3DL2REVERB
Const BASS_FX_PARAMEQ = 7      ' GUID_DSFX_STANDARD_PARAMEQ
Const BASS_FX_REVERB = 8       ' GUID_DSFX_WAVES_REVERB

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

Const BASS_FX_PHASE_NEG_180 = 0
Const BASS_FX_PHASE_NEG_90 = 1
Const BASS_FX_PHASE_ZERO = 2
Const BASS_FX_PHASE_90 = 3
Const BASS_FX_PHASE_180 = 4

Type GUID             ' used with BASS_Init - use VarPtr(guid) in clsid parameter
    Data1 As Integer
    Data2 As short
    Data3 As short
    Data4(7) As Byte
End Type


Declare Function BASS_SetConfig Lib "bass" (ByVal opt As Integer, ByVal value As Integer) As Integer
Declare Function BASS_GetConfig Lib "bass" (ByVal opt As Integer) As Integer
Declare Function BASS_GetVersion Lib "bass" () As Integer
Declare Function BASS_GetDeviceDescription Lib "bass" (ByVal device As Integer) As byte ptr
Declare Function BASS_ErrorGetCode Lib "bass" () As Integer
Declare Function BASS_Init Lib "bass" (ByVal device As Integer, ByVal freq As Integer, ByVal flags As Integer, ByVal win As Integer, ByVal clsid As Integer) As Integer
Declare Function BASS_SetDevice Lib "bass" (ByVal device As Integer) As Integer
Declare Function BASS_GetDevice Lib "bass" () As Integer
Declare Function BASS_Free Lib "bass" () As Integer
Declare Function BASS_GetDSoundObject Lib "bass" (ByVal object As Integer) As Integer
Declare Function BASS_GetInfo Lib "bass" (byval info As BASS_INFO ptr) As Integer
Declare Function BASS_Update Lib "bass" () As Integer
Declare Function BASS_GetCPU Lib "bass" () As Single
Declare Function BASS_Start Lib "bass" () As Integer
Declare Function BASS_Stop Lib "bass" () As Integer
Declare Function BASS_Pause Lib "bass" () As Integer
Declare Function BASS_SetVolume Lib "bass" (ByVal volume As Integer) As Integer
Declare Function BASS_GetVolume Lib "bass" () As Integer

Declare Function BASS_Set3DFactors Lib "bass" (ByVal distf As Single, ByVal rollf As Single, ByVal doppf As Single) As Integer
Declare Function BASS_Get3DFactors Lib "bass" (Byval distf As Single ptr, Byval rollf As Single ptr, Byval doppf As Single ptr) As Integer
Declare Function BASS_Set3DPosition Lib "bass" (Byval pos As Any ptr, Byval vel As Any ptr, Byval front As Any ptr, Byval top As Any ptr) As Integer
Declare Function BASS_Get3DPosition Lib "bass" (Byval pos As Any ptr, Byval vel As Any ptr, Byval front As Any ptr, Byval top As Any ptr) As Integer
Declare Function BASS_Apply3D Lib "bass" () As Integer
Declare Function BASS_SetEAXParameters Lib "bass" (ByVal env As Integer, ByVal vol As Single, ByVal decay As Single, ByVal damp As Single) As Integer
Declare Function BASS_GetEAXParameters Lib "bass" (Byval env As Integer ptr, Byval vol As Single ptr, Byval decay As Single ptr, Byval damp As Single ptr) As Integer

Declare Function BASS_MusicLoad Lib "bass" (ByVal mem As Integer, ByVal f As String, ByVal offset As Integer, ByVal length As Integer, ByVal flags As Integer, ByVal freq As Integer) As Integer
Declare Sub BASS_MusicFree Lib "bass" (ByVal handle As Integer)
Declare Function BASS_MusicGetName Lib "bass" (ByVal handle As Integer) As byte ptr
Declare Function BASS_MusicGetLength Lib "bass" (ByVal handle As Integer, ByVal playlen As Integer) As Integer
Declare Function BASS_MusicPreBuf Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_MusicPlay Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_MusicPlayEx Lib "bass" (ByVal handle As Integer, ByVal pos As Integer, ByVal flags As Integer, ByVal reset As Integer) As Integer
Declare Function BASS_MusicSetAmplify Lib "bass" (ByVal handle As Integer, amp As Integer) As Integer
Declare Function BASS_MusicSetPanSep Lib "bass" (ByVal handle As Integer, pan As Integer) As Integer
Declare Function BASS_MusicSetPositionScaler Lib "bass" (ByVal handle As Integer, ByVal pscale As Integer) As Integer
Declare Function BASS_MusicSetVolume Lib "bass" (ByVal handle As Integer, ByVal chanins As Integer, ByVal volume As Integer) As Integer
Declare Function BASS_MusicGetVolume Lib "bass" (ByVal handle As Integer, ByVal chanins As Integer) As Integer

Declare Function BASS_SampleLoad Lib "bass" (ByVal mem As Integer, ByVal f As String, ByVal offset As Integer, ByVal length As Integer, ByVal max As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_SampleCreate Lib "bass" (ByVal length As Integer, ByVal freq As Integer, ByVal max As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_SampleCreateDone Lib "bass" () As Integer
Declare Sub BASS_SampleFree Lib "bass" (ByVal handle As Integer)
Declare Function BASS_SampleGetInfo Lib "bass" (ByVal handle As Integer, Byval info As BASS_SAMPLE ptr) As Integer
Declare Function BASS_SampleSetInfo Lib "bass" (ByVal handle As Integer, Byval info As BASS_SAMPLE ptr) As Integer
Declare Function BASS_SamplePlay Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_SamplePlayEx Lib "bass" (ByVal handle As Integer, ByVal start As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer, ByVal pLoop As Integer) As Integer
Declare Function BASS_SamplePlay3D Lib "bass" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_SamplePlay3DEx Lib "bass" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr, ByVal start As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pLoop As Integer) As Integer
Declare Function BASS_SampleStop Lib "bass" (ByVal handle As Integer) As Integer

Declare Function BASS_StreamCreate Lib "bass" (ByVal freq As Integer, ByVal chans As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_StreamCreateFile Lib "bass" (ByVal mem As Integer, ByVal f As String, ByVal offset As Integer, ByVal length As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_StreamCreateURL Lib "bass" (ByVal url As String, ByVal offset As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_StreamCreateFileUser Lib "bass" (ByVal buffered As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Sub BASS_StreamFree Lib "bass" (ByVal handle As Integer)
Declare Function BASS_StreamGetLength Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_StreamGetTags Lib "bass" (ByVal handle As Integer, ByVal tags As Integer) As byte ptr
Declare Function BASS_StreamPreBuf Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_StreamPlay Lib "bass" (ByVal handle As Integer, ByVal flush As Integer, ByVal flags As Integer) As Integer
Declare Function BASS_StreamGetFilePosition Lib "bass" (ByVal handle As Integer, ByVal mode As Integer) As Integer

Declare Function BASS_RecordGetDeviceDescription Lib "bass" (ByVal device As Integer) As byte ptr
Declare Function BASS_RecordInit Lib "bass" (ByVal device As Integer) As Integer
Declare Function BASS_RecordSetDevice Lib "bass" (ByVal device As Integer) As Integer
Declare Function BASS_RecordGetDevice Lib "bass" () As Integer
Declare Function BASS_RecordFree Lib "bass" () As Integer
Declare Function BASS_RecordGetInfo Lib "bass" (Byval info As BASS_RECORDINFO ptr) As Integer
Declare Function BASS_RecordGetInputName Lib "bass" (ByVal inputn As Integer) As byte ptr
Declare Function BASS_RecordSetInput Lib "bass" (ByVal inputn As Integer, ByVal setting As Integer) As Integer
Declare Function BASS_RecordGetInput Lib "bass" (ByVal inputn As Integer) As Integer
Declare Function BASS_RecordStart Lib "bass" (ByVal freq As Integer, ByVal flags As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer

Declare Function BASS_ChannelBytes2Seconds64 Lib "bass" Alias "BASS_ChannelBytes2Seconds" (ByVal handle As Integer, ByVal pos As Integer, ByVal poshigh As Integer) As Single
Declare Function BASS_ChannelSeconds2Bytes Lib "bass" (ByVal handle As Integer, ByVal pos As Single) As Integer
Declare Function BASS_ChannelGetDevice Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelIsActive Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetInfo Lib "bass" (ByVal handle As Integer, Byval info As BASS_CHANNELINFO ptr) As Integer
Declare Function BASS_ChannelStop Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelPause Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelResume Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelSetAttributes Lib "bass" (ByVal handle As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer) As Integer
Declare Function BASS_ChannelGetAttributes Lib "bass" (ByVal handle As Integer, Byval freq As Integer ptr, Byval volume As Integer ptr, Byval pan As Integer ptr) As Integer
Declare Function BASS_ChannelSlideAttributes Lib "bass" (ByVal handle As Integer, ByVal freq As Integer, ByVal volume As Integer, ByVal pan As Integer, ByVal time As Integer) As Integer
Declare Function BASS_ChannelIsSliding Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelSet3DAttributes Lib "bass" (ByVal handle As Integer, ByVal mode As Integer, ByVal min As Single, ByVal max As Single, ByVal iangle As Integer, ByVal oangle As Integer, ByVal outvol As Integer) As Integer
Declare Function BASS_ChannelGet3DAttributes Lib "bass" (ByVal handle As Integer, Byval mode As Integer ptr, Byval min As Single ptr, Byval max As Single ptr, Byval iangle As Integer ptr, Byval oangle As Integer ptr, Byval outvol As Integer ptr) As Integer
Declare Function BASS_ChannelSet3DPosition Lib "bass" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_ChannelGet3DPosition Lib "bass" (ByVal handle As Integer, Byval pos As Any ptr, Byval orient As Any ptr, Byval vel As Any ptr) As Integer
Declare Function BASS_ChannelSetPosition64 Lib "bass" Alias "BASS_ChannelSetPosition" (ByVal handle As Integer, ByVal pos As Integer, ByVal poshigh As Integer) As Integer
Declare Function BASS_ChannelGetPosition Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetLevel Lib "bass" (ByVal handle As Integer) As Integer
Declare Function BASS_ChannelGetData Lib "bass" (ByVal handle As Integer, Byval buffer As Any ptr, ByVal length As Integer) As Integer
Declare Function BASS_ChannelSetSync64 Lib "bass" Alias "BASS_ChannelSetSync" (ByVal handle As Integer, ByVal atype As Integer, ByVal param As Integer, ByVal paramhigh As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
Declare Function BASS_ChannelRemoveSync Lib "bass" (ByVal handle As Integer, ByVal sync As Integer) As Integer
Declare Function BASS_ChannelSetDSP Lib "bass" (ByVal handle As Integer, ByVal proc As Integer, ByVal user As Integer, ByVal priority As Integer) As Integer
Declare Function BASS_ChannelRemoveDSP Lib "bass" (ByVal handle As Integer, ByVal dsp As Integer) As Integer
Declare Function BASS_ChannelSetEAXMix Lib "bass" (ByVal handle As Integer, ByVal mix As Single) As Integer
Declare Function BASS_ChannelGetEAXMix Lib "bass" (ByVal handle As Integer, Byval mix As Single ptr) As Integer
Declare Function BASS_ChannelSetLink Lib "bass" (ByVal handle As Integer, ByVal chan As Integer) As Integer
Declare Function BASS_ChannelRemoveLink Lib "bass" (ByVal handle As Integer, ByVal chan As Integer) As Integer
Declare Function BASS_ChannelSetFX Lib "bass" (ByVal handle As Integer, ByVal atype As Integer) As Integer
Declare Function BASS_ChannelRemoveFX Lib "bass" (ByVal handle As Integer, ByVal fx As Integer) As Integer
Declare Function BASS_FXSetParameters Lib "bass" (ByVal handle As Integer, Byval par As Any ptr) As Integer
Declare Function BASS_FXGetParameters Lib "bass" (ByVal handle As Integer, Byval par As Any ptr) As Integer



'*******************************************
' 32-bit wrappers for 64-bit BASS functions
'*******************************************

private Function BASS_ChannelBytes2Seconds(ByVal handle As Integer, ByVal bpos As Integer) As Single
    BASS_ChannelBytes2Seconds = BASS_ChannelBytes2Seconds64(handle, bpos, 0)
End Function

private Function BASS_ChannelSetPosition(ByVal handle As Integer, ByVal bpos As Integer) As Integer
    BASS_ChannelSetPosition = BASS_ChannelSetPosition64(handle, bpos, 0)
End Function

private Function BASS_ChannelSetSync(ByVal handle As Integer, ByVal atype As Integer, ByVal param As Integer, ByVal proc As Integer, ByVal user As Integer) As Integer
    BASS_ChannelSetSync = BASS_ChannelSetSync64(handle, atype, param, 0, proc, user)
End Function


private Function BASS_SetEAXPreset (byval presetnum as integer) As Integer
    ' This function is a workaround, because FB doesn't support multiple comma seperated
    ' paramaters for each Const, simply pass the EAX_ENVIRONMENT_xxx value to this function
    ' instead of BASS_SetEAXParameters as you would do in C++
    Select Case presetnum
        Case EAX_ENVIRONMENT_GENERIC
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_GENERIC, 0.5, 1.493, 0.5)
        Case EAX_ENVIRONMENT_PADDEDCELL
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_PADDEDCELL, 0.25, 0.1, 0)
        Case EAX_ENVIRONMENT_ROOM
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_ROOM, 0.417, 0.4, 0.666)
        Case EAX_ENVIRONMENT_BATHROOM
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_BATHROOM, 0.653, 1.499, 0.166)
        Case EAX_ENVIRONMENT_LIVINGROOM
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_LIVINGROOM, 0.208, 0.478, 0)
        Case EAX_ENVIRONMENT_STONEROOM
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_STONEROOM, 0.5, 2.309, 0.888)
        Case EAX_ENVIRONMENT_AUDITORIUM
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_AUDITORIUM, 0.403, 4.279, 0.5)
        Case EAX_ENVIRONMENT_CONCERTHALL
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_CONCERTHALL, 0.5, 3.961, 0.5)
        Case EAX_ENVIRONMENT_CAVE
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_CAVE, 0.5, 2.886, 1.304)
        Case EAX_ENVIRONMENT_ARENA
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_ARENA, 0.361, 7.284, 0.332)
        Case EAX_ENVIRONMENT_HANGAR
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_HANGAR, 0.5, 10, 0.3)
        Case EAX_ENVIRONMENT_CARPETEDHALLWAY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_CARPETEDHALLWAY, 0.153, 0.259, 2)
        Case EAX_ENVIRONMENT_HALLWAY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_HALLWAY, 0.361, 1.493, 0)
        Case EAX_ENVIRONMENT_STONECORRIDOR
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_STONECORRIDOR, 0.444, 2.697, 0.638)
        Case EAX_ENVIRONMENT_ALLEY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_ALLEY, 0.25, 1.752, 0.776)
        Case EAX_ENVIRONMENT_FOREST
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_FOREST, 0.111, 3.145, 0.472)
        Case EAX_ENVIRONMENT_CITY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_CITY, 0.111, 2.767, 0.224)
        Case EAX_ENVIRONMENT_MOUNTAINS
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_MOUNTAINS, 0.194, 7.841, 0.472)
        Case EAX_ENVIRONMENT_QUARRY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_QUARRY, 1, 1.499, 0.5)
        Case EAX_ENVIRONMENT_PLAIN
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_PLAIN, 0.097, 2.767, 0.224)
        Case EAX_ENVIRONMENT_PARKINGLOT
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_PARKINGLOT, 0.208, 1.652, 1.5)
        Case EAX_ENVIRONMENT_SEWERPIPE
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_SEWERPIPE, 0.652, 2.886, 0.25)
        Case EAX_ENVIRONMENT_UNDERWATER
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_UNDERWATER, 1, 1.499, 0)
        Case EAX_ENVIRONMENT_DRUGGED
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_DRUGGED, 0.875, 8.392, 1.388)
        Case EAX_ENVIRONMENT_DIZZY
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_DIZZY, 0.139, 17.234, 0.666)
        Case EAX_ENVIRONMENT_PSYCHOTIC
            BASS_SetEAXPreset = BASS_SetEAXParameters(EAX_ENVIRONMENT_PSYCHOTIC, 0.486, 7.563, 0.806)
    End Select
End Function