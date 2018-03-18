#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.nop )

	dim shared as integer x = 0

	TEST( conditional_branch_bop )
		dim as integer i, j

		'' Expression should be optimized to plain "j" variable access
		if j or (i and 0) then
			'' Should not be reached
			x = 333
		end if
		CU_ASSERT( x = 0 )

		j = 1
		if j or (i and 0) then
			x = 333
		end if
		CU_ASSERT( x = 333 )

		x = 0
		CU_ASSERT( x = 0 )
		if i = i then
			x = 1
		else
			x = 2
		end if
		CU_ASSERT( x = 1 )

		x = 0
		CU_ASSERT( x = 0 )
		if i <> i then
			x = 1
		else
			x = 2
		end if
		CU_ASSERT( x = 2 )

		x = 0
		CU_ASSERT( x = 0 )
		if 1 then
			x = 1
		else
			x = 2
		end if
		CU_ASSERT( x = 1 )

		x = 0
		CU_ASSERT( x = 0 )
		if 0 then
			x = 1
		else
			x = 2
		end if
		CU_ASSERT( x = 2 )

		x = 0
		CU_ASSERT( x = 0 )
		if 1 then
			x = 1
		end if
		CU_ASSERT( x = 1 )
	END_TEST

	TEST( double_uop )
		'' -gen gcc regression test
		'' Negating a relational operation:
		''    -(foo = bar)
		'' should compile to
		''    -(-(foo == bar))
		'' and definitly not
		''    --(foo == bar)
		'' because -- is the decrement operator.
		dim as integer i

		CU_ASSERT(   (i = 0)  = (-1) )
		CU_ASSERT( (-(i = 0)) =   1  )

		CU_ASSERT( (-1) =   (i = 0)  )
		CU_ASSERT(   1  = (-(i = 0)) )

		i = 123
		CU_ASSERT(   (i = 0)  = 0 )
		CU_ASSERT( (-(i = 0)) = 0 )

		CU_ASSERT( 0 =   (i = 0)  )
		CU_ASSERT( 0 = (-(i = 0)) )

		i = -1
		CU_ASSERT( i = -1 )
		CU_ASSERT( (not i) = 0 )
		CU_ASSERT( (not (not i)) = -1 )
		CU_ASSERT( (not (not (not i))) = 0 )
		CU_ASSERT( (not (not (not (not i)))) = -1 )
		CU_ASSERT( (not (not (not (not (not i))))) = 0 )
		CU_ASSERT( (not (not (not (not (not (not i)))))) = -1 )

		i = 123
		dim as integer ptr p = @i
		dim as integer ptr ptr pp = @p
		dim as integer ptr ptr ptr ppp = @pp

		CU_ASSERT( i = 123 )
		CU_ASSERT( p = @i )
		CU_ASSERT( pp = @p )
		CU_ASSERT( ppp = @pp )

		CU_ASSERT( *p = 123 )
		CU_ASSERT( *p = i )
		CU_ASSERT( **pp = 123 )
		CU_ASSERT( **pp = i )
		CU_ASSERT( ***ppp = 123 )
		CU_ASSERT( ***ppp = i )

		CU_ASSERT( *pp = @i )
		CU_ASSERT( **ppp = @i )
		CU_ASSERT( *ppp = @p )
	END_TEST

END_SUITE
