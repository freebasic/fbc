/* rnd# function */

#include "fb.h"

#if defined HOST_WIN32
	#include <windows.h>
	#include <wincrypt.h>
#elif defined HOST_LINUX
	#include <fcntl.h>
#endif

#define RND_AUTO		0
#define RND_CRT			1
#define RND_FAST		2
#define RND_MTWIST		3
#define RND_QB			4
#define RND_REAL		5

#define INITIAL_SEED	327680

#define MAX_STATE		624
#define PERIOD			397

static uint32_t generator = RND_AUTO;

static double hRnd_Startup( float n );
static double hRnd_CRT ( float n );
static double hRnd_QB ( float n );

static uint32_t hRnd_Startup32( void );
static uint32_t hRnd_CRT32 ( void );
static uint32_t hRnd_QB32 ( void );

static double ( *rnd_func )( float ) = hRnd_Startup;
static uint32_t ( *rnd_func32 )( void ) = hRnd_Startup32;

static uint32_t iseed = INITIAL_SEED;
static uint32_t state[MAX_STATE], *p = NULL;

static double last_num = 0.0;

static void hStartup( void )
{
	switch( __fb_ctx.lang ) {
	case FB_LANG_QB:
		generator = RND_QB;
		rnd_func = hRnd_QB;
		rnd_func32 = hRnd_QB32;
		iseed = INITIAL_SEED;
		break;
	case FB_LANG_FB_FBLITE:
	case FB_LANG_FB_DEPRECATED:
		generator = RND_CRT;
		rnd_func = hRnd_CRT;
		rnd_func32 = hRnd_CRT32;
		break;
	default:
		fb_Randomize( 0.0, 0 );
		break;
	}
}

static uint32_t hRnd_Startup32 ( void )
{
	hStartup();
	return fb_Rnd32();
}

static double hRnd_Startup ( float n )
{
	hStartup();
	return fb_Rnd( n );
}

static uint32_t hRnd_CRT32 ( void )
{
	return rand( );
}

static double hRnd_CRT ( float n )
{
	if( n == 0.0 )
		return last_num;

	/* return between 0 and 1 (but never 1) */
	return (double)hRnd_CRT32( ) * ( 1.0 / ( (double)RAND_MAX + 1.0 ) );
}

static uint32_t hRnd_FAST32 ( void )
{
	/* Constants from 'Numerical recipes in C' chapter 7.1 */
	iseed = ( ( 1664525 * iseed ) + 1013904223 );
	return iseed;
}

static double hRnd_FAST ( float n )
{
	/* return last value if argument is 0.0 */
	if( n == 0.0 )
		return (double)iseed / (double)4294967296ULL;

	/* return between 0 and 1 (but never 1) */
	return (double)hRnd_FAST32() / (double)4294967296ULL;
}

static uint32_t hRnd_MTWIST32 ( void )
{
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

	return v;
}

static double hRnd_MTWIST ( float n )
{
	if( n == 0.0 )
		return last_num;

	return (double)hRnd_MTWIST32() / (double)4294967296ULL;
}

static uint32_t hRnd_QB32 ( void )
{
	iseed = ( ( iseed * 0xFD43FD ) + 0xC39EC3 ) & 0xFFFFFF;
	return iseed;
}

static double hRnd_QB ( float n )
{
	union {
		float f;
		uint32_t i;
	} ftoi;

	if( n == 0.0 )
		return (float)iseed / (float)0x1000000;

	if( n < 0.0 ) {
		ftoi.f = n;
		uint32_t s = ftoi.i;
		iseed = s + ( s >> 24 );
	}

	return (float)hRnd_QB32() / (float)0x1000000;
}

