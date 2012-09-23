#macro check_( T, N, id )
	#print "1:"
	scope
		dim as T x = N
	end scope

	#print "2:"
	scope
		dim as T x
		x = N
	end scope

	#print "3:"
	namespace
		private sub f( byval x as T )
			f( N )
		end sub
	end namespace

	#print "4:"
	namespace
		private sub f( byref x as T )
			f( N )
		end sub
	end namespace

	#print "5:"
	namespace
		private sub f( byval x as T = N )
		end sub
	end namespace

	#print "6:"
	namespace
		private sub f( byref x as T = N )
		end sub
	end namespace

	#print "7:"
	scope
		const x as T = N
	end scope
#endmacro

#macro check( T, N )
	#print
	#print "warnings for: " #T #N
	check_( T, N, __LINE__ )
#endmacro

#print ""
#print "byte:"
#print ""
check( byte, -  9223372036854775808ull )  '' -&h8000000000000000
check( byte, -           2147483649ll  )  '' -&h80000000 - 1
check( byte, -           2147483649ull )
check( byte, -           2147483648u   )  '' -&h80000000
check( byte, -           2147483648ll  )
check( byte, -           2147483648ull )
check( byte, -           2147483647u   )  '' -&h80000000 + 1
check( byte, -           2147483647ll  )
check( byte, -           2147483647ull )
check( byte, -                32769    )  '' -&h8000 - 1
check( byte, -                32769u   )
check( byte, -                32769ll  )
check( byte, -                32769ull )
check( byte, -                32768    )  '' -&h8000
check( byte, -                32768u   )
check( byte, -                32768ll  )
check( byte, -                32768ull )
check( byte, -                  129    )  '' -&h80 - 1
check( byte, -                  129u   )
check( byte, -                  129ll  )
check( byte, -                  129ull )
check( byte,                    256    )  '' &hFF + 1
check( byte,                    256u   )
check( byte,                    256ll  )
check( byte,                    256ull )
check( byte,                  65536    )  '' &hFFFF + 1
check( byte,                  65536u   )
check( byte,                  65536ll  )
check( byte,                  65536ull )
check( byte,             2147483647u   )  '' &h7FFFFFFF
check( byte,             2147483647ll  )
check( byte,             2147483647ull )
check( byte,             2147483648u   )  '' &h80000000
check( byte,             2147483648ll  )
check( byte,             2147483648ull )
check( byte,             4294967295u   )  '' &hFFFFFFFF
check( byte,             4294967295ll  )
check( byte,             4294967295ull )
check( byte,             4294967296ll  )  '' &hFFFFFFFF + 1
check( byte,             4294967296ull )
check( byte,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( byte,    9223372036854775807ull )
check( byte,    9223372036854775808ull )  '' &h8000000000000000
check( byte,   9.223372036854775e+18   )
check( byte,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( byte,  1.844674407370955e+19    )
check( byte,   3.402823e+38 )
check( byte, - 3.402823e+38 )
check( byte,   1.797693134862316e+308 )
check( byte, - 1.797693134862316e+308 )

#print ""
#print "ubyte:"
#print ""
check( ubyte, -  9223372036854775808ull )  '' -&h8000000000000000
check( ubyte, -           2147483649ll  )  '' -&h80000000 - 1
check( ubyte, -           2147483649ull )
check( ubyte, -           2147483648u   )  '' -&h80000000
check( ubyte, -           2147483648ll  )
check( ubyte, -           2147483648ull )
check( ubyte, -           2147483647u   )  '' -&h80000000 + 1
check( ubyte, -           2147483647ll  )
check( ubyte, -           2147483647ull )
check( ubyte, -                32769    )  '' -&h8000 - 1
check( ubyte, -                32769u   )
check( ubyte, -                32769ll  )
check( ubyte, -                32769ull )
check( ubyte, -                32768    )  '' -&h8000
check( ubyte, -                32768u   )
check( ubyte, -                32768ll  )
check( ubyte, -                32768ull )
check( ubyte, -                  129    )  '' -&h80 - 1
check( ubyte, -                  129u   )
check( ubyte, -                  129ll  )
check( ubyte, -                  129ull )
check( ubyte,                    256    )  '' &hFF + 1
check( ubyte,                    256u   )
check( ubyte,                    256ll  )
check( ubyte,                    256ull )
check( ubyte,                  65536    )  '' &hFFFF + 1
check( ubyte,                  65536u   )
check( ubyte,                  65536ll  )
check( ubyte,                  65536ull )
check( ubyte,             2147483647u   )  '' &h7FFFFFFF
check( ubyte,             2147483647ll  )
check( ubyte,             2147483647ull )
check( ubyte,             2147483648u   )  '' &h80000000
check( ubyte,             2147483648ll  )
check( ubyte,             2147483648ull )
check( ubyte,             4294967295u   )  '' &hFFFFFFFF
check( ubyte,             4294967295ll  )
check( ubyte,             4294967295ull )
check( ubyte,             4294967296ll  )  '' &hFFFFFFFF + 1
check( ubyte,             4294967296ull )
check( ubyte,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( ubyte,    9223372036854775807ull )
check( ubyte,    9223372036854775808ull )  '' &h8000000000000000
check( ubyte,   9.223372036854775e+18   )
check( ubyte,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( ubyte,  1.844674407370955e+19    )
check( ubyte,   3.402823e+38 )
check( ubyte, - 3.402823e+38 )
check( ubyte,   1.797693134862316e+308 )
check( ubyte, - 1.797693134862316e+308 )

#print ""
#print "short:"
#print ""
check( short, -  9223372036854775808ull )  '' -&h8000000000000000
check( short, -           2147483649ll  )  '' -&h80000000 - 1
check( short, -           2147483649ull )
check( short, -           2147483648u   )  '' -&h80000000
check( short, -           2147483648ll  )
check( short, -           2147483648ull )
check( short, -                32769    )  '' -&h8000 - 1
check( short, -                32769u   )
check( short, -                32769ll  )
check( short, -                32769ull )
check( short,                  65536    )  '' &hFFFF + 1
check( short,                  65536u   )
check( short,                  65536ll  )
check( short,                  65536ull )
check( short,             2147483647u   )  '' &h7FFFFFFF
check( short,             2147483647ll  )
check( short,             2147483647ull )
check( short,             2147483648u   )  '' &h80000000
check( short,             2147483648ll  )
check( short,             2147483648ull )
check( short,             4294967295u   )  '' &hFFFFFFFF
check( short,             4294967295ll  )
check( short,             4294967295ull )
check( short,             4294967296ll  )  '' &hFFFFFFFF + 1
check( short,             4294967296ull )
check( short,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( short,    9223372036854775807ull )
check( short,    9223372036854775808ull )  '' &h8000000000000000
check( short,   9.223372036854775e+18   )
check( short,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( short,  1.844674407370955e+19    )
check( short,   3.402823e+38 )
check( short, - 3.402823e+38 )
check( short,   1.797693134862316e+308 )
check( short, - 1.797693134862316e+308 )

#print ""
#print "ushort:"
#print ""
check( ushort, -  9223372036854775808ull )  '' -&h8000000000000000
check( ushort, -           2147483649ll  )  '' -&h80000000 - 1
check( ushort, -           2147483649ull )
check( ushort, -           2147483648u   )  '' -&h80000000
check( ushort, -           2147483648ll  )
check( ushort, -           2147483648ull )
check( ushort, -                32769    )  '' -&h8000 - 1
check( ushort, -                32769u   )
check( ushort, -                32769ll  )
check( ushort, -                32769ull )
check( ushort,                  65536    )  '' &hFFFF + 1
check( ushort,                  65536u   )
check( ushort,                  65536ll  )
check( ushort,                  65536ull )
check( ushort,             2147483647u   )  '' &h7FFFFFFF
check( ushort,             2147483647ll  )
check( ushort,             2147483647ull )
check( ushort,             2147483648u   )  '' &h80000000
check( ushort,             2147483648ll  )
check( ushort,             2147483648ull )
check( ushort,             4294967295u   )  '' &hFFFFFFFF
check( ushort,             4294967295ll  )
check( ushort,             4294967295ull )
check( ushort,             4294967296ll  )  '' &hFFFFFFFF + 1
check( ushort,             4294967296ull )
check( ushort,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( ushort,    9223372036854775807ull )
check( ushort,    9223372036854775808ull )  '' &h8000000000000000
check( ushort,   9.223372036854775e+18   )
check( ushort,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( ushort,  1.844674407370955e+19    )
check( ushort,   3.402823e+38 )
check( ushort, - 3.402823e+38 )
check( ushort,   1.797693134862316e+308 )
check( ushort, - 1.797693134862316e+308 )

#print ""
#print "integer:"
#print ""
check( integer, -  9223372036854775808ull )  '' -&h8000000000000000
check( integer, -           2147483649ll  )  '' -&h80000000 - 1
check( integer, -           2147483649ull )
check( integer,             4294967296ll  )  '' &hFFFFFFFF + 1
check( integer,             4294967296ull )
check( integer,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( integer,    9223372036854775807ull )
check( integer,    9223372036854775808ull )  '' &h8000000000000000
check( integer,   9.223372036854775e+18   )
check( integer,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( integer,  1.844674407370955e+19    )
check( integer,   3.402823e+38 )
check( integer, - 3.402823e+38 )
check( integer,   1.797693134862316e+308 )
check( integer, - 1.797693134862316e+308 )

#print ""
#print "uinteger:"
#print ""
check( uinteger, -  9223372036854775808ull )  '' -&h8000000000000000
check( uinteger, -           2147483649ll  )  '' -&h80000000 - 1
check( uinteger, -           2147483649ull )
check( uinteger,             4294967296ll  )  '' &hFFFFFFFF + 1
check( uinteger,             4294967296ull )
check( uinteger,    9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( uinteger,    9223372036854775807ull )
check( uinteger,    9223372036854775808ull )  '' &h8000000000000000
check( uinteger,   9.223372036854775e+18   )
check( uinteger,   18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( uinteger,  1.844674407370955e+19    )
check( uinteger,   3.402823e+38 )
check( uinteger, - 3.402823e+38 )
check( uinteger,   1.797693134862316e+308 )
check( uinteger, - 1.797693134862316e+308 )

#print ""
#print "longint:"
#print ""
check( longint,   3.402823e+38 )
check( longint, - 3.402823e+38 )
check( longint,   1.797693134862316e+308 )
check( longint, - 1.797693134862316e+308 )

#print ""
#print "ulongint:"
#print ""
check( ulongint,   3.402823e+38 )
check( ulongint, - 3.402823e+38 )
check( ulongint,   1.797693134862316e+308 )
check( ulongint, - 1.797693134862316e+308 )

#print ""
#print "single:"
#print ""
check( single,   1.797693134862316e+308 )
check( single,   4.490656458412465e-324 )
check( single, - 4.490656458412465e-324 )
check( single, - 1.797693134862316e+308 )

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' cases that shouldn't generate a warning

#print
#print
#print "---------- no warnings should be shown below ----------"

#undef check
#macro check( T, N )
	#print
	#print "no warnings for: " #T #N
	check_( T, N, __LINE__ )
#endmacro

#print ""
#print "byte:"
#print ""
check( byte, - 128    )  '' -&h80
check( byte, - 128u   )
check( byte, - 128ll  )
check( byte, - 128ull )
check( byte, -   1    )
check( byte, -   1u   )
check( byte, -   1ll  )
check( byte, -   1ull )
check( byte, -   1.0  )
check( byte,     0    )
check( byte,     0u   )
check( byte,     0ll  )
check( byte,     0ull )
check( byte,     0.0  )
check( byte,   1.401298e-45           )  '' 0
check( byte, - 1.401298e-45           )  '' 0
check( byte,   4.490656458412465e-324 )  '' 0
check( byte, - 4.490656458412465e-324 )  '' 0
check( byte,     1    )
check( byte,     1u   )
check( byte,     1ll  )
check( byte,     1ull )
check( byte,     1.0  )
check( byte,   127    )  '' &h7F
check( byte,   127u   )
check( byte,   127ll  )
check( byte,   127ull )
check( byte,   128    )  '' &h80
check( byte,   128u   )
check( byte,   128ll  )
check( byte,   128ull )
check( byte,   255    )  '' &hFF
check( byte,   255u   )
check( byte,   255ll  )
check( byte,   255ull )

#print ""
#print "ubyte:"
#print ""
check( ubyte, - 128    )  '' -&h80
check( ubyte, - 128u   )
check( ubyte, - 128ll  )
check( ubyte, - 128ull )
check( ubyte, -   1    )
check( ubyte, -   1u   )
check( ubyte, -   1ll  )
check( ubyte, -   1ull )
check( ubyte, -   1.0  )
check( ubyte,     0    )
check( ubyte,     0u   )
check( ubyte,     0ll  )
check( ubyte,     0ull )
check( ubyte,     0.0  )
check( ubyte,   1.401298e-45           )  '' 0
check( ubyte, - 1.401298e-45           )  '' 0
check( ubyte,   4.490656458412465e-324 )  '' 0
check( ubyte, - 4.490656458412465e-324 )  '' 0
check( ubyte,     1    )
check( ubyte,     1u   )
check( ubyte,     1ll  )
check( ubyte,     1ull )
check( ubyte,     1.0  )
check( ubyte,   127    )  '' &h7F
check( ubyte,   127u   )
check( ubyte,   127ll  )
check( ubyte,   127ull )
check( ubyte,   128    )  '' &h80
check( ubyte,   128u   )
check( ubyte,   128ll  )
check( ubyte,   128ull )
check( ubyte,   255    )  '' &hFF
check( ubyte,   255u   )
check( ubyte,   255ll  )
check( ubyte,   255ull )

#print ""
#print "short:"
#print ""
check( short, - 32768    )  '' -&h8000
check( short, - 32768u   )
check( short, - 32768ll  )
check( short, - 32768ull )
check( short, -     1    )
check( short, -     1u   )
check( short, -     1ll  )
check( short, -     1ull )
check( short, -     1.0  )
check( short,       0    )
check( short,       0u   )
check( short,       0ll  )
check( short,       0ull )
check( short,       0.0  )
check( short,   1.401298e-45           )  '' 0
check( short, - 1.401298e-45           )  '' 0
check( short,   4.490656458412465e-324 )  '' 0
check( short, - 4.490656458412465e-324 )  '' 0
check( short,       1    )
check( short,       1u   )
check( short,       1ll  )
check( short,       1ull )
check( short,       1.0  )
check( short,   32767    )  '' &h7FFF
check( short,   32767u   )
check( short,   32767ll  )
check( short,   32767ull )
check( short,   32768    )  '' &h8000
check( short,   32768u   )
check( short,   32768ll  )
check( short,   32768ull )
check( short,   65535    )  '' &hFFFF
check( short,   65535u   )
check( short,   65535ll  )
check( short,   65535ull )

#print ""
#print "ushort:"
#print ""
check( ushort, - 32768    )  '' -&h8000
check( ushort, - 32768u   )
check( ushort, - 32768ll  )
check( ushort, - 32768ull )
check( ushort, -     1    )
check( ushort, -     1u   )
check( ushort, -     1ll  )
check( ushort, -     1ull )
check( ushort, -     1.0  )
check( ushort,       0    )
check( ushort,       0u   )
check( ushort,       0ll  )
check( ushort,       0ull )
check( ushort,       0.0  )
check( ushort,   1.401298e-45           )  '' 0
check( ushort, - 1.401298e-45           )  '' 0
check( ushort,   4.490656458412465e-324 )  '' 0
check( ushort, - 4.490656458412465e-324 )  '' 0
check( ushort,       1    )
check( ushort,       1u   )
check( ushort,       1ll  )
check( ushort,       1ull )
check( ushort,       1.0  )
check( ushort,   32767    )  '' &h7FFF
check( ushort,   32767u   )
check( ushort,   32767ll  )
check( ushort,   32767ull )
check( ushort,   32768    )  '' &h8000
check( ushort,   32768u   )
check( ushort,   32768ll  )
check( ushort,   32768ull )
check( ushort,   65535    )  '' &hFFFF
check( ushort,   65535u   )
check( ushort,   65535ll  )
check( ushort,   65535ull )

#print ""
#print "integer:"
#print ""
check( integer, - 2147483648u   )  '' -&h80000000
check( integer, - 2147483648ll  )
check( integer, - 2147483648ull )
check( integer, -          1    )
check( integer, -          1u   )
check( integer, -          1ll  )
check( integer, -          1ull )
check( integer, -          1.0  )
check( integer,            0    )
check( integer,            0u   )
check( integer,            0ll  )
check( integer,            0ull )
check( integer,            0.0  )
check( integer,   1.401298e-45           )  '' 0
check( integer, - 1.401298e-45           )  '' 0
check( integer,   4.490656458412465e-324 )  '' 0
check( integer, - 4.490656458412465e-324 )  '' 0
check( integer,            1    )
check( integer,            1u   )
check( integer,            1ll  )
check( integer,            1ull )
check( integer,            1.0  )
check( integer,   2147483647u   ) '' &h7FFFFFFF
check( integer,   2147483647ll  )
check( integer,   2147483647ull )
check( integer,   2147483648u   ) '' &h80000000
check( integer,   2147483648ll  )
check( integer,   2147483648ull )
check( integer,   4294967295u   ) '' &hFFFFFFFF
check( integer,   4294967295ll  )
check( integer,   4294967295ull )

#print ""
#print "uinteger:"
#print ""
check( uinteger, - 2147483648u   )  '' -&h80000000
check( uinteger, - 2147483648ll  )
check( uinteger, - 2147483648ull )
check( uinteger, -          1    )
check( uinteger, -          1u   )
check( uinteger, -          1ll  )
check( uinteger, -          1ull )
check( uinteger, -          1.0  )
check( uinteger,            0    )
check( uinteger,            0u   )
check( uinteger,            0ll  )
check( uinteger,            0ull )
check( uinteger,            0.0  )
check( uinteger,   1.401298e-45           )  '' 0
check( uinteger, - 1.401298e-45           )  '' 0
check( uinteger,   4.490656458412465e-324 )  '' 0
check( uinteger, - 4.490656458412465e-324 )  '' 0
check( uinteger,            1    )
check( uinteger,            1u   )
check( uinteger,            1ll  )
check( uinteger,            1ull )
check( uinteger,            1.0  )
check( uinteger,   2147483647u   ) '' &h7FFFFFFF
check( uinteger,   2147483647ll  )
check( uinteger,   2147483647ull )
check( uinteger,   2147483648u   ) '' &h80000000
check( uinteger,   2147483648ll  )
check( uinteger,   2147483648ull )
check( uinteger,   4294967295u   ) '' &hFFFFFFFF
check( uinteger,   4294967295ll  )
check( uinteger,   4294967295ull )

#print ""
#print "longint:"
#print ""
check( longint, - 9223372036854775808ull )
check( longint, -                   1    )
check( longint, -                   1u   )
check( longint, -                   1ll  )
check( longint, -                   1ull )
check( longint, -                   1.0  )
check( longint,                     0    )
check( longint,                     0u   )
check( longint,                     0ll  )
check( longint,                     0ull )
check( longint,                     0.0  )
check( longint,   1.401298e-45           )  '' 0
check( longint, - 1.401298e-45           )  '' 0
check( longint,   4.490656458412465e-324 )  '' 0
check( longint, - 4.490656458412465e-324 )  '' 0
check( longint,                     1    )
check( longint,                     1u   )
check( longint,                     1ll  )
check( longint,                     1ull )
check( longint,                     1.0  )
check( longint,   9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( longint,   9223372036854775807ull )
check( longint,   9223372036854775808ull )  '' &h8000000000000000
check( longint,  9.223372036854775e+18   )
check( longint,  18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( longint, 1.844674407370955e+19    )

#print ""
#print "ulongint:"
#print ""
check( ulongint, - 9223372036854775808ull )
check( ulongint, -                   1    )
check( ulongint, -                   1u   )
check( ulongint, -                   1ll  )
check( ulongint, -                   1ull )
check( ulongint, -                   1.0  )
check( ulongint,                     0    )
check( ulongint,                     0u   )
check( ulongint,                     0ll  )
check( ulongint,                     0ull )
check( ulongint,                     0.0  )
check( ulongint,   1.401298e-45           )  '' 0
check( ulongint, - 1.401298e-45           )  '' 0
check( ulongint,   4.490656458412465e-324 )  '' 0
check( ulongint, - 4.490656458412465e-324 )  '' 0
check( ulongint,                     1    )
check( ulongint,                     1u   )
check( ulongint,                     1ll  )
check( ulongint,                     1ull )
check( ulongint,                     1.0  )
check( ulongint,   9223372036854775807ll  )  '' &h7FFFFFFFFFFFFFFF
check( ulongint,   9223372036854775807ull )
check( ulongint,   9223372036854775808ull )  '' &h8000000000000000
check( ulongint,  9.223372036854775e+18   )
check( ulongint,  18446744073709551615ull )  '' &hFFFFFFFFFFFFFFFF
check( ulongint, 1.844674407370955e+19    )

#print ""
#print "single:"
#print ""
check( single, - 1            )
check( single, - 1u           )
check( single, - 1ll          )
check( single, - 1ull         )
check( single, - 1.0          )
check( single,   0            )
check( single,   0u           )
check( single,   0ll          )
check( single,   0ull         )
check( single,   0.0          )
check( single,   1            )
check( single,   1u           )
check( single,   1ll          )
check( single,   1ull         )
check( single,   1.0          )
check( single,   3.402823e+38 )
check( single,   1.401298e-45 )
check( single, - 1.401298e-45 )
check( single, - 3.402823e+38 )

#print ""
#print "double:"
#print ""
check( double, - 1            )
check( double, - 1u           )
check( double, - 1ll          )
check( double, - 1ull         )
check( double, - 1.0          )
check( double,   0            )
check( double,   0u           )
check( double,   0ll          )
check( double,   0ull         )
check( double,   0.0          )
check( double,   1            )
check( double,   1u           )
check( double,   1ll          )
check( double,   1ull         )
check( double,   1.0          )
check( double,   3.402823e+38 )
check( double,   1.401298e-45 )
check( double, - 1.401298e-45 )
check( double, - 3.402823e+38 )
check( double,   1.797693134862316e+308 )
check( double,   4.490656458412465e-324 )
check( double, - 4.490656458412465e-324 )
check( double, - 1.797693134862316e+308 )
