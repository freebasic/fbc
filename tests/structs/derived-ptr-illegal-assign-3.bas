' TEST_MODE : COMPILE_ONLY_FAIL

type BBObject
	dim value as integer
	dim somestr as string
end type

type BBBase extends BBObject
	dim value2 as integer
end type

type BBDerived extends BBBase
	dim value3 as integer
	declare constructor( value as integer )
end type

constructor BBDerived( value as integer )
	base.value = value
end constructor

dim pb as BBBase ptr
dim pd as BBDerived ptr

pd = pb '' not allowed, same as in C++
