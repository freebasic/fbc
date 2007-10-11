'' examples/manual/system/run.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRun
'' --------

'' Attempt to transfer control to "program.exe" in the current directory.
Dim result As Integer = Run("program.exe")

'' at this point, "program.exe" has failed to execute, and
'' result will be set to -1.
