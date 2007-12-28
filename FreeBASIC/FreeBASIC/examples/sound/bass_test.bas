

#include once "bass.bi"

const MusicFile = "data/dne_trtn.mod"

	if( BASS_GetVersion( ) < MAKELONG(2,2) ) then
		print "Error: BASS version 2.2 or above required"
		end 1
	end if
	
	if( BASS_Init( -1, 44100, 0, 0, 0 ) = 0 ) then
		print "Error: BASS_Init failed"
		end 1
	end if
	
	dim as HMUSIC test 
	test = BASS_MusicLoad( FALSE, MusicFile, 0, 0, BASS_MUSIC_LOOP, 0 )
	if( test = 0 ) then
		print "Error: BASS_MusicLoad failed"
		BASS_Free
		end 1
	end if
	
	BASS_ChannelPlay( test, FALSE )
	
	print "Press any key to exit..."
	sleep
	
	BASS_ChannelStop( test )
	
	BASS_MusicFree( test )
	
	''	
	BASS_Stop
	BASS_Free
	
	