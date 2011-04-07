'' examples/manual/prepro/define.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpdefine
'' --------

'' Definition and check
#define DEBUGGING
#ifdef DEBUGGING
  ' ... statements
#endif

'' Simple definition/text replacement
#define FALSE 0
#define TRUE (Not FALSE)

'' Function like definition
#define MyRGB(R,G,B) (((R)Shl 16)  Or ((G)Shl 8) Or (B)) 
Print Hex( MyRGB(&hff, &h00, &hff) )

'' Line continuation and statements in a definition
#define printval(bar) _
	Print #bar; " ="; bar

'' #defines are visible only in the scope where they are defined
Scope
	#define LOCALDEF 1
End Scope

#ifndef LOCALDEF
#	Print LOCALDEF Is Not defined
#endif

'' namespaces have no effect on the visibility of a define
Namespace foo
#	define NSDEF
End Namespace

#ifdef NSDEF
#	Print NSDEF Is defined
#endif
