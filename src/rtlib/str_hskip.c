#include "fb.h"

FBCALL char *fb_hStrSkipChar( char *s, ssize_t len, int c )
{
	char *p = s;

	if( s != NULL )
		while( (--len >= 0) && ((int)*p == c) )
			++p;

    return p;
}

FBCALL char *fb_hStrSkipCharRev( char *s, ssize_t len, int c )
{
	char *p;

	if( (s == NULL) || (len <= 0) )
		return s;

	p = &s[len-1];

    /* fixed-len's are filled with null's as in PB, strip them too */
    while( (--len >= 0) && (((int)*p == c) || ((int)*p == 0) ) )
		--p;

    return p;
}
