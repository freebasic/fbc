'' examples/manual/libraries/fmod1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FMOD'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibfmod
'' --------

#include Once "fmod.bi"

Const SOUND_FILE = "test.mod"

If (FSOUND_GetVersion() < FMOD_VERSION) Then
	Print "FMOD version mismatch"
	End 1
End If

If (FSOUND_Init(44100, 32, 0) = 0) Then
	Print "Could not initialize FMOD"
	End 1
End If

Dim As FMUSIC_MODULE Ptr song = FMUSIC_LoadSong(SOUND_FILE)
If (song = 0) Then
	Print "FMOD could not load '" & SOUND_FILE & "'"
	FSOUND_Close()
	End 1
End If

FMUSIC_PlaySong(song)

Print "Sound playing; waiting for keypress to stop and exit..."
Sleep

FMUSIC_FreeSong(song)
FSOUND_Close()
