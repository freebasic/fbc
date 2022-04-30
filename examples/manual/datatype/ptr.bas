'' examples/manual/datatype/ptr.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '(POINTER | PTR)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPtr
'' --------

' Create the pointer.
Dim p As Integer Ptr

' Create an integer value that we will point to using pointer "p"
Dim num As Integer = 98845

' Point p towards the memory address that variable "num" occupies.
p = @num

' Print the value stored in memory pointed to by pointer "p"
Print "Pointer 'p' ="; *p
Print 

' Print the actual location in memory that pointer "p" points at.
Print "Pointer 'p' points to memory location:"
Print p
