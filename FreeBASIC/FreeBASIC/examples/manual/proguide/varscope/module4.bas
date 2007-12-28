'' examples/manual/proguide/varscope/module4.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
'' --------

Common Shared m1 As Integer
Common Shared m2 As Integer

m2 = 2

Print "Module4"       '' This is executed first
Print "m1 = "; m1     '' m1 = 0 (by default)
Print "m2 = "; m2     '' m2 = 2

Sub Print_Values()
  Print "Module4.Print_Values"
  Print "m1 = "; m1   '' m1 = 1    
  Print "m2 = "; m2   '' m2 = 2
End Sub
