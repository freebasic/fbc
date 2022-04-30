'' examples/manual/fileio/for-input.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'INPUT (FILE MODE)'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInputfilemode
'' --------

Dim ff As UByte
Dim randomvar As Integer
Dim name_str As String
Dim age As Integer

'' collect the test data and output to file with Write #
Input "What is your name? ", name_str
Input "What is your age? ", age
Randomize
Print

ff = FreeFile
Open "testfile" For Output As #ff
Write #ff, Int(Rnd*42), name_str, age
Close #ff

'' clear variables
randomvar = 0
name_str = ""
age = 0

'' input the variables, using Input #
ff = FreeFile
Open "testfile" For Input As #ff
Input #ff, randomvar, name_str, age
Close #ff

Print "Random Number was: " & randomvar
Print "Your name is: " & name_str
Print "Your age is: " & age

'File outputted by this sample will look something like this
'(not including the leading comment marker):
'23,"Your Name",19
