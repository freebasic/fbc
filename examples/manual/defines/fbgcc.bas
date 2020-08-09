'' examples/manual/defines/fbgcc.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbgcc
'' --------

#if __FB_GCC__ <> 0
		#print Backend Code Emitter And Assembler: gcc
#else 
		#print Backend Code Emitter And Assembler: Not gcc
#endif
	
