# include "fbcu.bi"

namespace fbc_tests.swp.strings

sub testLocalVars cdecl( )
	#macro make( TA, TB )
		scope
			dim as TA a
			dim as TB b

			a = "1"
			b = "0"
			swap a, b
			CU_ASSERT( a = "0" )
			CU_ASSERT( b = "1" )
		end scope
	#endmacro

	make( string, string )
	make( string, string * 5 )
	make( string, zstring * 5 )

	make( string * 5, string )
	make( string * 5, string * 5 )
	make( string * 5, zstring * 5 )

	make( zstring * 5, string )
	make( zstring * 5, string * 5 )
	make( zstring * 5, zstring * 5 )

	make( wstring * 5, wstring * 5 )
end sub

sub testStaticVars cdecl( )
	#macro make( TA, TB )
		scope
			static as TA static_a
			static as TB static_b

			static_a = "1"
			static_b = "0"
			swap static_a, static_b
			CU_ASSERT( static_a = "0" )
			CU_ASSERT( static_b = "1" )
		end scope
	#endmacro

	make( string, string )
	make( string, string * 5 )
	make( string, zstring * 5 )

	make( string * 5, string )
	make( string * 5, string * 5 )
	make( string * 5, zstring * 5 )

	make( zstring * 5, string )
	make( zstring * 5, string * 5 )
	make( zstring * 5, zstring * 5 )

	make( wstring * 5, wstring * 5 )
end sub

sub testLocalVarsAndStaticVars cdecl( )
	#macro make( TA, TB )
		scope
			dim as TA a
			static as TB static_b

			a = "1"
			static_b = "0"
			swap a, static_b
			CU_ASSERT( a = "0" )
			CU_ASSERT( static_b = "1" )
		end scope
	#endmacro

	make( string, string )
	make( string, string * 5 )
	make( string, zstring * 5 )

	make( string * 5, string )
	make( string * 5, string * 5 )
	make( string * 5, zstring * 5 )

	make( zstring * 5, string )
	make( zstring * 5, string * 5 )
	make( zstring * 5, zstring * 5 )

	make( wstring * 5, wstring * 5 )
end sub

sub testStaticVarsAndLocalVars cdecl( )
	#macro make( TA, TB )
		scope
			dim as TB b
			static as TA static_a

			static_a = "1"
			b = "0"
			swap static_a, b
			CU_ASSERT( static_a = "0" )
			CU_ASSERT( b = "1" )
		end scope
	#endmacro

	make( string, string )
	make( string, string * 5 )
	make( string, zstring * 5 )

	make( string * 5, string )
	make( string * 5, string * 5 )
	make( string * 5, zstring * 5 )

	make( zstring * 5, string )
	make( zstring * 5, string * 5 )
	make( zstring * 5, zstring * 5 )

	make( wstring * 5, wstring * 5 )
end sub

dim shared as string global_string_a
dim shared as string global_string_b
dim shared as string * 5 global_fixstr_a
dim shared as string * 5 global_fixstr_b
dim shared as zstring * 5 global_zstring_a
dim shared as zstring * 5 global_zstring_b
dim shared as wstring * 5 global_wstring_a
dim shared as wstring * 5 global_wstring_b

