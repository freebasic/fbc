#include "fbcunit.bi"
#include "fbrtti.bi"

''
'' Byval copies mustn't overwrite the vptr, especially when up-casting. The lhs
'' doesn't change its type or size, thus the vptr must stay the same.
''
'' Fields other than the vptr should be copied though. However, when assigning a
'' derived class to a base class, only the base part of the derived class object
'' is copied. ("a.k.a. C++ object slicing")
''
'' Even if there are no fields and the objects contains only the vptr, byval
'' copies mustn't overwrite the vptr. In this case an implicit Let isn't
'' strictly necessary, but if it isn't used, then we must take care not to do
'' the usual byte-by-byte copy that would overwrite the vptr.
''

SUITE( fbc_tests.virtual_.byval_copy )

	TEST_GROUP( noFieldsRetainsVptr )
		type A extends object
		end type

		type B extends A
		end type

		sub checkByvalParamO( byval xo as object, byval vptro as any ptr )
			CU_ASSERT( getvptr( @xo ) = vptro )
		end sub

		sub checkByvalParamA( byval xa as A, byval vptra as any ptr )
			CU_ASSERT( getvptr( @xa ) = vptra )
		end sub

		TEST( default )
			dim as object xo
			dim as A xa, xa2
			dim as B xb, xb2

			dim as any ptr vptro = getvptr( @xo )
			dim as any ptr vptra = getvptr( @xa )
			dim as any ptr vptrb = getvptr( @xb )

			'' Assignment
			xo = xa : CU_ASSERT( getvptr( @xo ) = vptro )
			xo = xb : CU_ASSERT( getvptr( @xo ) = vptro )
			xa = xb : CU_ASSERT( getvptr( @xa ) = vptra )

			'' Typeini assignment
			xo = type<A>( ) : CU_ASSERT( getvptr( @xo ) = vptro )
			xo = type<B>( ) : CU_ASSERT( getvptr( @xo ) = vptro )
			xa = type<B>( ) : CU_ASSERT( getvptr( @xa ) = vptra )

			'' Byval param
			checkByvalParamO( xa, vptro )
			checkByvalParamO( xb, vptro )
			checkByvalParamA( xb, vptra )

			'' Typeini arg -> byval param
			checkByvalParamO( type<A>( ), vptro )
			checkByvalParamO( type<B>( ), vptro )
			checkByvalParamA( type<B>( ), vptra )

			'' Assignment with lvalue cast
			cast( object, xa ) = xo  : CU_ASSERT( getvptr( @xa ) = vptra )
			cast( object, xa ) = xa2 : CU_ASSERT( getvptr( @xa ) = vptra )
			cast( object, xb ) = xo  : CU_ASSERT( getvptr( @xb ) = vptrb )
			cast( object, xb ) = xa  : CU_ASSERT( getvptr( @xb ) = vptrb )
			cast( object, xb ) = xb2 : CU_ASSERT( getvptr( @xb ) = vptrb )
			cast( A     , xb ) = xa  : CU_ASSERT( getvptr( @xb ) = vptrb )
			cast( A     , xb ) = xb2 : CU_ASSERT( getvptr( @xb ) = vptrb )

			'' DIM copy construction
			scope
				dim as object newxo1 = xa : CU_ASSERT( getvptr( @newxo1 ) = vptro )
				dim as object newxo2 = xb : CU_ASSERT( getvptr( @newxo2 ) = vptro )
				dim as A      newxa1 = xb : CU_ASSERT( getvptr( @newxa1 ) = vptra )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( implicitLetWithFieldsRetainsVptr )
		type A extends object
			a as string
			declare virtual function f( ) as string
		end type

		function A.f( ) as string
			function = "A's f"
		end function

		type B extends A
			b as string
			declare function f( ) as string override
		end type

		function B.f( ) as string
			function = "B's f"
		end function

		sub checkByvalParamO( byval xo as object, byval vptro as any ptr )
			CU_ASSERT( getvptr( @xo ) = vptro )
		end sub

		sub checkByvalParamA( byval xa as A, byval vptra as any ptr )
			CU_ASSERT( getvptr( @xa ) = vptra )
		end sub

		TEST( defualt )
			dim as object xo
			dim as A xa, xa2
			dim as B xb, xb2

			'' Testing virtual calls through a pointer so they won't be
			'' devirtualized (we want to test that the vptr is correct, thus
			'' we need to actually use it)
			var po = @xo
			var pa = @xa
			var pb = @xb
			CU_ASSERT( pa->f( ) = "A's f" )
			CU_ASSERT( pb->f( ) = "B's f" )
			CU_ASSERT( cptr( A ptr, pb )->f( ) = "B's f" )

			dim as any ptr vptro = getvptr( @xo )
			dim as any ptr vptra = getvptr( @xa )
			dim as any ptr vptrb = getvptr( @xb )

			'' Assignment
			xo = xa : CU_ASSERT( getvptr( @xo ) = vptro )
			xo = xb : CU_ASSERT( getvptr( @xo ) = vptro )
			xa = xb : CU_ASSERT( getvptr( @xa ) = vptra ) : CU_ASSERT( pa->f( ) = "A's f" )

			'' Typeini assignment
			xo = type<A>( ) : CU_ASSERT( getvptr( @xo ) = vptro )
			xo = type<B>( ) : CU_ASSERT( getvptr( @xo ) = vptro )
			xa = type<B>( ) : CU_ASSERT( getvptr( @xa ) = vptra ) : CU_ASSERT( pa->f( ) = "A's f" )

			'' Byval param
			checkByvalParamO( xa, vptro )
			checkByvalParamO( xb, vptro )
			checkByvalParamA( xb, vptra )

			'' Typeini arg -> byval param
			checkByvalParamO( type<A>( ), vptro )
			checkByvalParamO( type<B>( ), vptro )
			checkByvalParamA( type<B>( ), vptra )

			'' Assignment with lvalue cast
			cast( object, xa ) = xo  : CU_ASSERT( getvptr( @xa ) = vptra ) : CU_ASSERT( pa->f( ) = "A's f" )
			cast( object, xa ) = xa2 : CU_ASSERT( getvptr( @xa ) = vptra ) : CU_ASSERT( pa->f( ) = "A's f" )
			cast( object, xb ) = xo  : CU_ASSERT( getvptr( @xb ) = vptrb ) : CU_ASSERT( pb->f( ) = "B's f" )
			cast( object, xb ) = xa  : CU_ASSERT( getvptr( @xb ) = vptrb ) : CU_ASSERT( pb->f( ) = "B's f" )
			cast( object, xb ) = xb2 : CU_ASSERT( getvptr( @xb ) = vptrb ) : CU_ASSERT( pb->f( ) = "B's f" )
			cast( A     , xb ) = xa  : CU_ASSERT( getvptr( @xb ) = vptrb ) : CU_ASSERT( pb->f( ) = "B's f" )
			cast( A     , xb ) = xb2 : CU_ASSERT( getvptr( @xb ) = vptrb ) : CU_ASSERT( pb->f( ) = "B's f" )

			'' DIM copy construction
			scope
				dim as object newxo1 = xa : CU_ASSERT( getvptr( @newxo1 ) = vptro )
				dim as object newxo2 = xb : CU_ASSERT( getvptr( @newxo2 ) = vptro )
				dim as A      newxa1 = xb : CU_ASSERT( getvptr( @newxa1 ) = vptra )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( implicitLetCopiesFields )
		type A extends object
			sa as string
			ia as integer
		end type

		type B extends A
			sb as string
			ib as integer
		end type

		type C extends B
			sc as string
			ic as integer
		end type

		sub checkByvalParamA _
			( _
				byval xa as A, _
				byval vptra as any ptr, _
				byref sa as string, _
				byval ia as integer _
			)

			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( xa.sa = sa )
			CU_ASSERT( xa.ia = ia )

		end sub

		sub checkByvalParamB _
			( _
				byval xb as B, _
				byval vptrb as any ptr, _
				byref sa as string, _
				byval ia as integer, _
				byref sb as string, _
				byval ib as integer _
			)

			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = sa )
			CU_ASSERT( xb.ia = ia )
			CU_ASSERT( xb.sb = sb )
			CU_ASSERT( xb.ib = ib )

		end sub

		TEST( default )
			dim as A xa, xa2
			dim as B xb, xb2
			dim as C xc, xc2

			xa.sa = "AA"
			xa.ia = &hAA

			xa2.sa = "A2A"
			xa2.ia = &hA2A

			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			xb2.sa = "B2A"
			xb2.ia = &hB2A
			xb2.sb = "B2B"
			xb2.ib = &hB2B

			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			xc2.sa = "C2A"
			xc2.ia = &hC2A
			xc2.sb = "C2B"
			xc2.ib = &hC2B
			xc2.sc = "C2C"
			xc2.ic = &hC2C

			dim as any ptr vptra = getvptr( @xa )
			dim as any ptr vptrb = getvptr( @xb )
			dim as any ptr vptrc = getvptr( @xc )

			'' Assignment
			xa = xb
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( xa.sa = "BA" )
			CU_ASSERT( xa.ia = &hBA )
			xa.sa = "AA"
			xa.ia = &hAA

			xa = xc
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( xa.sa = "CA" )
			CU_ASSERT( xa.ia = &hCA )
			xa.sa = "AA"
			xa.ia = &hAA

			xb = xc
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = "CA" )
			CU_ASSERT( xb.ia = &hCA )
			CU_ASSERT( xb.sb = "CB" )
			CU_ASSERT( xb.ib = &hCB )
			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			'' Typeini assignment
			xa = type<B>( )
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( xa.sa = "" )
			CU_ASSERT( xa.ia = 0 )
			xa.sa = "AA"
			xa.ia = &hAA

			xa = type<C>( )
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( xa.sa = "" )
			CU_ASSERT( xa.ia = 0 )
			xa.sa = "AA"
			xa.ia = &hAA

			xb = type<C>( )
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = "" )
			CU_ASSERT( xb.ia = 0 )
			CU_ASSERT( xb.sb = "" )
			CU_ASSERT( xb.ib = 0 )
			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			'' Byval param
			checkByvalParamA( xb, vptra, "BA", &hBA )
			checkByvalParamA( xc, vptra, "CA", &hCA )
			checkByvalParamB( xc, vptrb, "CA", &hCA, "CB", &hCB )

			'' Typeini arg -> byval param
			checkByvalParamA( type<B>( ), vptra, "", 0 )
			checkByvalParamA( type<C>( ), vptra, "", 0 )
			checkByvalParamB( type<C>( ), vptrb, "", 0, "", 0 )

			'' Assignment with lvalue cast
			cast( A, xb ) = xa
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = "AA" )
			CU_ASSERT( xb.ia = &hAA )
			CU_ASSERT( xb.sb = "BB" )
			CU_ASSERT( xb.ib = &hBB )
			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			cast( A, xb ) = xb2
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = "B2A" )
			CU_ASSERT( xb.ia = &hB2A )
			CU_ASSERT( xb.sb = "BB" )
			CU_ASSERT( xb.ib = &hBB )
			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			cast( A, xb ) = xc
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( xb.sa = "CA" )
			CU_ASSERT( xb.ia = &hCA )
			CU_ASSERT( xb.sb = "BB" )
			CU_ASSERT( xb.ib = &hBB )
			xb.sa = "BA"
			xb.ia = &hBA
			xb.sb = "BB"
			xb.ib = &hBB

			cast( A, xc ) = xa
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( xc.sa = "AA" )
			CU_ASSERT( xc.ia = &hAA )
			CU_ASSERT( xc.sb = "CB" )
			CU_ASSERT( xc.ib = &hCB )
			CU_ASSERT( xc.sc = "CC" )
			CU_ASSERT( xc.ic = &hCC )
			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			cast( A, xc ) = xb
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( xc.sa = "BA" )
			CU_ASSERT( xc.ia = &hBA )
			CU_ASSERT( xc.sb = "CB" )
			CU_ASSERT( xc.ib = &hCB )
			CU_ASSERT( xc.sc = "CC" )
			CU_ASSERT( xc.ic = &hCC )
			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			cast( A, xc ) = xc2
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( xc.sa = "C2A" )
			CU_ASSERT( xc.ia = &hC2A )
			CU_ASSERT( xc.sb = "CB" )
			CU_ASSERT( xc.ib = &hCB )
			CU_ASSERT( xc.sc = "CC" )
			CU_ASSERT( xc.ic = &hCC )
			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			cast( B, xc ) = xb
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( xc.sa = "BA" )
			CU_ASSERT( xc.ia = &hBA )
			CU_ASSERT( xc.sb = "BB" )
			CU_ASSERT( xc.ib = &hBB )
			CU_ASSERT( xc.sc = "CC" )
			CU_ASSERT( xc.ic = &hCC )
			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			cast( B, xc ) = xc2
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( xc.sa = "C2A" )
			CU_ASSERT( xc.ia = &hC2A )
			CU_ASSERT( xc.sb = "C2B" )
			CU_ASSERT( xc.ib = &hC2B )
			CU_ASSERT( xc.sc = "CC" )
			CU_ASSERT( xc.ic = &hCC )
			xc.sa = "CA"
			xc.ia = &hCA
			xc.sb = "CB"
			xc.ib = &hCB
			xc.sc = "CC"
			xc.ic = &hCC

			'' DIM copy construction
			scope
				dim as A newxa1 = xb
				CU_ASSERT( getvptr( @newxa1 ) = vptra )
				CU_ASSERT( newxa1.sa = "BA" )
				CU_ASSERT( newxa1.ia = &hBA )

				dim as A newxa2 = xc
				CU_ASSERT( getvptr( @newxa2 ) = vptra )
				CU_ASSERT( newxa2.sa = "CA" )
				CU_ASSERT( newxa2.ia = &hCA )

				dim as B newxb1 = xc
				CU_ASSERT( getvptr( @newxb1 ) = vptrb )
				CU_ASSERT( newxb1.sa = "CA" )
				CU_ASSERT( newxb1.ia = &hCA )
				CU_ASSERT( newxb1.sb = "CB" )
				CU_ASSERT( newxb1.ib = &hCB )
			end scope
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( explicitLetRetainsVptr )
		dim shared as integer alets, blets, clets

		type A extends object
			sa as string
			declare operator let( byref rhs as A )
		end type

		operator A.let( byref rhs as A )
			alets += 1
		end operator

		type B extends A
			sb as string
			declare operator let( byref rhs as B )
		end type

		operator B.let( byref rhs as B )
			blets += 1
			cast( A, this ) = cast( A, rhs )
		end operator

		type C extends B
			sc as string
			declare operator let( byref rhs as C )
		end type

		operator C.let( byref rhs as C )
			clets += 1
			cast( B, this ) = cast( B, rhs )
		end operator

		TEST( default )
			dim xo as object
			dim xa as A
			dim xb as B
			dim xc as C

			dim as any ptr vptro = getvptr( @xo )
			dim as any ptr vptra = getvptr( @xa )
			dim as any ptr vptrb = getvptr( @xb )
			dim as any ptr vptrc = getvptr( @xc )

			CU_ASSERT( alets = 0 )
			CU_ASSERT( blets = 0 )
			CU_ASSERT( clets = 0 )

			alets = 0
			blets = 0
			clets = 0
			xa = xb
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( alets = 1 )
			CU_ASSERT( blets = 0 )
			CU_ASSERT( clets = 0 )

			alets = 0
			blets = 0
			clets = 0
			xa = xc
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( alets = 1 )
			CU_ASSERT( blets = 0 )
			CU_ASSERT( clets = 0 )

			alets = 0
			blets = 0
			clets = 0
			xb = xc
			CU_ASSERT( getvptr( @xa ) = vptra )
			CU_ASSERT( getvptr( @xb ) = vptrb )
			CU_ASSERT( getvptr( @xc ) = vptrc )
			CU_ASSERT( alets = 1 )
			CU_ASSERT( blets = 1 )
			CU_ASSERT( clets = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( noOpObjectCopySideFx )
		'' Assigning OBJECTs is a no-op since OBJECT only contains the vptr and
		'' that's excluded from the copy. This means the compiler can delete the
		'' lhs/rhs expressions - unless they contain side-effects.

		dim shared as integer f0calls

		function f0( ) as integer
			f0calls += 1
			function = 0
		end function

		TEST( default )
			dim array(0 to 0) as object
			dim x as object

			CU_ASSERT( f0calls = 0 )
			array(f0( )) = x
			CU_ASSERT( f0calls = 1 )
			x = array(f0( ))
			CU_ASSERT( f0calls = 2 )
			array(f0( )) = array(f0( ))
			CU_ASSERT( f0calls = 4 )
		END_TEST
	END_TEST_GROUP

END_SUITE
