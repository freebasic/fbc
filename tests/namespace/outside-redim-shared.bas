' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns1
	dim shared array1() as integer
end namespace

'' REDIM SHARED is a declaration like DIM SHARED, not a code REDIM that
'' resizes the array, and the following should not be allowed,
'' because declarations must be written inside the namespace block.
'' And even without that rule, this would be a duplicate definition...
redim shared ns1.array1(4 to 5) as integer
