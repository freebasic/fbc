' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare operator @( ) as T ptr
end type

operator T.@( ) as T ptr
	operator = @this
end operator

dim as T x
dim as T ptr p = @x
