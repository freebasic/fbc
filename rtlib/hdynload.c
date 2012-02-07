/* Dynamic library functions loading */

#include "fb.h"

#if defined( HOST_UNIX )
#	include <dlfcn.h>
#	define hDylibFree( lib ) dlclose( lib )
#	define hDylibSymbol( lib, sym ) dlsym( lib, sym )
#elif defined( HOST_WIN32 )
#	define hDylibFree( lib ) FreeLibrary( lib )
#	define hDylibSymbol( lib, sym ) GetProcAddress( lib, sym )
#else
#	error TODO
#endif

FB_DYLIB fb_hDynLoad(const char *libname, const char **funcname, void **funcptr)
{
	FB_DYLIB lib;
	int i;

#if defined( HOST_UNIX )
	/* First look if library was already statically linked with current executable */
	if (!(lib = dlopen(NULL, RTLD_LAZY)))
		return NULL;
	if (!dlsym(lib, funcname[0])) {
		dlclose(lib);
		if (!(lib = dlopen(libname, RTLD_LAZY)))
			return NULL;
	}
#elif defined( HOST_WIN32 )
	if (!(lib = LoadLibrary(libname)))
		return NULL;
#endif

	/* Load functions */
	for (i = 0; funcname[i]; i++) {
		funcptr[i] = hDylibSymbol(lib, funcname[i]);
		if (!funcptr[i]) {
			hDylibFree(lib);
			return NULL;
		}
	}

	return lib;
}

int fb_hDynLoadAlso(FB_DYLIB lib, const char **funcname, void **funcptr, int count)
{
	int i;

	/* Load functions */
	for (i = 0; i < count; i++) {
		funcptr[i] = hDylibSymbol(lib, funcname[i]);
		if (!funcptr[i])
			return -1;
	}

	return 0;
}

void fb_hDynUnload(FB_DYLIB *lib)
{
	if (*lib) {
		hDylibFree( *lib );
		*lib = NULL;
	}
}
