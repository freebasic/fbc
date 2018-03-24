#include "fbcunit.bi"

SUITE( fbc_tests.pointers.funptr_mangling )

	''
	'' no warnings should be shown (bug report #1523070)
	''

	type baz_ as baz

	type bar
		fn as sub (byval as baz_ ptr)
	end type

	type baz
		zzz as integer
	end type

	type foo
		fn as sub (byval as foo ptr)
	end type

	private sub bar_cb( byval p as baz ptr )
	end sub

	private sub foo_cb( byval p as foo ptr )
	end sub

	TEST( all )
		dim as foo f
		dim as bar b
		f.fn = @foo_cb
		b.fn = @bar_cb
	END_TEST

END_SUITE
