'' examples/manual/system/name.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgName
'' --------

Dim result As Integer = Name( "dsc001.jpg", "landscape.jpg" )

If 0 <> result Then Print "error renaming " & oldname & " to " & newname & "."
