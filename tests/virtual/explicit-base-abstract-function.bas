' TEST_MODE : COMPILE_ONLY_FAIL

type Parent extends object
	i as integer
	declare abstract function f( ) as integer
end type

type Child extends Parent
	declare function f( ) as integer override
end type

function Child.f( ) as integer
	function = base.f( ) + 1
end function
