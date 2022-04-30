'' examples/manual/threads/threadsself-tls.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'THREADSELF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThreadSelf
'' --------

#include Once "fbthread.bi"

Function TLSindex() As Integer  ' returning a unique thread index (incremented with each new thread)
	Static As Any Ptr TLSind()
	Dim As Integer index = -1
	For I As Integer = LBound(TLSind) To UBound(TLSind)
		If TLSind(I) = ThreadSelf() Then
			index = I
			Exit For
		End If
	Next I
	If index = -1 Then
		index = UBound(TLSind) + 1
		ReDim Preserve TLSind(index)
		TLSind(index) = ThreadSelf()
	End If
	Return index
End Function

Function TLSinteger() ByRef As Integer  ' emulation of global integer with value depending on thread using it
	Static As Integer TLSint()
	Dim As Integer index = TLSindex()
	If index > UBound(TLSint) Then
		ReDim Preserve TLSint(index)
	End If
	Return TLSint(index)
End Function

'------------------------------------------------------------------------------

Type threadData
	Dim As Any Ptr handle
	Dim As String prefix
	Dim As String suffix
	Dim As Double tempo
End Type

Function counter() As Integer  ' definition of a generic counter with counting depending on thread calling it
	TLSinteger() += 1
	Return TLSinteger()
End Function

Sub Thread(ByVal p As Any Ptr)
	Dim As threadData Ptr ptd = p
	Dim As UInteger c
	Do
		c = counter()
		Print ptd->prefix & c & ptd->suffix & " ";  ' single print with concatenated string avoids using a mutex
		Sleep ptd->tempo, 1
	Loop Until c = 12
End Sub

'------------------------------------------------------------------------------

Print "|x| : counting from thread a"
Print "(x) : counting from thread b"
Print "[x] : counting from thread c"
Print

Dim As threadData mtlsa
mtlsa.prefix = "|"
mtlsa.suffix = "|"
mtlsa.tempo = 250
mtlsa.handle = ThreadCreate(@Thread, @mtlsa)

Dim As threadData mtlsb
mtlsb.prefix = "("
mtlsb.suffix = ")"
mtlsb.tempo = 150
mtlsb.handle = ThreadCreate(@Thread, @mtlsb)

Dim As threadData mtlsc
mtlsc.prefix = "["
mtlsc.suffix = "]"
mtlsc.tempo = 100
mtlsc.handle = ThreadCreate(@Thread, @mtlsc)

ThreadWait(mtlsa.handle)
ThreadWait(mtlsb.handle)
ThreadWait(mtlsc.handle)

Print
Print
Print "end of threads"

Sleep	
