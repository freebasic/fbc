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

namespace integerPointers
	namespace long_ulong
		proc( long ptr )
		proc( ulong ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace long_longint
		proc( long ptr )
		proc( longint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		end sub
	end namespace

	namespace long_ulongint
		proc( long ptr )
		proc( ulongint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		end sub
	end namespace

	namespace long_integer
		proc( long ptr )
		proc( integer ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#else
				CU_ASSERT( f( pul ) = "long ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		end sub
	end namespace

	namespace long_uinteger
		proc( long ptr )
		proc( uinteger ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pul ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "long ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace ulong_long
		proc( ulong ptr )
		proc( long ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace ulong_longint
		proc( ulong ptr )
		proc( longint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace ulong_ulongint
		proc( ulong ptr )
		proc( ulongint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace ulong_integer
		proc( ulong ptr )
		proc( integer ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pl ) = "ulong ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "integer ptr" )
			#else
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace ulong_uinteger
		proc( ulong ptr )
		proc( uinteger ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace longint_long
		proc( longint ptr )
		proc( long ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		end sub
	end namespace

	namespace longint_ulong
		proc( longint ptr )
		proc( ulong ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "longint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace longint_ulongint
		proc( longint ptr )
		proc( ulongint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#endif
		end sub
	end namespace

	namespace longint_integer
		proc( longint ptr )
		proc( integer ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		end sub
	end namespace

	namespace longint_uinteger
		proc( longint ptr )
		proc( uinteger ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "longint ptr" )
			#else
				CU_ASSERT( f( pull ) = "longint ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace ulongint_long
		proc( ulongint ptr )
		proc( long ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "long ptr" )
				CU_ASSERT( f( pui ) = "long ptr" )
			#endif
		end sub
	end namespace

	namespace ulongint_ulong
		proc( ulongint ptr )
		proc( ulong ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "ulongint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pi ) = "ulong ptr" )
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace ulongint_longint
		proc( ulongint ptr )
		proc( longint ptr )

		sub test cdecl( )
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pi ) = "longint ptr" )
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#endif
		end sub
	end namespace

	namespace ulongint_integer
		proc( ulongint ptr )
		proc( integer ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
				CU_ASSERT( f( pll ) = "ulongint ptr" )
			#endif
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pui ) = "integer ptr" )
			#endif
		end sub
	end namespace

	namespace ulongint_uinteger
		proc( ulongint ptr )
		proc( uinteger ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace integer_long
		proc( integer ptr )
		proc( long ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			CU_ASSERT( f( pul ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		end sub
	end namespace

	namespace integer_ulong
		proc( integer ptr )
		proc( ulong ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pl ) = "ulong ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "integer ptr" )
			#else
				CU_ASSERT( f( pui ) = "ulong ptr" )
			#endif
		end sub
	end namespace

	namespace integer_longint
		proc( integer ptr )
		proc( longint ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			CU_ASSERT( f( pull ) = "longint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "integer ptr" )
		end sub
	end namespace

	namespace integer_ulongint
		proc( integer ptr )
		proc( ulongint ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "integer ptr" )
				CU_ASSERT( f( pll ) = "ulongint ptr" )
			#endif
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "integer ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pui ) = "ulongint ptr" )
			#else
				CU_ASSERT( f( pui ) = "integer ptr" )
			#endif
		end sub
	end namespace

	namespace integer_uinteger
		proc( integer ptr )
		proc( uinteger ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace uinteger_long
		proc( uinteger ptr )
		proc( long ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "long ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pul ) = "long ptr" )
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pul ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "long ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace uinteger_ulong
		proc( uinteger ptr )
		proc( ulong ptr )

		sub test cdecl( )
			CU_ASSERT( f( pl ) = "ulong ptr" )
			CU_ASSERT( f( pul ) = "ulong ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "uinteger ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace uinteger_longint
		proc( uinteger ptr )
		proc( longint ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "longint ptr" )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pull ) = "uinteger ptr" )
				CU_ASSERT( f( pi ) = "longint ptr" )
			#else
				CU_ASSERT( f( pull ) = "longint ptr" )
				CU_ASSERT( f( pi ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace uinteger_ulongint
		proc( uinteger ptr )
		proc( ulongint ptr )

		sub test cdecl( )
			#ifndef __FB_64BIT__
				CU_ASSERT( f( pl ) = "uinteger ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pll ) = "ulongint ptr" )
			CU_ASSERT( f( pull ) = "ulongint ptr" )
			CU_ASSERT( f( pi ) = "uinteger ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace

	namespace uinteger_integer
		proc( uinteger ptr )
		proc( integer ptr )

		sub test cdecl( )
			#ifdef __FB_64BIT__
				CU_ASSERT( f( pll ) = "integer ptr" )
				CU_ASSERT( f( pull ) = "uinteger ptr" )
			#else
				CU_ASSERT( f( pl ) = "integer ptr" )
				CU_ASSERT( f( pul ) = "uinteger ptr" )
			#endif
			CU_ASSERT( f( pi ) = "integer ptr" )
			CU_ASSERT( f( pui ) = "uinteger ptr" )
		end sub
	end namespace
end namespace

namespace const0
	'' It's possible to pass constant zero to pointer parameters

	sub a overload( byval p as any ptr ) :            : end sub
	sub a overload( byref s as string  ) : CU_FAIL( ) : end sub

	#macro makeFunction1( suffix, inttype )
		function f1_##suffix overload( byval p as any ptr ) as string : function = "any ptr" : end function
		function f1_##suffix overload( byval i as inttype ) as string : function = #inttype  : end function
	#endmacro

	makeFunction1( b, byte )
	makeFunction1( ub, ubyte )
	makeFunction1( sh, short )
	makeFunction1( ush, ushort )
	makeFunction1( l, long )
	makeFunction1( ul, ulong )
	makeFunction1( ll, longint )
	makeFunction1( ull, ulongint )
	makeFunction1( i, integer )
	makeFunction1( ui, uinteger )

	private sub test cdecl( )
		a( cptr( any ptr, 0 ) )
		a( 0 )
		a( cint( 0 ) )
		a( cuint( 0 ) )
		#ifdef __FB_64BIT__
			a( 0ll )
			a( 0ull )
			a( clngint( 0 ) )
			a( culngint( 0 ) )
		#else
			a( 0l )
			a( 0ul )
			a( clng( 0 ) )
			a( culng( 0 ) )
		#endif

		#macro makeTest1( suffix, result )
			CU_ASSERT( f1_##suffix( cptr( any ptr, 0 ) ) = "any ptr" )
			CU_ASSERT( f1_##suffix( cbyte  ( 0 ) ) = #result )
			CU_ASSERT( f1_##suffix( cubyte ( 0 ) ) = #result )
			CU_ASSERT( f1_##suffix( cshort ( 0 ) ) = #result )
			CU_ASSERT( f1_##suffix( cushort( 0 ) ) = #result )
			CU_ASSERT( f1_##suffix( 0l   ) = #result )
			CU_ASSERT( f1_##suffix( 0ul  ) = #result )
			CU_ASSERT( f1_##suffix( 0ll  ) = #result )
			CU_ASSERT( f1_##suffix( 0ull ) = #result )
			CU_ASSERT( f1_##suffix( 0    ) = #result )
			CU_ASSERT( f1_##suffix( 0u   ) = #result )
		#endmacro

		makeTest1( b, byte )
		makeTest1( ub, ubyte )
		makeTest1( sh, short )
		makeTest1( ush, ushort )
		makeTest1( l, long )
		makeTest1( ul, ulong )
		makeTest1( ll, longint )
		makeTest1( ull, ulongint )
		makeTest1( i, integer )
		makeTest1( ui, uinteger )
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
	fbcu.add_test( "integerPointers.long_ulong"       , @integerPointers.long_ulong.test )
	fbcu.add_test( "integerPointers.long_longint"     , @integerPointers.long_longint.test )
	fbcu.add_test( "integerPointers.long_ulongint"    , @integerPointers.long_ulongint.test )
	fbcu.add_test( "integerPointers.long_integer"     , @integerPointers.long_integer.test )
	fbcu.add_test( "integerPointers.long_uinteger"    , @integerPointers.long_uinteger.test )
	fbcu.add_test( "integerPointers.ulong_long"       , @integerPointers.ulong_long.test )
	fbcu.add_test( "integerPointers.ulong_longint"    , @integerPointers.ulong_longint.test )
	fbcu.add_test( "integerPointers.ulong_ulongint"   , @integerPointers.ulong_ulongint.test )
	fbcu.add_test( "integerPointers.ulong_integer"    , @integerPointers.ulong_integer.test )
	fbcu.add_test( "integerPointers.ulong_uinteger"   , @integerPointers.ulong_uinteger.test )
	fbcu.add_test( "integerPointers.longint_long"     , @integerPointers.longint_long.test )
	fbcu.add_test( "integerPointers.longint_ulong"    , @integerPointers.longint_ulong.test )
	fbcu.add_test( "integerPointers.longint_ulongint" , @integerPointers.longint_ulongint.test )
	fbcu.add_test( "integerPointers.longint_integer"  , @integerPointers.longint_integer.test )
	fbcu.add_test( "integerPointers.longint_uinteger" , @integerPointers.longint_uinteger.test )
	fbcu.add_test( "integerPointers.ulongint_long"    , @integerPointers.ulongint_long.test )
	fbcu.add_test( "integerPointers.ulongint_ulong"   , @integerPointers.ulongint_ulong.test )
	fbcu.add_test( "integerPointers.ulongint_longint" , @integerPointers.ulongint_longint.test )
	fbcu.add_test( "integerPointers.ulongint_integer" , @integerPointers.ulongint_integer.test )
	fbcu.add_test( "integerPointers.ulongint_uinteger", @integerPointers.ulongint_uinteger.test )
	fbcu.add_test( "integerPointers.integer_long"     , @integerPointers.integer_long.test )
	fbcu.add_test( "integerPointers.integer_ulong"    , @integerPointers.integer_ulong.test )
	fbcu.add_test( "integerPointers.integer_longint"  , @integerPointers.integer_longint.test )
	fbcu.add_test( "integerPointers.integer_ulongint" , @integerPointers.integer_ulongint.test )
	fbcu.add_test( "integerPointers.integer_uinteger" , @integerPointers.integer_uinteger.test )
	fbcu.add_test( "integerPointers.uinteger_long"    , @integerPointers.uinteger_long.test )
	fbcu.add_test( "integerPointers.uinteger_ulong"   , @integerPointers.uinteger_ulong.test )
	fbcu.add_test( "integerPointers.uinteger_longint" , @integerPointers.uinteger_longint.test )
	fbcu.add_test( "integerPointers.uinteger_ulongint", @integerPointers.uinteger_ulongint.test )
	fbcu.add_test( "integerPointers.uinteger_integer" , @integerPointers.uinteger_integer.test )

	fbcu.add_test( "const0", @const0.test )
end sub

end namespace
