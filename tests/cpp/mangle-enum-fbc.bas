' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of enums between fbc and g++
'' with c++ name mangling

extern "c++"

namespace cpp_mangle_enum

	enum E1 explicit
		A
		B
	end enum

	type T1
		enum E2 explicit
			A
			B
		end enum
		a as long
	end type

	declare function cpp_enum_byval_1( byval e as E1 ) as long
	declare function cpp_enum_byref_2( byref e as E1 ) as long

	declare function cpp_enum_byval_3( byval e as T1.E2 ) as long
	declare function cpp_enum_byref_4( byref e as T1.E2 ) as long

end namespace

end extern

using cpp_mangle_enum

'' ------------------------------------
'' Tests
'' ------------------------------------

scope
	dim z as E1
	ASSERT( 1 = cpp_enum_byval_1( z ) )
end scope

scope
	dim z as E1
	ASSERT( 2 = cpp_enum_byref_2( z ) )
end scope

scope
	dim z as T1.E2
	ASSERT( 3 = cpp_enum_byval_3( z ) )
end scope

scope
	dim z as T1.E2
	ASSERT( 4 = cpp_enum_byref_4( z ) )
end scope

