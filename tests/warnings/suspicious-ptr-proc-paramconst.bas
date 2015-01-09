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
