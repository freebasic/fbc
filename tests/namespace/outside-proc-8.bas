' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns
	namespace a
		declare sub f1( )
	end namespace

	declare sub a.f1( )
end namespace
