'' examples/manual/error/resume.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RESUME'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgResume
'' --------

'' Compile with -lang fblite or qb

#lang "fblite"

Dim As Single i, j

On Error Goto ErrHandler

i = 0
j = 1 / i ' this line causes a divide-by-zero error on the first try; execution jumps to ErrHandler label

Print j ' after the value of i is corrected, prints 0.5

End ' end the program so that execution does not fall through to the error handler again

ErrHandler:

i = 2
Resume ' execution jumps back to 'j = 1 / i' line, which does not cause an error this time
