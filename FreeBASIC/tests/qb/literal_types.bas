' TEST_MODE : COMPILE_ONLY_OK


#define typeof1 __typeof
#define typeof2(n) __typeof(n) '' lexed differently

#macro ASSERT_TYPE( n, t )
# if typeof1(n) <> __typeof(t)
#  print typeof1(n)
#  error
# endif
# if typeof2(n) <> __typeof(t)
#  print typeof2(n)
#  error
# endif
#endmacro

ASSERT_TYPE(     0 ,     integer )
ASSERT_TYPE( 32767 ,     integer )
ASSERT_TYPE( 32767&,     long    )
ASSERT_TYPE( 32768 ,     long    )
ASSERT_TYPE( 2147483647, long    )


ASSERT_TYPE( &h80000000, long    )
ASSERT_TYPE( &hffff7fff, long    )
ASSERT_TYPE( &hffff8000, long    )
ASSERT_TYPE(     &h8000, integer )
ASSERT_TYPE(     &hffff, integer )
ASSERT_TYPE( &hffffffff, long    )
ASSERT_TYPE(     &h7fff, integer )
ASSERT_TYPE(    &h10000, long    )
ASSERT_TYPE( &h7fffffff, long    )

ASSERT_TYPE( &o20000000000, long    )
ASSERT_TYPE( &o37777700000, long    )
ASSERT_TYPE( &o37777677777, long    )
ASSERT_TYPE(      &o100000, integer )
ASSERT_TYPE(      &o177777, integer )
ASSERT_TYPE( &o37777777777, long    )
ASSERT_TYPE(       &o77777, integer )
ASSERT_TYPE(      &o200000, long    )
ASSERT_TYPE( &o17777777777, long    )

ASSERT_TYPE( &b10000000000000000000000000000000, long    )
ASSERT_TYPE( &b11111111111111110000000000000000, long    )
ASSERT_TYPE( &b11111111111111101111111111111111, long    )
ASSERT_TYPE(                 &b1000000000000000, integer )
ASSERT_TYPE( &b11111111111111111111111111111111, long    )
ASSERT_TYPE(                 &b1111111111111111, integer )
ASSERT_TYPE(                 &b0111111111111111, integer )
ASSERT_TYPE(                &b10000000000000000, long    )
ASSERT_TYPE( &b01111111111111111111111111111111, long    )

ASSERT_TYPE( 1. , single )
ASSERT_TYPE( 12. , single )
ASSERT_TYPE( 123. , single )
ASSERT_TYPE( 1234. , single )
ASSERT_TYPE( 12345. , single )
ASSERT_TYPE( 123456. , single )
ASSERT_TYPE( 1234567. , single )

ASSERT_TYPE( 12345678. , double )
ASSERT_TYPE( 123456789. , double )
ASSERT_TYPE( 1234567890. , double )

ASSERT_TYPE( 1234.567    , single )
ASSERT_TYPE( 1234.567e   , single )
ASSERT_TYPE( 1234.567e10 , single )
ASSERT_TYPE( 1234.567f   , single )
ASSERT_TYPE( 1234.567!   , single )
ASSERT_TYPE( 1234.567d   , double )
ASSERT_TYPE( 1234.567d10 , double )
ASSERT_TYPE( 1234.567#   , double )

ASSERT_TYPE( 12345678! , single )
ASSERT_TYPE( 12345678.! , single )
ASSERT_TYPE( 12345678f , single )
ASSERT_TYPE( 12345678.f , single )

ASSERT_TYPE( 1234567#      , double )
ASSERT_TYPE( 1234567.#     , double )
ASSERT_TYPE( 1234567d      , double )
ASSERT_TYPE( 1234567.d     , double )
ASSERT_TYPE( 1234567d+10   , double )
ASSERT_TYPE( 1234567.d+10  , double )
ASSERT_TYPE( 12345678e+10  , double )
ASSERT_TYPE( 12345678.e+10 , double )

ASSERT_TYPE( 1234567e-10  , single )
ASSERT_TYPE( 1234567d-10  , double )
ASSERT_TYPE( 12345678e-10 , double )
