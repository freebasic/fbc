'' examples/manual/proguide/multithreading/criticalsectionfaq17.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Critical Sections FAQ'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgMtCriticalSectionsFAQ
'' --------

Type Thread
	Dim As UInteger value
	Dim As Any Ptr pHandle
	Declare Static Sub thread1(ByVal pt As Thread Ptr)
	Declare Static Sub thread2(ByVal pt As Thread Ptr)
End Type

Sub Thread.thread1(ByVal pt As Thread Ptr)
	Dim As Integer result
	For n As Integer = 1 To pt->value
		Dim As String s1
		Dim As String s2
		Dim As String s3
		s1 = "FreeBASIC rev 1.20"
		result = InStr(s1, "rev")
		s2 = Mid(s1, result)
		s3 = UCase(s2)
	Next n
End Sub

Sub Thread.thread2(ByVal pt As Thread Ptr)
	Dim As Integer result
	For n As Integer = 1 To pt->value
		Dim As ZString * 256 z1
		Dim As ZString * 256 z2
		Dim As ZString * 256 z3
		' instead of: z1 = "FreeBASIC rev 1.20"
		For i As Integer = 0 To Len("FreeBASIC rev 1.20")
			z1[i] = ("FreeBASIC rev 1.20")[i]
		Next i
		' instead of: result = Instr(z1, "rev")
		result = 0
		For i As Integer = 0 To Len(z1) - Len("rev")
			For j As Integer = 0 To Len("rev") - 1
				If z1[i + j] <> ("rev")[j] Then Continue For, For
			Next j
			result = i + 1
			Exit For
		Next i
		' instead of: z2 = Mid(z1, result)
		For i As Integer = result - 1 To Len(z1)
			z2[i - result + 1] = z1[i]
		Next i
		' instead of: z3 = Ucase(z2)
		For i As Integer = 0 To Len(z2)
			z3[i] = z2[i]
			If z3[i] >= Asc("a") AndAlso z3[i] <= Asc("z") Then z3[i] -= 32
		Next i
	Next n
End Sub

Sub MyThreads(ByVal pThread As Any Ptr, ByVal threadNB As UInteger = 1)
	Dim As Thread td(1 To threadNB)
	Dim As Double t
   
	t = Timer
	For i As Integer = 1 To threadNB
		td(i).value = 100000
		td(i).pHandle = ThreadCreate(pThread, @td(i))
	Next I
	For i As Integer = 1 To threadNB
		ThreadWait(td(i).pHandle)
	Next I
	t = Timer - t

	Print "      total time for " & threadNB & " threads in parallel: " & t & " s"
	Print
End Sub

Print
For i As Integer = 1 To 8
	Print "Each thread using var-len strings, with its built-in functions and operators:"
	Mythreads(@Thread.thread1, I)
	Print "Each thread using fix-len zstrings, with user code working on zstring indexes:"
	Mythreads(@Thread.thread2, I)
	Print "------------------------------------------------------------------------------"
	Print
Next i

Sleep
