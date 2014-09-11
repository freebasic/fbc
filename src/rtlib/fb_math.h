FBCALL double       fb_Rnd              ( float n );
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
