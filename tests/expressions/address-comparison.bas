#include "fbcu.bi"

namespace fbc_tests.expressions.address_comparison

private sub test cdecl( )
	dim as integer i1, i2
	static as integer si1, si2

	'' Testing code generation for comparing involving OFS vregs

	CU_ASSERT( @i1 =  @i1  )
	CU_ASSERT( @i1 <> @i2  )
	CU_ASSERT( @i1 <> @si1 )
	CU_ASSERT( @i1 <> @si2 )

	CU_ASSERT( @i2 <> @i1  )
	CU_ASSERT( @i2 =  @i2  )
	CU_ASSERT( @i2 <> @si1 )
	CU_ASSERT( @i2 <> @si2 )

	CU_ASSERT( @si1 <> @i1  )
	CU_ASSERT( @si1 <> @i2  )
	CU_ASSERT( @si1 =  @si1 )
	CU_ASSERT( @si1 <> @si2 )

	CU_ASSERT( @si2 <> @i1  )
	CU_ASSERT( @si2 <> @i2  )
	CU_ASSERT( @si2 <> @si1 )
	CU_ASSERT( @si2 =  @si2 )

	if @i1 = @i1  then : end if
	if @i1 = @i2  then : end if
	if @i1 = @si1 then : end if
	if @i1 = @si2 then : end if

	if @i2 = @i1  then : end if
	if @i2 = @i2  then : end if
	if @i2 = @si1 then : end if
	if @i2 = @si2 then : end if

	if @si1 = @i1  then : end if
	if @si1 = @i2  then : end if
	if @si1 = @si1 then : end if
	if @si1 = @si2 then : end if

	if @si2 = @i1  then : end if
	if @si2 = @i2  then : end if
	if @si2 = @si1 then : end if
	if @si2 = @si2 then : end if
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.expressions.address-comparison" )
	fbcu.add_test( "test", @test )
end sub

end namespace
