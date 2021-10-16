' TEST_MODE : COMPILE_ONLY_OK

namespace ns
	#pragma reserve symbol

	sub proc()
		const symbol = 2
	end sub
end namespace
