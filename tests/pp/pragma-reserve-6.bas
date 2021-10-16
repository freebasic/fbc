' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	#pragma reserve (shared) symbol

	sub proc()
		const symbol = 1
	end sub
end namespace
