#include "fbcunit.bi"

SUITE( fbc_tests.functions.return_byref )

	TEST_GROUP( returnGlobal )
		'' UDT that fits into registers
		type UDT1
			i as integer
		end type

		'' UDT that will always be returned on stack
		type UDT2
			a(0 to 63) as integer
		end type

		dim shared as byte b
		dim shared as integer i, j
		dim shared as string s
		dim shared as zstring * 32 z = "testing"
		dim shared as wstring * 32 w = wstr( "testing" )
		dim shared as UDT1 x1 = ( 12 )
		dim shared as UDT2 x2 = ( { 34 } )

		function f1( ) byref as byte
			b = 12
			function = b
		end function

		'' should work with DECLARE too
		declare function f2( ) byref as integer

		function f2( ) byref as integer
			i = 34
			function = i
		end function

		function f3( ) byref as string
			s = "56"
			function = s
		end function

		function f4( ) byref as integer
			j = 78
			function = j
			j = 90
		end function

		function f5( ) byref as zstring
			function = z
		end function

		function f6( ) byref as zstring
			function = "also good"
		end function

		function f7( ) byref as wstring
			function = w
		end function

		function f8( ) byref as wstring
			function = wstr( "also good" )
		end function

		function f9( ) byref as UDT1
			function = x1
		end function

		function f10( ) byref as UDT2
			function = x2
		end function

		function f11( ) byref as integer
			function = x1.i
		end function

		function f12( ) byref as integer
			function = x2.a(0)
		end function

		'' returning globals
		TEST( default )
			CU_ASSERT( b = 0 )
			CU_ASSERT( f1( ) = 12 )
			CU_ASSERT( f1( ) = b )
			CU_ASSERT( b = 12 )

			CU_ASSERT( i = 0 )
			CU_ASSERT( f2( ) = 34 )
			CU_ASSERT( f2( ) = i )
			CU_ASSERT( i = 34 )

			CU_ASSERT( s = "" )
			CU_ASSERT( f3( ) = "56" )
			CU_ASSERT( f3( ) = s  )
			CU_ASSERT( s = "56" )

			CU_ASSERT( j = 0 )
			CU_ASSERT( f4( ) = 90 )
			CU_ASSERT( f4( ) = j )
			CU_ASSERT( j = 90 )

			CU_ASSERT( f5( ) = z )
			CU_ASSERT( f5( ) = "testing" )
			CU_ASSERT( f6( ) = "also good" )
			CU_ASSERT( f7( ) = w )
			CU_ASSERT( f7( ) = wstr( "testing" ) )
			CU_ASSERT( f8( ) = wstr( "also good" ) )

			CU_ASSERT( f9( ).i = 12 )
			CU_ASSERT( f10( ).a(0) = 34 )
			CU_ASSERT( f11( ) = 12 )
			CU_ASSERT( f12( ) = 34 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( returnStatic )
		function f1( ) byref as byte
			static as byte b = 12
			function = b
		end function

		function f2( ) byref as integer
			static as integer i = 34
			function = i
		end function

		function f3( ) byref as string
			static as string s
			s = "56"
			function = s
		end function

		function f4( ) byref as zstring
			static as zstring * 32 z = "testing"
			function = z
		end function

		function f5( ) byref as wstring
			static as wstring * 32 w = wstr( "testing" )
			function = w
		end function

		'' returning statics
		TEST( default )
			CU_ASSERT( f1( ) = 12 )
			CU_ASSERT( f2( ) = 34 )
			CU_ASSERT( f3( ) = "56" )
			CU_ASSERT( f4( ) = "testing" )
			CU_ASSERT( f5( ) = wstr( "testing" ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( withBlock )
		type UDT
			i as integer
		end type

		function f( ) byref as UDT
			static x as UDT
			function = x
		end function

		'' WITH block
		TEST( default )
			with( f( ) )
				CU_ASSERT( .i = 0 )
				.i = 456
				CU_ASSERT( .i = 456 )
			end with
			with( f( ) )
				CU_ASSERT( .i = 456 )
			end with
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( addrofResult )
		dim shared as integer i

		function f( ) byref as integer
			function = i
		end function

		'' @ byref result
		TEST( default )
			'' The extra parentheses are needed to prevent taking the
			'' address of the function itself, when we just wanted to
			'' cancel out the implicit DEREF.
			CU_ASSERT( @( f( ) ) = @i )

			CU_ASSERT( varptr( f( ) ) = @i )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( resultMemberAccess )
		'' syntax of member access, but really it will be a member deref

		type UDT
			as integer a, b
		end type

		function f( ) byref as UDT
			static x as UDT = ( 123, 456 )
			function = x
		end function

		'' member access
		TEST( default )
			CU_ASSERT( f( ).a = 123 )
			CU_ASSERT( 456 = f( ).b )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( resultPtrDeref )
		'' not much special about this, just the pointer being returned BYREF

		type UDT
			as integer a, b
		end type

		function f1( ) byref as integer ptr
			static i as integer = 789
			static pi as integer ptr = @i
			function = pi
		end function

		function f2( ) byref as UDT ptr
			static x as UDT = ( 123, 456 )
			static px as UDT ptr = @x
			function = px
		end function

		function f3( ) byref as string ptr
			static s as string
			static ps as string ptr = @s
			s = "abc"
			function = ps
		end function

		function f4( ) byref as zstring ptr
			static z as zstring * 32
			static pz as zstring ptr = @z
			z = "abc"
			function = pz
		end function

		function f5( ) byref as wstring ptr
			static w as wstring * 32
			static pw as wstring ptr = @w
			w = wstr( "abc" )
			function = pw
		end function

		'' ptr Deref
		TEST( default )
			CU_ASSERT( *f1( ) = 789 )

			CU_ASSERT( f2( )->a = 123 )
			CU_ASSERT( 456 = f2( )->b )

			CU_ASSERT( *f3( ) = "abc" )
			CU_ASSERT( *f4( ) = "abc" )
			CU_ASSERT( *f3( ) = *f4( ) )
			CU_ASSERT( *f5( ) = wstr( "abc" ) )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( resultPtrIndexing )
		dim shared as integer array(0 to 1) = { 11, 22 }

		function f( ) byref as integer ptr
			static pi as integer ptr = @array(0)
			function = pi
		end function

		TEST( default )
			CU_ASSERT( f( )[0] = 11 )
			CU_ASSERT( f( )[1] = 22 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( resultIndexing )
		dim shared as integer array(0 to 1) = { 11, 22 }

		function f( ) byref as integer
			function = array(0)
		end function

		'' ptr indexing
		TEST( default )
			CU_ASSERT( (@(f( )))[0] = 11 )
			CU_ASSERT( (@(f( )))[1] = 22 )
			CU_ASSERT( (varptr( f( ) ))[0] = 11 )
			CU_ASSERT( (varptr( f( ) ))[1] = 22 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( returnProcptr )
		function foo( ) as integer
			function = 1122
		end function

		function f( ) byref as function( ) as integer
			static pf as function( ) as integer = @foo
			function = pf
		end function

		'' procptr
		TEST( default )
			CU_ASSERT( f( )( ) = 1122 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( returnBydescArrayElement )
		function f1( array() as integer ) byref as integer
			function = array(0)
		end function

		function f2( array() as integer, byval index as integer ) byref as integer
			function = array(index)
		end function

		'' returning bydesc array element
		TEST( default )
			dim array(0 to 3) as integer = { 111, 222, 333, 444 }
			CU_ASSERT( f1( array() ) = 111 )
			CU_ASSERT( f2( array(), 0 ) = 111 )
			CU_ASSERT( f2( array(), 1 ) = 222 )
			CU_ASSERT( f2( array(), 2 ) = 333 )
			CU_ASSERT( f2( array(), 3 ) = 444 )

			f2( array(), 0 ) = 555
			CU_ASSERT( array(0) = 555 )

			f2( array(), 3 ) = 666
			CU_ASSERT( array(3) = 666 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( toByvalParam )
		function f( ) byref as integer
			static i as integer = 3344
			function = i
		end function

		function test1( byval i as integer ) as integer
			CU_ASSERT( i = 3344 )
			function = i
		end function

		'' byref result -> byval param
		TEST( default )
			CU_ASSERT( test1( f( ) ) = 3344 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( toByrefParam )
		dim shared globali as integer = 5566

		function f( ) byref as integer
			function = globali
		end function

		function test1( byref i as integer ) as integer
			CU_ASSERT( i = 5566 )
			CU_ASSERT( globali = 5566 )
			CU_ASSERT( @globali = @i )
			function = i
		end function

		'' byref result -> byref param
		TEST( default )
			CU_ASSERT( test1( f( ) ) = 5566 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( properties )
		type UDT
			i as integer
			declare property f( ) byref as integer
			declare property f( byval as integer )
		end type

		property UDT.f( ) byref as integer
			return this.i
		end property

		property UDT.f( byval j as integer )
			this.i = j
		end property

		'' properties
		TEST( default )
			dim x as UDT
			x.i = 123
			CU_ASSERT( x.f = 123 )
			CU_ASSERT( @x.f = @x.i )
			x.f = 124
			CU_ASSERT( x.i = 124 )
			CU_ASSERT( x.f = 124 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( operators )
		type UDT
			i as integer

			declare operator for( )
			declare operator for( byref stp as UDT )
			declare operator step( )
			declare operator step( byref stp as UDT )
			declare operator next( byref cond as UDT ) byref as integer
			declare operator next( byref cond as UDT, byref stp as UDT ) byref as integer
		end type

		operator UDT.for( )
			i = 0
		end operator

		operator UDT.for( byref stp as UDT )
			i = 0
		end operator

		operator UDT.step( )
			i += 1
		end operator

		operator UDT.step( byref stp as UDT )
			i += 1
		end operator

		operator UDT.next( byref cond as UDT ) byref as integer
			static c as integer
			c = (i < 5)
			operator = c
		end operator

		operator UDT.next( byref cond as UDT, byref stp as UDT ) byref as integer
			static c as integer
			c = (i < 5)
			operator = c
		end operator

		operator *( byref x as UDT ) byref as integer
			operator = x.i
		end operator

		'' operators
		TEST( default )
			dim as integer count

			dim x as UDT = ( 123 )
			CU_ASSERT( x.i = 123 )
			CU_ASSERT( *x = 123 )
			*x = 456
			CU_ASSERT( x.i = 456 )
			CU_ASSERT( *x = 456 )

			count = 0
			for i as UDT = x to x step x
				count += 1
			next
			CU_ASSERT( count = 5 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( ignoreResult )
		dim shared as integer calls

		function f( ) byref as integer
			calls += 1
			static i as integer = 3344
			function = i
		end function

		'' ignore results
		TEST( default )
			CU_ASSERT( calls = 0 )
			f( )
			f( ) 'comment
			f( ) rem rem
			f( ) : 'stmtsep
			f( ) : f( ) 'stmtsep
			CU_ASSERT( calls = 6 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( ctorDtorUdt )
		dim shared as integer ctorcalls, dtorcalls

		type UDT
			dummy as integer
			declare constructor( )
			declare constructor( byref as UDT )
			declare destructor( )
		end type

		constructor UDT( )
			dummy = 123
			ctorcalls += 1
		end constructor

		constructor UDT( byref rhs as UDT )
			dummy = 0
			ctorcalls += 1
		end constructor

		destructor UDT( )
			dtorcalls += 1
		end destructor

		dim shared x as UDT

		function f( ) byref as UDT
			CU_ASSERT( ctorcalls = 1 )
			function = x
		end function

		'' UDT with ctor/dtor
		TEST( default )
			CU_ASSERT( ctorcalls = 1 )
			scope  '' scope to capture any temp vars, just in case
				CU_ASSERT( f( ).dummy = 123 )
				x = f( )
			end scope
			CU_ASSERT( ctorcalls = 1 )
			CU_ASSERT( dtorcalls = 0 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( funcptr )
		dim shared as integer x1 = 123, x2 = 789

		function f1( ) byref as integer
			function = x1
		end function

		function f2( ) byref as integer
			function = x2
		end function

		'' function pointer
		TEST( default )
			dim p as function( ) byref as integer = @f1
			CU_ASSERT( f1( ) = 123 )
			CU_ASSERT(  p( ) = 123 )
			CU_ASSERT( @(f1( )) = @(p( )) )
			x1 = 456
			CU_ASSERT(  p( ) = 456 )
			CU_ASSERT( f1( ) = 456 )
			p = @f2
			CU_ASSERT(  p( ) = 789 )
			CU_ASSERT( f2( ) = 789 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( byrefToByref )
		function f1( byref i as integer ) byref as integer
			function = i
		end function

		function f2( ) byref as integer
			static i as integer = 789
			function = i
		end function

		function f3( ) byref as integer
			function = f2( )
		end function

		function f4( byref i as integer ) as integer
			function = i
		end function

		'' BYREF to BYREF
		TEST( default )
			dim i as integer = 456
			CU_ASSERT( f1( 123 ) = 123 )
			CU_ASSERT( f1( i ) = i )
			CU_ASSERT( f1( i ) = 456 )
			CU_ASSERT( f1( f1( i ) ) = 456 )
			CU_ASSERT( @(f1( i )) = @i )
			CU_ASSERT( @(f1( f1( i ) )) = @i )

			CU_ASSERT( f3( ) = 789 )

			CU_ASSERT( f4( f2( ) ) = 789 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( referenceToTreeUsingLocals )
		'' Some expression trees can include/use locals without really being
		'' references to locals themselves; thus they should be allowed

		type UDT
			a(0 to 1) as integer
		end type

		dim shared as integer globalarray(0 to 1) = { 12, 34 }
		dim shared as UDT globalx = ( { 56, 78 } )

		function f1( ) byref as integer
			dim i as integer
			function = globalarray(i)
		end function

		function f2( ) byref as integer
			dim i as integer = 1
			function = globalx.a(i)
		end function

		function f3( ) byref as integer
			dim i as integer = 1
			dim x as UDT = ( { 1, 0 } )
			function = globalx.a(x.a(i))
		end function

		function f( ) as integer
			function = 1
		end function

		function f4( ) byref as integer
			function = globalarray(f( ))
		end function

		'' tree using locals
		TEST( default )
			CU_ASSERT( f1( ) = 12 )
			CU_ASSERT( @(f1( )) = @globalarray(0) )
			CU_ASSERT( f2( ) = 78 )
			CU_ASSERT( @(f2( )) = @globalx.a(1) )
			CU_ASSERT( f3( ) = 56 )
			CU_ASSERT( f4( ) = 34 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( explicitByval )
		dim shared i as integer = 123

		function f1( ) byref as integer
			dim pi as integer ptr = @i
			function = byval pi
		end function

		function f2( ) byref as integer
			dim pi as integer ptr = @i
			return byval pi
		end function

		'' explicit BYVAL
		TEST( default )
			CU_ASSERT( f1( ) = 123 )
			CU_ASSERT( f2( ) = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( byrefResultAsLvalue )
		type UDT
			as integer a, b
		end type

		dim shared dat(0 to 2) as zstring * 32 = { "a", "b", "c" }
		dim shared i as integer

		function f1( ) byref as zstring
			function = dat( i )
		end function

		function f2( byval j as integer ) byref as zstring
			function = dat( j )
		end function

		function f3( ) byref as UDT
			static as UDT x1 = ( 12, 34 ), x2 = ( 56, 78 )
			if( i ) then
				return x1
			end if
			function = x2
		end function

		function f4( byval j as integer ) byref as UDT
			static as UDT x1 = ( 12, 34 ), x2 = ( 56, 78 )
			if( j ) then
				return x1
			end if
			function = x2
		end function

		TEST( default )
			i = 0 : CU_ASSERT( f1( ) = "a" )
			i = 1 : CU_ASSERT( f1( ) = "b" )
			i = 2 : CU_ASSERT( f1( ) = "c" )
			i = 1 : f1( ) = "y"  '' Note: must be careful; it's like *pzstr = "foo", the length is unchecked
			i = 0 : CU_ASSERT( f1( ) = "a" )
			i = 1 : CU_ASSERT( f1( ) = "y" )
			i = 2 : CU_ASSERT( f1( ) = "c" )
			i = 0 : f1( ) = "x"
			i = 2 : f1( ) = "z"
			i = 0 : CU_ASSERT( f1( ) = "x" )
			i = 1 : CU_ASSERT( f1( ) = "y" )
			i = 2 : CU_ASSERT( f1( ) = "z" )

			'' reset test data
			dat(0) = "a"
			dat(1) = "b"
			dat(2) = "c"

			CU_ASSERT( f2( 0 ) = "a" )
			CU_ASSERT( f2( 1 ) = "b" )
			CU_ASSERT( f2( 2 ) = "c" )
			(f2( 1 )) = "y"
			CU_ASSERT( f2( 0 ) = "a" )
			CU_ASSERT( f2( 1 ) = "y" )
			CU_ASSERT( f2( 2 ) = "c" )

			(f2( 0 )) = "x"
			(f2( 2 )) = "z"
			CU_ASSERT( f2( 0 ) = "x" )
			CU_ASSERT( f2( 1 ) = "y" )
			CU_ASSERT( f2( 2 ) = "z" )

			i = 1 : CU_ASSERT( f3( ).a = 12 )
			i = 1 : CU_ASSERT( f3( ).b = 34 )
			i = 0 : CU_ASSERT( f3( ).a = 56 )
			i = 0 : CU_ASSERT( f3( ).b = 78 )
			i = 1 : f3( ).a = 0
			i = 0 : f3( ).b = 0
			i = 1 : CU_ASSERT( f3( ).a = 0 )
			i = 1 : CU_ASSERT( f3( ).b = 34 )
			i = 0 : CU_ASSERT( f3( ).a = 56 )
			i = 0 : CU_ASSERT( f3( ).b = 0 )
			i = 0 : f3( ) = type<UDT>( 22, 33 )
			i = 1 : CU_ASSERT( f3( ).a = 0 )
			i = 1 : CU_ASSERT( f3( ).b = 34 )
			i = 0 : CU_ASSERT( f3( ).a = 22 )
			i = 0 : CU_ASSERT( f3( ).b = 33 )

			CU_ASSERT( f4( 1 ).a = 12 )
			CU_ASSERT( f4( 1 ).b = 34 )
			CU_ASSERT( f4( 0 ).a = 56 )
			CU_ASSERT( f4( 0 ).b = 78 )
			(f4( 1 ).a) = 0
			(f4( 0 )).b = 0
			CU_ASSERT( f4( 1 ).a = 0 )
			CU_ASSERT( f4( 1 ).b = 34 )
			CU_ASSERT( f4( 0 ).a = 56 )
			CU_ASSERT( f4( 0 ).b = 0 )
			(f4( 0 )) = type<UDT>( 22, 33 )
			CU_ASSERT( f4( 1 ).a = 0 )
			CU_ASSERT( f4( 1 ).b = 34 )
			CU_ASSERT( f4( 0 ).a = 22 )
			CU_ASSERT( f4( 0 ).b = 33 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( protoReturningFwdref )
		type typedef as fwdref

		'' As with BYREF parameters, BYREF AS FWDREF is allowed, but only in
		'' prototypes, not the function body itself
		declare function f( ) byref as typedef

		type fwdref as integer

		function f( ) byref as integer
			static as integer a = 123
			function = a
		end function

		'' returning a forward ref
		TEST( default )
			CU_ASSERT( f( ) = 123 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( cxxMangling )
		extern "C++"
			'' The BYREF result in function pointer parameters must be included
			'' in the C++ mangling. These 4 overloads should all have different
			'' mangling:
			sub f1 overload( byval p as function cdecl( ) as integer )
			end sub

			sub f1 overload( byval p as function cdecl( ) as const integer )
			end sub

			sub f1 overload( byval p as function cdecl( ) byref as integer )
			end sub

			sub f1 overload( byval p as function cdecl( ) byref as const integer )
			end sub

			'' A function's result isn't included in its C++ name mangling, since
			'' overloading based on function result type isn't supported in C++
			'' (neither in FB), but for function pointer parameters, it still must
			'' be taken into account.
			function f2 overload( byval p as function cdecl( ) as integer ) byref as integer
				static as integer x = 1
				function = x
			end function

			function f2 overload( byval p as function cdecl( ) as const integer ) byref as integer
				static as integer x = 2
				function = x
			end function

			function f2 overload( byval p as function cdecl( ) byref as integer ) byref as integer
				static as integer x = 3
				function = x
			end function

			function f2 overload( byval p as function cdecl( ) byref as const integer ) byref as integer
				static as integer x = 4
				function = x
			end function
		end extern

		'' C++ mangling
		TEST( default )
			dim p1 as function cdecl( ) as integer
			dim p2 as function cdecl( ) as const integer
			dim p3 as function cdecl( ) byref as integer
			dim p4 as function cdecl( ) byref as const integer

			f1( p1 )
			f1( p2 )
			f1( p3 )
			f1( p4 )

			CU_ASSERT( f2( p1 ) = 1 )
			CU_ASSERT( f2( p2 ) = 2 )
			CU_ASSERT( f2( p3 ) = 3 )
			CU_ASSERT( f2( p4 ) = 4 )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( returnVsFunction )
		'' For functions returning BYREF, both RETURN and FUNCTION= should be
		'' allowed to assign results, no matter what result type it is, since
		'' it's just a pointer, and the function doesn't actually have to call
		'' any constructor.

		type CtorUdt
			i as integer
			declare constructor( )
		end type

		constructor CtorUdt( )
		end constructor

		dim shared as integer ireturn, ifunction
		dim shared as CtorUdt ctorudtreturn, ctorudtfunction

		function getInteger1( ) byref as integer
			return ireturn
			function = ifunction
		end function

		function getInteger2( ) byref as integer
			function = ifunction
			return ireturn
		end function

		function getInteger3( ) byref as integer
			exit function
			return ireturn
		end function

		function getInteger4( ) byref as integer
			return ireturn
			exit function
		end function

		function getCtorUdt1( ) byref as CtorUdt
			return ctorudtreturn
			function = ctorudtfunction
		end function

		function getCtorUdt2( ) byref as CtorUdt
			function = ctorudtfunction
			return ctorudtreturn
		end function

		function getCtorUdt3( ) byref as CtorUdt
			exit function
			return ctorudtreturn
		end function

		function getCtorUdt4( ) byref as CtorUdt
			return ctorudtreturn
			exit function
		end function

		TEST( default )
			CU_ASSERT( @(getInteger1( )) = @ireturn )
			CU_ASSERT( @(getInteger2( )) = @ireturn )
			CU_ASSERT( @(getInteger3( )) = 0 )
			CU_ASSERT( @(getInteger4( )) = @ireturn )
			CU_ASSERT( @(getCtorUdt1( )) = @ctorudtreturn )
			CU_ASSERT( @(getCtorUdt2( )) = @ctorudtreturn )
			CU_ASSERT( @(getCtorUdt3( )) = 0 )
			CU_ASSERT( @(getCtorUdt4( )) = @ctorudtreturn )
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( derefConst )
		type UDT
			a as integer
			b as integer
		end type

		function offsetof_a( ) byref as integer
			'' This isn't an access to a local var, so it should be allowed (and not
			'' trigger a compiler crash), although it's perhaps not very useful,
			'' except if all callers of this function take the address-of the result
			'' in which case they'll retrieve the offsetof(UDT, a).
			function = cptr(UDT ptr, 0)->a
		end function

		function offsetof_b( ) byref as integer
			function = cptr(UDT ptr, 0)->b
		end function

		TEST( default )
			CU_ASSERT( @(offsetof_a( )) = offsetof( UDT, a ) )
			CU_ASSERT( @(offsetof_b( )) = offsetof( UDT, b ) )
		END_TEST
	END_TEST_GROUP

	namespace constness
		function f1() byref as const integer
			static i as integer
			function = i
		end function
	end namespace

	TEST_GROUP( returnCtorCall )
		'' In return-byval functions, RETURN can call a ctor to construct the result.
		'' This shouldn't be done in return-byref functions, because there is no
		'' result object (it's just a pointer).

		dim shared as integer ctorcalls, ptrctorcalls, copyctorcalls

		type UDT
			dummy as integer
			declare constructor()
			declare constructor(byval as const UDT ptr)
			declare constructor(byref as const UDT)
		end type

		constructor UDT()
			ctorcalls += 1
		end constructor

		constructor UDT(byval px as const UDT ptr)
			'' This ctor overload triggered the bug (byref function results
			'' are pointers)
			ptrctorcalls += 1
		end constructor

		constructor UDT(byref x as const UDT)
			copyctorcalls += 1
		end constructor

		dim shared p as UDT ptr

		function f() byref as UDT
			'' should just do assignment, no ctor calls
			return *p
		end function

		TEST( default )
			CU_ASSERT( ctorcalls = 0 )
			CU_ASSERT( ptrctorcalls = 0 )
			CU_ASSERT( copyctorcalls = 0 )

			p = new UDT()
			CU_ASSERT( ctorcalls = 1 )
			CU_ASSERT( ptrctorcalls = 0 )
			CU_ASSERT( copyctorcalls = 0 )

			scope
				dim px as UDT ptr = @(f())
				CU_ASSERT( ctorcalls = 1 )
				CU_ASSERT( ptrctorcalls = 0 )
				CU_ASSERT( copyctorcalls = 0 )
			end scope

			scope
				dim x as UDT = f()
				CU_ASSERT( ctorcalls = 1 )
				CU_ASSERT( ptrctorcalls = 0 )
				CU_ASSERT( copyctorcalls = 1 )
			end scope

			delete p
		END_TEST
	END_TEST_GROUP

END_SUITE
