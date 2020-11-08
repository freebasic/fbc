/* rnd# function & randmoize statement for built-in PRNGs */

#include "fb.h"

/* Needed by FB_RND_REAL */
#if defined HOST_WIN32
	#include <windows.h>
	#include <wincrypt.h>
#elif defined HOST_LINUX
	#include <fcntl.h>
#endif

/* rtlib is initialzied so that RND & RND32 call the
   startup routines.  This allows calling RND without
   first call RANDOMIZE.  After the startup routine is
   called, the functions are remapped to the actual PRNG
   functions.
*/
static uint32_t hRnd_Startup32( void );
static double hRnd_Startup( float n );

static void hRndCtxInitCRT32    ( uint32_t seed );
static void hRndCtxInitFAST32   ( uint32_t seed );
static void hRndCtxInitMTWIST32 ( uint64_t seed );
static void hRndCtxInitQB32     ( uint32_t seed );
#if defined HOST_WIN32 || defined HOST_LINUX
static void hRndCtxInitREAL32   ( uint64_t seed );
#endif

#define INITIAL_SEED	327680

/* MAX_STATE is number of 32-bit unsigned integers */
/* used by FB_RND_MTWIST & FB_RND_REAL */
#define MAX_STATE     (FB_RND_MAX_STATE)
#define PERIOD        397

static FB_RNDSTATE ctx = {
	FB_RND_AUTO,       /* generator */
	0,                 /* length of state */
	hRnd_Startup,      /* fb_Rnd() */
	hRnd_Startup32,    /* fb_Rnd32() */
	{0},               /* iseed64 */
	NULL,              /* index pointer */
	/* state32[] - state for FB_RND_MTWIST 
	   and buffer for FB_RND_REAL follows */
	 {0}
};

/* last number as returned by RND(0.0) 
	- is updated by fb_Rnd() only
	- is never reset
	- is not updated by fb_Rnd32() or any of the other PRNG procedures
 */
static double last_num = 0.0;

/* FB_RND_CRT */
static uint32_t hRnd_CRT32 ( void )
{
	return rand( );
}

static double hRnd_CRT ( float n )
{
	if( n == 0.0 )
		return last_num;

	/* return between 0 and 1 (but never 1) */
	return (double)hRnd_CRT32() * ( 1.0 / ( (double)RAND_MAX + 1.0 ) );
}

static void hRndCtxInitCRT32 ( uint32_t seed )
{
	ctx.algorithm = FB_RND_CRT;
	ctx.length = 0;
	ctx.index32 = NULL;
	ctx.rndproc = hRnd_CRT;
	ctx.rndproc32 = hRnd_CRT32;

	srand( (unsigned int)seed );
}

/* FB_RND_FAST */
static uint32_t hRnd_FAST32 ( void )
{
	return ctx.iseed32 = FBRNDFAST32( ctx.iseed32 );
}

static double hRnd_FAST ( float n )
{
	/* return last value if argument is 0.0 */
	if( n == 0.0 )
		return (double)ctx.iseed32 / (double)4294967296ULL;

	/* return between 0 and 1 (but never 1) */
	return (double)hRnd_FAST32() / (double)4294967296ULL;
}

static void hRndCtxInitFAST32 ( uint32_t seed )
{
	ctx.algorithm = FB_RND_FAST;
	ctx.length = 0;
	ctx.index32 = NULL;
	ctx.iseed32 = seed;
	ctx.rndproc = hRnd_FAST;
	ctx.rndproc32 = hRnd_FAST32;
}

