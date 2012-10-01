' TEST_MODE : COMPILE_AND_RUN_OK

	a = 1
	scope 
	  dim a 
	  b = 7 
	  scope 
	    dim b 
	    scope 
	      c = 11 
	      scope 
	        a = 5 
	        b = 3 
          ASSERT(a = 5) 
          ASSERT(b = 3) 
          ASSERT(c = 11) 
	      end scope 
        ASSERT(a = 5) 
        ASSERT(b = 3) 
        ASSERT(c = 11) 
	    end scope 
      ASSERT(a = 5) 
      ASSERT(b = 3) 
	    '' c = c '' quiet implicit var warning 
      ASSERT(c = 0) 
	  end scope 
    ASSERT(a = 5) 
    ASSERT(b = 7) 
	  '' c = c '' quiet implicit var warning 
    ASSERT(c = 0) 
	end scope 
  ASSERT( a = 1) 
	'' b = b '' quiet implicit var warning 
  ASSERT(b = 0) 
	'' c = c '' quiet implicit var warning 
  ASSERT(c = 0) 

