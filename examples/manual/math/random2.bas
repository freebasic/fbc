'' examples/manual/math/random2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RANDOM'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandom
'' --------

Type ScoreEntry Field = 1
	As String * 20 Name
	As Single score
End Type

Dim As ScoreEntry entry

'' Generate a fake boring highscore file
Open "scores.dat" For Random Access Write As #1 Len = SizeOf(entry)
For i As Integer = 1 To 10
	entry.name = "Player " & i
	entry.score = i
	Put #1, i, entry
Next
Close #1

'' Read out and display the entries
Open "scores.dat" For Random Access Read As #1 Len = SizeOf(entry)
For i As Integer = 1 To 10
	Get #1, i, entry
	Print i & ":", entry.name, Str(entry.score), entry.score
Next
Close #1
