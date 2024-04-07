'' examples/manual/switches/option-private.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION PRIVATE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionprivate
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
