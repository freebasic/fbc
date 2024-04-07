#include once "fbcunit.bi"

'' This code allows to check the precedence of the
'' constructors/operators for some operations
'' involving UDT pointer types

'' for debugging
#macro dprint ? ( text )
	'' print text
#endmacro

#macro gen_type_decl _
	( _
		TU_CTOR_STRING, _
		TU_LET_BYREF_TU, _
		TU_CTOR_BYREF_TU, _
		TV_CTOR_BYVAL_TU_PTR, _
		TV_CAST_TU_PTR, _
		TV_CAST_STRING _
	)

	type TU extends object
		#if TU_CTOR_STRING <> 0
			declare constructor ( byref s As String = "" )
		#endif
		#if TU_LET_BYREF_TU <> 0
			declare operator let( byref r as TU )
		#endif
		#if TU_CTOR_BYREF_TU <> 0
			declare constructor( byref r as TU )
		#endif
	end type

	type TV
		o as TU ptr
		#if TV_CTOR_BYVAL_TU_PTR <> 0
			declare constructor ( byval p as TU ptr )
		#endif
		#if TV_CAST_TU_PTR <> 0
			declare operator cast() as TU ptr
		#endif
		#if TV_CAST_STRING <> 0
			declare operator cast() as string
		#endif
	end type

	#if TU_CTOR_STRING <> 0
		constructor TU( byref s as string = "" )
			id_TU_ctor_string = get_id_count()
		end constructor
	#endif

	#if TU_LET_BYREF_TU <> 0
		operator TU.let( byref r as TU )
			id_TU_let_byref_TU = get_id_count()
		end operator
	#endif

	#if TU_CTOR_BYREF_TU <> 0
		constructor TU( byref r as TU )
			id_TU_ctor_byref_TU = get_id_count()
		end constructor
	#endif

	#if TV_CTOR_BYVAL_TU_PTR <> 0
		constructor TV( byval p as TU ptr )
			o = p
			id_TV_ctor_byval_TU_ptr = get_id_count()
		end constructor
	#endif

	#if TV_CAST_TU_PTR <> 0
		operator TV.cast() as TU ptr
			id_TV_cast_TU_ptr = get_id_count()
			return o
		end operator
	#endif

	#if TV_CAST_STRING <> 0
		operator TV.cast() as string
			id_TV_cast_string = get_id_count()
			return ""
		end operator
	#endif

#endmacro

SUITE( fbc_tests.structs.udt_ops_4 )

	dim shared as integer id_count

	dim shared as integer id_TU_ctor_string
	dim shared as integer id_TU_let_byref_TU
	dim shared as integer id_TU_ctor_byref_TU
	dim shared as integer id_TV_ctor_byval_TU_ptr
	dim shared as integer id_TV_cast_TU_ptr
	dim shared as integer id_TV_cast_string

	sub reset_id_counts()
		id_count = 0
		id_TU_ctor_string = 0
		id_TU_let_byref_TU = 0
		id_TU_ctor_byref_TU = 0
		id_TV_ctor_byval_TU_ptr = 0
		id_TV_cast_TU_ptr = 0
		id_TV_cast_string = 0
	end sub

	function get_id_count() as integer
		id_count += 1
		return id_count
	end function

	namespace ns1
		gen_type_decl( 1, 1, 1, 1, 1, 1 )

		sub test_byval_TU_ptr( byval p as TU ptr )
		end sub

		sub test_byref_TU_ptr( byref p as TU ptr )
		end sub

		sub check()
			reset_id_counts()
			dim as TV x = cast( TU ptr, &hBAD00DBA )
			CU_ASSERT_EQUAL( id_count                , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_string       , 0 )
			CU_ASSERT_EQUAL( id_TU_let_byref_TU      , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_byref_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_ctor_byval_TU_ptr , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_TU_ptr       , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_string       , 0 )

			reset_id_counts()
			test_byval_TU_ptr( x )
			CU_ASSERT_EQUAL( id_count                , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_string       , 0 )
			CU_ASSERT_EQUAL( id_TU_let_byref_TU      , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_byref_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_ctor_byval_TU_ptr , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_TU_ptr       , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_string       , 0 )

			reset_id_counts()
			test_byref_TU_ptr( x )
			CU_ASSERT_EQUAL( id_count                , 1 )
			CU_ASSERT_EQUAL( id_TU_ctor_string       , 0 )
			CU_ASSERT_EQUAL( id_TU_let_byref_TU      , 0 )
			CU_ASSERT_EQUAL( id_TU_ctor_byref_TU     , 0 )
			CU_ASSERT_EQUAL( id_TV_ctor_byval_TU_ptr , 0 )
			CU_ASSERT_EQUAL( id_TV_cast_TU_ptr       , 1 )
			CU_ASSERT_EQUAL( id_TV_cast_string       , 0 )
		end sub

	end namespace

	TEST( default )
		ns1.check()
	END_TEST

END_SUITE
