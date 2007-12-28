'' examples/manual/udt/sub.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgMemberSub
'' --------

Type Statistics
  count As Single
  sum As Single
  Declare Sub AddValue( ByVal x As Single )
  Declare Sub ShowResults( )
End Type

Sub Statistics.AddValue( ByVal x As Single )
  count += 1
  sum += x
End Sub

Sub Statistics.ShowResults( )
  Print "Number of Values = "; count
  Print "Average          = ";
  If( count > 0 ) Then
	Print sum / count
  Else
	Print "N/A"
  End If
End Sub

Dim stats As Statistics

stats.AddValue 17.5
stats.AddValue 20.1
stats.AddValue 22.3
stats.AddValue 16.9

stats.ShowResults
