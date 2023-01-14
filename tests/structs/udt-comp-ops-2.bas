#include once "fbcunit.bi"

'' tests comst combinations of constructor / cast with integer / long
'' for comparison operation between udt and integer / long

SUITE( fbc_tests.structs.udt_comp_ops_2 )

	'' TU_ctor_from_TV               '' A
	'' TU_ctor_from_string           '' B
	'' TV_cast_to_TU                 '' C
	'' TV_cast_to_string             '' D
	'' op_inequal_from_TU_from_TU    '' E
	'' op_inequal_from_TU_from_TV    '' F

	''  Priority 1      F
	''  Priority 2     C+E
	''  Priority 3     A+E
	''  Priority 4    D+B+E

	dim shared as integer id_count
	dim shared as integer id_UDT_constructor
	dim shared as integer id_UDT_destructor
	dim shared as integer id_TU_ctor_from_TV             '' A
	dim shared as integer id_TU_ctor_from_string         '' B
	dim shared as integer id_TV_cast_to_TU               '' C
	dim shared as integer id_TV_cast_to_string           '' D
	dim shared as integer id_op_inequal_from_TU_from_TU  '' E
	dim shared as integer id_op_inequal_from_TU_from_TV  '' F

	sub reset_id_counts()
		id_count = 0
		id_UDT_constructor = 0
		id_UDT_destructor = 0
		id_TU_ctor_from_TV = 0
		id_TU_ctor_from_string = 0
		id_TV_cast_to_TU = 0
		id_TV_cast_to_string = 0
		id_op_inequal_from_TU_from_TU = 0
		id_op_inequal_from_TU_from_TV = 0
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
			TU_ctor_from_TV, _
			TU_ctor_from_string, _
			TV_cast_to_TU, _
			TV_cast_to_string, _
			op_inequal_from_TU_from_TU, _
			op_inequal_from_TU_from_TV _
		)

		type _TV as TV

		type TU
			dim as integer I
			declare constructor()
			#if TU_ctor_from_TV <> 0
				declare constructor(byref v as _TV)
			#endif
			#if TU_ctor_from_string <> 0
				declare constructor(byref s as String)
			#endif
			declare destructor()
		end type

		type TV
			dim as integer I
			#if TV_cast_to_TU <> 0
				declare operator cast() byref as TU
			#endif
			#if TV_cast_to_string <> 0
				declare operator cast() as string
			#endif
		end type

		dim shared byref_u as TU

		constructor TU()
			if( @this <> @byref_u ) then
				dprint #ns; " ";
				dprint "    constructor UDT()"
				id_UDT_constructor = get_id_count()
			end if
		end constructor

		#if TU_ctor_from_TV <> 0
			constructor TU(byref v as TV)
				dprint #ns; " ";
				dprint "    constructor TU(byref as TV)"
				id_TU_ctor_from_TV = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_string <> 0
			constructor TU(byref s as string)
				if( @this <> @byref_u ) then
					dprint #ns; " ";
					dprint "    constructor TU(byref as string)"
					id_TU_ctor_from_string = get_id_count()
				end if
			end constructor
		#endif

		destructor TU()
			if( @this <> @byref_u ) then
				dprint #ns; " ";
				dprint "  destructor TU()"
				id_UDT_destructor = get_id_count()
			end if
		end destructor

		#if TV_cast_to_TU <> 0
			operator TV.cast() byref as TU
				dprint #ns; " ";
				dprint "    operator TV.cast() byref as TU"
				id_TV_cast_to_TU = get_id_count()
				Return byref_u
			end operator
		#endif

		#if TV_cast_to_string <> 0
			operator TV.cast() as string
				dprint #ns; " ";
				dprint "    operator TV.cast() byref as String"
				id_TV_cast_to_string = get_id_count()
				Return ""
			end operator
		#endif

		#if op_inequal_from_TU_from_TU <> 0
			operator <>(byref ul as TU, byref ur as TU) as integer
				dprint #ns; " ";
				dprint "    operator <>(byref as TU, byref as TU) as integer"
				id_op_inequal_from_TU_from_TU = get_id_count()
				Return ul.i <> ur.i
			end operator
		#endif

		#if op_inequal_from_TU_from_TV <> 0
			operator <>(byref ul as TU, byref vr as TV) as integer
				dprint #ns; " ";
				dprint "    operator <>(byref as TU, byref as TV) as integer"
				id_op_inequal_from_TU_from_TV = get_id_count()
				Return ul.i <> vr.i
			end operator
		#endif

	#endmacro

	'' --------------------------------------------------------
	'' priority 1
	'' --------------------------------------------------------

	#macro gen_test_1()
		sub do_test1()
			reset_id_counts()
			dim as TU u
			dim as TV v
			u.i = 1
			dim as boolean result
			dprint "'if u <> v then'"
			if u <> v then
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
			dim as TU u
			dim as TV v
			u.i = 1
			dim as boolean result
			dprint "'result = u <> v'"
			result = u <> v
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
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 2 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 3 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 2 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 2
	'' --------------------------------------------------------

	namespace ns2
		gen_type_decl( ns2, 1, 1, 1, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 4 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 3 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 4 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 3 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 3
	'' --------------------------------------------------------

	namespace ns3
		gen_type_decl( ns3, 1, 1, 0, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 2 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 3 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 5 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 2 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 0 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 3 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

		end sub
	end namespace

	'' --------------------------------------------------------
	'' priority 4
	'' --------------------------------------------------------

	namespace ns4
		gen_type_decl( ns4, 0, 1, 0, 1, 1, 0 )
		gen_test_1()
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 6 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 2 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 4 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_UDT_constructor                   , 1 )
			CU_ASSERT_EQUAL( id_UDT_destructor                    , 6 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV                   , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string               , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU                     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string                 , 2 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TU        , 4 )
			CU_ASSERT_EQUAL( id_op_inequal_from_TU_from_TV        , 0 )

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

	END_TEST

END_SUITE
