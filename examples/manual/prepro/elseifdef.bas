'' examples/manual/prepro/elseifdef.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ELSEIFDEF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpelseifdef
'' --------

#define B

#ifdef A
	Print "A is defined"
#elseifdef B
	Print "A is not defined and B is defined"
#else
	Print "both A and B are not defined"
#endif
