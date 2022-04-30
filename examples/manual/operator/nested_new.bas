'' examples/manual/operator/nested_new.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator New Expression'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpNew
'' --------

'' Example of nested New [] to get a 2-dimentional object array (4*3)

Type UDT
	Dim As Integer N
	Declare Constructor ()
	Declare Destructor ()
End Type

Constructor UDT ()
	Print "Constructor",
End Constructor

Destructor UDT ()
	Print "Destructor",
End Destructor

Dim As UDT Ptr Ptr p = New UDT Ptr [4]  '' New [] allocation for the first dimension:
										''   no internal allocation of extra uinteger because
										''   allocation of array of pointers (to UDT objects with destructor)
For I As Integer = 0 To 3
	p[I] = New UDT [5]                  '' New [] allocations for the last dimension:
										''   internal allocation of an extra uinteger for each New [],
										''   because allocation of an array of UDT objects with destructor
	Print
Next I

For I As Integer = 0 To 3
	For J As Integer = 0 To 4
		p[I][J].N = I * 10 + J  '' assignment of each object array element
	Next J
Next I

Print
For I As Integer = 0 To 3
	For J As Integer = 0 To 4
		Print p[I][J].N,        '' display of each object array element
	Next J
	Print
Next I
Print

For I As Integer = 0 To 3
	Delete [] p[I]  '' Delete [] deallocations for the last dimension
	Print
Next I
Delete [] p         '' Delete [] deallocation for the first dimension)
Print

Sleep
