//
// compile as:
//    g++ -c alias.cxx
//    ar rcs libalias.a alias.o
//

#include <string.h>
#include <ctype.h>

namespace str 
{
	void ucaseme( char *s ) 
	{ 
		int len = strlen( s );

		for( int i = 0; i < len; i++ ) {
			int c = s[i];
			if( islower( c ) )
				s[i] = toupper( c );
		}
	}
}
