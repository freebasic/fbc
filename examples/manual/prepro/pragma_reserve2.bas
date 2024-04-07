'' examples/manual/prepro/pragma_reserve2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#PRAGMA RESERVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpPragmaReserve
'' --------

'' for x86_64

#cmdline "-gen gas64 -r"

Dim Shared xyz As Integer

Sub proc Naked()
	Asm
		xyz
		ret
	End Asm
End Sub

/'
OUTPUT in the .asm file:

   .intel_syntax noprefix
   .section .text
   .text
   .globl PROC
PROC:
   .L_0004:
   XYZ$
   ret
   .L_0005:
   ret
.....

'/
