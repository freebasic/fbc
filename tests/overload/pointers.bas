# include "fbcu.bi"

namespace fbc_tests.overload_.pointers

type T
	as integer a, b, c, d
end type

type Forward as MyUndefinedType

dim shared pb as byte ptr, ppb as byte ptr ptr
dim shared pub as ubyte ptr, ppub as ubyte ptr ptr
dim shared ps as short ptr, pps as short ptr ptr
dim shared pus as ushort ptr, ppus as ushort ptr ptr
dim shared i as integer, pi as integer ptr, ppi as integer ptr ptr
dim shared pui as uinteger ptr, ppui as uinteger ptr ptr
dim shared pl as long ptr, ppl as long ptr ptr
dim shared pul as ulong ptr, ppul as ulong ptr ptr
dim shared pll as longint ptr, ppll as longint ptr ptr
dim shared pull as ulongint ptr, ppull as ulongint ptr ptr
dim shared pt as T ptr, ppt as T ptr ptr
dim shared pany as any ptr, ppany as any ptr ptr
dim shared pfwd as Forward ptr, ppfwd as Forward ptr ptr

dim shared pds as string ptr, ppds as string ptr ptr
dim shared pzs as zstring ptr, ppzs as zstring ptr ptr
dim shared pws as wstring ptr, ppws as wstring ptr ptr

#macro proc( T )
	function f overload( byval p as T ) as string
		function = #T
	end function
#endmacro

namespace pointers
	proc( byte ptr )
	proc( byte ptr ptr )
	proc( short ptr )
	proc( short ptr ptr )
	proc( integer ptr )
	proc( integer ptr ptr )
	proc( long ptr )
	proc( long ptr ptr )
	proc( longint ptr )
	proc( longint ptr ptr )
	proc( T ptr )
	proc( T ptr ptr )
	proc( any ptr )
	proc( any ptr ptr )
	proc( Forward ptr )
	proc( Forward ptr ptr )
	proc( string ptr )
	proc( string ptr ptr )
	proc( zstring ptr )
	proc( zstring ptr ptr )
	proc( wstring ptr )
	proc( wstring ptr ptr )

	sub test cdecl( )
		CU_ASSERT( f( pb ) = "byte ptr" )
		CU_ASSERT( f( ps ) = "short ptr" )
		CU_ASSERT( f( pi ) = "integer ptr" )
		CU_ASSERT( f( pl ) = "long ptr" )
		CU_ASSERT( f( pll ) = "longint ptr" )
		CU_ASSERT( f( pt ) = "T ptr" )
		CU_ASSERT( f( pany ) = "any ptr" )
		CU_ASSERT( f( pfwd ) = "Forward ptr" )
		CU_ASSERT( f( pds ) = "string ptr" )
		CU_ASSERT( f( pzs ) = "zstring ptr" )
		CU_ASSERT( f( pws ) = "wstring ptr" )

		CU_ASSERT( f( ppb ) = "byte ptr ptr" )
		CU_ASSERT( f( pps ) = "short ptr ptr" )
		CU_ASSERT( f( ppi ) = "integer ptr ptr" )
		CU_ASSERT( f( ppl ) = "long ptr ptr" )
		CU_ASSERT( f( ppll ) = "longint ptr ptr" )
		CU_ASSERT( f( ppt ) = "T ptr ptr" )
		CU_ASSERT( f( ppany ) = "any ptr ptr" )
		CU_ASSERT( f( ppfwd ) = "Forward ptr ptr" )
		CU_ASSERT( f( ppds ) = "string ptr ptr" )
		CU_ASSERT( f( ppzs ) = "zstring ptr ptr" )
		CU_ASSERT( f( ppws ) = "wstring ptr ptr" )

		CU_ASSERT( f( @ppb ) = "any ptr" )
		CU_ASSERT( f( @pps ) = "any ptr" )
		CU_ASSERT( f( @ppi ) = "any ptr" )
		CU_ASSERT( f( @ppt ) = "any ptr" )
		CU_ASSERT( f( @ppany ) = "any ptr" )
		CU_ASSERT( f( @ppfwd ) = "any ptr" )
	end sub
