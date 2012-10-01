# include "fbcu.bi"

namespace fbc_tests.numbers.infnan

private sub testDouble cdecl( )
	''
	'' Double
	''

	#macro checkD( d, x )
		'' x86 assumption
		CU_ASSERT( *cptr( ulongint ptr, @d ) = x )
	#endmacro

	#macro checkConstD( N, x )
		scope
			dim d as double
			d = N
			checkD( d, x )
		end scope

		scope
			dim d as double = N
			checkD( d, x )
		end scope

		scope
			static d as double
			d = N
			checkD( d, x )
		end scope

		scope
			static d as double = N
			checkD( d, x )
		end scope
	#endmacro

	const POSINFD = &h7FF0000000000000ull
	const NEGINFD = &hFFF0000000000000ull
	const POSNAND = &h7FF8000000000000ull
	const NEGNAND = &hFFF8000000000000ull

	checkConstD(  ( 0.0 /  0.0), NEGNAND )
	checkConstD(  ( 0.0 / -0.0), NEGNAND )
	checkConstD(  (-0.0 /  0.0), NEGNAND )
	checkConstD(  (-0.0 / -0.0), NEGNAND )
	checkConstD(  ( 1.0 /  0.0), POSINFD )
	checkConstD(  ( 1.0 / -0.0), NEGINFD )
	checkConstD(  (-1.0 /  0.0), NEGINFD )
	checkConstD(  (-1.0 / -0.0), POSINFD )

	checkConstD( -( 0.0 /  0.0), POSNAND )
	checkConstD( -( 0.0 / -0.0), POSNAND )
	checkConstD( -(-0.0 /  0.0), POSNAND )
	checkConstD( -(-0.0 / -0.0), POSNAND )
	checkConstD( -( 1.0 /  0.0), NEGINFD )
	checkConstD( -( 1.0 / -0.0), POSINFD )
	checkConstD( -(-1.0 /  0.0), POSINFD )
	checkConstD( -(-1.0 / -0.0), NEGINFD )

	#macro checkVarDivD( NA, NB, x )
		scope
			dim as double a, b, c
			a = NA
			b = NB
			c = a / b
			checkD( c, x )
		end scope
	#endmacro

	checkVarDivD(  0.0,  0.0, NEGNAND )
	checkVarDivD(  0.0, -0.0, NEGNAND )
	checkVarDivD( -0.0,  0.0, NEGNAND )
	checkVarDivD( -0.0, -0.0, NEGNAND )
	checkVarDivD(  1.0,  0.0, POSINFD )
	checkVarDivD(  1.0, -0.0, NEGINFD )
	checkVarDivD( -1.0,  0.0, NEGINFD )
	checkVarDivD( -1.0, -0.0, POSINFD )

	#macro checkVarDivNegD( NA, NB, x )
		scope
			dim as double a, b, c
			a = NA
			b = NB
			c = -(a / b)
			checkD( c, x )
		end scope
	#endmacro

	checkVarDivNegD(  0.0,  0.0, POSNAND )
	checkVarDivNegD(  0.0, -0.0, POSNAND )
	checkVarDivNegD( -0.0,  0.0, POSNAND )
	checkVarDivNegD( -0.0, -0.0, POSNAND )
	checkVarDivNegD(  1.0,  0.0, NEGINFD )
	checkVarDivNegD(  1.0, -0.0, POSINFD )
	checkVarDivNegD( -1.0,  0.0, POSINFD )
	checkVarDivNegD( -1.0, -0.0, NEGINFD )
end sub

private sub testSingle cdecl( )
	''
	'' Single
	''

	#macro checkF( f, x )
		'' x86 assumption
		CU_ASSERT( *cptr( uinteger ptr, @f ) = x )
	#endmacro

	#macro checkConstF( N, x )
		scope
			dim f as single
			f = N
			checkF( f, x )
		end scope

		scope
			dim f as single = N
			checkF( f, x )
		end scope

		scope
			static f as single
			f = N
			checkF( f, x )
		end scope

		scope
			static f as single = N
			checkF( f, x )
		end scope
	#endmacro

	const POSINFF = &h7F800000u
	const NEGINFF = &hFF800000u
	const POSNANF = &h7FC00000u
	const NEGNANF = &hFFC00000u

	checkConstF(  ( 0.0f /  0.0f), NEGNANF )
	checkConstF(  ( 0.0f / -0.0f), NEGNANF )
	checkConstF(  (-0.0f /  0.0f), NEGNANF )
	checkConstF(  (-0.0f / -0.0f), NEGNANF )
	checkConstF(  ( 1.0f /  0.0f), POSINFF )
	checkConstF(  ( 1.0f / -0.0f), NEGINFF )
	checkConstF(  (-1.0f /  0.0f), NEGINFF )
	checkConstF(  (-1.0f / -0.0f), POSINFF )

	checkConstF( -( 0.0f /  0.0f), POSNANF )
	checkConstF( -( 0.0f / -0.0f), POSNANF )
	checkConstF( -(-0.0f /  0.0f), POSNANF )
	checkConstF( -(-0.0f / -0.0f), POSNANF )
	checkConstF( -( 1.0f /  0.0f), NEGINFF )
	checkConstF( -( 1.0f / -0.0f), POSINFF )
	checkConstF( -(-1.0f /  0.0f), POSINFF )
	checkConstF( -(-1.0f / -0.0f), NEGINFF )

	#macro checkVarDivF( NA, NB, x )
		scope
			dim as single a, b, c
			a = NA
			b = NB
			c = a / b
			checkF( c, x )
		end scope
	#endmacro

	checkVarDivF(  0.0f,  0.0f, NEGNANF )
	checkVarDivF(  0.0f, -0.0f, NEGNANF )
	checkVarDivF( -0.0f,  0.0f, NEGNANF )
	checkVarDivF( -0.0f, -0.0f, NEGNANF )
	checkVarDivF(  1.0f,  0.0f, POSINFF )
	checkVarDivF(  1.0f, -0.0f, NEGINFF )
	checkVarDivF( -1.0f,  0.0f, NEGINFF )
	checkVarDivF( -1.0f, -0.0f, POSINFF )

	#macro checkVarDivNegF( NA, NB, x )
		scope
			dim as single a, b, c
			a = NA
			b = NB
			c = -(a / b)
			checkF( c, x )
		end scope
	#endmacro

	checkVarDivNegF(  0.0f,  0.0f, POSNANF )
	checkVarDivNegF(  0.0f, -0.0f, POSNANF )
	checkVarDivNegF( -0.0f,  0.0f, POSNANF )
	checkVarDivNegF( -0.0f, -0.0f, POSNANF )
	checkVarDivNegF(  1.0f,  0.0f, NEGINFF )
	checkVarDivNegF(  1.0f, -0.0f, POSINFF )
	checkVarDivNegF( -1.0f,  0.0f, POSINFF )
	checkVarDivNegF( -1.0f, -0.0f, NEGINFF )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.numbers.infnan" )
	fbcu.add_test( "double", @testDouble )
	fbcu.add_test( "single", @testSingle )
end sub

end namespace
