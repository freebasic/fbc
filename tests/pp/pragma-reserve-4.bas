' TEST_MODE : COMPILE_ONLY_OK

'' reserve in the global scope

#pragma reserve symbol

#if not defined(symbol)
	#error
#endif

sub proc_var()
	'' 
	#if not defined(symbol)
		#error
	#endif

	'' local symbol shadows global
	dim symbol as integer

	#if not defined(symbol)
		#error
	#endif

	#if not defined(..symbol)
		#error
	#endif
end sub

sub proc_type()
	#if not defined(symbol)
		#error
	#endif

	'' local symbol shadows global
	type symbol
		__ as integer
	end type

	#if not defined(symbol)
		#error
	#endif

	#if not defined(..symbol)
		#error
	#endif
end sub

