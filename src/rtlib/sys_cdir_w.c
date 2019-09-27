/* curdir$ (wide string) */

#include "fb.h"
#ifdef HOST_WIN32
#include <windows.h> /* for MAX_PATH */
#endif

FBCALL FB_WCHAR *fb_CurDir_W( void )
{
	FB_WCHAR	*dst = 0;
	ssize_t len;


	FB_LOCK();

	FB_WCHAR tmp[MAX_PATH+1];
	len = fb_hGetCurrentDir_W( tmp, MAX_PATH );


	if( len > 0 )
	{
    len = fb_wstr_Len( &tmp[0] ) + 1;
    dst = fb_wstr_AllocTemp( len );                   

    if( dst != NULL )
      {
      memcpy(dst, &tmp[0], len*2);
      dst[len] = 0;
      }
    else
      return NULL;
	}
  else
    return NULL;

	FB_UNLOCK();

  return dst;

}
