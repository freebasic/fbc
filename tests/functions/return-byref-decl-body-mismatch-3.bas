' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	declare property f( ) byref as integer
end type

property UDT.f( ) as integer
	property = this.dummy
end property
