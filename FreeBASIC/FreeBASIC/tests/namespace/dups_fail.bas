' TEST_MODE : COMPILE_ONLY_FAIL

namespace ns_a
	dim as integer foo = 1
end namespace

namespace ns_b
	dim as integer foo = 2
end namespace

namespace ns_c
	using ns_a
	using ns_b
	dim as integer foo = 3
end namespace

	scope 
		using ns_a
		print foo
		
		using ns_b
		print foo
		
		using ns_c
		print foo
		
		dim as integer foo = 4
		print foo
	end scope
	
	scope 
		using ns_c
		print foo
		
		using ns_b
		print foo
		
		using ns_a
		print foo
		
		dim as integer foo = 4
		print foo
	end scope
	