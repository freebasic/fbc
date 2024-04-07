'' examples/manual/system/name.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'NAME'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgName
'' --------

Dim OldName As String
Dim NewName As String
Dim result As Long 

OldName = "dsc001.jpg"
NewName = "landscape.jpg"

result = Name( OldName, NewName )
If 0 <> result Then 
	Print "error renaming " & oldname & " to " & newname & "."
End If
