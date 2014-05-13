' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	i as integer
	declare constructor( byval as integer )
end type

type Child extends Parent
	s as string
	declare constructor( )
	declare constructor( byref as const Child )

	'' Non-const copy-let triggers generation of non-const copy-ctor,
	'' which however isn't possible due to the base that's missing a def-ctor
	declare operator let( byref as Child )
end type
