type Pod1
	i as integer
end type

type Pod2
	i as integer
end type

dim pb    as byte ptr
dim pub   as ubyte ptr
dim psh   as short ptr
dim push  as ushort ptr
dim pl    as long ptr
dim pul   as ulong ptr
dim pll   as longint ptr
dim pull  as ulongint ptr
dim pi    as integer ptr
dim pui   as integer ptr
dim pf    as single ptr
dim pd    as double ptr
dim ps    as string ptr
dim pz    as zstring ptr
dim pw    as wstring ptr
dim ppod1 as Pod1 ptr
dim ppod2 as Pod2 ptr
dim psub  as sub()

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

testNoWarning( pb  , pub  )
testNoWarning( pb  , pz   )
testNoWarning( pub , pz   )
testNoWarning( psh , push )
testNoWarning( pl  , pul  )
testNoWarning( pll , pull )
testNoWarning( pi  , pui  )

#ifdef __FB_64BIT__
	'' integer = longint
	testNoWarning( pll , pi  )
	testNoWarning( pll , pui )
	testNoWarning( pull, pi  )
	testNoWarning( pull, pui )
#else
	'' integer = long
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
		test( lhs, rhs, 1 )
	#endif
#endmacro

#macro checkLhs( lhs )
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
	checkLhsAndRhs( lhs, ppod1 )
	checkLhsAndRhs( lhs, ppod2 )
	checkLhsAndRhs( lhs, psub  )
#endmacro

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
checkLhs( ppod1 )
checkLhs( ppod2 )
checkLhs( psub  )
