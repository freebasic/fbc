''
'' Type aliases:
''

	type myint as integer

	dim a as myint = 5
	print a

''
'' Especially useful for long types (to avoid all the typing):
''
	type MyProcPtr as function( byval as integer, byval as integer ) as integer

	dim p1 as MyProcPtr
	dim p2 as MyProcPtr
	dim p3 as MyProcPtr
	dim p4 as MyProcPtr

''
'' Forward declarations:
''
	'' Declare MyType as type that isn't yet "implemented"
	type MyType as RealMyType

	'' The forward-declared type can be used with pointers and references
	type FooBar
		as MyType ptr p
	end type
	dim as MyType ptr p
	declare sub foo( byref x as MyType )

	'' Here's the implementation
	type RealMyType
		as integer a, b
	end type

''
'' Declaring types that behave like Any:
'' (i.e. void types, just a type name that is never really "implemented")
''
	type MyAny1 as any
	type MyAny2 as MyAny2
