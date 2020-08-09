'' examples/manual/array/memmove.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFBMemmove
'' --------

Dim As ZString * 33 z = "memmove can be very useful......"

Print z

fb_memmove(z[20], z[15], 11)

Print z

Sleep
	
