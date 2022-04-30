'' examples/manual/switches/option-explicit.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OPTION EXPLICIT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOptionexplicit
'' --------

'' Compile with the "-lang qb" or "-lang fblite" compiler switches

#lang "fblite"

Option Explicit

Dim a As Integer            ' 'a' must be declared..
a = 1                       ' ..or this statement will fail to compile.
