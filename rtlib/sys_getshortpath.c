/* get short path */

#include "fb.h"
#ifdef HOST_WIN32
	#include <windows.h>
#endif

char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{
#if defined( HOST_DOS )
	if( strchr( src, 32 ) == NULL ) {
		strcpy( dst, src );
    } else {
        /* FIXME: SPC is only allowed when using LFNs provided by a Windows
         * environment. So I guess that we have to use the following INT
         * function:
         *
         * IN:
         *
         * AX = 0x7160
         * CL = 0x01
         * CH = SUBST expansion flag, 0x00 = true path for SUBSTed drive letter
         *                            0x80 = SUBSTed drive letter
         * DS:SI = ASCIZ FLN
         * ES:DI = buffer for SFN ( max size = 67 or 128 ??? )
         *
         * OUT:
         *
         * CF = 1 on error
         *      AX = error code
         *
         */
        strncpy( dst, src, maxlen-1 );
        dst[maxlen-1] = 0;
	}

	return dst;

#elif defined( HOST_UNIX )
	if( strchr( src, 32 ) == NULL ) {
		strcpy( dst, src );
	} else {
		int i = 0;
		char *old_dst = dst;

		while ((*src) && (i < maxlen - 1)) {
			if (*src == ' ') {
				*dst++ = '\\';
				i++;
			}
			if (i == maxlen - 1)
				break;
			*dst++ = *src++;
			i++;
		}
		dst = old_dst;
		dst[maxlen - 1] = '\0';
	}

	return dst;

#elif defined( HOST_WIN32 )
	if( strchr( src, 32 ) == NULL ) {
		strcpy( dst, src );
	} else {
	 	GetShortPathName( src, dst, maxlen );
	}
	return dst;

#else
	/* !!!WRITEME!!! */
	strncpy(dst, src, maxlen);
	return dst;
#endif
}
