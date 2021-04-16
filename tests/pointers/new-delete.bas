#include "fbcunit.bi"

#define NULL 0
      
SUITE( fbc_tests.pointers.new_delete )

	'' default initialization
	TEST_GROUP( defaultInit )
		dim shared as integer ctorudt_ctors
		type CtorUdt
			i as integer
			declare constructor( )
		end type
		constructor CtorUdt( )
			ctorudt_ctors += 1
		end constructor

		dim shared as integer dtorudt_dtors
		type DtorUdt
			i as integer
			declare destructor( )
		end type
		destructor DtorUdt( )
			dtorudt_dtors += 1
		end destructor

		dim shared as integer ctordtorudt_ctors, ctordtorudt_dtors
		type CtorDtorUdt
			i as integer
			declare constructor( )
			declare destructor( )
		end type
		constructor CtorDtorUdt( )
			ctordtorudt_ctors += 1
		end constructor
		destructor CtorDtorUdt( )
			ctordtorudt_dtors += 1
		end destructor

		TEST( default )
			#macro check( T )
				scope
					var p = new T
					#assert( typeof( p ) = typeof( T ptr ) )
					CU_ASSERT( *p = 0 )
					delete p
				end scope
			#endmacro

			check(  byte )
			check( ubyte )
			check(  short )
			check( ushort )
			check(  long )
			check( ulong )
			check(  longint )
			check( ulongint )
			check(  integer )
			check( uinteger )
			check( single )
			check( double )

			scope
				var p = new string
				#assert( typeof( p ) = typeof( string ptr ) )
				CU_ASSERT( len( *p ) = 0 )
				CU_ASSERT( *p = "" )
				delete p
			end scope

			scope
				var p = new string
				#assert( typeof( p ) = typeof( string ptr ) )
				CU_ASSERT( len( *p ) = 0 )
				CU_ASSERT( *p = "" )
				*p = "abcdef"
				CU_ASSERT( len( *p ) = 6 )
				CU_ASSERT( *p = "abcdef" )
				delete p
			end scope

			scope
				CU_ASSERT( ctorudt_ctors = 0 )
				var p = new CtorUdt
				#assert( typeof( p ) = typeof( CtorUdt ptr ) )
				CU_ASSERT( ctorudt_ctors = 1 )
				CU_ASSERT( p->i = 0 )
				delete p
			end scope
			CU_ASSERT( ctorudt_ctors = 1 )

			scope
				CU_ASSERT( dtorudt_dtors = 0 )
				var p = new DtorUdt
				#assert( typeof( p ) = typeof( DtorUdt ptr ) )
				CU_ASSERT( dtorudt_dtors = 0 )
				CU_ASSERT( p->i = 0 )
				delete p
				CU_ASSERT( dtorudt_dtors = 1 )
			end scope
			CU_ASSERT( dtorudt_dtors = 1 )

			scope
				CU_ASSERT( ctordtorudt_ctors = 0 )
				CU_ASSERT( ctordtorudt_dtors = 0 )
				var p = new CtorDtorUdt
				#assert( typeof( p ) = typeof( CtorDtorUdt ptr ) )
				CU_ASSERT( ctordtorudt_ctors = 1 )
				CU_ASSERT( ctordtorudt_dtors = 0 )
				CU_ASSERT( p->i = 0 )
				delete p
				CU_ASSERT( ctordtorudt_ctors = 1 )
				CU_ASSERT( ctordtorudt_dtors = 1 )
			end scope
			CU_ASSERT( ctordtorudt_ctors = 1 )
			CU_ASSERT( ctordtorudt_dtors = 1 )
		END_TEST
	END_TEST_GROUP

	'' New with int/float initializer
	TEST( newIntFloatInit )
		#macro check( T, N )
			scope
				var p = new T( N )
				CU_ASSERT( *p = N )
				delete p
			end scope
		#endmacro

		check( byte, cbyte( 0 ) )
		check( byte, cbyte( -128 ) )
		check( byte, cbyte( 127 ) )
		check( ubyte, cubyte( 0 ) )
		check( ubyte, cubyte( 255 ) )
		check( short, cbyte( 0 ) )
		check( short, cshort( -32768 ) )
		check( short, cshort( 32767 ) )
		check( short, -15 )
		check( ushort, cushort( 0 ) )
		check( ushort, cushort( 65535 ) )
		check( long, 0l )
		check( long, &h80000000l )
		check( long, &h7FFFFFFFl )
		check( ulong, 0ul )
		check( ulong, &hFFFFFFFFul )
		check( longint, 0ll )
		check( longint, &h8000000000000000ll )
		check( longint, &h7FFFFFFFFFFFFFFFll )
		check( ulongint, 0ull )
		check( ulongint, &hFFFFFFFFFFFFFFFFull )

		check( integer, 0 )
		check( integer, &h80000000 )
		check( integer, &h7FFFFFFF )
		check( integer, 5 )
		check( uinteger, 0u )
		check( uinteger, &hFFFFFFFFu )
	#ifdef __FB_64BIT__
		check( integer, 0ll )
		check( integer, &h8000000000000000ll )
		check( integer, &h7FFFFFFFFFFFFFFFll )
		check( uinteger, 0ull )
		check( uinteger, &hFFFFFFFFFFFFFFFFull )
	#endif

		check( single, 0.0f )
		check( single, 2.5f )
		check( single, 2.5 )
		check( single, 1.0 )
		check( single, -1.0 )
		check( double, 0.0 )
		check( double, 0.5 )
		check( double, 1.0 )
		check( double, -1.0 )
	END_TEST

	'' New with string initializer
	TEST( newStringInit )
		scope
			var p = new string( "" )
			CU_ASSERT( len( *p ) = 0 )
			CU_ASSERT( *p = "" )
			delete p
		end scope

		scope
			var p = new string( "abc" )
			CU_ASSERT( len( *p ) = 3 )
			CU_ASSERT( *p = "abc" )
			delete p
		end scope

		scope
			var p = new string( string( 50, "." ) )
			CU_ASSERT( len( *p ) = 50 )
			CU_ASSERT( *p = string( 50, "." ) )
			delete p
		end scope

		scope
			var p = new string( "a" )
			CU_ASSERT( len( *p ) = 1 )
			CU_ASSERT( *p = "a" )
			*p = "abcdef"
			CU_ASSERT( len( *p ) = 6 )
			CU_ASSERT( *p = "abcdef" )
			delete p
		end scope
	END_TEST

	'' New with UDT initializer
	TEST( newUDTInit )
		type T1
			as integer a, b, c
			as single d
		end type

		type T2
			as byte a
			as short b
			as integer c
			as double d
		end type

		type T3
			as integer i
		end type

		type T4
			as single f
		end type

		scope
			var p = new T1( 1, 2, 3, 4 )

			CU_ASSERT( p->a = 1 )
			CU_ASSERT( p->b = 2 )
			CU_ASSERT( p->c = 3 )
			CU_ASSERT( p->d = 4 )

			delete p
		end scope

		scope
			dim as T1 x = ( 4, 5, 6, 7 )
			dim as T1 ptr p = new T1( x )

			CU_ASSERT( p->a = 4 )
			CU_ASSERT( p->b = 5 )
			CU_ASSERT( p->c = 6 )
			CU_ASSERT( p->d = 7 )

			delete p
		end scope

		scope
			dim as T1 ptr a = new T1( 1, 2, 3, 4 )
			dim as T1 ptr b = new T1( *a )

			CU_ASSERT( a->a = 1 )
			CU_ASSERT( a->b = 2 )
			CU_ASSERT( a->c = 3 )
			CU_ASSERT( a->d = 4 )

			CU_ASSERT( b->a = 1 )
			CU_ASSERT( b->b = 2 )
			CU_ASSERT( b->c = 3 )
			CU_ASSERT( b->d = 4 )

			delete b
			delete a
		end scope

		scope
			var p = new T2( 123, 12345, 123456789 )

			CU_ASSERT( p->a = 123 )
			CU_ASSERT( p->b = 12345 )
			CU_ASSERT( p->c = 123456789 )
			CU_ASSERT( p->d = 0.0 )

			delete p
		end scope

		scope
			dim as T3 x1 = ( 123 )
			dim as T4 x2 = ( 2.5 )

			var a = new T3( 123 )
			var b = new T3( *a )
			var c = new T4( 2.5 )
			var d = new T3( x1 )
			var e = new T4( x2 )
			var f = new T1( 1, 2, 3, 2.5 )

			CU_ASSERT( a->i = 123 )
			CU_ASSERT( b->i = 123 )
			CU_ASSERT( c->f = 2.5 )
			CU_ASSERT( d->i = 123 )
			CU_ASSERT( e->f = 2.5 )
			CU_ASSERT( f->a = 1 )
			CU_ASSERT( f->b = 2 )
			CU_ASSERT( f->c = 3 )
			CU_ASSERT( f->d = 2.5 )

			delete a
			delete b
			delete c
			delete d
			delete e
			delete f
		end scope
	END_TEST

	'' Some obscure NEW initializers
	TEST_GROUP( newQuirkInit )
		'' An UDT that fits in registers
		type T1
			as integer i
		end type

		'' A bigger UDT that must be put on stack
		type T2
			as integer a, b, c, d, e, f
		end type

		private function getT1( ) as T1
			function = type( 123 )
		end function

		private function getT2( ) as T2
			function = type( 1, 2, 3, 4, 5, 6 )
		end function

		private function getInteger( ) as integer
			function = 123
		end function

		private function getLongint( ) as longint
			function = 123ll
		end function

		private function getSingle( ) as single
			function = 2.5f
		end function

		private function getDouble( ) as double
			function = 2.5
		end function

		TEST( default )
			var a1 = new T1( getT1( ) )
			var b1 = new T1( type<T1>( 123 ) )
			var c1 = new T1( type( 123 ) )
			var a2 = new T2( getT2( ) )
			var b2 = new T2( type<T2>( 1, 2, 3, 4, 5, 6 ) )
			var c2 = new T2( type( 1 ) )  '' TODO: type( 1, 2, 3, 4, 5, 6 ) isn't working here!
			var d = new integer( getInteger( ) )
			var e = new longint( getLongint( ) )
			var f = new single( getSingle( ) )
			var g = new double( getDouble( ) )
			CU_ASSERT( a1->i = 123 )
			CU_ASSERT( b1->i = 123 )
			CU_ASSERT( c1->i = 123 )
			CU_ASSERT( a2->a = 1 )
			CU_ASSERT( a2->b = 2 )
			CU_ASSERT( a2->c = 3 )
			CU_ASSERT( a2->d = 4 )
			CU_ASSERT( a2->e = 5 )
			CU_ASSERT( a2->f = 6 )
			CU_ASSERT( b2->a = 1 )
			CU_ASSERT( b2->b = 2 )
			CU_ASSERT( b2->c = 3 )
			CU_ASSERT( b2->d = 4 )
			CU_ASSERT( b2->e = 5 )
			CU_ASSERT( b2->f = 6 )
			CU_ASSERT( c2->a = 1 )
			CU_ASSERT( c2->b = 0 )
			CU_ASSERT( c2->c = 0 )
			CU_ASSERT( c2->d = 0 )
			CU_ASSERT( c2->e = 0 )
			CU_ASSERT( c2->f = 0 )
			CU_ASSERT( *d = 123 )
			CU_ASSERT( *e = 123ll )
			CU_ASSERT( *f = 2.5f )
			CU_ASSERT( *g = 2.5 )
			delete a1
			delete b1
			delete c1
			delete a2
			delete b2
			delete c2
			delete d
			delete e
			delete f
			delete g
		END_TEST
	END_TEST_GROUP

	'' New[]
	TEST_GROUP( vectorNew )
		type T1
			as integer i
		end type

		dim shared as integer T2_ctor_count = 0
		dim shared as integer T2_ctor_count_x = 0
		type T2
			as integer i
			declare constructor( )
		end type
		constructor T2( )
			T2_ctor_count += 1
			T2_ctor_count_x += 1
		end constructor

		dim shared as integer T3_dtor_count = 0
		dim shared as integer T3_dtor_count_x = 0
		type T3
			as integer i
			declare destructor( )
		end type
		destructor T3( )
			T3_dtor_count += 1
			T3_dtor_count_x += 1
		end destructor

		dim shared as integer T4_ctor_count = 0, T4_dtor_count = 0
		dim shared as integer T4_ctor_count_x = 0, T4_dtor_count_x = 0
		type T4
			as integer i
			declare constructor( )
			declare destructor( )
		end type
		constructor T4( )
			T4_ctor_count += 1
			T4_ctor_count_x += 1
		end constructor
		destructor T4( )
			T4_dtor_count += 1
			T4_dtor_count_x += 1
		end destructor

		TEST( default )
			#macro check( T )
				scope
					var p = new T[10]
					#assert( typeof( p ) = typeof( T ptr ) )
					CU_ASSERT( p[0] = 0 )
					CU_ASSERT( p[1] = 0 )
					CU_ASSERT( p[2] = 0 )
					CU_ASSERT( p[3] = 0 )
					CU_ASSERT( p[4] = 0 )
					CU_ASSERT( p[5] = 0 )
					CU_ASSERT( p[6] = 0 )
					CU_ASSERT( p[7] = 0 )
					CU_ASSERT( p[8] = 0 )
					CU_ASSERT( p[9] = 0 )
					delete[] p
				end scope
			#endmacro

			check(  byte )
			check( ubyte )
			check(  short )
			check( ushort )
			check(  long )
			check( ulong )
			check(  longint )
			check( ulongint )
			check(  integer )
			check( uinteger )
			check( single )
			check( double )

			scope
				var p = new string[10]
				#assert( typeof( p ) = typeof( string ptr ) )

				CU_ASSERT( len( p[0] ) = 0 )
				CU_ASSERT( len( p[1] ) = 0 )
				CU_ASSERT( len( p[2] ) = 0 )
				CU_ASSERT( len( p[3] ) = 0 )
				CU_ASSERT( len( p[4] ) = 0 )
				CU_ASSERT( len( p[5] ) = 0 )
				CU_ASSERT( len( p[6] ) = 0 )
				CU_ASSERT( len( p[7] ) = 0 )
				CU_ASSERT( len( p[8] ) = 0 )
				CU_ASSERT( len( p[9] ) = 0 )

				CU_ASSERT( p[0] = "" )
				CU_ASSERT( p[1] = "" )
				CU_ASSERT( p[2] = "" )
				CU_ASSERT( p[3] = "" )
				CU_ASSERT( p[4] = "" )
				CU_ASSERT( p[5] = "" )
				CU_ASSERT( p[6] = "" )
				CU_ASSERT( p[7] = "" )
				CU_ASSERT( p[8] = "" )
				CU_ASSERT( p[9] = "" )

				delete[] p
			end scope

			scope
				var p = new string[10]
				#assert( typeof( p ) = typeof( string ptr ) )

				CU_ASSERT( len( p[0] ) = 0 )
				CU_ASSERT( len( p[1] ) = 0 )
				CU_ASSERT( len( p[2] ) = 0 )
				CU_ASSERT( len( p[3] ) = 0 )
				CU_ASSERT( len( p[4] ) = 0 )
				CU_ASSERT( len( p[5] ) = 0 )
				CU_ASSERT( len( p[6] ) = 0 )
				CU_ASSERT( len( p[7] ) = 0 )
				CU_ASSERT( len( p[8] ) = 0 )
				CU_ASSERT( len( p[9] ) = 0 )

				CU_ASSERT( p[0] = "" )
				CU_ASSERT( p[1] = "" )
				CU_ASSERT( p[2] = "" )
				CU_ASSERT( p[3] = "" )
				CU_ASSERT( p[4] = "" )
				CU_ASSERT( p[5] = "" )
				CU_ASSERT( p[6] = "" )
				CU_ASSERT( p[7] = "" )
				CU_ASSERT( p[8] = "" )
				CU_ASSERT( p[9] = "" )

				p[0] = "1"
				p[1] = "2"
				p[2] = "3"
				p[3] = "4"
				p[4] = "5"
				p[5] = "6"
				p[6] = "7"
				p[7] = "8"
				p[8] = "9"
				p[9] = "10"

				CU_ASSERT( len( p[0] ) = 1 )
				CU_ASSERT( len( p[1] ) = 1 )
				CU_ASSERT( len( p[2] ) = 1 )
				CU_ASSERT( len( p[3] ) = 1 )
				CU_ASSERT( len( p[4] ) = 1 )
				CU_ASSERT( len( p[5] ) = 1 )
				CU_ASSERT( len( p[6] ) = 1 )
				CU_ASSERT( len( p[7] ) = 1 )
				CU_ASSERT( len( p[8] ) = 1 )
				CU_ASSERT( len( p[9] ) = 2 )

				CU_ASSERT( p[0] = "1" )
				CU_ASSERT( p[1] = "2" )
				CU_ASSERT( p[2] = "3" )
				CU_ASSERT( p[3] = "4" )
				CU_ASSERT( p[4] = "5" )
				CU_ASSERT( p[5] = "6" )
				CU_ASSERT( p[6] = "7" )
				CU_ASSERT( p[7] = "8" )
				CU_ASSERT( p[8] = "9" )
				CU_ASSERT( p[9] = "10" )

				delete[] p
			end scope

			scope
				var p = new T1[0]
				CU_ASSERT( p <> NULL )
				delete[] p
			end scope

			scope
				var p = new T1[1]
				CU_ASSERT( p[0].i = 0 )
				delete[] p
			end scope

			scope
				var p = new T1[2]
				CU_ASSERT( p[0].i = 0 )
				CU_ASSERT( p[1].i = 0 )
				delete[] p
			end scope

			scope
				var p = new T1[3]
				CU_ASSERT( p[0].i = 0 )
				CU_ASSERT( p[1].i = 0 )
				CU_ASSERT( p[2].i = 0 )
				delete[] p
			end scope

			for n as integer = 0 to 2
				var p = new T1[n]
				CU_ASSERT( p <> NULL )
				delete[] p
			next

			'' new T2[N]
			CU_ASSERT( T2_ctor_count_x = 0 )
			scope
				CU_ASSERT( T2_ctor_count = 0 )
				var p = new T2[2]
				CU_ASSERT( T2_ctor_count = 2 )
				delete[] p
			end scope

			scope
				T2_ctor_count_x = 0
				var p = new T2[0]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T2_ctor_count_x = 0 )
				delete[] p
			end scope

			scope
				T2_ctor_count_x = 0
				var p = new T2[1]
				CU_ASSERT( T2_ctor_count_x = 1 )
				delete[] p
			end scope

			scope
				T2_ctor_count_x = 0
				var p = new T2[2]
				CU_ASSERT( T2_ctor_count_x = 2 )
				delete[] p
			end scope

			for n as integer = 0 to 2
				T2_ctor_count_x = 0
				var p = new T2[n]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T2_ctor_count_x = n )
				delete[] p
			next

			'' new T3[N]
			CU_ASSERT( T3_dtor_count_x = 0 )

			scope
				CU_ASSERT( T3_dtor_count = 0 )
				var p = new T3[2]
				CU_ASSERT( T3_dtor_count = 0 )
				delete[] p
				CU_ASSERT( T3_dtor_count = 2 )
			end scope

			scope
				T3_dtor_count_x = 0
				var p = new T3[0]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T3_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T3_dtor_count_x = 0 )
			end scope

			scope
				T3_dtor_count_x = 0
				var p = new T3[1]
				CU_ASSERT( T3_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T3_dtor_count_x = 1 )
			end scope

			scope
				T3_dtor_count_x = 0
				var p = new T3[2]
				CU_ASSERT( T3_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T3_dtor_count_x = 2 )
			end scope

			for n as integer = 0 to 2
				T3_dtor_count_x = 0
				var p = new T3[n]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T3_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T3_dtor_count_x = n )
			next

			'' new T4[N]
			CU_ASSERT( T4_ctor_count_x = 0 )

			scope
				CU_ASSERT( T4_ctor_count = 0 )
				CU_ASSERT( T4_dtor_count = 0 )
				var p = new T4[2]
				CU_ASSERT( T4_ctor_count = 2 )
				CU_ASSERT( T4_dtor_count = 0 )
				delete[] p
				CU_ASSERT( T4_ctor_count = 2 )
				CU_ASSERT( T4_dtor_count = 2 )
			end scope

			scope
				T4_ctor_count_x = 0
				T4_dtor_count_x = 0
				var p = new T4[0]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T4_ctor_count_x = 0 )
				CU_ASSERT( T4_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T4_ctor_count_x = 0 )
				CU_ASSERT( T4_dtor_count_x = 0 )
			end scope

			scope
				T4_ctor_count_x = 0
				T4_dtor_count_x = 0
				var p = new T4[1]
				CU_ASSERT( T4_ctor_count_x = 1 )
				CU_ASSERT( T4_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T4_ctor_count_x = 1 )
				CU_ASSERT( T4_dtor_count_x = 1 )
			end scope

			scope
				T4_ctor_count_x = 0
				T4_dtor_count_x = 0
				var p = new T4[2]
				CU_ASSERT( T4_ctor_count_x = 2 )
				CU_ASSERT( T4_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T4_ctor_count_x = 2 )
				CU_ASSERT( T4_dtor_count_x = 2 )
			end scope

			for n as integer = 0 to 2
				T4_ctor_count_x = 0
				T4_dtor_count_x = 0
				var p = new T4[n]
				CU_ASSERT( p <> NULL )
				CU_ASSERT( T4_ctor_count_x = n )
				CU_ASSERT( T4_dtor_count_x = 0 )
				delete[] p
				CU_ASSERT( T4_ctor_count_x = n )
				CU_ASSERT( T4_dtor_count_x = n )
			next

		END_TEST
	END_TEST_GROUP

	'' New as field initializer
	TEST_GROUP( newAsFieldInit )
		type T
			declare constructor( )
			declare destructor( )
			as short ptr a = new short[8]
			as short ptr ptr b = new short ptr[8]
			as integer ptr pi1 = new integer[3]
			as integer ptr pi2 = new integer( 123 )
		end type

		constructor T( )
			CU_ASSERT( a <> NULL )
			CU_ASSERT( b <> NULL )
			CU_ASSERT( pi1 <> NULL )
			CU_ASSERT( pi1[0] = 0 )
			CU_ASSERT( pi1[1] = 0 )
			CU_ASSERT( pi1[2] = 0 )
			CU_ASSERT( pi2 <> NULL )
			CU_ASSERT( *pi2 = 123 )
		end constructor

		destructor T( )
			delete[] a
			delete[] b
			delete[] pi1
			delete pi2
		end destructor

		TEST( default )
			dim as t a, b, c, d, e, f
		END_TEST
	END_TEST_GROUP

	'' New + side-effects
	TEST_GROUP( newSideFx )
		dim shared as integer count

		function f( ) as integer
			count += 1
			function = 123
		end function

		TEST( default )
			CU_ASSERT( count = 0 )
			var p = new integer( f( ) )
			CU_ASSERT( *p = 123 )
			CU_ASSERT( count = 1 )
			delete p
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( vectorNewSideFx )
		dim shared as integer calls

		function f( ) as integer
			calls += 1
			function = 2
		end function

		type DtorUDT
			i as integer
			declare destructor( )
		end type

		destructor DtorUDT( )
		end destructor

		TEST( default )
			'' new type[elementsexpr]

			scope
				CU_ASSERT( calls = 0 )

				'' p = allocate( elementsexpr * sizeof( type ) )
				var p = new integer[f( )] { any }

				CU_ASSERT( calls = 1 )
				calls = 0

				delete[] p
			end scope

			scope
				CU_ASSERT( calls = 0 )

				'' p = allocate( elementsexpr * sizeof( type ) )
				'' memclear( *p, elementsexpr * sizeof( type ) )
				var p = new integer[f( )]

				CU_ASSERT( calls = 1 )
				calls = 0

				delete[] p
			end scope

			scope
				CU_ASSERT( calls = 0 )

				'' p = allocate( (elementsexpr * sizeof( type )) + sizeof( integer ) )
				'' *p = elementsexpr
				'' p = cptr( any ptr, p ) + sizeof( integer )
				var p = new DtorUDT[f( )] { any }

				CU_ASSERT( calls = 1 )
				calls = 0

				delete[] p
			end scope

			scope
				CU_ASSERT( calls = 0 )

				'' p = allocate( (elementsexpr * sizeof( type )) + sizeof( integer ) )
				'' *p = elementsexpr
				'' p = cptr( any ptr, p ) + sizeof( integer )
				'' memclear( *p, elementsexpr * sizeof( type ) )
				var p = new DtorUDT[f( )]

				CU_ASSERT( calls = 1 )
				calls = 0

				delete[] p
			end scope
		END_TEST
	END_TEST_GROUP

	'' new[const]
	TEST_GROUP( vectorNewCtorList )
		type UDT
			i as integer
		end type

		type ClassUDT
			i as integer
			declare constructor( )
		end type

		constructor ClassUDT( )
			this.i = 123
		end constructor

		function f( byval p as ClassUDT ptr ) as UDT
			function = type( p->i )
			'' free p otherwise it is a memory leak
			delete p
		end function

		TEST( default )
			dim x as UDT
			CU_ASSERT( x.i = 0 )
			x = f( new ClassUDT[1] )
			CU_ASSERT( x.i = 123 )
		END_TEST
	END_TEST_GROUP

	'' new[iif + TYPEINIs]
	TEST_GROUP( vectorNewComplexElements )
		dim shared as integer ctors, dtors

		type ClassUdt
			i as integer
			declare constructor( )
			declare destructor( )
		end type

		constructor ClassUdt( )
			ctors += 1
		end constructor

		destructor ClassUdt( )
			dtors += 1
		end destructor

		type UDT
			i as integer
		end type

		TEST( default )
			ctors = 0
			dtors = 0
			scope
				var p = new ClassUdt[iif( (type<UDT>( (type<UDT>( 123 )).i )).i = 123, 4, 8 )]
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 0 )
				delete[] p
				CU_ASSERT( ctors = 4 )
				CU_ASSERT( dtors = 4 )
			end scope
			CU_ASSERT( ctors = 4 )
			CU_ASSERT( dtors = 4 )

			ctors = 0
			dtors = 0
			scope
				var p = new ClassUdt[iif( (type<UDT>( (type<UDT>( 123 )).i )).i = 456, 4, 8 )]
				CU_ASSERT( ctors = 8 )
				CU_ASSERT( dtors = 0 )
				delete[] p
				CU_ASSERT( ctors = 8 )
				CU_ASSERT( dtors = 8 )
			end scope
			CU_ASSERT( ctors = 8 )
			CU_ASSERT( dtors = 8 )
		END_TEST
	END_TEST_GROUP

	'' new(address) integer
	TEST_GROUP( placementNewPod )
		TEST( default )
			dim as integer ptr buffer = callocate( sizeof( integer ) * 3 )

			dim as integer ptr p = new(buffer+1) integer (111)
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0] = 0 )
			CU_ASSERT( buffer[1] = 111 )
			CU_ASSERT( buffer[2] = 0 )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' new(address) CtorUdt
	TEST_GROUP( placementNewCtor )
		dim shared as integer ctors

		type CtorUdt
			i as integer
			declare constructor( )
		end type

		constructor CtorUdt( )
			ctors += 1
			i = 111
		end constructor

		TEST( default )
			dim as CtorUdt ptr buffer = callocate( sizeof( CtorUdt ) * 3 )

			dim as CtorUdt ptr p = new(buffer+1) CtorUdt
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0].i = 0 )
			CU_ASSERT( buffer[1].i = 111 )
			CU_ASSERT( buffer[2].i = 0 )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' new(address) CtorDtorUdt
	TEST_GROUP( placementNewCtorDtor )
		dim shared as integer ctors, dtors

		type CtorDtorUdt
			i as integer
			declare constructor( )
			declare destructor( )
		end type

		constructor CtorDtorUdt( )
			ctors += 1
			i = 111
		end constructor

		destructor CtorDtorUdt( )
			dtors += 1
		end destructor

		TEST( default )
			dim as CtorDtorUdt ptr buffer = callocate( sizeof( CtorDtorUdt ) * 3 )

			dim as CtorDtorUdt ptr p = new(buffer+1) CtorDtorUdt
			CU_ASSERT( ctors = 1 )
			CU_ASSERT( dtors = 0 )
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0].i = 0 )
			CU_ASSERT( buffer[1].i = 111 )
			CU_ASSERT( buffer[2].i = 0 )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' new(address) integer[]
	TEST_GROUP( placementVectorNewPod )
		TEST( default )
			dim as integer ptr buffer = callocate( sizeof( integer ) * 5 )
			buffer[0] = &hAA
			buffer[1] = &hBB
			buffer[2] = &hCC
			buffer[3] = &hDD
			buffer[4] = &hEE

			dim as integer ptr p = new(buffer+1) integer[3]
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0] = &hAA )  '' no cookie should be written to p[-1]
			CU_ASSERT( buffer[1] = 0 )
			CU_ASSERT( buffer[2] = 0 )
			CU_ASSERT( buffer[3] = 0 )
			CU_ASSERT( buffer[4] = &hEE )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' new(address) CtorUdt[]
	TEST_GROUP( placementVectorNewCtor )
		dim shared as integer ctors

		type CtorUdt
			i as integer
			declare constructor( )
		end type

		constructor CtorUdt( )
			ctors += 1
		end constructor

		TEST( default )
			dim as CtorUdt ptr buffer = callocate( sizeof( CtorUdt ) * 5 )
			buffer[0].i = &hAA
			buffer[1].i = &hBB
			buffer[2].i = &hCC
			buffer[3].i = &hDD
			buffer[4].i = &hEE

			dim as CtorUdt ptr p = new(buffer+1) CtorUdt[3]
			CU_ASSERT( ctors = 3 )
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0].i = &hAA )  '' no cookie should be written to p[-1]
			CU_ASSERT( buffer[1].i = 0 )
			CU_ASSERT( buffer[2].i = 0 )
			CU_ASSERT( buffer[3].i = 0 )
			CU_ASSERT( buffer[4].i = &hEE )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' new(address) CtorDtorUdt[]
	TEST_GROUP( placementVectorNewCtorDtor )
		dim shared as integer ctors, dtors

		type CtorDtorUdt
			i as integer
			declare constructor( )
			declare destructor( )
		end type

		constructor CtorDtorUdt( )
			ctors += 1
		end constructor

		destructor CtorDtorUdt( )
			dtors += 1
		end destructor

		TEST( default )
			dim as CtorDtorUdt ptr buffer = callocate( sizeof( CtorDtorUdt ) * 5 )
			buffer[0].i = &hAA
			buffer[1].i = &hBB
			buffer[2].i = &hCC
			buffer[3].i = &hDD
			buffer[4].i = &hEE

			dim as CtorDtorUdt ptr p = new(buffer+1) CtorDtorUdt[3]
			CU_ASSERT( ctors = 3 )
			CU_ASSERT( dtors = 0 )
			CU_ASSERT( p = buffer+1 )
			CU_ASSERT( buffer[0].i = &hAA )  '' no cookie should be written to p[-1]
			CU_ASSERT( buffer[1].i = 0 )
			CU_ASSERT( buffer[2].i = 0 )
			CU_ASSERT( buffer[3].i = 0 )
			CU_ASSERT( buffer[4].i = &hEE )

			deallocate( buffer )
		END_TEST
	END_TEST_GROUP

	'' #3509495 regression test
	'' Delete on derived UDT pointers
	TEST_GROUP( deleteDerivedPtr )
		type Parent
			as integer i
		end type

		type Child extends Parent
			declare constructor( )
			declare destructor( )
		end type

		constructor Child( )
			base.i = 123
		end constructor

		destructor Child( )
		end destructor

		TEST( default )
			scope
				var p = new Child( )
				CU_ASSERT( p->i = 123 )
				delete p
			end scope

			scope
				dim as Child ptr p = new Child[5]
				for i as integer = 0 to 4
					CU_ASSERT( p[i].i = 123 )
				next
				delete[] p
			end scope
		END_TEST
	END_TEST_GROUP

	'' Delete + side-effects 1
	TEST_GROUP( deleteSideFx1 )
		dim shared as integer count
		dim shared as integer ptr p

		function f( ) as integer ptr
			count += 1
			function = p
		end function

		TEST( default )
			p = new integer( 123 )
			CU_ASSERT( *p = 123 )
			CU_ASSERT( count = 0 )
			delete f( )
			CU_ASSERT( count = 1 )
		END_TEST
	END_TEST_GROUP

	'' Delete + side-effects 2
	TEST_GROUP( deleteSideFx2 )
		dim shared as integer count
		dim shared as integer ptr p

		function f( ) as integer ptr
			count += 1
			function = p
		end function

		TEST( default )
			p = new integer[5]
			CU_ASSERT( count = 0 )
			delete[] f( )
			CU_ASSERT( count = 1 )
		END_TEST
	END_TEST_GROUP

	'' Delete + side-effects 3
	TEST_GROUP( deleteSideFx3 )
		type T
			as integer i
			declare destructor( )
		end type

		destructor T( )
		end destructor

		dim shared as integer count
		dim shared as T ptr p

		function f( ) as T ptr
			count += 1
			function = p
		end function

		TEST( default )
			p = new T
			CU_ASSERT( count = 0 )
			delete f( )
			CU_ASSERT( count = 1 )
		END_TEST
	END_TEST_GROUP

	'' Delete + side-effects 4
	TEST_GROUP( deleteSideFx4 )
		type T
			as integer i
			declare destructor( )
		end type

		destructor T( )
		end destructor

		dim shared as integer count
		dim shared as T ptr p

		function f( ) as T ptr
			count += 1
			function = p
		end function

		TEST( default )
			p = new T[2]
			CU_ASSERT( count = 0 )
			delete[] f( )
			CU_ASSERT( count = 1 )
		END_TEST
	END_TEST_GROUP

	'' Delete on NULL pointer
	TEST_GROUP( deleteNull )
		type T
			as integer i
			declare destructor( )
		end type

		destructor T( )
			'' Shouldn't be called
			CU_FAIL( )
		end destructor

		TEST( default )
			dim as T ptr a = 0
			CU_ASSERT( a = 0 )
			delete a
			delete[] a

			dim as T ptr b(0 to 0) = { 0 }
			CU_ASSERT( b(0) = 0 )
			delete b(0)
			delete[] b(0)
		END_TEST
	END_TEST_GROUP

END_SUITE
