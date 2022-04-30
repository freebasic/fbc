'' examples/manual/memory/swap.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'SWAP'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSwap
'' --------

' using swap to order 2 numbers:
Dim a As Integer, b As Integer

Input "input a number: "; a
Input "input another number: "; b
If a > b Then Swap a, b
Print "the numbers, in ascending order are:"
Print a, b
