#ifndef __FBC_INT_FBCALL_BI__ 
#define __FBC_INT_FBCALL_BI__

'' definition for FBCALL
''
'' FBCALL is not a built-in word in fbc as calling convention is only implied as "fbcall"
'' in the absence of other calling convention specifiers stdcall / cdecl / pascal
'' or other structures the imply some other default calling convention e.g. EXTERN "C"
'' 

# if __FB_LANG__ = "fb"
namespace FBC
# endif

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

# if __FB_LANG__ = "fb"
end namespace
# endif

#endif
