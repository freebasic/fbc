'' examples/manual/fileio/lineinput.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LINE INPUT #'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLineinputPp
'' --------

Open "myfile.txt" For Output As #1
Print #1, "Hello, World"
Close #1

Dim s As String
Open "myfile.txt" For Input As #1
Line Input #1, s
Close #1
Print "'" & s & "'"

Const maxlength = 6  '' max 5 characters plus 1 null terminal character
Dim pz As ZString Ptr = CAllocate(maxlength, SizeOf(ZString))
Open "myfile.txt" For Input As #1
Line Input #1, *pz, maxlength
Close #1
Print "'" & *pz & "'"
Deallocate(pz)
