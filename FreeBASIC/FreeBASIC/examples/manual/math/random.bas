'' examples/manual/math/random.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRandom
'' --------

Dim ff As UByte
Dim randomvar As Integer

ff = FreeFile

Open "testfile" For Random As #ff
Write #ff, Int(Rnd * 42)
Close #ff

Open "testfile" For Random As #ff
Input #ff, randomvar
Close #ff

Print "Random Number was: ", randomvar
