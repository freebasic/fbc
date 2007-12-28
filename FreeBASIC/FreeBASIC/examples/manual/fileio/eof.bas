'' examples/manual/fileio/eof.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgEof
'' --------

'' This code finds a free file number to use and attempts to open the file
'' "file.ext" and if successful, binds our file number to the opened file. It
'' reads the file line by line, outputting it to the screen. We loop until eof()
'' returns true, in this case we ignore the loop if file is empty.

Dim As String file_name
Dim As Integer file_num

file_name = "file.ext"
file_num = FreeFile( )                 '' retrieve an available file number

'' open our file and bind our file number to it, exit on error
If( Open( file_name For Input As #file_num ) ) Then
   Print "ERROR: opening file " ; file_name
   End -1
End If

Do Until EOF( file_num )               '' loop until we have reached the end of the file
   Dim As String text
   Line Input #file_num, text               '' read a line of text ...
   Print text                             '' ... and output it to the screen
Loop

Close #file_num                        '' close file via our file number

End 0
