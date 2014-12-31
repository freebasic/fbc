' TEST_MODE : COMPILE_ONLY_OK

#if (not defined(__FB_64BIT__)) and (not defined(__FB_ARM__))
	#assert (__FB_ASM__ = "intel") or (__FB_ASM__ = "att")
#else
	#assert not defined(__FB_ASM__)
#endif
