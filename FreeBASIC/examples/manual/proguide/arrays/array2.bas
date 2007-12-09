'' examples/manual/proguide/arrays/array2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

' Declares and initializes an array of four integer elements.
Dim array(3) As Integer = { 10, 20, 30, 40 }

' Outputs all of the element values (" 10 20 30 40").
For position As Integer = LBound(array) To UBound(array)
	Print array(position) ;
Next
