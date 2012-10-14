#include once "bassmod.bi"

dim as string sound_file = exepath() + "/../data/dne_trtn.mod"

If (BASSMOD_GetVersion() < 2) Then
    Print "BASSMOD version 2 or above required!"
    End 1
End If

If (BASSMOD_Init(-1, 44100, 0) = 0) Then
    Print "Could not initialize BASSMOD"
    End 1
End If

If (BASSMOD_MusicLoad(FALSE, sound_file, 0, 0, BASS_MUSIC_LOOP) = 0) Then
    Print "BASSMOD could not load '" & sound_file & "'"
    BASSMOD_Free()
    End 1
End If

BASSMOD_MusicPlay()

Print "Sound playing; waiting for keypress to stop and exit..."
Sleep

BASSMOD_MusicStop()
BASSMOD_MusicFree()
BASSMOD_Free()
