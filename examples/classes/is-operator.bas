const DOG_ACTION = "rub belly"
const CAT_ACTION = "sleep"

type Animal extends Object	'' must extend Object so RTTI will be generated for this class
	dim as string name
end type

type Dog extends Animal
	declare constructor (name_ as string)
	declare function getAction as string
end type

constructor Dog (name_ as string)
	base.name = name_
end constructor

function Dog.getAction as string
	return DOG_ACTION
end function

type Cat extends Animal
	declare constructor (name_ as string)
	declare function getAction as string
end type

constructor Cat (name_ as string)
	base.name = name_
end constructor

function Cat.getAction as string
	return CAT_ACTION
end function

function getAction( a as Animal ) as string

	if( a is Dog ) then
		return cast( Dog ptr, @a )->getAction
	elseif( a is Cat ) then
		return cast( Cat ptr, @a )->getAction
	end if
	
end function

sub main
	var pluto = Dog( "Pluto" )
	var tom = Cat( "Tom" )

	assert( getAction( pluto ) = DOG_ACTION )
	assert( getAction( tom ) = CAT_ACTION )
	
	print "all tests ok"
end sub

	main
