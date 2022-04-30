'' examples/manual/proguide/shared-lib/mainShareData.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Shared Libraries'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgSharedLibraries
'' --------

' mainShareData.bas
' Sharing data between main and dll code

' 'Alias' clause allows compatibility with dll loaded statically or dynamically

' dll loaded statically
	#inclib "dllShareData"
	Declare Sub passIntByRef Alias"passIntByRef"(ByRef i As Integer)
	Declare Function returnIntByRef Alias"returnIntByRef"() ByRef  As Integer
	Declare Sub printIdll Alias"printIdll"()
	Declare Sub printJdll Alias"printJdll"()
	Declare Sub incrementIdll Alias"incrementIdll"()
	Declare Sub incrementJdll Alias"incrementJdll"()
 ' or dll loaded dynamically
	'Dim As Any Ptr libhandle = DyLibLoad("dllShareData")
	'Dim As Sub(Byref i As Integer) passIntByRef = DyLibSymbol(libhandle, "passIntByRef")
	'Dim As Function() Byref  As Integer returnIntByRef = DyLibSymbol(libhandle, "returnIntByRef")
	'Dim As Sub() printIdll = DyLibSymbol(libhandle, "printIdll")
	'Dim As Sub() printJdll = DyLibSymbol(libhandle, "printJdll")
	'Dim As Sub() incrementIdll = DyLibSymbol(libhandle, "incrementIdll")
	'Dim As Sub() incrementJdll = DyLibSymbol(libhandle, "incrementJdll")

' share main variable
Dim Shared As Integer Imain = 1
Print "main code passes by reference main integer to dll code"
passIntByref(Imain)
Print "main code requests dll code to print its own reference"
printIdll()
Print "main code increments its main integer value"
Imain += 1
Print "main code requests dll code to print its own reference"
printIdll()
Print "main code requests dll to increments its own reference"
incrementIdll()
Print "main code prints its main integer"
Print "" & Imain

Print

' share dll variable
Dim Shared ByRef As Integer Jdll = *CPtr(Integer Ptr, 0)
Print "main code requests by reference dll integer from dll code"
Dim As Integer Ptr pJdll = @(returnIntByRef())
Print "main code receives by reference dll integer"
@Jdll = pJdll
Print "main code prints its own reference"
Print "" & Jdll
Print "main code requests dll to increment its dll integer value"
incrementJdll()
Print "main code prints its own reference"
Print "" & Jdll
Print "main code increments its own reference"
Jdll += 1
Print "main code requests dll code to print its dll integer"
printJdll()
Print

' for dll loaded dynamically
	'DyLibFree(libhandle)

Sleep
