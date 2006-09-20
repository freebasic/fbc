' TEST_MODE : COMPILE_ONLY_OK

'' with = only

type foo
	value as integer = any
	
	declare operator + ( byref rhs as foo )
	declare operator - ( byref rhs as foo )
	declare operator * ( byref rhs as foo )
	declare operator \ ( byref rhs as foo )

end type

operator foo.+ ( byref rhs as foo )
	value += rhs.value
end operator

operator foo.- ( byref rhs as foo )
	value -= rhs.value
end operator

operator foo.* ( byref rhs as foo )
	value *= rhs.value
end operator

operator foo.\ ( byref rhs as foo )
	value \= rhs.value
end operator

sub foo_test
	dim as foo l, r
	l += r	
	l -= r
	l *= r
	l \= r
end sub

'' with op=

type bar
	value as integer = any
	
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
