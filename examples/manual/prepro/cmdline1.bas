'' examples/manual/prepro/cmdline1.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpcmdline
'' --------

#cmdline "-O 2"

Print __FB_OPTIMIZE__  '' just to check the optimization level

Sleep
		
