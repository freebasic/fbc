#ifndef __FBC_INT_FBCALL_BI__ 
#define __FBC_INT_FBCALL_BI__

'' definition for FBCALL
''
'' FBCALL is not a built-in word.  In fbc, calling convention is only implied as "fbcall"
'' in the absence of any other calling convention specifiers e.g. stdcall / cdecl / pascal
'' or some other structure that imply another default calling convention e.g. EXTERN "C"
'' 

# if __FB_LANG__ = "qb"
#     error "include not supported in qb dialect"
# endif

namespace FBC

'' declarations must follow:
''  ./src/rtlib/fb_config.h
''  ./src/rtlib/dos/fb_dos.h     :#define FBCALL
''  ./src/rtlib/unix/fb_unix.h   :#define FBCALL
''  ./src/rtlib/win32/fb_win32.h :#define FBCALL __stdcall
''  ./src/rtlib/win32/fb_win32.h :#define FBCALL
''  ./src/rtlib/xbox/fb_xbox.h   :#define FBCALL __stdcall

#if defined( __FB_WIN32__ ) or defined (__FB_XBOX__)
	#if defined( __FB_64BIT__)
		#define FBCALL cdecl
	#else
		#define FBCALL stdcall
	#endif
#else
	#define FBCALL cdecl
#endif

end namespace

#endif
