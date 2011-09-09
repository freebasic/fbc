'' examples/manual/error/err1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErr
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

On Error Goto Error_Handler
Error 150
End

Error_Handler:
  n = Err()
  Print "Error #"; n
  Resume Next
