' TEST_MODE : COMPILE_ONLY_OK

'' from sf.net #801

scope 
	type UDT
		i as integer
	end type

	dim x as UDT

	'' OK
   	type<UDT>(0).i = 1
	*@type<UDT>(0).i = 1

end scope
