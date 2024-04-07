'' examples/manual/array/erase3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ERASE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErase
'' --------

Dim MyArray1(1 To 3, 4 To 9) As Integer
ReDim MyArray2(1 To 3, 4 To 9) As Integer

Print , "LOWER", "UPPER"
Print "MyArray1", _
	  LBound( MyArray1, 1 ); ", "; LBound( MyArray1, 2 ), _
	  UBound( MyArray1, 1 ); ", "; UBound( MyArray1, 2 )
Print "MyArray2", _
	  LBound( MyArray2, 1 ); ", "; LBound( MyArray2, 2 ), _
	  UBound( MyArray2, 1 ); ", "; UBound( MyArray2, 2 )

Erase MyArray1, MyArray2

Print
Print "MyArray1", _
	  LBound( MyArray1, 1 ); ", "; LBound( MyArray1, 2 ), _
	  UBound( MyArray1, 1 ); ", "; UBound( MyArray1, 2 )
Print "MyArray2", _
	  LBound( MyArray2, 1 ); ", "; LBound( MyArray2, 2 ), _
	  UBound( MyArray2, 1 ); ", "; UBound( MyArray2, 2 )
		
