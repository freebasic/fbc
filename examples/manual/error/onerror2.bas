'' examples/manual/error/onerror2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'ON ERROR'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgOnerror
'' --------

'' compile as: fbc onerror.bas -ex

#lang "fblite"

Function hFileExists( filename As String ) As Integer Static
	Dim f As Integer

	hFileExists = 0

	On Local Error Goto exitfunction

	f = FreeFile
	Open filename For Input As #f
	
	Close #f

	hFileExists = -1

exitfunction:
	Exit Function
End Function


	Print "File exists (0=false): "; hFileExists( Command )

	On Error Goto errhandler
	Error 1234
	Print "back from resume next"
	End 0

errhandler:
	Print "error number: " + Str( Err ) + " at line: " + Str( Erl )
	Resume Next
