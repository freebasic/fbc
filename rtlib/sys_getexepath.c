/* get the executable path */

#include "fb.h"

char *fb_hGetExePath( char *dst, int maxlen )
{
#if defined( HOST_DOS )
	char *p;
	int argv_len, len;

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
		int cwd_len;
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

	return p;

#elif defined( HOST_FREEBSD ) || defined( HOST_NETBSD ) || defined( HOST_OPENBSD )
	const char *p = strrchr( __fb_ctx.argv[0], '/' );
	if( p ) {
		int len = p - __fb_ctx.argv[0];
		if( len > maxlen ) {
			len = maxlen;
		}

		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
	} else {
		*dst = '\0';
	}
	return dst;

#elif defined( HOST_LINUX )
	char *p;
	char linkname[1024];
	struct stat finfo;
	int len;

	sprintf(linkname, "/proc/%d/exe", getpid());
	if ((stat(linkname, &finfo) == 0) && ((len = readlink(linkname, dst, maxlen - 1)) > -1)) {
		/* Linux-like proc fs is available */
		dst[len] = '\0';
		p = strrchr(dst, '/');
		if (p)
			*p = '\0';
		else
			dst[0] = '\0';
	} else {
		p = NULL;
	}

	return p;

#elif defined( HOST_WIN32 )
	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );
	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		*p = '\0';
	else
		dst[0] = '\0';
	return p;

#else
	/* !!!WRITEME!!! */
	dst[0] = '\0';
	return dst;

#endif
}
