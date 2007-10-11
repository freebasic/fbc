''
''
'' get_bit_length -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __bigint_get_bit_length_bi__
#define __bigint_get_bit_length_bi__

#include once "big_int/big_int.bi"

private function get_bit_length cdecl alias "get_bit_length" (byval num as big_int_word) as integer
    dim as integer n_bits
	n_bits = 0    
    do while( num <> 0 )
        num shr= 1
        n_bits += 1
    loop
    return n_bits
end function

#endif
