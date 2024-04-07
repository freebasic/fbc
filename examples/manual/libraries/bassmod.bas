'' examples/manual/libraries/bassmod.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'BASSMOD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibbassmod
'' --------

#include Once "bassmod.bi"

Const SOUND_FILE = "test.mod"

If (BASSMOD_GetVersion() < 2) Then
	Print "BASSMOD version 2 or above required!"
	End 1
End If

If (BASSMOD_Init(-1, 44100, 0) = 0) Then
	Print "Could not initialize BASSMOD"
	End 1
End If

If (BASSMOD_MusicLoad(False, SOUND_FILE, 0, 0, BASS_MUSIC_LOOP) = 0) Then
	Print "BASSMOD could not load '" & SOUND_FILE & "'"
	BASSMOD_Free()
	End 1
End If

BASSMOD_MusicPlay()

Print "Sound playing; waiting for keypress to stop and exit..."
Sleep

BASSMOD_MusicStop()
BASSMOD_MusicFree()
BASSMOD_Free()
