'' examples/manual/system/sleep.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SLEEP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSleep
'' --------

Print "press a key"
Sleep
GetKey  '' clear the keyboard input buffer, and even in that code case, the 'Sleep' keyword can be outright omitted
Print "waiting half second"
Sleep 500
	
