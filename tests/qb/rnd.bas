' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

#define irnd(n) (rnd(n) * 16777216#)

ASSERT( irnd(0.0) = 327680 ) '' initial seed value, 0.0 rnd parameter

ASSERT( irnd(1.0) = 11837123 ) '' positive rnd parameters
ASSERT( irnd(1e11) = 8949370 )


randomize 1.5 '' non-integer parameter
ASSERT( irnd() = 9837909 )

randomize 1.5 '' repeated randomize (with different results)
ASSERT( irnd() = 16468420 )


randomize 1.d+16 '' large negative number
ASSERT( irnd() = 722039 )

randomize -1.d+16 '' large positive number
ASSERT( irnd() = 6132062 )

randomize 0 '' zero
ASSERT( irnd() = 12752297 )


ASSERT( irnd(-1.5) = 7952518 ) '' negative rnd parameter
ASSERT( irnd(-1.5) = 7952518 ) '' (same results each time)

ASSERT( irnd(-8.e+10) = 11025253 ) '' negative large parameter
ASSERT( irnd(-0.0) = 11025253 ) '' 0 parameter (for repeated results)
