' TEST_MODE : COMPILE_ONLY_OK

#ifndef __FB_ARM__
	'' x86 and x86_64 only
	#assert defined(__FB_ASM__)
	#assert (__FB_ASM__ = "intel") or (__FB_ASM__ = "att")
#else
	#assert not defined(__FB_ASM__)
#endif
