'' examples/manual/array/memcopyclear.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FB_MEMCOPYCLEAR'
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
fb_MemCopyClear(dst, SizeOf(dst), src, 4)

Print "after:"
Print "src = " & src
Print "dst = " & dst

Sleep
	
