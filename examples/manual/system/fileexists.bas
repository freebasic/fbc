'' examples/manual/system/fileexists.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FILEEXISTS'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFileexists
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
