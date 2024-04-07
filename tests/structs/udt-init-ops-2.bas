#include once "fbcunit.bi"

'' test combinations of constructor / let / cast

SUITE( fbc_tests.structs.udt_init_ops_2 )

	''  Test  Description
	''  ----  ------------------------------
	''   1  dim_as_TU_from_TV
	''   2  byval_as_TU_from_TV, byref_as_TU_from_TV
	''   3  equal_as_TU_from_TV
	''   4  function_equal_from_TV_to_TU
	''   5  return_from_TV_to_TU

	''   6  dim_as_TW_from_TW
	''   7  byval_as_TW_from_TW, byref_as_TW_from_TW
	''   8  equal_as_TW_from_TW
	''   9  function_equal_from_TW_to_TW
	''  10  return_from_TW_to_TW

	''  11  dim_as_TU_from_TW
	''  12  byval_as_TU_from_TW, byref_as_TU_from_TW
	''  13  equal_as_TU_from_TW
	''  14  function_equal_from_TW_to_TU
	''  15  return_from_TW_to_TU

	dim shared as integer id_count
	dim shared as integer id_TU_ctor
	dim shared as integer id_TU_ctor_from_TU
	dim shared as integer id_TU_ctor_from_TV
	dim shared as integer id_TU_ctor_from_TX
	dim shared as integer id_TU_let_from_TU
	dim shared as integer id_TU_let_from_TV
	dim shared as integer id_TU_let_from_TX
	dim shared as integer id_TU_dtor
	dim shared as integer id_TV_cast_to_TU
	dim shared as integer id_TV_cast_to_TX

	sub reset_id_counts()
		id_count = 0
		id_TU_ctor = 0
		id_TU_ctor_from_TU = 0
		id_TU_ctor_from_TV = 0
		id_TU_ctor_from_TX = 0
		id_TU_let_from_TU = 0
		id_TU_let_from_TV = 0
		id_TU_let_from_TX = 0
		id_TU_dtor = 0
		id_TV_cast_to_TU = 0
		id_TV_cast_to_TX = 0
	end sub

	function get_id_count() as integer
		id_count += 1
		return id_count
	end function

	'' for debugging
	#macro dprint ? ( text )
		'' print text
	#endmacro

	'' TX type defined:
	enum TX_type
		TX_as_integer
		TX_as_integer_ptr
		TX_as_string
		TX_as_UDT_with_integer
		TX_as_UDT_with_string
	end enum

	#macro gen_TX_decl( TX_id )

		#if TX_as_integer = TX_id
			type TX as integer
		#endif

		#if TX_as_integer_ptr = TX_id
			type TX as integer ptr
		#endif

		#if TX_as_string = TX_id
			type TX as string
		#endif

		#if TX_as_UDT_with_integer = TX_id
			type TX
				dim as integer I
			end type
		#endif

		#if TX_as_UDT_with_string = TX_id
			type TX
				dim as string s
			end type
		#endif

	#endmacro

	#macro gen_type_decl _
		( _
			ns, _
			TU_ctor_from_TU, _
			TU_ctor_from_TV, _
			TU_ctor_from_TX, _
			TU_let_from_TU, _
			TU_let_from_TV, _
			TU_let_from_TX, _
			TU_dtor, _
			TV_cast_to_TU, _
			TV_cast_to_TX _
		)

		type _TV as TV

		type TU
			dim as integer I
			declare constructor()
			#if TU_ctor_from_TU <> 0
				declare constructor( byref u as TU )
			#endif
			#if TU_ctor_from_TV <> 0
				declare constructor( byref v as _TV )
			#endif
			#if TU_ctor_from_TX <> 0
				declare constructor( byref s as TX )
			#endif
			#if TU_let_from_TU <> 0
				declare operator Let( byref u as TU )
			#endif
			#if TU_let_from_TV <> 0
				declare operator Let( byref v as _TV )
			#endif
			#if TU_let_from_TX <> 0
				declare operator Let( byref s as TX )
			#endif
			#if TU_dtor <> 0
				declare Destructor()
			#endif
		end type

		type TV
			dim as integer I
			#if TV_cast_to_TU <> 0
				declare operator Cast() byref as TU
			#endif
			#if TV_cast_to_TX <> 0
				declare operator Cast() byref as TX
			#endif
		end type

		type TW Extends TU
		end type

		dim shared as TX x0
		dim shared as TU u0
		dim shared as TV v
		dim shared as TW w0

		constructor TU()
			i = 1
			If (@This <> @u0) And (@This <> @w0) Then
				dprint #ns; " ";
				dprint "constructor TU()"
				id_TU_ctor = get_id_count()
			end If
		end constructor


		#if TU_ctor_from_TU <> 0
			constructor TU( byref u as TU )
				dprint #ns; " ";
				dprint "constructor TU( byref u as TU )"
				this.i = u.i
				id_TU_ctor_from_TU = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_TV <> 0
			constructor TU( byref v as TV )
				dprint #ns; " ";
				dprint "constructor TU( byref v as TV )"
				this.i = v.i
				id_TU_ctor_from_TV = get_id_count()
			end constructor
		#endif

		#if TU_ctor_from_TX <> 0
			constructor TU( byref s as TX )
				dprint #ns; " ";
				dprint "constructor TU( byref s as TX )"
				this.i = cint(s)
				id_TU_ctor_from_TX = get_id_count()
			end constructor
		#endif

		#if TU_let_from_TU <> 0
			operator TU.Let( byref u as TU )
				dprint #ns; " ";
				dprint "operator TU.Let( byref u as TU )"
				this.i = u.i
				id_TU_let_from_TU = get_id_count()
			end operator
		#endif

		#if TU_let_from_TV <> 0
			operator TU.Let( byref v as TV )
				dprint #ns; " ";
				dprint "operator TU.Let( byref v as TV )"
				this.i = v.i
				id_TU_let_from_TV = get_id_count()
			end operator
		#endif

		#if TU_let_from_TX <> 0
			operator TU.Let( byref s as TX )
				dprint #ns; " ";
				dprint "operator TU.Let( byref s as TX )"
				this.i = cint(s)
				id_TU_let_from_TX = get_id_count()
			end operator
		#endif

		#if TU_dtor <> 0
			Destructor TU()
			end destructor
		#endif

		#if TV_cast_to_TU <> 0
			operator TV.Cast() byref as TU
				dprint #ns; " ";
				dprint "operator TV.Cast() byref as TU"
				id_TV_cast_to_TU = get_id_count()
				return u0
			end operator
		#endif

		#if TV_cast_to_TX <> 0
			operator TV.Cast() byref as TX
				dprint #ns; " ";
				dprint "operator TV.Cast() byref as TX"
				id_TV_cast_to_TX = get_id_count()
				return x0
			end operator
		#endif

	#endmacro

