

namespace inner

	extern array() as integer

	function test_zero() as integer
		dim as integer i
		for i = lbound(array) to ubound(array)
			if( array(i) <> 0 ) then 
				return 0
			end if
		next	
		function = -1
	end function
	
	function test_lin() as integer
		dim as integer i
		for i = lbound(array) to ubound(array)
			if( array(i) <> i ) then 
				return 0
			end if
		next
		function = -1
	end function
	
end namespace

namespace outer1
	using inner

	sub bar()
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = 0
		next
		CU_ASSERT( test_zero( ) <> 0 )
	end sub

end namespace

namespace outer2
	using inner

	sub bar()
		dim as integer i
		for i = lbound(array) to ubound(array)
			array(i) = i
		next
		CU_ASSERT( test_lin( ) <> 0 )
	end sub

end namespace

	
sub fun
	outer2.bar
end sub

	''
	redim inner.array(0 to 2)

	scope
		using outer1
		bar
	end scope

	fun
