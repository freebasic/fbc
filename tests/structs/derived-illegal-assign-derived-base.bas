' TEST_MODE : COMPILE_ONLY_FAIL

type AAObject
	dim value as integer
end type

type AABase extends AAObject
	dim value2 as integer
end type

type AADerived extends AABase
	dim value3 as integer
	declare constructor( value as integer )
end type

constructor AADerived( value as integer )
	base.value = value
end constructor

dim b as AABase
dim d as AADerived = ( 5678 )

d = b '' not allowed, same as in C++
