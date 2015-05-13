type MyType
	bar as integer
	declare sub printMe( ) 
	declare static sub printThis( byref x as MyType )
end type

sub MyType.printMe( ) 
	print bar
end sub

sub MyType.printThis( byref x as MyType )
	print x.bar
end sub

dim as MyType x
x.printMe( )
MyType.printThis( x )
