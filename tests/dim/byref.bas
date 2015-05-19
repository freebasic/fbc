#include "fbcu.bi"

namespace fbc_tests.dim_.byref_

namespace simpleVars
	'' Globals
	dim shared gi as integer = 123

	'' Normal syntax
	dim shared byref gr1 as integer = gi
	dim shared byref gr2 as integer = gi, byref gr3 as integer = gi
	var shared byref gr4 = gi, byref gr5 = gi

	'' Multdecl syntax
	dim shared byref as integer gr6 = gi, gr7 = gi

	function fByval( byval i as integer ) as integer
		function = i
	end function

	sub fByref( byref i as integer )
		i += 1
	end sub

	sub test cdecl( )
		'' Globals
		scope
			CU_ASSERT( gr1 = 123 ) : CU_ASSERT( @gr1 = @gi )
			CU_ASSERT( gr2 = 123 ) : CU_ASSERT( @gr2 = @gi )
			CU_ASSERT( gr3 = 123 ) : CU_ASSERT( @gr3 = @gi )
			CU_ASSERT( gr4 = 123 ) : CU_ASSERT( @gr4 = @gi )
			CU_ASSERT( gr5 = 123 ) : CU_ASSERT( @gr5 = @gi )
			CU_ASSERT( gr6 = 123 ) : CU_ASSERT( @gr6 = @gi )
			CU_ASSERT( gr7 = 123 ) : CU_ASSERT( @gr7 = @gi )
		end scope

		scope
			'' Normal syntax
			dim i as integer = 456
			dim byref r1 as integer = i, byref r2 as integer = i
			var byref r3 = i, byref r4 = i

			CU_ASSERT( r1 = 456 ) : CU_ASSERT( @r1 = @i )
			CU_ASSERT( r2 = 456 ) : CU_ASSERT( @r2 = @i )
			CU_ASSERT( r3 = 456 ) : CU_ASSERT( @r3 = @i )
			CU_ASSERT( r4 = 456 ) : CU_ASSERT( @r4 = @i )
		end scope

		scope
			'' Multdecl syntax
			var i = 123
			dim byref as integer r1 = i, r2 = i, r3 = i
			CU_ASSERT( r1 = 123 ) : CU_ASSERT( @r1 = @i )
			CU_ASSERT( r2 = 123 ) : CU_ASSERT( @r2 = @i )
			CU_ASSERT( r3 = 123 ) : CU_ASSERT( @r3 = @i )
		end scope

		scope
			'' Initialized from other reference
			dim i as integer = 111
			dim byref ri1 as integer = i
			dim byref ri2 as integer = ri1
			CU_ASSERT( ri1 = 111 ) : CU_ASSERT( @ri1 = @i )
			CU_ASSERT( ri2 = 111 ) : CU_ASSERT( @ri2 = @i )
		end scope

		scope
			'' More complex expression
			var p = new integer[3]
			CU_ASSERT( p[0] = 0 )
			CU_ASSERT( p[1] = 0 )
			CU_ASSERT( p[2] = 0 )

			dim byref r as integer = p[1]

			p[1] = 111
			CU_ASSERT( r = 111 )
			CU_ASSERT( p[0] = 0 )
			CU_ASSERT( p[1] = 111 )
			CU_ASSERT( p[2] = 0 )

			delete p
		end scope

		scope
			'' Reference as lhs of assignment
			var i = 111
			var byref ri = i
			CU_ASSERT( ri = 111 )

			ri = 222
			CU_ASSERT( i = 222 )

			'' Self-ops
			ri += 2
			CU_ASSERT( i = 224 )
		end scope

		scope
			'' Passing as procedure arguments
			var i = 111
			var byref ri = i
			CU_ASSERT( fByval( ri ) = 111 )
			fByref( ri )
			CU_ASSERT( i = 112 )
		end scope
	end sub
end namespace

