#include "fbcunit.bi"

dim shared id as string

sub s overload ()
	id = "s()"
end sub

sub s( byval arg as byte )
	id = "s( byval arg as byte )"
end sub

sub s( byval arg as short )
	id = "s( byval arg as short )"
end sub

sub s( byval arg as long )
	id = "s( byval arg as long )"
end sub

sub s( byval arg as longint )
	id = "s( byval arg as longint )"
end sub

sub s( byval arg as single )
	id = "s( byval arg as single )"
end sub

sub s( byval arg as double )
	id = "s( byval arg as double )"
end sub


SUITE( fbc_tests.pointers.procptr_type )

	TEST( subs )

		scope
			var p1 = procptr(s)
			p1()
			CU_ASSERT( id = "s()" )
		end scope

		scope
			var p1 = procptr(s, sub() )
			p1()
			CU_ASSERT( id = "s()" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as byte ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as byte )" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as short ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as short )" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as long ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as long )" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as longint ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as longint )" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as single ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as single )" )
		end scope

		scope
			var p1 = procptr(s, sub( byval as double ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as double )" )
		end scope

	END_TEST

	TEST( types )

		type t as sub( byval as single )

		scope
			var p1 = procptr(s, sub( byval as single ) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as single )" )
		end scope

		scope
			var p1 = procptr(s, t )
			p1(0)
			CU_ASSERT( id = "s( byval arg as single )" )
		end scope

		scope
			var p1 = procptr(s, typeof(t) )
			p1(0)
			CU_ASSERT( id = "s( byval arg as single )" )

			var p2 = procptr(s, typeof(p1) )
			p2(0)
			CU_ASSERT( id = "s( byval arg as single )" )
		end scope


	END_TEST

END_SUITE
