
/* _M_IX86 _M_X64 defined by Microsoft; everyone else defines __SSE__ */
#if defined(_M_IX86) || defined(_M_X64) || defined(__SSE__)
#define SSE
#include <xmmintrin.h>

__m128 m1;
#endif

#ifdef __GNUC__
/* This is the same as __m128, but should also work on ARM, etc */
typedef float v4si __attribute__ ((vector_size (16)));

v4si v1;
#endif

int alignrequired(int arg) {
#ifdef __GNUC__
    /* On x86/x86_64 with gcc -O0, this compiles to a pair of movaps instructions */
    v4si v2 = v1;
#endif

#ifdef SSE
    /* This is also a movaps */
    __m128 m2 = _mm_load_ps( (float*) &m1 );
#endif
    return arg;
}
