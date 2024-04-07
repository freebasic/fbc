#include once "fbcunit.bi"

'' This code allows to check the precedence of the
'' constructors/operators (among the eleven)

SUITE( fbc_tests.structs.udt_ops_3 )

	#include once "udt-ops-check.bi"

	'' Conversion with Inheritance (w -> u with TU <- TW)
	namespace ns1
		gen_TX_decl( ns1, TX_as_string )
		gen_type_decl( ns1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 )

		'' dim_as_TU_from_TW
		sub do_test01()
			reset_id_counts()
			dprint "'dim As TU u = w':"
			dim As TU u = w0
		end sub

		'' byval_as_TU_from_TW
		sub s31(Byval u As TU)
		end sub

		'' byval_as_TU_from_TW
		sub do_test02()
			reset_id_counts()
			dprint "'Byval As TU' (from TW):"
			s31(w0)
		end sub

		'' equal_as_TU_from_TW
		sub do_test03()
			reset_id_counts()
			dprint "'u = w':"
			u0 = w0
		end sub

		'' function_equal_from_TW_to_TU
		function f31() As TU
			function = w0
		end function

		'' function_equal_from_TW_to_TU
		sub do_test04()
			reset_id_counts()
			dprint "'function = w' to TU:"
			f31()
		end sub

		'' return_from_TW_to_TU
		function f32() As TU
			return w0
		end function

		'' return_from_TW_to_TU
		sub do_test05()
			reset_id_counts()
			dprint "'return w' to TU:"
			f32()
		end sub

		sub check()

			dprint "----- Conversion with Inheritance (w -> u with TU <- TW) "

			'' dim_as_TU_from_TW
			do_test01()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' byval_as_TU_from_TW
			do_test02()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' equal_as_TU_from_TW
			do_test03()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' function_equal_from_TW_to_TU
			do_test04()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' return_from_TW_to_TU
			do_test05()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

		end sub

	end namespace

	'' --------------------------------------------------------
	'' perform tests
	'' --------------------------------------------------------

	TEST( default )

		ns1.check()

	END_TEST

END_SUITE
