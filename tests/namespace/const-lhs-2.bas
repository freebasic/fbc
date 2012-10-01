' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	const foo = 1
end namespace

using ns
foo = 1
