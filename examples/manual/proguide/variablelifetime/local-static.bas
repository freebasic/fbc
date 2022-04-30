'' examples/manual/proguide/variablelifetime/local-static.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Simple Variable Lifetime vs Scope'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgVariableLifetime
'' --------

Dim Shared As ZString Ptr pzl ' global variable to memorize the local Zstring address
Dim Shared As ZString Ptr pzs ' global variable to memorize the static Zstring address

Declare Sub prntSubString (ByVal p As ZString Ptr, ByVal size As Integer)


Sub s ()                                          ' beginning of procedure scope
	Dim As ZString * 15 zl = "local variable"     ' declare/initialize a local Zstring
	pzl = @zl                                     ' memorize the local Zstring address
	 
	Static As ZString * 16 zs = "static variable" ' declare/initialize a static Zstring
	pzs = @zs                                     ' memorize the static Zstring address
	 
	Print "     From inside the procedure scope:"
	prntSubString(pzl, 14)                        ' display address/content of the local zstring
	prntSubString(pzs, 15)                        ' display address/content of the static zstring
End Sub                                           ' end of procedure scope

Print "Lifetimes comparison between local/static variables declared in a local scope:"
s() ' call the procedure

Print "     From outside the procedure scope:"
prntSubString(pzl, 14) ' display address/content of the local zstring after going out its scope
prntSubString(pzs, 15) ' display address/content of the static zstring after going out its scope

Sleep


Sub prntSubString (ByVal p As ZString Ptr, ByVal size As Integer)
	Print , "&h" & Hex(p, SizeOf(Any Ptr) * 2),
	Print """";
	For I As Integer = 0 To size - 1
		Dim As UByte u = (*p)[I]
		If u < Asc(" ") Then
			Print " ";
		Else
			Print Chr(u);
		End If
	Next I
	Print """"
End Sub
			
