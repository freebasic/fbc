typedef enum _FB_RND_ALGORITHMS {
	FB_RND_AUTO = 0,
	FB_RND_CRT,
	FB_RND_FAST,
	FB_RND_MTWIST,
	FB_RND_QB,
	FB_RND_REAL
} FB_RND_ALGORITHMS;

/* single instance global state */
FBCALL void         fb_Randomize        ( double seed, int algorithm );
FBCALL double       fb_Rnd              ( float n );
FBCALL uint32_t     fb_Rnd32            ( void );

#define FB_RND_MAX_STATE 624

typedef struct _FB_RNDSTATE {
	uint32_t algorithm;        /* see FB_RND_ALGORITHMS */
	uint32_t length;           /* length of state vector (# of uint32_t) */

	/* function pointers to internal rnd() and rnd32() called by fb_Rnd() and fb_Rnd32() */
	double   ( *rndproc )( float n );
	uint32_t ( *rndproc32 )( void );

	union {
		uint64_t iseed64;      /* initial seed and state 64-bit */
		uint32_t iseed32;      /* initial seed and state 32-bit */
	};
	uint32_t *index32;         /* pointer to index in state vector, if length != 0 */
	
	/* state vector */
	uint32_t state32[FB_RND_MAX_STATE];
} FB_RNDSTATE;

FBCALL FB_RNDSTATE *fb_RndGetState ( void );

/* Constants from 'Numerical recipes in C' chapter 7.1 */
#define FBRNDFAST32(arg) ( ( (arg) * 1664525 ) + 1013904223 )

static __inline__ void hRnd_FillFAST32 ( uint32_t *buffer, uint32_t length32, uint32_t iseed32 )
{
	uint32_t i;
	buffer[0] = iseed32;
	for( i = 1; i < length32; i++ ) {
		buffer[i] = FBRNDFAST32( buffer[i - 1] );
	}
}

FBCALL int          fb_SGNSingle        ( float x );
FBCALL int          fb_SGNDouble        ( double x );
FBCALL float        fb_FIXSingle        ( float x );
FBCALL double       fb_FIXDouble        ( double x );

FBCALL double       fb_CVDFROMLONGINT   ( long long l );
FBCALL float        fb_CVSFROML         ( int l );
FBCALL int          fb_CVLFROMS         ( float f );
FBCALL long long    fb_CVLONGINTFROMD   ( double d );

FBCALL int fb_IntLog10_32 ( unsigned int x );
FBCALL int fb_IntLog10_64 ( unsigned long long x );
