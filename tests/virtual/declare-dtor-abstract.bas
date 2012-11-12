' TEST_MODE : COMPILE_ONLY_FAIL

'' Destructors cannot be abstract; they need to have a body to ensure base
'' and field destructors are called.
type UDT extends object
	dummy as integer
	declare abstract destructor( )
end type
