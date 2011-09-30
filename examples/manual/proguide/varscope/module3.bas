'' examples/manual/proguide/varscope/module3.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
'' --------

'' compile with:
''    fbc module3.bas module4.bas

Declare Sub Print_Values()
Common m1 As Integer
Common m2 As Integer

'' This is executed after all other modules
m1 = 1

Print "Module3"       
Print "m1 = "; m1     '' m1 = 1 as set in this module
Print "m2 = "; m2     '' m2 = 2 as set in module2

Print_Values
