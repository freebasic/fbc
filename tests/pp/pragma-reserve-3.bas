' TEST_MODE : COMPILE_ONLY_OK

'' reserve in the implicit main only

#pragma reserve symbol

#if not defined(symbol)
	#error
#endif

sub proc_var()

#if ENABLE_CHECK_BUGS
	'' symbol should not be defined
	#if defined(symbol)
		#error
	#endif
#endif

	dim symbol as integer
end sub

sub proc_type()

#if ENABLE_CHECK_BUGS
	'' symbol should not be defined
	#if defined(symbol)
		#error
	#endif
#endif

	type symbol
		__ as integer
	end type
end sub
