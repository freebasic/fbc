'' examples/manual/defines/fbgui.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbgui
'' --------

#if __FB_GUI__ <> 0
		#print Executable subsystem: gui
#else 
		#print Executable subsystem: console
#endif
