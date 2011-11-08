' TEST_MODE : COMPILE_ONLY_OK

type foo
	dummy as integer
end type

operator = ( byref lhs as foo, byref rhs as foo ) as integer

	operator = (lhs.dummy = rhs.dummy)

end operator

operator + ( byref lhs as foo, byref rhs as foo ) as integer

	operator = (lhs.dummy = rhs.dummy)

end operator

