'' examples/manual/defines/fboutobj.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_OUT_OBJ__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfboutobj
'' --------

#if __FB_OUT_OBJ__ 
		'... specific instructions when compiling to an object file only
#else
		'... specific instructions when not compiling to an object file only
#endif
