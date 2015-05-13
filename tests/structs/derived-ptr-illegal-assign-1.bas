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

dim pb as AABase ptr
dim pd as AADerived ptr

pd = pb '' not allowed, same as in C++
