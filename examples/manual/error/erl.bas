'' examples/manual/error/erl.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErl
'' --------

' compile with -lang fblite or qb

#lang "fblite"

' note: compilation with '-ex' option is required

On Error Goto ErrorHandler

' Generate an explicit error
Error 100

End

ErrorHandler:
  Dim num As Integer = Err
  Print "Error "; num; " on line "; Erl
  Resume Next

' Expected output is
' Error  100 on line  6