'' --------------------------------------------------------
''   1  dim_as_TU_from_TV
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

	'' test 1 - 1 - 1
	namespace ns0111
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0111, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_1()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   2  byval_as_TU_from_TV
'' --------------------------------------------------------

	#macro gen_test_2()
	    sub s1(byval u as TU)
	    end sub
	    sub s2(byref u as TU)
	    end sub
		sub do_test1()
	        dprint "'Byval As TU' (from TV):"
			reset_id_counts()
	        s1(v)
		end sub
		sub do_test2()
	        dprint "'Byref As TU' (from TV):"
			reset_id_counts()
	        s2(v)
		end sub
	#endmacro

	'' test 2 - 1 - 1
	namespace ns0211
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0211, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_2()
		sub check()
			do_test1()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )

			do_test2()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   3  equal_as_TU_from_TV
'' --------------------------------------------------------

	#macro gen_test_3()
		sub do_test()
			dim As TU u
	        dprint "'u = v':"
			reset_id_counts()
	        u = v
		end sub
	#endmacro

	'' test 3 - 1 - 1
	namespace ns0311
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0311, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_3()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   4  function_equal_from_TV_to_TU
'' --------------------------------------------------------

	#macro gen_test_4()
		function f11() as TU
			function = v
		end function

		sub do_test()
	        dprint "'function = v' to TU:"
			reset_id_counts()
	        f11()
		end sub
	#endmacro

	'' test 4 - 1 - 1
	namespace ns0411
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0411, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_4()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   5  return_from_TV_to_TU
'' --------------------------------------------------------

	#macro gen_test_5()
		function f12() as TU
			return v
		end function

		sub do_test()
	        dprint "'return v' to TU:"
			reset_id_counts()
	        f12()
		end sub
	#endmacro

	'' test 5 - 1 - 1
	namespace ns0511
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0511, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_5()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   6  dim_as_TW_from_TW
'' --------------------------------------------------------

	#macro gen_test_6()
		sub do_test()
	        dprint "'dim as TW w = w0':"
			reset_id_counts()
	        dim as TW w = w0
		end sub
	#endmacro

	'' test 6 - 1 - 1
	namespace ns0611
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0611, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_6()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   7  byval_as_TW_from_TW
'' --------------------------------------------------------

	#macro gen_test_7()
		sub s21(byval w as TW)
		end sub

		sub do_test()
			dim byref As TW w = w0
	        dprint "'byval as TW' (from TW):"
			reset_id_counts()
	        s21(w)
		end sub
	#endmacro

	'' test 7 - 1 - 1
	namespace ns0711
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0711, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_7()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   8  equal_as_TW_from_TW
'' --------------------------------------------------------

	#macro gen_test_8()
		sub do_test()
			dim byref As TW w = w0
	        dprint "'w = w0':"
			reset_id_counts()
	        w = w0
		end sub
	#endmacro

	'' test 8 - 1 - 1
	namespace ns0811
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0811, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_8()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''   9  function_equal_from_TW_to_TW
'' --------------------------------------------------------

	#macro gen_test_9()
		function f21() as TW
			function = w0
		end function

		sub do_test()
	        dprint "'function = w' to TW:"
			reset_id_counts()
	        f21()
		end sub
	#endmacro

	'' test 9 - 1 - 1
	namespace ns0911
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns0911, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_9()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  10  return_from_TW_to_TW
'' --------------------------------------------------------

	#macro gen_test_10()
		function f22() as TW
			return w0
		end function

		sub do_test()
	        dprint "'return w' to TW:"
			reset_id_counts()
	        f22()
		end sub
	#endmacro

	'' test 10 - 1 - 1
	namespace ns1011
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1011, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_10()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  11  dim_as_TU_from_TW
'' --------------------------------------------------------

	#macro gen_test_11()
		sub do_test()
		    dim Byref as TW w = w0
	        dprint "'dim as TU u = w':"
			reset_id_counts()
	        dim as TU u = w
		end sub
	#endmacro

	'' test 11 - 1 - 1
	namespace ns1111
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1111, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_11()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  12  byval_as_TU_from_TW
'' --------------------------------------------------------

	#macro gen_test_12()
		sub s31(byval u as TU)
		end sub

		sub do_test()
			dim byref As TW w = w0
	        dprint "'byval as TU' (from TW):"
			reset_id_counts()
	        s31(w)
		end sub
	#endmacro

	'' test 12 - 1 - 1
	namespace ns1211
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1211, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_12()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  13  equal_as_TU_from_TW
'' --------------------------------------------------------

	#macro gen_test_13()
		sub do_test()
			dim byref As TW w = w0
			reset_id_counts()
	        u0 = w
		end sub
	#endmacro

	'' test 13 - 1 - 1
	namespace ns1311
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1311, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_13()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 1 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  14  function_equal_from_TW_to_TU
'' --------------------------------------------------------

	#macro gen_test_14()
		function f31() as TU
			function = w0
		end function

		sub do_test()
			reset_id_counts()
	        f31()
		end sub
	#endmacro

	'' test 14 - 1 - 1
	namespace ns1411
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1411, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_14()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 2 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

