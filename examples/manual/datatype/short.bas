'' examples/manual/datatype/short.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgShort
'' --------

  Dim x As Short = CShort(&H8000)
  Dim y As Short = CShort(&H7FFF)
  Print "Short Range = "; x; " to "; y
