'' examples/manual/libraries/gmp.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'gmp, The GNU Multiple Precision Arithmetic Library'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibgmp
'' --------

#include Once "gmp.bi"

Dim As mpz_ptr bignum = Allocate(SizeOf(__mpz_struct))
mpz_init_set_si(bignum, 2)
mpz_pow_ui(bignum, bignum, 65536)

Print "2^65536 = ";
Dim As ZString Ptr s = mpz_get_str(0, 10, bignum)
Print *s;
Deallocate(s)
Print

mpz_clear(bignum)
Deallocate(bignum)
