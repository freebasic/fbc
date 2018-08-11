type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

type FWDREF1 as FWDREF1_
type FWDREF2 as FWDREF2_

dim b     as function( ) as byte
dim ub    as function( ) as ubyte
dim sh    as function( ) as short
dim ush   as function( ) as ushort
dim l     as function( ) as long
dim ul    as function( ) as ulong
dim ll    as function( ) as longint
dim ull   as function( ) as ulongint
dim i     as function( ) as integer
dim ui    as function( ) as uinteger
dim f     as function( ) as single
dim d     as function( ) as double
dim s     as function( ) as string
dim udt1  as function( ) as UDT1
dim udt2  as function( ) as UDT2
dim psub  as function( ) as sub( )
dim pfi   as function( ) as function( ) as integer
dim pany  as function( ) as any      ptr
dim pb    as function( ) as byte     ptr
dim pub   as function( ) as ubyte    ptr
dim psh   as function( ) as short    ptr
dim push  as function( ) as ushort   ptr
dim pl    as function( ) as long     ptr
dim pul   as function( ) as ulong    ptr
dim pll   as function( ) as longint  ptr
dim pull  as function( ) as ulongint ptr
dim pi    as function( ) as integer  ptr
dim pui   as function( ) as uinteger ptr
dim pf    as function( ) as single   ptr
dim pd    as function( ) as double   ptr
dim ps    as function( ) as string   ptr
dim pz    as function( ) as zstring  ptr
dim pw    as function( ) as wstring  ptr
dim pudt1 as function( ) as UDT1     ptr
dim pudt2 as function( ) as UDT2     ptr
dim pfwd1 as function( ) as FWDREF1  ptr
dim pdwf2 as function( ) as FWDREF2  ptr
dim ppsub as function( ) as typeof( sub( )                 ) ptr
dim ppfi  as function( ) as typeof( function( ) as integer ) ptr

#macro test( lhs, rhs, amountofwarnings )
	#ifndef __tested__##lhs##__##rhs
	#define __tested__##lhs##__##rhs
		#print lhs = rhs, amountofwarnings warning:
		lhs = rhs
	#endif
#endmacro

#macro testNoWarning( lhs, rhs )
	test( lhs, rhs, no )
	test( rhs, lhs, no )
#endmacro

''
'' Filter out cases that shouldn't trigger a warning:
''
'' assignments between same size but signed/unsigned,
'' assignments between zstring and [u]byte,
'' assignments between wstring and the integer type with matching size (depends on the OS),
'' assignments between integer and long/longint (depends on 32bit or 64bit)
''

testNoWarning( b   , ub   )
testNoWarning( sh  , ush  )
testNoWarning( l   , ul   )
testNoWarning( ll  , ull  )
testNoWarning( i   , ui   )
testNoWarning( pb  , pub  )
testNoWarning( pb  , pz   )
testNoWarning( pub , pz   )
testNoWarning( psh , push )
testNoWarning( pl  , pul  )
testNoWarning( pll , pull )
testNoWarning( pi  , pui  )

#ifdef __FB_64BIT__
	'' integer = longint
	testNoWarning( ll  , i   )
	testNoWarning( ll  , ui  )
	testNoWarning( ull , i   )
	testNoWarning( ull , ui  )
	testNoWarning( pll , pi  )
	testNoWarning( pll , pui )
	testNoWarning( pull, pi  )
	testNoWarning( pull, pui )
#else
	'' integer = long
	testNoWarning( l  , i   )
	testNoWarning( l  , ui  )
	testNoWarning( ul , i   )
	testNoWarning( ul , ui  )
	testNoWarning( pl , pi  )
	testNoWarning( pl , pui )
	testNoWarning( pul, pi  )
	testNoWarning( pul, pui )
#endif

#if sizeof(wstring) = 4
	'' wstring = 4 bytes = long
	testNoWarning( pl , pw )
	testNoWarning( pul, pw )
	#ifndef __FB_64BIT__
		'' wstring = 4 bytes = integer
		testNoWarning( pi , pw )
		testNoWarning( pui, pw )
	#endif
