'' examples/manual/system/chain.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgChain
'' --------

#ifdef FB__LINUX
#define CHAIN2	"chain2"
#else
#define CHAIN2	"chain2.exe"
#endif

	Print "chain1 begins"

	Chain CHAIN2

	Print "chain1 ends"

	Sleep
