/* Dynamic library loading functions */

#include "../fb.h"

FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	return NULL;
}

FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	return NULL;
}

FBCALL void *fb_DylibSymbolByOrd( void *library, short int symbol )
{
	return NULL;
}

FBCALL void fb_DylibFree( void *library )
{
}
