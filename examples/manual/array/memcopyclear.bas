'' examples/manual/array/memcopyclear.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFBMemcopyclear
'' --------

Dim src As ZString * 10 = "FreeBASIC"
Dim dst As ZString * 10 = "012345678"

Print "before:"
Print "src = " & src
Print "dst = " & dst
Print

'' copy first 4 bytes and clear the rest
fb_memcopyclear(dst, SizeOf(dst), src, 4)

Print "after:"
Print "src = " & src
Print "dst = " & dst

Sleep
	
