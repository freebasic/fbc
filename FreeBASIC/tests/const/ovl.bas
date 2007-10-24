# include "fbcu.bi"

namespace fbc_tests.const_.ovl
		
	function foo overload (bar As Integer Ptr) as integer
	        return 1
	End function
	
	function foo overload (ba2 As Integer Const Ptr) as integer
	        return 2
	End function
	
	function foo overload (bar As Integer Const Ptr ptr) as integer
	        return 3
	End function
	
	sub testy cdecl ( )
		Dim As Integer Const Ptr ptr p
		Dim As CONsT Integer const Ptr q = 0
		Dim As CONsT Integer Ptr r = 0
		       
		assert( foo( p ) = 3 )
		assert( foo( q ) = 2 )
		assert( foo( r ) = 1 )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("tests.const.ovl")
		fbcu.add_test("ovl", @testy)
	
	end sub
	
end namespace
	