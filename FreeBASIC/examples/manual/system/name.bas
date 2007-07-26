'' examples/manual/system/name.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgName
'' --------

Dim OldName As String
Dim NewName As String
Dim result As Integer 

OldName = "dsc001.jpg"
NewName = "landscape.jpg"

result = Name( OldName, NewName )
If 0 <> result Then 
	Print "error renaming " & oldname & " to " & newname & "."
End If
