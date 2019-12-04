#include "fbcunit.bi"

SUITE( fbc_tests.quirk.len_sizeof )

	#if defined( __FB_WIN32__ )
	CONST WCHAR_SIZE = 2
	#elseif defined( __FB_DOS__ ) or defined( __FB_ANDROID__ )
	CONST WCHAR_SIZE = 1
	#else
	CONST WCHAR_SIZE = 4
	#endif


	TEST( lenString )
		dim as string s = "123"
		dim as string ptr p = @s

		'' len() on string expressions should be strlen() and not sizeof(string)
		CU_ASSERT( len( s ) = 3 )

		CU_ASSERT( len( s + s ) = 6 )
		CU_ASSERT( len( s & s ) = 6 )
		CU_ASSERT( len( *p    ) = 3 )
		CU_ASSERT( len( p[0]  ) = 3 )

		CU_ASSERT( len( "123" ) = 3 )

		CU_ASSERT( len( string( 3, "a" ) ) = 3 )  '' Relies on disambiguation from len(string) via the '(' in 'string('
		CU_ASSERT( len( (string( 3, "a" )) ) = 3 ) '' Not ambiguous

		'' FIXSTRs are somewhat of an exception though,
		'' len() returns the sizeof()-1 (-1 for the implicit null terminator),
		'' i.e. the N from STRING * N, not the length of the stored string data.
		dim fstr as string * 31
		CU_ASSERT(    len( fstr ) = 31 )
		CU_ASSERT( sizeof( fstr ) = 32 )

		const STRCONST = "12345"
		CU_ASSERT(    len( STRCONST ) = 5 )
		CU_ASSERT( sizeof( STRCONST ) = 6 )

		CU_ASSERT(    len( "123456" ) = 6 )
		CU_ASSERT( sizeof( "123456" ) = 7 )

		const WSTRCONST = wstr( "123" )
		CU_ASSERT(    len( WSTRCONST ) = 3 )
		CU_ASSERT( sizeof( WSTRCONST ) = 4 * sizeof( wstring ) )

		CU_ASSERT(    len( wstr( "1234567" ) ) = 7 )
		CU_ASSERT( sizeof( wstr( "1234567" ) ) = 8 * sizeof( wstring ) )

		type UDT
			zstr as zstring * len( STRCONST ) + 1
			fstr as  string * len( STRCONST )
		end type

		dim x as UDT
		CU_ASSERT( sizeof( x.zstr ) = len( STRCONST ) + 1 )
		CU_ASSERT(    len( x.fstr ) = len( STRCONST )     )
	END_TEST

	namespace ns
		type T
			as integer a, b, c, d
		end type
		dim shared as integer a
	end namespace

	'' sizeof(expression)
	TEST( sizeofExpression )
		type a
			as integer a, b, c, d
		end type
		type b as a
		type p as a
		type x as a

		dim as integer a, b
		dim as integer ptr p = @a
		dim as integer x(0 to 0)
		dim as a aa
		dim as a ptr pa = @aa

		'' This tests len/sizeof's type/expression disambiguation, it needs to
		'' do a lookahead and check for following operators.

		CU_ASSERT(   len(a + b) = sizeof(integer))
		CU_ASSERT(sizeof(a + b) = sizeof(integer))

		CU_ASSERT(   len(a - b) = sizeof(integer))
		CU_ASSERT(sizeof(a - b) = sizeof(integer))

		''CU_ASSERT(   len(a * b) = sizeof(integer)) '' This is treated as type to support len(string * N)
		''CU_ASSERT(sizeof(a * b) = sizeof(integer))

		CU_ASSERT(   len(a / b) = sizeof(double)) '' (returns a double)
		CU_ASSERT(sizeof(a / b) = sizeof(double))

		CU_ASSERT(   len(a \ b) = sizeof(integer))
		CU_ASSERT(sizeof(a \ b) = sizeof(integer))

		CU_ASSERT(   len(a ^ b) = sizeof(double)) '' (returns a double)
		CU_ASSERT(sizeof(a ^ b) = sizeof(double))

		CU_ASSERT(   len(a mod b) = sizeof(integer))
		CU_ASSERT(sizeof(a mod b) = sizeof(integer))

		CU_ASSERT(   len(not a) = sizeof(integer))
		CU_ASSERT(sizeof(not a) = sizeof(integer))

		CU_ASSERT(   len(-a) = sizeof(integer))
		CU_ASSERT(sizeof(-a) = sizeof(integer))

		CU_ASSERT(   len(a shl b) = sizeof(integer))
		CU_ASSERT(sizeof(a shl b) = sizeof(integer))

		CU_ASSERT(   len(a shr b) = sizeof(integer))
		CU_ASSERT(sizeof(a shr b) = sizeof(integer))

		CU_ASSERT(   len(a and b) = sizeof(integer))
		CU_ASSERT(sizeof(a and b) = sizeof(integer))

		CU_ASSERT(   len(a eqv b) = sizeof(integer))
		CU_ASSERT(sizeof(a eqv b) = sizeof(integer))

		CU_ASSERT(   len(a imp b) = sizeof(integer))
		CU_ASSERT(sizeof(a imp b) = sizeof(integer))

		CU_ASSERT(   len(a or b) = sizeof(integer))
		CU_ASSERT(sizeof(a or b) = sizeof(integer))

		CU_ASSERT(   len(a xor b) = sizeof(integer))
		CU_ASSERT(sizeof(a xor b) = sizeof(integer))

		CU_ASSERT(   len(a = b) = sizeof(integer))
		CU_ASSERT(sizeof(a = b) = sizeof(integer))

		CU_ASSERT(   len(a <> b) = sizeof(integer))
		CU_ASSERT(sizeof(a <> b) = sizeof(integer))

		''CU_ASSERT(   len(a < b) = sizeof(integer)) '' This is treated as type to support len(integer<n>)
		''CU_ASSERT(sizeof(a < b) = sizeof(integer))

		CU_ASSERT(   len(a <= b) = sizeof(integer))
		CU_ASSERT(sizeof(a <= b) = sizeof(integer))

		CU_ASSERT(   len(a >= b) = sizeof(integer))
		CU_ASSERT(sizeof(a >= b) = sizeof(integer))

		CU_ASSERT(   len(a > b) = sizeof(integer))
		CU_ASSERT(sizeof(a > b) = sizeof(integer))

		CU_ASSERT(   len(a andalso b) = sizeof(integer))
		CU_ASSERT(sizeof(a andalso b) = sizeof(integer))

		CU_ASSERT(   len(a orelse b) = sizeof(integer))
		CU_ASSERT(sizeof(a orelse b) = sizeof(integer))

		CU_ASSERT(   len(x(0)) = sizeof(integer))
		CU_ASSERT(sizeof(x(0)) = sizeof(integer))

		CU_ASSERT(   len(p[0]) = sizeof(integer))
		CU_ASSERT(sizeof(p[0]) = sizeof(integer))

		CU_ASSERT(   len(aa.a) = sizeof(integer)) '' Plain field access
		CU_ASSERT(sizeof(aa.a) = sizeof(integer))

		CU_ASSERT(   len(pa->a) = sizeof(integer))
		CU_ASSERT(sizeof(pa->a) = sizeof(integer))

		CU_ASSERT(   len(ns.a) = sizeof(integer)) '' Variable from namespace
		CU_ASSERT(sizeof(ns.a) = sizeof(integer))

		/'
		'' Treated as len(bb) because bb is a type, even though there is a
		'' '.' coming, to allow accessing namespaced types
		type as a bb
		dim as bb bb
		CU_ASSERT(   len(bb.a) = sizeof(integer))
		CU_ASSERT(sizeof(bb.a) = sizeof(integer))
		'/

		dim as string sa = "a", sbb = "bb"
		dim fstr as string * 31 = "a"
		dim z as zstring * 32 = "abc"
		dim w as wstring * 32 = "abcde"
		dim psa as string ptr = @sa
		dim pz as zstring ptr = @z
		dim pw as wstring ptr = @w

		CU_ASSERT( sizeof( sa + sbb ) = sizeof( string ) )
		CU_ASSERT(    len( sa + sbb ) = 3 )
		CU_ASSERT( sizeof( fstr ) = 32 )
		CU_ASSERT(    len( fstr ) = 31 )
		CU_ASSERT( sizeof( *psa ) = sizeof( string ) )
		CU_ASSERT(    len( *psa ) = 1 )
		CU_ASSERT( sizeof( *pz )  = sizeof( zstring ) )
		CU_ASSERT(    len( *pz )  = 3 )  '' "abc"
		CU_ASSERT( sizeof( *pw )  = sizeof( wstring ) )
		CU_ASSERT(    len( *pw )  = 5 )  '' "abcde"
	END_TEST

	'' sizeof(var)
	TEST( sizeofVar )
		dim b   as byte
		dim ub  as ubyte
		dim sh  as short
		dim ush as short
		dim i   as integer
		dim ui  as uinteger
		dim l   as long
		dim ul  as ulong
		dim ll  as longint
		dim ull as ulongint

		CU_ASSERT( sizeof( b ) = 1 )
		CU_ASSERT( sizeof( ub ) = 1 )

		dim f   as single
		dim d   as double

		dim s   as string
		dim fixstr31 as string * 31
		dim z32   as zstring * 32
		dim w32   as wstring * 32

		type UDT2 field = 1
			i as integer
			b as byte
		end type

		dim x1 as ns.T
		dim x2 as UDT2

		dim p   as any ptr
		dim pi  as integer ptr
		dim px1 as ns.T ptr

		CU_ASSERT(    len(   b ) = 1 )
		CU_ASSERT( sizeof(   b ) = 1 )
		CU_ASSERT(    len(  ub ) = 1 )
		CU_ASSERT( sizeof(  ub ) = 1 )
		CU_ASSERT(    len(  sh ) = 2 )
		CU_ASSERT( sizeof(  sh ) = 2 )
		CU_ASSERT(    len( ush ) = 2 )
		CU_ASSERT( sizeof( ush ) = 2 )
	#ifdef __FB_64BIT__
		CU_ASSERT(    len(   i ) = 8 )
		CU_ASSERT( sizeof(   i ) = 8 )
		CU_ASSERT(    len(  ui ) = 8 )
		CU_ASSERT( sizeof(  ui ) = 8 )
	#else
		CU_ASSERT(    len(   i ) = 4 )
		CU_ASSERT( sizeof(   i ) = 4 )
		CU_ASSERT(    len(  ui ) = 4 )
		CU_ASSERT( sizeof(  ui ) = 4 )
	#endif
		CU_ASSERT(    len(   l ) = 4 )
		CU_ASSERT( sizeof(   l ) = 4 )
		CU_ASSERT(    len(  ul ) = 4 )
		CU_ASSERT( sizeof(  ul ) = 4 )
		CU_ASSERT(    len(  ll ) = 8 )
		CU_ASSERT( sizeof(  ll ) = 8 )
		CU_ASSERT(    len( ull ) = 8 )
		CU_ASSERT( sizeof( ull ) = 8 )

		CU_ASSERT(    len( f ) = 4 )
		CU_ASSERT( sizeof( f ) = 4 )
		CU_ASSERT(    len( d ) = 8 )
		CU_ASSERT( sizeof( d ) = 8 )

	#ifdef __FB_64BIT__
		CU_ASSERT(    len( p ) = 8 )
		CU_ASSERT( sizeof( p ) = 8 )
		CU_ASSERT(    len( pi ) = 8 )
		CU_ASSERT( sizeof( pi ) = 8 )
		CU_ASSERT(    len( px1 ) = 8 )
		CU_ASSERT( sizeof( px1 ) = 8 )
	#else
		CU_ASSERT(    len( p ) = 4 )
		CU_ASSERT( sizeof( p ) = 4 )
		CU_ASSERT(    len( pi ) = 4 )
		CU_ASSERT( sizeof( pi ) = 4 )
		CU_ASSERT(    len( px1 ) = 4 )
		CU_ASSERT( sizeof( px1 ) = 4 )
	#endif

		CU_ASSERT( sizeof( "" ) = 1 )
		CU_ASSERT( sizeof( wstr( "" ) ) = sizeof( wstring ) )
		CU_ASSERT( sizeof( "test" ) = 5 )
		CU_ASSERT( sizeof( wstr( "test" ) ) = 5 * sizeof( wstring ) )
		CU_ASSERT( sizeof( s ) = sizeof( string ) )
		CU_ASSERT( sizeof( fixstr31 ) = 32 ) '' 31 + implicit null terminator
		CU_ASSERT( sizeof( z32 ) = 32 )
		CU_ASSERT( sizeof( w32 ) = 32 * sizeof( wstring ) )

		CU_ASSERT( sizeof( wstr( "" ) ) = WCHAR_SIZE )
		CU_ASSERT( sizeof( wstr( "test" ) ) = 5 * WCHAR_SIZE )
		CU_ASSERT( sizeof( w32 ) = 32 * WCHAR_SIZE )

		CU_ASSERT(    len( x1 ) = sizeof( integer ) * 4 )
		CU_ASSERT( sizeof( x1 ) = sizeof( integer ) * 4 )
		CU_ASSERT(    len( x2 ) = sizeof( integer ) + 1 )
		CU_ASSERT( sizeof( x2 ) = sizeof( integer ) + 1 )
	END_TEST

	'' sizeof(type)
	TEST( sizeofType )
		CU_ASSERT(    len(  byte ) = 1 )
		CU_ASSERT( sizeof(  byte ) = 1 )
		CU_ASSERT(    len( ubyte ) = 1 )
		CU_ASSERT( sizeof( ubyte ) = 1 )
		CU_ASSERT(    len(  short ) = 2 )
		CU_ASSERT( sizeof(  short ) = 2 )
		CU_ASSERT(    len( ushort ) = 2 )
		CU_ASSERT( sizeof( ushort ) = 2 )
	#ifdef __FB_64BIT__
		CU_ASSERT(    len(  integer ) = 8 )
		CU_ASSERT( sizeof(  integer ) = 8 )
		CU_ASSERT(    len( uinteger ) = 8 )
		CU_ASSERT( sizeof( uinteger ) = 8 )
	#else
		CU_ASSERT(    len(  integer ) = 4 )
		CU_ASSERT( sizeof(  integer ) = 4 )
		CU_ASSERT(    len( uinteger ) = 4 )
		CU_ASSERT( sizeof( uinteger ) = 4 )
	#endif
		CU_ASSERT(    len(  long ) = 4 )
		CU_ASSERT( sizeof(  long ) = 4 )
		CU_ASSERT(    len( ulong ) = 4 )
		CU_ASSERT( sizeof( ulong ) = 4 )
		CU_ASSERT(    len(  longint ) = 8 )
		CU_ASSERT( sizeof(  longint ) = 8 )
		CU_ASSERT(    len( ulongint ) = 8 )
		CU_ASSERT( sizeof( ulongint ) = 8 )

		CU_ASSERT(    len( single ) = 4 )
		CU_ASSERT( sizeof( single ) = 4 )
		CU_ASSERT(    len( double ) = 8 )
		CU_ASSERT( sizeof( double ) = 8 )

	#ifdef __FB_64BIT__
		CU_ASSERT(    len( any ptr ) = 8 )
		CU_ASSERT( sizeof( any ptr ) = 8 )
	#else
		CU_ASSERT(    len( any ptr ) = 4 )
		CU_ASSERT( sizeof( any ptr ) = 4 )
	#endif
		CU_ASSERT(    len( integer ptr ) = sizeof( any ptr ) )

	#ifdef __FB_64BIT__
		CU_ASSERT(    len( string ) = 24 )
		CU_ASSERT( sizeof( string ) = 24 )
	#else
		CU_ASSERT(    len( string ) = 12 )
		CU_ASSERT( sizeof( string ) = 12 )
	#endif
		CU_ASSERT(    len( string * 5 ) = 5 + 1 ) '' + the implicit null terminator
		CU_ASSERT( sizeof( string * 5 ) = 5 + 1 )
		CU_ASSERT(    len( zstring ) = 1 )
		CU_ASSERT( sizeof( zstring ) = 1 )
		CU_ASSERT(    len( zstring * 5 ) = 5 )
		CU_ASSERT( sizeof( zstring * 5 ) = 5 )
		CU_ASSERT(    len( wstring * 5 ) = 5 * sizeof( wstring ) )
		CU_ASSERT( sizeof( wstring * 5 ) = 5 * sizeof( wstring ) )

		CU_ASSERT(    len( wstring ) = WCHAR_SIZE )
		CU_ASSERT( sizeof( wstring ) = WCHAR_SIZE )
		CU_ASSERT(    len( wstring * 5 ) = 5 * WCHAR_SIZE )
		CU_ASSERT( sizeof( wstring * 5 ) = 5 * WCHAR_SIZE )

		type a
			as integer a, b, c, d
		end type
		dim as integer a

		type T as a

		type UDT2 field = 1
			i as integer
			b as byte
		end type

		CU_ASSERT(    len( T ) = sizeof( integer ) * 4 )
		CU_ASSERT( sizeof( T ) = sizeof( integer ) * 4 )
		CU_ASSERT(    len( a ) = sizeof( integer ) * 4 )
		CU_ASSERT( sizeof( a ) = sizeof( integer ) * 4 )
		CU_ASSERT(    len( ns.T ) = sizeof( integer ) * 4 )
		CU_ASSERT( sizeof( ns.T ) = sizeof( integer ) * 4 )
		CU_ASSERT(    len( UDT2 ) = sizeof( integer ) + 1 )
		CU_ASSERT( sizeof( UDT2 ) = sizeof( integer ) + 1 )
	END_TEST

	'' sizeof(type) vs. len(string)
	TEST( sizeofTypeVsLenString )
		'' len() does not prefer string over type if both have the same name.
		'' (Perhaps one day this should be changed for -lang fb at least,
		'' since we do have sizeof())

		type s1
			as integer a, b, c, d
		end type
		dim as string s1 = "123"
		CU_ASSERT(   len(s1) = sizeof(integer) * 4)
		CU_ASSERT(sizeof(s1) = sizeof(integer) * 4)
		CU_ASSERT(   len(s1 + s1) = 6)

		'' ---

		dim as string s2 = "123"
		type s2
			as integer a, b, c, d
		end type
		CU_ASSERT(   len(s2) = sizeof(integer) * 4)
		CU_ASSERT(sizeof(s2) = sizeof(integer) * 4)
		CU_ASSERT(   len(s2 + s2) = 6)

		'' ---

		dim as string s3 = "123"
		scope
			type s3
				as integer a, b, c, d
			end type
			CU_ASSERT(   len(s3) = sizeof(integer) * 4)
			CU_ASSERT(sizeof(s3) = sizeof(integer) * 4)
			CU_ASSERT(   len(s3 + s3) = 6)
		end scope

		'' ---

		type s4
			as integer a, b, c, d
		end type
		scope
			dim as string s4 = "123"
			CU_ASSERT(   len(s4) = sizeof(integer) * 4)
			CU_ASSERT(sizeof(s4) = sizeof(integer) * 4)
			CU_ASSERT(   len(s4 + s4) = 6)
		end scope
	END_TEST

	TEST_GROUP( lenUdtWithCastOverloads )
		type UDT1
			dummy as integer
			declare operator cast() as integer
		end type

		operator UDT1.cast() as integer
			return 123
		end operator

		type UDT2
			pz as zstring ptr
			dummy as integer
			declare operator cast() byref as zstring
		end type

		operator UDT2.cast() byref as zstring
			return *pz
		end operator

		TEST( default )
			scope
				dim x as UDT1
				CU_ASSERT( len( x ) = sizeof( x ) )
				CU_ASSERT( len( x ) = sizeof( UDT1 ) )
				CU_ASSERT( len( x ) = sizeof( integer ) )
				CU_ASSERT( len( UDT1 ) = sizeof( x ) )
				CU_ASSERT( len( UDT1 ) = sizeof( UDT1 ) )
				CU_ASSERT( len( UDT1 ) = sizeof( integer ) )
			end scope

			scope
				dim x as UDT2 = ( @"FreeBASIC" )
				CU_ASSERT( (*x.pz)[0] = asc( "F" ) )
				CU_ASSERT( len( *x.pz ) = 9 )
				CU_ASSERT( sizeof( *x.pz ) = sizeof( zstring ) )
				CU_ASSERT( len( x ) = sizeof( x ) )
				CU_ASSERT( len( x ) = sizeof( UDT2 ) )
				CU_ASSERT( len( x ) = sizeof( zstring ptr ) + sizeof( integer ) )
				CU_ASSERT( len( UDT2 ) = sizeof( x ) )
				CU_ASSERT( len( UDT2 ) = sizeof( UDT2 ) )
				CU_ASSERT( len( UDT2 ) = sizeof( zstring ptr ) + sizeof( integer ) )
			end scope
		END_TEST
	END_TEST_GROUP

	namespace ns1
		type T
			as integer a, b, c, d
		end type
		dim shared as integer a
		const b as integer = 0
		const s as string = "12345"
		enum e1
			e11, e12, e13
		end enum

		namespace ns2
			type T
				as integer a, b, c, d
			end type
			dim shared as integer a
			const b as integer = 0
			const s as string = "12345"
			enum e2
				e21, e22, e23
			end enum
		end namespace
	end namespace

	'' sizeof(type|expression)
	TEST( sizeofTypeOrExpression )
		'' This tests len/sizeof's type/expression disambiguation, where
		'' namespace prefix is given

		'' direct use of namespace
		
		CU_ASSERT(   len(ns1.T) = sizeof(ns1.T))
		CU_ASSERT(sizeof(ns1.T) = sizeof(integer)*4)

		CU_ASSERT(   len(ns1.a) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.a) = sizeof(integer))

		CU_ASSERT(   len(ns1.b) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.b) = sizeof(integer))

		CU_ASSERT(   len(ns1.s) =  len("hello"))
		CU_ASSERT(sizeof(ns1.s) = (len("hello")+1))

		CU_ASSERT(   len(ns1.e1.e11) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.e1.e11) = sizeof(integer))

		'' direct use of nested namespace

		CU_ASSERT(   len(ns1.ns2.T) = sizeof(ns1.ns2.T))
		CU_ASSERT(sizeof(ns1.ns2.T) = sizeof(integer)*4)

		CU_ASSERT(   len(ns1.ns2.a) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.ns2.a) = sizeof(integer))

		CU_ASSERT(   len(ns1.ns2.b) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.ns2.b) = sizeof(integer))

		CU_ASSERT(   len(ns1.ns2.s) =  len("hello"))
		CU_ASSERT(sizeof(ns1.ns2.s) = (len("hello")+1))

		CU_ASSERT(   len(ns1.ns2.e2.e21) = sizeof(integer))
		CU_ASSERT(sizeof(ns1.ns2.e2.e21) = sizeof(integer))

		'' import top-level namespace

		using ns1

		CU_ASSERT(   len(T) = sizeof(T))
		CU_ASSERT(sizeof(T) = sizeof(integer)*4)

		CU_ASSERT(   len(a) = sizeof(integer))
		CU_ASSERT(sizeof(a) = sizeof(integer))

		CU_ASSERT(   len(b) = sizeof(integer))
		CU_ASSERT(sizeof(b) = sizeof(integer))

		CU_ASSERT(   len(s) =  len("hello"))
		CU_ASSERT(sizeof(s) = (len("hello")+1))

		CU_ASSERT(   len(e1.e11) = sizeof(integer))
		CU_ASSERT(sizeof(e1.e11) = sizeof(integer))

		CU_ASSERT(   len(e11) = sizeof(integer))
		CU_ASSERT(sizeof(e11) = sizeof(integer))

		'' nested namespace

		CU_ASSERT(   len(ns2.T) = sizeof(ns2.T))
		CU_ASSERT(sizeof(ns2.T) = sizeof(integer)*4)

		CU_ASSERT(   len(ns2.a) = sizeof(integer))
		CU_ASSERT(sizeof(ns2.a) = sizeof(integer))

		CU_ASSERT(   len(ns2.b) = sizeof(integer))
		CU_ASSERT(sizeof(ns2.b) = sizeof(integer))

		CU_ASSERT(   len(ns2.s) =  len("hello"))
		CU_ASSERT(sizeof(ns2.s) = (len("hello")+1))

		CU_ASSERT(   len(ns2.e2.e21) = sizeof(integer))
		CU_ASSERT(sizeof(ns2.e2.e21) = sizeof(integer))

	END_TEST

END_SUITE
