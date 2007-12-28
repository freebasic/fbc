'Simple FMOD test for FB
'by Plasma  [11-16-2004]


#include once "fmod.bi"

declare sub ErrorQuit( byval Message as string )

const FALSE = 0
const MusicFile = "data/dne_trtn.mod"
	
	dim song as FMUSIC_MODULE ptr 

	if( FSOUND_GetVersion() < FMOD_VERSION ) then
  		ErrorQuit( "FMOD version " & FMOD_VERSION & " or greater required" )
	end if

	if( FSOUND_Init(44100, 32, 0) = FALSE ) then
  		ErrorQuit( "Can't initialize FMOD" )
	end if

	song = FMUSIC_LoadSong( MusicFile )
	if song = 0 then
  		ErrorQuit( "Can't load music file """ + MusicFile + """" )
	end if

	FMUSIC_PlaySong( song )

	print "Press any key to exit..."
	sleep

	FMUSIC_FreeSong( song )
	FSOUND_Close

	end


sub ErrorQuit( byval Message as string )

  print "ERROR: "; Message
  FSOUND_Close
  end 1

end sub

