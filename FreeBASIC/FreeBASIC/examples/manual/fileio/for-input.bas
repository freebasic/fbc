'' examples/manual/fileio/for-input.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgInputfilemode
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
