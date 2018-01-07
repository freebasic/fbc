'' examples/manual/fileio/access.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgAccess
'' --------

Dim As Integer o

  '' get an open file number.
  o = FreeFile
  
  '' open file for read-only access.    
  Open "data.raw" For Binary Access Read As #o
	
	'' make a buffer in memory thats the entire size of the file
	Dim As UByte file_char( LOF( o ) - 1 )

	  '' get the file into the buffer.      
	  Get #o, , file_char()
	
  Close
  
  '' get another open file number.
  o = FreeFile
  
  '' open file for write-only access.    
  Open "data.out" For Binary Access Write As #o

	'' put the buffer into the new file.      
	Put #o, , file_char()
	
  Close

  Print "Copied file ""data.raw"" to file ""data.out"""

  Sleep
