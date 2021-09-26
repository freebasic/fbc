'' examples/manual/prepro/cmdline2.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpcmdline
'' --------

'' not processed in single line comments
'#cmdline "asdf"

'' not processed in multi line comments
/'
#cmdline "-asdf"
'/

'' not processed in strings
Print "#cmdline ""-asdf"""

'' not processed if skipping over a conditional
#if 0
   #cmdline "-asdf"
#endif

'' not processed when defining macros (as long as the macro is not called)
#macro DOARGS
   #cmdline "-asdf"
#endmacro

Sleep
		
