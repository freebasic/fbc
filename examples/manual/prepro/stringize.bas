'' examples/manual/prepro/stringize.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpStringize
'' --------

#define SEE(x) Print #x ;" = "; x
Dim variable As Integer, another_one As Integer
variable=1
another_one=2
SEE(variable)
SEE(another_one)
