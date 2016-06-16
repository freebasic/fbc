# include "fbcu.bi"
	
namespace fbc_tests.overloads.arg_cast2
	
    Type CPos
        as integer x, y
        
        ' Constructors.
        declare constructor ()

    end type
    
    type CSize
        as integer w, h
        
        ' Constructors
        declare constructor ()
        
    end type
    
    type CRect
        as integer x, y, w, h
        
        declare constructor ()

        ' Constructors
        declare operator cast () as CSize
        declare operator cast () as CPos
        
        declare operator Let (byref rhs as CPos)
        declare operator Let (byref rhs as CSize)
        
    end type
    
    type CSplittedRect
        m_count as integer
        m_rects(0 to 3) as Crect
    end type
    
    sub dummy cdecl( )
    	'' this just has to compile
    end sub

	private sub ctor () constructor
	
		fbcu.add_suite("fbc_tests.overload.arg_cast2")
		fbcu.add_test("n_a", @dummy)
	
	end sub

end namespace
