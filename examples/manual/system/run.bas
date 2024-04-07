'' examples/manual/system/run.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RUN'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRun
'' --------

'' Attempt to transfer control to "program.exe" in the current directory.
Dim result As Integer = Run("program.exe")

'' at this point, "program.exe" has failed to execute, and
'' result will be set to -1.
