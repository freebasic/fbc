' BASSMOD 2.0 copyright (c) 1999-2004 Ian Luck.
' Please report bugs/suggestions/etc... to bassmod@un4seen.com
' See the BASSMOD.CHM file for more complete documentation

' FB header converted from bassmod.bas for VB by Plasma  [11-13-2004]
' Mostly untested, so don't be surprised if something doesn't work :P

Const BASSTRUE = 1
Const BASSFALSE = 0

' Error codes returned by BASSMOD_GetErrorCode()
Const BASS_OK = 0              ' all is OK
Const BASS_ERROR_MEM = 1       ' memory error
Const BASS_ERROR_FILEOPEN = 2  ' can't open the file
Const BASS_ERROR_DRIVER = 3    ' can't find a free/valid driver
Const BASS_ERROR_HANDLE = 5    ' invalid handle
Const BASS_ERROR_FORMAT = 6    ' unsupported format
Const BASS_ERROR_POSITION = 7  ' invalid playback position
Const BASS_ERROR_INIT = 8      ' BASS_Init has not been successfully called
Const BASS_ERROR_ALREADY = 14  ' already initialized/loaded
Const BASS_ERROR_NOPAUSE = 16  ' not paused
Const BASS_ERROR_ILLTYPE = 19  ' an illegal type was specified
Const BASS_ERROR_ILLPARAM = 20 ' an illegal parameter was specified
Const BASS_ERROR_DEVICE = 23   ' illegal device number
Const BASS_ERROR_NOPLAY = 24   ' not playing
Const BASS_ERROR_NOMUSIC = 28  ' no MOD music has been loaded
Const BASS_ERROR_NOSYNC = 30   ' synchronizers have been disabled
Const BASS_ERROR_NOTAVAIL = 37 ' requested data is not available
Const BASS_ERROR_DECODE = 38   ' the channel is a "decoding channel"
Const BASS_ERROR_FILEFORM = 41 ' unsupported file format
Const BASS_ERROR_UNKNOWN = -1  ' some other mystery error

' Device setup flags
Const BASS_DEVICE_8BITS = 1    ' use 8 bit resolution, else 16 bit
Const BASS_DEVICE_MONO = 2     ' use mono, else stereo
Const BASS_DEVICE_NOSYNC = 16  ' disable synchronizers

' Music flags
Const BASS_MUSIC_RAMP = 1            ' normal ramping
Const BASS_MUSIC_RAMPS = 2           ' sensitive ramping
Const BASS_MUSIC_LOOP = 4            ' loop music
Const BASS_MUSIC_FT2MOD = 16         ' play .MOD as FastTracker 2 does
Const BASS_MUSIC_PT1MOD = 32         ' play .MOD as ProTracker 1 does
Const BASS_MUSIC_POSRESET = 256      ' stop all notes when moving position
Const BASS_MUSIC_SURROUND = 512      ' surround sound
Const BASS_MUSIC_SURROUND2 = 1024    ' surround sound (mode 2)
Const BASS_MUSIC_STOPBACK = 2048     ' stop the music on a backwards jump effect
Const BASS_MUSIC_CALCLEN = 8192      ' calculate playback length
Const BASS_MUSIC_NONINTER = 16384    ' non-interpolated mixing
Const BASS_MUSIC_NOSAMPLE = &H400000 ' don't load the samples

Const BASS_UNICODE = &H80000000

' Sync types (with BASSMOD_MusicSetSync() "param" and SYNCPROC "data"
' definitions) & flags.

Const BASS_SYNC_POS = 0
Const BASS_SYNC_MUSICPOS = 0
' Sync when the music reaches a position.
' param: LOWORD=order (0=first, -1=all) HIWORD=row (0=first, -1=all)
' data : LOWORD=order HIWORD=row

Const BASS_SYNC_MUSICINST = 1
' Sync when an instrument (sample for the non-instrument based formats)
' is played in the music (not including retrigs).
' param: LOWORD=instrument (1=first) HIWORD=note (0=c0...119=b9, -1=all)
' data : LOWORD=note HIWORD=volume (0-64)

