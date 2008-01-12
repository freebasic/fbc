'' examples/manual/proguide/arrays/indexing.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgArrayIndex
'' --------

Declare Sub PrintArray()

Dim Numbers(1 To 10) As Integer
Dim Shared OtherNumbers(1 To 10) As Integer
Dim a As Integer

Numbers(1) = 1
Numbers(2) = 2
OtherNumbers(1) = 3
OtherNumbers(2) = 4

PrintArray ()

For a = 1 To 10
 Print Numbers(a)
Next a

Print OtherNumbers(1)
Print OtherNumbers(2)
Print OtherNumbers(3)
Print OtherNumbers(4)
Print OtherNumbers(5)
Print OtherNumbers(6)
Print OtherNumbers(7)
Print OtherNumbers(8)
Print OtherNumbers(9)
Print OtherNumbers(10)

Sub PrintArray ()
 Dim a As Integer
 For a = 1 To 10
   Print otherNumbers(a)
 Next a
End Sub
