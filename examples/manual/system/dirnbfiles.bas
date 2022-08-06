'' examples/manual/system/dirnbfiles.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

' Number of files in the current directory.

Dim As Integer FileCount

If Dir("*") <> "" Then  ' Start a file search with no specified filespec/attrib *AND* get the first filename.
	Filecount = 1
	While Dir() <> ""  ' If dir() is "", exit the loop: no more filenames are left to be read.
		FileCount += 1  ' Increment the counter of number of files
	Wend
End If

Print FileCount & " files in the current directory."

Sleep
