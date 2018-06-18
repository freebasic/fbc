#include "fbcunit.bi"
#include "byref-common.bi"

namespace externs

	'' namespace externs is in the global namespace;
	'' we want the test to be independent of the fbcunit framework
	'' See:
	''	- byref.bas
	''  - byref2.bas
	''  - byref-common.bi

	sub globalExterns_proc
		CU_ASSERT( @ri = @i )
		CU_ASSERT( @SomeUDT.ri = @SomeUDT.i )
		CU_ASSERT( i  = &hEE112233 )
		CU_ASSERT( ri = &hEE112233 )
		CU_ASSERT( SomeUDT.i  = &hEE445566 )
		CU_ASSERT( SomeUDT.ri = &hEE445566 )
	end sub

end namespace

SUITE( fbc_tests.dim_.byref_ )

	TEST_GROUP( simpleVars )
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

		TEST( default )
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
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( allDtypes )
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

		type Parent extends object
			declare abstract function f() as integer
		end type

		type Child extends Parent
			declare virtual function f() as integer
		end type

		function Child.f() as integer
			function = 123
		end function

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
		dim shared w as wstring * 10 = wstr( "13" )
		dim shared xpod as PodUdt = (14)
		dim shared xclass as ClassUdt
		dim shared pany as any ptr = cptr(any ptr, 16)
		dim shared xchild as Child

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
		dim shared byref as Parent rparent1 = xchild
		dim shared byref rparent2 as Parent = xchild

		TEST( default )
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
			CU_ASSERT( rw   = wstr( "13" ) )
			CU_ASSERT( rxpod.i = 14 )
			CU_ASSERT( rxclass.i = 15 )
			CU_ASSERT( rpany = cptr( any ptr, 16 ) )
			CU_ASSERT( rparent1.f() = 123 )
			CU_ASSERT( rparent2.f() = 123 )

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
				dim byref as Parent rparent1 = xchild
				dim byref rparent2 as Parent = xchild

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
				CU_ASSERT( rparent1.f() = 123 )
				CU_ASSERT( rparent2.f() = 123 )

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
				rw   = wstr( "13" )
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
				CU_ASSERT( rw   = wstr( "13" ) )
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
				static byref as Parent rparent1 = xchild
				static byref rparent2 as Parent = xchild

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
				CU_ASSERT( rw   = wstr( "13" ) )
				CU_ASSERT( rxpod.i = 14 )
				CU_ASSERT( rxclass.i = 15 )
				CU_ASSERT( rpany = cptr( any ptr, 16 ) )
				CU_ASSERT( rparent1.f() = 123 )
				CU_ASSERT( rparent2.f() = 123 )

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

			scope
				var byref rb = b
				var byref rub = ub
				var byref rsh = sh
				var byref rush = ush
				var byref rl = l
				var byref rul = ul
				var byref rll = ll
				var byref rull = ull
				var byref ri = i
				var byref rui = ui
				var byref rs = s
				var byref rz = z
				var byref rw = w
				var byref rxpod = xpod
				var byref rxclass = xclass
				var byref rpany = pany

				#assert( typeof( rb   ) = typeof( byte     ) )
				#assert( typeof( rub  ) = typeof( ubyte    ) )
				#assert( typeof( rsh  ) = typeof( short    ) )
				#assert( typeof( rush ) = typeof( ushort   ) )
				#assert( typeof( rl   ) = typeof( long     ) )
				#assert( typeof( rul  ) = typeof( ulong    ) )
				#assert( typeof( rll  ) = typeof( longint  ) )
				#assert( typeof( rull ) = typeof( ulongint ) )
				#assert( typeof( ri   ) = typeof( integer  ) )
				#assert( typeof( rui  ) = typeof( uinteger ) )
				#assert( typeof( rs   ) = typeof( string   ) )
				#assert( typeof( rz   ) = typeof( zstring  ) )
				#assert( typeof( rw   ) = typeof( wstring  ) )
				#assert( typeof( rxpod   ) = typeof( PodUdt   ) )
				#assert( typeof( rxclass ) = typeof( ClassUdt ) )
				#assert( typeof( rpany   ) = typeof( any ptr  ) )

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
				rw   = wstr( "13" )
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
				CU_ASSERT( rw   = wstr( "13" ) )
				CU_ASSERT( rxpod.i = 14 )
				CU_ASSERT( rxclass.i = 15 )
				CU_ASSERT( rpany = cptr( any ptr, 16 ) )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( callByrefFunctionPtrThroughByref )
		dim shared i as integer = 123

		function f( ) byref as integer
			function = i
		end function

		TEST( default )
			CU_ASSERT( f( ) = 123 )
			CU_ASSERT( @(f( )) = @i )

			dim p1 as function( ) byref as integer = @f
			CU_ASSERT( p1( ) = 123 )
			CU_ASSERT( @(p1( )) = @i )

			dim byref p2 as function( ) byref as integer = p1
			CU_ASSERT( p2( ) = 123 )
			CU_ASSERT( @(p2( )) = @i )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( noCtorsCalled )
		dim shared as integer ctors, dtors

		type ClassUdt
			dummy as integer
			declare constructor( )
			declare constructor( byref as const ClassUdt )
			declare operator let( byref as const ClassUdt )
			declare destructor( )
		end type

		constructor ClassUdt( )
			if ctors <> 0 then
				'' (libcunit doesn't allow using CU_ASSERT() in a global ctor/dtor)
				print __FUNCTION__ + "(" & __LINE__ & "): too many ctor calls"
				end 1
			end if
			ctors += 1
		end constructor

		constructor ClassUdt( byref rhs as const ClassUdt )
			CU_FAIL( )
		end constructor

		operator ClassUdt.let( byref rhs as const ClassUdt )
			CU_FAIL( )
		end operator

		destructor ClassUdt( )
			if dtors <> 0 then
				'' (libcunit doesn't allow using CU_ASSERT() in a global ctor/dtor)
				print __FUNCTION__ + "(" & __LINE__ & "): too many dtor calls"
				end 1
			end if
			dtors += 1
		end destructor

		dim shared globalstr as string
		dim shared byref globalstrref1 as string = globalstr
		var shared byref globalstrref2           = globalstr

		dim shared globaludt as ClassUdt
		dim shared byref globaludtref1 as ClassUdt = globaludt
		var shared byref globaludtref2             = globaludt

		TEST( default )
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )

			scope
				dim byref localstrref1 as string = globalstr
				var byref localstrref2 = globalstr

				dim byref localudtref1 as ClassUdt = globaludt
				var byref localudtref2 = globaludt

				static byref staticstrref1 as string = globalstr
				static var byref staticstrref2 = globalstr

				static byref staticudtref1 as ClassUdt = globaludt
				static var byref staticudtref2 = globaludt
			end scope

			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( privateDtor )
		type UDT
			private:
				dummy as integer
				declare destructor()
			public:
				declare sub free()
		end type

		destructor UDT()
		end destructor

		sub UDT.free()
			delete @this
		end sub

		TEST( default )
			dim as UDT ptr p = new UDT

			'' It should be allowed to create a reference to a UDT even if
			'' its destructor isn't publicly accessible
			dim byref as UDT r = *p

			p->free()
		END_TEST
	END_TEST_GROUP

	TEST( globalExterns )
		externs.globalExterns_proc
	END_TEST

	TEST_GROUP( globalConstantInitWithoutOffset )
		type UDT1
			dummy as integer
		end type

		type UDT2
			dummy as integer
			static byref r1 as UDT1
			static byref r2 as UDT1
		end type

		'' Initializer for global ref var using a constant that is not an offset
		dim byref UDT2.r1 as UDT1 = *cptr(UDT1 ptr, 0)
		dim byref UDT2.r2 as UDT1 = *cptr(UDT1 ptr, 123)

		TEST( default )
			CU_ASSERT( @UDT2.r1 = 0 )
			CU_ASSERT( @UDT2.r2 = 123 )
		END_TEST
	END_TEST_GROUP

END_SUITE
