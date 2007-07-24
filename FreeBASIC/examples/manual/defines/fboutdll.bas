'' examples/manual/defines/fboutdll.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutdll
'' --------

#if __FB_OUT_DLL__ 
	    '... specific instructions when making a shared library (DLL)
#else
	    '... specific instructions when not making a shared library (DLL)
#endif	
