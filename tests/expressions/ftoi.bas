# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.ftoi )

	TEST( floatToIntRounding )
		dim f as single
		dim d as double

		''
		'' single -> signed
		''

		f = -1.1f : CU_ASSERT( cbyte( f ) = -1 ) : CU_ASSERT( cbyte( -1.1f ) = -1 )
		f = -1.0f : CU_ASSERT( cbyte( f ) = -1 ) : CU_ASSERT( cbyte( -1.0f ) = -1 )
		f = -0.9f : CU_ASSERT( cbyte( f ) = -1 ) : CU_ASSERT( cbyte( -0.9f ) = -1 )
		f = -0.5f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte( -0.5f ) =  0 )
		f = -0.4f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte( -0.4f ) =  0 )
		f = -0.1f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte( -0.1f ) =  0 )
		f =  0.0f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte(  0.0f ) =  0 )
		f =  0.1f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte(  0.1f ) =  0 )
		f =  0.4f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte(  0.4f ) =  0 )
		f =  0.5f : CU_ASSERT( cbyte( f ) =  0 ) : CU_ASSERT( cbyte(  0.5f ) =  0 )
		f =  0.9f : CU_ASSERT( cbyte( f ) =  1 ) : CU_ASSERT( cbyte(  0.9f ) =  1 )
		f =  1.0f : CU_ASSERT( cbyte( f ) =  1 ) : CU_ASSERT( cbyte(  1.0f ) =  1 )
		f =  1.1f : CU_ASSERT( cbyte( f ) =  1 ) : CU_ASSERT( cbyte(  1.1f ) =  1 )

		f = -1.1f : CU_ASSERT( cshort( f ) = -1 ) : CU_ASSERT( cshort( -1.1f ) = -1 )
		f = -1.0f : CU_ASSERT( cshort( f ) = -1 ) : CU_ASSERT( cshort( -1.0f ) = -1 )
		f = -0.9f : CU_ASSERT( cshort( f ) = -1 ) : CU_ASSERT( cshort( -0.9f ) = -1 )
		f = -0.5f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort( -0.5f ) =  0 )
		f = -0.4f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort( -0.4f ) =  0 )
		f = -0.1f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort( -0.1f ) =  0 )
		f =  0.0f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort(  0.0f ) =  0 )
		f =  0.1f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort(  0.1f ) =  0 )
		f =  0.4f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort(  0.4f ) =  0 )
		f =  0.5f : CU_ASSERT( cshort( f ) =  0 ) : CU_ASSERT( cshort(  0.5f ) =  0 )
		f =  0.9f : CU_ASSERT( cshort( f ) =  1 ) : CU_ASSERT( cshort(  0.9f ) =  1 )
		f =  1.0f : CU_ASSERT( cshort( f ) =  1 ) : CU_ASSERT( cshort(  1.0f ) =  1 )
		f =  1.1f : CU_ASSERT( cshort( f ) =  1 ) : CU_ASSERT( cshort(  1.1f ) =  1 )

		f = -1.1f : CU_ASSERT( cint( f ) = -1 ) : CU_ASSERT( cint( -1.1f ) = -1 )
		f = -1.0f : CU_ASSERT( cint( f ) = -1 ) : CU_ASSERT( cint( -1.0f ) = -1 )
		f = -0.9f : CU_ASSERT( cint( f ) = -1 ) : CU_ASSERT( cint( -0.9f ) = -1 )
		f = -0.5f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint( -0.5f ) =  0 )
		f = -0.4f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint( -0.4f ) =  0 )
		f = -0.1f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint( -0.1f ) =  0 )
		f =  0.0f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint(  0.0f ) =  0 )
		f =  0.1f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint(  0.1f ) =  0 )
		f =  0.4f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint(  0.4f ) =  0 )
		f =  0.5f : CU_ASSERT( cint( f ) =  0 ) : CU_ASSERT( cint(  0.5f ) =  0 )
		f =  0.9f : CU_ASSERT( cint( f ) =  1 ) : CU_ASSERT( cint(  0.9f ) =  1 )
		f =  1.0f : CU_ASSERT( cint( f ) =  1 ) : CU_ASSERT( cint(  1.0f ) =  1 )
		f =  1.1f : CU_ASSERT( cint( f ) =  1 ) : CU_ASSERT( cint(  1.1f ) =  1 )

		f = -1.1f : CU_ASSERT( clng( f ) = -1l ) : CU_ASSERT( clng( -1.1f ) = -1l )
		f = -1.0f : CU_ASSERT( clng( f ) = -1l ) : CU_ASSERT( clng( -1.0f ) = -1l )
		f = -0.9f : CU_ASSERT( clng( f ) = -1l ) : CU_ASSERT( clng( -0.9f ) = -1l )
		f = -0.5f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng( -0.5f ) =  0l )
		f = -0.4f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng( -0.4f ) =  0l )
		f = -0.1f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng( -0.1f ) =  0l )
		f =  0.0f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng(  0.0f ) =  0l )
		f =  0.1f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng(  0.1f ) =  0l )
		f =  0.4f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng(  0.4f ) =  0l )
		f =  0.5f : CU_ASSERT( clng( f ) =  0l ) : CU_ASSERT( clng(  0.5f ) =  0l )
		f =  0.9f : CU_ASSERT( clng( f ) =  1l ) : CU_ASSERT( clng(  0.9f ) =  1l )
		f =  1.0f : CU_ASSERT( clng( f ) =  1l ) : CU_ASSERT( clng(  1.0f ) =  1l )
		f =  1.1f : CU_ASSERT( clng( f ) =  1l ) : CU_ASSERT( clng(  1.1f ) =  1l )

		f = -1.1f : CU_ASSERT( clngint( f ) = -1ll ) : CU_ASSERT( clngint( -1.1f ) = -1ll )
		f = -1.0f : CU_ASSERT( clngint( f ) = -1ll ) : CU_ASSERT( clngint( -1.0f ) = -1ll )
		f = -0.9f : CU_ASSERT( clngint( f ) = -1ll ) : CU_ASSERT( clngint( -0.9f ) = -1ll )
		f = -0.5f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint( -0.5f ) =  0ll )
		f = -0.4f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint( -0.4f ) =  0ll )
		f = -0.1f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint( -0.1f ) =  0ll )
		f =  0.0f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint(  0.0f ) =  0ll )
		f =  0.1f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint(  0.1f ) =  0ll )
		f =  0.4f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint(  0.4f ) =  0ll )
		f =  0.5f : CU_ASSERT( clngint( f ) =  0ll ) : CU_ASSERT( clngint(  0.5f ) =  0ll )
		f =  0.9f : CU_ASSERT( clngint( f ) =  1ll ) : CU_ASSERT( clngint(  0.9f ) =  1ll )
		f =  1.0f : CU_ASSERT( clngint( f ) =  1ll ) : CU_ASSERT( clngint(  1.0f ) =  1ll )
		f =  1.1f : CU_ASSERT( clngint( f ) =  1ll ) : CU_ASSERT( clngint(  1.1f ) =  1ll )

		''
		'' single -> unsigned
		''

		f =  0.0f : CU_ASSERT( cubyte( f ) =  0u ) : CU_ASSERT( cubyte(  0.0f ) =  0u )
		f =  0.1f : CU_ASSERT( cubyte( f ) =  0u ) : CU_ASSERT( cubyte(  0.1f ) =  0u )
		f =  0.4f : CU_ASSERT( cubyte( f ) =  0u ) : CU_ASSERT( cubyte(  0.4f ) =  0u )
		f =  0.5f : CU_ASSERT( cubyte( f ) =  0u ) : CU_ASSERT( cubyte(  0.5f ) =  0u )
		f =  0.9f : CU_ASSERT( cubyte( f ) =  1u ) : CU_ASSERT( cubyte(  0.9f ) =  1u )
		f =  1.0f : CU_ASSERT( cubyte( f ) =  1u ) : CU_ASSERT( cubyte(  1.0f ) =  1u )
		f =  1.1f : CU_ASSERT( cubyte( f ) =  1u ) : CU_ASSERT( cubyte(  1.1f ) =  1u )

		f =  0.0f : CU_ASSERT( cushort( f ) =  0u ) : CU_ASSERT( cushort(  0.0f ) =  0u )
		f =  0.1f : CU_ASSERT( cushort( f ) =  0u ) : CU_ASSERT( cushort(  0.1f ) =  0u )
		f =  0.4f : CU_ASSERT( cushort( f ) =  0u ) : CU_ASSERT( cushort(  0.4f ) =  0u )
		f =  0.5f : CU_ASSERT( cushort( f ) =  0u ) : CU_ASSERT( cushort(  0.5f ) =  0u )
		f =  0.9f : CU_ASSERT( cushort( f ) =  1u ) : CU_ASSERT( cushort(  0.9f ) =  1u )
		f =  1.0f : CU_ASSERT( cushort( f ) =  1u ) : CU_ASSERT( cushort(  1.0f ) =  1u )
		f =  1.1f : CU_ASSERT( cushort( f ) =  1u ) : CU_ASSERT( cushort(  1.1f ) =  1u )

		f =  0.0f : CU_ASSERT( cuint( f ) =  0u ) : CU_ASSERT( cuint(  0.0f ) =  0u )
		f =  0.1f : CU_ASSERT( cuint( f ) =  0u ) : CU_ASSERT( cuint(  0.1f ) =  0u )
		f =  0.4f : CU_ASSERT( cuint( f ) =  0u ) : CU_ASSERT( cuint(  0.4f ) =  0u )
		f =  0.5f : CU_ASSERT( cuint( f ) =  0u ) : CU_ASSERT( cuint(  0.5f ) =  0u )
		f =  0.9f : CU_ASSERT( cuint( f ) =  1u ) : CU_ASSERT( cuint(  0.9f ) =  1u )
		f =  1.0f : CU_ASSERT( cuint( f ) =  1u ) : CU_ASSERT( cuint(  1.0f ) =  1u )
		f =  1.1f : CU_ASSERT( cuint( f ) =  1u ) : CU_ASSERT( cuint(  1.1f ) =  1u )

		f =  0.0f : CU_ASSERT( culng( f ) =  0ul ) : CU_ASSERT( culng(  0.0f ) =  0ul )
		f =  0.1f : CU_ASSERT( culng( f ) =  0ul ) : CU_ASSERT( culng(  0.1f ) =  0ul )
		f =  0.4f : CU_ASSERT( culng( f ) =  0ul ) : CU_ASSERT( culng(  0.4f ) =  0ul )
		f =  0.5f : CU_ASSERT( culng( f ) =  0ul ) : CU_ASSERT( culng(  0.5f ) =  0ul )
		f =  0.9f : CU_ASSERT( culng( f ) =  1ul ) : CU_ASSERT( culng(  0.9f ) =  1ul )
		f =  1.0f : CU_ASSERT( culng( f ) =  1ul ) : CU_ASSERT( culng(  1.0f ) =  1ul )
		f =  1.1f : CU_ASSERT( culng( f ) =  1ul ) : CU_ASSERT( culng(  1.1f ) =  1ul )

		f =  0.0f : CU_ASSERT( culngint( f ) =  0ull ) : CU_ASSERT( culngint(  0.0f ) =  0ull )
		f =  0.1f : CU_ASSERT( culngint( f ) =  0ull ) : CU_ASSERT( culngint(  0.1f ) =  0ull )
		f =  0.4f : CU_ASSERT( culngint( f ) =  0ull ) : CU_ASSERT( culngint(  0.4f ) =  0ull )
		f =  0.5f : CU_ASSERT( culngint( f ) =  0ull ) : CU_ASSERT( culngint(  0.5f ) =  0ull )
		f =  0.9f : CU_ASSERT( culngint( f ) =  1ull ) : CU_ASSERT( culngint(  0.9f ) =  1ull )
		f =  1.0f : CU_ASSERT( culngint( f ) =  1ull ) : CU_ASSERT( culngint(  1.0f ) =  1ull )
		f =  1.1f : CU_ASSERT( culngint( f ) =  1ull ) : CU_ASSERT( culngint(  1.1f ) =  1ull )

		''
		'' double -> signed
		''

		d = -1.1 : CU_ASSERT( cbyte( d ) = -1 ) : CU_ASSERT( cbyte( -1.1 ) = -1 )
		d = -1.0 : CU_ASSERT( cbyte( d ) = -1 ) : CU_ASSERT( cbyte( -1.0 ) = -1 )
		d = -0.9 : CU_ASSERT( cbyte( d ) = -1 ) : CU_ASSERT( cbyte( -0.9 ) = -1 )
		d = -0.5 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte( -0.5 ) =  0 )
		d = -0.4 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte( -0.4 ) =  0 )
		d = -0.1 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte( -0.1 ) =  0 )
		d =  0.0 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte(  0.0 ) =  0 )
		d =  0.1 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte(  0.1 ) =  0 )
		d =  0.4 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte(  0.4 ) =  0 )
		d =  0.5 : CU_ASSERT( cbyte( d ) =  0 ) : CU_ASSERT( cbyte(  0.5 ) =  0 )
		d =  0.9 : CU_ASSERT( cbyte( d ) =  1 ) : CU_ASSERT( cbyte(  0.9 ) =  1 )
		d =  1.0 : CU_ASSERT( cbyte( d ) =  1 ) : CU_ASSERT( cbyte(  1.0 ) =  1 )
		d =  1.1 : CU_ASSERT( cbyte( d ) =  1 ) : CU_ASSERT( cbyte(  1.1 ) =  1 )

		d = -1.1 : CU_ASSERT( cshort( d ) = -1 ) : CU_ASSERT( cshort( -1.1 ) = -1 )
		d = -1.0 : CU_ASSERT( cshort( d ) = -1 ) : CU_ASSERT( cshort( -1.0 ) = -1 )
		d = -0.9 : CU_ASSERT( cshort( d ) = -1 ) : CU_ASSERT( cshort( -0.9 ) = -1 )
		d = -0.5 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort( -0.5 ) =  0 )
		d = -0.4 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort( -0.4 ) =  0 )
		d = -0.1 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort( -0.1 ) =  0 )
		d =  0.0 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort(  0.0 ) =  0 )
		d =  0.1 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort(  0.1 ) =  0 )
		d =  0.4 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort(  0.4 ) =  0 )
		d =  0.5 : CU_ASSERT( cshort( d ) =  0 ) : CU_ASSERT( cshort(  0.5 ) =  0 )
		d =  0.9 : CU_ASSERT( cshort( d ) =  1 ) : CU_ASSERT( cshort(  0.9 ) =  1 )
		d =  1.0 : CU_ASSERT( cshort( d ) =  1 ) : CU_ASSERT( cshort(  1.0 ) =  1 )
		d =  1.1 : CU_ASSERT( cshort( d ) =  1 ) : CU_ASSERT( cshort(  1.1 ) =  1 )

		d = -1.1 : CU_ASSERT( cint( d ) = -1 ) : CU_ASSERT( cint( -1.1 ) = -1 )
		d = -1.0 : CU_ASSERT( cint( d ) = -1 ) : CU_ASSERT( cint( -1.0 ) = -1 )
		d = -0.9 : CU_ASSERT( cint( d ) = -1 ) : CU_ASSERT( cint( -0.9 ) = -1 )
		d = -0.5 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint( -0.5 ) =  0 )
		d = -0.4 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint( -0.4 ) =  0 )
		d = -0.1 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint( -0.1 ) =  0 )
		d =  0.0 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint(  0.0 ) =  0 )
		d =  0.1 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint(  0.1 ) =  0 )
		d =  0.4 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint(  0.4 ) =  0 )
		d =  0.5 : CU_ASSERT( cint( d ) =  0 ) : CU_ASSERT( cint(  0.5 ) =  0 )
		d =  0.9 : CU_ASSERT( cint( d ) =  1 ) : CU_ASSERT( cint(  0.9 ) =  1 )
		d =  1.0 : CU_ASSERT( cint( d ) =  1 ) : CU_ASSERT( cint(  1.0 ) =  1 )
		d =  1.1 : CU_ASSERT( cint( d ) =  1 ) : CU_ASSERT( cint(  1.1 ) =  1 )

		d = -1.1 : CU_ASSERT( clng( d ) = -1l ) : CU_ASSERT( clng( -1.1 ) = -1l )
		d = -1.0 : CU_ASSERT( clng( d ) = -1l ) : CU_ASSERT( clng( -1.0 ) = -1l )
		d = -0.9 : CU_ASSERT( clng( d ) = -1l ) : CU_ASSERT( clng( -0.9 ) = -1l )
		d = -0.5 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng( -0.5 ) =  0l )
		d = -0.4 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng( -0.4 ) =  0l )
		d = -0.1 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng( -0.1 ) =  0l )
		d =  0.0 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng(  0.0 ) =  0l )
		d =  0.1 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng(  0.1 ) =  0l )
		d =  0.4 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng(  0.4 ) =  0l )
		d =  0.5 : CU_ASSERT( clng( d ) =  0l ) : CU_ASSERT( clng(  0.5 ) =  0l )
		d =  0.9 : CU_ASSERT( clng( d ) =  1l ) : CU_ASSERT( clng(  0.9 ) =  1l )
		d =  1.0 : CU_ASSERT( clng( d ) =  1l ) : CU_ASSERT( clng(  1.0 ) =  1l )
		d =  1.1 : CU_ASSERT( clng( d ) =  1l ) : CU_ASSERT( clng(  1.1 ) =  1l )

		d = -1.1 : CU_ASSERT( clngint( d ) = -1ll ) : CU_ASSERT( clngint( -1.1 ) = -1ll )
		d = -1.0 : CU_ASSERT( clngint( d ) = -1ll ) : CU_ASSERT( clngint( -1.0 ) = -1ll )
		d = -0.9 : CU_ASSERT( clngint( d ) = -1ll ) : CU_ASSERT( clngint( -0.9 ) = -1ll )
		d = -0.5 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint( -0.5 ) =  0ll )
		d = -0.4 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint( -0.4 ) =  0ll )
		d = -0.1 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint( -0.1 ) =  0ll )
		d =  0.0 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint(  0.0 ) =  0ll )
		d =  0.1 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint(  0.1 ) =  0ll )
		d =  0.4 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint(  0.4 ) =  0ll )
		d =  0.5 : CU_ASSERT( clngint( d ) =  0ll ) : CU_ASSERT( clngint(  0.5 ) =  0ll )
		d =  0.9 : CU_ASSERT( clngint( d ) =  1ll ) : CU_ASSERT( clngint(  0.9 ) =  1ll )
		d =  1.0 : CU_ASSERT( clngint( d ) =  1ll ) : CU_ASSERT( clngint(  1.0 ) =  1ll )
		d =  1.1 : CU_ASSERT( clngint( d ) =  1ll ) : CU_ASSERT( clngint(  1.1 ) =  1ll )

		''
		'' double -> unsigned
		''

		d =  0.0 : CU_ASSERT( cubyte( d ) =  0u ) : CU_ASSERT( cubyte(  0.0 ) =  0u )
		d =  0.1 : CU_ASSERT( cubyte( d ) =  0u ) : CU_ASSERT( cubyte(  0.1 ) =  0u )
		d =  0.4 : CU_ASSERT( cubyte( d ) =  0u ) : CU_ASSERT( cubyte(  0.4 ) =  0u )
		d =  0.5 : CU_ASSERT( cubyte( d ) =  0u ) : CU_ASSERT( cubyte(  0.5 ) =  0u )
		d =  0.9 : CU_ASSERT( cubyte( d ) =  1u ) : CU_ASSERT( cubyte(  0.9 ) =  1u )
		d =  1.0 : CU_ASSERT( cubyte( d ) =  1u ) : CU_ASSERT( cubyte(  1.0 ) =  1u )
		d =  1.1 : CU_ASSERT( cubyte( d ) =  1u ) : CU_ASSERT( cubyte(  1.1 ) =  1u )

		d =  0.0 : CU_ASSERT( cushort( d ) =  0u ) : CU_ASSERT( cushort(  0.0 ) =  0u )
		d =  0.1 : CU_ASSERT( cushort( d ) =  0u ) : CU_ASSERT( cushort(  0.1 ) =  0u )
		d =  0.4 : CU_ASSERT( cushort( d ) =  0u ) : CU_ASSERT( cushort(  0.4 ) =  0u )
		d =  0.5 : CU_ASSERT( cushort( d ) =  0u ) : CU_ASSERT( cushort(  0.5 ) =  0u )
		d =  0.9 : CU_ASSERT( cushort( d ) =  1u ) : CU_ASSERT( cushort(  0.9 ) =  1u )
		d =  1.0 : CU_ASSERT( cushort( d ) =  1u ) : CU_ASSERT( cushort(  1.0 ) =  1u )
		d =  1.1 : CU_ASSERT( cushort( d ) =  1u ) : CU_ASSERT( cushort(  1.1 ) =  1u )

		d =  0.0 : CU_ASSERT( cuint( d ) =  0u ) : CU_ASSERT( cuint(  0.0 ) =  0u )
		d =  0.1 : CU_ASSERT( cuint( d ) =  0u ) : CU_ASSERT( cuint(  0.1 ) =  0u )
		d =  0.4 : CU_ASSERT( cuint( d ) =  0u ) : CU_ASSERT( cuint(  0.4 ) =  0u )
		d =  0.5 : CU_ASSERT( cuint( d ) =  0u ) : CU_ASSERT( cuint(  0.5 ) =  0u )
		d =  0.9 : CU_ASSERT( cuint( d ) =  1u ) : CU_ASSERT( cuint(  0.9 ) =  1u )
		d =  1.0 : CU_ASSERT( cuint( d ) =  1u ) : CU_ASSERT( cuint(  1.0 ) =  1u )
		d =  1.1 : CU_ASSERT( cuint( d ) =  1u ) : CU_ASSERT( cuint(  1.1 ) =  1u )

		d =  0.0 : CU_ASSERT( culng( d ) =  0ul ) : CU_ASSERT( culng(  0.0 ) =  0ul )
		d =  0.1 : CU_ASSERT( culng( d ) =  0ul ) : CU_ASSERT( culng(  0.1 ) =  0ul )
		d =  0.4 : CU_ASSERT( culng( d ) =  0ul ) : CU_ASSERT( culng(  0.4 ) =  0ul )
		d =  0.5 : CU_ASSERT( culng( d ) =  0ul ) : CU_ASSERT( culng(  0.5 ) =  0ul )
		d =  0.9 : CU_ASSERT( culng( d ) =  1ul ) : CU_ASSERT( culng(  0.9 ) =  1ul )
		d =  1.0 : CU_ASSERT( culng( d ) =  1ul ) : CU_ASSERT( culng(  1.0 ) =  1ul )
		d =  1.1 : CU_ASSERT( culng( d ) =  1ul ) : CU_ASSERT( culng(  1.1 ) =  1ul )

		d =  0.0 : CU_ASSERT( culngint( d ) =  0ull ) : CU_ASSERT( culngint(  0.0 ) =  0ull )
		d =  0.1 : CU_ASSERT( culngint( d ) =  0ull ) : CU_ASSERT( culngint(  0.1 ) =  0ull )
		d =  0.4 : CU_ASSERT( culngint( d ) =  0ull ) : CU_ASSERT( culngint(  0.4 ) =  0ull )
		d =  0.5 : CU_ASSERT( culngint( d ) =  0ull ) : CU_ASSERT( culngint(  0.5 ) =  0ull )
		d =  0.9 : CU_ASSERT( culngint( d ) =  1ull ) : CU_ASSERT( culngint(  0.9 ) =  1ull )
		d =  1.0 : CU_ASSERT( culngint( d ) =  1ull ) : CU_ASSERT( culngint(  1.0 ) =  1ull )
		d =  1.1 : CU_ASSERT( culngint( d ) =  1ull ) : CU_ASSERT( culngint(  1.1 ) =  1ull )
	END_TEST

	TEST( doubleToUnsigned )
		dim as uinteger i
		dim as ulongint l
		dim as double d

		d = 1234.49
		i = d
		l = d
		CU_ASSERT_EQUAL( i, 1234 )
		CU_ASSERT_EQUAL( l, 1234 )

		d = 1234.5
		i = d
		l = d
		CU_ASSERT_EQUAL( i, 1234 )
		CU_ASSERT_EQUAL( l, 1234 )

		d = 1234.51
		i = d
		l = d
		CU_ASSERT_EQUAL( i, 1235 )
		CU_ASSERT_EQUAL( l, 1235 )

		i = 4.2e9
		CU_ASSERT_EQUAL( i, 4.2e9 )

		'' -gen gcc regression tests
		d = &hFFFFFFFFu
		CU_ASSERT( culng( d ) = &hFFFFFFFFu )
		CU_ASSERT( cuint( d ) = &hFFFFFFFFu )
		CU_ASSERT( culng( cdbl( &hFFFFFFFFu ) ) = &hFFFFFFFFu )
		CU_ASSERT( cuint( cdbl( &hFFFFFFFFu ) ) = &hFFFFFFFFu )
		d = -1
		CU_ASSERT( cint( d ) = -1 )

		'' double-2-uint64 shouldn't truncate to int64
		d = 1e19
		CU_ASSERT( culngint( d ) = 10000000000000000000ull )
		CU_ASSERT( culngint( d ) = &h8AC7230489E80000ull )
	END_TEST

	TEST( singleToUnsigned )
		dim as uinteger i
		dim as ulongint l
		dim as single f

		f = 1234.49
		i = f
		l = f
		CU_ASSERT_EQUAL( i, 1234 )
		CU_ASSERT_EQUAL( l, 1234 )

		f = 1234.5
		i = f
		l = f
		CU_ASSERT_EQUAL( i, 1234 )
		CU_ASSERT_EQUAL( l, 1234 )

		f = 1234.51
		i = f
		l = f
		CU_ASSERT_EQUAL( i, 1235 )
		CU_ASSERT_EQUAL( l, 1235 )

		i = 4.2e9
		CU_ASSERT_EQUAL( i, 4.2e9 )

		'' -gen gcc regression tests
		f = &h80000000u
		CU_ASSERT( culng( f ) = &h80000000u )
		CU_ASSERT( cuint( f ) = &h80000000u )
		CU_ASSERT( culng( csng( &h80000000u ) ) = &h80000000u )
		CU_ASSERT( cuint( csng( &h80000000u ) ) = &h80000000u )
		f = -1
		CU_ASSERT( cint( f ) = -1 )

		'' float-2-uint64 shouldn't truncate to int64
		f = 9223372036854775808f
		CU_ASSERT( culngint( f ) = 9223372036854775808ull )
		CU_ASSERT( culngint( f ) = &h8000000000000000ull )
	END_TEST

END_SUITE
