//
// compile with G++ 3.x or above:
// 		g++ -c cpplib.cpp -o cpplib.o
//		ar cr libcpplib.a cpplib.o
//

#include <string.h>
#include <ctype.h>
      
namespace str 
{
	char *ucaseme( char *s ) 
	{ 
		int c, len = strlen( s );
		
		for( int i = 0; i < len; i++ )
		{
            c = s[i];
            if( islower( c ) )
                s[i] = toupper( c );
		}
		
		return s;
	}
}
