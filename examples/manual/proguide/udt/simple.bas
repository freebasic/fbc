'' examples/manual/proguide/udt/simple.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ProPgUDTs
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
