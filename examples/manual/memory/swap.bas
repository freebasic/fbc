'' examples/manual/memory/swap.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSwap
'' --------

' using swap to order 2 numbers:
Dim a As Integer, b As Integer

Input "input a number: "; a
Input "input another number: "; b
If a > b Then Swap a, b
Print "the numbers, in ascending order are:"
Print a, b