namespace allDtypes
	type PodUdt
		i as integer
	end type

	type ClassUdt
		i as integer
		declare constructor( )
		declare destructor( )
	end type

	constructor ClassUdt( )
		this.i = 15
	end constructor

	destructor ClassUdt( )
	end destructor

	dim shared b as byte = 1
	dim shared ub as ubyte = 2
	dim shared sh as short = 3
	dim shared ush as ushort = 4
	dim shared l as long = 5
	dim shared ul as ulong = 6
	dim shared ll as longint = 7
	dim shared ull as ulongint = 8
	dim shared i as integer = 9
	dim shared ui as uinteger = 10
	dim shared s as string '' = "11"
	dim shared z as zstring * 10 = "12"
	dim shared w as wstring * 10 = "13"
	dim shared xpod as PodUdt = (14)
	dim shared xclass as ClassUdt
	dim shared pany as any ptr = cptr(any ptr, 16)

	dim shared byref rb as byte = b
	dim shared byref rub as ubyte = ub
	dim shared byref rsh as short = sh
	dim shared byref rush as ushort = ush
	dim shared byref rl as long = l
	dim shared byref rul as ulong = ul
	dim shared byref rll as longint = ll
	dim shared byref rull as ulongint = ull
	dim shared byref ri as integer = i
	dim shared byref rui as uinteger = ui
	dim shared byref rs as string = s
	dim shared byref rz as zstring = z
	dim shared byref rw as wstring = w
	dim shared byref rxpod as PodUdt = xpod
	dim shared byref rxclass as ClassUdt = xclass
	dim shared byref rpany as any ptr = pany

	sub test cdecl( )
		s = "11"

		CU_ASSERT( rb   = 1 )
		CU_ASSERT( rub  = 2 )
		CU_ASSERT( rsh  = 3 )
		CU_ASSERT( rush = 4 )
		CU_ASSERT( rl   = 5 )
		CU_ASSERT( rul  = 6 )
		CU_ASSERT( rll  = 7 )
		CU_ASSERT( rull = 8 )
		CU_ASSERT( ri   = 9 )
		CU_ASSERT( rui  = 10 )
		CU_ASSERT( rs   = "11" )
		CU_ASSERT( rz   = "12" )
		CU_ASSERT( rw   = "13" )
		CU_ASSERT( rxpod.i = 14 )
		CU_ASSERT( rxclass.i = 15 )
		CU_ASSERT( rpany = cptr( any ptr, 16 ) )

		rb   = 101
		rub  = 102
		rsh  = 103
		rush = 104
		rl   = 105
		rul  = 106
		rll  = 107
		rull = 108
		ri   = 109
		rui  = 110
		rs   = "111"
		rz   = "112"
		rw   = "113"
		rxpod.i = 114
		rxclass.i = 115
		rpany = cptr( any ptr, 116 )

		CU_ASSERT( rb   = 101 )
		CU_ASSERT( rub  = 102 )
		CU_ASSERT( rsh  = 103 )
		CU_ASSERT( rush = 104 )
		CU_ASSERT( rl   = 105 )
		CU_ASSERT( rul  = 106 )
		CU_ASSERT( rll  = 107 )
		CU_ASSERT( rull = 108 )
		CU_ASSERT( ri   = 109 )
		CU_ASSERT( rui  = 110 )
		CU_ASSERT( rs   = "111" )
		CU_ASSERT( rz   = "112" )
		CU_ASSERT( rw   = "113" )
		CU_ASSERT( rxpod.i = 114 )
		CU_ASSERT( rxclass.i = 115 )
		CU_ASSERT( rpany = cptr( any ptr, 116 ) )

		scope
			dim byref rb as byte = b
			dim byref rub as ubyte = ub
			dim byref rsh as short = sh
			dim byref rush as ushort = ush
			dim byref rl as long = l
			dim byref rul as ulong = ul
			dim byref rll as longint = ll
			dim byref rull as ulongint = ull
			dim byref ri as integer = i
			dim byref rui as uinteger = ui
			dim byref rs as string = s
			dim byref rz as zstring = z
			dim byref rw as wstring = w
			dim byref rxpod as PodUdt = xpod
			dim byref rxclass as ClassUdt = xclass
			dim byref rpany as any ptr = pany

			CU_ASSERT( rb   = 101 )
			CU_ASSERT( rub  = 102 )
			CU_ASSERT( rsh  = 103 )
			CU_ASSERT( rush = 104 )
			CU_ASSERT( rl   = 105 )
			CU_ASSERT( rul  = 106 )
			CU_ASSERT( rll  = 107 )
			CU_ASSERT( rull = 108 )
			CU_ASSERT( ri   = 109 )
			CU_ASSERT( rui  = 110 )
			CU_ASSERT( rs   = "111" )
			CU_ASSERT( rz   = "112" )
			CU_ASSERT( rw   = "113" )
			CU_ASSERT( rxpod.i = 114 )
			CU_ASSERT( rxclass.i = 115 )
			CU_ASSERT( rpany = cptr( any ptr, 116 ) )

			rb   = 1
			rub  = 2
			rsh  = 3
			rush = 4
			rl   = 5
			rul  = 6
			rll  = 7
			rull = 8
			ri   = 9
			rui  = 10
			rs   = "11"
			rz   = "12"
			rw   = "13"
			rxpod.i = 14
			rxclass.i = 15
			rpany = cptr( any ptr, 16 )

			CU_ASSERT( rb   = 1 )
			CU_ASSERT( rub  = 2 )
			CU_ASSERT( rsh  = 3 )
			CU_ASSERT( rush = 4 )
			CU_ASSERT( rl   = 5 )
			CU_ASSERT( rul  = 6 )
			CU_ASSERT( rll  = 7 )
			CU_ASSERT( rull = 8 )
			CU_ASSERT( ri   = 9 )
			CU_ASSERT( rui  = 10 )
			CU_ASSERT( rs   = "11" )
			CU_ASSERT( rz   = "12" )
			CU_ASSERT( rw   = "13" )
			CU_ASSERT( rxpod.i = 14 )
			CU_ASSERT( rxclass.i = 15 )
			CU_ASSERT( rpany = cptr( any ptr, 16 ) )
		end scope

		scope
			static byref rb as byte = b
			static byref rub as ubyte = ub
			static byref rsh as short = sh
			static byref rush as ushort = ush
			static byref rl as long = l
			static byref rul as ulong = ul
			static byref rll as longint = ll
			static byref rull as ulongint = ull
			static byref ri as integer = i
			static byref rui as uinteger = ui
			static byref rs as string = s
			static byref rz as zstring = z
			static byref rw as wstring = w
			static byref rxpod as PodUdt = xpod
			static byref rxclass as ClassUdt = xclass
			static byref rpany as any ptr = pany

			CU_ASSERT( rb   = 1 )
			CU_ASSERT( rub  = 2 )
			CU_ASSERT( rsh  = 3 )
			CU_ASSERT( rush = 4 )
			CU_ASSERT( rl   = 5 )
			CU_ASSERT( rul  = 6 )
			CU_ASSERT( rll  = 7 )
			CU_ASSERT( rull = 8 )
			CU_ASSERT( ri   = 9 )
			CU_ASSERT( rui  = 10 )
			CU_ASSERT( rs   = "11" )
			CU_ASSERT( rz   = "12" )
			CU_ASSERT( rw   = "13" )
			CU_ASSERT( rxpod.i = 14 )
			CU_ASSERT( rxclass.i = 15 )
			CU_ASSERT( rpany = cptr( any ptr, 16 ) )

			rb   = 101
			rub  = 102
			rsh  = 103
			rush = 104
			rl   = 105
			rul  = 106
			rll  = 107
			rull = 108
			ri   = 109
			rui  = 110
			rs   = "111"
			rz   = "112"
			rw   = "113"
			rxpod.i = 114
			rxclass.i = 115
			rpany = cptr( any ptr, 116 )

			CU_ASSERT( rb   = 101 )
			CU_ASSERT( rub  = 102 )
			CU_ASSERT( rsh  = 103 )
			CU_ASSERT( rush = 104 )
			CU_ASSERT( rl   = 105 )
			CU_ASSERT( rul  = 106 )
			CU_ASSERT( rll  = 107 )
			CU_ASSERT( rull = 108 )
			CU_ASSERT( ri   = 109 )
			CU_ASSERT( rui  = 110 )
			CU_ASSERT( rs   = "111" )
			CU_ASSERT( rz   = "112" )
			CU_ASSERT( rw   = "113" )
			CU_ASSERT( rxpod.i = 114 )
			CU_ASSERT( rxclass.i = 115 )
			CU_ASSERT( rpany = cptr( any ptr, 116 ) )
		end scope
	end sub
end namespace

namespace callByrefFunctionPtrThroughByref
	dim shared i as integer = 123

	function f( ) byref as integer
		function = i
	end function

	sub test cdecl( )
		CU_ASSERT( f( ) = 123 )
		CU_ASSERT( @(f( )) = @i )

		dim p1 as function( ) byref as integer = @f
		CU_ASSERT( p1( ) = 123 )
		CU_ASSERT( @(p1( )) = @i )

		dim byref p2 as function( ) byref as integer = p1
		CU_ASSERT( p2( ) = 123 )
		CU_ASSERT( @(p2( )) = @i )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/byref" )
	fbcu.add_test( "simpleVars", @simpleVars.test )
	fbcu.add_test( "allDtypes", @allDtypes.test )
	fbcu.add_test( "callByrefFunctionPtrThroughByref", @callByrefFunctionPtrThroughByref.test )
end sub

end namespace
