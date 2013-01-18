#include "fbcu.bi"

namespace fbc_tests.functions.return_byref

namespace returnGlobal
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

	sub test cdecl( )
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
	end sub
end namespace

namespace returnStatic
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

	sub test cdecl( )
		CU_ASSERT( f1( ) = 12 )
		CU_ASSERT( f2( ) = 34 )
		CU_ASSERT( f3( ) = "56" )
		CU_ASSERT( f4( ) = "testing" )
		CU_ASSERT( f5( ) = wstr( "testing" ) )
	end sub
end namespace

namespace withBlock
	type UDT
		i as integer
	end type

	function f( ) byref as UDT
		static x as UDT
		function = x
	end function

	sub test cdecl( )
		with( f( ) )
			CU_ASSERT( .i = 0 )
			.i = 456
			CU_ASSERT( .i = 456 )
		end with
		with( f( ) )
			CU_ASSERT( .i = 456 )
		end with
	end sub
end namespace

namespace addrofResult
	dim shared as integer i

	function f( ) byref as integer
		function = i
	end function

	sub test cdecl( )
		'' The extra parentheses are needed to prevent taking the
		'' address of the function itself, when we just wanted to
		'' cancel out the implicit DEREF.
		CU_ASSERT( @( f( ) ) = @i )

		CU_ASSERT( varptr( f( ) ) = @i )
	end sub
end namespace

namespace resultMemberAccess
	'' syntax of member access, but really it will be a member deref

	type UDT
		as integer a, b
	end type

	function f( ) byref as UDT
		static x as UDT = ( 123, 456 )
		function = x
	end function

	sub test cdecl( )
		CU_ASSERT( f( ).a = 123 )
		CU_ASSERT( 456 = f( ).b )
	end sub
end namespace

namespace resultPtrDeref
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

	sub test cdecl( )
		CU_ASSERT( *f1( ) = 789 )

		CU_ASSERT( f2( )->a = 123 )
		CU_ASSERT( 456 = f2( )->b )

		CU_ASSERT( *f3( ) = "abc" )
		CU_ASSERT( *f4( ) = "abc" )
		CU_ASSERT( *f3( ) = *f4( ) )
		CU_ASSERT( *f5( ) = wstr( "abc" ) )
	end sub
end namespace

namespace resultPtrIndexing
	dim shared as integer array(0 to 1) = { 11, 22 }

	function f( ) byref as integer ptr
		static pi as integer ptr = @array(0)
		function = pi
	end function

	sub test cdecl( )
		CU_ASSERT( f( )[0] = 11 )
		CU_ASSERT( f( )[1] = 22 )
	end sub
end namespace

namespace resultIndexing
	dim shared as integer array(0 to 1) = { 11, 22 }

	function f( ) byref as integer ptr
		function = array(0)
	end function

	sub test cdecl( )
		CU_ASSERT( (@(f( )))[0] = 11 )
		CU_ASSERT( (@(f( )))[1] = 22 )
		CU_ASSERT( (varptr( f( ) ))[0] = 11 )
		CU_ASSERT( (varptr( f( ) ))[1] = 22 )
	end sub
end namespace

namespace returnProcptr
	function foo( ) as integer
		function = 1122
	end function

	function f( ) byref as function( ) as integer
		static pf as function( ) as integer = @foo
		function = pf
	end function

	sub test cdecl( )
		CU_ASSERT( f( )( ) = 1122 )
	end sub
end namespace

namespace toByvalParam
	function f( ) byref as integer
		static i as integer = 3344
		function = i
	end function

	function test1( byval i as integer ) as integer
		CU_ASSERT( i = 3344 )
		function = i
	end function

	sub test cdecl( )
		CU_ASSERT( test1( f( ) ) = 3344 )
	end sub
end namespace

namespace toByrefParam
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

	sub test cdecl( )
		CU_ASSERT( test1( f( ) ) = 5566 )
	end sub
end namespace

namespace properties
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

	sub test cdecl( )
		dim x as UDT
		x.i = 123
		CU_ASSERT( x.f = 123 )
		CU_ASSERT( @x.f = @x.i )
		x.f = 124
		CU_ASSERT( x.i = 124 )
		CU_ASSERT( x.f = 124 )
	end sub
