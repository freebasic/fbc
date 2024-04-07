#include once "fbcunit.bi"

'' test combinations of constructor / let / cast

SUITE( fbc_tests.structs.udt_init_ops_1 )

	''  Test  Description
	''  ----  ------------------------------
	''   1    dim_as_TU_from_TV
	''   2    byval_as_TU_from_TV, byref_as_TU_from_TV
	''   3    equal_as_TU_from_TV
	''   4    function_equal_from_TV_to_TU
	''   5    return_from_TV_to_TU

	dim shared as integer id_count
	dim shared as integer id_TU_ctor
	dim shared as integer id_TU_ctor_from_TV
	dim shared as integer id_TU_ctor_from_string
	dim shared as integer id_TU_let_from_TV
	dim shared as integer id_TU_let_from_string
	dim shared as integer id_TU_ctor_from_TU
	dim shared as integer id_TU_let_from_TU
	dim shared as integer id_TV_cast_to_string
	dim shared as integer id_TV_cast_to_TU

	sub reset_id_counts()
		id_count = 0
		id_TU_ctor = 0
		id_TU_ctor_from_TV = 0
		id_TU_ctor_from_string = 0
		id_TU_let_from_TV = 0
		id_TU_let_from_string = 0
		id_TU_ctor_from_TU = 0
		id_TU_let_from_TU = 0
		id_TV_cast_to_string = 0
		id_TV_cast_to_TU = 0
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
			TU_let_from_TV, _
			TU_let_from_string, _
			TU_ctor_from_TU, _
			TU_let_from_TU, _
			TV_cast_to_string, _
			TV_cast_to_TU _
		)

		type _TV as TV

		type TU
			dim as integer i
			#if TU_ctor_from_TV
				declare constructor( byref v as _TV )
			#endif
			#if TU_ctor_from_string
					declare constructor( byref s as string )
			#endif
			#if TU_let_from_TV
				declare operator let( byref v as _TV )
			#endif
			#if TU_let_from_string
				declare operator let( byref s as string )
			#endif

			declare constructor()
			#if TU_ctor_from_TU
				declare constructor( byref u as TU )
			#endif
			#if TU_let_from_TU
				declare operator let( byref u as TU )
			#endif
		end type

		type TV
			dim as integer i
			#if TV_cast_to_string
				declare operator Cast() as string
			#endif
			#if TV_cast_to_TU
				declare operator Cast() as TU
			#endif
		end type

		dim Shared as TU u0
		dim Shared as TV v

		#if TU_ctor_from_TV <> 0
			constructor TU( byref v as TV )
				dprint #ns; " ";
				dprint "constructor TU( byref v as TV )"
				this.i = v.i
				id_TU_ctor_from_TV = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_string <> 0
			constructor TU( byref s as string )
				dprint #ns; " ";
				dprint "constructor TU( byref s as string )"
				this.i = val(s)
				id_TU_ctor_from_string = get_id_count()
			end constructor
		#endif

		#if TU_let_from_TV <> 0
			operator TU.let( byref v as TV )
				dprint #ns; " ";
				dprint "operator TU.let( byref v as TV )"
				this.i = v.i
				id_TU_let_from_TV = get_id_count()
			end operator
		#endif

		#if TU_let_from_string <> 0
			operator TU.let( byref s as string )
				dprint #ns; " ";
				dprint "operator TU.let( byref s as string )"
				this.i = val(s)
				id_TU_let_from_string = get_id_count()
			end operator
		#endif

		constructor TU()
			dprint #ns; " ";
			dprint "constructor TU()"
			i = 1
			id_TU_ctor = get_id_count()
		end constructor

		#if TU_ctor_from_TU <> 0
			constructor TU( byref u as TU )
				dprint #ns; " ";
				dprint "constructor TU( byref u as TU )"
				this.i = u.i
				id_TU_ctor_from_TU = get_id_count()
			end constructor
		#endif

		#if TU_let_from_TU <> 0
			operator TU.let( byref u as TU )
				dprint #ns; " ";
				dprint "operator TU.let( byref u as TU )"
				this.i = u.i
				id_TU_let_from_TU = get_id_count()
			end operator
		#endif

		#if TV_cast_to_string <> 0
			operator TV.Cast() as string
				dprint #ns; " ";
				dprint "operator TV.Cast() as string"
				id_TV_cast_to_string = get_id_count()
				return str(this.i)
			end operator
		#endif

		#if TV_cast_to_TU <> 0
			operator TV.Cast() as TU
				dprint #ns; " ";
				dprint "operator TV.Cast() as TU"
				id_TV_cast_to_TU = get_id_count()
				return u0
			end operator
		#endif

	#endmacro

	'' --------------------------------------------------------
	'' dim_as_TU_from_TV
	'' --------------------------------------------------------

	#macro gen_test_1()
		sub do_test()
			dprint "'dim as TU u = v':"
			reset_id_counts()
			v.i = 1
			dim as TU u = v
			CU_ASSERT_EQUAL( u.i, 1 )
		end sub
	#endmacro

	'' test 1 - 1
	namespace ns11
		gen_type_decl( ns11, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_1()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 1 - 2
	namespace ns12
		gen_type_decl( ns12, 0, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_1()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 1 - 3
	namespace ns13
		gen_type_decl( ns13, 0, 0, 1, 1, 1, 1, 0, 1 )
		gen_test_1()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 3 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

#if 0
	'' invalid data types

	'' test 1 - 4
	namespace ns14
		gen_type_decl( ns14, 0, 0, 1, 1, 1, 1, 0, 0 )
		gen_test_1()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace
#endif

	'' --------------------------------------------------------
	'' byval_as_TU_from_TV, byref_as_TU_from_TV
	'' --------------------------------------------------------

	#macro gen_test_2()
		sub s1(byval u as TU)
		end sub
		sub s2(byref u as TU)
		end sub
		sub do_test1()
			dprint "'byval as TU' (from TV):"
			reset_id_counts()
			s1(v)
		end sub
		sub do_test2()
			dprint "'byref as TU' (from TV):"
			reset_id_counts()
			s2(v)
		end sub
	#endmacro

	'' test 2 - 1
	namespace ns21
		gen_type_decl( ns21, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

	'' test 2 - 2
	namespace ns22
		gen_type_decl( ns22, 1, 1, 1, 1, 1, 1, 1, 0 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 2 - 3
	namespace ns23
		gen_type_decl( ns23, 0, 1, 1, 1, 1, 1, 1, 0 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 2 - 4
	namespace ns24
		gen_type_decl( ns24, 1, 1, 0, 0, 0, 0, 1, 1 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

	'' test 2 - 5
	namespace ns25
		gen_type_decl( ns25, 1, 1, 0, 0, 0, 0, 1, 0 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 2 - 6
	namespace ns26
		gen_type_decl( ns26, 1, 0, 0, 0, 0, 0, 0, 0 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 2 - 7
	namespace ns27
		gen_type_decl( ns27, 1, 1, 0, 0, 0, 0, 0, 1 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

	'' --------------------------------------------------------
	'' equal_as_TU_from_TV
	'' --------------------------------------------------------

	#macro gen_test_3()
		sub do_test()
			dim u as TU
			dprint "'u = v':"
			reset_id_counts()
			u = v
		end sub
	#endmacro

	'' test 3 - 1
	namespace ns31
		gen_type_decl( ns31, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_3()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 3 - 2
	namespace ns32
		gen_type_decl( ns32, 1, 1, 0, 1, 1, 1, 1, 1 )
		gen_test_3()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 2 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 3 - 3
	namespace ns33
		gen_type_decl( ns33, 1, 1, 0, 0, 1, 1, 0, 1 )
		gen_test_3()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

	'' test 3 - 4
	namespace ns34
		gen_type_decl( ns34, 1, 1, 0, 0, 1, 1, 0, 0 )
		gen_test_3()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' --------------------------------------------------------
	'' function_equal_from_TV_to_TU
	'' --------------------------------------------------------

	#macro gen_test_4()
		function f1() as TU
			function = v
		end function
		sub do_test()
			dprint "'function = v' to TU:"
			reset_id_counts()
			f1()
		end sub
	#endmacro

	'' test 4 - 1
	namespace ns41
		gen_type_decl( ns41, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_4()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 4 - 2
	namespace ns42
		gen_type_decl( ns42, 1, 1, 0, 1, 1, 1, 1, 1 )
		gen_test_4()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 3 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 2 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 4 - 3
	namespace ns43
		gen_type_decl( ns43, 1, 1, 0, 0, 1, 1, 0, 1 )
		gen_test_4()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 3 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 4 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 2 )
		end sub
	end namespace

	'' test 4 - 4
	namespace ns44
		gen_type_decl( ns44, 1, 1, 0, 0, 1, 1, 0, 0 )
		gen_test_4()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 2 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' --------------------------------------------------------
	'' return_from_TV_to_TU
	'' --------------------------------------------------------

	#macro gen_test_5()
		function f2() as TU
			return v
		end function
		sub do_test()
			dprint "'return v' to TU:"
			reset_id_counts()
			f2()
		end sub
	#endmacro

	'' test 5 - 1
	namespace ns51
		gen_type_decl( ns51, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 5 - 2
	namespace ns52
		gen_type_decl( ns52, 0, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 5 - 3
	namespace ns53
		gen_type_decl( ns53, 0, 0, 1, 1, 1, 1, 0, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 3 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
		end sub
	end namespace

	'' test 5 - 4
	namespace ns54
		gen_type_decl( ns54, 0, 0, 1, 1, 1, 1, 0, 0 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 5 - 3a
	namespace ns53a
		gen_type_decl( ns53a, 0, 0, 1, 1, 0, 1, 0, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
		end sub
	end namespace

	'' test 5 - 4a
	namespace ns54a
		gen_type_decl( ns54a, 0, 0, 0, 1, 0, 1, 0, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_string, 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_string , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 3 )
			CU_ASSERT_EQUAL( id_TV_cast_to_string  , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 2 )
		end sub
	end namespace

	'' --------------------------------------------------------
	'' perform tests
	'' --------------------------------------------------------

	TEST( default )

		ns11.check()
		ns12.check()
		ns13.check()
#if 0
		ns14.check()
#endif
		ns21.check()
		ns22.check()
		ns23.check()
		ns24.check()
		ns25.check()
		ns26.check()
		ns27.check()

		ns31.check()
		ns32.check()
		ns33.check()
		ns34.check()

		ns41.check()
		ns42.check()
		ns43.check()
		ns44.check()

		ns51.check()
		ns52.check()
		ns53.check()
		ns54.check()
		ns53a.check()
		ns54a.check()

	END_TEST

END_SUITE
