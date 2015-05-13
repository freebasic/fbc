''
''
'' bassmod -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bassmod_bi__
#define __bassmod_bi__

#inclib "bassmod"

#ifdef __FB_WIN32__
# include once "win/wtypes.bi"
#else
type WORD as ushort
type DWORD as uinteger
type BOOL as integer
# define TRUE 1
# define FALSE 0
#define MAKELONG(a,b) cint( cushort(a) or (cuint(cushort(b)) shl 16) )
#endif '' __FB_WIN32__

#ifdef __FB_WIN32__
extern "Windows-MS"
#else
extern "C"
#endif

type HSYNC as DWORD

#define BASS_OK 0
#define BASS_ERROR_MEM 1
#define BASS_ERROR_FILEOPEN 2
#define BASS_ERROR_DRIVER 3
#define BASS_ERROR_HANDLE 5
#define BASS_ERROR_FORMAT 6
#define BASS_ERROR_POSITION 7
#define BASS_ERROR_INIT 8
#define BASS_ERROR_ALREADY 14
#define BASS_ERROR_ILLTYPE 19
#define BASS_ERROR_ILLPARAM 20
#define BASS_ERROR_DEVICE 23
#define BASS_ERROR_NOPLAY 24
#define BASS_ERROR_NOMUSIC 28
#define BASS_ERROR_NOSYNC 30
#define BASS_ERROR_NOTAVAIL 37
#define BASS_ERROR_DECODE 38
#define BASS_ERROR_FILEFORM 41
#define BASS_ERROR_UNKNOWN -1
#define BASS_DEVICE_8BITS 1
#define BASS_DEVICE_MONO 2
#define BASS_DEVICE_NOSYNC 16
#define BASS_MUSIC_RAMP 1
#define BASS_MUSIC_RAMPS 2
#define BASS_MUSIC_LOOP 4
#define BASS_MUSIC_FT2MOD 16
#define BASS_MUSIC_PT1MOD 32
#define BASS_MUSIC_POSRESET 256
#define BASS_MUSIC_SURROUND 512
#define BASS_MUSIC_SURROUND2 1024
#define BASS_MUSIC_STOPBACK 2048
#define BASS_MUSIC_CALCLEN 8192
#define BASS_MUSIC_NONINTER 16384
#define BASS_MUSIC_NOSAMPLE &h400000
#define BASS_UNICODE &h80000000
#define BASS_SYNC_MUSICPOS 0
#define BASS_SYNC_POS 0
#define BASS_SYNC_MUSICINST 1
#define BASS_SYNC_END 2
#define BASS_SYNC_MUSICFX 3
#define BASS_SYNC_ONETIME &h80000000

type SYNCPROC as sub(byval as HSYNC, byval as DWORD, byval as DWORD)

#define BASS_ACTIVE_STOPPED 0
#define BASS_ACTIVE_PLAYING 1
#define BASS_ACTIVE_PAUSED 3

declare function BASSMOD_GetVersion() as DWORD
declare function BASSMOD_ErrorGetCode() as DWORD
declare function BASSMOD_GetDeviceDescription(byval devnum as integer) as zstring ptr
declare function BASSMOD_Init(byval device as integer, byval freq as DWORD, byval flags as DWORD) as BOOL
declare sub BASSMOD_Free()
declare function BASSMOD_GetCPU() as single
declare function BASSMOD_SetVolume(byval volume as DWORD) as BOOL
declare function BASSMOD_GetVolume() as integer
declare function BASSMOD_MusicLoad(byval mem as BOOL, byval file as zstring ptr, byval offset as DWORD, byval length as DWORD, byval flags as DWORD) as BOOL
declare sub BASSMOD_MusicFree()
declare function BASSMOD_MusicGetName() as zstring ptr
declare function BASSMOD_MusicGetLength(byval playlen as BOOL) as DWORD
declare function BASSMOD_MusicPlay() as BOOL
declare function BASSMOD_MusicPlayEx(byval pos as DWORD, byval flags as integer, byval reset as BOOL) as BOOL
declare function BASSMOD_MusicDecode(byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASSMOD_MusicSetAmplify(byval amp as DWORD) as BOOL
declare function BASSMOD_MusicSetPanSep(byval pan as DWORD) as BOOL
declare function BASSMOD_MusicSetPositionScaler(byval scale as DWORD) as BOOL
declare function BASSMOD_MusicSetVolume(byval chanins as DWORD, byval volume as DWORD) as BOOL
declare function BASSMOD_MusicGetVolume(byval chanins as DWORD) as DWORD
declare function BASSMOD_MusicIsActive() as DWORD
declare function BASSMOD_MusicStop() as BOOL
declare function BASSMOD_MusicPause() as BOOL
declare function BASSMOD_MusicSetPosition(byval pos as DWORD) as BOOL
declare function BASSMOD_MusicGetPosition() as DWORD
declare function BASSMOD_MusicSetSync(byval type as DWORD, byval param as DWORD, byval proc as SYNCPROC ptr, byval user as DWORD) as HSYNC
declare function BASSMOD_MusicRemoveSync(byval sync as HSYNC) as BOOL

end extern

#endif
