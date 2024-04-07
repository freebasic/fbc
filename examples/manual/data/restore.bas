'' examples/manual/data/restore.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'RESTORE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgRestore
'' --------

' Create an 2 arrays of integers and a 2 strings to hold the data.
Dim h(4) As Integer
Dim h2(4) As Integer
Dim hs As String
Dim hs2 As String
Dim read_data1 As Integer
Dim read_data2 As Integer

' Set the data read to the label 'dat2:'
Restore dat2

' Set up to loop 5 times (for 5 numbers... check the data)
For read_data1 = 0 To 4

  ' Read in an integer.
  Read h(read_data1)

  ' Display it.
  Print "Bloc 1, number"; read_data1;" = "; h(read_data1)

Next

' Spacer.
Print

' Read in a string.
Read hs

' Print it.
Print  "Bloc 1 string = " + hs

' Spacers.
Print
Print


' Set the data read to the label 'dat1:'
Restore dat1

' Set up to loop 5 times (for 5 numbers... check the data)
For read_data2 = 0 To 4

  ' Read in an integer.
  Read h2(read_data2)

  ' Display it.
  Print "Bloc 2, number"; read_data2;" = "; h2(read_data2)

Next

' Spacer.
Print

' Read in a string.
Read hs2

' Print it.
Print  "Bloc 2 string = " + hs2

' Await a keypress.
Sleep

' Exit program.
End



' First block of data.
dat1:
Data 3, 234, 4354, 23433, 87643, "Bye!"

' Second block of data.
dat2:
Data 546, 7894, 4589, 64657, 34554, "Hi!"





