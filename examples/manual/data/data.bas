'' examples/manual/data/data.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DATA'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgData
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
Data 3, 234, 435/4, 23+433, 87643, "Good" + "Bye!"
