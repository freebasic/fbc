' TEST_MODE : COMPILE_ONLY_FAIL

'' from sf.net #801

scope 
	type UDT
		i as integer
	end type

	dim x as UDT

    '' Expected to fail
	type<UDT>(1) = x

end scope