end namespace

namespace operators
	type UDT
		i as integer
	end type

	operator *( byref x as UDT ) byref as integer
		operator = x.i
	end operator

	sub test cdecl( )
		dim x as UDT = ( 123 )
		CU_ASSERT( x.i = 123 )
		CU_ASSERT( *x = 123 )
		*x = 456
		CU_ASSERT( x.i = 456 )
		CU_ASSERT( *x = 456 )
	end sub
end namespace

namespace ignoreResult
	dim shared as integer calls

	function f( ) byref as integer
		calls += 1
		static i as integer = 3344
		function = i
	end function

	sub test cdecl( )
		CU_ASSERT( calls = 0 )
		f( )
		CU_ASSERT( calls = 1 )
	end sub
end namespace

namespace ctorDtorUdt
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

	sub test cdecl( )
		CU_ASSERT( ctorcalls = 1 )
		scope  '' scope to capture any temp vars, just in case
			CU_ASSERT( f( ).dummy = 123 )
			x = f( )
		end scope
		CU_ASSERT( ctorcalls = 1 )
		CU_ASSERT( dtorcalls = 0 )
	end sub
end namespace

namespace funcptr
	dim shared as integer x1 = 123, x2 = 789

	function f1( ) byref as integer
		function = x1
	end function

	function f2( ) byref as integer
		function = x2
	end function

	sub test cdecl( )
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
	end sub
end namespace

namespace byrefToByref
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

	sub test cdecl( )
		dim i as integer = 456
		CU_ASSERT( f1( 123 ) = 123 )
		CU_ASSERT( f1( i ) = i )
		CU_ASSERT( f1( i ) = 456 )
		CU_ASSERT( f1( f1( i ) ) = 456 )
		CU_ASSERT( @(f1( i )) = @i )
		CU_ASSERT( @(f1( f1( i ) )) = @i )

		CU_ASSERT( f3( ) = 789 )

		CU_ASSERT( f4( f2( ) ) = 789 )
	end sub
end namespace

namespace referenceToTreeUsingLocals
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

	sub test cdecl( )
		CU_ASSERT( f1( ) = 12 )
		CU_ASSERT( @(f1( )) = @globalarray(0) )
		CU_ASSERT( f2( ) = 78 )
		CU_ASSERT( @(f2( )) = @globalx.a(1) )
		CU_ASSERT( f3( ) = 56 )
		CU_ASSERT( f4( ) = 34 )
	end sub
end namespace

namespace explicitByval
	dim shared i as integer = 123

	function f1( ) byref as integer
		dim pi as integer ptr = @i
		function = byval pi
	end function

	function f2( ) byref as integer
		dim pi as integer ptr = @i
		return byval pi
	end function

	sub test cdecl( )
		CU_ASSERT( f1( ) = 123 )
		CU_ASSERT( f2( ) = 123 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/functions/return-byref" )
	fbcu.add_test( "returning globals", @returnGlobal.test )
	fbcu.add_test( "returning statics", @returnStatic.test )
	fbcu.add_test( "WITH block", @withBlock.test )
	fbcu.add_test( "@ byref result", @addrofResult.test )
	fbcu.add_test( "member access", @resultMemberAccess.test )
	fbcu.add_test( "ptr deref", @resultPtrDeref.test )
	fbcu.add_test( "ptr indexing", @resultPtrIndexing.test )
	fbcu.add_test( "indexing", @resultIndexing.test )
	fbcu.add_test( "procptr", @returnProcptr.test )
	fbcu.add_test( "byref result -> byval param", @toByvalParam.test )
	fbcu.add_test( "byref result -> byref param", @toByrefParam.test )
	fbcu.add_test( "properties", @properties.test )
	fbcu.add_test( "operators", @operators.test )
	fbcu.add_test( "ignore result", @ignoreResult.test )
	fbcu.add_test( "UDT with ctor/dtor", @ctorDtorUdt.test )
	fbcu.add_test( "function ptr", @funcptr.test )
	fbcu.add_test( "BYREF to BYREF", @byrefToByref.test )
	fbcu.add_test( "tree using locals", @referenceToTreeUsingLocals.test )
	fbcu.add_test( "explicit BYVAL", @explicitByval.test )
end sub

end namespace
