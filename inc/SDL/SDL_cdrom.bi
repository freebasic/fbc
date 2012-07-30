''
''
'' SDL_cdrom -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __SDL_cdrom_bi__
#define __SDL_cdrom_bi__

#include once "SDL_types.bi"
#include once "begin_code.bi"

#define SDL_MAX_TRACKS 99
#define SDL_AUDIO_TRACK &h00
#define SDL_DATA_TRACK &h04

enum CDstatus
	CD_TRAYEMPTY
	CD_STOPPED
	CD_PLAYING
	CD_PAUSED
	CD_ERROR = -1
end enum

#define CD_INDRIVE(status) (cint(status) > 0)

type SDL_CDtrack
	id as Uint8
	type as Uint8
	unused as Uint16
	length as Uint32
	offset as Uint32
end type

type SDL_CD
	id as integer
	status as CDstatus
	numtracks as integer
	cur_track as integer
	cur_frame as integer
	track(0 to SDL_MAX_TRACKS-1) as SDL_CDtrack
end type

#define CD_FPS 75

#define FRAMES_TO_MSF(frames,M,S,F)			_
	scope									:_
		dim as integer value				:_
		value = frames						:_
		*(F) = value mod CD_FPS				:_
		value \= CD_FPS						:_
		*(S) = value mod 60					:_
		value \= 60							:_
		*(M) = value						:_
	end scope

#define MSF_TO_FRAMES(M,S,F)	((M)*60*CD_FPS+(S)*CD_FPS+(F))

declare function SDL_CDNumDrives cdecl alias "SDL_CDNumDrives" () as integer
declare function SDL_CDName cdecl alias "SDL_CDName" (byval drive as integer) as zstring ptr
declare function SDL_CDOpen cdecl alias "SDL_CDOpen" (byval drive as integer) as SDL_CD ptr
declare function SDL_CDStatus cdecl alias "SDL_CDStatus" (byval cdrom as SDL_CD ptr) as CDstatus
declare function SDL_CDPlayTracks cdecl alias "SDL_CDPlayTracks" (byval cdrom as SDL_CD ptr, byval start_track as integer, byval start_frame as integer, byval ntracks as integer, byval nframes as integer) as integer
declare function SDL_CDPlay cdecl alias "SDL_CDPlay" (byval cdrom as SDL_CD ptr, byval start as integer, byval length as integer) as integer
declare function SDL_CDPause cdecl alias "SDL_CDPause" (byval cdrom as SDL_CD ptr) as integer
declare function SDL_CDResume cdecl alias "SDL_CDResume" (byval cdrom as SDL_CD ptr) as integer
declare function SDL_CDStop cdecl alias "SDL_CDStop" (byval cdrom as SDL_CD ptr) as integer
declare function SDL_CDEject cdecl alias "SDL_CDEject" (byval cdrom as SDL_CD ptr) as integer
declare sub SDL_CDClose cdecl alias "SDL_CDClose" (byval cdrom as SDL_CD ptr)

#include once "close_code.bi"

#endif
