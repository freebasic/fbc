#ifndef __FB_CONFIG_H__
#define __FB_CONFIG_H__

#ifdef HOST_MINGW
	/* MinGW doesn't recognize _FILE_OFFSET_BITS, so we this manually */
	#define fseeko fseeko64
	#define ftello ftello64

	/* We want to use _mkdir() instead of mkdir() (see config.h.in),
	   so we just #define mkdir to _mkdir */
	/* Note the special case for mkdir: the second parameter will be
	   ignored, since the Windows function doesn't have it */
	#define chdir _chdir
	#define mkdir(x, y) _mkdir(x)
	#define pclose _pclose
	#define popen _popen
	#define putenv _putenv
	#define rmdir _rmdir
	#define snprintf _snprintf
	#define strncasecmp _strnicmp
#elif defined(HOST_DOS)
	/* In DJGPP we didn't use fseeko() at all (the DJGPP semi-2.04 setup
	   used for FB doesn't seem to have it) */
	#define fseeko(x, y, z) fseek(x, y, z)
	#define ftello(x)       ftell(x)
#endif

#endif /* __FB_CONFIG_H__ */
