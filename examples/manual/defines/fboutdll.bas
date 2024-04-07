'' examples/manual/defines/fboutdll.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OUT_DLL__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutdll
'' --------

#if __FB_OUT_DLL__ 
		'... specific instructions when making a shared library (DLL)
#else
		'... specific instructions when not making a shared library (DLL)
#endif	
