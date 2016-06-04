# include "fbcu.bi"

namespace fbc_tests.string_.str_pad

	sub test_i cdecl
		dim as integer i = 1
		cu_assert( str(i) = "1" )
		i = -1
		cu_assert( str(i) = "-1" )
		cu_assert( str(1) = "1" )
		cu_assert( str(-1) = "-1" )
	end sub
	sub test_ui cdecl
		dim as uinteger ui = 1
		cu_assert( str(ui) = "1" )
		cu_assert( str(1ul) = "1" )
	end sub
	
	sub test_s cdecl
		dim as single s = 1
		cu_assert( str(s) = "1" )
		s = -1
		cu_assert( str(s) = "-1" )
		cu_assert( str(1!) = "1" )
		cu_assert( str(-1!) = "-1" )
	end sub
	sub test_d cdecl
		dim as double d = 1
		cu_assert( str(d) = "1" )
		d = -1
		cu_assert( str(d) = "-1" )
		cu_assert( str(1#) = "1" )
		cu_assert( str(-1#) = "-1" )
	end sub
	
	sub test_l cdecl
		dim as longint l = 1
		cu_assert( str(l) = "1" )
		l = -1
		cu_assert( str(l) = "-1" )
		cu_assert( str(1ll) = "1" )
		cu_assert( str(-1ll) = "-1" )
	end sub
	sub test_ul cdecl
		dim as ulongint ul = 1
		cu_assert( str(ul) = "1" )
		cu_assert( str(1ull) = "1" )
	end sub

	sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.string.str_pad")
		fbcu.add_test("integer to str", @test_i)
		fbcu.add_test("uinteger to str", @test_ui)

		fbcu.add_test("single to str", @test_s)
		fbcu.add_test("double to str", @test_d)

		fbcu.add_test("longint to str", @test_l)
		fbcu.add_test("ulongint to str", @test_ul)
	
	end sub
	
end namespace

