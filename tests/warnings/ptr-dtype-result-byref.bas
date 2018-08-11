type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

type FWDREF1 as FWDREF1_
type FWDREF2 as FWDREF2_

dim b     as function( ) byref as byte
dim ub    as function( ) byref as ubyte
dim sh    as function( ) byref as short
dim ush   as function( ) byref as ushort
dim l     as function( ) byref as long
dim ul    as function( ) byref as ulong
dim ll    as function( ) byref as longint
dim ull   as function( ) byref as ulongint
dim i     as function( ) byref as integer
dim ui    as function( ) byref as uinteger
dim f     as function( ) byref as single
dim d     as function( ) byref as double
dim s     as function( ) byref as string
dim z     as function( ) byref as zstring
dim w     as function( ) byref as wstring
dim udt1  as function( ) byref as UDT1
dim udt2  as function( ) byref as UDT2
dim fwd1  as function( ) byref as FWDREF1
dim fwd2  as function( ) byref as FWDREF2
dim psub  as function( ) byref as sub( )
dim pfi   as function( ) byref as function( ) as integer
dim pany  as function( ) byref as any      ptr
dim pb    as function( ) byref as byte     ptr
dim pub   as function( ) byref as ubyte    ptr
dim psh   as function( ) byref as short    ptr
dim push  as function( ) byref as ushort   ptr
dim pl    as function( ) byref as long     ptr
dim pul   as function( ) byref as ulong    ptr
dim pll   as function( ) byref as longint  ptr
dim pull  as function( ) byref as ulongint ptr
dim pi    as function( ) byref as integer  ptr
dim pui   as function( ) byref as uinteger ptr
dim pf    as function( ) byref as single   ptr
dim pd    as function( ) byref as double   ptr
dim ps    as function( ) byref as string   ptr
dim pz    as function( ) byref as zstring  ptr
dim pw    as function( ) byref as wstring  ptr
dim pudt1 as function( ) byref as UDT1     ptr
dim pudt2 as function( ) byref as UDT2     ptr
dim pfwd1 as function( ) byref as FWDREF1  ptr
dim pdwf2 as function( ) byref as FWDREF2  ptr
dim ppsub as function( ) byref as typeof( sub( )                 ) ptr
dim ppfi  as function( ) byref as typeof( function( ) as integer ) ptr

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

testNoWarning( b  , ub   )
testNoWarning( b  , z    )
testNoWarning( ub , z    )
testNoWarning( sh , ush  )
testNoWarning( l  , ul   )
testNoWarning( ll , ull  )
testNoWarning( i  , ui   )
testNoWarning( pb , pub  )
testNoWarning( pb , pz   )
testNoWarning( pub, pz   )
testNoWarning( psh, push )
testNoWarning( pl , pul  )
testNoWarning( pll, pull )
testNoWarning( pi , pui  )

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
	testNoWarning( l  , w  )
	testNoWarning( ul , w  )
	testNoWarning( pl , pw )
	testNoWarning( pul, pw )
	#ifndef __FB_64BIT__
		'' wstring = 4 bytes = integer
		testNoWarning( i  , w  )
		testNoWarning( ui , w  )
		testNoWarning( pi , pw )
		testNoWarning( pui, pw )
	#endif
#elseif sizeof(wstring) = 1
	'' wstring = byte = zstring
	testNoWarning( b  , w  )
	testNoWarning( ub , w  )
	testNoWarning( z  , w  )
	testNoWarning( pb , pw )
	testNoWarning( pub, pw )
	testNoWarning( pz , pw )
#else
	'' wstring = 2 bytes = short
	testNoWarning( sh  , w  )
	testNoWarning( ush , w  )
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
	checkLhsAndRhs( lhs, z     )
	checkLhsAndRhs( lhs, w     )
	checkLhsAndRhs( lhs, udt1  )
	checkLhsAndRhs( lhs, udt2  )
	checkLhsAndRhs( lhs, fwd1  )
	checkLhsAndRhs( lhs, fwd2  )
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
checkLhs( z     )
checkLhs( w     )
checkLhs( udt1  )
checkLhs( udt2  )
checkLhs( fwd1  )
checkLhs( fwd2  )
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
