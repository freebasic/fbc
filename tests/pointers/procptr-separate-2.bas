' TEST_MODE : COMPILE_ONLY_OK

type UDT extends object
	i as integer
	declare sub sub1()
	declare sub sub2()
end type

private sub UDT.sub1()
	type UDT2
		i as integer
	end type

	dim subptr1 as sub( byref as UDT2 )
end sub

private sub UDT.sub2()
	type UDT2
		i as double
	end type

	dim subptr2 as sub( byref as UDT2 )
end sub

dim x as UDT
x.sub1()
x.sub2()
