' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	declare constructor( byval as integer )
end type

constructor Parent( byval i as integer )
	this.i = i
end constructor

type Child extends Parent
	'' Since the base UDT has a constructor, and none was implemented for
	'' the derived UDT, the compiler should generate one automatically,
	'' but it cannot because the base UDT doesn't have a default ctor.
end type

dim as Child x
