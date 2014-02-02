' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

'' Wrong result type: integer instead of UDT. This should of course trigger an
'' error, and as for the error recovery: This operator should not be added to
'' the global table because it has a bad signature. Otherwise the code below
'' would try to do a member access on an integer during error recovery...
operator ->( byref x as UDT ) as integer
	operator = x.i
end operator

dim x as UDT
print x->i
