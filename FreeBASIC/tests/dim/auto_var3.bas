# include "fbcu.bi"

namespace fbc_tests.dim_.auto_var3

	Type MyType
	    Declare Constructor (x As Integer, y As Integer)
	    m_x As Integer
	    m_y As Integer
	End Type
	Constructor MyType (x As Integer, y As Integer)
	    m_x = x
	    m_y = y
	End Constructor
	
	Function CreateTest () As MyType
	    Return MyType(10, 20)
	End Function
	
	sub ctor_fallback cdecl ( )
		var mt1 = CreateTest()
		CU_ASSERT( mt1.m_x = 10 )
		CU_ASSERT( mt1.m_y = 20 )
	end sub
	
	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.dim.auto_var3")
		fbcu.add_test("ctor_fallback", @ctor_fallback)
	
	end sub

end namespace