'' --------------------------------------------------------
''  15  return_from_TW_to_TU
'' --------------------------------------------------------

	#macro gen_test_15()
		function f32() as TU
			return w0
		end function

		sub do_test()
			reset_id_counts()
	        f32()
		end sub
	#endmacro

	'' test 15 - 1 - 1
	namespace ns1511
		gen_TX_decl( TX_as_integer )
		gen_type_decl( ns1511, 1, 1, 1, 1, 1, 1, 1, 1, 1 )
		gen_test_15()
		sub check()
			do_test()
			CU_ASSERT_EQUAL( id_TU_ctor            , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TU    , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TV    , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_from_TX    , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TU     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TV     , 0 )
			CU_ASSERT_EQUAL( id_TU_let_from_TX     , 0 )
			CU_ASSERT_EQUAL( id_TU_dtor            , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TU      , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_to_TX      , 0 )
		end sub
	end namespace

	'' --------------------------------------------------------
	'' perform tests
	'' --------------------------------------------------------

	TEST( default )

		ns0111.check()
		ns0211.check()
		ns0311.check()
		ns0411.check()
		ns0511.check()
		ns0611.check()
		ns0711.check()
		ns0811.check()
		ns0911.check()
		ns1011.check()
		ns1111.check()
		ns1211.check()
		ns1311.check()
		ns1411.check()
		ns1511.check()

	END_TEST

END_SUITE
