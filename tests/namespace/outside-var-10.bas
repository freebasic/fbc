' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	namespace a
		dim shared i1 as integer
	end namespace

	dim shared a.i1 as integer
end namespace
