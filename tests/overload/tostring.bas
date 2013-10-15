' TEST_MODE : COMPILE_ONLY_OK

type foo
	bar as double
    declare operator cast ( ) as double
    declare operator cast ( ) as string
end type

operator foo.cast ( ) as double
	operator = bar
end operator

operator foo.cast ( ) as string
	operator = str( bar )
end operator

operator - ( byref l as foo, byval r as single ) as foo
	return type( l.bar - r )
end operator

operator + ( byval l as single, byref r as foo ) as foo
	return type( l + r.bar )
end operator

operator * ( byref l as foo, byref r as foo ) as foo
	return type( l.bar + r.bar )
end operator
  
'' main	
	dim as foo l = ( 1 ), r = ( 2 )

	'' auto-coercion of r to double, pass into a single param, then convert to string
	print l - r
	
	'' now the inverse
	write l + r
	
	'' no string conversion, print using only takes DOUBLE's
	print using "#.##"; l * r

