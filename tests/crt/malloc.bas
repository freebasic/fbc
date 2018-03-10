# include once "fbcunit.bi"
# include once "crt.bi"

SUITE( fbc_tests.crt.malloc_ )

	TEST( test_malloc )
		dim as any ptr p

		'' This should compile fine under -gen gcc
		'' (the malloc() declarations from the built-in allocate() and from the
		'' crt.bi should not conflict)

		p = malloc( 128 )
		p = realloc( p, 256 )
		free( p )

		p = calloc( 128, 1 )
		free( p )

		p = allocate( 128 )
		p = reallocate( p, 256 )
		deallocate( p )

		p = callocate( 128, 1 )
		deallocate( p )
	END_TEST

END_SUITE
