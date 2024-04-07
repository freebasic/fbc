'' examples/manual/system/sleep2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SLEEP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSleep
'' --------

Dim As String s

Print "wait 3 seconds or press a key"
Sleep 3000
Print "outputed by timeout or key pressed"
While Inkey <> ""  '' loop until the keyboard input buffer is empty
Wend

Input "enter a string"; s
Print "string entered: " & "'" & s & "'"

Sleep
	
