' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	declare constructor( byval as integer )
end type

constructor Parent( byval i as integer )
	this.i = i
end constructor

type Child extends Parent
	'' Since the base UDT has a constructor, the derived UDT must get one
	'' automatically generated, but here an error must be shown if the
	'' base UDT ctor isn't a default one and cannot be called automatically.
end type

dim as Child x