#elseif sizeof(wstring) = 1
	'' wstring = byte = zstring
	testNoWarning( pb , pw )
	testNoWarning( pub, pw )
	testNoWarning( pz , pw )
#else
	'' wstring = 2 bytes = short
	testNoWarning( psh , pw )
	testNoWarning( push, pw )
#endif

''
'' Auto-generate tests for remaining combinations, except self-assignments
''

#macro checkLhsAndRhs( lhs, rhs )
	#if #lhs <> #rhs
		test( lhs, rhs, 2 )
	#endif
#endmacro

#macro checkLhs( lhs )
	checkLhsAndRhs( lhs, b     )
	checkLhsAndRhs( lhs, ub    )
	checkLhsAndRhs( lhs, sh    )
	checkLhsAndRhs( lhs, ush   )
	checkLhsAndRhs( lhs, l     )
	checkLhsAndRhs( lhs, ul    )
	checkLhsAndRhs( lhs, ll    )
	checkLhsAndRhs( lhs, ull   )
	checkLhsAndRhs( lhs, i     )
	checkLhsAndRhs( lhs, ui    )
	checkLhsAndRhs( lhs, f     )
	checkLhsAndRhs( lhs, d     )
	checkLhsAndRhs( lhs, s     )
	checkLhsAndRhs( lhs, udt1  )
	checkLhsAndRhs( lhs, udt2  )
	checkLhsAndRhs( lhs, psub  )
	checkLhsAndRhs( lhs, pfi   )
	checkLhsAndRhs( lhs, pany  )
	checkLhsAndRhs( lhs, pb    )
	checkLhsAndRhs( lhs, pub   )
	checkLhsAndRhs( lhs, psh   )
	checkLhsAndRhs( lhs, push  )
	checkLhsAndRhs( lhs, pl    )
	checkLhsAndRhs( lhs, pul   )
	checkLhsAndRhs( lhs, pll   )
	checkLhsAndRhs( lhs, pull  )
	checkLhsAndRhs( lhs, pi    )
	checkLhsAndRhs( lhs, pui   )
	checkLhsAndRhs( lhs, pf    )
	checkLhsAndRhs( lhs, pd    )
	checkLhsAndRhs( lhs, ps    )
	checkLhsAndRhs( lhs, pz    )
	checkLhsAndRhs( lhs, pw    )
	checkLhsAndRhs( lhs, pudt1 )
	checkLhsAndRhs( lhs, pudt2 )
	checkLhsAndRhs( lhs, pfwd1 )
	checkLhsAndRhs( lhs, pdwf2 )
	checkLhsAndRhs( lhs, ppsub )
	checkLhsAndRhs( lhs, ppfi  )
#endmacro

checkLhs( b     )
checkLhs( ub    )
checkLhs( sh    )
checkLhs( ush   )
checkLhs( l     )
checkLhs( ul    )
checkLhs( ll    )
checkLhs( ull   )
checkLhs( i     )
checkLhs( ui    )
checkLhs( f     )
checkLhs( d     )
checkLhs( s     )
checkLhs( udt1  )
checkLhs( udt2  )
checkLhs( psub  )
checkLhs( pfi   )
checkLhs( pany  )
checkLhs( pb    )
checkLhs( pub   )
checkLhs( psh   )
checkLhs( push  )
checkLhs( pl    )
checkLhs( pul   )
checkLhs( pll   )
checkLhs( pull  )
checkLhs( pi    )
checkLhs( pui   )
checkLhs( pf    )
checkLhs( pd    )
checkLhs( ps    )
checkLhs( pz    )
checkLhs( pw    )
checkLhs( pudt1 )
checkLhs( pudt2 )
checkLhs( pfwd1 )
checkLhs( pdwf2 )
checkLhs( ppsub )
checkLhs( ppfi  )
