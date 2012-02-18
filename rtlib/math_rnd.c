/* rnd# function */

#include "fb.h"


#define RND_AUTO		0
#define RND_CRT			1
#define RND_FAST		2
#define RND_MTWIST		3
#define RND_QB			4

#define INITIAL_SEED	327680

#define MAX_STATE		624
#define PERIOD			397


static double hRnd_Startup( float n );

static double hRnd_CRT ( float n );
static double hRnd_FAST ( float n );
static double hRnd_MTWIST ( float n );
static double hRnd_QB ( float n );

static double ( *rnd_func )( float ) = hRnd_Startup;
static uint32_t iseed = INITIAL_SEED;
static uint32_t state[MAX_STATE], *p = NULL;

static double last_num = 0.0;

/*:::::*/
static double hRnd_Startup( float n )
{

	switch( __fb_ctx.lang ) {
	case FB_LANG_QB:
		rnd_func = hRnd_QB;
		iseed = INITIAL_SEED;
		break;

	case FB_LANG_FB_FBLITE:
	case FB_LANG_FB_DEPRECATED:
		rnd_func = hRnd_CRT;
		break;

	default:
		fb_Randomize( 0.0, 0 );
		break;

	}
	return fb_Rnd( n );
}


/*:::::*/
static double hRnd_CRT ( float n )
{

	if( n == 0.0 )
		return last_num;

	/* return between 0 and 1 (but never 1) */
	return (double)rand( ) * ( 1.0 / ( (double)RAND_MAX + 1.0 ) );
}


/*:::::*/
static double hRnd_FAST ( float n )
{

	/* return between 0 and 1 (but never 1) */
	/* Constants from 'Numerical recipes in C' chapter 7.1 */
	if( n != 0.0 )
		iseed = ( ( 1664525 * iseed ) + 1013904223 );

	return (double)iseed / (double)4294967296ULL;
}


/*:::::*/
static double hRnd_MTWIST ( float n )
{

	if( n == 0.0 )
		return last_num;

	uint32_t i, v, xor_mask[2] = { 0, 0x9908B0DF };
	
	if( !p ) {
		/* initialize state starting with an initial seed */
		fb_Randomize( INITIAL_SEED, RND_MTWIST );
	}
	
	if( p >= state + MAX_STATE ) {
		/* generate another array of 624 numbers */
		for( i = 0; i < MAX_STATE - PERIOD; i++ ) {
			v = ( state[i] & 0x80000000 ) | ( state[i + 1] & 0x7FFFFFFF );
			state[i] = state[i + PERIOD] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		}
		for( ; i < MAX_STATE - 1; i++ ) {
			v = ( state[i] & 0x80000000 ) | ( state[i + 1] & 0x7FFFFFFF );
			state[i] = state[i + PERIOD - MAX_STATE] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		}
		v = ( state[MAX_STATE - 1] & 0x80000000 ) | ( state[0] & 0x7FFFFFFF );
		state[MAX_STATE - 1] = state[PERIOD - 1] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		p = state;
	}
	
	v = *p++;
	v ^= ( v >> 11 );
	v ^= ( ( v << 7 ) & 0x9D2C5680 );
	v ^= ( ( v << 15 ) & 0xEFC60000 );
	v ^= ( v >> 18 );

	return (double)v / (double)4294967296ULL;
}


/*:::::*/
static double hRnd_QB ( float n )
{
	union {
		float f;
		uint32_t i;
	} ftoi;

	if( n != 0.0 ) {
		if( n < 0.0 ) {
			ftoi.f = n;
			uint32_t s = ftoi.i;
			iseed = ( s & 0xFFFFFF ) + ( s >> 24 );
		}
		iseed = ( ( iseed * 16598013 ) + 12820163 ) & 0xFFFFFF;
	}
	return (double)iseed / (double)0x1000000;
}


/*:::::*/
FBCALL double fb_Rnd ( float n )
{
	last_num = rnd_func( n );
	
	return last_num;
}


/*:::::*/
FBCALL void fb_Randomize ( double seed, int algorithm )
{
	int i;
	
	union {
		double d;
		uint32_t i[2];
	} dtoi;
	
	if( algorithm == RND_AUTO ) {
		switch( __fb_ctx.lang ) {
		case FB_LANG_QB:			algorithm = RND_QB;		break;
		case FB_LANG_FB_FBLITE:
		case FB_LANG_FB_DEPRECATED:	algorithm = RND_CRT;	break;
		default:
		case FB_LANG_FB:			algorithm = RND_MTWIST; break;
		}
	}
	
	if( seed == -1.0 )
	{
		/* Take value of Timer to ensure a non-constant seed.  The seeding
		algorithms (with the exception of the QB one) take the integer value
		of the seed, so make a value that will change more than once a second */

		dtoi.d = fb_Timer( );
		seed = (double)(dtoi.i[0] ^ dtoi.i[1]);
	}

	switch( algorithm ) {
	case RND_CRT:
		rnd_func = hRnd_CRT;
		srand( (int)seed );
		rand( );
		break;
		
	case RND_FAST:
		rnd_func = hRnd_FAST;
		iseed = (uint32_t)seed;
		break;
		
	case RND_QB:
		rnd_func = hRnd_QB;
		dtoi.d = seed;
		uint32_t s = dtoi.i[1];
		s ^= ( s >> 16 );
		s = ( ( s & 0xFFFF ) << 8 ) | ( iseed & 0xFF );
		iseed = s;
		break;
		
	default:
	case RND_MTWIST:
		rnd_func = hRnd_MTWIST;
		state[0] = (unsigned int)seed;
		for( i = 1; i < MAX_STATE; i++ )
			state[i] = ( state[i - 1] * 1664525 ) + 1013904223;
		p = state + MAX_STATE;
		break;
	}
}
