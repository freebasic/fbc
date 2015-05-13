/* command$ */

#include "fb.h"

FBCALL FBSTRING *fb_Command ( int arg )
{
	FBSTRING *dst;
	ssize_t i, len;

	/* return all arguments? */
	if( arg < 0 )
	{
		/* no args? */
		if( __fb_ctx.argc <= 1 )
			return &__fb_ctx.null_desc;

		/* concatenate all args but 0 */
		len = 0;
		for( i = 1; i < __fb_ctx.argc; i++ )
			len += strlen( __fb_ctx.argv[i] );

		dst = fb_hStrAllocTemp( NULL, len + __fb_ctx.argc-2 );
		if( dst == NULL )
			return &__fb_ctx.null_desc;

		dst->data[0] = '\0';
		for( i = 1; i < __fb_ctx.argc; i++ )
		{
			strcat( dst->data, __fb_ctx.argv[i] );
			if( i != __fb_ctx.argc-1 )
				strcat( dst->data, " " );
    	}

    	return dst;
	}

    /* return just one argument */
	if( arg >= __fb_ctx.argc )
	    return &__fb_ctx.null_desc;

	len = strlen( __fb_ctx.argv[arg] );
	dst = fb_hStrAllocTemp( NULL, len );
	if( dst == NULL )
		return &__fb_ctx.null_desc;

	strcpy( dst->data, __fb_ctx.argv[arg] );

#ifdef HOST_DOS
	if( arg == 0 )
	{
		/* make drive letter uppercase */
		if( dst->data[1] == ':' )
			dst->data[0] = toupper( dst->data[0] );

		/* DOS gives us argv[0] with '/' path separators -
		 * change them to the more DOS-like '\'. */
		for( i = 0; i < len; ++i )
		{
			if( dst->data[i] == '/' )
				dst->data[i] = '\\';
		}
	}
#endif

	return dst;
}
