'' SUFFIX warnings

'$lang: "qb"

#macro WARN( W )
	#if (W=0)
		#print none expected
	#elseif (W=1)
		#print warning expected
	#elseif (W>1) and (W<10)
		#print W warnings expected
	#else
		#print argument must be 0 to 9
		#error
	#endif
#endmacro

#print ---- parser-assignment.bas ----

WARN( 0 )
dim a%
WARN( 1 )
let% a% = 1

WARN( 0 )
dim b%(1 to 2)
WARN( 1 )
let% b%(1) = 1
