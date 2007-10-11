'' examples/manual/system/fileexists.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFileexists
'' --------

#include "vbcompat.bi"

Dim filename As String

Print "Enter a filename: "
Line Input filename

If FileExists( filename ) Then
  Print "File found: " & filename
Else
  Print "File not found: " & filename
End If
