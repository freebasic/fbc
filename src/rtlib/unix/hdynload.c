/* Internal dynamic library functions loading */

#include "../fb.h"
#include "../fb_private_hdynload.h"

#include <dlfcn.h>
#define hDylibFree( lib ) dlclose( lib )
#define hDylibSymbol( lib, sym ) dlsym( lib, sym )

FB_DYLIB fb_hDynLoad(const char *libname, const char *const *funcname, void **funcptr)
{
	FB_DYLIB lib;
	ssize_t i;

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
		funcptr[i] = hDylibSymbol(lib, funcname[i]);
		if (!funcptr[i]) {
			hDylibFree(lib);
			return NULL;
		}
	}

	return lib;
}

int fb_hDynLoadAlso( FB_DYLIB lib, const char *const *funcname, void **funcptr, ssize_t count )
{
	ssize_t i;

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
