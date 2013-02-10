# include once "fbcu.bi"
# include once "crt.bi"

namespace fbc_tests.crt.malloc_

sub test cdecl( )
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
end sub

sub ctor( ) constructor
	fbcu.add_suite( "tests/crt/malloc" )
	fbcu.add_test( "test", @test )
end sub

end namespace
