'' examples/manual/proguide/arrays/passing.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Passing Arrays to Procedures'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgPassingArrays
'' --------

Declare Sub splitString(ByVal As String, (Any) As String, ByVal As UByte = Asc(","))


Dim As String s = "Programmer's Guide/Variables and Datatypes/Arrays/Passing Arrays to Procedures"
Dim As String array(Any)

splitString(s, array(), Asc("/"))

Print "STRING TO SPLIT:"
Print s
Print
Print "RESULT ARRAY FROM SPLITTING:"
For i As Integer = LBound(array) To UBound(array)
	Print i, array(i)
Next i

Sleep


Sub splitString(ByVal source As String, destination(Any) As String, ByVal delimitor As UByte)
	Do
		Dim As Integer position = InStr(1, source, Chr(delimitor))
		ReDim Preserve destination(UBound(destination) + 1)
		If position = 0 Then
			destination(UBound(destination)) = source
			Exit Do
		End If
		destination(UBound(destination)) = Left(source, position - 1)
		source = Mid(source, position + 1)
	Loop
End Sub
