'' examples/manual/defines/fbasm.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_ASM__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbasm
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
