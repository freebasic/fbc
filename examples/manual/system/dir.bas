'' examples/manual/system/dir.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'DIR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

#include "dir.bi" 'provides constants to use for the attrib_mask parameter

Sub list_files (ByRef filespec As String, ByVal attrib As Integer)
	Dim As String filename = Dir(filespec, attrib) ' Start a file search with the specified filespec/attrib *AND* get the first filename.
	Do While Len(filename) > 0 ' If len(filename) is 0, exit the loop: no more filenames are left to be read.
		Print filename
		filename = Dir() ' Search for (and get) the next item matching the initially specified filespec/attrib.
	Loop
End Sub

Print "directories:"
list_files "*", fbDirectory

Print
Print "archive files:"
list_files "*", fbArchive
