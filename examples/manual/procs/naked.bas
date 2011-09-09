'' examples/manual/procs/naked.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNaked
'' --------

'' Naked cdecl function
Function add naked cdecl _
	( _
		ByVal a As Integer, _
		ByVal b As Integer _
	) As Integer
	
	Asm
		mov eax, dword Ptr [esp+4] '' a
		add eax, dword Ptr [esp+8] '' + b
		ret                        '' return result in eax
	End Asm
	
End Function

Print add( 1, 5 )
