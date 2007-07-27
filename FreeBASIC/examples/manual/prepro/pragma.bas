'' examples/manual/prepro/pragma.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPragma
'' --------

'' save the current pragma setting
#pragma push(msbitfields)
'' switch to MSVC-compatible bitfields
#pragma msbitfields=1

'' do something that requires MS-compatible bitfields here

'' restore original setting
#pragma pop(msbitfields)
