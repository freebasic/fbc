' TEST_MODE : COMPILE_ONLY_FAIL

type A1
	i as integer
end type
type A2 extends A1
	j as integer
end type

type B1 extends object
	declare virtual function f( ) as A1
end type
type B2 extends B1
	declare function f( ) as A2 override
end type
