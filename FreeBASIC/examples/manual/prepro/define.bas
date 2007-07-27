'' examples/manual/prepro/define.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=KeyPgPpdefine
'' --------

#define DEBUGGING
#ifdef DEBUGGING
  ' ... statements
#endif

#define FALSE 0
#define TRUE (Not FALSE)

#define MyRGB(R,G,B) (((R)Shl 16)  Or ((G)Shl 8) Or (B)) 
Print Hex( MyRGB(&hff, &h00, &hff) )

#define printval(bar) _
	Print #bar; " ="; bar
