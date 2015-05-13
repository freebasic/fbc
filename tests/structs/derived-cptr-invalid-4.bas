' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
end type

type Child extends Parent
end type

type T
	as integer i
end type

dim as T ptr t

print cptr( Child ptr, t )
