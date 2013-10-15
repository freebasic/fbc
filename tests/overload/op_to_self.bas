' TEST_MODE : COMPILE_ONLY_OK

type bar
	value as integer
	declare operator += ( byref rhs as bar )
	declare operator -= ( byref rhs as bar )
	declare operator *= ( byref rhs as bar )
	declare operator \= ( byref rhs as bar )
end type

operator bar.+= ( byref rhs as bar )
	value += rhs.value
end operator

operator bar.-= ( byref rhs as bar )
	value -= rhs.value
end operator

operator bar.*= ( byref rhs as bar )
	value *= rhs.value
end operator

operator bar.\= ( byref rhs as bar )
	value \= rhs.value
end operator

sub bar_test
	dim as bar l, r
	l += r
	l -= r
	l *= r
	l \= r
end sub
