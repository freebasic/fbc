' TEST_MODE : COMPILE_ONLY_OK

'' macro with parens is seen as macro only when using parens

#define D1() 1

type T1
	'' no expansion of D1() or built-ins
	D1 as double
	rgb as double
	bit as double
end type

'' no expansion of D1()
declare sub S1 _
	( _
		byval D1 as single, _
		byval rgb as double, _
		byval bit as double _
	)

'' expand D
var X1 = D1()


#define D2(arg1,arg2) 1

type T2
	'' no expansion of D2() or built-ins
	D2 as double
	rgb as double
	bit as double
end type

'' no expansion of D2()
declare sub S2 _
	( _
		byval D2 as single, _
		byval rgb as double, _
		byval bit as double _
	)

'' expand D
var X2 = D2(,)
