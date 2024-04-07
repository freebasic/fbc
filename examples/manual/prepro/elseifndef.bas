'' examples/manual/prepro/elseifndef.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '#ELSEIFNDEF'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpelseifndef
'' --------

#ifdef A
	Print "A is defined"
#elseifndef B
	Print "both A and B are not defined"
#else
	Print "A is not defined and B is defined"
#endif
