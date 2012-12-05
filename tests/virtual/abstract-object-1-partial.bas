' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f1( )
	declare abstract sub f2( )
end type

type B extends A
	declare sub f1( )
	'' B inherits A's ABSTRACTs but only implements some of them,
	'' so it is an "abstract class" itself
end type

sub B.f1( )
end sub

dim x1 as B
