'' examples/manual/switches/option-private.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionprivate
'' --------

'' Compile with the "-lang fblite" compiler switch

#lang "fblite"

Sub ProcWithExternalLinkage()
   ' ...
End Sub

Option Private

Sub ProcWithInternalLinkage()
   ' ...
End Sub

Public Sub AnotherProcWithExternalLinkage()
   ' ...
End Sub
