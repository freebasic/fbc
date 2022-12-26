#include "fbcunit.bi"
#include "fbc-int/symbol.bi"

'' tests for __FB_QUERY_SYMBOL__

#pragma reserve SYM_RESERVED

namespace ns1

	sub proc1
	end sub

	namespace ns2

		sub proc2()
		end sub

	end namespace
end namespace

SUITE( fbc_tests.fbc_int.query_symbol )

	type T
		fld1 as integer
		fld2 as long

	end type

	union U
		fld1 as integer
		fld2 as long
	end union

	enum E
		elem
	end enum

	sub proc( byval sym_param as integer )
		dim result as integer

		'' internal symbol, to get this need to check SYMBATTRIB instead
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_param )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PARAM )
	end sub

	function func() as integer
		function = 0
	end function

	type SYM_LONGPTR as long ptr
	type FWDREF as SYM_FWDREF

	TEST( symbclass )
		dim result as integer

		dim sym_var as integer
		const sym_const as integer = 1

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_var )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_VAR )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_const )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_CONST )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, proc )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.proc1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.ns2.proc2 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, func )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_PROC )

		proc( 0 )

		'' define is will not be possible without some other query filter added
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_define )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_DEFINE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, integer )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_KEYWORD )

sym_label:
		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_label )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_LABEL )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NAMESPACE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, ns1.ns2 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NAMESPACE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, E )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_ENUM )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, T )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_STRUCT )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, U )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_STRUCT )

		'' CLASS not implemented
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_class )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_CLASS )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, T.fld1 )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_FIELD )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_LONGPTR )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_TYPEDEF )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_FWDREF )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_FWDREF )

		'' internal symbol
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_scope )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_SCOPE )

		result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, SYM_RESERVED )
		CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_RESERVED )

		'' internal symbol
		'' result = __FB_QUERY_SYMBOL__( fbc.FB_QUERY_SYMBOL.symbclass, sym_nsimport )
		'' CU_ASSERT_EQUAL( result, fbc.FB_SYMBCLASS_NSIMPORT )

	END_TEST

END_SUITE
