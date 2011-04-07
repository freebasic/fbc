type TObject
	private:
		dim unused as integer
end type

type TBase extends TObject
end type

type TDerived extends TBase
end type

function overloaded overload(b as TObject) as string
	return "overloaded(TObject)"
end function

function overloaded overload(b as TBase) as string
	return "overloaded(TBase)"
end function 

/'function  overloaded overload(d as TDerived) as string
	return "overloaded(TDerived)"
end function '/

function  overloaded overload(i as integer) as string
	return "overloaded(int)"
end function 

sub main()
	dim as TDerived d
	
	assert( overloaded( d ) = "overloaded(TBase)" )
	
	print "all tests ok"
end sub

	main