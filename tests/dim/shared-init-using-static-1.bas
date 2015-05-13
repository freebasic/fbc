' TEST_MODE : COMPILE_ONLY_FAIL

'' The global's initializer shouldn't be able to reference the static,
'' because by the time the global will be emitted, the static is already
'' emitted and deleted, and the global's initializer would have a dangling
'' FBSYMBOL ptr...
static as integer i
dim shared as integer ptr pi = @i
print pi
