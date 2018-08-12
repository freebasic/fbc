' TEST_MODE : COMPILE_ONLY_FAIL

'' from sf.net #801

scope 
	type UDT
		i as integer
	end type

	dim x as UDT

	'' OK
   	type<UDT>(0).i = 1
	*@type<UDT>(0).i = 1

    '' Expected to fail
	type<UDT>(1) = x
	*@type<UDT>(1) = x

end scope
