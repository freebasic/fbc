#include "fbcunit.bi"

SUITE( fbc_tests.pointers.typedef_fwd )

	type foo as bar

	type sometype
		f as foo ptr
	end type

	type bar
		st as sometype
		a as integer
	end type

	TEST( all )

		dim s as sometype, b as bar
  
		b.st.f = @b
		s.f = @b
  
		s.f->st.f->a = 1234
  
		CU_ASSERT_EQUAL( s.f->st.f->a, 1234 )

		type y as z ptr
		dim f1 as y, f2 as y ptr, f3 as y ptr ptr

		type z as short
		dim n as short

		f1 = @n
		f2 = @f1
		f3 = @f2

		***f3 = 123

		CU_ASSERT_EQUAL( sizeof(f1), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(*f1), sizeof(short) )

		CU_ASSERT_EQUAL( sizeof(f2), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(*f2), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(**f2), sizeof(short) )

		CU_ASSERT_EQUAL( sizeof(f3), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(*f3), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(**f3), sizeof(any ptr) )
		CU_ASSERT_EQUAL( sizeof(***f3), sizeof(short) )

		CU_ASSERT_EQUAL( sizeof(z), sizeof(short) )
		CU_ASSERT_EQUAL( sizeof(n), sizeof(short) )

		CU_ASSERT_EQUAL( ***f3, 123 )

	END_TEST

END_SUITE
