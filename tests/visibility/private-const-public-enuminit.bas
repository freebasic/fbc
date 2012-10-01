' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	const MYCONST = 123
end type

enum
	NEXTCONST = T.MYCONST
end enum
