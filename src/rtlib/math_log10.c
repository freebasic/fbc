/* integer log base 10 function */

#include "fb.h"


/*:::::*/
FBCALL int fb_IntLog10_32 ( unsigned int x )
{
	if( x >= (unsigned int)1.E+9 ) return 9;
	if( x >= (unsigned int)1.E+8 ) return 8;
	if( x >= (unsigned int)1.E+7 ) return 7;
	if( x >= (unsigned int)1.E+6 ) return 6;
	if( x >= (unsigned int)1.E+5 ) return 5;
	if( x >= (unsigned int)1.E+4 ) return 4;
	if( x >= (unsigned int)1.E+3 ) return 3;
	if( x >= (unsigned int)1.E+2 ) return 2;
	if( x >= (unsigned int)1.E+1 ) return 1;
	if( x >= (unsigned int)1.E+0 ) return 0;
	return -1;
}

/*:::::*/
FBCALL int fb_IntLog10_64 ( unsigned long long x )
{
	if( x & 0xffffffff00000000ull )
	{
		if( x >= (unsigned long long)1.E+19 ) return 19;
		if( x >= (unsigned long long)1.E+18 ) return 18;
		if( x >= (unsigned long long)1.E+17 ) return 17;
		if( x >= (unsigned long long)1.E+16 ) return 16;
		if( x >= (unsigned long long)1.E+15 ) return 15;
		if( x >= (unsigned long long)1.E+14 ) return 14;
		if( x >= (unsigned long long)1.E+13 ) return 13;
		if( x >= (unsigned long long)1.E+12 ) return 12;
		if( x >= (unsigned long long)1.E+11 ) return 11;
		if( x >= (unsigned long long)1.E+10 ) return 10;
		else return 9;
	}
	else
	{
		return fb_IntLog10_32( (unsigned int)x );
	}
}
