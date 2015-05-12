# include once "fbcu.bi"

namespace fbc_tests.expressions.ftoi

sub floatToIntRounding cdecl( )
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
end sub

sub doubleToUnsigned cdecl( )
	dim as unsigned integer i
	dim as unsigned longint l
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
	d = 4294967295u
	CU_ASSERT( cuint( d ) = 4294967295u )
	CU_ASSERT( cuint( cdbl( 4294967295u ) ) = 4294967295u )
	d = -1
	CU_ASSERT( cint( d ) = -1 )
end sub

sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.expressions.ftoi" )
	fbcu.add_test( "FTOI rounding", @floatToIntRounding )
	fbcu.add_test( "double to unsigned", @doubleToUnsigned )
end sub

end namespace