end namespace

namespace anyptrParam1
	'' Any Ptr params accept all pointers
	proc( any ptr )

	sub test cdecl( )
		CU_ASSERT( f( pb ) = "any ptr" )
		CU_ASSERT( f( ps ) = "any ptr" )
		CU_ASSERT( f( pi ) = "any ptr" )
		CU_ASSERT( f( pl ) = "any ptr" )
		CU_ASSERT( f( pll ) = "any ptr" )
		CU_ASSERT( f( pt ) = "any ptr" )
		CU_ASSERT( f( pany ) = "any ptr" )
		CU_ASSERT( f( pfwd ) = "any ptr" )
		CU_ASSERT( f( pds ) = "any ptr" )
		CU_ASSERT( f( pzs ) = "any ptr" )
		CU_ASSERT( f( pws ) = "any ptr" )

		CU_ASSERT( f( ppb ) = "any ptr" )
		CU_ASSERT( f( pps ) = "any ptr" )
		CU_ASSERT( f( ppi ) = "any ptr" )
		CU_ASSERT( f( ppl ) = "any ptr" )
		CU_ASSERT( f( ppll ) = "any ptr" )
		CU_ASSERT( f( ppt ) = "any ptr" )
		CU_ASSERT( f( ppany ) = "any ptr" )
		CU_ASSERT( f( ppfwd ) = "any ptr" )
		CU_ASSERT( f( ppds ) = "any ptr" )
		CU_ASSERT( f( ppzs ) = "any ptr" )
		CU_ASSERT( f( ppws ) = "any ptr" )
	end sub
end namespace

namespace anyptrParam2
	proc( integer ptr )
	proc( any ptr )

	sub test cdecl( )
		CU_ASSERT( f( pb ) = "any ptr" )
		CU_ASSERT( f( ps ) = "any ptr" )
		CU_ASSERT( f( pi ) = "integer ptr" ) '' Full match - not ambigious
		CU_ASSERT( f( pl ) = "any ptr" )
		CU_ASSERT( f( pll ) = "any ptr" )
		CU_ASSERT( f( pt ) = "any ptr" )
		CU_ASSERT( f( pany ) = "any ptr" ) '' Full match - not ambigious
		CU_ASSERT( f( pfwd ) = "any ptr" )
		CU_ASSERT( f( pds ) = "any ptr" )
		CU_ASSERT( f( pzs ) = "any ptr" )
		CU_ASSERT( f( pws ) = "any ptr" )

		CU_ASSERT( f( ppb ) = "any ptr" )
		CU_ASSERT( f( pps ) = "any ptr" )
		CU_ASSERT( f( ppi ) = "any ptr" )
		CU_ASSERT( f( ppl ) = "any ptr" )
		CU_ASSERT( f( ppll ) = "any ptr" )
		CU_ASSERT( f( ppt ) = "any ptr" )
		CU_ASSERT( f( ppany ) = "any ptr" )
		CU_ASSERT( f( ppfwd ) = "any ptr" )
		CU_ASSERT( f( ppds ) = "any ptr" )
		CU_ASSERT( f( ppzs ) = "any ptr" )
		CU_ASSERT( f( ppws ) = "any ptr" )
	end sub
end namespace

