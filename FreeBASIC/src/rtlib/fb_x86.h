/*
 *  libfb - FreeBASIC's runtime library
 *    Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/** X86-optimized implementations of low-level functions.
 */

#ifndef __FB_X86_H__
#define __FB_X86_H__

#ifdef __cplusplus
extern "C" {
#endif

    static __inline__ int FB_MEMCMP( const void *p1, size_t len1,
                                     const void *p2, size_t len2 )
    {
        int res, len = ((len1<len2) ? len1 : len2);
        __asm (
               " pushl %%esi      \n"
               " pushl %%edi      \n"
               " repe             \n"
               " cmpsb            \n"
               " je 0f            \n"
               " movl $1, %%ecx   \n"
               " jg 0f            \n"
               " neg %%ecx        \n"
               "0:                \n"
               " popl %%edi       \n"
               " popl %%esi       \n"
               : "=c" (res)
               : "c" (len), "S" (p1), "D" (p2)
              );
        if( res != 0 )
            return res;
        if( len1 != len2 )
            return (len1 < len2? -1: 1);
        return 0;
    }

    static __inline__ void *FB_MEMCPY( void *dest, const void *src, size_t n )
    {
        __asm (
               " pushl %%ecx      \n"
               " pushl %%esi      \n"
               " pushl %%edi      \n"
               " pushl %%ecx      \n"
               " shrl $2,%%ecx    \n"
               " rep              \n"
               " movsd            \n"
               " popl %%ecx       \n"
               " andl $3,%%ecx    \n"
               " rep              \n"
               " movsb            \n"
               " popl %%edi       \n"
               " popl %%esi       \n"
               " popl %%ecx       \n"
               :
               : "c" (n), "S" (src), "D" (dest)
              );
        return dest;
    }

    /** Same as FB_MEMCPY but returns position after destination string.
     */
    static __inline__ void *FB_MEMCPYX( void *dest, const void *src, size_t n )
    {
        __asm (
               " pushl %%ecx      \n"
               " pushl %%esi      \n"
               " pushl %%ecx      \n"
               " shrl $2,%%ecx    \n"
               " rep              \n"
               " movsd            \n"
               " popl %%ecx       \n"
               " andl $3,%%ecx    \n"
               " rep              \n"
               " movsb            \n"
               " popl %%esi       \n"
               " popl %%ecx       \n"
               : "=D" (dest)
               : "c" (n), "S" (src), "D" (dest)
              );
        return dest;
    }

    static __inline__ const void *FB_MEMCHR( const void *s, int c, size_t n )
    {
        const void *dst;
        __asm (
               " pushl %%ecx            \n"
               " pushf                  \n"
               " cld                    \n"
               " repne                  \n"
               " scasb                  \n"
               " jne 0f                 \n"
               " dec %%edi              \n"
               " jmp 1f                 \n"
               "0:                      \n"
               " xorl %%edi, %%edi      \n"
               "1:                      \n"
               " popf                   \n"
               " popl %%ecx             \n"
               : "=D" (dst)
               : "c" (n), "a" (c), "D" (s)
              );
        return dst;
    }

    /** Searches for the first ocurrence of a character unequal to c.
     */
    static __inline__ size_t FB_MEMLEN( const void *s, int c, size_t n )
    {
        size_t len;
        __asm (
               " pushl %%edi            \n"
               " pushf                  \n"
               " std                    \n"  /* DF = 1 -> from hi to lo */
               " repe                   \n"
               " scasb                  \n"
               " je 0f                  \n"
               " inc %%ecx              \n"
               "0:                      \n"
               " popf                   \n"
               " popl %%edi             \n"
               : "=c" (len)
               : "c" (n), "a" (c), "D" ((const char*) s + n - 1)
              );
        return len;
    }

#ifdef __cplusplus
}
#endif

#endif
