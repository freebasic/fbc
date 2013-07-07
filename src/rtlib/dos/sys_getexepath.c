/* get the executable path */

#include "../fb.h"

char *fb_hGetExePath( char *dst, ssize_t maxlen )
{
	char *p;
	ssize_t argv_len, len;

	argv_len = strlen( __fb_ctx.argv[0] );

	/* check for drive letter - if there, get full path from argv[0] */
	if( isalpha(__fb_ctx.argv[0][0]) && __fb_ctx.argv[0][1] == ':' )
	{
		len = argv_len;
		if( len >= maxlen)
			return NULL;

		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
	}
	/* check for \ at beginning - get drive letter from cwd */
	else if( __fb_ctx.argv[0][0] == '\\' || __fb_ctx.argv[0][0] == '/' )
	{
		len = 1 + argv_len;
		if( len >= maxlen )
			return NULL;

		dst[0] = __fb_startup_cwd[0];
		dst[1] = ':';
		memcpy( dst + 2, __fb_ctx.argv[0], argv_len );
		dst[len] = '\0';
	}
	/* no drive letter, no \, so relative path - get cur dir from startup */
	else
	{
		ssize_t cwd_len;
		cwd_len = strlen(__fb_startup_cwd);

		len = cwd_len + 1 + argv_len;
		if( len >= maxlen )
			return NULL;

		memcpy( dst, __fb_startup_cwd, cwd_len );
		dst[cwd_len] = '\\';
		memcpy( dst + cwd_len + 1, __fb_ctx.argv[0], argv_len );
		dst[len] = '\0';
	}

	fb_hConvertPath( dst );

	p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';

	/* upcase drive letter to be consistent with win32 port */
	dst[0] = toupper( dst[0] );

	/* just a drive letter? make sure \ follows to prevent using relative path */
	if( maxlen > 3 && dst[2] == '\0' && dst[1] == ':' && isalpha(dst[0]) )
	{
		dst[2] = '\\';
		dst[3] = '\0';
	}

	return p;
}
