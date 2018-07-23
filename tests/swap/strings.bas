#include "fbcunit.bi"

SUITE( fbc_tests.swap_.strings )

	'' SWAP on local vars
	TEST( localVars )
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
	END_TEST

	'' SWAP on static vars
	TEST( StaticVars )
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
	END_TEST

	'' SWAP local, static
	TEST( LocalVarsAndStaticVars )
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
	END_TEST

	'' SWAP static, local
	TEST( StaticVarsAndLocalVars )
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
	END_TEST

	dim shared as string global_string_a
	dim shared as string global_string_b
	dim shared as string * 5 global_fixstr_a
	dim shared as string * 5 global_fixstr_b
	dim shared as zstring * 5 global_zstring_a
	dim shared as zstring * 5 global_zstring_b
	dim shared as wstring * 5 global_wstring_a
	dim shared as wstring * 5 global_wstring_b

	'' SWAP on global vars
	TEST( GlobalVars )
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
	END_TEST

	dim shared as string global_array(0 to 1)

	'' SWAP with arrays
	TEST( Arrays )
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
	END_TEST

	'' SWAP arrayelement, var
	TEST( ArraysAndVars )
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
	END_TEST

	'' SWAP on derefs
	TEST( Derefs )
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
	END_TEST

	'' SWAP deref, var
	TEST( DerefsAndVars )
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
	END_TEST

	'' SWAP deref, arrayelement
	TEST( DerefsAndArrays )
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
	END_TEST

	type T
		as string a, b
	end type

	'' SWAP on string fields
	TEST( Fields )
		dim as T x
		x.a = "1"
		x.b = "0"

		swap x.a, x.b

		CU_ASSERT( x.a = "0" )
		CU_ASSERT( x.b = "1" )
	END_TEST

	'' SWAP on strings of different lengths
	TEST( DifferentLengths )
		'' Strings

		scope
			dim as string a, b
			swap a, b
			CU_ASSERT( len(a) = 0 )
			CU_ASSERT( len(b) = 0 )
			CU_ASSERT( a = "" )
			CU_ASSERT( b = "" )
		end scope

		scope
			dim as string a, b

			a = "a"
			swap a, b
			CU_ASSERT( len(a) = 0 )
			CU_ASSERT( len(b) = 1 )
			CU_ASSERT( a = "" )
			CU_ASSERT( b = "a" )

			swap a, b
			CU_ASSERT( len(a) = 1 )
			CU_ASSERT( len(b) = 0 )
			CU_ASSERT( a = "a" )
			CU_ASSERT( b = "" )
		end scope

		scope
			dim as string a, b
			a = "foobarbaz"
			b = "test"
			swap a, b
			CU_ASSERT( len(a) = 4 )
			CU_ASSERT( len(b) = 9 )
			CU_ASSERT( a = "test" )
			CU_ASSERT( b = "foobarbaz" )

			swap a, b
			CU_ASSERT( len(a) = 9 )
			CU_ASSERT( len(b) = 4 )
			CU_ASSERT( a = "foobarbaz" )
			CU_ASSERT( b = "test" )
		end scope

		'' Fixed-size strings

		scope
			dim as string s
			dim as string * 1 f
			CU_ASSERT( sizeof(f) = 2 )

			s = "foobarbaz"
			swap s, f
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( f = "f" )
			CU_ASSERT( f[1] = 0 )

			swap s, f
			CU_ASSERT( len(s) = 1 )
			CU_ASSERT( s = "f" )
			CU_ASSERT( f = "" )
			CU_ASSERT( f[0] = 0 )

			s = "foobarbaz"
			swap f, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( f = "f" )
			CU_ASSERT( f[1] = 0 )

			swap f, s
			CU_ASSERT( len(s) = 1 )
			CU_ASSERT( s = "f" )
			CU_ASSERT( f = "" )
			CU_ASSERT( f[0] = 0 )
		end scope

		scope
			dim as string s
			dim as string * 9 f

			s = "foobarbaz"
			swap s, f
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( f = "foobarbaz" )
			CU_ASSERT( f[9] = 0 )

			swap s, f
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( f = "" )
			CU_ASSERT( f[0] = 0 )

			swap f, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( f = "foobarbaz" )
			CU_ASSERT( f[9] = 0 )

			swap f, s
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( f = "" )
			CU_ASSERT( f[0] = 0 )
		end scope

		scope
			dim as string * 9 a
			dim as string * 4 b

			a = "foobarbaz"
			b = "test"
			swap a, b
			CU_ASSERT( a = "test" )
			CU_ASSERT( b = "foob" )
			CU_ASSERT( a[4] = 0 )
			CU_ASSERT( b[4] = 0 )

			a = "foobarbaz"
			b = "test"
			swap b, a
			CU_ASSERT( a = "test" )
			CU_ASSERT( b = "foob" )
			CU_ASSERT( a[4] = 0 )
			CU_ASSERT( b[4] = 0 )
		end scope

		'' Fixed-size zstrings

		scope
			dim as string s
			dim as zstring * 1 z

			swap s, z
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )

			swap z, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )

			s = "foobarbaz"
			swap s, z
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )

			s = "foobarbaz"
			swap z, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )
		end scope

		scope
			dim as string s
			dim as zstring * 2 z

			s = "foobarbaz"
			swap s, z
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 1 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "f" )
			CU_ASSERT( z[1] = 0 )

			swap s, z
			CU_ASSERT( len(s) = 1 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "f" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )

			s = "foobarbaz"
			swap z, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 1 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "f" )
			CU_ASSERT( z[1] = 0 )

			swap z, s
			CU_ASSERT( len(s) = 1 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "f" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )
		end scope

		scope
			dim as string s
			dim as zstring * 10 z

			s = "foobarbaz"
			swap s, z
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 9 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "foobarbaz" )
			CU_ASSERT( z[9] = 0 )

			swap s, z
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )

			swap z, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(z) = 9 )
			CU_ASSERT( s = "" )
			CU_ASSERT( z = "foobarbaz" )
			CU_ASSERT( z[9] = 0 )

			swap z, s
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( z = "" )
			CU_ASSERT( z[0] = 0 )
		end scope

		scope
			dim as zstring * 10 a
			dim as zstring * 1 b

			a = "foobarbaz"
			b = ""
			swap a, b
			CU_ASSERT( len(a) = 0 )
			CU_ASSERT( len(b) = 0 )
			CU_ASSERT( a = "" )
			CU_ASSERT( b = "" )
			CU_ASSERT( a[0] = 0 )
			CU_ASSERT( b[0] = 0 )

			a = "foobarbaz"
			b = ""
			swap b, a
			CU_ASSERT( len(a) = 0 )
			CU_ASSERT( len(b) = 0 )
			CU_ASSERT( a = "" )
			CU_ASSERT( b = "" )
			CU_ASSERT( a[0] = 0 )
			CU_ASSERT( b[0] = 0 )
		end scope

		scope
			dim as zstring * 5 a
			dim as zstring * 10 b

			a = "test"
			b = "foobarbaz"
			swap a, b
			CU_ASSERT( len(a) = 4 )
			CU_ASSERT( len(b) = 4 )
			CU_ASSERT( a = "foob" )
			CU_ASSERT( b = "test" )
			CU_ASSERT( a[4] = 0 )
			CU_ASSERT( b[4] = 0 )

			a = "test"
			b = "foobarbaz"
			swap b, a
			CU_ASSERT( len(a) = 4 )
			CU_ASSERT( len(b) = 4 )
			CU_ASSERT( a = "foob" )
			CU_ASSERT( b = "test" )
			CU_ASSERT( a[4] = 0 )
			CU_ASSERT( b[4] = 0 )
		end scope

		'' User-allocated zstrings (assumed to be large enough)

		scope
			dim as string s
			dim as zstring ptr pz = callocate( sizeof(zstring) * 1 )

			swap s, *pz
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( (*pz)[0] = 0 )

			swap *pz, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( s = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( (*pz)[0] = 0 )

			deallocate( pz )
		end scope

		scope
			dim as string s
			dim as zstring ptr pz = callocate( sizeof(zstring) * 10 )

			s = "foobarbaz"
			*pz = ""
			swap s, *pz
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(*pz) = 9 )
			CU_ASSERT( s = "" )
			CU_ASSERT( *pz = "foobarbaz" )
			CU_ASSERT( (*pz)[9] = 0 )

			s = "foobarbaz"
			*pz = ""
			swap *pz, s
			CU_ASSERT( len(s) = 0 )
			CU_ASSERT( len(*pz) = 9 )
			CU_ASSERT( s = "" )
			CU_ASSERT( *pz = "foobarbaz" )
			CU_ASSERT( (*pz)[9] = 0 )

			s = ""
			*pz = "foobarbaz"
			swap s, *pz
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( (*pz)[0] = 0 )

			s = ""
			*pz = "foobarbaz"
			swap *pz, s
			CU_ASSERT( len(s) = 9 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( s = "foobarbaz" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( (*pz)[0] = 0 )

			deallocate( pz )
		end scope

		scope
			dim as zstring * 1 z
			dim as zstring ptr pz = callocate( sizeof(zstring) * 1 )

			swap z, *pz
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			swap *pz, z
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			deallocate( pz )
		end scope

		scope
			dim as zstring * 10 z
			dim as zstring ptr pz = callocate( sizeof(zstring) * 10 )

			z = "foobarbaz"
			*pz = ""
			swap z, *pz
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 9 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "foobarbaz" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[9] = 0 )

			z = "foobarbaz"
			*pz = ""
			swap *pz, z
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 9 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "foobarbaz" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[9] = 0 )

			z = ""
			*pz = "foobarbaz"
			swap z, *pz
			CU_ASSERT( len(z) = 9 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "foobarbaz" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[9] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			z = ""
			*pz = "foobarbaz"
			swap *pz, z
			CU_ASSERT( len(z) = 9 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "foobarbaz" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[9] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			deallocate( pz )
		end scope

		scope
			dim as zstring * 1 z
			dim as zstring ptr pz = callocate( sizeof(zstring) * 10 )

			*pz = "foobarbaz"
			swap z, *pz
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			*pz = "foobarbaz"
			swap *pz, z
			CU_ASSERT( len(z) = 0 )
			CU_ASSERT( len(*pz) = 0 )
			CU_ASSERT( z = "" )
			CU_ASSERT( *pz = "" )
			CU_ASSERT( z[0] = 0 )
			CU_ASSERT( (*pz)[0] = 0 )

			deallocate( pz )
		end scope

		scope
			dim as zstring ptr a = callocate( sizeof(zstring) * 10 )
			dim as zstring ptr b = callocate( sizeof(zstring) * 10 )

			*a = "foobarbaz"
			*b = "test"
			swap *a, *b
			CU_ASSERT( len(*a) = 4 )
			CU_ASSERT( len(*b) = 9 )
			CU_ASSERT( *a = "test" )
			CU_ASSERT( *b = "foobarbaz" )
			CU_ASSERT( (*a)[4] = 0 )
			CU_ASSERT( (*b)[9] = 0 )

			swap *a, *b
			CU_ASSERT( len(*a) = 9 )
			CU_ASSERT( len(*b) = 4 )
			CU_ASSERT( *a = "foobarbaz" )
			CU_ASSERT( *b = "test" )
			CU_ASSERT( (*a)[9] = 0 )
			CU_ASSERT( (*b)[4] = 0 )

			deallocate( b )
			deallocate( a )
		end scope

		'' Fixed-size wstrings

		scope
			dim as wstring * 10 w1
			dim as wstring * 1 w2
			w1 = wstr("foobarbaz")
			w2 = wstr("")
			swap w1, w2
			CU_ASSERT( len(w1) = 0 )
			CU_ASSERT( len(w2) = 0 )
			CU_ASSERT( w1 = wstr("") )
			CU_ASSERT( w2 = wstr("") )
			CU_ASSERT( w1[0] = 0 )
			CU_ASSERT( w2[0] = 0 )
		end scope

		scope
			dim as wstring * 1 w1
			dim as wstring * 10 w2
			w1 = wstr("")
			w2 = wstr("foobarbaz")
			swap w1, w2
			CU_ASSERT( len(w1) = 0 )
			CU_ASSERT( len(w2) = 0 )
			CU_ASSERT( w1 = wstr("") )
			CU_ASSERT( w2 = wstr("") )
			CU_ASSERT( w1[0] = 0 )
			CU_ASSERT( w2[0] = 0 )
		end scope

		scope
			dim as wstring * 10 w1
			dim as wstring * 5 w2
			w1 = wstr("foobarbaz")
			w2 = wstr("test")
			swap w1, w2
			CU_ASSERT( len(w1) = 4 )
			CU_ASSERT( len(w2) = 4 )
			CU_ASSERT( w1 = wstr("test") )
			CU_ASSERT( w2 = wstr("foob") )
			CU_ASSERT( w1[4] = 0 )
			CU_ASSERT( w2[4] = 0 )
		end scope

		scope
			dim as wstring * 5 w1
			dim as wstring * 10 w2
			w1 = wstr("test")
			w2 = wstr("foobarbaz")
			swap w1, w2
			CU_ASSERT( len(w1) = 4 )
			CU_ASSERT( len(w2) = 4 )
			CU_ASSERT( w1 = wstr("foob") )
			CU_ASSERT( w2 = wstr("test") )
			CU_ASSERT( w1[4] = 0 )
			CU_ASSERT( w2[4] = 0 )
		end scope

		'' User-allocated wstrings (assumed to be large enough)

		scope
			dim as wstring * 1 w
			dim as wstring ptr pw = callocate( sizeof(wstring) * 1 )

			swap w, *pw
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			swap *pw, w
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			deallocate( pw )
		end scope

		scope
			dim as wstring * 10 w
			dim as wstring ptr pw = callocate( sizeof(wstring) * 10 )

			w = wstr("foobarbaz")
			*pw = wstr("")
			swap w, *pw
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 9 )
			CU_ASSERT( w = wstr("" ))
			CU_ASSERT( *pw = wstr("foobarbaz") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[9] = 0 )

			w = wstr("foobarbaz")
			*pw = wstr("")
			swap *pw, w
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 9 )
			CU_ASSERT( w = wstr("") )
			CU_ASSERT( *pw = wstr("foobarbaz") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[9] = 0 )

			w = wstr("")
			*pw = wstr("foobarbaz")
			swap w, *pw
			CU_ASSERT( len(w) = 9 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("foobarbaz") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[9] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			w = wstr("")
			*pw = wstr("foobarbaz")
			swap *pw, w
			CU_ASSERT( len(w) = 9 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("foobarbaz") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[9] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			deallocate( pw )
		end scope

		scope
			dim as wstring * 1 w
			dim as wstring ptr pw = callocate( sizeof(wstring) * 10 )

			*pw = wstr("foobarbaz")
			swap w, *pw
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			*pw = wstr("foobarbaz")
			swap *pw, w
			CU_ASSERT( len(w) = 0 )
			CU_ASSERT( len(*pw) = 0 )
			CU_ASSERT( w = wstr("") )
			CU_ASSERT( *pw = wstr("") )
			CU_ASSERT( w[0] = 0 )
			CU_ASSERT( (*pw)[0] = 0 )

			deallocate( pw )
		end scope

		scope
			dim as wstring ptr a = callocate( sizeof(wstring) * 10 )
			dim as wstring ptr b = callocate( sizeof(wstring) * 10 )

			*a = wstr("foobarbaz")
			*b = wstr("test")
			swap *a, *b
			CU_ASSERT( len(*a) = 4 )
			CU_ASSERT( len(*b) = 9 )
			CU_ASSERT( *a = wstr("test") )
			CU_ASSERT( *b = wstr("foobarbaz") )
			CU_ASSERT( (*a)[4] = 0 )
			CU_ASSERT( (*b)[9] = 0 )

			swap *a, *b
			CU_ASSERT( len(*a) = 9 )
			CU_ASSERT( len(*b) = 4 )
			CU_ASSERT( *a = wstr("foobarbaz") )
			CU_ASSERT( *b = wstr("test") )
			CU_ASSERT( (*a)[9] = 0 )
			CU_ASSERT( (*b)[4] = 0 )

			deallocate( b )
			deallocate( a )
		end scope
	END_TEST

	'' SWAP should clear fixstr remainders
	TEST( ClearRemainders )
		scope
			dim as string s
			dim as string * 5 f

			s = "12"
			f = "abcd"

			swap s, f

			CU_ASSERT( s = "abcd" )
			CU_ASSERT( f = "12" )
			CU_ASSERT( f[2] = 0 ) '' null terminator
			CU_ASSERT( f[3] = 0 ) '' remainder
			CU_ASSERT( f[4] = 0 )
		end scope

		scope
			dim as string * 5 a
			dim as string * 10 b

			a = "abcde"
			b = "12"

			swap a, b

			CU_ASSERT( a = "12" )
			CU_ASSERT( a[2] = 0 )
			CU_ASSERT( a[3] = 0 )
			CU_ASSERT( a[4] = 0 )

			CU_ASSERT( b = "abcde" )
			CU_ASSERT( b[5] = 0 )
			CU_ASSERT( b[6] = 0 )
			CU_ASSERT( b[7] = 0 )
			CU_ASSERT( b[8] = 0 )
			CU_ASSERT( b[9] = 0 )

			a = "abcde"
			b = "12"

			swap b, a

			CU_ASSERT( a = "12" )
			CU_ASSERT( a[2] = 0 )
			CU_ASSERT( a[3] = 0 )
			CU_ASSERT( a[4] = 0 )

			CU_ASSERT( b = "abcde" )
			CU_ASSERT( b[5] = 0 )
			CU_ASSERT( b[6] = 0 )
			CU_ASSERT( b[7] = 0 )
			CU_ASSERT( b[8] = 0 )
			CU_ASSERT( b[9] = 0 )
		end scope
	END_TEST

END_SUITE
