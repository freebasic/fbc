'' examples/manual/proguide/shared-lib/dllShareData.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

' dllShareData.bas to be compile with -dll
' Sharing data between main and dll code

' 'Alias' clause (in addition to 'Export') allows compatibility with dll loaded statically or dynamically

' share main variable
Dim Shared ByRef As Integer Idll = *CPtr(Integer Ptr, 0)
Sub passIntByRef Alias"passIntByRef"(ByRef i As Integer) Export
	Print "   dll code receives by reference main integer"
	@Idll = @i
End Sub

Sub printIdll Alias"printIdll"() Export
	Print "   dll code prints its own reference"
	Print "   " & Idll
End Sub

Sub incrementIdll Alias"incrementIdll"() Export
	Idll += 1
End Sub

' share dll variable
Dim Shared As Integer Jdll = 5
Function returnIntByRef Alias"returnIntByRef"() ByRef As Integer Export
	Print "   dll code returns by reference dll integer"
	Return Jdll
End Function

Sub printJdll Alias"printJdll"() Export
	Print "   dll code prints its dll integer"
	Print "   " & Jdll
End Sub

Sub incrementJdll Alias"incrementJdll"() Export
	Jdll +=1
End Sub