sub testGlobalVars cdecl( )
	global_string_a = "1"
	global_string_b = "0"
	swap global_string_a, global_string_b
	CU_ASSERT( global_string_a = "0" )
	CU_ASSERT( global_string_b = "1" )

	global_fixstr_a = "1"
	global_fixstr_b = "0"
	swap global_fixstr_a, global_fixstr_b
	CU_ASSERT( global_fixstr_a = "0" )
	CU_ASSERT( global_fixstr_b = "1" )

	global_zstring_a = "1"
	global_zstring_b = "0"
	swap global_zstring_a, global_zstring_b
	CU_ASSERT( global_zstring_a = "0" )
	CU_ASSERT( global_zstring_b = "1" )

	global_wstring_a = "1"
	global_wstring_b = "0"
	swap global_wstring_a, global_wstring_b
	CU_ASSERT( global_wstring_a = "0" )
	CU_ASSERT( global_wstring_b = "1" )

	global_string_a = "1"
	global_fixstr_b = "0"
	swap global_string_a, global_fixstr_b
	CU_ASSERT( global_string_a = "0" )
	CU_ASSERT( global_fixstr_b = "1" )

	global_fixstr_a = "1"
	global_string_b = "0"
	swap global_fixstr_a, global_string_b
	CU_ASSERT( global_fixstr_a = "0" )
	CU_ASSERT( global_string_b = "1" )

	global_string_a = "1"
	global_zstring_b = "0"
	swap global_string_a, global_zstring_b
	CU_ASSERT( global_string_a = "0" )
	CU_ASSERT( global_zstring_b = "1" )

	global_zstring_a = "1"
	global_string_b = "0"
	swap global_zstring_a, global_string_b
	CU_ASSERT( global_zstring_a = "0" )
	CU_ASSERT( global_string_b = "1" )
end sub

dim shared as string global_array(0 to 1)

sub testArrays cdecl( )
	static as string static_array(0 to 1)
	dim as string array(0 to 1)

	#macro make( i, j )
		array(i) = "1"
		array(j) = "0"
		swap array(i), array(j)
		CU_ASSERT( array(i) = "0" )
		CU_ASSERT( array(j) = "1" )

		static_array(i) = "1"
		static_array(j) = "0"
		swap static_array(i), static_array(j)
		CU_ASSERT( static_array(i) = "0" )
		CU_ASSERT( static_array(j) = "1" )

		array(i) = "1"
		static_array(j) = "0"
		swap array(i), static_array(j)
		CU_ASSERT( array(i) = "0" )
		CU_ASSERT( static_array(j) = "1" )

		static_array(i) = "1"
		array(j) = "0"
		swap static_array(i), array(j)
		CU_ASSERT( static_array(i) = "0" )
		CU_ASSERT( array(j) = "1" )

		global_array(i) = "1"
		global_array(j) = "0"
		swap global_array(i), global_array(j)
		CU_ASSERT( global_array(i) = "0" )
		CU_ASSERT( global_array(j) = "1" )

		array(i) = "1"
		global_array(j) = "0"
		swap array(i), global_array(j)
		CU_ASSERT( array(i) = "0" )
		CU_ASSERT( global_array(j) = "1" )

		global_array(i) = "1"
		array(j) = "0"
		swap global_array(i), array(j)
		CU_ASSERT( global_array(i) = "0" )
		CU_ASSERT( array(j) = "1" )

		global_array(i) = "1"
		static_array(j) = "0"
		swap global_array(i), static_array(j)
		CU_ASSERT( global_array(i) = "0" )
		CU_ASSERT( static_array(j) = "1" )

		static_array(i) = "1"
		global_array(j) = "0"
		swap static_array(i), global_array(j)
		CU_ASSERT( static_array(i) = "0" )
		CU_ASSERT( global_array(j) = "1" )
	#endmacro

	make( 0, 1 )

	dim as integer i = 0, j = 1

	make( i, j )
end sub

sub testArraysAndVars cdecl( )
	dim as integer i = 0

	scope
		dim as string a(0 to 0)
		dim as string b

		a(0) = "1"
		b = "0"

		swap a(i), b

		CU_ASSERT( a(0) = "0" )
		CU_ASSERT( b = "1" )

		swap b, a(i)

		CU_ASSERT( a(0) = "1" )
		CU_ASSERT( b = "0" )
	end scope

	scope
		static as string a(0 to 0)
		static as string b

		a(0) = "1"
		b = "0"

		swap a(i), b

		CU_ASSERT( a(0) = "0" )
		CU_ASSERT( b = "1" )

		swap b, a(i)

		CU_ASSERT( a(0) = "1" )
		CU_ASSERT( b = "0" )
	end scope

	scope
		global_array(0) = "1"
		global_string_b = "0"

		swap global_array(i), global_string_b

		CU_ASSERT( global_array(0) = "0" )
		CU_ASSERT( global_string_b = "1" )

		swap global_string_b, global_array(i)

		CU_ASSERT( global_array(0) = "1" )
		CU_ASSERT( global_string_b = "0" )
	end scope
