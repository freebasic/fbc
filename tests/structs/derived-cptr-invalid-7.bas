' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
end type

type Child extends Parent
end type

dim as integer ptr i

print cast( Child ptr, i )
