#include "fbcunit.bi"

SUITE( fbc_tests.overload_.op_ctor_coercion_2 )

	const CALLED_NONE = 0
	const CALLED_CTOR = 1
	const CALLED_CTOR_STRING = 2
	const CALLED_CTOR_STRUCT = 3
	const CALLED_CAST_STRING = 4

	namespace N1
		type T
			public:
				dim as integer result1
				dim as integer result2
				declare constructor(byref s as string)
				declare constructor(byref arg as T)
				declare constructor()
			private:
				declare operator cast() as string
		end type

		constructor T()
			result1 = CALLED_CTOR
		end constructor

		constructor T(byref s as string)
			result1 = CALLED_CTOR_STRING
		end constructor

		constructor T(byref arg as T)
			result1 = CALLED_CTOR_STRUCT
		end constructor

		operator T.cast() as string
			result2 = CALLED_CAST_STRING
			return ""
		end operator
	end namespace

	TEST(no_cast_ctor)
		dim as N1.T x1
		CU_ASSERT_EQUAL( x1.result1, CALLED_CTOR )
		CU_ASSERT_EQUAL( x1.result2, CALLED_NONE )

		dim as N1.T x2 = "hello"
		CU_ASSERT_EQUAL( x2.result1, CALLED_CTOR_STRING )
		CU_ASSERT_EQUAL( x2.result2, CALLED_NONE )

		dim as N1.T x3 = x1
		CU_ASSERT_EQUAL( x3.result1, CALLED_CTOR_STRUCT )
		CU_ASSERT_EQUAL( x1.result2, CALLED_NONE )
	END_TEST

END_SUITE
