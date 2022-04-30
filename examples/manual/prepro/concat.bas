'' examples/manual/prepro/concat.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Operator ## (Preprocessor Concatenate)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpPpConcat
'' --------

#define Concat(t,n) t##n

Print concat (12,34)

Dim Concat (hello,world) As Integer
Concat (hello,world)=99
Print helloworld
