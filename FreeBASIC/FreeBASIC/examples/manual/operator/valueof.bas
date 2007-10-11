'' examples/manual/operator/valueof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpValueOf
'' --------

'This program demonstrates the use of * to utilize the value a pointer points to.
Dim a As Integer
Dim pa As Integer Ptr

pa=@a 'Here, we use the @ operator to point our integer ptr at 'a'.
' 'a' is, in this case, a standard integer variable.

a=9     'Here we give 'a' a value of 9.

Print "The value of 'a' is";*pa 'Here, we display the value of 'a' using a pointer. 

*pa = 1 'Here we use our pointer to change the value of 'a'
Print "The new value of 'a' is";a 'Here we display the new value of 'a'.
