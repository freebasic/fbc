'' examples/manual/check/KeyPgOnerror_2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOnerror
'' --------

'' Compile with FB default (-lang fb) dialect 
If Open( "text" For Input As #1 ) <> 0 Then
  Print "Unable to open file"
End If

