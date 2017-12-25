'' examples/manual/system/dir.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

#include "dir.bi" 'provides constants to use for the attrib_mask parameter

Sub list_files (ByRef filespec As String, ByVal attrib As Integer)
	Dim As String filename = Dir(filespec, attrib) ' Start a file search with the specified filespec/attrib *AND* get the first filename.
	Do While Len(filename) > 0 ' If len(filename) is 0, exit the loop: no more filenames are left to be read.
		Print filename
		filename = Dir()
	Loop
End Sub

Print "directories:"
list_files "*", fbDirectory

Print
Print "archive files:"
list_files "*", fbArchive
