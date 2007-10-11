'' examples/manual/fileio/loc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLoc
'' --------

Dim b As String

If Open Com ("com1:9600,n,8,1,cs,rs,ds,bin" For Binary As #1) <> 0 Then
  Print "unable to open serial port"
  End
End If

Print "Sending command: AT"

Print #1, "AT" + Chr(13, 10);

Sleep 500,1

Print "Response:"

While( LOC(1) > 0 )
  b = Input(LOC(1), 1)
  Print b;
Wend

Close #1
