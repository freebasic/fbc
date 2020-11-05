/* Dynamic library loading functions */

#include "../fb.h"
#include <dlfcn.h>
#include <sys/dxe.h>

static int FirstDyLibCall = 0;

FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	void *res = NULL;

	char libname[MAX_PATH];
	char *libnameformat = "%s";

	if( FirstDyLibCall == 0 ) {
		#include "symb_reg.txt"
		dlregsym(libfb_symbol_table);
		FirstDyLibCall = 1;
	}

	if( (library) && (library->data) ) {
		snprintf( libname, MAX_PATH-1, libnameformat, library->data );
		libname[MAX_PATH-1] = '\0';
		fb_hConvertPath( libname );
		res = dlopen( libname, RTLD_GLOBAL + RTLD_LAZY);
	}

	/* del if temp */
	fb_hStrDelTemp( library );

	return res;
}

FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	void *proc = NULL;

	if( library == NULL )
		library = dlopen( NULL, RTLD_GLOBAL + RTLD_LAZY);

	if( (symbol) && (symbol->data) )
		proc = dlsym( library, symbol->data );

	/* del if temp */
	fb_hStrDelTemp( symbol );

	return proc;
}

FBCALL void *fb_DylibSymbolByOrd( void *library, short int symbol )
{
	/* Not applicable to DOS */
	return NULL;
}

FBCALL void fb_DylibFree( void *library )
{
	dlclose( library );
}
