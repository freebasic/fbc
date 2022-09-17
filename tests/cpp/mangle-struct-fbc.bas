' TEST_MODE : MULTI_MODULE_TEST

'' test mapping of structs between fbc and g++
'' with c++ name mangling

extern "c++"

namespace cpp_mangle_struct

	type Simple
		a as long
	end type

	declare function cpp_struct0_byval_1( byval size as long, byval udt as Simple ) as long
	declare function cpp_struct0_byref_2( byval size as long, byref udt as Simple ) as long

	type Outer1
		a as long
		b as long
		type Inner
			c as long
		end type
		d as Inner
	end type

	declare function cpp_struct1_byval_1( byval size as long, byval udt as Outer1 ) as long
	declare function cpp_struct1_byref_2( byval size as long, byref udt as Outer1 ) as long
	declare function cpp_struct1_byval_3( byval size as long, byval udt as Outer1.Inner ) as long
	declare function cpp_struct1_byref_4( byval size as long, byref udt as Outer1.Inner ) as long

	type Outer2
		a as long
		b as long
		c as long
		type Inner
			c as long
			d as long
		end type
		d as Inner
	end type

	declare function cpp_struct2_byval_1( byval size as long, byval udt as Outer2 ) as long
	declare function cpp_struct2_byref_2( byval size as long, byref udt as Outer2 ) as long
	declare function cpp_struct2_byval_3( byval size as long, byval udt as Outer2.Inner ) as long
	declare function cpp_struct2_byref_4( byval size as long, byref udt as Outer2.Inner ) as long

	type Outer3
		a as long
		b as long
		c as long
		type Inner2
			d as long
			e as long
			type Inner1
				f as long
			end type
			g as Inner1
		end type
		h as Inner2
	end type

	declare function cpp_struct3_byval_1( byval size as long, byval udt as Outer3 ) as long
	declare function cpp_struct3_byref_2( byval size as long, byref udt as Outer3 ) as long
	declare function cpp_struct3_byval_3( byval size as long, byval udt as Outer3.Inner2 ) as long
	declare function cpp_struct3_byref_4( byval size as long, byref udt as Outer3.Inner2 ) as long
	declare function cpp_struct3_byval_5( byval size as long, byval udt as Outer3.Inner2.Inner1 ) as long
	declare function cpp_struct3_byref_6( byval size as long, byref udt as Outer3.Inner2.Inner1 ) as long

end namespace

end extern

using cpp_mangle_struct

'' ------------------------------------
'' Simple
'' ------------------------------------

scope
	dim z as Simple
	ASSERT( 01 = cpp_struct0_byval_1( sizeof( Simple ), z ) )
end scope

scope
	dim z as Simple
	ASSERT( 02 = cpp_struct0_byref_2( sizeof( Simple ), z ) )
end scope

'' ------------------------------------
'' Outer1 + Outer1.Inner
'' ------------------------------------

scope
	dim z as Outer1
	ASSERT( 11 = cpp_struct1_byval_1( sizeof( Outer1 ), z ) )
end scope

scope
	dim z as Outer1
	ASSERT( 12 = cpp_struct1_byref_2( sizeof( Outer1 ), z ) )
end scope

scope
	dim z as Outer1.Inner
	ASSERT( 13 = cpp_struct1_byval_3( sizeof( Outer1.Inner ), z ) )
end scope

scope
	dim z as Outer1.Inner
	ASSERT( 14 = cpp_struct1_byref_4( sizeof( Outer1.Inner ), z ) )
end scope

'' ------------------------------------
'' Outer2 + Outer2.Inner
'' ------------------------------------

scope
	dim z as Outer2
	ASSERT( 21 = cpp_struct2_byval_1( sizeof( Outer2 ), z ) )
end scope

scope
	dim z as Outer2
	ASSERT( 22 = cpp_struct2_byref_2( sizeof( Outer2 ), z ) )
end scope

scope
	dim z as Outer2.Inner
	ASSERT( 23 = cpp_struct2_byval_3( sizeof( Outer2.Inner ), z ) )
end scope

scope
	dim z as Outer2.Inner
	ASSERT( 24 = cpp_struct2_byref_4( sizeof( Outer2.Inner ), z ) )
end scope

'' ------------------------------------
'' Outer3 + Outer3.Inner1 + Outer3.Inner1.Inner2
'' ------------------------------------

scope
	dim z as Outer3
	ASSERT( 31 = cpp_struct3_byval_1( sizeof( Outer3 ), z ) )
end scope

scope
	dim z as Outer3
	ASSERT( 32 = cpp_struct3_byref_2( sizeof( Outer3 ), z ) )
end scope

scope
	dim z as Outer3.Inner2
	ASSERT( 33 = cpp_struct3_byval_3( sizeof( Outer3.Inner2 ), z ) )
end scope

scope
	dim z as Outer3.Inner2
	ASSERT( 34 = cpp_struct3_byref_4( sizeof( Outer3.Inner2 ), z ) )
end scope

scope
	dim z as Outer3.Inner2.Inner1
	ASSERT( 35 = cpp_struct3_byval_5( sizeof( Outer3.Inner2.Inner1 ), z ) )
end scope

scope
	dim z as Outer3.Inner2.Inner1
	ASSERT( 36 = cpp_struct3_byref_6( sizeof( Outer3.Inner2.Inner1 ), z ) )
end scope
