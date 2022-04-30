'' examples/manual/proguide/shared-lib/dllShareData2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

' dllShareData2.bas to be compile with -dll
' Sharing data between main and dll code by using static funtion returning by reference

' 'Alias' clause (in addition to 'Export') allows compatibility with dll loaded statically or dynamically

Function returnIntByRef Alias"returnIntByRef"() ByRef As Integer Export
	Static As Integer Jdll = 1
	Return Jdll
End Function

Sub printJdll Alias"printJdll"() Export
	Print "   dll code prints the reference"
	Print "   " & returnIntByRef()
End Sub

Sub incrementJdll Alias"incrementJdll"() Export
	returnIntByRef() +=1
End Sub
