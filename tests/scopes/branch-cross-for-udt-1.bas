' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare constructor( byval i as integer )
	declare operator for( )
	declare operator for( byref stp as UDT )
	declare operator step( )
	declare operator step( byref stp as UDT )
	declare operator next( byref cond as UDT ) as integer
	declare operator next( byref cond as UDT, byref stp as UDT ) as integer
end type

constructor UDT( byval i as integer )
	this.i = i
end constructor

operator UDT.for( )
end operator

operator UDT.for( byref stp as UDT )
end operator

operator UDT.step( )
end operator

operator UDT.step( byref stp as UDT )
end operator

operator UDT.next( byref cond as UDT ) as integer
	operator = 0
end operator

operator UDT.next( byref cond as UDT, byref stp as UDT ) as integer
	operator = 0
end operator

'' Must be an error: GOTO over the constructor call for x and the temp var
'' created to hold the end condition
goto inner
for x as UDT = 1 to 2
	inner:
next
