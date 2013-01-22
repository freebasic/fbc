' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
end type

operator A.cast( ) as integer
	operator = &hA
end operator

dim xa as A
print cint( xa )
