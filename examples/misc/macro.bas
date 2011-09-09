''
'' macro tests
''

	randomize timer

#define mul(x,y) ((x) * (y))
#define addsubmul(x,y) mul(x+y,y-x)

	dim as integer b = rnd * 10
	dim as integer c = rnd * 10
	print b; " *"; c; " ="; mul(b,c)
	
	print b+c; " *"; c-b; " ="; addsubmul(b,c)

''-----------------------------------

#define getabc(x) x.abc

type mytype
	a as integer
	b as integer
	abc as short
end type
	
	dim mytype as mytype
	
	mytype.abc = 1234
	print ".abc ="; getabc(mytype)
	
''-----------------------------------	

#define printdouble(s) print "doubled: "; s; " "; s

	dim as string a = "abcd"
	
	printdouble(a)
	
''-----------------------------------	

#define maxx(a,b) iif( a >= b, a, b )

#define minn(a,b) iif( a <= b, a, b )

	dim as integer x = rnd * 100
	dim as integer y = rnd * 100
	
	print "min:"; x; ","; y; " ="; minn( x, y )
	print "max:"; x; ","; y; " ="; maxx( x, y )
	
	
	sleep
