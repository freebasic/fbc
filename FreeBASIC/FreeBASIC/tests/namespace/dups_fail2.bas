' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns_a
	dim as integer foo = 1
	dim as integer bar = 1234
end namespace

namespace ns_a.ns_b
	dim as integer foo = 2
end namespace

	scope 
		using ns_a.ns_b
		print ns_a.bar
		'' shouldn't exist
		print bar
	end scope
	
