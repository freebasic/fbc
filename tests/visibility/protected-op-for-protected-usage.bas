' TEST_MODE : COMPILE_ONLY_OK

type T
	public:
		n as integer
		declare operator step( byref stp as T )
		declare operator next( byref cond as T, byref stp as T ) as integer
	protected:
		declare operator for (byref stp as T)
end type

operator T.for( byref x as T )
end operator

operator T.next( byref cond as T, byref stp as T ) as integer
	return 0
end operator

operator T.step( byref stp as T )
end operator

type U extends T
	private:
		declare sub proc()
end type

sub U.proc()
	for i as T = type<T>(3) to type<T>(3) step type<T>(1)
	next
end sub
 
