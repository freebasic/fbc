'' examples/manual/operator/address-var.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator @ (Address of)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpAt
'' --------

'This program demonstrates the use of the @ operator.

Dim a As Integer
Dim b As Integer

Dim addr As Integer Ptr

a = 5   'Here we place the values 5 and 10 into a and b, respectively.
b = 10

'Here, we print the value of the variables, then where in memory they are stored.
Print "The value in A is ";a;" but the pointer to a is ";@a
Print "The value in B is ";b;" but the pointer to b is ";@b

'Now, we will take the integer ptr above, and use @ to place a value into it.
'Note that the * will check the value in the ptr, just as @ checked the ptr 
'for a normal variable.

addr = @a

Print "The pointer addr is now pointing at the memory address to a, value: ";*addr

addr = @b

Print "The pointer addr is now pointing at the memory address to b, value: ";*addr
