' TEST_MODE : COMPILE_AND_RUN_OK

'' Internal virtual method procedure pointers
type UDT extends object
	declare virtual sub vs( )
	s as sub( )
end type

virtual sub UDT.vs( )
end sub

dim x as UDT
x.vs( )
