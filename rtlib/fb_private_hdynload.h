#if defined HOST_UNIX
	typedef void *FB_DYLIB;

#elif defined HOST_WIN32
	#include <windows.h>
	typedef HANDLE FB_DYLIB;

#endif

FB_DYLIB fb_hDynLoad    (const char *libname, const char **funcname, void **funcptr);
int      fb_hDynLoadAlso(FB_DYLIB lib, const char **funcname, void **funcptr, int count);
void     fb_hDynUnload  (FB_DYLIB *lib);
