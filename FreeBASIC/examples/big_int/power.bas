

#include once "big_int/big_int_full.bi"

#ifndef NULL
#define NULL 0
#endif

sub print_num (byval num as big_int ptr)
    dim as big_int_str ptr s

    s = big_int_str_create( 1 )
    if( s = NULL ) then
        exit sub
    end if
    
    if( big_int_to_str( num, 10, s ) <> 0 ) then
        exit sub
    end if
    
    print *s->str;
    
    big_int_str_destroy( s )
    
end sub

    
    dim as big_int ptr bignum

    bignum = big_int_create( 1 )

    big_int_from_int( 2, bignum )
    
    big_int_pow( bignum, 65536, bignum )
    
    print "2^65536 = ";
    print_num bignum
    print

    big_int_destroy( bignum )
    
