'' examples/manual/proguide/varscope/module2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
'' --------

Common m1 As Integer
Common m2 As Integer

m2 = 2

Print "Module2"       ' This is executed first
Print "m1 = "; m1     ' m1 = 0 (by default)
Print "m2 = "; m2     ' m2 = 2

Sub Print_Values()
  Print "Module2.Print_Values"
  Print "m1 = "; m1   ' Implicit variable = 0    
  Print "m2 = "; m2   ' Implicit variable = 0  
End Sub
