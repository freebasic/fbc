'' examples/manual/prepro/pragma.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPragma
'' --------

'' MSVC-compatible bitfields: save the current setting and then enable them
#pragma push(msbitfields)

'' do something that requires MS-compatible bitfields here

'' restore original setting
#pragma pop(msbitfields)
