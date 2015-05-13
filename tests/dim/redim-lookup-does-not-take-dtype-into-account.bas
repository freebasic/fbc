' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	dim array() as integer
end namespace

dim array() as double
using ns

redim array(0 to 1) as integer
