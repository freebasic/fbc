#macro checkDec( suffix )
	#print
	#print "dec:"
	#print typeof(                    0##suffix )
	#print typeof(                    1##suffix )
	#print typeof(                32767##suffix )
	#print typeof(                32768##suffix )
	#print typeof(                65535##suffix )
	#print typeof(           2147483647##suffix )
	#print typeof(           2147483648##suffix )
	#print typeof(           4294967295##suffix )
	#print typeof(  9223372036854775807##suffix )
	#print typeof(  9223372036854775808##suffix )
	#print typeof( 18446744073709551615##suffix )
#endmacro

#macro checkBin( suffix )
	#print
	#print "bin:"
	#print typeof(                                                                &b0##suffix )
	#print typeof(                                                                &b1##suffix )
	#print typeof(                                                  &b111111111111111##suffix )
	#print typeof(                                                 &b1000000000000000##suffix )
	#print typeof(                                                 &b1111111111111111##suffix )
	#print typeof(                                  &b1111111111111111111111111111111##suffix )
	#print typeof(                                 &b10000000000000000000000000000000##suffix )
	#print typeof(                                 &b11111111111111111111111111111111##suffix )
	#print typeof(  &b111111111111111111111111111111111111111111111111111111111111111##suffix )
	#print typeof( &b1000000000000000000000000000000000000000000000000000000000000000##suffix )
	#print typeof( &b1111111111111111111111111111111111111111111111111111111111111111##suffix )
#endmacro

#macro checkOct( suffix )
	#print
	#print "oct:"
	#print typeof(                      &o0##suffix )
	#print typeof(                      &o1##suffix )
	#print typeof(                  &o77777##suffix )
	#print typeof(                 &o100000##suffix )
	#print typeof(                 &o177777##suffix )
	#print typeof(            &o17777777777##suffix )
	#print typeof(            &o20000000000##suffix )
	#print typeof(            &o37777777777##suffix )
	#print typeof(  &o777777777777777777777##suffix )
	#print typeof( &o1000000000000000000000##suffix )
	#print typeof( &o1777777777777777777777##suffix )
#endmacro

#macro checkHex( suffix )
	#print
	#print "hex:"
	#print typeof(                &h0##suffix )
	#print typeof(                &h1##suffix )
	#print typeof(             &h7FFF##suffix )
	#print typeof(             &h8000##suffix )
	#print typeof(             &hFFFF##suffix )
	#print typeof(         &h7FFFFFFF##suffix )
	#print typeof(         &h80000000##suffix )
	#print typeof(         &hFFFFFFFF##suffix )
	#print typeof( &h7FFFFFFFFFFFFFFF##suffix )
	#print typeof( &h8000000000000000##suffix )
	#print typeof( &hFFFFFFFFFFFFFFFF##suffix )
#endmacro

#print
#print "--------------------------------------------------------------------------------"
#print "no suffix"
checkDec( )
checkBin( )
checkOct( )
checkHex( )

#print
#print "--------------------------------------------------------------------------------"
#print "u suffix"
checkDec( u )
checkBin( u )
checkOct( u )
checkHex( u )

#print
#print "--------------------------------------------------------------------------------"
#print "l suffix"
checkDec( l )
checkBin( l )
checkOct( l )
checkHex( l )

#print
#print "--------------------------------------------------------------------------------"
#print "ul suffix"
checkDec( ul )
checkBin( ul )
checkOct( ul )
checkHex( ul )

#print
#print "--------------------------------------------------------------------------------"
#print "ll suffix"
checkDec( ll )
checkBin( ll )
checkOct( ll )
checkHex( ll )

#print
#print "--------------------------------------------------------------------------------"
#print "ull suffix"
checkDec( ull )
checkBin( ull )
checkOct( ull )
checkHex( ull )

#print
#print "--------------------------------------------------------------------------------"
#print "% suffix"
checkDec( % )
checkBin( % )
checkOct( % )
checkHex( % )

#print
#print "--------------------------------------------------------------------------------"
#print "& suffix"
checkDec( & )
checkBin( & )
checkOct( & )
checkHex( & )

#print
#print "--------------------------------------------------------------------------------"
#print "f suffix"
checkDec( f )
checkBin( f )
checkOct( f )

#print
#print "--------------------------------------------------------------------------------"
#print "d suffix"
checkDec( d )
checkBin( d )
checkOct( d )

#print
#print "--------------------------------------------------------------------------------"
#print "! suffix"
checkDec( ! )
checkBin( ! )
checkOct( ! )
checkHex( ! )

#print
#print "--------------------------------------------------------------------------------"
#print "# suffix"
checkDec( # )
checkBin( # )
checkOct( # )
checkHex( # )

#print
#print "--------------------------------------------------------------------------------"
#print "float literal"
#print
#print typeof( 0.0 )
#print typeof( 1.0 )
#print typeof( 0.1 )
#print "---"
#print typeof( .0 )
#print typeof( .1 )
#print "---"
#print typeof( 1.0f )
#print typeof( 1.0d )
#print typeof( 1.0e1 )
#print "---"
#print typeof( 0.12 )
#print typeof( 0.123 )
#print typeof( 0.1234 )
#print typeof( 0.12345 )
#print typeof( 0.123456 )
#print typeof( 0.1234567 )
#print typeof( 0.12345678 )
#print typeof( 0.123456789 )

#print
#print "--------------------------------------------------------------------------------"
#print "missing non decimal digits"
#print "expect 3 warnings"
const c02 = &b
const c08 = &o
const c16 = &h
#print "expect 0 warnings"
#define d02 &b
#define d08 &o
#define d16 &h
#print "expect 3 warnings"
const cd02 = &b
const cd08 = &o
const cd16 = &h
