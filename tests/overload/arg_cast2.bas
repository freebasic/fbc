#include "fbcunit.bi"
	
SUITE( fbc_tests.overload_.arg_cast2 )
	
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
    
    TEST( dummy )
    	'' this just has to compile
    	CU_PASS()
    END_TEST

END_SUITE
