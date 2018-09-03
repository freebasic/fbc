/'

Generates ../const-overflow-select-const.bas

This test checks the warnings that could be generated at compile
time by SELECT CASE AS CONST.  More specifically, it tests 
parser-decl-symbtype.bas:cConstIntExprRanged() function.

Usage:

Generate the test source:
	$ fbc gen-select-const.bas
	$ ./gen-select-const > ../const-overflow-select-const.bas

Generate the results of compiling the test source:
	$ fbc -c ../const-overflow-select-const.bas > const-overflow-select-const.log

To check first time run, use this helper tool:
	$ fbc chk-warning-log.bas
	$ ./chk-warning-log const-overflow-select-const.log > chk-select-const.log

	Line numbers reported in ./chk-select-const.log refer to line numbers 
	in const-overflow-select-const.log which can then be referenced to line
	numbers in ../const-overflow-select-const.bas

	If no differences found, ./chk-select-const.log is empty file.

Data type range and test value matrix
	B = boolean
	S = signed
	U = unsigned
	# = byte size of data
	X = value is in data types range

	B   S S S S   U U U U
	1   1 2 4 8   1 2 4 8
	-   - - - X   - - - -   -9223372036854775808
	-   - - - X   - - - -   -4294967297
	-   - - - X   - - - -   -4294967296
	-   - - - X   - - - -   -2147483649
	-   - - X X   - - - -   -2147483648
	-   - - X X   - - - -   -65537
	-   - - X X   - - - -   -65536
	-   - - X X   - - - -   -32769
	-   - X X X   - - - -   -32768
	-   - X X X   - - - -   -257
	-   - X X X   - - - -   -256
	-   - X X X   - - - -   -129
	-   X X X X   - - - -   -128
	X   X X X X   - - - -   -1
	X   X X X X   X X X X   0
	-   X X X X   X X X X   1
	-   X X X X   X X X X   127
	-   - X X X   X X X X   128
	-   - X X X   X X X X   255
	-   - X X X   - X X X   256
	-   - X X X   - X X X   32767
	-   - - X X   - X X X   32768
	-   - - X X   - X X X   65535
	-   - - X X   - - X X   65536
	-   - - X X   - - X X   2147483647
	-   - - - X   - - X X   2147483648
	-   - - - X   - - X X   4294967295
	-   - - - X   - - - X   4294967296
	-   - - - X   - - - X   9223372036854775807
	-   - - - -   - - - X   9223372036854775808
	-   - - - -   - - - X   18446744073709551615

'/

type VALUEINFO
	index as integer
	value as zstring * 30
	over32bit as integer
	reserved as integer
end type

dim values( -14 to 16 ) as VALUEINFO = _
	{ _
		( -14, "(-9223372036854775807ll-1ll)" , true , false ), _
		( -13, "-4294967297ll"          , true , false ), _
		( -12, "-4294967296ll"          , true , false ), _
		( -11, "-2147483649ll"          , true , false ), _
		( -10, "-2147483648ll"          , false, false ), _
		(  -9, "-65537"                 , false, false ), _
		(  -8, "-65536"                 , false, false ), _
		(  -7, "-32769"                 , false, false ), _
		(  -6, "-32768"                 , false, false ), _
		(  -5, "-257"                   , false, false ), _
		(  -4, "-256"                   , false, false ), _
		(  -3, "-129"                   , false, false ), _
		(  -2, "-128"                   , false, false ), _
		(  -1, "-1"                     , false, false ), _
		(   0, "0"                      , false, false ), _
		(   1, "1"                      , false, false ), _
		(   2, "127"                    , false, false ), _
		(   3, "128"                    , false, false ), _
		(   4, "255"                    , false, false ), _
		(   5, "256"                    , false, false ), _
		(   6, "32767"                  , false, false ), _
		(   7, "32768"                  , false, false ), _
		(   8, "65535"                  , false, false ), _
		(   9, "65536"                  , false, false ), _
		(  10, "2147483647ull"          , false, false ), _
		(  11, "2147483648ull"          , false, false ), _
		(  12, "4294967295ull"          , false, false ), _
		(  13, "4294967296ull"          , true,  false ), _
		(  14, "9223372036854775807ull" , true , false ), _
		(  15, "9223372036854775808ull" , true , false ), _
		(  16, "18446744073709551615ull", false, false ) _
	}

type TYPEINFO
	dtype as zstring * 12 '' data type name
	dsize as integer      '' data type size
	conv as zstring * 12  '' casting function
	value_idx1 as integer '' first value in the data type's range
	value_idx2 as integer '' last value in the data type's range
	is32or64 as integer   '' type depends on being 32bit or 64bit
