'' examples/manual/error/erfn.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgErfn
'' --------

'' test.bas
'' compile with fbc -exx -lang fblite test.bas

#lang "fblite"

Sub Generate_Error
  On Error Goto Handler
  Error 1000
  Exit Sub
Handler:
  Print "Error Function: "; *Erfn()
  Print "Error Module  : "; *Ermn()
  Resume Next
End Sub

Generate_Error
