typedef struct _FB_RNDINTERNALS {
	uint32_t algorithm;
	uint32_t length;
	uint32_t *stateblock;
	uint32_t **stateindex;
	uint32_t *iseed;
	double   ( *rndproc )( float n );
	uint32_t ( *rndproc32 )( void );
} FB_RNDINTERNALS;

FBCALL double       fb_Rnd              ( float n );
FBCALL uint32_t     fb_Rnd32            ( void );
FBCALL void         fb_GetRndInternals  ( FB_RNDINTERNALS *info );

FBCALL void         fb_Randomize        ( double seed, int algorithm );
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
