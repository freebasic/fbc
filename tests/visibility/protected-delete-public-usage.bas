' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare operator delete( byval as T ptr )
end type

operator T.delete( byval p as T ptr )
end operator

dim as T ptr p
delete p
