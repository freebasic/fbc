'' examples/manual/operator/andalso.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAndAlso
'' --------

'' Using the ANDALSO operator to guard against array access
'' when the index is out of range

Dim As Integer isprime(1 To 10) = { _
	_ ' 1  2  3  4  5  6  7  8  9  10
	    0, 1, 1, 0, 1, 0, 1, 0, 0, 0 _
	}

Dim As Integer n
Input "Enter a number between 1 and 10: ", n

'' isprime() array will only be accessed if n is in range
If (n >= 1 And n <= 10) AndAlso isprime(n) Then
	Print "n is prime"
Else
	Print "n is not prime, or out of range"
End If
