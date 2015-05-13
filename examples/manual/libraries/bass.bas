'' examples/manual/libraries/bass.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibbass
'' --------

#include once "bass.bi"

Const SOUND_FILE = "test.mod"

If (BASS_GetVersion() < MAKELONG(2,2)) Then
	Print "BASS version 2.2 or above required!"
	End 1
End If

If (BASS_Init(-1, 44100, 0, 0, 0) = 0) Then
	Print "Could not initialize BASS"
	End 1
End If

Dim As HMUSIC test = BASS_MusicLoad(FALSE, SOUND_FILE, 0, 0, BASS_MUSIC_LOOP, 0)
If (test = 0) Then
	Print "BASS could not load '" & SOUND_FILE & "'"
	BASS_Free()
	End 1
End If

BASS_ChannelPlay(test, FALSE)

Print "Sound playing; waiting to keypress to stop and exit..."
Sleep

BASS_ChannelStop(test)
BASS_MusicFree(test)
BASS_Stop()
BASS_Free()
