/* Dynamic library loading functions */

#include "../fb.h"
#include <windows.h>

FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	void *res = NULL;

	if( (library) && (library->data) )
		res = LoadLibrary( library->data );

	/* del if temp */
	fb_hStrDelTemp( library );

	return res;
}

FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	void *proc = NULL;
	char procname[1024];
	int i;

	if( library == NULL )
		library = GetModuleHandle( NULL );

	if( (symbol) && (symbol->data) )
	{
		proc = (void*) GetProcAddress( (HINSTANCE) library, symbol->data );
		if( (!proc) && (!strchr( symbol->data, '@' )) ) {
			procname[1023] = '\0';
			for( i = 0; i < 256; i += 4 ) {
				snprintf( procname, 1023, "%s@%d", symbol->data, i );
				proc = (void*) GetProcAddress( (HINSTANCE) library, procname );
				if( proc )
					break;
			}
		}
	}

	/* del if temp */
	fb_hStrDelTemp( symbol );

	return proc;
}

FBCALL void *fb_DylibSymbolByOrd ( void *library, short int symbol )
{
	void *proc = NULL;

	if( library == NULL )
		library = GetModuleHandle( NULL );

	proc = (void*) GetProcAddress( (HINSTANCE) library, MAKEINTRESOURCE(symbol) );

	return proc;
}

FBCALL void fb_DylibFree( void *library )
{
	FreeLibrary((HINSTANCE) library);
}
