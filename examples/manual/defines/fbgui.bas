'' examples/manual/defines/fbgui.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_GUI__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbgui
'' --------

#if __FB_GUI__ <> 0
		#print Executable subsystem: gui
#else 
		#print Executable subsystem: console
#endif
