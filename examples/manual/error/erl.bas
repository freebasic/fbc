'' examples/manual/error/erl.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ERL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErl
'' --------

' compile with -lang fblite or qb

#lang "fblite"

' note: compilation with '-ex' option is required

On Error Goto ErrorHandler

' Generate an explicit error
Error 100

End

ErrorHandler:
  Dim num As Long = Err
  Print "Error "; num; " on line "; Erl
  Resume Next

' Expected output is
' Error  100 on line  6