namespace anyptrParam3
	proc( byte ptr )
	proc( short ptr )
	proc( integer ptr )
	proc( any ptr )

	sub test cdecl( )
		CU_ASSERT( f( pb ) = "byte ptr" )
		CU_ASSERT( f( ps ) = "short ptr" )
		CU_ASSERT( f( pi ) = "integer ptr" )
		CU_ASSERT( f( pl ) = "any ptr" )
		CU_ASSERT( f( pll ) = "any ptr" )
		CU_ASSERT( f( pt ) = "any ptr" )
		CU_ASSERT( f( pany ) = "any ptr" )
		CU_ASSERT( f( pfwd ) = "any ptr" )
		CU_ASSERT( f( pds ) = "any ptr" )
		CU_ASSERT( f( pzs ) = "any ptr" )
		CU_ASSERT( f( pws ) = "any ptr" )

		'' With higher indirection level, these should all match the
		'' Any Ptr, since there are no full matches
		CU_ASSERT( f( ppb ) = "any ptr" )
		CU_ASSERT( f( pps ) = "any ptr" )
		CU_ASSERT( f( ppi ) = "any ptr" )
		CU_ASSERT( f( ppl ) = "any ptr" )
		CU_ASSERT( f( ppll ) = "any ptr" )
		CU_ASSERT( f( ppt ) = "any ptr" )
		CU_ASSERT( f( ppany ) = "any ptr" )
		CU_ASSERT( f( ppfwd ) = "any ptr" )
		CU_ASSERT( f( ppds ) = "any ptr" )
		CU_ASSERT( f( ppzs ) = "any ptr" )
		CU_ASSERT( f( ppws ) = "any ptr" )
	end sub
end namespace

namespace anyptrArg1
	'' Any Ptr args match all pointer params (unlike C++)
	proc( integer )
	proc( integer ptr )

	sub test cdecl( )
		CU_ASSERT( f( i ) = "integer" )
		CU_ASSERT( f( pi ) = "integer ptr" )
		CU_ASSERT( f( pany ) = "integer ptr" )
	end sub
end namespace

namespace anyptrArg2
	proc( integer )
	proc( T ptr )

	sub test cdecl( )
		CU_ASSERT( f( i ) = "integer" )
		CU_ASSERT( f( pt ) = "T ptr" )
		CU_ASSERT( f( pany ) = "T ptr" )
	end sub
end namespace

namespace anyptrArg3
	proc( integer )
	proc( T ptr ptr )

	sub test cdecl( )
		CU_ASSERT( f( i ) = "integer" )
		CU_ASSERT( f( ppt ) = "T ptr ptr" )
		CU_ASSERT( f( pany ) = "T ptr ptr" )
	end sub
end namespace

namespace anyptrArgRegressionTest1
	'' Regression test (Any Ptr args were treated as Uintegers)
	proc( uinteger )
	proc( integer ptr )

	sub test cdecl( )
		CU_ASSERT( f( i ) = "uinteger" )
		CU_ASSERT( f( pi ) = "integer ptr" )
		CU_ASSERT( f( pany ) = "integer ptr" )
	end sub
end namespace

namespace anyptrArgRegressionTest2
	proc( uinteger )
	proc( any ptr )

	sub test cdecl( )
		CU_ASSERT( f( i ) = "uinteger" )
		CU_ASSERT( f( pi ) = "any ptr" )
		CU_ASSERT( f( pany ) = "any ptr" )
		CU_ASSERT( f( pt ) = "any ptr" )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "tests/overload/pointers" )
	fbcu.add_test( "pointers", @pointers.test )
	fbcu.add_test( "Any Ptr param 1", @anyptrParam1.test )
	fbcu.add_test( "Any Ptr param 2", @anyptrParam2.test )
	fbcu.add_test( "Any Ptr param 3", @anyptrParam3.test )
	fbcu.add_test( "Any Ptr arg 1", @anyptrArg1.test )
	fbcu.add_test( "Any Ptr arg 2", @anyptrArg2.test )
	fbcu.add_test( "Any Ptr arg 3", @anyptrArg3.test )
	fbcu.add_test( "Any Ptr bug 1", @anyptrArgRegressionTest1.test )
	fbcu.add_test( "Any Ptr bug 2", @anyptrArgRegressionTest2.test )
end sub

end namespace
