''
'' MCI helper
''

option explicit
'$include: 'win\mmsystem.bi'

'':::::
function winmmCreate as integer

	winmmCreate = -1

end function

'':::::
function winmmRelease as integer

	winmmRelease = -1

end function

''
'' MIDI
''

'':::::
function winmmInitMidi as integer

    winmmInitMidi = mciSendString( "open sequencer", byval NULL, 0, 0 ) = 0

end function

'':::::	
function winmmEndMidi as integer
    
	winmmEndMidi = mciSendString( "close sequencer", byval NULL, 0, 0 ) = 0
	
end function

'':::::
function winmmPlayMidi( filename as string ) as integer
    
    if( mciSendString( "open " + filename + " alias mymidifile", byval NULL, 0, 0 ) <> 0 ) then
    	winmmPlayMidi = 0
    	exit function
	end if
    
    winmmPlayMidi = mciSendString( "play mymidifile", byval NULL, 0, 0 ) = 0
    
end function

'':::::
function winmmStopMidi( ) as integer
    
    mciSendString( "stop mymidifile", byval NULL, 0, 0 )

    winmmStopMidi = mciSendString( "close mymidifile", byval NULL, 0, 0 ) = 0
    
end function

''
'' WAV
''

'':::::
function winmmInitWave as integer

	winmmInitWave = -1

end function

'':::::
function winmmEndWave as integer

	winmmEndWave = -1

end function

'':::::
function winmmPlayWave( filename as string ) as integer

	winmmPlayWave = sndPlaySound( filename, SND_ASYNC )
	
end function

'':::::
function winmmStopWave as integer

	winmmStopWave = -1

end function

