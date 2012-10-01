'' TYPEs and UNIONs (unlimited nesting):

type OtherUDT
	x as integer
	y as integer
end type

type MyType
	a as short
	b as integer
	c as long
	d as OtherUDT
	union
		e as double
		f as single
		g as OtherUDT
	end union
	h as byte
end type

union MyUnion
	a as integer
	b as longint
	c as double
	my as MyType
end union
