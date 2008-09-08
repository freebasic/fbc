'' examples/manual/array/ubound3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgUbound
'' --------

'' determining the size of a multi-dimensional array
Dim As Long array4D(1 To 2, 1 To 3, 1 To 4, 1 To 5)
Dim As Integer arraylen, arraysize


arraylen = (UBound(array4D, 4) - LBound(array4D, 4) + 1) _
	     * (UBound(array4D, 3) - LBound(array4D, 3) + 1) _
	     * (UBound(array4D, 2) - LBound(array4D, 2) + 1) _
	     * (UBound(array4D, 1) - LBound(array4D, 1) + 1)

arraysize = arraylen * SizeOf( Long )

Print "Number of elements in array:", arraylen    '2 * 3 * 4 * 5 = 120
Print "Number of bytes used in array:", arraysize '120 * 4 = 480
