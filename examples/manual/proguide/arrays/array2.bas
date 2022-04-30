'' examples/manual/proguide/arrays/array2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Arrays'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrays
'' --------

' Declares and initializes an array of four integer elements.
Dim array(3) As Integer = { 10, 20, 30, 40 }

' Outputs all of the element values (" 10 20 30 40").
For position As Integer = LBound(array) To UBound(array)
	Print array(position) ;
Next
	
