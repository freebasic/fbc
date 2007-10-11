

#include once "bassmod.bi"

const MusicFile = "data/dne_trtn.mod"

	if( BASSMOD_GetVersion( ) < 2 ) then
		print "Error: BASSMOD version 2 or above required"
		end 1
	end if
	
	if( BASSMOD_Init( -1, 44100, 0 ) = 0 ) then
		print "Error: BASSMOD_Init failed"
		end 1
	end if
	
	if( BASSMOD_MusicLoad( FALSE, MusicFile, 0, 0, BASS_MUSIC_LOOP ) = 0 ) then
		print "Error: BASS_MusicLoad failed"
		BASSMOD_Free
		end 1
	end if
	
	BASSMOD_MusicPlay( )
	
	print "Press any key to exit..."
	sleep
	
	BASSMOD_MusicStop( )
	BASSMOD_MusicFree( )
	
	BASSMOD_Free
	
	