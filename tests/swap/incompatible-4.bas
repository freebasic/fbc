' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	i as integer
end type

type Child extends Parent
	j as integer
end type

dim p as Parent, c as Child

swap p, c
