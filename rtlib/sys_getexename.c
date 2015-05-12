/* get the executable's name */

#include "fb.h"
#if defined HOST_LINUX
	#include <sys/stat.h>
#elif defined HOST_WIN32
	#include <windows.h>
#endif

char *fb_hGetExeName( char *dst, int maxlen )
{
#if defined( HOST_DOS )
	strncpy(dst, __fb_ctx.argv[0], maxlen);
	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;
	return p;

#elif defined( HOST_FREEBSD ) || defined( HOST_NETBSD ) || defined( HOST_OPENBSD )
	const char *p = strrchr( __fb_ctx.argv[0], '/' );
	if( p )
		strlcpy( dst, p + 1, maxlen );
	else
		strlcpy( dst, __fb_ctx.argv[0], maxlen );
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
		if (p != NULL)
			++p;
		else
			p = dst;
	} else {
		p = NULL;
	}

	return p;

#elif defined( HOST_WIN32 )
	GetModuleFileName( GetModuleHandle( NULL ), dst, maxlen );
	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;
	return p;

#else
	/* !!!WRITEME!!! */
	dst[0] = '\0';
	return dst;
#endif
}
