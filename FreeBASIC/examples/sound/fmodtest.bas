'Simple FMOD test for FB
'by Plasma  [11-16-2004]

#include once "fmod.bi"

declare sub ErrorQuit( byval Message as string )

const FALSE = 0
const MusicFile = "dne_trtn.mod"
	
	dim Shared Handle as long

	if( FSOUND_GetVersion() < FMOD_VERSION ) then
  		ErrorQuit( "FMOD version " + STR(FMOD_VERSION) + " or greater required" )
	end if

	if( FSOUND_Init(44100, 32, 0) = FALSE ) then
  		ErrorQuit( "Can't initialize FMOD" )
	end if

	Handle = FMUSIC_LoadSong( MusicFile )
	if Handle = FALSE then
  		ErrorQuit( "Can't load music file """ + MusicFile + """" )
	end if

	FMUSIC_PlaySong( Handle )

	print "Press any key to exit..."
	sleep

	FMUSIC_FreeSong( Handle )
	FSOUND_Close

	end


sub ErrorQuit( byval Message as string )

  print "ERROR: "; Message
  FMUSIC_FreeSong( Handle )
  FSOUND_Close
  end 1

end sub

