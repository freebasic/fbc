'' examples/manual/proguide/varscope/module2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Variable Scope'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableScope
'' --------

Common m1 As Integer
Common m2 As Integer

m2 = 2

Print "Module2"       ' This is executed first
Print "m1 = "; m1     ' m1 = 0 (by default)
Print "m2 = "; m2     ' m2 = 2

Sub Print_Values()
  Print "Module2.Print_Values"
  Print "m1 = "; m1   ' Implicit variable = 0, because '-lang qb' use
  Print "m2 = "; m2   ' Implicit variable = 0, because '-lang qb' use
End Sub
