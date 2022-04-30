'' examples/manual/error/err1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ERR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErr
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
