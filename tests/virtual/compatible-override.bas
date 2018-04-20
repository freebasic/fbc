#include "fbcunit.bi"

SUITE( fbc_tests.virtual_.compatible_override )

	''
	'' We can allow overrides even if the signature differs from the corresponding
	'' virtual method, as long as they're compatible.
	''

	TEST_GROUP( integertypes )
		type A extends object
			declare virtual function f1( ) as byte
			declare virtual function f2( ) as integer
	#ifdef __FB_64BIT__
			declare virtual function f3( ) as longint
	#else
			declare virtual function f3( ) as long
	#endif
		end type

		function A.f1( ) as byte    : function = &hA1 : end function
		function A.f2( ) as integer : function = &hA2 : end function
	#ifdef __FB_64BIT__
		function A.f3( ) as longint : function = &hA3 : end function
	#else
		function A.f3( ) as long    : function = &hA3 : end function
	#endif

		type B extends A
			declare function f1( ) as ubyte   override
	#ifdef __FB_64BIT__
			declare function f2( ) as longint override
	#else
			declare function f2( ) as long    override
	#endif
			declare function f3( ) as integer override
		end type

		function B.f1( ) as ubyte   : function = &hB1 : end function
	#ifdef __FB_64BIT__
		function B.f2( ) as longint : function = &hB2 : end function
	#else
		function B.f2( ) as long    : function = &hB2 : end function
	#endif
		function B.f3( ) as integer : function = &hB3 : end function

		TEST( default )
			dim xa as A
			CU_ASSERT( xa.f1( ) = cbyte( &hA1 ) )
			CU_ASSERT( xa.f2( ) = &hA2 )
			CU_ASSERT( xa.f3( ) = &hA3 )

			dim xb as B
			CU_ASSERT( xb.f1( ) = &hB1 )
			CU_ASSERT( xb.f2( ) = &hB2 )
			CU_ASSERT( xb.f3( ) = &hB3 )

			dim pa as A ptr = new B
			CU_ASSERT( pa->f1( ) = cbyte( &hB1 ) )
			CU_ASSERT( pa->f2( ) = &hB2 )
			CU_ASSERT( pa->f3( ) = &hB3 )
			delete pa
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( covariantReturnType )
		type A extends object
			i as integer
			declare virtual function f( ) byref as A
		end type
		type B extends A
			j as integer
			declare function f( ) byref as B override
		end type

		dim shared globala as A
		dim shared globalb as B

		function A.f( ) byref as A : function = globala : end function
		function B.f( ) byref as B : function = globalb : end function

		TEST( default )
			globala.i = &hA
			globalb.i = &hB1
			globalb.j = &hB2

			dim xa as A
			CU_ASSERT( xa.f( ).i = &hA )

			dim xb as B
			CU_ASSERT( xb.f( ).i = &hB1 )
			CU_ASSERT( xb.f( ).j = &hB2 )

			dim pa as A ptr = new B
			CU_ASSERT( pa->f( ).i = &hB1 )
			delete pa
		END_TEST
	END_TEST_GROUP

	TEST_GROUP( constness )
		type A extends object
			declare virtual function f1( ) byref as const integer
			declare virtual function f2( )       as       integer
			declare virtual function f3( )       as const integer
		end type

		function A.f1( ) byref as const integer
			static i as integer = &hA1
			function = i
		end function
		function A.f2( ) as       integer : function = &hA2 : end function
		function A.f3( ) as const integer : function = &hA3 : end function

		type B extends A
			'' A.f1 promises CONST, i.e. the caller can never modify it -
			'' that's acceptable for B.f1. B.f1 doesn't have CONST, so
			'' modification would be allowed, but it's not required either.
			declare function f1( ) byref as       integer override

			'' For BYVAL returns, CONST doesn't matter at all, so we can
			'' override all we want.
			declare function f2( )       as const integer override
			declare function f3( )       as       integer override
		end type

		function B.f1( ) byref as integer
			static i as integer = &hB1
			function = i
		end function
		function B.f2( ) as const integer : function = &hB2 : end function
		function B.f3( ) as       integer : function = &hB3 : end function

		TEST( default )
			dim xa as A
			CU_ASSERT( xa.f1( ) = &hA1 )
			CU_ASSERT( xa.f2( ) = &hA2 )
			CU_ASSERT( xa.f3( ) = &hA3 )

			dim xb as B
			CU_ASSERT( xb.f1( ) = &hB1 )
			CU_ASSERT( xb.f2( ) = &hB2 )
			CU_ASSERT( xb.f3( ) = &hB3 )

			dim pa as A ptr = new B
			CU_ASSERT( pa->f1( ) = &hB1 )
			CU_ASSERT( pa->f2( ) = &hB2 )
			CU_ASSERT( pa->f3( ) = &hB3 )
			delete pa
		END_TEST
	END_TEST_GROUP

END_SUITE
