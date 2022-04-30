'' examples/manual/proguide/references/hacking.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Using References'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgReferences
'' --------

Declare Function resizeZstring (ByRef refZstring As ZString, ByVal length As Integer) ByRef As ZString
Declare Sub prntZstring (ByRef refZstring As ZString)

Dim ByRef As ZString refZ = *CPtr(ZString Ptr, 0)  '' "null" reference declaration

Const cz1 = "FB"
@refZ = @(resizeZstring(refZ, Len(cz1)))           '' reference (re-)inititialization
refZ = cz1
prntZstring(refZ)

Const cz2 = "FreeBASIC"
@refZ = @(resizeZstring(refZ, Len(cz2)))           '' reference re-inititialization
refZ = cz2
prntZstring(refZ)

Const cz3 = "FreeBASIC 1.06.0"
@refZ = @(resizeZstring(refZ, Len(cz3)))           '' reference re-inititialization
refZ = cz3
prntZstring(refZ)

Const cz4 = ""
@refZ = @(resizeZstring(refZ, Len(cz4)))           '' reference re-inititialization to "null" reference
refZ = cz4
prntZstring(refZ)

Sleep

Function resizeZstring (ByRef refZstring As ZString, ByVal length As Integer) ByRef As ZString
	If length > 0 Then
		If @refZstring = 0 Then
			Print "Zstring memory buffer allocation"
		Else
			Print "Zstring memory buffer re-allocation"
		End If
		length += 1
	Else
		Print "Zstring memory buffer de-allocation"
	End If
'	Return *Cptr(Zstring Ptr, Reallocate(@refZstring, length * Sizeof(Zstring)))
'	'' Using the "Return Byval ..." syntax allows to avoid casting + dereferencing as above
	Return ByVal Reallocate(@refZstring, length * SizeOf(ZString))
End Function

Sub prntZstring (ByRef refZstring As ZString)
	Print "  " & @refZstring, "'" & refZstring & "'"
	Print
End Sub
		