Const BASS_SYNC_END = 2
' Sync when the music reaches the end.
' param: not used
' data : not used

Const BASS_SYNC_MUSICFX = 3
' Sync when the "sync" effect (XM/MTM/MOD: E8x/Wxx, IT/S3M: S2x) is used.
' param: 0:data=pos, 1:data="x" value
' data : param=0: LOWORD=order HIWORD=row, param=1: "x" value

Const BASS_SYNC_ONETIME = 2147483648 ' FLAG: sync only once, else continuously
' Sync callback function. NOTE: a sync callback function should be very
' quick (eg. just posting a message) as other syncs cannot be processed
' until it has finished.
' handle : The sync that has occured
' data   : Additional data associated with the sync's occurance

' BASSMOD_MusicIsActive return values
Const BASS_ACTIVE_STOPPED = 0
Const BASS_ACTIVE_PLAYING = 1
Const BASS_ACTIVE_PAUSED = 3

Declare Function BASSMOD_GetVersion Lib "bassmod" () As Integer
Declare Function BASSMOD_ErrorGetCode Lib "bassmod" () As Integer
Declare Function BASSMOD_GetDeviceDescription Lib "bassmod" (ByVal devnum As Integer) As byte ptr
Declare Function BASSMOD_Init Lib "bassmod" (ByVal device As Integer, ByVal freq As Integer, ByVal flags As Integer) As Integer
Declare Sub BASSMOD_Free Lib "bassmod" ()
Declare Function BASSMOD_GetCPU Lib "bassmod" () As Single
Declare Function BASSMOD_SetVolume Lib "bassmod" (ByVal volume As Integer) As Integer
Declare Function BASSMOD_GetVolume Lib "bassmod" () As Integer

Declare Function BASSMOD_MusicLoad Lib "bassmod" (ByVal mem As Integer, ByVal pfile As String, ByVal offset As Integer, ByVal length As Integer, ByVal flags As Integer) As Integer
Declare Sub BASSMOD_MusicFree Lib "bassmod" ()
Declare Function BASSMOD_MusicGetName lib "bassmod" () as byte ptr
Declare Function BASSMOD_MusicGetLength Lib "bassmod" (ByVal playlen As Integer) As Integer
Declare Function BASSMOD_MusicPlay Lib "bassmod" () As Integer
Declare Function BASSMOD_MusicPlayEx Lib "bassmod" (ByVal pos As Integer, ByVal flags As Integer, ByVal reset As Integer) As Integer
Declare Function BASSMOD_MusicDecode Lib "bassmod" (Byval buffer As Any ptr, ByVal length As Integer) As Integer
Declare Function BASSMOD_MusicSetAmplify Lib "bassmod" (ByVal amp As Integer) As Integer
Declare Function BASSMOD_MusicSetPanSep Lib "bassmod" (ByVal pan As Integer) As Integer
Declare Function BASSMOD_MusicSetPositionScaler Lib "bassmod" (ByVal pscale As Integer) As Integer
Declare Function BASSMOD_MusicSetVolume Lib "bassmod" (ByVal chanins As Integer, ByVal volume As Integer) As Integer
Declare Function BASSMOD_MusicGetVolume Lib "bassmod" (ByVal chanins As Integer) As Integer

Declare Function BASSMOD_MusicIsActive Lib "bassmod" () As Integer
Declare Function BASSMOD_MusicStop Lib "bassmod" () As Integer
Declare Function BASSMOD_MusicPause Lib "bassmod" () As Integer
Declare Function BASSMOD_MusicSetPosition Lib "bassmod" (ByVal pos As Integer) As Integer
Declare Function BASSMOD_MusicGetPosition Lib "bassmod" () As Integer
Declare Function BASSMOD_MusicSetSync Lib "bassmod" (ByVal ptype As Integer, ByVal param As Integer, Byval proc as any ptr, ByVal user As Integer) As Integer
Declare Function BASSMOD_MusicRemoveSync Lib "bassmod" (ByVal sync As Integer) As Integer