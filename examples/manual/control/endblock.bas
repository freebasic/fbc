'' examples/manual/control/endblock.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'END (Block)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEndblock
'' --------

Declare Sub checkvalue( n As Integer )

Dim variable As Integer

Input "Give me a number: ", variable
If variable = 1 Then
Print "You gave me a 1"
Else
Print "You gave me a big number!"
End If
checkvalue(variable)

Sub checkvalue( n As Integer )
Print "Value is: " & n
End Sub
