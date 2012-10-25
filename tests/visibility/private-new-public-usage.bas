' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	declare operator new( byval as uinteger ) as T ptr
end type

operator T.new( byval size as uinteger ) as T ptr
	operator = 0
end operator

dim as T ptr p = new T
