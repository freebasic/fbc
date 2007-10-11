'' examples/manual/prepro/concat.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpConcat
'' --------

#define Concat(t,n) t##n

Print concat (12,34)

Dim Concat (hello,world) As Integer
Concat (hello,world)=99
Print helloworld
