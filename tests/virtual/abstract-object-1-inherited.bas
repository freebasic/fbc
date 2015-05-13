' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f1( )
end type

type B extends A
	'' B inherits A's ABSTRACTs but does not implement them,
	'' so it is an "abstract class" itself
end type

dim x1 as B
