' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	protected:
	const MYCONST = 123
end type

type Child extends Parent
end type

enum
	NEXTCONST = Child.MYCONST
end enum
