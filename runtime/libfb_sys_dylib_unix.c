/*
 * sys_dylib.c -- Dynamic library loading and symbols retrieving
 *
 * chng: feb/2005 written [lillo]
 * 		 jan/2007 fb_DylibSymbolByOrd [voodooattack] 
 */

#include "fb.h"


/*:::::*/
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

	libname[MAX_PATH-1] = '\0';
	if( (library) && (library->data) ) {
		for( i = 0; libnameformat[i]; i++ ) {
			snprintf( libname, MAX_PATH-1, libnameformat[i], library->data );
			fb_hConvertPath( libname, MAX_PATH-1 );
			res = dlopen( libname, RTLD_LAZY );
			if( res )
				break;
		}
	}

	/* del if temp */
	fb_hStrDelTemp( library );

	return res;
}

/*:::::*/
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

/*:::::*/
FBCALL void *fb_DylibSymbolByOrd ( void *library, short int symbol )
{
	/* 
		!!!WRITEME!!!
		NOT APPLICABLE TO LINUX 
			--  THE COMPILER SHOULD WARN ABOUT IT 
	*/
	
	return (void *)0;
}

/*:::::*/
FBCALL void fb_DylibFree( void *library )
{
	dlclose( library );
}
