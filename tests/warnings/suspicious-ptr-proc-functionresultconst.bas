scope
	dim byval_i as function( )       as       integer
	dim byvalci as function( )       as const integer
	dim byref_i as function( ) byref as       integer
	dim byrefci as function( ) byref as const integer

	#print "no warnings:"
	byval_i = byvalci
	byvalci = byval_i
	byrefci = byref_i  '' safe: const-ref wraps ref (CONST added)

	#print "1 warning:"
	byref_i = byrefci  '' unsafe: ref wraps const-ref (CONST lost)

	#print "8 warnings:"
	byval_i = byref_i
	byval_i = byrefci
	byvalci = byref_i
	byvalci = byrefci
	byref_i = byval_i
	byref_i = byvalci
	byrefci = byval_i
	byrefci = byvalci
end scope

scope
	type UDT
		i as integer
	end type

	dim byval_x as function( )       as       UDT
	dim byvalcx as function( )       as const UDT
	dim byref_x as function( ) byref as       UDT
	dim byrefcx as function( ) byref as const UDT

	#print "no warnings:"
	byval_x = byvalcx
	byvalcx = byval_x
	byrefcx = byref_x  '' safe: const-ref wraps ref (CONST added)

	#print "1 warning:"
	byref_x = byrefcx  '' unsafe: ref wraps const-ref (CONST lost)

	#print "8 warnings:"
	byval_x = byref_x
	byval_x = byrefcx
	byvalcx = byref_x
	byvalcx = byrefcx
	byref_x = byval_x
	byref_x = byvalcx
	byrefcx = byval_x
	byrefcx = byvalcx
end scope
