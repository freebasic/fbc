'' examples/manual/proguide/varscope/module3.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable Scope'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
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
