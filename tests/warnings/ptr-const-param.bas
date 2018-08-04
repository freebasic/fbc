'' ensure const discarded warnings are turned off
'' else, we get additional warnings

#pragma constness=false

#print ASSIGNMENT

#print "BYREF parameter CONSTness"
scope
	dim _i__ as sub( byref as       integer           )
	dim ci__ as sub( byref as const integer           )
	dim _i_p as sub( byref as       integer       ptr )
	dim _icp as sub( byref as       integer const ptr )
	dim ci_p as sub( byref as const integer       ptr )
	dim cicp as sub( byref as const integer const ptr )

	'' safe - a non-CONST can be used instead of a CONST
	#print "no warnings:"
	_i__ = ci__
	_i_p = _icp
	_i_p = ci_p
	_i_p = cicp
	_icp = cicp
	ci_p = cicp

	'' unsafe - a CONST can't be used instead of a non-CONST
	#print "8 warnings:"
	ci__ = _i__
	_icp = _i_p
	_icp = ci_p
	ci_p = _i_p
	ci_p = _icp
	cicp = _i_p
	cicp = _icp
	cicp = ci_p
end scope

#print "BYVAL parameter CONSTness"
scope
	dim _i__ as sub( byval as       integer           )
	dim ci__ as sub( byval as const integer           )
	dim _i_p as sub( byval as       integer       ptr )
	dim _icp as sub( byval as       integer const ptr )
	dim ci_p as sub( byval as const integer       ptr )
	dim cicp as sub( byval as const integer const ptr )

	#print "no warnings:"
	_i__ = ci__
	ci__ = _i__
	_i_p = _icp
	_i_p = ci_p
	_i_p = cicp
	_icp = _i_p
	_icp = ci_p
	_icp = cicp
	ci_p = cicp
	cicp = ci_p

	#print "4 warnings:"
	ci_p = _i_p
	ci_p = _icp
	cicp = _i_p
	cicp = _icp
end scope

#print PARAMETER

#print "BYREF parameter CONSTness"

declare sub byref__i__	( byval as sub( byref as       integer           ) )
declare sub byref_ci__	( byval as sub( byref as const integer           ) )
declare sub byref__i_p	( byval as sub( byref as       integer       ptr ) )
declare sub byref__icp	( byval as sub( byref as       integer const ptr ) )
declare sub byref_ci_p	( byval as sub( byref as const integer       ptr ) )
declare sub byref_cicp	( byval as sub( byref as const integer const ptr ) )

scope
	dim _i__ as sub( byref as       integer           )
	dim ci__ as sub( byref as const integer           )
	dim _i_p as sub( byref as       integer       ptr )
	dim _icp as sub( byref as       integer const ptr )
	dim ci_p as sub( byref as const integer       ptr )
	dim cicp as sub( byref as const integer const ptr )

	'' safe - a non-CONST can be used instead of a CONST
	#print "no warnings:"
	byref__i__( ci__ )
	byref__i_p( _icp )
	byref__i_p( ci_p )
	byref__i_p( cicp )
	byref__icp( cicp )
	byref_ci_p( cicp )

	'' unsafe - a CONST can't be used instead of a non-CONST
	#print "8 warnings:"
	byref_ci__( _i__ )
	byref__icp( _i_p )
	byref__icp( ci_p )
	byref_ci_p( _i_p )
	byref_ci_p( _icp )
	byref_cicp( _i_p )
	byref_cicp( _icp )
	byref_cicp( ci_p )
end scope

#print "BYVAL parameter CONSTness"

declare sub byval__i__( byval as sub( byval as       integer           ) )
declare sub byval_ci__( byval as sub( byval as const integer           ) )
declare sub byval__i_p( byval as sub( byval as       integer       ptr ) )
declare sub byval__icp( byval as sub( byval as       integer const ptr ) )
declare sub byval_ci_p( byval as sub( byval as const integer       ptr ) )
declare sub byval_cicp( byval as sub( byval as const integer const ptr ) )

scope
	dim _i__ as sub( byval as       integer           )
	dim ci__ as sub( byval as const integer           )
	dim _i_p as sub( byval as       integer       ptr )
	dim _icp as sub( byval as       integer const ptr )
	dim ci_p as sub( byval as const integer       ptr )
	dim cicp as sub( byval as const integer const ptr )

	#print "no warnings:"
	byval__i__( ci__ )
	byval_ci__( _i__ )
	byval__i_p( _icp )
	byval__i_p( ci_p )
	byval__i_p( cicp )
	byval__icp( _i_p )
	byval__icp( ci_p )
	byval__icp( cicp )
	byval_ci_p( cicp )
	byval_cicp( ci_p )

	#print "4 warnings:"
	byval_ci_p( _i_p )
	byval_ci_p( _icp )
	byval_cicp( _i_p )
	byval_cicp( _icp )
end scope
