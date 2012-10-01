' TEST_MODE : COMPILE_ONLY_FAIL

type TObject
	dim value as integer
end type

type TBase extends TObject
end type

type TDerived extends TBase
end type

sub takeDerivedPtr( pb as TDerived ptr )
end sub

dim pb as TBase ptr
takeDerivedPtr( pb ) '' shouldn't be allowed, same as in C++
