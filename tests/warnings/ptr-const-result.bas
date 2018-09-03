scope
	dim byval_i as function( )       as       integer
	dim byvalci as function( )       as const integer
	dim byref_i as function( ) byref as       integer
	dim byrefci as function( ) byref as const integer

	#print "no warnings:"
	byval_i = byvalci
	byvalci = byval_i
	byrefci = byref_i  '' safe: const-ref wraps ref (CONST added)

	#print "2 warnings:"
	byref_i = byrefci  '' unsafe: ref wraps const-ref (CONST lost)

	#print "2 warnings:"
	byval_i = byref_i
	#print "2 warnings:"
	byval_i = byrefci
	#print "2 warnings:"
	byvalci = byref_i
	#print "2 warnings:"
	byvalci = byrefci
	#print "2 warnings:"
	byref_i = byval_i
	#print "2 warnings:"
	byref_i = byvalci
	#print "2 warnings:"
	byrefci = byval_i
	#print "2 warnings:"
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

	#print "2 warnings:"
	byref_x = byrefcx  '' unsafe: ref wraps const-ref (CONST lost)

	#print "2 warnings:"
	byval_x = byref_x
	#print "2 warnings:"
	byval_x = byrefcx
	#print "2 warnings:"
	byvalcx = byref_x
	#print "2 warnings:"
	byvalcx = byrefcx
	#print "2 warnings:"
	byref_x = byval_x
	#print "2 warnings:"
	byref_x = byvalcx
	#print "2 warnings:"
	byrefcx = byval_x
	#print "2 warnings:"
	byrefcx = byvalcx
end scope
