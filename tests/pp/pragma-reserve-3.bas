' TEST_MODE : COMPILE_ONLY_OK

'' reserved symbols can be shadowed by variables

#pragma reserve symbol

scope
	#pragma reserve symbol
end scope

scope
	dim symbol as integer
end scope

sub proc()
	#pragma reserve symbol

	scope
		#pragma reserve symbol
	end scope

	scope
		dim symbol as integer
	end scope

end sub

sub proc_var()
	dim symbol as integer

	scope
		#pragma reserve symbol
	end scope

	scope
		dim symbol as integer
	end scope
end sub

sub proc_type()
	type symbol
		__ as integer
	end type
end sub
