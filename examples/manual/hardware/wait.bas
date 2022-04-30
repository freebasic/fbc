'' examples/manual/hardware/wait.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'WAIT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgWait
'' --------

Wait &h3da, &h8 'Old Qbasic way of waiting for the monitor's vsync
ScreenSync 'FreeBASIC way of accomplishing the same thing
