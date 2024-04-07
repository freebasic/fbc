'' examples/manual/prepro/pragma_reserve1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#PRAGMA RESERVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpPragmaReserve
'' --------

#pragma reserve myName1
#pragma reserve myName2
#pragma reserve myName3
#pragma reserve myName4
#pragma reserve myName5
#pragma reserve (Extern) myName11
#pragma reserve (Extern) myName12
#pragma reserve (Extern) myName13
#pragma reserve (Extern) myName14
#pragma reserve (Extern) myName15

Dim As Integer myName1             '' error: Duplicated definition, myName1 in 'Dim As Integer myName1 ...
Print myName1                      '' error: Illegal use of reserved symbol, found 'myName1' in 'Print myName1 ...

Scope
	Dim As Integer myName2         '' OK
	Print myName2                  '' OK
End Scope

Dim As Integer myName11            '' OK
Print myName11                     '' OK
Dim Shared As Integer myName12     '' warning: Use of reserved global or backend symbol, myName12
Print myName12                     '' OK

Namespace N
	Dim As Integer myName3         '' OK
	Dim As Integer myName13        '' OK
	Sub myName4()                  '' OK
	End Sub
	Sub myName14()                 '' OK
	End Sub
End Namespace
Print N.myName3                    '' OK
Print N.myName13                   '' OK
N.myName4()                        '' OK
N.myName14()                       '' OK

Sub myName5()                      '' error: Duplicated definition, before ''' in 'Sub myName4() ...
End Sub
myName5()                          '' error: Illegal use of reserved symbol, found 'myName4' in 'myName4() ...

Sub myName15()                     '' warning: Use of reserved global or backend symbol, myName14
End Sub
myName15()                         '' OK
