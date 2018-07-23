# include "fbcunit.bi"

SUITE( fbc_tests.compound.for_udt_init )

	dim shared as integer ctor_count, dtor_count

	type T
		as integer x

		declare constructor( )
		declare constructor( byref rhs as T )
		declare constructor( byval x as integer )

		declare operator let( byref rhs as T )

		declare operator for( )
		declare operator for( byref stp as T )

		declare operator step( )
		declare operator step( byref stp as T )

		declare operator next( byref end_cond as T ) as integer
		declare operator next( byref end_cond as T, byref stp as T ) as integer

		declare destructor( )
	end type

	constructor T( )
		ctor_count += 1
	end constructor

	constructor T( byref rhs as T )
		ctor_count += 1
		this.x = rhs.x
	end constructor

	constructor T( byval x as integer )
		ctor_count += 1
		this.x = x
	end constructor

	operator T.let( byref rhs as T )
		this.x = rhs.x
	end operator

	operator T.for( )
	end operator

	operator T.for( byref stp as T )
	end operator

	operator T.step( )
		this.x += 1
	end operator

	operator T.step( byref stp as T )
		this.x += stp.x
	end operator

	operator T.next( byref end_cond as T ) as integer
		return (this.x <= end_cond.x)
	end operator

	operator T.next( byref end_cond as T, byref stp as T ) as integer
		return (this.x <= end_cond.x)
	end operator

	destructor T( )
		dtor_count += 1
	end destructor

	TEST( udt_init )
		'' Side note: FOR should use an implicit scope for the iterator and
		'' any temporaries

		'' The iterator object should be constructed with the start value,
		'' the end value should be put into a second (temporary) object,
		'' to avoid side-effects in case it's a expression containing function
		'' calls etc.
		CU_ASSERT( ctor_count = 0 )
		CU_ASSERT( dtor_count = 0 )
		for i as T = 0 to 0
		next
		CU_ASSERT( ctor_count = 2 )
		CU_ASSERT( dtor_count = 2 )

		scope
			dim as T endvalue
			CU_ASSERT( ctor_count = 3 )
			CU_ASSERT( dtor_count = 2 )
			scope
				for i as T = 1 to endvalue
				next
				CU_ASSERT( ctor_count = 5 )
				CU_ASSERT( dtor_count = 4 )
			end scope
		end scope
		CU_ASSERT( ctor_count = 5 )
		CU_ASSERT( dtor_count = 5 )

		scope
			dim as T startvalue
			CU_ASSERT( ctor_count = 6 )
			CU_ASSERT( dtor_count = 5 )
			scope
				for i as T = startvalue to 0
				next
				CU_ASSERT( ctor_count = 8 )
				CU_ASSERT( dtor_count = 7 )
			end scope
		end scope
		CU_ASSERT( ctor_count = 8 )
		CU_ASSERT( dtor_count = 8 )

		scope
			dim as T startvalue, endvalue
			CU_ASSERT( ctor_count = 10 )
			CU_ASSERT( dtor_count = 8 )
			scope
				for i as T = startvalue to endvalue
				next
				CU_ASSERT( ctor_count = 12 )
				CU_ASSERT( dtor_count = 10 )
			end scope
		end scope
		CU_ASSERT( ctor_count = 12 )
		CU_ASSERT( dtor_count = 12 )
	END_TEST

END_SUITE
