'' examples/manual/fileio/basicvsc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'File I/O with FreeBASIC'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgFileIO
'' --------

'==== File I/O example / 2018-05-18 ====

Dim As String fileName = "test_123.tmp"
Dim As ULong buffer(0 To 99) '100 x 4 bytes
Dim As Integer numItems, result

Print !"\n==== Using the C Runtime (CRT) file I/O ====\n"

#include Once "crt/stdio.bi"

Dim As FILE Ptr filePtr

'open in binary writing mode
filePtr = fopen(fileName, "wb")
If filePtr <> 0 Then
	'write 75 x 4 = 300 bytes
	numItems = fwrite(@buffer(0), SizeOf(buffer(0)), 75, filePtr)
	Print "Number of bytes written: " & Str(numItems * SizeOf(buffer(0)))
	Print "Number of items written: " & Str(numItems)
	fclose(filePtr)
Else
	Print "Failed to open " & fileName & " for writing"
End If

'open in binary reading mode
filePtr = fopen(fileName, "rb")
If filePtr <> 0 Then
	'skip the first 25 items
	If fseek(filePtr, SizeOf(buffer(0)) * 25, SEEK_SET) <> 0 Then
		Print "Failed to seek (set file stream position)"
	End If
	'try to read the next 100 items
	numItems = fread(@buffer(0), SizeOf(buffer(0)), 100, filePtr)
	Print "Number of bytes read: " & Str(numItems * SizeOf(buffer(0)))
	Print "Number of items read: " & Str(numItems)
	fclose(filePtr)
Else
	Print "Failed to open " & fileName & " for reading"
End If

result = remove(fileName) 'delete file
If result = 0 Then Print "Removed: " & fileName

Print !"\n==== Using the FreeBASIC file I/O ====\n"

Dim As Long fileNum
Dim As Integer numBytes

fileNum = FreeFile
'open in binary writing mode
If Open(fileName, For Binary, Access Write, As fileNum) = 0 Then
	'write 75 x 4 = 300 bytes
	result = Put(fileNum, , buffer(0), 75) 'No @buffer(0)
	numBytes = Seek(fileNum) - 1 'FreeBASIC file position is 1-based
	Print "Number of bytes written: " & Str(numBytes)
	Print "Number of items written: " & Str(numBytes \ SizeOf(buffer(0)))
	Close(fileNum)
Else
	Print "Failed to open " & fileName & " for writing"
End If

'open in binary reading mode
If Open(fileName, For Binary, Access Read, As fileNum) = 0 Then
	'skip the first 25 items
	Seek fileNum, 25 * SizeOf(buffer(0)) + 1 'Note: +1 & seek(...) not allowed
	'try to read the next 100 items
	result = Get(fileNum, , buffer(0), 100, numBytes)
	Print "Number of bytes read: " & Str(numBytes)
	Print "Number of items read: " & Str(numBytes \ SizeOf(buffer(0)))
	Close(fileNum)
Else
	Print "Failed to open " & fileName & " for reading"
End If

result = Kill(fileName) 'delete file
If result = 0 Then Print "Killed: " & fileName

Print !"\n==== End ====\n"
