' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	declare property f( ) as integer
end type

property UDT.f( ) byref as integer
	property = this.dummy
end property
