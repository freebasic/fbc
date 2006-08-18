''
'' MCI helper
''

#ifdef __FB_MAIN__
#error this is a module, not an application
#endif


#include once "windows.bi"
#include once "win/mmsystem.bi"

'':::::
function winmmCreate as integer

	function = -1

end function

'':::::
function winmmRelease as integer

	function = -1

end function

''
'' MIDI
''

'':::::
function winmmInitMidi as integer

    function = mciSendString( "open sequencer", NULL, 0, 0 ) = 0

end function

'':::::	
function winmmEndMidi as integer
    
	function = mciSendString( "close sequencer", NULL, 0, 0 ) = 0
	
end function

'':::::
function winmmPlayMidi( byval filename as string ) as integer
    
    if( mciSendString( "open " + filename + " alias mymidifile", NULL, 0, 0 ) <> 0 ) then
    	return 0
	end if
    
    function = mciSendString( "play mymidifile", NULL, 0, 0 ) = 0
    
end function

'':::::
function winmmStopMidi( ) as integer
    
    mciSendString( "stop mymidifile", NULL, 0, 0 )

    function = mciSendString( "close mymidifile", NULL, 0, 0 ) = 0
    
end function

''
'' WAV
''

'':::::
function winmmInitWave as integer

	function = -1

end function

'':::::
function winmmEndWave as integer

	function = -1

end function

'':::::
function winmmPlayWave( byval filename as string ) as integer

	function = sndPlaySound( filename, SND_ASYNC )
	
end function

'':::::
function winmmStopWave as integer

	function = -1

end function
