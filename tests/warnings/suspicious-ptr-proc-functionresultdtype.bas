type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

namespace ns1
	type UDT1
		i as integer
	end type
end namespace

type FWDREF1 as FWDREF1_
type FWDREF2 as FWDREF2_

dim p01 as function( ) as byte
dim p02 as function( ) as ubyte
dim p03 as function( ) as short
dim p04 as function( ) as ushort
dim p05 as function( ) as long
dim p06 as function( ) as ulong
dim p07 as function( ) as longint
dim p08 as function( ) as ulongint
dim p09 as function( ) as integer
dim p10 as function( ) as uinteger
dim p11 as function( ) as single
dim p12 as function( ) as double
dim p13 as function( ) as string
dim p14 as function( ) byref as zstring
dim p15 as function( ) byref as wstring
dim p16 as function( ) as UDT1
dim p17 as function( ) as UDT2
dim p18 as function( ) byref as FWDREF1
dim p19 as function( ) byref as FWDREF2
dim p20 as function( ) as sub( )
dim p21 as function( ) as function( ) as integer
dim p22 as function( ) as any      ptr
dim p23 as function( ) as byte     ptr
dim p24 as function( ) as ubyte    ptr
dim p25 as function( ) as short    ptr
dim p26 as function( ) as ushort   ptr
dim p27 as function( ) as long     ptr
dim p28 as function( ) as ulong    ptr
dim p29 as function( ) as longint  ptr
dim p30 as function( ) as ulongint ptr
dim p31 as function( ) as integer  ptr
dim p32 as function( ) as uinteger ptr
dim p33 as function( ) as single   ptr
dim p34 as function( ) as double   ptr
dim p35 as function( ) as string   ptr
dim p36 as function( ) as zstring  ptr
dim p37 as function( ) as wstring  ptr
dim p38 as function( ) as UDT1     ptr
dim p39 as function( ) as UDT2     ptr
dim p40 as function( ) as FWDREF1  ptr
dim p41 as function( ) as FWDREF2  ptr
dim p42 as function( ) as typeof( sub( )                 ) ptr
dim p43 as function( ) as typeof( function( ) as integer ) ptr

#define stringify( s ) #s

#macro checkLhsAndRhs( lhs, rhs )
	#if stringify( lhs ) <> stringify( rhs )
		#print lhs = rhs, 1 warning:
		lhs = rhs
	#endif
#endmacro

#macro checkLhs( lhs )
	checkLhsAndRhs( lhs, p01 )
	checkLhsAndRhs( lhs, p02 )
	checkLhsAndRhs( lhs, p03 )
	checkLhsAndRhs( lhs, p04 )
	checkLhsAndRhs( lhs, p05 )
	checkLhsAndRhs( lhs, p06 )
	checkLhsAndRhs( lhs, p07 )
	checkLhsAndRhs( lhs, p08 )
	checkLhsAndRhs( lhs, p09 )
	checkLhsAndRhs( lhs, p10 )
	checkLhsAndRhs( lhs, p11 )
	checkLhsAndRhs( lhs, p12 )
	checkLhsAndRhs( lhs, p13 )
	checkLhsAndRhs( lhs, p14 )
	checkLhsAndRhs( lhs, p15 )
	checkLhsAndRhs( lhs, p16 )
	checkLhsAndRhs( lhs, p17 )
	checkLhsAndRhs( lhs, p18 )
	checkLhsAndRhs( lhs, p19 )
	checkLhsAndRhs( lhs, p20 )
	checkLhsAndRhs( lhs, p21 )
	checkLhsAndRhs( lhs, p22 )
	checkLhsAndRhs( lhs, p23 )
	checkLhsAndRhs( lhs, p24 )
	checkLhsAndRhs( lhs, p25 )
	checkLhsAndRhs( lhs, p26 )
	checkLhsAndRhs( lhs, p27 )
	checkLhsAndRhs( lhs, p28 )
	checkLhsAndRhs( lhs, p29 )
	checkLhsAndRhs( lhs, p30 )
	checkLhsAndRhs( lhs, p31 )
	checkLhsAndRhs( lhs, p32 )
	checkLhsAndRhs( lhs, p33 )
	checkLhsAndRhs( lhs, p34 )
	checkLhsAndRhs( lhs, p35 )
	checkLhsAndRhs( lhs, p36 )
	checkLhsAndRhs( lhs, p37 )
	checkLhsAndRhs( lhs, p38 )
	checkLhsAndRhs( lhs, p39 )
	checkLhsAndRhs( lhs, p40 )
	checkLhsAndRhs( lhs, p41 )
	checkLhsAndRhs( lhs, p42 )
	checkLhsAndRhs( lhs, p43 )
#endmacro

checkLhs( p01 )
checkLhs( p02 )
checkLhs( p03 )
checkLhs( p04 )
checkLhs( p05 )
checkLhs( p06 )
checkLhs( p07 )
checkLhs( p08 )
checkLhs( p09 )
checkLhs( p10 )
checkLhs( p11 )
checkLhs( p12 )
checkLhs( p13 )
checkLhs( p14 )
checkLhs( p15 )
checkLhs( p16 )
checkLhs( p17 )
checkLhs( p18 )
checkLhs( p19 )
checkLhs( p20 )
checkLhs( p21 )
checkLhs( p22 )
checkLhs( p23 )
checkLhs( p24 )
checkLhs( p25 )
checkLhs( p26 )
checkLhs( p27 )
checkLhs( p28 )
checkLhs( p29 )
checkLhs( p30 )
checkLhs( p31 )
checkLhs( p32 )
checkLhs( p33 )
checkLhs( p34 )
checkLhs( p35 )
checkLhs( p36 )
checkLhs( p37 )
checkLhs( p38 )
checkLhs( p39 )
checkLhs( p40 )
checkLhs( p41 )
checkLhs( p42 )
checkLhs( p43 )
