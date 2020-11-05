'' examples/manual/fileio/fileflush.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFileflush
'' --------

#include "file.bi"

Dim As Long f1, f2
Dim As String s

Print "File length", "File string"

f1 = FreeFile
Open "fileflushtest.txt" For Output As #f1
Print #f1, "successful file flush"

f2 = FreeFile
Open "fileflushtest.txt" For Input As #f2
Line Input #f2, s
Print FileLen("fileflushtest.txt"), "'" & s & "'"  '' the string is not yet physically written to the file

FileFlush(f1)
Line Input #f2, s
Print FileLen("fileflushtest.txt"), "'" & s & "'"  '' the string is now physically written to the file

Close #f2
Close #f1

Sleep
	
