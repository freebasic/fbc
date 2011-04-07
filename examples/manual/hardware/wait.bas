'' examples/manual/hardware/wait.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWait
'' --------

Wait &h3da, &h8 'Old Qbasic way of waiting for the monitor's vsync
ScreenSync 'FreeBASIC way of accomplishing the same thing
