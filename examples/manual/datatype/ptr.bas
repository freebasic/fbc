'' examples/manual/datatype/ptr.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPtr
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
