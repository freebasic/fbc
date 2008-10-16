

#include once "gmp.bi"

sub print_num (byval num as mpz_ptr)
	dim as zstring ptr s

	s = mpz_get_str( 0, 10, num )

	print *s;

	deallocate( s )

end sub

	dim as mpz_ptr bignum = allocate( len( __mpz_struct ) )

	mpz_init_set_si( bignum, 2 )

	mpz_pow_ui( bignum, bignum, 65536 )

	print "2^65536 = ";
	print_num( bignum )
	print

	mpz_clear( bignum )

	deallocate( bignum )
