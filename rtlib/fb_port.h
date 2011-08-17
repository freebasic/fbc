/** Portable implementations of low-level functions.
 */

#ifndef __FB_PORT_H__
#define __FB_PORT_H__

#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

    /* We use memcmp from C because the compiler might replace this by a built-in
     * function which will definately be faster than our own implementation
     * in C. */
#define FB_MEMCMP(p1, p2, len) \
    memcmp( p1, p2, len )

    /* We have to wrap memcpy here because our MEMCPYX should return the position
     * after the destination string. */
    static __inline__ void *FB_MEMCPYX( void *dest, const void *src, size_t n )
    {
        memcpy(dest, src, n);
        return ((char *)dest)+n;
    }

#define FB_MEMCPY( dest, src, n ) \
    memcpy(dest, src, n)

#define FB_MEMCHR( s, c, n ) \
    memchr( s, c, n )

    static __inline__ size_t FB_MEMLEN( const void *s, int c, size_t n )
    {
        const char *pachData = (const char*) s;
        while (n--) {
            if( pachData[n]!=(char)c )
                return n+1;
        }
        return 0;
    }

	static __inline__ int fb_CpuDetect( void )
	{
		return 0;
	}
	
#ifdef __cplusplus
}
#endif

#endif
