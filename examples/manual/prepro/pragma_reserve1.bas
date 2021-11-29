'' examples/manual/prepro/pragma_reserve1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpPragmaReserve
'' --------

#pragma reserve myName1
#pragma reserve myName2
#pragma reserve myName3
#pragma reserve myName4
#pragma reserve (Extern) myName11
#pragma reserve (Extern) myName12
#pragma reserve (Extern) myName13
#pragma reserve (Extern) myName14

Dim As Integer myName1             '' error: Duplicated definition, myName1 in 'Dim As Integer myName1 ...
Print myName1                      '' error: Illegal use of reserved symbol, found 'myName1' in 'Print myName1 ...

Scope
	Dim As Integer myName2         '' OK
	Print myName2                  '' OK
End Scope

Dim As Integer myName11            '' OK
Print myName11
Dim Shared As Integer myName12     '' warning: Use of reserved global or backend symbol, myName12
Print myName12                     '' OK

Namespace N
	Dim As Integer myName3         '' OK
	Dim As Integer myName13        '' OK
End Namespace
Print N.myName3                    '' OK
Print N.myName13                   '' OK

Sub myName4()                      '' error: Duplicated definition, before ''' in 'Sub myName4() ...
End Sub
myName4()                          '' error: Illegal use of reserved symbol, found 'myName4' in 'myName4() ...

Sub myName14()                     '' warning: Use of reserved global or backend symbol, myName14
End Sub
myName14()                         '' OK
		
