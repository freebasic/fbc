' SDL-cdrom.h header ported to freeBasic by Edmond Leung (leung.edmond@gmail.com)

'$inclib: "SDL"

#ifndef SDL_cdrom_bi_
#define SDL_cdrom_bi_

'$include: 'SDL/SDL_types.bi'

'$include: 'SDL/begin_code.bi'

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

private function CD_INDRIVE(byval status as integer) as byte
   CD_INDRIVE = status > 0
end function

type SDL_CDTrack
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
   track(SDL_MAX_TRACKS) as SDL_CDTrack
end type

#define CD_FPS 75
private sub FRAMES_TO_MSF _
   (byval f as integer, byval M as integer ptr, byval S as integer ptr, _
   byval Fr as integer ptr)
   dim value as integer
   value = f
   *Fr = value mod CD_FPS
   value = value \ CD_FPS
   *S = value mod 60
   value = value \ 60
   *M = value
end sub
private function MSF_TO_FRAMES _
   (byval M as integer, byval S as integer, byval F as integer) as integer
   MSF_TO_FRAMES = M * 60 * CD_FPS + S * CD_FPS + F
end function

declare function SDL_CDNumDrives SDLCALL alias "SDL_CDNumDrives" () as integer

declare function SDL_CDName SDLCALL alias "SDL_CDName" _
   (byval drive as integer) as byte ptr

declare function SDL_CDOpen SDLCALL alias "SDL_CDOpen" _
   (byval drive as integer) as SDL_CD ptr

declare function SDL_CDStatus SDLCALL alias "SDL_CDStatus" _
   (byval cdrom as SDL_CD ptr) as CDstatus

declare function SDL_CDPlayTracks SDLCALL alias "SDL_CDPlayTracks" _
   (byval cdrom as SDL_CD ptr, byval start_track as integer, _
   byval start_frame as integer, byval ntracks as integer, _
   byval nframes as integer) as integer

declare function SDL_CDPlay SDLCALL alias "SDL_CDPlay" _
   (byval cdrom as SDL_CD ptr, start as integer, length as integer) as integer

declare function SDL_CDPause SDLCALL alias "SDL_CDPause" _
   (byval cdrom as SDL_CD ptr) as integer

declare function SDL_CDResume SDLCALL alias "SDL_CDResume" _
   (byval cdrom as SDL_CD ptr) as integer

declare function SDL_CDStop SDLCALL alias "SDL_CDStop" _
   (byval cdrom as SDL_CD ptr) as integer

declare function SDL_CDEject SDLCALL alias "SDL_CDEject" _
   (byval cdrom as SDL_CD ptr) as integer

declare function SDL_CDClose SDLCALL alias "SDL_CDClose" _
   (byval cdrom as SDL_CD ptr) as integer

'$include: 'SDL/close_code.bi'

#endif