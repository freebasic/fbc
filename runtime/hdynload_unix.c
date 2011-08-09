/* Dynamic library functions loading */

#include "fb.h"
#include <stdlib.h>
#include <dlfcn.h>


/*:::::*/
FB_DYLIB fb_hDynLoad(const char *libname, const char **funcname, void **funcptr)
{
	FB_DYLIB lib;
	int i;
	
	/* First look if library was already statically linked with current executable */
	if (!(lib = dlopen(NULL, RTLD_LAZY)))
		return NULL;
	if (!dlsym(lib, funcname[0])) {
		dlclose(lib);
		if (!(lib = dlopen(libname, RTLD_LAZY)))
			return NULL;
	}
	
	/* Load functions */
	for (i = 0; funcname[i]; i++) {
		funcptr[i] = dlsym(lib, funcname[i]);
		if (!funcptr[i]) {
			dlclose(lib);
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
		funcptr[i] = dlsym(lib, funcname[i]);
		if (!funcptr[i])
			return -1;
	}
	
	return 0;
}


/*:::::*/
void fb_hDynUnload(FB_DYLIB *lib)
{
    if (*lib) {
    	dlclose(*lib);
	    *lib = NULL;
	}
}
