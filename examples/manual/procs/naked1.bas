'' examples/manual/procs/naked1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgNaked
'' --------

'' Naked cdecl function
Function subtract_c Naked cdecl _   '' parameters pushed onto call stack in reverse order of declaration
	( _
	    ByVal a As Long, _
	    ByVal b As Long _        '' parameter pushed onto stack in first
	) As Long
   
	Asm
	    mov eax, dword Ptr [esp+4]  '' eax = a
	    Sub eax, dword Ptr [esp+8]  '' eax -= b
	    ret                         '' return result in eax
	End Asm
   
End Function

Print subtract_c( 5, 1 ) '' 5 - 1

''---------------------------------------------------------------------------------------------------------------------

'' Naked stdcall function
Function subtract_s Naked stdcall _ '' parameters pushed onto call stack in reverse order of declaration
	                     _          '' called procedure responsible for removing parameters from stack
	                     _          ''   (appending constant to RET instruction specifying number of bytes to release)
	( _
	    ByVal a As Long, _
	    ByVal b As Long _        '' parameter pushed onto stack in first
	) As Long
   
	Asm
	    mov eax, dword Ptr [esp+4]  '' eax = a
	    Sub eax, dword Ptr [esp+8]  '' eax -= b
	    ret 8                       '' return result in eax and 8 bytes (2 integers) to release
	End Asm
   
End Function

Print subtract_s( 5, 1 ) '' 5 - 1 

''---------------------------------------------------------------------------------------------------------------------

'' Naked pascal function
Function subtract_p Naked pascal _  '' parameters pushed onto call stack in same order as declaration
	                     _          '' called procedure responsible for removing parameters from stack
	                     _          ''   (appending constant to RET instruction specifying number of bytes to release)
	( _
	    ByVal a As Long, _       '' parameter pushed onto stack in first
	    ByVal b As Long _
	) As Long
   
	Asm
	    mov eax, dword Ptr [esp+8]  '' eax = a
	    Sub eax, dword Ptr [esp+4]  '' eax -= b
	    ret 8                       '' return result in eax and 8 bytes (2 longs) to release
	End Asm
   
End Function

Print subtract_p( 5, 1 ) '' 5 - 1
