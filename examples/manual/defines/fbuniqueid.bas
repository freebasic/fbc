'' examples/manual/defines/fbuniqueid.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__FB_UNIQUEID__'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgDdfbuniqueid
'' --------

__FB_UNIQUEID_PUSH__( stk )
#print __FB_UNIQUEID__( stk )

	__FB_UNIQUEID_PUSH__( stk )
	#print __FB_UNIQUEID__( stk )

		__FB_UNIQUEID_PUSH__( stk )
		#print __FB_UNIQUEID__( stk )
		__FB_UNIQUEID_POP__( stk )

	#print __FB_UNIQUEID__( stk )
	__FB_UNIQUEID_POP__( stk )

#print __FB_UNIQUEID__( stk )
__FB_UNIQUEID_POP__( stk )

/' Compiler output example:
Lt_0006
Lt_0007
Lt_0008
Lt_0007
Lt_0006
'/
	
