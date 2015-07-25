' TEST_MODE : COMPILE_ONLY_OK

const I1 = 0
const I1 = 0

const I2 = 123
const I2 = 123
const I2 = 123
const I2 = 123

#ifdef __FB_64BIT__
	const I3 as integer = &hFFFFFFFFFFFFFFFF
	const I3 as integer = -1
#else
	const I3 as integer = &hFFFFFFFF
	const I3 as integer = -1
#endif

const I4 = &h8000000000000000ull
const I4 = &h8000000000000000ull

const F1 = 1.0
const F1 = 1.0

const F2 = 123.456789
const F2 = 123.456789

const S1 = "a"
const S1 = "a"

const WS1 = wstr("a")
const WS1 = wstr("a")

namespace ns1
	const I1 = 0  '' same as toplevel I1

	'' same id as toplevel I2, but different value, but it should be allowed
	'' because it's in a different namespace
	const I2 = 456

	const I5 = 0  '' new in the namespace
	const I5 = 0

	const I6 = 1
end namespace

'' same id as I5 in the namespace, but different value, but it should be allowed
'' because it's in a different namespace
const I5 = 555

'' importing I6 from the other namespace shouldn't affect declarations here
using ns1
const I6 = 123
