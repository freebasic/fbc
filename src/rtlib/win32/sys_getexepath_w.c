/* get the executable path (wide string) */

#include "../fb.h"
#include <windows.h>

char *fb_hGetExePath_W( FB_WCHAR *dst, ssize_t maxlen )
{
	GetModuleFileNameW( GetModuleHandle( NULL ), dst, maxlen );

	char *p;
    p = '\0';                                         //assign an initial value of '\0'

	FB_WCHAR *w = wcsrchr( dst, _LC('\\') );          //get last backslash
	if( w != NULL )
	{
        p = "x";                                      //assign a value different from '\0', -> signal a valid path
		*(w+1) = '\0';                                //truncate after last "\"
  }
	else
		dst[0] = '\0';                                //not a valid path


	/* just a drive letter? make sure "\" follows to prevent using relative path */
	if( maxlen > 3 && dst[2] == '\0' && dst[1] == _LC(':'))
	{
		if( (dst[0] & ~32) >= _LC('A') && (dst[0] & ~32) <= _LC('Z') )
		{
			dst[2] = _LC('\\');
			dst[3] = '\0';
		}
	}

	return p;
}
