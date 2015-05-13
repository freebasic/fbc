'' examples/manual/defines/fbasm.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbasm
'' --------

Dim a As Long
#if __FB_ASM__ = "intel"
	Asm
 		inc dword Ptr [a]
	End Asm
#else
	Asm
		"incl %0\n" : "+m" (a) : :
	End Asm
#endif