/* FB_RND_MTWIST */
static uint32_t hRnd_MTWIST32 ( void )
{
	uint32_t i, v, xor_mask[2] = { 0, 0x9908B0DF };

	if( !ctx.index32 ) {
		/* initialize state starting with an initial seed */
		hRndCtxInitMTWIST32( INITIAL_SEED );
	}

	if( ctx.index32 >= ctx.state32 + MAX_STATE ) {
		/* generate another array of 624 numbers */
		for( i = 0; i < MAX_STATE - PERIOD; i++ ) {
			v = ( ctx.state32[i] & 0x80000000 ) | ( ctx.state32[i + 1] & 0x7FFFFFFF );
			ctx.state32[i] = ctx.state32[i + PERIOD] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		}
		for( ; i < MAX_STATE - 1; i++ ) {
			v = ( ctx.state32[i] & 0x80000000 ) | ( ctx.state32[i + 1] & 0x7FFFFFFF );
			ctx.state32[i] = ctx.state32[i + PERIOD - MAX_STATE] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		}
		v = ( ctx.state32[MAX_STATE - 1] & 0x80000000 ) | ( ctx.state32[0] & 0x7FFFFFFF );
		ctx.state32[MAX_STATE - 1] = ctx.state32[PERIOD - 1] ^ ( v >> 1 ) ^ xor_mask[v & 0x1];
		ctx.index32 = ctx.state32;
	}

	v = *(ctx.index32++);
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

static void hRndCtxInitMTWIST32 ( uint64_t seed )
{
	ctx.algorithm = FB_RND_MTWIST;
	ctx.length = MAX_STATE;
	ctx.index32 = ctx.state32 + MAX_STATE;
	ctx.rndproc = hRnd_MTWIST;
	ctx.rndproc32 = hRnd_MTWIST32;

	hRnd_FillFAST32( ctx.state32, MAX_STATE, (uint32_t)seed );
}

/* FB_RND_QB */
static uint32_t hRnd_QB32 ( void )
{
	ctx.iseed32 = ( ( ctx.iseed32 * 0xFD43FD ) + 0xC39EC3 ) & 0xFFFFFF;
	return ctx.iseed32;
}

static double hRnd_QB ( float n )
{
	union {
		float f;
		uint32_t i;
	} ftoi;

	if( n == 0.0 )
		return (float)ctx.iseed32 / (float)0x1000000;

	if( n < 0.0 ) {
		ftoi.f = n;
		uint32_t s = ftoi.i;
		ctx.iseed32 = s + ( s >> 24 );
	}

	return (float)hRnd_QB32() / (float)0x1000000;
}

static void hRndCtxInitQB32 ( uint32_t seed )
{
	ctx.algorithm = FB_RND_QB;
	ctx.length = 0;
	ctx.index32 = NULL;
	ctx.iseed32 = seed;
	ctx.rndproc = hRnd_QB;
	ctx.rndproc32 = hRnd_QB32;
}

/* FB_RND_REAL */

#if defined HOST_WIN32 || defined HOST_LINUX
static int hRefillRealRndNumber( void )
{
	int success = 0;
#if defined HOST_WIN32
	HCRYPTPROV provider = 0;
	if( CryptAcquireContext( &provider, NULL, 0, PROV_RSA_FULL, 0 ) == TRUE ) {
		success = CryptGenRandom( provider, sizeof(ctx.state32), (BYTE*)ctx.state32 );
		CryptReleaseContext( provider, 0 );
	}

#elif defined HOST_LINUX
	int urandom = open( "/dev/urandom", O_RDONLY );
	if( urandom != -1 ) {
		success = ( read( urandom, ctx.state32, sizeof(ctx.state32) ) == sizeof(ctx.state32) );
		close( urandom );
	}
#endif
	if( success ) {
		ctx.index32 = ctx.state32;
	}
	return success; 
}

static uint32_t hRnd_REAL32( void )
{
	uint32_t v;
	if( ctx.index32 == ( ctx.state32 + MAX_STATE ) ) {
		/* get new random numbers, if not available, redirect to MTwist as per docs */
		if( hRefillRealRndNumber() == 0 ) {
			fb_Randomize( -1.0, FB_RND_MTWIST );
			return hRnd_MTWIST32();
		}
	}
	v = *(ctx.index32++);
	return v;
}

static double hRnd_REAL( float n )
{
	if( n == 0.0 )
		return last_num;

	return (double)hRnd_REAL32() / (double)4294967296ULL;
}

static void hRndCtxInitREAL32 ( uint64_t seed )
{
	ctx.algorithm = FB_RND_REAL;
	ctx.length = MAX_STATE;
	ctx.index32 = ctx.state32 + MAX_STATE;
	ctx.rndproc = hRnd_REAL;
	ctx.rndproc32 = hRnd_REAL32;

	/* initialize starting state - used by hRefillRealRndNumber() */
	hRnd_FillFAST32( ctx.state32, MAX_STATE, (uint32_t)seed );
}
#endif

/* RND Startup code */

static void hStartup( void )
{
	switch( __fb_ctx.lang ) {
	case FB_LANG_QB:
		hRndCtxInitQB32( INITIAL_SEED );
		break;
	case FB_LANG_FB_FBLITE:
	case FB_LANG_FB_DEPRECATED:
		hRndCtxInitCRT32( 1 );
		break;
	default:
		fb_Randomize( 0.0, FB_RND_AUTO );
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

static int getAlogrithm( int algorithm )
{
	if( algorithm == FB_RND_AUTO ) {
		switch( __fb_ctx.lang ) {
		case FB_LANG_QB:			algorithm = FB_RND_QB; break;
		case FB_LANG_FB_FBLITE:
		case FB_LANG_FB_DEPRECATED:	algorithm = FB_RND_CRT; break;
		default:
		case FB_LANG_FB:			algorithm = FB_RND_MTWIST; break;
		}
	}
	return algorithm;
}

/* Public API for the built-in PRNGs */

/* declare sub randomize alias "fb_Randomize" ( byval seed as double = -1.0, byval algorithm as long = FB.FB_RND_AUTO ) */
FBCALL void fb_Randomize ( double seed, int algorithm )
{
	union {
		double d;
		uint32_t i[2];
	} dtoi;

	FB_MATH_LOCK();

	if( seed == -1.0 )
	{
		/* Take value of Timer to ensure a non-constant seed.  The seeding
		algorithms (with the exception of the QB one) take the integer value
		of the seed, so make a value that will change more than once a second */

		dtoi.d = fb_Timer();
		seed = (double)(dtoi.i[0] ^ dtoi.i[1]);
	}

	ctx.algorithm = getAlogrithm( algorithm );

	switch( ctx.algorithm ) {
	case FB_RND_CRT:
		hRndCtxInitCRT32( (uint32_t)seed );
		fb_Rnd32();
		break;

	case FB_RND_FAST:
		hRndCtxInitFAST32( (uint32_t)seed );
		break;

	case FB_RND_QB:
		dtoi.d = seed;
		uint32_t s = dtoi.i[1];
		s ^= ( s >> 16 );
		s = ( ( s & 0xFFFF ) << 8 ) | ( ctx.iseed32 & 0xFF );
		hRndCtxInitQB32( (uint32_t)s );
		break;

#if defined HOST_WIN32 || defined HOST_LINUX
	case FB_RND_REAL:
		hRndCtxInitREAL32( (uint32_t)seed );
		break;
#endif

	default:
	case FB_RND_MTWIST:
		hRndCtxInitMTWIST32( (uint32_t)seed );
		break;
	}

	FB_MATH_UNLOCK();
}

/* declare function rnd alias "fb_Rnd" ( byval n as single = 1.0 ) as double */
FBCALL double fb_Rnd ( float n )
{
	FB_MATH_LOCK();
	last_num = ctx.rndproc( n );
	FB_MATH_UNLOCK();
	return last_num;
}

/* declare function rnd32 alias "fb_Rnd32" ( ) as ulong */
FBCALL uint32_t fb_Rnd32 ( void )
{
	uint32_t result;
	FB_MATH_LOCK();
	result = ctx.rndproc32();
	FB_MATH_UNLOCK();
	return result;
}

/* declare function rndGetState alias "fb_RndGetState" ( ) as FB_RNDSTATE ptr */
FBCALL FB_RNDSTATE *fb_RndGetState( void )
{
	return &ctx;
}
