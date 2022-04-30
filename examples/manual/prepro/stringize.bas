'' examples/manual/prepro/stringize.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator # (Preprocessor Stringize)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpStringize
'' --------

#define SEE(x) Print #x ;" = "; x
Dim variable As Integer, another_one As Integer
variable=1
another_one=2
SEE(variable)
SEE(another_one)
