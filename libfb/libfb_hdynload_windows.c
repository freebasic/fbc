/*
 * dynload.c -- Dynamic library functions loading
 *
 * chng: oct/2006 written [lillo]
 *
 */

#include "fb.h"


/*:::::*/
FB_DYLIB fb_hDynLoad(const char *libname, const char **funcname, void **funcptr)
{
	FB_DYLIB lib;
	int i;
	
	if (!(lib = LoadLibrary(libname)))
		return NULL;
	
	/* Load functions */
	for (i = 0; funcname[i]; i++) {
		funcptr[i] = GetProcAddress(lib, funcname[i]);
		if (!funcptr[i]) {
			FreeLibrary(lib);
			return NULL;
		}
	}
	
	return lib;
}


/*:::::*/
int fb_hDynLoadAlso(FB_DYLIB lib, const char **funcname, void **funcptr, int count)
{
	int i;
	
	/* Load functions */
	for (i = 0; i < count; i++) {
		funcptr[i] = GetProcAddress(lib, funcname[i]);
		if (!funcptr[i])
			return -1;
	}
	
	return 0;
}


/*:::::*/
void fb_hDynUnload(FB_DYLIB *lib)
{
    if (*lib) {
    	FreeLibrary(*lib);
	    *lib = NULL;
	}
}
