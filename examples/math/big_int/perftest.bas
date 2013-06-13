''***********************************************************************
''
''    BIG_INT library performance stress-test
''
''    Copyright 2004, 2005 Alexander Valyalkin
''
''    These sources is free software. You can redistribute it and/or
''    modify it freely. You can use it with any free or commercial
''    software.
''
''    These sources is distributed in the hope that it will be useful,
''    but WITHOUT ANY WARRANTY. Without even the implied warranty of
''    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
''    You may contact the author by:
''       e-mail:  valyala@gmail.com
''***********************************************************************



#include once "big_int/big_int_full.bi"

#ifndef NULL
#define NULL 0
#endif

sub print_num (byval tpl as string, byval num as big_int ptr)
    dim as big_int_str ptr s

    s = big_int_str_create( 1 )
    if( s = NULL ) then
        print "error when creating [s]"
        exit sub
    end if
    
    if( big_int_to_str( num, 10, s ) <> 0 ) then
        print "error when converting number [num] to string [s]"
        exit sub
    end if
    
    print tpl; *s->str
    
    big_int_str_destroy( s )
    
end sub

    
    dim as big_int ptr a, b, c

    '' initialize of [a], [b] & [c]
    a = big_int_create(1)
    b = big_int_create(1)
    c = big_int_create(1)
    if (a = NULL or b = NULL or c = NULL) then
        print "error when creating [a], [b] or [c]"
    	end 1
    end if

    '' calculate 3000!
    print "Start of calculating 3000!... ";
    if( big_int_fact(3000, a) ) then
        print "error during calculating 3000!"
    	end 2
    end if
    print_num( "3000! = ", a )
    print

    '' calculating 17^3000
    print "Start of calculating 17^3000... ";
    if( big_int_from_int( 17, a ) ) then
        print "error in big_int_from_int"
    	end 3
    end if
    
    if( big_int_pow(a, 3000, a) ) then
        print "error during calculating 17^3000"
    	end 4
    end if
    
    print_num( "17^3000 = ", a )
    print


	''
    ''    trying to find nextprime(2^1024).
	''
    ''    This test estimates the speed of generating 2048-bit
    ''    RSA key n = p * q, where p and q - different prime numbers
    ''
    print "Start of finding nextprime(2^1024)... ";
    if (big_int_from_int(2, a)) then
        print "error in big_int_from_int"
    	end 5
    end if
    if (big_int_pow(a, 1024, a)) then
        print "error during calculating 2^1024"
        end 6
    end if
    if (big_int_next_prime(a, a)) then
        print "error during finding nextprime(2^1024)"
        end 7
    end if
    
    print_num("nextprime(2^1024) = ", a)
    print


	''
    ''    calculate 65537^p = 1 (mod p),
    ''    where p = 2^2048
    ''    Result is proven by Euler theoreme:
    ''        Phi(p) = 2^2047, so 65537^p = (65537^Phi(p))^2 = 1^2 = 1 (mod p)
	''
    ''    This test estimates the speed of encrypting one block by 2048-bit
    ''    RSA key.
    ''
    print "Start of calculating 65537^p (mod p), where p = 2^2048... ";
    if (big_int_from_int(2, a)) then
        print "error in big_int_from_int"
    	end 8
    end if
    if (big_int_pow(a, 2048, a)) then
        print "error during calculating 2^2048"
        end 9
    end if
    if (big_int_from_int(65537, b)) then
        print "error in big_int_from_int"
        end 10
    end if
    if (big_int_powmod(b, a, a, c)) then
        print "error during calculating 65537^p (mod p)"
        end 11
    end if
    print_num( "65537^p (mod p) = ", c)
    print_num( "p = 2^2048 = ", a)
    print

    '' free allocated memory
    big_int_destroy(c)
    big_int_destroy(b)
    big_int_destroy(a)

    print "done, waiting for keypress to exit..."
    sleep
