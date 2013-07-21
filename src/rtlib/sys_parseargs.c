#include "fb.h"

/* dst     - preallocated buffer to hold processed args
   src     - source string for arguments, may contain embedded null chars
   length  - length of src
   returns -1 on error, or number of arguments */
int fb_hParseArgs( char *dst, const char *src, ssize_t length )
{
	int in_quote = 0, argc = 0;
	ssize_t bs_count = 0, i = 0;
	const char *s = src;
	char *p = dst;

	/* s  - next char to read from src
	   p  - next char to write in dst */

	/* return -1 to indicate error */
	if( src == NULL || dst == NULL || length < 0 )
		return -1;

	/* skip leading white space */
	while( i < length && (*s == ' ' || *s == '\0') ) {
		i++;
		s++;
	}

	/* scan for arguments. ' ' and '\0' are delimiters */
	while( i < length ) {
		bs_count = 0;

		do {
			if( *s == '\\' ) {
				*p++ = *s;
				bs_count++;
			} else {
				if( *s == '\"') {
					if( bs_count & 1 ) {
						p -= ((bs_count - 1) >> 1) + 1;
						*p++ = *s;
					} else {
						p -= ( bs_count >> 1 );
						in_quote = !in_quote;
					}
				} else if( *s == ' ' || *s == '\0' ) {
					if( in_quote ) {
						*p++ = ' ';
					} else {
						*p++ = '\0';
						break;
					}
				} else {
					*p++ = *s;
				}

				bs_count = 0;
			}

			i++;
			s++;

		} while ( i < length );

		argc++;

		/* skip trailing white space */
		while( i < length && ( *s == ' ' || *s == '\0' ) ) {
			i++;
			s++;
		}
	}

	*p = '\0';

	/* return arguments found */
	return argc;
}
