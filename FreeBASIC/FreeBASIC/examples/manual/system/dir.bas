'' examples/manual/system/dir.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDir
'' --------

#include "dir.bi" 'provides constants to use for the attrib_mask parameter

Sub list_files (ByRef filespec As String, ByVal attrib As Integer)
	Dim filename As String

	filename = Dir( filespec, attrib )
	Do
	    Print filename
	    filename = Dir( )
	Loop While Len( filename ) > 0
End Sub

Print "directories:"
list_files "*", fbDirectory

Print
Print "archive files:"
list_files "*", fbArchive
