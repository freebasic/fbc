#ifndef __FB_CONFIG_H__
#define __FB_CONFIG_H__

#if defined HOST_XBOX
#elif defined __DJGPP__
	#define HOST_DOS
	#define HOST_DJGPP
#elif defined __MINGW32__ /* MinGW, MinGW-w64, TDM-GCC */
	#define HOST_MINGW
	#define HOST_WIN32
	/* We prefer using non-oldnames functions, see also win32/fb_win32.h */
	#define NO_OLDNAMES
	#define _NO_OLDNAMES
	/* Tell windows.h to omit many headers we don't need */
	#define WIN32_LEAN_AND_MEAN
#elif defined __CYGWIN__
	#define HOST_CYGWIN
	#define HOST_WIN32
	#define WIN32_LEAN_AND_MEAN
#elif defined __linux__
	#define HOST_LINUX
	#define HOST_UNIX
#elif defined __FreeBSD__
	#define HOST_FREEBSD
	#define HOST_UNIX
#elif defined __NetBSD__
	#define HOST_NETBSD
	#define HOST_UNIX
#elif defined __OpenBSD__
	#define HOST_OPENBSD
	#define HOST_UNIX
#elif defined __APPLE__
	#define HOST_DARWIN
	#define HOST_UNIX
#elif (defined sun || defined __sun) && defined __SVR4
	#define HOST_SOLARIS
	#define HOST_UNIX
#else
	#error "Couldn't identify target system!"
#endif

#ifdef HOST_UNIX
	/* Map off_t/fopen/fseeko/etc. to their 64bit versions */
	#define _FILE_OFFSET_BITS 64
#endif

#if defined __i386__
	#define HOST_X86
#elif defined __x86_64__
	#define HOST_X86_64
	#define HOST_64BIT
#elif defined __sparc__
	#ifdef __LP64__
		#define HOST_SPARC64
		#define HOST_64BIT
	#else
		#define HOST_SPARC
	#endif
#elif defined __ppc64__
	#define HOST_POWERPC64
	#define HOST_64BIT
#endif

#if defined HOST_MINGW && defined HOST_X86
	/* work around gcc bug 52991 */
	/* Since GCC 4.7 -mms-bitfields was made the default for mingw32,
	   causing structs to be "ms_struct" by default, but "packed" seems
	   to be broken in combination with that. Using "gcc_struct" (the old
	   default) helps.
	   Note that "gcc_struct" isn't recognized for *all* targets though. */
	#define FBPACKED __attribute__((gcc_struct, packed))
#else
	#define FBPACKED __attribute__((packed))
#endif

#endif