end type

dim types( 0 to ... ) as TYPEINFO = _
	{ _
		( "boolean" , 1, "cbool"   ,  -1,  0, 0 ), _
		( "byte"    , 1, "cbyte"   ,  -2,  2, 0 ), _
		( "ubyte"   , 1, "cubyte"  ,   0,  4, 0 ), _
		( "short"   , 2, "cshort"  ,  -6,  6, 0 ), _
		( "ushort"  , 2, "cushort" ,   0,  8, 0 ), _
		( "long"    , 4, "clng"    , -10, 10, 0 ), _
		( "ulong"   , 4, "culng"   ,   0, 12, 0 ), _
		( "integer" , 4, "cint"    , -10, 10, 1 ), _
		( "uinteger", 4, "cuint"   ,   0, 12, 1 ), _
		( "integer" , 8, "cint"    , -14, 14, 2 ), _
		( "uinteger", 8, "cuint"   ,   0, 16, 2 ), _
		( "longint" , 8, "clngint" , -14, 14, 0 ), _
		( "ulongint", 8, "culngint",   0, 16, 0 ) _
	}

dim x as string

/'
	chkwarn( T, C, V, W, E )
		
		T = data type name
		C = conversion function
		V = value
		W = if true, warning is expected to follow CASE
		E = if true, warning is expected to follow END SELECT
'/

print "'' Automatically generated by " + __FILE__ + ", " + __DATE_ISO__ 
print
print "#macro chkwarn( T, C, V, W, E )"
print "	scope"
print "		dim x as T"
print "		select case as const x"
print "		#print CASE C ( V )"
print "		#if( W )"
print "			#print warning in CASE expected: Overflow in constant conversion"
print "		#endif"
print "		case C ( V )"
print "		#ifndef __FB_64BIT__"
print "		#if( E )"
print "			#print warning in END SELECT expected: Overflow in constant conversion"
print "		#endif"
print "		#endif"
print "		end select"
print "	end scope"
print "#endmacro"
print

'' test if a constant value(value_idx) of type(case_idx) 
'' will fit in expression of type(select_idx)

'' SELECT CASE AS CONST
for select_idx as integer = lbound(types) to ubound(types)

	print "'' " & string( 75, "-" )
	print

	print "#print ---- " & ucase(types(select_idx).dtype) & " ----"
	print

	print "#print SELECT CASE AS CONST " & ucase( types(select_idx).dtype )
	print

	select case types(select_idx).is32or64
	case 1
		print "	#ifndef __FB_64BIT__"
	case 2
		print "	#ifdef __FB_64BIT__"
	end select

	'' CASE
	for case_idx as integer = lbound(types) to ubound(types)

		if( types(select_idx).is32or64 > 0 ) then
			if( types(case_idx).is32or64 > 0 ) then
				if( types(select_idx).is32or64 <> types(case_idx).is32or64 ) then
					continue for
				end if
			end if
		end if
			
		if( types(select_idx).is32or64 = 0 ) then
			select case types(case_idx).is32or64
			case 1
				print "	#ifndef __FB_64BIT__"
			case 2
				print "	#ifdef __FB_64BIT__"
			end select
		end if
		
		'' VALUE
		for value_idx as integer = types(case_idx).value_idx1 to types(case_idx).value_idx2

			x = chr(9) & "chkwarn( " 
			x &= types(select_idx).dtype
			x &= ", "
			x &= types(case_idx).conv
			x &= ", "
			x &= values(value_idx).value
			x &= ", "

			'' 'value_idx' out of range for type 'select_idx'
			if( value_idx < types(select_idx).value_idx1 or value_idx > types(select_idx).value_idx2 ) then
				x &= "true"
			else
				x &= "false"
			end if

			x &= ", "

			'' if SELECT CASE AS CONST data type is <= 32 bits and
			'' if jump table bias is over 32 bits after cast to the
			'' SELECT CASE AS CONST data type, we expect a warning
			'' in the jump table subtraction expression

			if( (types(select_idx).dsize <= 4) and (values(value_idx).over32bit <> false) ) then
				x &= "true"
			else
				x &= "false"
			end if
			x &= " )"

			print x
		next

		if( types(select_idx).is32or64 = 0 ) then
			select case types(case_idx).is32or64
			case 1, 2
				print "	#endif"
			end select
		end if

		print
	next

	select case types(select_idx).is32or64
	case 1, 2
		print "	#endif"
	end select

	print

next
