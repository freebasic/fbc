type Foo
	declare function DoSomething() as integer
	declare function DoIt() as integer
	declare function DoItFromBase() as integer
	
	private:
	dim unused as byte
end type

	function Foo.DoSomething() as integer
		return 1
	end function

	function Foo.DoIt() as integer
		return DoSomething()
	end function

	function Foo.DoItFromBase() as integer
		return DoSomething()
	end function
	
type SuperFoo extends Foo
	declare function DoSomething() as integer
	declare function DoIt() as integer
end type

	function SuperFoo.DoSomething() as integer
		return 2
	end function

	function SuperFoo.DoIt() as integer
		return DoSomething()
	end function

sub main	
	dim as SuperFoo inst
	
	assert( inst.DoIt() = 2 )
	assert( cast( Foo, inst ).DoIt() = 1 )
	assert( inst.DoItFromBase() = 1 )
	
	print "all tests ok"
end sub

	main