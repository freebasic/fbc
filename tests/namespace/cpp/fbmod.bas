' TEST_MODE : MULTI_MODULE_TEST

#ifdef __FB_64BIT__
	type cxxint as long
#else
	type cxxint as integer
#endif

'' simple

extern "c++"
	namespace cpp
		declare function sum( byval a as cxxint, byval b as cxxint ) as cxxint
		declare function dec( byval a as cxxint, byval b as cxxint ) as cxxint
	end namespace
end extern

	ASSERT( cpp.sum( 1, 2 ) = 3 )
	ASSERT( cpp.dec( 2, 1 ) = 1 )


'' nested

extern "c++"
	namespace cpp.foo.bar
		declare function sum( byval a as cxxint, byval b as cxxint ) as cxxint
		declare function dec( byval a as cxxint, byval b as cxxint ) as cxxint
	end namespace
end extern

	ASSERT( cpp.foo.bar.sum( 2, 2 ) = 4 )
	ASSERT( cpp.foo.bar.dec( 1, 1 ) = 0 )


'' nested + udts

extern "c++"
	namespace cpp.foo.bar
		type udt
			v as cxxint
		end type
	
		declare function sum_udt( byval a as udt ptr, byval b as udt ptr ) as cxxint
		declare function dec_udt( byval a as udt ptr, byval b as udt ptr ) as cxxint
	end namespace
end extern

	ASSERT( cpp.foo.bar.sum_udt( @type<cpp.foo.bar.udt>(2), @type<cpp.foo.bar.udt>(2) ) = 4 )
	ASSERT( cpp.foo.bar.dec_udt( @type<cpp.foo.bar.udt>(1), @type<cpp.foo.bar.udt>(1) ) = 0 )

'' nested + func ptr

extern "c++"
	namespace cpp.foo.bar
		type baz
			v1 as cxxint
			v2 as cxxint
		end type
	
		declare function sum_fn( byval baz as baz ptr, _
								 byval a as function cdecl(byval as baz ptr) as cxxint, _
								 byval b as function cdecl(byval as baz ptr) as cxxint ) as cxxint
		declare function dec_fn( byval baz as baz ptr, _
								 byval a as function cdecl(byval as baz ptr) as cxxint, _
								 byval b as function cdecl(byval as baz ptr) as cxxint ) as cxxint
	end namespace
end extern

private function fun_v1 cdecl( byval baz as cpp.foo.bar.baz ptr) as cxxint
	function = baz->v1
end function

private function fun_v2 cdecl ( byval baz as cpp.foo.bar.baz ptr) as cxxint
	function = baz->v2
end function

	ASSERT( cpp.foo.bar.sum_fn( @type<cpp.foo.bar.baz>(1,2), @fun_v1, @fun_v2 ) = 3 )
	ASSERT( cpp.foo.bar.dec_fn( @type<cpp.foo.bar.baz>(1,2), @fun_v1, @fun_v2 ) = -1 )
