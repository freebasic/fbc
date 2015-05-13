' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare operator +=( byref as T )
end type

operator T.+=( byref other as T )
end operator

dim as T x
x += x
