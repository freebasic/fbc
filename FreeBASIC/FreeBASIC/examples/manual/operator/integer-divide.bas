'' examples/manual/operator/integer-divide.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOpIntegerDivide
'' --------

Dim n As Double
Print n \ 5
n = 7 \ 2.6  '' => 7 \ 3  => 2.33333  => 2
Print n
n = 7 \ 2.4  '' => 7 \ 2 => 3.5 => 3
Print n
Sleep
