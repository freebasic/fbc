'' examples/manual/memory/callocate.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgCallocate
'' --------

' Create an integer pointer.
Dim p As Integer Ptr
Dim fill_p As Integer
Dim show_p As Integer

' Allocate cleared space for 10 integers.
p = CAllocate(10, Len(Integer))

' Fill the array with numbers.
For fill_p = 0 To 9
  p[fill_p] = fill_p
Next

' Display the values.
For show_p = 0 To 9
  Print p[show_p]
Next

' Await a keypress.
Sleep

' Exit program.
End
