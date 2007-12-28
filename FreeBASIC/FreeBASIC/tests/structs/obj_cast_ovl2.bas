
# include "fbcu.bi"

namespace fbc_tests.structs.obj_cast_ovl2
    
    type LivingThing
        declare constructor( a as integer )
        as integer a
    end type
    
    constructor LivingThing( a as integer )
    	this.a = a
	end constructor
    
    type Animal
        declare operator let( byref as LivingThing )
        as integer b
    end type
    
    operator Animal.let( byref rhs as LivingThing )
    	b = -rhs.a
	end operator
    
    type Dog
        declare operator cast () as LivingThing
        as integer c
    end type
    
    operator Dog.cast () as LivingThing
    	return LivingThing( 1234 )
	end operator
	
sub test1 cdecl	
	dim as Animal an
	dim as Dog dg
	
	'' should this be supported? (C++ doesn't allow that)
	
	'' this will be converted to: animal.let( a, dog.cast( LivingThing, d ) )
	an = dg
	
	CU_ASSERT_EQUAL( an.b, -1234 )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-cast-ovl2")
	fbcu.add_test( "test 1", @test1)

end sub
	
end namespace	