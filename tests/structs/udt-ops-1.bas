#include once "fbcunit.bi"

'' This code allows to check the precedence of the
'' constructors/operators (among the eleven)

SUITE( fbc_tests.structs.udt_ops_1 )

	#include once "udt-ops-check.bi"

	'' Conversion (v -> u)
	namespace ns1

		gen_TX_decl( ns1, TX_as_integer )
		gen_type_decl( ns1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 )

		'' dim_as_TU_from_TV
		sub do_test01()
			reset_id_counts()
			dprint "'dim As TU u = v':"
			dim As TU u = v0
		end sub

		'' byval_as_TU_from_TV
		sub s1(Byval u As TU)
		end sub

		'' byval_as_TU_from_TV
		sub do_test02()
			reset_id_counts()
			dprint "'Byval As TU' (from TV):"
			s1(v0)
		end sub

		'' byref_as_TU_from_TV
		sub s2(Byref u As TU)
		end sub

		'' byref_as_TU_from_TV
		sub do_test03()
			reset_id_counts()
			dprint "'Byref As TU' (from TV):"
			s2(v0)
		end sub

		'' equal_as_TU_from_TV
		sub do_test04()
			reset_id_counts()
			dprint "'u = v':"
			u0 = v0
		end sub

		'' function_equal_from_TV_to_TU
		function f11() As TU
			function = v0
		end function

		'' function_equal_from_TV_to_TU
		sub do_test05()
			reset_id_counts()
			dprint "'function = v' to TU:"
			f11()
		end sub

		'' return_from_TV_to_TU
		function f12() As TU
			return v0
		end function

		'' return_from_TV_to_TU
		sub do_test06()
			reset_id_counts()
			dprint "'return v' to TU:"
			f12()
		end sub

		'' inequal_from_TU_from_TU
		sub do_test07()
			reset_id_counts()
			dim u as TU
			u.i = 1
			u0.i = 2
			dim as boolean result
			dprint "'u <> u0':"
			if u <> u0 then
				result = true
			else
				result = false
			end if
			CU_ASSERT_EQUAL( result, true )
		end sub

		'' inequal_from_TU_from_TV
		sub do_test08()
			reset_id_counts()
			u0.i = 1
			v0.i = 2
			dim as boolean result
			dprint "'u0 <> v0':"
			if u0 <> v0 then
				result = true
			else
				result = false
			end if
			CU_ASSERT_EQUAL( result, true )
		end sub

		sub check()
			dprint "-------------------- Conversion (v -> u) ----------------"
			dprint

			'' dim_as_TU_from_TV
			do_test01()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' byval_as_TU_from_TV
			do_test02()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' byref_as_TU_from_TV
			do_test03()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' equal_as_TU_from_TV
			do_test04()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' function_equal_from_TV_to_TU
			do_test05()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' return_from_TV_to_TU
			do_test06()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' inequal_from_TU_from_TU
			do_test07()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 2 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 0 )

			'' inequal_from_TU_from_TV
			do_test08()
			CU_ASSERT_EQUAL( id_TU_constructor                  , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                 , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX                 , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV                  , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX                  , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor                         , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                   , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX                   , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU      , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV      , 1 )
		end sub

	end namespace

	'' --------------------------------------------------------
	'' perform tests
	'' --------------------------------------------------------

	TEST( default )

		ns1.check()

	END_TEST

END_SUITE
