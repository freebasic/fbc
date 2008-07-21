'' examples/manual/error/resume-next.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgResumenext
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

Dim As Single i, j

On Error Goto ErrHandler

i = 0
j = 5
j = 1 / i ' this line causes a divide-by-zero error; execution jumps to ErrHandler label

Print "ending..."

End ' end the program so that execution does not fall through to the error handler again

ErrHandler:

Resume Next ' execution jumps to 'Print "ending..."' line, but j is now in an undefined state
