' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f1( )
	x as integer
end type

print (type<A>()).x
