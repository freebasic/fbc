# include "fbcu.bi"

'' - don't mix false/true intrinsic constants 
''   of the compiler in with the tests
#undef FALSE
#undef TRUE

#define FALSE 0
#define TRUE -1

namespace fbc_tests.boolean_.boolean_

	sub sizeof_boolean cdecl ( )
		dim as boolean b
		dim as integer i

		CU_ASSERT_EQUAL( sizeof(boolean), 1 )
		CU_ASSERT_EQUAL( sizeof(b), 1 )

		i = sizeof(boolean)
		CU_ASSERT_EQUAL( i, 1 )

		i = sizeof(b)
		CU_ASSERT_EQUAL( i, 1 )
	end sub

	sub convert_cbool cdecl ( )
		dim as integer b
		dim as integer i
		dim as integer n

		#define __cbool(x) iif(x<>0,TRUE,FALSE)

		'' literal

		b = cbool(0)
		i = __cbool(0)
		CU_ASSERT_EQUAL( b, i )

		b = cbool(1)
		i = __cbool(1)
		CU_ASSERT_EQUAL( b, i )

		b = cbool(2)
		i = __cbool(2)
		CU_ASSERT_EQUAL( b, i )

		b = cbool(-1)
		i = __cbool(-1)
		CU_ASSERT_EQUAL( b, i )

		b = cbool(256)
		i = __cbool(256)
		CU_ASSERT_EQUAL( b, i )

		'' variable

		n = 0
		b = cbool(n)
		i = __cbool(n)
		CU_ASSERT_EQUAL( b, i )

		n = 1
		b = cbool(n)
		i = __cbool(n)
		CU_ASSERT_EQUAL( b, i )

		n = 2
		b = cbool(n)
		i = __cbool(n)
		CU_ASSERT_EQUAL( b, i )

		n = -1
		b = cbool(n)
		i = __cbool(n)
		CU_ASSERT_EQUAL( b, i )

		n = 256
		b = cbool(n)
		i = __cbool(n)
		CU_ASSERT_EQUAL( b, i )
	end sub

	sub convert_cbool_literal cdecl ( )
		dim as boolean b

		b = cbool(0)
		CU_ASSERT_EQUAL( b, FALSE )

		b = cbool(1)
		CU_ASSERT_EQUAL( b, TRUE )

		b = cbool(2)
		CU_ASSERT_EQUAL( b, TRUE )

		b = cbool(-1)
		CU_ASSERT_EQUAL( b, TRUE )

		b = cbool(256)
		CU_ASSERT_EQUAL( b, TRUE )
	end sub

	sub convert_cbool_variable cdecl ( )
		dim as integer b
		dim as integer i

		i = 0
		b = cbool(i)
		CU_ASSERT_EQUAL( b, FALSE )

		i = 1
		b = cbool(i)
		CU_ASSERT_EQUAL( b, TRUE )

		i = 2
		b = cbool(i)
		CU_ASSERT_EQUAL( b, TRUE )

		i = -1
		b = cbool(i)
		CU_ASSERT_EQUAL( b, TRUE )

		i = 256
		b = cbool(i)
		CU_ASSERT_EQUAL( b, TRUE )
	end sub

	sub assign_literal cdecl ( )
		dim as boolean b
		CU_ASSERT_EQUAL( b, FALSE )

		b = 0
		CU_ASSERT_EQUAL( b, FALSE )

		b = 1
		CU_ASSERT_EQUAL( b, TRUE )

		b = 2
		CU_ASSERT_EQUAL( b, TRUE )

		b = -1
		CU_ASSERT_EQUAL( b, TRUE )

		b = 256
		CU_ASSERT_EQUAL( b, TRUE )
	end sub

	sub assign_integer cdecl ( )
		dim as boolean b
		dim as integer i

		CU_ASSERT_EQUAL( b, FALSE )

		i = 0
		b = i
		CU_ASSERT_EQUAL( b, FALSE )

		i = 1
		b = i
		CU_ASSERT_EQUAL( b, TRUE )

		i = 2
		b = i
		CU_ASSERT_EQUAL( b, TRUE )

		i = -1
		b = i
		CU_ASSERT_EQUAL( b, TRUE )

		i = 256
		b = i
		CU_ASSERT_EQUAL( b, TRUE )
	end sub

	sub initializer_literal cdecl ( )
		dim as boolean a = 0
		CU_ASSERT_EQUAL( a, FALSE )

		dim as boolean b = 1
		CU_ASSERT_EQUAL( b, TRUE )

		dim as boolean c = 2
		CU_ASSERT_EQUAL( c, TRUE )

		dim as boolean d = -1
		CU_ASSERT_EQUAL( d, TRUE )

		dim as boolean e = 256
		CU_ASSERT_EQUAL( e, TRUE )
	end sub

	sub initializer_variable cdecl ( )
		dim i as integer

		i = 0
		dim as boolean a = i

		i = 1
		dim as boolean b = i

		i = 2
		dim as boolean c = i

		i = -1
		dim as boolean d = i

		i = 256
		dim as boolean e = i

		CU_ASSERT_EQUAL( a, FALSE )
		CU_ASSERT_EQUAL( b, TRUE )
		CU_ASSERT_EQUAL( c, TRUE )
		CU_ASSERT_EQUAL( d, TRUE )
		CU_ASSERT_EQUAL( e, TRUE )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("fbc_tests.boolean_.boolean")
		fbcu.add_test("sizeof_boolean", @sizeof_boolean)
		fbcu.add_test("convert_cbool", @convert_cbool)
		fbcu.add_test("convert_cbool_literal", @convert_cbool_literal)
		fbcu.add_test("convert_cbool_variable", @convert_cbool_variable)
		fbcu.add_test("assign_literal", @assign_literal)
		fbcu.add_test("assign_integer", @assign_integer)
		fbcu.add_test("initializer_literal", @initializer_literal)
		fbcu.add_test("initializer_variable", @initializer_variable)
	end sub
end namespace
