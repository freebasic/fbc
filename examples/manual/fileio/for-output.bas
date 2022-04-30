'' examples/manual/fileio/for-output.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'OUTPUT'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOutput
'' --------

Dim ff As UByte
Dim randomvar As Integer
Dim name_str As String
Dim age_ubyte As UByte

ff = FreeFile
Input "What is your name? ",name_str
Input "What is your age? ",age_ubyte
Open "testfile" For Output As #ff
Write #ff, Int(Rnd(0)*42),name_str,age_ubyte
Close #ff
randomvar=0
name_str=""
age_ubyte=0

Open "testfile" For Input As #ff
Input #ff, randomvar,name_str,age_ubyte
Close #ff

Print "Random Number was: ", randomvar
Print "Your name is: " + name_str
Print "Your age is: " + Str(age_ubyte)

'File outputted by this sample will look like this,
'minus the comment of course:
'23,"Your Name",19 
