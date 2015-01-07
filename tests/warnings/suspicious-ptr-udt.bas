type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

type RTTI1 extends object
end type

type RTTI2 extends RTTI1
end type

type INHERIT1
	i as integer
end type

type INHERIT2 extends INHERIT1
end type

scope
	dim as UDT1 ptr pudt1, pudt1_
	dim as UDT2 ptr pudt2
	dim as INHERIT1 ptr pinherit1, pinherit1_
	dim as INHERIT2 ptr pinherit2, pinherit2_
	dim as RTTI1 ptr prtti1, prtti1_
	dim as RTTI2 ptr prtti2, prtti2_
	dim as integer ptr pi

	#print "no warnings:"
	pudt1 = pudt1_
	pinherit1 = pinherit1_
	pinherit2 = pinherit2_
	pinherit1 = pinherit2
	prtti1 = prtti1_
	prtti2 = prtti2_
	prtti1 = prtti2

	'' (invalid assignments involving derived UDT pointers trigger errors,
	'' so they can't be tested here)

	#macro warn( statement )
		#print "1 warning:"
		statement
	#endmacro

	warn( pudt1 = pudt2 )
	warn( pudt1 = pinherit1 )
	warn( pudt1 = pi )
	warn( pinherit1 = pudt1 )
	warn( pinherit1 = pi )
	warn( pi = pudt1 )
	warn( pi = pinherit1 )
end scope