end sub

sub testDerefs cdecl( )
	scope
		dim as string a, b
		a = "1"
		b = "0"

		dim as string ptr pa = @a, pb = @b

		swap *pa, *pb

		CU_ASSERT( a = "0" )
		CU_ASSERT( b = "1" )

		swap a, *pb

		CU_ASSERT( a = "1" )
		CU_ASSERT( b = "0" )

		swap *pa, b

		CU_ASSERT( a = "0" )
		CU_ASSERT( b = "1" )
	end scope

	scope
		dim as zstring * 5 a, b
		a = "1"
		b = "0"

		dim as zstring ptr pa = @a, pb = @b

		swap *pa, *pb

		CU_ASSERT( a = "0" )
		CU_ASSERT( b = "1" )

		swap a, *pb

		CU_ASSERT( a = "1" )
		CU_ASSERT( b = "0" )

		swap *pa, b

		CU_ASSERT( a = "0" )
		CU_ASSERT( b = "1" )
	end scope

	scope
		dim as wstring * 5 a, b
		a = wstr("1")
		b = wstr("0")

		dim as wstring ptr pa = @a, pb = @b

		swap *pa, *pb

		CU_ASSERT( a = wstr("0") )
		CU_ASSERT( b = wstr("1") )

		swap a, *pb

		CU_ASSERT( a = wstr("1") )
		CU_ASSERT( b = wstr("0") )

		swap *pa, b

		CU_ASSERT( a = wstr("0") )
		CU_ASSERT( b = wstr("1") )
	end scope
end sub

sub testDerefsAndVars cdecl( )
	dim as string a
	dim as string b
	dim as string ptr pa = @a

	a = "1"
	b = "0"

	swap *pa, b

	CU_ASSERT( a = "0" )
	CU_ASSERT( b = "1" )

	swap b, *pa

	CU_ASSERT( a = "1" )
	CU_ASSERT( b = "0" )
end sub

sub testDerefsAndArrays cdecl( )
	dim as string a
	dim as string b(0 to 0)

	dim as integer i = 0
	dim as string ptr pa = @a

	a = "1"
	b(0) = "0"

	swap *pa, b(i)

	CU_ASSERT( a = "0" )
	CU_ASSERT( b(0) = "1" )

	swap b(i), *pa

	CU_ASSERT( a = "1" )
	CU_ASSERT( b(0) = "0" )
end sub

type T
	as string a, b
end type

sub testFields cdecl( )
	dim as T x
	x.a = "1"
	x.b = "0"

	swap x.a, x.b

	CU_ASSERT( x.a = "0" )
	CU_ASSERT( x.b = "1" )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fb_tests.swap.strings" )
	fbcu.add_test( "SWAP on local vars", @testLocalVars )
	fbcu.add_test( "SWAP on static vars", @testStaticVars )
	fbcu.add_test( "SWAP local, static", @testLocalVarsAndStaticVars )
	fbcu.add_test( "SWAP static, local", @testStaticVarsAndLocalVars )
	fbcu.add_test( "SWAP on global vars", @testGlobalVars )
	fbcu.add_test( "SWAP with arrays", @testArrays )
	fbcu.add_test( "SWAP arrayelement, var", @testArraysAndVars )
	fbcu.add_test( "SWAP on derefs", @testDerefs )
	fbcu.add_test( "SWAP deref, var", @testDerefsAndVars )
	fbcu.add_test( "SWAP deref, arrayelement", @testDerefsAndArrays )
	fbcu.add_test( "SWAP on string fields", @testFields )
end sub

end namespace
