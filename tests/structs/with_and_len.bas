# include "fbcu.bi"

namespace fbc_tests.structs.with_and_len

	type foo
		bar as string
	end type

	sub with_and_len_ cdecl ()
		dim baz as foo
		with baz
			CU_assert( len( .bar ) = 0 )
			CU_assert( .bar = "" )
		end with
	end sub

	sub len_no_with cdecl ()
		dim baz as foo
		CU_assert( len( string ) = sizeof( string ) )
		CU_assert( len( baz.bar ) = 0 )
	end sub

	private sub ctor () constructor
		fbcu.add_suite("tests/structs/with_and_len")
		fbcu.add_test("with and len", @with_and_len_)
		fbcu.add_test("with no len", @len_no_with)
	end sub

end namespace
