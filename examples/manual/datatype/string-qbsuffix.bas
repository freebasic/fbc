'' examples/manual/datatype/string-qbsuffix.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgString
'' --------

'' QB-like $ suffixes
#lang "qb"

'' DIM based on $ suffix
Dim a$
a$ = "Hello"

'' Implicit declaration based on $ suffix
b$ = ", world!"

Print a$ + b$
