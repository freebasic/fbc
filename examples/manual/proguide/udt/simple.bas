'' examples/manual/proguide/udt/simple.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'User Defined Types'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgUDTs
'' --------

'Define a UDT called myType, with an Integer member named someVar
Type myType
  As Integer someVar
End Type

'Create a variable of that type
Dim myUDT As myType

'Set the member someVar to 23, then display its contents on the screen
myUDT.someVar = 23
Print myUDT.someVar
