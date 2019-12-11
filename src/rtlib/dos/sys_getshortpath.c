#include "../fb.h"

char *fb_hGetShortPath( char *src, char *dst, ssize_t maxlen )
{
	if( strchr( src, 32 ) == NULL ) {
		strncpy( dst, src, maxlen );
		dst[maxlen-1] = '\0';
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
        strncpy( dst, src, maxlen );
        dst[maxlen-1] = 0;
	}

	return dst;
}
