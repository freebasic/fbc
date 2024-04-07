#include once "fbcunit.bi"

'' define namespace names to allow short names
'' in this source but avoid namespace collisions
'' in other sources

#define N iherit_type_2_N
#define B iherit_type_2_B

#macro checkCall( func, result )
	func
	CU_ASSERT_EQUAL( proc_result, result )
#endmacro

dim shared proc_result as string

private sub proc()
	proc_result = "..PROC"
end sub

enum E
	proc
end enum

namespace B
	sub proc()
		proc_result = "B.PROC"
	end sub
end namespace

namespace N

	type P extends object
		declare sub proc()
		declare sub method()
	end type

	sub P.proc()
		proc_result = "N.P.PROC"
	end sub

	sub P.method()
		proc()
	end sub

	sub method()
		proc()
	end sub

	namespace A1

		using B

		sub proc()
			proc_result = "N.A1.PROC"
		end sub

		type C extends P
			declare sub proc()
			declare sub method()
		end type

		sub C.proc()
			proc_result = "N.A1.C.PROC"
		end sub

		sub C.method()
			proc()
		end sub

		sub method()
			proc()
		end sub

	end namespace

	namespace A2

		using B

		type C extends P
			declare sub proc()
			declare sub method()
		end type

		sub C.proc()
			proc_result = "N.A2.C.PROC"
		end sub

		sub C.method()
			proc()
		end sub

		sub method()
			proc()  '' << ambiguous B.PROC, E.PROC
		end sub

	end namespace

	namespace A3

		using B

		type C extends P
			declare sub method()
		end type

		sub C.method()
			proc()  '' << ambiguous N.P.PROC, B.PROC, E.PROC
		end sub

		sub method()
			proc()  '' << ambiguous B.PROC, E.PROC
		end sub

	end namespace

end namespace

private sub module_proc

	checkCall( proc(), "..PROC" )
	checkCall( N.method(), "..PROC" )
	checkCall( N.A1.method(), "N.A1.PROC" )
	checkCall( N.A2.method(), "..PROC" )
	checkCall( N.A3.method(), "..PROC" )

	scope
		dim x as N.P
		checkCall( x.method(), "N.P.PROC" )
	end scope

	scope
		dim x as N.A1.C
		checkCall( x.method(), "N.A1.C.PROC" )
	end scope

	scope
		dim x as N.A2.C
		checkCall( x.method(), "N.A2.C.PROC" )
	end scope

	scope
		dim x as N.A3.C
		checkCall( x.method(), "N.P.PROC" )
	end scope

end sub

SUITE( fbc_tests.structs.inherit_type_2 )
	TEST( default )
		module_proc()
	END_TEST
END_SUITE
