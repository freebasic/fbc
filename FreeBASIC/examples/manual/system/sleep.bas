'' examples/manual/system/sleep.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSleep
'' --------

Print "press a key"
Sleep
GetKey 'clear the keyboard buffer
Print "waiting half second"
Sleep 500
