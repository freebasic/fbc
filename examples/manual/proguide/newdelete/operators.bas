'' examples/manual/proguide/newdelete/operators.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'New and Delete'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgNewDelete
'' --------

Declare Sub printArray (ByRef label As String = "", array() As String)


Type UDT
	Declare Constructor ()
	Declare Destructor ()
	Declare Operator New (ByVal size As UInteger) As Any Ptr    ' Operator New Overload
	Declare Operator New[] (ByVal size As UInteger) As Any Ptr  ' Operator New[] Overload
	Declare Operator Delete (ByVal buf As Any Ptr)              ' Operator Delete Overload
	Declare Operator Delete[] (ByVal buf As Any Ptr)            ' Operator Delete[] Overload
	Dim As String array (1 To 4)
End Type

Constructor UDT ()
	Static As Integer n
	Print "    Constructor"
	printArray("        init: @" & @This & " (descriptors) -> ", This.array())
	For i As Integer = LBound(This.array) To UBound(This.array)
		This.array(i) = Chr(Asc("a") + n + i - LBound(This.array))
	Next i
	printArray(" => ", This.array())
	Print
	n += UBound(This.array)- LBound(This.array) + 1
End Constructor

Destructor UDT ()
	Print "    Destructor"
	printArray("        erase: @" & @This & " (descriptors) -> ", This.array())
	Erase This.array
	printArray(" => ", This.array())
	Print
End Destructor

Operator UDT.New (ByVal size As UInteger) As Any Ptr
	Print "    Operator New Overload"
	Dim As Any Ptr p = Allocate(size)                   ' Memory allocation (with passed size)
	Print "        memory allocation: ";
	Print size & " Bytes from @" & p
	Return p                                            ' Returning memory pointer
End Operator

Operator UDT.New[] (ByVal size As UInteger) As Any Ptr
	Print "    Operator New[] Overload"
	Dim As Any Ptr p = Allocate(size)                   ' Memory allocation (with passed size)
	Print "        memory allocation: ";
	Print size & " Bytes from @" & p
	Return p                                            ' Returning memory pointer
End Operator

Operator UDT.Delete (ByVal buf As Any Ptr)
	Print "    Operator Delete Overload"
	Deallocate(buf)                                     ' Memory deallocation (with passed pointer)
	Print "        memory deallocation: ";
	Print "for @" & buf
End Operator

Operator UDT.Delete[] (ByVal buf As Any Ptr)
	Print "    Operator Delete[] Overload"
	Deallocate(buf)                                     ' Memory deallocation (with passed pointer)
	Print "        memory deallocation: ";
	Print "for @" & buf
End Operator


Print "Operator New Expression"
Dim As UDT Ptr pu1 = New UDT         ' Operator New Expression
Print "Operator Delete Statement"
Delete pu1                           ' Operator Delete Statement
Sleep

Print
Print "Operator New[] Expression"      
Dim As UDT Ptr pu2 = New UDT[2]      ' Operator New[] Expression
Print "Operator Delete[] Statement"
Delete[] pu2                         ' Operator Delete[] Statement
Sleep

Dim As Byte buffer(1 To 256)
Dim As Any Ptr p = @buffer(1)

Print
Print "Operator Placement New"
Dim As UDT Ptr pu3 = New(p) UDT      ' Operator Placement New
Print "User call of Destructor"
pu3->Destructor()                    ' User Call of Destructor
Sleep

Print
Print "Operator Placement New[]"
Dim As UDT Ptr pu4 = New(p) UDT[2]   ' Operator Placement New[]
For i As Integer = 0 To 1
	Print "User Call of Destructor"
	pu4[i].Destructor()              ' User Call of Destructor
Next i
Sleep


Sub printArray (ByRef label As String = "", array() As String)
	Print label & "{";
	For i As Integer = LBound(array) To UBound(array)
		Print """" & array(i) & """";
		If i < UBound(array) Then
			Print ",";
		End If
	Next I
	Print "}";
End Sub
