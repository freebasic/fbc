'' examples/manual/defines/fboutexe.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutexe
'' --------

#if __FB_OUT_EXE__ 
	    '... specific instructions when making an executable
#else
	    '... specific instructions when not making an executable
#endif
