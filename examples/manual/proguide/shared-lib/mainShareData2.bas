'' examples/manual/proguide/shared-lib/mainShareData2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

' mainShareData2.bas
' Sharing data between main and dll code by using static funtion returning by reference

' 'Alias' clause allows compatibility with dll loaded statically or dynamically

' dll loaded statically
	#inclib "dllShareData2"
	Declare Function returnIntByRef Alias"returnIntByRef"() ByRef  As Integer
	Declare Sub printJdll Alias"printJdll"()
	Declare Sub incrementJdll Alias"incrementJdll"()
 ' or dll loaded dynamically
	'Dim As Any Ptr libhandle = DyLibLoad("dllShareData2")
	'Dim As Function() Byref As Integer returnIntByRef = DyLibSymbol(libhandle, "returnIntByRef")
	'Dim As Sub() printJdll = DyLibSymbol(libhandle, "printJdll")
	'Dim As Sub() incrementJdll = DyLibSymbol(libhandle, "incrementJdll")

Print "main code requests dll code to print the reference"
printJdll()
Print "main code prints the reference"
Print "" & returnIntByRef()
Print
Print "main code requests dll to increment the reference"
incrementJdll()
Print "main code requests dll code to print the reference"
printJdll()
Print "main code prints the reference"
Print "" & returnIntByRef()
Print
Print "main code increments the reference"
returnIntByRef() += 1
Print "main code prints the reference"
Print "" & returnIntByRef()
Print "main code requests dll code to print the reference"
printJdll()
Print

' for dll loaded dynamically
	'DyLibFree(libhandle)

Sleep
