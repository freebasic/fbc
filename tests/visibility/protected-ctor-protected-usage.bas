' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare constructor( )
end type

constructor Parent( )
end constructor

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	scope
		static as Parent staticx

		dim as Parent x1
		dim as Parent x2 = Parent( )
		dim as Parent x3(0 to 1)

		dim as Parent ptr p
		p = new Parent( )
		p = new Parent[5]
	end scope

	scope
		static as Child staticx

		dim as Child x1
		dim as Child x2 = Child( )
		dim as Child x3(0 to 1)

		dim as Child ptr p
		p = new Child( )
		p = new Child[5]
	end scope
end sub
