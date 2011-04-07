'' examples/manual/datatype/longint.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLongint
'' --------

  Dim x As LongInt = &H8000000000000000
  Dim y As LongInt = &H7FFFFFFFFFFFFFFF
  Print "LongInt Range = "; x; " to "; y
