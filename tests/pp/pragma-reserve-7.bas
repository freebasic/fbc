' TEST_MODE : COMPILE_ONLY_OK

'' reserved ASM symbols have their own list

#pragma reserve (asm) symbol

#ifdef __FB_X86__

asm
	#if defined(symbol)
		#error
	#endif
end asm

#endif
