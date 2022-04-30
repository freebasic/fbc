'' examples/manual/fileio/lock.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'LOCK'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgLock
'' --------

'' e.g. locking a file, reading 100 bytes, and unlocking it. 
'' To run, make sure there exists a file called 'file.ext' 
'' in the current directory that is at least 100 bytes.

Dim array(1 To 100) As Integer
Dim f As Integer, i As Integer
f = FreeFile
Open "file.ext" For Binary As #f
Lock #f, 1 To 100
For i = 1 To 100
	Get #f, i, array(i)
Next
Unlock #f, 1 To 100
Close #f
