/* chrw$ routine */

#include "fb.h"

FB_WCHAR *fb_WstrChr ( int args, ... )
{
	FB_WCHAR 	*dst, *s;
	va_list 	ap;
	unsigned int num;
	int i;

	if( args <= 0 )
		return NULL;

	/* alloc temp string */
	va_start( ap, args );

    dst = fb_wstr_AllocTemp( args );
	if( dst != NULL )
	{
		/* convert */
		s = dst;
		for( i = 0; i < args; i++ )
		{
			num = va_arg( ap, unsigned int );
			*s++ = num;
		}
		/* null-term */
		*s = 0;
	}

	va_end( ap );

	return dst;
}
