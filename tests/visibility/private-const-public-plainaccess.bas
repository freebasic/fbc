' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	const MYCONST = 123
end type

dim as integer i
i = T.MYCONST
