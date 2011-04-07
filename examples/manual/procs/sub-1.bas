'' examples/manual/procs/sub-1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgSub
'' --------

'' Example of writing colored text using a sub:

Sub PrintColoredText( ByVal colour As Integer, ByRef text As String )
   Color colour
   Print text
End Sub

   PrintColoredText( 1, "blue" )        '' a few colors
   PrintColoredText( 2, "green" )
   PrintColoredText( 4, "red" )
   Print
   
   Dim i As Integer
   For i = 0 To 15                        '' all 16 colors
	  PrintColoredText( i, ("color " & i) )
   Next i
