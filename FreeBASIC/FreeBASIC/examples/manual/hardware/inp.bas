'' examples/manual/hardware/inp.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInp
'' --------

'' Turn off PC speaker
Out &h61,Inp(&h61) And &hfc
