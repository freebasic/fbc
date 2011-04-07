'' examples/manual/system/filedatetime.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFiledatetime
'' --------

#include "vbcompat.bi"

Dim filename As String, d As Double

Print "Enter a filename: "
Line Input filename

If FileExists( filename ) Then

  Print "File last modified: ";

  d = FileDateTime( filename )

  Print Format( d, "yyyy-mm-dd hh:mm AM/PM" )

Else

  Print "File not found"

End If
