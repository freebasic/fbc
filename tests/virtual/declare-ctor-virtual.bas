' TEST_MODE : COMPILE_ONLY_FAIL

'' Constructors cannot be virtual because the vptr needed for the vtable lookup
'' is initialized by the constructor itself (chicken-egg problem)
type UDT extends object
	dummy as integer
	declare virtual constructor( )
end type
