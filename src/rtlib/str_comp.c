/* string compare function */

#include "fb.h"

FBCALL int fb_StrCompare
	(
		void *str1,
		ssize_t str1_size,
		void *str2,
		ssize_t str2_size
	)
{
	const char *str1_ptr, *str2_ptr;
	ssize_t str1_len, str2_len;
	int	res;

	/* both not null? */
	if( (str1 != NULL) && (str2 != NULL) )
	{
		FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );
        FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

        res = FB_MEMCMP( str1_ptr,
                         str2_ptr,
                         ((str1_len < str2_len) ? str1_len : str2_len) );

        if( (res == 0) && (str1_len != str2_len) )
            res = (( str1_len > str2_len ) ? 1 : -1 );
	}
	/* left null? */
	else if( str1 == NULL )
	{
		/* right also null? return eq */
		if( str2 == NULL )
			res = 0;
		else
		{
			FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

			/* is right empty? return eq */
			if( str2_len == 0 )
				res = 0;

			/* else, return lt */
			else
				res = -1;
		}
	}
	/* only right is null */
	else
	{
		FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );

		/* is left empty? return eq */
		if( str1_len == 0 )
			res = 0;
		/* else, return gt */
		else
			res = 1;
	}


	FB_STRLOCK();

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return res;
}
