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

#macro testInheritanceParamAndResult( A, B )
	#print testing A and B
	scope
		dim pa as function( ) byref as A
		dim pb as function( ) byref as B

		#print "no warning:"
		pa = pb  '' when calling pa() we expect an A, and get a B - actually safe (B is an A) since it's passed BYREF

		#print "2 warnings:"
		pb = pa  '' when calling pb() we expect a B, and get an A - unsafe
	end scope

	scope
		dim pa as sub( byref as A )
		dim pb as sub( byref as B )

		#print "1 warning:"
		pa = pb  '' when calling pa() we'll pass an A, but pb() expects a B - unsafe

		#print "no warning:"
		pb = pa  '' when calling pb() we'll pass a B, and pa() expects an A - actually safe (B is an A) since it's passed BYREF
	end scope

	scope
		dim pa as function( ) as A
		dim pb as function( ) as B

		#print "2 warnings:"
		pa = pb  '' caller expects an A, callee returns a B
		'' This isn't safe with BYVAL returns because the caller is responsible
		'' for allocating the temp var on stack, where the result will be
		'' written by the callee. This must have the exact same size or there
		'' will be a buffer overflow...
		#print "2 warnings:"
		pb = pa  '' caller expects a B, callee returns an A - unsafe
	end scope

	scope
		dim pa as sub( byval as A )
		dim pb as sub( byval as B )

		'' This might perhaps be safe even with the BYVAL parameters, because passing RTTI
		'' types BYVAL means they are copied and then implicitly passed BYREF, and
		'' the caller cleans up, but since BYVAL function results like this can't be
		'' allowed, this should probably not be allowed either.

		#print "2 warnings:"
		pa = pb
		pb = pa
	end scope
#endmacro

testInheritanceParamAndResult( INHERIT1, INHERIT2 )
testInheritanceParamAndResult( RTTI1, RTTI2 )
