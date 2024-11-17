#include "fbcunit.bi"

SUITE( fbc_tests.structs.obj_property_idx_byref )

	type A
	    num as integer
	end type

	type B
	    num as integer
	    declare property p( byval index as long ) byref as A
	end type

	type C
	    num as integer
	    declare property p( byval index as long ) byref as A
	    declare property p( byval index as long, byref value as A )
	end type

	type D
	    num as integer
	    declare property q( byval index as long ) byref as C
	    declare property q( byval index as long, byref value as C )
	end type

	dim shared g0A as A = ( 10 )
	dim shared g0B as B = ( 20 )
	dim shared g0C as C = ( 30 )
	dim shared g0D as D = ( 40 )

	dim shared g1A as A = ( 11 )
	dim shared g1B as B = ( 21 )
	dim shared g1C as C = ( 31 )
	dim shared g1D as D = ( 41 )

	property B.p( byval index as long ) byref as A
		if( index = 0 ) then
			return g0A
		end if
		return g1A
	end property

	property C.p( byval index as long ) byref as A
		if( index = 0 ) then
			return g0A
		end if
		return g1A
	end property

	property C.p( byval index as long, byref value as A )
		if( index = 0 ) then
			g0A = value
			return
		end if
		g1A = value
	end property

	property D.q( byval index as long ) byref as C
		if( index = 0 ) then
			return g0C
		end if
		return g1C
	end property

	property D.q( byval index as long, byref value as C )
		if( index = 0 ) then
			g0C = value
			return
		end if
		g1C = value
	end property

	TEST( all )

		dim w0 as A = ( 100 )
		dim x0 as B = ( 200 )
		dim y0 as C = ( 300 )
		dim z0 as D = ( 400 )

		CU_ASSERT( w0.num = 100 )

		CU_ASSERT( x0.num = 200 )
		CU_ASSERT( x0.p(0).num = 10 )
		CU_ASSERT( x0.p(1).num = 11 )

		CU_ASSERT( y0.num = 300 )
		CU_ASSERT( y0.p(0).num = 10 )
		CU_ASSERT( y0.p(1).num = 11 )

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 10 )
		CU_ASSERT( z0.q(0).p(1).num = 11 )
		CU_ASSERT( z0.q(1).p(0).num = 10 )
		CU_ASSERT( z0.q(1).p(1).num = 11 )

		dim w1 as A = ( 101 )

		y0.p(0) = w1

		CU_ASSERT( y0.num = 300 )
		CU_ASSERT( y0.p(0).num = 101 )
		CU_ASSERT( y0.p(1).num = 11 )

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 101 )
		CU_ASSERT( z0.q(0).p(1).num = 11 )
		CU_ASSERT( z0.q(1).p(0).num = 101 )
		CU_ASSERT( z0.q(1).p(1).num = 11 )

		dim w2 as A = ( 102 )

		y0.p(1).num = w2.num

		CU_ASSERT( y0.num = 300 )
		CU_ASSERT( y0.p(0).num = 101 )
		CU_ASSERT( y0.p(1).num = 102 )

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 101 )
		CU_ASSERT( z0.q(0).p(1).num = 102 )
		CU_ASSERT( z0.q(1).p(0).num = 101 )
		CU_ASSERT( z0.q(1).p(1).num = 102 )

		dim y1 as C = ( 301 )

		z0.q(0) = y1

		CU_ASSERT( y0.num = 300 )
		CU_ASSERT( y0.p(0).num = 101 )
		CU_ASSERT( y0.p(1).num = 102 )

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 101 )
		CU_ASSERT( z0.q(0).p(1).num = 102 )
		CU_ASSERT( z0.q(1).p(0).num = 101 )
		CU_ASSERT( z0.q(1).p(1).num = 102 )

		dim y2 as C = ( 302 )

		z0.q(0).num = y2.num

		CU_ASSERT( y0.num = 300 )
		CU_ASSERT( y0.p(0).num = 101 )
		CU_ASSERT( y0.p(1).num = 102 )

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 101 )
		CU_ASSERT( z0.q(0).p(1).num = 102 )
		CU_ASSERT( z0.q(1).p(0).num = 101 )
		CU_ASSERT( z0.q(1).p(1).num = 102 )


		dim w3 as A = ( 103 )

		z0.q(0).p(0) = w3

		CU_ASSERT( z0.num = 400 )
		CU_ASSERT( z0.q(0).p(0).num = 103 )
		CU_ASSERT( z0.q(0).p(1).num = 102 )
		CU_ASSERT( z0.q(1).p(0).num = 103 )
		CU_ASSERT( z0.q(1).p(1).num = 102 )

	END_TEST

END_SUITE
