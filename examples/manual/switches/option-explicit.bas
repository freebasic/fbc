'' examples/manual/switches/option-explicit.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionexplicit
'' --------

'' Compile with the "-lang qb" or "-lang fblite" compiler switches

#lang "fblite"

Option Explicit

Dim a As Integer            ' 'a' must be declared..
a = 1                       ' ..or this statement will fail to compile.
