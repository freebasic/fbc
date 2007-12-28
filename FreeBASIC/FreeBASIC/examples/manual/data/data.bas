'' examples/manual/data/data.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgData
'' --------

' Create an array of 5 integers and a string to hold the data.
Dim h(4) As Integer
Dim hs As String
Dim read_data As Integer

' Set up to loop 5 times (for 5 numbers... check the data)
For read_data = 0 To 4

  ' Read in an integer.
  Read h(read_data)

  ' Display it.
  Print "Number"; read_data;" = "; h(read_data)

Next

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

Data 3, 234, 435/4, 23+433, 87643,"Good"+ "Bye!"
