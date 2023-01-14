#include once "fbcunit.bi"

'' tests comst combinations of constructor / cast with udt / string
'' comparison between udt and udt

SUITE( fbc_tests.structs.udt_comp_ops_1 )

	'' UDT_ctor_from_integer               '' A
	'' UDT_ctor_from_long                  '' B
	'' UDT_cast_to_integer                 '' C
	'' UDT_cast_to_long                    '' D
	'' inequality_between_UDT_and_UDT      '' E
	'' inequality_between_UDT_and_integer  '' F

	''  Priority 1      F
	''  Priority 2     A+E
	''  Priority 3     B+E
	''  Priority 4      C
	''  Priority 5      D

	dim shared as integer id_count
	dim shared as integer id_UDT_constructor
	dim shared as integer id_UDT_destructor
	dim shared as integer id_UDT_ctor_from_integer               '' A
	dim shared as integer id_UDT_ctor_from_long                  '' B
	dim shared as integer id_UDT_cast_to_integer                 '' C
	dim shared as integer id_UDT_cast_to_long                    '' D
	dim shared as integer id_inequality_between_UDT_and_UDT      '' E
	dim shared as integer id_inequality_between_UDT_and_integer  '' F

	sub reset_id_counts()
		id_count = 0
		id_UDT_constructor = 0
		id_UDT_destructor = 0
		id_UDT_ctor_from_integer = 0
		id_UDT_ctor_from_long = 0
		id_UDT_cast_to_integer = 0
		id_UDT_cast_to_long = 0
		id_inequality_between_UDT_and_UDT = 0
		id_inequality_between_UDT_and_integer = 0
	end sub

	function get_id_count() as integer
		id_count += 1
		return id_count
	end function

	'' for debugging
	#macro dprint ? ( text )
		'' print text
	#endmacro

	#macro gen_type_decl _
		( _
			ns, _
			UDT_ctor_from_integer, _
			UDT_ctor_from_long, _
			UDT_cast_to_integer, _
			UDT_cast_to_long, _
			inequality_between_UDT_and_UDT, _
			inequality_between_UDT_and_integer _
		)

		type UDT
			dim as integer I
			declare constructor()
			#if UDT_ctor_from_integer <> 0
				declare constructor(byval i as integer)
			#endif
			#if UDT_ctor_from_long <> 0
				declare constructor(byval l as long)
			#endif
			#if UDT_cast_to_integer <> 0
				declare operator cast() as integer
			#endif
			#if UDT_cast_to_long <> 0
				declare operator cast() as long
			#endif
			declare destructor()
		end type

		constructor UDT()
			dprint #ns; " ";
			dprint "   'constructor UDT()'"
			id_UDT_constructor = get_id_count()
		end constructor

		#if UDT_ctor_from_integer <> 0
			constructor UDT(byval i as integer)
				dprint #ns; " ";
				dprint "   'constructor UDT(byval as integer)'"
				id_UDT_ctor_from_integer = get_id_count()
				this.I = i
			end constructor
		#endif

		#if UDT_ctor_from_long <> 0
			constructor UDT(byval l as long)
				dprint #ns; " ";
				dprint "   'constructor UDT(byval as long)'"
				id_UDT_ctor_from_long = get_id_count()
				this.I = l
			end constructor
		#endif

		#if UDT_cast_to_integer <> 0
			operator UDT.cast() as integer
				dprint #ns; " ";
				dprint "   'operator UDT.cast() as integer'"
				id_UDT_cast_to_integer = get_id_count()
				return this.I
			end operator
		#endif

		#if UDT_cast_to_long <> 0
			operator UDT.cast() as long
				dprint #ns; " ";
				dprint "   'operator UDT.cast() as long'"
				id_UDT_cast_to_long = get_id_count()
				return this.I
			end operator
		#endif

		destructor UDT()
			dprint #ns; " ";
			dprint "   'destructor UDT()'"
			id_UDT_destructor = get_id_count()
		end destructor

		#if inequality_between_UDT_and_UDT <> 0
			operator <>(byref ul as UDT, byref ur as UDT) as integer
				dprint #ns; " ";
				dprint "   'operator <>(byref as UDT, byref as UDT) as integer'"
				id_inequality_between_UDT_and_UDT = get_id_count()
				return ul.I <> ur.I
			end operator
		#endif

		#if inequality_between_UDT_and_integer <> 0
			operator <>(byref ul as UDT, byref ir as integer) as integer
				dprint #ns; " ";
				dprint "   'operator <>(byref as UDT, byref as integer) as integer'"
				id_inequality_between_UDT_and_integer = get_id_count()
				return ul.I <> ir
			end operator
		#endif

	#endmacro

	'' --------------------------------------------------------
	'' priority 1
	'' --------------------------------------------------------

	#macro gen_test_1()
		sub do_test1()
			reset_id_counts()
			dim as UDT u
			u.i = 1
			dim as boolean result
			dprint "'if u <> 0 then'"
			if u <> 0 then
				result = true
			else
				result = false
			end if
			CU_ASSERT_EQUAL( result, true )
		end sub
	#endmacro

	#macro gen_test_2()
		sub do_test2()
			reset_id_counts()
			dim as UDT u
			u.i = 1
			dim as boolean result
			dprint "'result = u <> 0'"
			result = u <> 0
			CU_ASSERT_EQUAL( result, true )
		end sub
	#endmacro

	#macro gen_test_3()
		sub do_test3()
			reset_id_counts()
			dim as UDT u
			u.i = 1
			dim as boolean result
			dprint "'if u <> 0L then'"
			if u <> 0L then
				result = true
			else
				result = false
			end if
			CU_ASSERT_EQUAL( result, true )
		end sub
	#endmacro

	#macro gen_test_4()
		sub do_test4()
			reset_id_counts()
			dim as UDT u
			u.i = 1
			dim as boolean result
			dprint "'result = u <> 0L'"
			result = u <> 0L
			CU_ASSERT_EQUAL( result, true )
		end sub
	#endmacro

	'' --------------------------------------------------------
	'' priority 1
	'' --------------------------------------------------------

	namespace ns1
		gen_type_decl( ns1, 1, 1, 1, 1, 1, 1 )
		gen_test_1()
		gen_test_2()
		gen_test_3()
		gen_test_4()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 2 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 2 )

			do_test3()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 2 )

			do_test4()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 2 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 2
	'' --------------------------------------------------------

	namespace ns2
		gen_type_decl( ns2, 1, 1, 1, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		gen_test_3()
		gen_test_4()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 2 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 2 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test3()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test4()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 3
	'' --------------------------------------------------------

	namespace ns3
		gen_type_decl( ns3, 0, 1, 1, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		gen_test_3()
		gen_test_4()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test3()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test4()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 3 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 4
	'' --------------------------------------------------------

	namespace ns4
		gen_type_decl( ns4, 0, 0, 1, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		gen_test_3()
		gen_test_4()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 2 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test3()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test4()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 5
	'' --------------------------------------------------------

	namespace ns5
		gen_type_decl( ns5, 0, 0, 0, 1, 0, 0 )
		gen_test_1()
		gen_test_2()
		gen_test_3()
		gen_test_4()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 6 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 4 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 6 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 4 )

			do_test3()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

			do_test4()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_integer             , 0 )
			CU_ASSERT_EQUAL( id_UDT_ctor_from_long                , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_integer               , 0 )
			CU_ASSERT_EQUAL( id_UDT_cast_to_long                  , 2 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_UDT    , 0 )
			CU_ASSERT_EQUAL( id_inequality_between_UDT_and_integer, 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' perform tests
	'' --------------------------------------------------------

	TEST( default )

		ns1.check()
		ns2.check()
		ns3.check()
		ns4.check()
		ns5.check()

	END_TEST

END_SUITE
