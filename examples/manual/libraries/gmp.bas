'' examples/manual/libraries/gmp.bas
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
'' See Also: http://www.freebasic.net/wiki/wikka.php?wakka=ExtLibgmp
'' --------

#include once "gmp.bi"

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
