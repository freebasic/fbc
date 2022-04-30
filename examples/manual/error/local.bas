'' examples/manual/error/local.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LOCAL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLocal
'' --------

'' compile with -lang fblite or qb

#lang "fblite"

Declare Sub foo

foo
Print "ok"
Sleep

Sub foo
  Dim errno As Integer
  On Local Error Goto fail
  Open "xzxwz.zwz" For Input As #1
  On Local Error Goto 0
  Exit Sub
fail:                  ' here starts the error handler
  errno = Err
  Print "Error "; errno      ' just print the error number
  Sleep
End Sub
