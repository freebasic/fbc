' TEST_MODE : COMPILE_ONLY_OK

type T
	public:
		n as integer
		declare operator for (byref stp as T)
		declare operator step( byref stp as T )
	protected:
		declare operator next( byref cond as T, byref stp as T ) as integer
	private:
		declare sub proc()
end type

operator T.for( byref x as T )
end operator

operator T.next( byref cond as T, byref stp as T ) as integer
	return 0
end operator

operator T.step( byref stp as T )
end operator

sub T.proc()
	for i as T = type<T>(3) to type<T>(3) step type<T>(1)
	next
end sub
