#ifndef __FB_MATH_H__
#define __FB_MATH_H__

FBCALL double       fb_Rnd              ( float n );
FBCALL void         fb_Randomize        ( double seed, int algorithm );
FBCALL int          fb_SGNSingle        ( float x );
FBCALL int          fb_SGNDouble        ( double x );
FBCALL float        fb_FIXSingle        ( float x );
FBCALL double       fb_FIXDouble        ( double x );

#endif /* __FB_MATH_H__ */
