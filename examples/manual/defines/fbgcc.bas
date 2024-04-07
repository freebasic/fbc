'' examples/manual/defines/fbgcc.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_GCC__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbgcc
'' --------

#if __FB_GCC__ <> 0
		#print Backend Code Emitter And Assembler: gcc
#else 
		#print Backend Code Emitter And Assembler: Not gcc
#endif
	