#if defined HOST_WIN32 || defined HOST_LINUX
static int hRefillRealRndNumber( )
{
	int success = 0;
#if defined HOST_WIN32
	HCRYPTPROV provider = 0;
	if( CryptAcquireContext( &provider, NULL, 0, PROV_RSA_FULL, 0 ) == TRUE ) {
		success = CryptGenRandom( provider, sizeof(state), (BYTE*)state );
		CryptReleaseContext( provider, 0 );
	}

#elif defined HOST_LINUX
	int urandom = open( "/dev/urandom", O_RDONLY );
	if( urandom != -1 ) {
		success = ( read( urandom, state, sizeof(state) ) == sizeof(state) );
		close( urandom );
	}
#endif
	if( success ) {
		p = state;
	}
	return success; 
}

static uint32_t hRnd_REAL32( void )
{
	uint32_t v;
	if( p == ( state + MAX_STATE ) ) {
		/* get new random numbers, if not available, redirect to MTwist as per docs */
		if( hRefillRealRndNumber( ) == 0 ) {
			fb_Randomize( -1.0, RND_MTWIST );
			return fb_Rnd32( );
		}
	}
	v = *(p++);
	return v;
}

static double hRnd_REAL( float n )
{
	if( n == 0.0 )
		return last_num;

	return (double)hRnd_REAL32() / (double)4294967296ULL;
}
#endif

FBCALL double fb_Rnd ( float n )
{
	FB_MATH_LOCK();
	last_num = rnd_func( n );
	FB_MATH_UNLOCK();
	return last_num;
}

FBCALL uint32_t fb_Rnd32 ( void )
{
	uint32_t result;
	FB_MATH_LOCK();
	result = rnd_func32( );
	FB_MATH_UNLOCK();
	return result;
}

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

	FB_MATH_LOCK();

	if( seed == -1.0 )
	{
		/* Take value of Timer to ensure a non-constant seed.  The seeding
		algorithms (with the exception of the QB one) take the integer value
		of the seed, so make a value that will change more than once a second */

		dtoi.d = fb_Timer( );
		seed = (double)(dtoi.i[0] ^ dtoi.i[1]);
	}

	generator = algorithm;

	switch( algorithm ) {
	case RND_CRT:
		rnd_func = hRnd_CRT;
		rnd_func32 = hRnd_CRT32;
		srand( (unsigned int)seed );
		rand( );
		break;

	case RND_FAST:
		rnd_func = hRnd_FAST;
		rnd_func32 = hRnd_FAST32;
		iseed = (uint32_t)seed;
		break;

	case RND_QB:
		rnd_func = hRnd_QB;
		rnd_func32 = hRnd_QB32;
		dtoi.d = seed;
		uint32_t s = dtoi.i[1];
		s ^= ( s >> 16 );
		s = ( ( s & 0xFFFF ) << 8 ) | ( iseed & 0xFF );
		iseed = s;
		break;

#if defined HOST_WIN32 || defined HOST_LINUX
	case RND_REAL:
		rnd_func = hRnd_REAL;
		rnd_func32 = hRnd_REAL32;
		state[0] = (unsigned int)seed;
		for( i = 1; i < MAX_STATE; i++ )
			state[i] = ( state[i - 1] * 1664525 ) + 1013904223;
		p = state + MAX_STATE;
		break;
#endif

	default:
	case RND_MTWIST:
		rnd_func = hRnd_MTWIST;
		rnd_func32 = hRnd_MTWIST32;
		state[0] = (unsigned int)seed;
		for( i = 1; i < MAX_STATE; i++ )
			state[i] = ( state[i - 1] * 1664525 ) + 1013904223;
		p = state + MAX_STATE;
		break;
	}

	FB_MATH_UNLOCK();

}

FBCALL void fb_RndGetInternals( FB_RNDINTERNALS *info )
{
	if( info )
	{
		FB_MATH_LOCK();

		info->algorithm = generator;
		info->length = MAX_STATE;
		info->stateblock = &(state[0]);
		info->stateindex = &p;
		info->iseed = &iseed;
		info->rndproc = rnd_func;
		info->rndproc32 = rnd_func32;

		FB_MATH_UNLOCK();
	}
}
