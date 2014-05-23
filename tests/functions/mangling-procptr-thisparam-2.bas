' TEST_MODE : COMPILE_AND_RUN_OK

'' Internal virtual method procedure pointers
type UDT extends object
	declare virtual sub vs( as integer )
	s as sub( as integer )
end type

virtual sub UDT.vs( i as integer )
end sub

dim x as UDT
x.vs( 0 )
