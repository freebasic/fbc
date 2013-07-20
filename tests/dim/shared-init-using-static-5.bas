' TEST_MODE : COMPILE_ONLY_FAIL

static as integer i

namespace ns
	dim as integer ptr pi = @i
end namespace

print ns.pi
