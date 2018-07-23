' TEST_MODE : COMPILE_ONLY_OK

'' test for sf bug #844
'' in -gen gcc, this would have caused a duplicate struct names to be emitted

scope
  type udt
	dim as integer i
  end type
  dim as udt u1
end scope

scope
  type udt
	dim as integer i
  end type
  dim as udt u2
end scope

scope
  scope
    dim as integer array1()
  end scope
end scope

scope
  scope
    dim as integer array2()
  end scope
end scope

scope
	scope
	  type udt
		dim as integer i
	  end type
	  dim as udt u1
	end scope
	
	scope
	  type udt
		dim as integer i
	  end type
	  dim as udt u2
	end scope
	
	scope
	  scope
	    dim as integer array1()
	  end scope
	end scope
	
	scope
	  scope
	    dim as integer array2()
	  end scope
	end scope
end scope

scope
	scope
		scope
		  type udt
			dim as integer i
		  end type
		  dim as udt u1
		end scope
		
		scope
		  type udt
			dim as integer i
		  end type
		  dim as udt u2
		end scope
		
		scope
		  scope
		    dim as integer array1()
		  end scope
		end scope
		
		scope
		  scope
		    dim as integer array2()
		  end scope
		end scope
	end scope
end scope
