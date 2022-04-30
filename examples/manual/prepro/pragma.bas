'' examples/manual/prepro/pragma.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#PRAGMA'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpPragma
'' --------

'' MSVC-compatible bitfields: save the current setting and then enable them
#pragma push(msbitfields)

'' do something that requires MS-compatible bitfields here

'' restore original setting
#pragma pop(msbitfields)
