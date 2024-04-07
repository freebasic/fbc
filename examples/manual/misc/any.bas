'' examples/manual/misc/any.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ANY'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAny
'' --------

Declare Sub echo(ByVal x As Any Ptr) '' echo will accept any pointer type

Dim As Integer a(0 To 9) = Any '' this variable is not initialized
Dim As Double  d(0 To 4)

Dim p As Any Ptr

Dim pa As Integer Ptr = @a(0)
Print "Not initialized ";
echo pa       '' pass to echo a pointer to integer

Dim pd As Double Ptr = @d(0)
Print "Initialized ";
echo pd       '' pass to echo a pointer to double

p = pa     '' assign to p a pointer to integer
p = pd     '' assign to p a pointer to double      

Sleep

Sub echo (ByVal x As Any Ptr)
	Dim As Integer i
	For i = 0 To 39
		'echo interprets the data in the pointer as bytes
		Print Cast(UByte Ptr, x)[i] & " ";
	Next
	Print
End Sub
