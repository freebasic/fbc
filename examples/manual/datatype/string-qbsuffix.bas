'' examples/manual/datatype/string-qbsuffix.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'STRING'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' QB-like $ suffixes
#lang "qb"

'' DIM based on $ suffix
Dim a$
a$ = "Hello"

'' Implicit declaration based on $ suffix
b$ = ", world!"

Print a$ + b$
