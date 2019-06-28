/* Dynamic library loading functions */

#include "../fb.h"
#include "fb_private_console.h"
#include <dlfcn.h>

FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	void *res = NULL;
	int i;
	char libname[MAX_PATH];
	char *libnameformat[] = { "%s",
							  "lib%s",
							  "lib%s.so",
							  "./%s",
							  "./lib%s",
							  "./lib%s.so",
							  NULL };

	
	
	
	
	
	FB_LOCK( );
	fb_hExitConsole();
	FB_UNLOCK( );

	libname[MAX_PATH-1] = '\0';
	if( (library) && (library->data) ) {
		for( i = 0; libnameformat[i]; i++ ) {
			snprintf( libname, MAX_PATH-1, libnameformat[i], library->data );
			fb_hConvertPath( libname );
			res = dlopen( libname, RTLD_LAZY );
			if( res )
				break;
		}
	}

	/* del if temp */
	fb_hStrDelTemp( library );

	FB_LOCK( );
	fb_hInitConsole();
	FB_UNLOCK( );

	return res;
}

FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	void *proc = NULL;

	if( library == NULL )
		library = dlopen( NULL, RTLD_LAZY );

	if( (symbol) && (symbol->data) )
		proc = dlsym( library, symbol->data );

	/* del if temp */
	fb_hStrDelTemp( symbol );

	return proc;
}

FBCALL void *fb_DylibSymbolByOrd( void *library, short int symbol )
{
	/* Not applicable to Linux */
	return NULL;
}

FBCALL void fb_DylibFree( void *library )
{
	
	
	FB_LOCK( );
	fb_hExitConsole();
	FB_UNLOCK( );

	dlclose( library );

	FB_LOCK( );
	fb_hInitConsole();
	FB_UNLOCK( );
}
