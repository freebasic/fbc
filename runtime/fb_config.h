#ifndef __FB_CONFIG_H__
#define __FB_CONFIG_H__

#ifdef HOST_MINGW
	/* MinGW doesn't recognize _FILE_OFFSET_BITS, so we this manually */
	#define fseeko(x, y, z) fseeko64(x, y, z)
	#define ftello(x)       ftello64(x)
#elif defined(HOST_DOS)
	/* On DJGPP we didn't use fseeko() at all (the DJGPP semi-2.04 setup
	   used for FB doesn't seem to have it) */
	#define fseeko(x, y, z) fseek(x, y, z)
	#define ftello(x)       ftell(x)
#endif

#endif /* __FB_CONFIG_H__ */
