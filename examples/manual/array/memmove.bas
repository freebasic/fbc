'' examples/manual/array/memmove.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'FB_MEMMOVE'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgFBMemmove
'' --------

Dim As ZString * 33 z = "memmove can be very useful......"

Print z

fb_memmove(z[20], z[15], 11)

Print z

Sleep
	
