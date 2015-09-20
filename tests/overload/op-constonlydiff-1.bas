' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	x as single
end type

operator +(byval l as single, byref r as const UDT) as UDT
	operator = type(l + r.x)
end operator

operator +(byref l as const UDT, byval r as single) as UDT
	operator = type(l.x + r)
end operator

dim as UDT u = (1)
dim as UDT u2

'' rhs passes UDT to const UDT (const only diff),
'' but lhs passes Double to Single - inexact match, not allowed for operator overloads.
u2 = 0.1 + u
