#include once "fbcunit.bi"

SUITE( fbc_tests.pointers.procptr_member )

	enum PROCID
		PID_NONE
		PID_ctor_noargs
		PID_ctor_byref_as_const_T
		PID_ctor_byval_as_integer
		PID_dtor_noargs
		PID_let_byref_as_const_T
		PID_let_byval_as_integer
		PID_add_byref_as_const_T
		PID_add_byval_as_integer
		PID_proc_noargs
		PID_proc_byref_as_const_T
		PID_proc_byval_as_integer
		PID_proc_byref_as_string
		PID_func_noargs
		PID_func_byref_as_const_T
		PID_func_byval_as_integer
		PID_func_byref_as_string
		PID_prop_get_integer
		PID_prop_set_integer
		PID_prop_get_string
		PID_prop_set_string
		PID_prop_get_index_integer
		PID_prop_set_index_integer
		PID_prop_get_index_string
		PID_prop_set_index_string
		PID_index_byref_as_const_T
		PID_index_byval_as_integer
		PID_cast_single
		PID_cast_integer
		PID_cast_string
	end enum

	dim shared last_called as PROCID
	dim shared last_value as integer

	type T
		n as integer

		declare constructor()
		declare constructor( byref x as const T )
		declare constructor( byval x as integer )
		declare destructor()

		declare operator let( byref x as const T )
		declare operator let( byval x as integer )

		declare operator +=( byref x as const T )
		declare operator +=( byval x as integer )

		declare sub proc()
		declare sub proc( byref x as const T )
		declare sub proc( byval x as integer )
		declare sub proc( byref x as string )

		declare function func() as integer
		declare function func( byref x as const T ) as integer
		declare function func( byval x as integer ) as integer
		declare function func( byref x as string ) as integer

		declare property propi() as integer
		declare property propi( byval x as integer )
		declare property props() as string
		declare property props( byref x as string )
		declare property propxi( byval index as integer ) as integer
		declare property propxi( byval index as integer, byval x as integer )
		declare property propxs( byval index as integer ) as string
		declare property propxs( byval index as integer, byref x as string )

		declare operator []( byref i as const T ) as integer
		declare operator []( byval i as integer ) as integer

		declare operator cast() as single
		declare operator cast() as integer
		declare operator cast() as string
	end type

	constructor T()
		n = 1
		last_called = PID_ctor_noargs
	end constructor

	constructor T( byref x as const T)
		n = x.n + 1
		last_called = PID_ctor_byref_as_const_T
	end constructor

	constructor T( byval x as integer )
		n = x
		last_called = PID_ctor_byval_as_integer
	end constructor

	destructor T()
		last_called = PID_dtor_noargs
		last_value = n
	end destructor

	operator T.let( byref x as const T )
		n = x.n
		last_called = PID_let_byref_as_const_T
	end operator

	operator T.let( byval x as integer )
		n = x
		last_called = PID_let_byval_as_integer
	end operator

	operator T.+=( byref x as const T )
		n += x.n
		last_called = PID_add_byref_as_const_T
	end operator

	operator T.+=( byval x as integer )
		n += x
		last_called = PID_add_byval_as_integer
	end operator

	sub T.proc()
		last_called = PID_proc_noargs
	end sub

	sub T.proc( byref x as const T )
		last_called = PID_proc_byref_as_const_T
	end sub

	sub T.proc( byval x as integer )
		last_called = PID_proc_byval_as_integer
	end sub

	sub T.proc( byref x as string )
		last_called = PID_proc_byref_as_string
	end sub

	function T.func() as integer
		last_called = PID_func_noargs
		return 0
	end function

	function T.func( byref x as const T ) as integer
		last_called = PID_func_byref_as_const_T
		return 0
	end function

	function T.func( byval x as integer ) as integer
		last_called = PID_func_byval_as_integer
		return 0
	end function

	function T.func( byref x as string ) as integer
		last_called = PID_func_byref_as_string
		return 0
	end function

	property T.propi() as integer
		last_called = PID_prop_get_integer
		return 0
	end property

	property T.propi( byval x as integer )
		last_called = PID_prop_set_integer
	end property

	property T.props() as string
		last_called = PID_prop_get_string
		return ""
	end property

	property T.props( byref x as string )
		last_called = PID_prop_set_string
	end property

	property T.propxi( byval index as integer ) as integer
		last_called = PID_prop_get_index_integer
		return 0
	end property

	property T.propxi( byval index as integer, byval x as integer )
		last_called = PID_prop_set_index_integer
	end property

	property T.propxs( byval index as integer ) as string
		last_called = PID_prop_get_index_string
		return ""
	end property

	property T.propxs( byval index as integer, byref x as string )
		last_called = PID_prop_set_index_string
	end property

	operator T.[]( byref i as const T ) as integer
		last_called = PID_index_byref_as_const_T
		return 0
	end operator

	operator T.[]( byval i as integer ) as integer
		last_called = PID_index_byval_as_integer
		return 0
	end operator

	operator T.cast() as single
		last_called = PID_cast_single
		return 0
	end operator

	operator T.cast() as integer
		last_called = PID_cast_integer
		return 0
	end operator

	operator T.cast() as string
		last_called = PID_cast_string
		return ""
	end operator

	TEST( address )
		'' constructor/destructor
		scope
			var fp_ctor_first = procptr( T.constructor )
			var fp_ctor_noargs = procptr( T.constructor, sub() )
			var fp_ctor_udt_T = procptr( T.constructor, sub( byref as const T ) )
			var fp_ctor_integer = procptr( T.constructor, sub( byval as integer ) )

			var fp_dtor_first = procptr( T.destructor )
			var fp_dtor_noargs = procptr( T.destructor, sub() )

			CU_ASSERT( fp_ctor_first = fp_ctor_noargs )
			CU_ASSERT( fp_ctor_noargs <> fp_ctor_udt_T )
			CU_ASSERT( fp_ctor_noargs <> fp_ctor_integer )
			CU_ASSERT( fp_ctor_udt_T <> fp_ctor_integer )

			CU_ASSERT( fp_dtor_first = fp_dtor_noargs )
		end scope

		'' operator let, +=
		scope
			var fp_op_let_first = procptr( T.let )
			var fp_op_let_udt_T = procptr( T.let, sub( byref as const T) )
			var fp_op_let_integer = procptr( T.let, sub( byval as integer) )

			var fp_op_add_first = procptr( T.+= )
			var fp_op_add_udt_T = procptr( T.+=, sub( byref as const T) )
			var fp_op_add_integer = procptr( T.+=, sub( byval as integer) )

			CU_ASSERT( fp_op_let_first = fp_op_let_udt_T )
			CU_ASSERT( fp_op_let_udt_T <> fp_op_let_integer )

			CU_ASSERT( fp_op_add_first = fp_op_add_udt_T )
			CU_ASSERT( fp_op_add_udt_T <> fp_op_add_integer )
		end scope

		'' member procedure/function
		scope
			var fp_proc_first = procptr( T.proc )
			var fp_proc_noargs = procptr( T.proc, sub() )
			var fp_proc_byref_as_const_T = procptr( T.proc, sub( byref as const T ) )
			var fp_proc_byval_as_integer = procptr( T.proc, sub( byval as integer ) )
			var fp_proc_byref_as_string = procptr( T.proc, sub( byref as string ) )

			CU_ASSERT( fp_proc_first = fp_proc_noargs )
			CU_ASSERT( fp_proc_noargs <> fp_proc_byref_as_const_T )
			CU_ASSERT( fp_proc_noargs <> fp_proc_byval_as_integer )
			CU_ASSERT( fp_proc_noargs <> fp_proc_byref_as_string )
			CU_ASSERT( fp_proc_byref_as_const_T <> fp_proc_byval_as_integer )
			CU_ASSERT( fp_proc_byref_as_const_T <> fp_proc_byref_as_string )
			CU_ASSERT( fp_proc_byval_as_integer <> fp_proc_byref_as_string )

			var fp_func_first = procptr( T.func )
			var fp_func_noargs = procptr( T.func, function() as integer )
			var fp_func_byref_as_const_T = procptr( T.func, function( byref as const T ) as integer )
			var fp_func_byval_as_integer = procptr( T.func, function( byval as integer ) as integer )
			var fp_func_byref_as_string = procptr( T.func, function( byref as string ) as integer )

			CU_ASSERT( fp_func_first = fp_func_noargs )
			CU_ASSERT( fp_func_noargs <> fp_func_byref_as_const_T )
			CU_ASSERT( fp_func_noargs <> fp_func_byval_as_integer )
			CU_ASSERT( fp_func_noargs <> fp_func_byref_as_string )
			CU_ASSERT( fp_func_byref_as_const_T <> fp_func_byval_as_integer )
			CU_ASSERT( fp_func_byref_as_const_T <> fp_func_byref_as_string )
			CU_ASSERT( fp_func_byval_as_integer <> fp_func_byref_as_string )
		end scope

		'' property
		scope
			var fp_prop_first_integer = procptr( T.propi )
			var fp_prop_get_integer = procptr( T.propi, function() as integer )
			var fp_prop_set_integer = procptr( T.propi, sub( byval as integer ) )

			CU_ASSERT( fp_prop_first_integer = fp_prop_get_integer )
			CU_ASSERT( fp_prop_get_integer <> fp_prop_set_integer )

			var fp_prop_first_string = procptr( T.props )
			var fp_prop_get_string = procptr( T.props, function() as string )
			var fp_prop_set_string = procptr( T.props, sub( byref as string ) )

			CU_ASSERT( fp_prop_first_string = fp_prop_get_string )
			CU_ASSERT( fp_prop_get_string <> fp_prop_set_string )
			CU_ASSERT( fp_prop_get_string <> fp_prop_get_integer )
			CU_ASSERT( fp_prop_get_string <> fp_prop_set_integer )
			CU_ASSERT( fp_prop_set_string <> fp_prop_get_integer )
			CU_ASSERT( fp_prop_set_string <> fp_prop_set_integer )
			'' note (not exhaustive comparisons)

			var fp_prop_first_index_integer = procptr( T.propxi )
			var fp_prop_get_index_integer = procptr( T.propxi, function( byval index as integer ) as integer )
			var fp_prop_set_index_integer = procptr( T.propxi, sub( byval index as integer, byval as integer ) )

			CU_ASSERT( fp_prop_first_index_integer = fp_prop_get_index_integer )
			CU_ASSERT( fp_prop_get_index_integer <> fp_prop_set_index_integer )
			CU_ASSERT( fp_prop_get_index_integer <> fp_prop_get_integer )
			CU_ASSERT( fp_prop_get_index_integer <> fp_prop_set_integer )
			CU_ASSERT( fp_prop_set_index_integer <> fp_prop_get_integer )
			CU_ASSERT( fp_prop_set_index_integer <> fp_prop_set_integer )
			'' note (not exhaustive comparisons)

			var fp_prop_first_index_string = procptr( T.propxs )
			var fp_prop_get_index_string = procptr( T.propxs, function( byval index as integer ) as string )
			var fp_prop_set_index_string = procptr( T.propxs, sub( byval index as integer, byref as string ) )

			CU_ASSERT( fp_prop_first_index_string = fp_prop_get_index_string )
			CU_ASSERT( fp_prop_get_index_string <> fp_prop_set_index_string )
			CU_ASSERT( fp_prop_get_index_string <> fp_prop_get_string )
			CU_ASSERT( fp_prop_get_index_string <> fp_prop_set_string )
			CU_ASSERT( fp_prop_set_index_string <> fp_prop_get_string )
			CU_ASSERT( fp_prop_set_index_string <> fp_prop_set_string )
			'' note (not exhaustive comparisons)
		end scope

		'' operator []
		scope
			var fp_op_index_first = procptr( T.[] )
			var fp_op_index_udt_T = procptr( T.[], function( byref as const T) as integer )
			var fp_op_index_integer = procptr( T.[], function( byval as integer) as integer )

			CU_ASSERT( fp_op_index_first = fp_op_index_udt_T )
			CU_ASSERT( fp_op_index_udt_T <> fp_op_index_integer )
		end scope

		'' operator cast()
		scope
			var fp_op_cast_first = procptr( T.cast )
			var fp_op_cast_single = procptr( T.cast, function() as single )
			var fp_op_cast_integer = procptr( T.cast, function() as integer )
			var fp_op_cast_string = procptr( T.cast, function() as string )

			CU_ASSERT( fp_op_cast_first = fp_op_cast_single )
			CU_ASSERT( fp_op_cast_single <> fp_op_cast_integer )
			CU_ASSERT( fp_op_cast_integer <> fp_op_cast_string )
		end scope
	END_TEST

	TEST( typeof_ )
		type tfp_ctor_noargs as sub cdecl( byref as T )
		type tfp_ctor_udt_T as sub cdecl( byref as T, byref as const T )
		type tfp_ctor_integer as sub cdecl( byref as T, byval as integer )
		type tfp_dtor_noargs as sub cdecl( byref as T )

		#if typeof( tfp_ctor_noargs ) = typeof( procptr( T.constructor ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_ctor_noargs ) = typeof( procptr( T.constructor, sub() ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_ctor_udt_T ) = typeof( procptr( T.constructor, sub( byref as const T ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_ctor_integer ) = typeof( procptr( T.constructor, sub( byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_dtor_noargs ) = typeof( procptr( T.destructor ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_dtor_noargs ) = typeof( procptr( T.destructor, sub() ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_op_let_udt_T as sub( byref as T, byref as const T )
		type tfp_op_let_integer as sub( byref as T, byval as integer )

		#if typeof( tfp_op_let_udt_T ) = typeof( procptr( T.let, sub( byref as const T ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_op_let_integer ) = typeof( procptr( T.let, sub( byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_op_add_udt_T as sub( byref as T, byref as const T )
		type tfp_op_add_integer as sub( byref as T, byval as integer )

		#if typeof( tfp_op_add_udt_T ) = typeof( procptr( T.+=, sub( byref as const T ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_op_add_integer ) = typeof( procptr( T.+=, sub( byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_proc_noargs as sub( byref as T )
		type tfp_proc_byref_as_const_T as sub( byref as T, byref as const T )
		type tfp_proc_byval_as_integer as sub( byref as T, byval as integer )
		type tfp_proc_byref_as_string as sub( byref as T, byref as string )

		#if typeof( tfp_proc_noargs ) = typeof( procptr( T.proc, sub() ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_proc_byref_as_const_T ) = typeof( procptr( T.proc, sub( byref as const T ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_proc_byval_as_integer ) = typeof( procptr( T.proc, sub( byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_proc_byref_as_string ) = typeof( procptr( T.proc, sub( byref as string ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_func_noargs as function( byref as T ) as integer
		type tfp_func_byref_as_const_T as function( byref as T, byref as const T ) as integer
		type tfp_func_byval_as_integer as function( byref as T, byval as integer ) as integer
		type tfp_func_byref_as_string as function( byref as T, byref as string ) as integer

		#if typeof( tfp_func_noargs ) = typeof( procptr( T.func, function() as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_func_byref_as_const_T ) = typeof( procptr( T.func, function( byref as const T ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_func_byval_as_integer ) = typeof( procptr( T.func, function( byval as integer ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_func_byref_as_string ) = typeof( procptr( T.func, function( byref as string ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_propi_get_integer as function( byref as T ) as integer
		type tfp_propi_set_integer as sub( byref as T, byval as integer )
		type tfp_props_get_string as function( byref as T ) as string
		type tfp_props_set_string as sub( byref as T, byref as string )
		type tfp_propi_get_index_integer as function( byref as T, byval as integer ) as integer
		type tfp_propi_set_index_integer as sub( byref as T, byval as integer, byval as integer )
		type tfp_props_get_index_string as function( byref as T, byval as integer ) as string
		type tfp_props_set_index_string as sub( byref as T, byval as integer, byref as string )

		#if typeof( tfp_propi_get_integer ) = typeof( procptr( T.propi, function() as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_propi_set_integer ) = typeof( procptr( T.propi, sub( byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_props_get_string ) = typeof( procptr( T.props, function() as string ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_props_set_string ) = typeof( procptr( T.props, sub( byref as string ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_propi_get_index_integer ) = typeof( procptr( T.propxi, function( byval as integer ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_propi_set_index_integer ) = typeof( procptr( T.propxi, sub( byval as integer, byval as integer ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_props_get_index_string ) = typeof( procptr( T.propxs, function( byval as integer ) as string ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_props_set_index_string ) = typeof( procptr( T.propxs, sub( byval as integer, byref as string ) ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_op_index_udt_T as function( byref as T, byref as const T ) as integer
		type tfp_op_index_integer as function( byref as T, byval as integer ) as integer

		#if typeof( tfp_op_index_udt_T ) = typeof( procptr( T.[], function( byref as const T ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_op_index_integer ) = typeof( procptr( T.[], function( byval as integer ) as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		type tfp_op_cast_single as function( byref as T ) as single
		type tfp_op_cast_integer as function( byref as T ) as integer
		type tfp_op_cast_string as function( byref as T ) as string

		#if typeof( tfp_op_cast_single ) = typeof( procptr( T.cast, function() as single ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_op_cast_integer ) = typeof( procptr( T.cast, function() as integer ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

		#if typeof( tfp_op_cast_string ) = typeof( procptr( T.cast, function() as string ) )
			CU_PASS()
		#else
			CU_FAIL()
		#endif

	END_TEST

	TEST( calling1 )
		dim ret as integer = 0
		dim sret as string = ""

		'' T.constructor/destructor
		var fp_ctor_noargs = procptr( T.constructor, sub() )
		var fp_ctor_byref_as_const_T = procptr( T.constructor, sub( byref as const T ) )
		var fp_ctor_byval_as_integer = procptr( T.constructor, sub( byval as integer ) )

		var fp_dtor_noargs = procptr( T.destructor, sub() )

		'' T.=
		var fp_op_let_byref_as_const_T = procptr( T.let, sub( byref as const T ) )
		var fp_op_let_byval_as_integer = procptr( T.let, sub( byval as integer ) )

		'' T.+=
		var fp_op_add_byref_as_const_T = procptr( T.+=, sub( byref as const T ) )
		var fp_op_add_byval_as_integer = procptr( T.+=, sub( byval as integer ) )

		'' T.proc
		var fp_proc_noargs = procptr( T.proc, sub() )
		var fp_proc_byref_as_const_T = procptr( T.proc, sub( byref as const T ) )
		var fp_proc_byval_as_integer = procptr( T.proc, sub( byval as integer ) )
		var fp_proc_byref_as_string = procptr( T.proc, sub( byref as string ) )

		'' T.func
		var fp_func_noargs = procptr( T.func, function() as integer )
		var fp_func_byref_as_const_T = procptr( T.func, function( byref as const T ) as integer )
		var fp_func_byval_as_integer = procptr( T.func, function( byval as integer ) as integer )
		var fp_func_byref_as_string = procptr( T.func, function( byref as string ) as integer )

		'' T.propi, props, propxi, propxs
		var fp_prop_get_integer = procptr( T.propi, function() as integer )
		var fp_prop_set_integer = procptr( T.propi, sub( byval as integer ) )
		var fp_prop_get_string = procptr( T.props, function() as string )
		var fp_prop_set_string = procptr( T.props, sub( byval as string ) )
		var fp_prop_get_index_integer = procptr( T.propxi, function( byval as integer ) as integer )
		var fp_prop_set_index_integer = procptr( T.propxi, sub( byval as integer, byval as integer ) )
		var fp_prop_get_index_string = procptr( T.propxs, function( byval as integer ) as string )
		var fp_prop_set_index_string = procptr( T.propxs, sub( byval as integer, byval as string ) )

		'' T.[]
		var fp_op_index_byref_as_const_T = procptr( T.[], function( byref as const T ) as integer )
		var fp_op_index_byval_as_integer = procptr( T.[], function( byval as integer ) as integer )

		'' T.cast
		var fp_op_cast_single = procptr( T.cast, function( ) as single )
		var fp_op_cast_integer = procptr( T.cast, function( ) as integer )
		var fp_op_cast_string = procptr( T.cast, function( ) as string )

		'' initialize space
		dim a as T ptr = callocate( sizeof(T) )
		dim b as T ptr = callocate( sizeof(T) )
		dim c as T ptr = callocate( sizeof(T) )

		'' constructor/destructor
		fp_ctor_noargs( *a )
		CU_ASSERT_EQUAL( last_called, PID_ctor_noargs )
		CU_ASSERT_EQUAL( a->n, 1 )

		fp_ctor_byref_as_const_T( *b, *a )
		CU_ASSERT_EQUAL( last_called, PID_ctor_byref_as_const_T )
		CU_ASSERT_EQUAL( b->n, 2 )

		fp_ctor_byval_as_integer( *c, 3 )
		CU_ASSERT_EQUAL( last_called, PID_ctor_byval_as_integer )
		CU_ASSERT_EQUAL( c->n, 3 )

		'' assignment
		fp_op_let_byref_as_const_T( *a, *b )
		CU_ASSERT_EQUAL( last_called, PID_let_byref_as_const_T )
		CU_ASSERT_EQUAL( a->n, 2 )

		fp_op_let_byval_as_integer( *a, 3 )
		CU_ASSERT_EQUAL( last_called, PID_let_byval_as_integer )
		CU_ASSERT_EQUAL( a->n, 3 )

		'' self addition
		a->n = 2
		b->n = 3
		c->n = 7

		fp_op_add_byref_as_const_T( *a, *b )
		CU_ASSERT_EQUAL( last_called, PID_add_byref_as_const_T )
		CU_ASSERT_EQUAL( a->n, 5 )

		fp_op_add_byval_as_integer( *c, 11 )
		CU_ASSERT_EQUAL( last_called, PID_add_byval_as_integer )
		CU_ASSERT_EQUAL( c->n, 18 )

		'' procedure member
		fp_proc_noargs( *a )
		CU_ASSERT_EQUAL( last_called, PID_proc_noargs )

		fp_proc_byref_as_const_T( *a, *b )
		CU_ASSERT_EQUAL( last_called, PID_proc_byref_as_const_T )

		fp_proc_byval_as_integer( *a, 11 )
		CU_ASSERT_EQUAL( last_called, PID_proc_byval_as_integer )

		fp_proc_byref_as_string( *a, "" )
		CU_ASSERT_EQUAL( last_called, PID_proc_byref_as_string )

		'' function member
		ret = fp_func_noargs( *a )
		CU_ASSERT_EQUAL( last_called, PID_func_noargs )

		ret = fp_func_byref_as_const_T( *a, *b )
		CU_ASSERT_EQUAL( last_called, PID_func_byref_as_const_T )

		ret = fp_func_byval_as_integer( *a, 11 )
		CU_ASSERT_EQUAL( last_called, PID_func_byval_as_integer )

		ret = fp_func_byref_as_string( *a, "" )
		CU_ASSERT_EQUAL( last_called, PID_func_byref_as_string )

		'' properties
		ret = fp_prop_get_integer( *a )
		CU_ASSERT_EQUAL( last_called, PID_prop_get_integer )

		fp_prop_set_integer( *a, 11 )
		CU_ASSERT_EQUAL( last_called, PID_prop_set_integer )

		sret = fp_prop_get_string( *a )
		CU_ASSERT_EQUAL( last_called, PID_prop_get_string )

		fp_prop_set_string( *a, "" )
		CU_ASSERT_EQUAL( last_called, PID_prop_set_string )

		ret = fp_prop_get_index_integer( *a, 1 )
		CU_ASSERT_EQUAL( last_called, PID_prop_get_index_integer )

		fp_prop_set_index_integer( *a, 2, 11 )
		CU_ASSERT_EQUAL( last_called, PID_prop_set_index_integer )

		sret = fp_prop_get_index_string( *a, 3 )
		CU_ASSERT_EQUAL( last_called, PID_prop_get_index_string )

		fp_prop_set_index_string( *a, 4, "" )
		CU_ASSERT_EQUAL( last_called, PID_prop_set_index_string )

		'' T.[]
		ret = fp_op_index_byref_as_const_T( *a, *b )
		CU_ASSERT_EQUAL( last_called, PID_index_byref_as_const_T )

		ret = fp_op_index_byval_as_integer( *a, 11 )
		CU_ASSERT_EQUAL( last_called, PID_index_byval_as_integer )

		'' T.cast
		ret = fp_op_cast_single( *a )
		CU_ASSERT_EQUAL( last_called, PID_cast_single )

		ret = fp_op_cast_integer( *a )
		CU_ASSERT_EQUAL( last_called, PID_cast_integer )

		sret = fp_op_cast_string( *a )
		CU_ASSERT_EQUAL( last_called, PID_cast_string )

		'' destructor
		a->n = 1
		b->n = 2
		c->n = 3

		fp_dtor_noargs( *a )
		CU_ASSERT_EQUAL( last_called, PID_dtor_noargs )
		CU_ASSERT_EQUAL( last_value, 1 )

		fp_dtor_noargs( *b )
		CU_ASSERT_EQUAL( last_called, PID_dtor_noargs )
		CU_ASSERT_EQUAL( last_value, 2 )

		fp_dtor_noargs( *c )
		CU_ASSERT_EQUAL( last_called, PID_dtor_noargs )
		CU_ASSERT_EQUAL( last_value, 3 )

		deallocate a
		deallocate b
		deallocate c

	END_TEST

END_SUITE
