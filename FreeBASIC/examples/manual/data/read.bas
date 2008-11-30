'' examples/manual/data/read.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRead
'' --------

' Create an array of 5 integers and a string to hold the data.
Dim As Integer h(4)
Dim As String hs
Dim As Integer readindex

' Set up to loop 5 times (for 5 numbers... check the data)
For readindex = 0 To 4

  ' Read in an integer.
  Read h(readindex)

  ' Display it.
  Print "Number" ; readindex ; " = " ; h(readindex)

Next readindex

' Spacer.
Print

' Read in a string.
Read hs

' Print it.
Print  "String = " + hs

' Await a keypress.
Sleep

' Exit program.
End

' Block of data.
Data 3, 234, 4354, 23433, 87643, "Bye!"
