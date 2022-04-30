'' examples/manual/udt/type-fctptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Type (Alias)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgTypeAlias
'' --------

Function triple (ByVal i As Integer) As Integer
	Return 3 * i
End Function

Type As Function (ByVal As Integer) As Integer function_alias

'Dim As Function (Byval As Integer) As Integer f  ''this syntax works but is less readable than the next code line
Dim As function_alias f
f = @triple
Print f(123)

'Dim As Function (Byval As Integer) As Integer Ptr pf  ''this syntax does not work because Ptr applies on Integer and not on function
Dim As function_alias Ptr pf                           ''this syntax works
pf = @f
Print (*pf)(123)  ''the dereferenced pointer to procedure pointer must be enclosed in parentheses
