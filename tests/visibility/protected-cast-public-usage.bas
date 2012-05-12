' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare operator cast( ) as integer
end type

operator T.cast( ) as integer
	operator = i
end operator

dim as T x
dim as integer i
i = x
